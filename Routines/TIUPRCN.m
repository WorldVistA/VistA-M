TIUPRCN ; SLC/JER - Driver to Print Form 513 Consult Reports ;10/5/04
 ;;1.0;TEXT INTEGRATION UTILITY;**4,182**;Jun 20, 1997
 ; Call to TIUEN^GMRCP513 supported by DBIA 3957
ENTRY ; Entry point to print SF 513
 N TIUERR,TIUI,TIUJ,D0,DN,Y,DTOUT,DUOUT,DIRUT,DIROUT,TIU0,TIU14,TIUINI
 K ^TMP("TIULQ",$J)
 S TIUINI=1 ; Indicate initials only for transcriber
 I $D(ZTQUEUED) S ZTREQ="@" ; Tell TaskMan to delete Task log entry
 U IO
 I '$D(^TMP("TIUPR",$J)) W !,"No Document Record Specified.",$C(7) Q
 ; -- P182 If no Print Group, TIUJ may begin 0$... 
 S TIUJ=0 F  S TIUJ=$O(^TMP("TIUPR",$J,TIUJ)) G:TIUJ="" ENTRYX  D
 . S TIUI=0 F  S TIUI=$O(^TMP("TIUPR",$J,TIUJ,TIUI)) Q:TIUI'>0!$D(DIROUT)  D
 . . N TIUDA,TIUCDA ;P182
 . . S TIUDA=0
 . . F  S TIUDA=+$O(^TMP("TIUPR",$J,TIUJ,TIUI,TIUDA)) Q:+TIUDA'>0!$D(DIROUT)  D
 . . . S TIU0=$G(^TIU(8925,+TIUDA,0)),TIU14=$G(^(14))
 . . . I +$$ISADDNDM^TIULC1(TIUDA) S TIUDA=$P(TIU0,U,6)
 . . . S TIUCDA=+$P(TIU14,U,5)
 . . . I +TIUCDA'>0 D  Q
 . . . . ; W !!,"This Consult Result is not associated with a request.",!
 . . . . ; -- If note has no request, print that note only, using
 . . . . ;    PN Print Method (P182):
 . . . . M ^TMP("TIUTMPPR",$J)=^TMP("TIUPR",$J)
 . . . . K ^TMP("TIUPR",$J)
 . . . . S ^TMP("TIUPR",$J,TIUJ,TIUI,TIUDA)=^TMP("TIUTMPPR",$J,TIUJ,TIUI,TIUDA)
 . . . . D ENTRY^TIUPRPN
 . . . . M ^TMP("TIUPR",$J)=^TMP("TIUTMPPR",$J)
 . . . . K ^TMP("TIUTMPPR",$J)
 . . . . ; I $E(IOST)="C-",$$READ^TIUU("EA","Press RETURN to continue...")
 . . . . K ^TMP("TIUPR",$J,TIUJ,TIUI,TIUDA)
 . . . N VALMAR,VALMCNT,VALMPGE
 . . . ; -- Don't repeat if request already printed (P182):
 . . . I '$D(^TMP("TIUPRCDA",$J,TIUCDA)) D TIUEN^GMRCP513(TIUCDA) S ^TMP("TIUPRCDA",$J,TIUCDA)="" I $E(IOST)="C-",$$READ^TIUU("EA","Press RETURN to continue...")
 . . . K ^TMP("TIUPR",$J,TIUJ,TIUI,TIUDA)
ENTRYX ;
 K ^TMP("TIUPRCDA",$J)
 Q
