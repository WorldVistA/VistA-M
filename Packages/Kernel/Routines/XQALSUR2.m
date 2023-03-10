XQALSUR2 ;FO-OAK.SEA/JLI-Continuation of alert surrogate processing ; May 12, 2021@14:28
 ;;8.0;KERNEL;**366,513,602,690,730,754**;Jul 10, 1995;Build 1
 ;Per VHA VA Directive 6402, this routine should not be modified
 Q
 ; added to handle adjustment for manual or Fileman editing of surrogate on top zero node
CHEKSUBS(XQAUSER) ;
 N XQA0,XQASTR1,XQANOW,XQB0,XQB1
 S XQANOW=$$NOW^XLFDT()
 S XQA0=$G(^XTV(8992,XQAUSER,0)) I $P(XQA0,U,2)>0 D
 . N XQAFDA,XQAIEN,XQADA
 . S XQASTR1=$P(XQA0,U,3) S:XQASTR1'>0 XQASTR1=XQANOW,XQAFDA(8992,XQAUSER_",",.03)=XQASTR1 D
 . . S XQADA=0 F  S XQADA=$O(^XTV(8992,XQAUSER,2,"B",XQASTR1,XQADA)) Q:XQADA'>0  D  Q:$P($G(^XTV(8992,XQAUSER,2,XQADA,0)),U,2)=$P(XQA0,U,2)  ; p754
 . . . K:'$D(^XTV(8992,XQAUSER,2,XQADA,0)) ^XTV(8992,XQAUSER,2,"B",XQASTR1,XQADA) ;p754 somebody removed surr by gbl kill, cleanup
 . . S XQAIEN=$S(XQADA>0:XQADA,1:"+1")_","_XQAUSER_"," S XQAFDA(8992.02,XQAIEN,.01)=XQASTR1
 . . S XQAFDA(8992.02,XQAIEN,.02)=$P(XQA0,U,2) S:$P(XQA0,U,4)>0 XQAFDA(8992.02,XQAIEN,.03)=$P(XQA0,U,4)
 . . D:XQADA'>0 UPDATE^DIE("","XQAFDA")
 . . D:XQADA>0 FILE^DIE("","XQAFDA")
 . . Q
 . Q
 Q
 ;
CHKCRIT(ZERONODE) ;EXTRINSIC - check for critical indication for alert
 ; ZERONODE - input - Value for zero node for alert data
 ; RETURN VALUE - 1 if the alert is indicated as critical
 ;                0 otherwise
 N RESULT,IEN
 S RESULT=0
 F IEN=0:0 S IEN=$O(^XTV(8992.3,IEN)) Q:IEN'>0  D  Q:RESULT
 . N IENS,RES,MSG,CRITTEXT,PKGID,ALERTTXT
 . S IENS=IEN_","
 . D GETS^DIQ(8992.3,IENS,".01:.02",,"RES","MSG")
 . S CRITTEXT=$$UP^XLFSTR(RES(8992.3,IENS,.01)),PKGID=$$UP^XLFSTR(RES(8992.3,IENS,.02))
 . I PKGID'="",$$UP^XLFSTR($P(ZERONODE,U,2))'[PKGID Q
 . S ALERTTXT=$$UP^XLFSTR($P(ZERONODE,U,3))
 . I ALERTTXT[CRITTEXT,ALERTTXT'["NOT "_CRITTEXT,ALERTTXT'["NON "_CRITTEXT S RESULT=1  ;;XU*8*690 - Added check for "NON" critical text
 Q RESULT
CLEANUP(XQAUSER) ;SR. - clean up expired surrogate info
 N XQAI,XQANOW,XQASUR
 S XQANOW=$$NOW^XLFDT()
 I $P($G(^XTV(8992,XQAUSER,2,0)),U,2)>0 D
 . S XQAI=0 F  S XQAI=$O(^XTV(8992,XQAUSER,2,XQAI)) Q:XQAI'>0  D
 . . S XQASUR=$G(^XTV(8992,XQAUSER,2,XQAI,0))
 . . I ($P(XQASUR,U)<XQANOW)&($P(XQASUR,U,4)'=1)&($P(XQASUR,U,3)<XQANOW)&($P(XQASUR,U,3)>0) D
 . . . N XQAIEN S XQAIEN=XQAI_","_XQAUSER_","
 . . . N XQAFDA S XQAFDA(8992.02,XQAIEN,.01)="@" D FILE^DIE("","XQAFDA")
 Q
 ; p730
DISPSUR(XQAUSER,XQASLIST)   ; Prints and returns current list of surrogate periods for a user 
 ; usage: N LIST D DISPSUR^XQAUSER(DUZ,.LIST)
 N XQAI
 D SUROLIST^XQALSUR1(XQAUSER,.XQASLIST)
 I $G(XQASLIST)<1 W !!,"  No current surrogates",! Q
 W !!,"Current Surrogate(s):",?33,"START DATE",?58,"END DATE" ; p754 shortened
 F XQAI=0:0 S XQAI=$O(XQASLIST(XQAI)) Q:XQAI'>0  D 
 . W !,XQAI,"  ",$P(XQASLIST(XQAI),U,2),?33,$$FMTE^XLFDT($P(XQASLIST(XQAI),U,3)),?58,$$FMTE^XLFDT($P(XQASLIST(XQAI),U,4))
 W !
 Q
 ;
