PXRMLCD ; SLC/PKR - Reminder Patient List Patients ;11/02/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
 ;Display list creation documentation.
 ;===========================================================
DCDOC ;Display creation documentation.
 N IND,LISTIEN,VALMY
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 ;PXRMDONE is newed in PXRMLPU
 S IND="",PXRMDONE=0
 F  S IND=$O(VALMY(IND)) Q:(IND="")!(PXRMDONE)  D
 . S LISTIEN=^TMP("PXRMLPU",$J,"SEL",IND)
 . D EN^PXRMLCD(LISTIEN)
 S VALMBCK="R"
 Q
 ;
 ;===========================================================
EN(LISTIEN) ;
 N VALMBCK,VALMBG,VALMCNT,VALMSG,X,XMZ,XQORM,XQORNOD
 K ^TMP("PXRMLCD",$J)
 I $D(^PXRMXP(810.5,LISTIEN,200)) D
 . M ^TMP("PXRMLCD",$J)=^PXRMXP(810.5,LISTIEN,200)
 . S VALMCNT=$P(^PXRMXP(810.5,LISTIEN,200,0),U,4)
 I '$D(^PXRMXP(810.5,LISTIEN,200)) D
 . S ^TMP("PXRMLCD",$J,1,0)="No documentation is available."
 . S VALMCNT=1
 D EN^VALM("PXRM PATIENT LIST CREATION DOC")
 Q
 ;
 ;===========================================================
EXIT ;Exit code
 K ^TMP("PXRMLCD",$J)
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="R"
 Q
 ;
 ;===========================================================
HDR ; Header code
 S VALMHDR(1)="Documentation for creation of patient list:"
 S VALMHDR(2)=" "_$P(^PXRMXP(810.5,LISTIEN,0),U,1)
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
 ;===========================================================
HELP ;Help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
