DGMSTL ; ALB/SCK - MST Status entry ; 15-DEC-1998
 ;;5.3;Registration;**195**;Aug 13, 1993
 ;
 Q
EN ; -- main entry point for DGMST STATUS ENTRY
 K XQORS,VALMEVL
 N DGHDR,VALMCNT,MSTCNT,VALMI,VALMY,XQORNOD,VALMBCK,VALMHDR
 D EN^VALM("DGMST STATUS ENTRY")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Military Sexual Trauma - Data Entry Screen"
 S VALMHDR(2)=$S($G(DGHDR)]"":DGHDR,1:"")
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("DGMST",$J)
 D CLEAN^VALM10
 D NUL^DGMSTL2 ; Display null list message to force page number
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D SENDMST^DGMSTL1
 K ^TMP("DGMST",$J)
 K ^TMP("DGMST RENUM",$J)
 Q
 ;
EXPND ; -- expand code
 Q:$$CHKNUL^DGMSTL2
 N MSTDFN
 D FULL^VALM1
 D EN^VALM2(XQORNOD(0),"S") S VALMI=0
 S VALMI=$O(VALMY(VALMI))
 Q:'VALMI
 S MSTDFN=0,MSTDFN=$O(^TMP("DGMST",$J,"DFN",VALMI,MSTDFN))
 ;;
 D EN^VALM("DGMST STATUS DISPLAY")
 S VALMBCK="R"
 Q
 ;
SET(X) ;
 S VALMCNT=$G(VALMCNT)+1,MSTCNT=VALMCNT
 S ^TMP("DGMST",$J,VALMCNT,0)=X
 S ^TMP("DGMST",$J,"IDX",VALMCNT,MSTCNT)=""
 S ^TMP("DGMST",$J,"INIT",VALMCNT,MSTCNT)=""
 Q
