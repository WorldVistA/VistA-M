PSJOCERR ;BIR/MV - ERROR HANDLING FOR ORDER CHECKS ;6 Jun 07 / 3:37 PM
 ;;5.0; INPATIENT MEDICATIONS ;**181**;16 DEC 97;Build 190
 ;
SYS() ;
 ;If the system is down, pause and continue with Allergy and CPRS OC
 I '$$PING^PSJOC() D  Q 1
 . K ^TMP($J,"PSJPRE")
 . D PAUSE^PSJMISC(1,1)
 . D GMRAOC^PSJOC
 Q 0
DRUG ;
 Q
ORDER ;
 Q
SETERR(PSJBASE,PSJPON,PSJCODE,PSJDNM) ;
 ;PSJBASE - Base(Literal value for TMP global)
 ;PSJPON - 4th pieces pharmacy order #
 ;PSJCODE - Exception code for a specific error message to be returned
 ;PSJDNM - Display drug name (DD or AD/SOL)
 I $G(PSJBASE)="" Q
 I $G(PSJPON)="" Q
 I '$G(PSJCODE) Q
 S ^TMP($J,PSJBASE,"IN","EXCEPTIONS","DOSE",PSJPON)=PSJCODE_U_$G(PSJDNM)
 Q
DSPERR(PSJTYPE) ;Display drug level errors
 ;PSJTYPE = "DRUGDRUG" or "THERAPY"
 ;PSJOCER(MSG_TEXT) - Array to keep track of errors that already displayed
 ;PSJDSPFG - If 1 then display a Pause if an error was displayed.
 Q:$G(PSJTYPE)=""
 NEW ON,PSJPON,PSJCNT,PSJMSG
 S PSJDSPFG=0
 S PSJPON="" F  S PSJPON=$O(^TMP($J,"PSJPRE","OUT",PSJTYPE,"ERROR",PSJPON)) Q:PSJPON=""  D
 . F PSJCNT=0:0 S PSJCNT=$O(^TMP($J,"PSJPRE","OUT",PSJTYPE,"ERROR",PSJPON,PSJCNT)) Q:'PSJCNT  D
 .. S PSJMSG=$G(^TMP($J,"PSJPRE","OUT",PSJTYPE,"ERROR",PSJPON,PSJCNT,"MSG"))
 .. S PSJTXT=$G(^TMP($J,"PSJPRE","OUT",PSJTYPE,"ERROR",PSJPON,PSJCNT,"TEXT"))
 .. I '$$ERRCHK(PSJMSG_PSJTXT) Q
 .. S PSJDSPFG=1
 .. K PSJPAUSE
 .. I ($Y+6)>IOSL D PAUSE^PSJMISC(1,1) W @IOF
 .. I PSJMSG]"" W !! D WRITE^PSJMISC(PSJMSG)
 .. I PSJTXT]"" D WRITE^PSJMISC("  Reason: "_PSJTXT)
 I PSJDSPFG D PAUSE^PSJMISC(1,1) W @IOF
 Q
ERRCHK(PSJX) ;
 ;PSJX - Drug name_Error reason
 ;Return 1 if this error drug has not displayed to the user.
 I $G(PSJX)="" Q 0
 I '$D(PSJOCER(PSJX)) S PSJOCER(PSJX)="" Q 1
 Q 0
