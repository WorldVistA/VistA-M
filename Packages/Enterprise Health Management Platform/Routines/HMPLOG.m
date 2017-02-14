HMPLOG ; ASMR/hrubovcak - eHMP logging support ;Jun 21, 2016 16:41:12
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;June 13, 2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; routine created 13 June 2016 for US15658
 Q
 ;
NWNTRY(HMPDTIM,HMPTYP,HMPLOG) ; function, create new entry in HMP EVENT file (#80003)
 ; returns new entry IEN
 ; HMPDTIM - optional FileMan format date/time.  Must be precise and have time with seconds.
 ;   defaults to NOW if not passed or invalid
 ; HMPTYP - optional event type, if missing, defaults to O (other)
 ; HMPLOG - event log passed by reference, traversed by $QUERY for word-processing text
 ;  array is optional, but should be passed with calling routine name and module, at minimum.
 ;  this array will remain unchanged
 ;
 Q:'$L($G(^HMPLOG(800003,0))) -1  ; file not installed, return out-of-bounds value
 ;
 D DT^DICRW  ; ensure minimum symbol table defined
 N G,H,HMPERR,HMPLGFDA,HMPLGIEN,HMPWPTXT,IENS,J,X,Y
 ; handle entry creation for speed
 L +^HMPLOG(800003,0):DILOCKTM  ; exclusive access for new IEN
 S X=$G(^HMPLOG(800003,0)),J=$P(X,U,4)+1,$P(X,U,4)=J,HMPLGIEN=$P(X,U,3)+1\1  ; make it an integer
 F  Q:'$D(^HMPLOG(800003,HMPLGIEN))  S HMPLGIEN=HMPLGIEN+1   ; entry IEN to be returned
 S ^HMPLOG(800003,HMPLGIEN,0)=HMPLGIEN,^HMPLOG(800003,"B",HMPLGIEN,HMPLGIEN)=""  ; new entry and cross-ref.
 S $P(X,U,3)=HMPLGIEN,^HMPLOG(800003,0)=X L -^HMPLOG(800003,0)  ; update zero node and unlock
 ;
 S J=0 D  ; create word-processing text
 . I $G(HMPLOG)]"" S J=J+1,HMPWPTXT(J,0)=HMPLOG  ; if root has text, save it
 . S Y="HMPLOG" F  S Y=$Q(@Y) Q:Y=""  S X=@Y,J=J+1,HMPWPTXT(J,0)=$S($L(X):X,1:" ")  ; replace blanks with spaces
 . S X=$S($G(DUZ):" DUZ: "_DUZ,1:"")_"   $job: "_$J_"   $i: "_$I_$S($G(ZTSK):"   ZTSK: "_ZTSK,1:"")  ; job info
 . S J=J+1,HMPWPTXT(J,0)=X,J=J+1,HMPWPTXT(J,0)=" logged: "_$$HTE^XLFDT($H)
 ;
 S IENS=HMPLGIEN_","
 S Y=$G(HMPDTIM) S:'((Y?7N)!(Y?7N1"."1.6N)&$E(Y,6,7)) Y=$$NOW^XLFDT  ; must be precise date, otherwise NOW
 S:'$P(Y,".",2) Y=Y+.000001  ; if no seconds, make time 00:00:01
 S HMPLGFDA(800003,IENS,.02)=Y  ; EVENT DATE/TIME
 ;
 S Y=$E($G(HMPTYP)) S:'(Y?1U) Y="O"  ; default to other
 S HMPLGFDA(800003,IENS,.03)=Y  ; TYPE OF EVENT
 ;
 D FILE^DIE("S","HMPLGFDA","HMPERR")  ; "S" flag to save HMPLGFDA array
 ;
 I $D(HMPERR("DIERR")) D  ; save new entry error data, just in case (should not happen)
 . S H=$H,J=0,G="HMPERR(""DIERR"")"
 . S ^TMP($T(+0),$J,H,"NEW",0)=" FileMan error, adding HMP EVENT"
 . F  S G=$Q(@G) Q:'(G["DIERR")  S J=J+1,^TMP($T(+0),$J,H,"NEW",J)=@G
 ; add word-processing text
 K HMPERR D WP^DIE(800003,IENS,1,"","HMPWPTXT","HMPERR")
  I $D(HMPERR("DIERR")) D  ; save w-p error data, just in case (should not happen)
 . S H=$H,J=0,G="HMPERR(""DIERR"")"
 . S ^TMP($T(+0),$J,H,"W-P",0)=" FileMan error, adding w-p text"
 . F  S G=$Q(@G) Q:'(G["DIERR")  S J=J+1,^TMP($T(+0),$J,H,"W-P",J)=@G
 ;
 Q HMPLGIEN  ; return new log IEN
 ;
PRGLOG ; purge HMP EVENT file (#800003) entries older than 61 days
 ;
 Q:'$L($G(^HMPLOG(800003,0)))  ; file not installed
 D DT^DICRW  ; minimal symbol table
 ;
 N DA,DIK,HMP,HMPRGLOG,J,X,Y
 S J=1,HMPRGLOG(J,0)="HMP EVENT log purge started"
 S J=J+1,HMPRGLOG(J,0)=" calling routine: PRGLOG^"_$T(+0)
 S Y=$NA(^HMPLOG(800003,0))  ; record zero node
 S J=J+1,HMPRGLOG(J,0)=" "_Y_"="_$C(34)_$G(^HMPLOG(800003,0))_$C(34)
 S Y=$$NWNTRY($$NOW^XLFDT,"I",.HMPRGLOG)  ; log the purge start
 ;
 S HMP("T-61")=$$HTFM^XLFDT($H-61)  ; 61 days ago, FileMan format
 S HMP("DEL")=0  ; deleted count
 S HMP("TTL")=0  ; total checked
 S DIK="^HMPLOG(800003,"  ; file root
 S J=0 F  S J=$O(^HMPLOG(800003,J)) Q:'J  D
 . S HMP("TTL")=HMP("TTL")+1,Y=$G(^HMPLOG(800003,J,0)) Q:$P(Y,U,2)>HMP("T-61")
 . S DA=J,HMP("DEL")=HMP("DEL")+1
 . N J D ^DIK  ; protect J before ^DIK call
 ;
 K HMPRGLOG S J=1,HMPRGLOG(J,0)="HMP EVENT log purge finished"
 S J=J+1,HMPRGLOG(J,0)=" Entries checked: "_HMP("TTL")
 S J=J+1,HMPRGLOG(J,0)=" Entries deleted: "_HMP("DEL")
 S J=J+1,HMPRGLOG(J,0)=" calling routine: PRGLOG^"_$T(+0)
 S Y=$$NWNTRY($$NOW^XLFDT,"I",.HMPRGLOG)  ; log the purge end
 Q
 ;
