TIURB3 ; SLC/JER - Review Action, Change Advance Directive Title Submodules ;01/03/12  12:50
 ;;1.0;TEXT INTEGRATION UTILITIES;**261**;Jun 20, 1997;Build 7
 ;
AD2RAD(NOTEDA,SELNEWTL) ; Is this note being changed from ADVANCE DIRECTIVE to RESCINDED ADVANCE DIRECTIVE?
 N TITLIEN,TITLNM,SELTLNM
 S TITLIEN=+^TIU(8925,NOTEDA,0),TITLNM=$P(^TIU(8925.1,TITLIEN,0),U)
 I TITLNM'="ADVANCE DIRECTIVE" Q 0
 S SELTLNM=$P(^TIU(8925.1,SELNEWTL,0),U)
 I SELTLNM'="RESCINDED ADVANCE DIRECTIVE" Q 0
 Q 1
 ;
OK2MARK() ; Returns 1 if user oks changing Title to RESCINDED ADVANCE DIRECTIVE; Else 0
 N DIR,X,Y
 S DIR("A",1)="  The title of this note will be changed to RESCINDED ADVANCE DIRECTIVE and "
 S DIR("A")="linked images will be watermarked 'RESCINDED'.  OK"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR W !
 Q Y
 ;
WTRMARK(TIUDA,SELTITL,TLCHNGD) ; Watermark image of TIUDA 'Rescinded'
 N OK2MARK,TIUY
 S (OK2MARK,TLCHNGD)=0
 I $$AD2RAD(TIUDA,SELTITL) D  I $$READ^TIUU("EA","Press RETURN to continue...")
 . I '$$HASIMG^TIURB2(TIUDA) D   Q
 . . D TLDIE^TIURS1(TIUDA,SELTITL) S TLCHNGD=1
 . . W !,"  Title changed.  Note has no image to watermark."
 . . D CKADDA(TIUDA)
 . I '$$OK2MARK W !,"  Title not changed; image not watermarked." S TIUQUIT=1 Q
 . D TLDIE^TIURS1(TIUDA,SELTITL) S TLCHNGD=1 D RESCIND^MAGGSIU4(.TIUY,TIUDA)
 . I +TIUY(0)=0 D  Q
 . . W !,"  Title changed.  Image for note #",TIUDA," could not be queued for watermarking. Please see"
 . . W !,"Imaging Manager."
 . . D CKADDA(TIUDA)
 . W !,"  Title changed; Image queued for watermarking."
 . D CKADDA(TIUDA)
 Q
 ;
CKADDA(TIUDA) ; Watermark addendum images
 N ADDMIEN,ARRADDA,TIUI,ARRCAN,TIUJ,HASIMG,IMAGERR,IMAGQUED
 S (TIUI,TIUJ,HASIMG,IMAGERR,IMAGQUED)=0
 ; -- Set array of adda:
 S ADDMIEN=0 F  S ADDMIEN=$O(^TIU(8925,"DAD",TIUDA,ADDMIEN)) Q:'ADDMIEN  D
 . Q:+$$ISADDNDM^TIULC1(ADDMIEN)'>0
 . S ARRADDA(ADDMIEN)=0
 Q:'$D(ARRADDA)  ;note has no adda
 ; -- Is DUZ authorized to watermark an image of this addm? [Authorization to CT of an Adv Dir
 ;    implies authorization to watermark its image, including adda images.  Some sites may permit
 ;    changing title of UNCOS Adv Dirs as well as COMPLETED ones.]
 S TIUI=0 F  S TIUI=$O(ARRADDA(TIUI)) Q:+TIUI'>0  D
 . I $$CANDO^TIULP(TIUI,"CHANGE TITLE")'>0 Q
 . S ARRCAN(TIUI)=0
 Q:'$D(ARRCAN)
 W !,"Checking signed addenda for images to watermark. . ."
 ; -- If addm has image, watermark it:
 S TIUJ=0 F  S TIUJ=$O(ARRCAN(TIUJ)) Q:+TIUJ'>0  D
 . I '$$HASIMG^TIURB2(TIUJ) Q
 . S HASIMG=1
 . N TIUY D RESCIND^MAGGSIU4(.TIUY,TIUJ)
 . I +TIUY(0)=0 S IMAGERR=IMAGERR+1 Q
 . S IMAGQUED=IMAGQUED+1
 ; -- Feedback to user:
 I 'HASIMG W !,"No addendum images to watermark." Q
 I IMAGQUED D
 . N NUMADDA
 . S NUMADDA=$S(IMAGQUED=1:"ONE",IMAGQUED=2:"TWO",1:"Multiple")
 . W !,NUMADDA," addendum image(s) queued for watermarking."
 I IMAGERR D
 . N NUMADDA
 . S NUMADDA=$S(IMAGERR=1:"ONE",IMAGERR=2:"TWO",1:"Multiple")
 . W !,NUMADDA," addendum image(s) could not be queued for watermarking. Please"
 . W !,"see Imaging Manager."
 Q
