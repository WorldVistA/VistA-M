SCENIA0 ;ALB/SCK - DISPLAY INCOMPLETE ENCOUNTER ERRORS ; 09-MAY-1997
 ;;5.3;Scheduling;**66**;AUG 13, 1993
 ;
EN ; -- main entry point for SCENI INCOMPLETE ENC DISPLAY
 ;   Variables
 ;        SDOE  - Ptr to #409.68
 ;        SDCLN - Ptr to #44
 ;        SDFLG - Deleted encounter or not
 ;        SCINF - Encounter information array
 ;
 N VALMCNT
 S VALMBCK=""
 K ^TMP("SCENI DFN",$J),^TMP("SCENI XMT",$J)
 K VA,SDFLG
 ;
 Q:'+SDXPTR
 S SDFLG=$$OPENC^SCUTIE1(SDXPTR,"SCINF")
 ;
 S DFN=SCINF("DFN")
 S ^TMP("SCENI DFN",$J,0)=DFN
 S ^TMP("SCENI XMT",$J,0)=+SDXPTR
 D PID^VADPT6
 D EN^VALM("SCENI INCOMPLETE ENC DISPLAY")
 S VALMBCK="R"
 Q
 ;
HDR ; -- header code
 I '$G(VA("BID")) S DFN=SCINF("DFN") D PID^VADPT6
 S VALMHDR(1)="  Patient: "_$$LOWER^VALM1($E($P(^DPT(SCINF("DFN"),0),U),1,25))
 S VALMHDR(1)=$$SETSTR^VALM1("SSN: "_VA("BID"),VALMHDR(1),66,10)
 S VALMHDR(2)="   Clinic: "_$E($P($G(^SC(SCINF("CLINIC"),0)),U),1,25)
 S VALMHDR(2)=$$SETSTR^VALM1($S(SDFLG:"(DEL) ",1:"      ")_"Encounter Date: "_$$FDTTM^VALM1(SCINF("ENCOUNTER")),VALMHDR(2),49,30)
 Q
 ;
INIT ; -- init variables and list array
 ;     Variables
 ;       IW,IC,EC,EW,DC,DW,SC,SW - Col widths and positions
 ;       SDECNT - Counter
 ;
 K ^TMP("SCENI ERR",$J)
 D CLEAN^VALM10
 ;
 S BL="",$P(BL," ",30)=""
 S X=VALMDDF("INDEX"),IC=$P(X,U,2),IW=$P(X,U,3)
 S X=VALMDDF("SOURCE"),SC=$P(X,U,2),SW=$P(X,U,3)
 S X=VALMDDF("ERROR"),EC=$P(X,U,2),EW=$P(X,U,3)
 S X=VALMDDF("DESCRIPTION"),DC=$P(X,U,2),DW=$P(X,U,3)
 ;
 D BLD
 I '$D(^TMP("SCENI ERR",$J)) D  Q
 . S (SDECNT,VALMCNT)=0
 . D SET(" "),SET("No Errors found.")
 Q
 ;
BLD ;  Build display global for error entries in the error file
 ;
 S (SDECNT,VALMCNT)=0,SDEPTR=""
 F  S SDEPTR=$O(^SD(409.75,"B",SDXPTR,SDEPTR)) Q:'SDEPTR  D
 . Q:'$D(^SD(409.75,SDEPTR))
 . D BLD1(SDEPTR)
 Q
 ;
BLD1(SDEPTR) ;   Build display line
 ;    Input
 ;         SDEPTR - Ptr to #409.75
 ;
 ;    Variables
 ;        SDX     - Local variable
 ;        ERNODE  - Error table node 0
 ;        ERNODE1 - Error table node 1
 ;        SDERR   - Error code
 ;
 N SDSRC
 ;
 S SDECNT=SDECNT+1,SDX="",$P(SDX," ",VALMWD+1)=""
 ;W:(SDECNT#10)=0 "."
 ;
 S SDERR=$P(^SD(409.75,SDEPTR,0),U,2)
 Q:'SDERR
 S ERNODE=$G(^SD(409.76,SDERR,0))
 S ERNODE1=$G(^SD(409.76,SDERR,1))
 ;
 S SDX=$E(SDX,1,IC-1)_$E(SDECNT_BL,1,IW)_$E(SDX,IC+IW+1,VALMWD)
 S SDSRC=$P(ERNODE,U,2)
 S SDX=$E(SDX,1,SC-1)_$E($S(SDSRC="V":"VISTA",SDSRC="N":"NPCD ",1:"UNK  ")_BL,1,SW)_$E(SDX,SC+SW+1,VALMWD)
 S SDX=$E(SDX,1,EC-1)_$E($P(ERNODE,U)_BL,1,EW)_$E(SDX,EC+EW+1,VALMWD)
 S SDX=$E(SDX,1,DC-1)_$E(ERNODE1_BL,1,DW)_$E(SDX,DC+DW+1,VALMWD)
 D SET(SDX)
 Q
 ;
SET(X) ;   Sets formatted display string into TMP global
 S VALMCNT=VALMCNT+1,^TMP("SCENI ERR",$J,VALMCNT,0)=X
 Q:'SDECNT
 S ^TMP("SCENI ERR",$J,"IDX",VALMCNT,SDECNT)=SDEPTR_U_$P(ERNODE,U)
 S ^TMP("SCENI ERR",$J,"DA",SDECNT,SDEPTR)=""
 ;S ^TMP("SCENI ERR",$J,"XMT",SDECNT,SDXPTR)=""
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("SCENI ERR",$J),^TMP("SCENI DFN",$J),^TMP("SCENI XMT",$J),VA
 K BL,IW,IC,EC,EW,DC,DW,SC,SW,SDECNT,SCINF,SDFLG,SDEPTR,SDX,ERNODE,ERNODE1,SDERR,SCCOR,SCTEXT
 K SDN1,SDN2,SCEPTR,SDOK,SINDX,DIE,DR,STATUS,RESULT
 I $G(FLG1),$D(VALMBCK),VALMBCK="R" D REFRESH^VALM S VALMBCK=$P(VALMBCK,"R")_$P(VALMBCK,"R",2)
 Q
