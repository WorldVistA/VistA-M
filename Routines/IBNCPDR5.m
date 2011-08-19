IBNCPDR5 ;ALB/BDB - ROI MANAGEMENT, EXPAND ROI ;30-NOV-07
 ;;2.0;INTEGRATED BILLING;**384**; 21-MAR-94;Build 74
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
VP ; -- View Patient ROI Info
 N I,J,IBNCRXX,VALMY,IBNCRPR
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBNCRXX=0 F  S IBNCRXX=$O(VALMY(IBNCRXX)) Q:'IBNCRXX  D
 .S IBNCRPR=$G(^TMP("IBNCRDX",$J,IBNCRXX))
 .Q:IBNCRPR=""
 .D EN^VALM("IBNCR EXPANDED ROI")
 .Q
 D FULL^VALM1
 D BLD^IBNCPDR
 Q
 ;
INIT ; -- set up inital variables
 S U="^",VALMCNT=14,VALMBG=1
 K ^TMP("IBNCRVR",$J)
 D BLD^IBNCPDR5
INITQ Q
 ;
BLD ; -- expand the ROI
 N IBNCR0,IBNCR1,IBNCR2,IBNCRJ,IBNCROFF
 D KILL^VALM10()
 F I=1:1:14 D BLANK(.I)
 S IBNCRJ=0,IBNCROFF=1
 D SET(IBNCRJ+1,2,$E($P($G(^DPT(DFN,0)),"^"),1,20)_" has the following ROI on file:")
 S IBNCR0=$G(^IBT(356.25,IBNCRPR,0)),IBNCR1=$G(^(1)),IBNCR2=$G(^(2))
 S ^TMP("IBNCR",$J,"ROI0")=IBNCR0,^("ROI1")=IBNCR1,^("ROI2")=IBNCR2
 D SET(IBNCRJ+3,2,"Drug: "_$$DRUG^IBRXUTL1($P(IBNCR0,U,3)))
 I $D(^DIC(36,$P(IBNCR0,U,4),0)) D SET(IBNCRJ+4,2,"Insurance Company: "_$P(^(0),"^"))
 D SET(IBNCRJ+5,2,"Effective Date: "_$$DAT1^IBOUTL($P(IBNCR0,"^",5)))
 D SET(IBNCRJ+6,2,"Expiration Date: "_$$DAT1^IBOUTL($P(IBNCR0,"^",6)))
 D SET(IBNCRJ+7,2,"Status: Active  ")
 I $P(IBNCR0,U,7)="0" D SET(IBNCRJ+7,2,"Status: Inactive")
 D SET(IBNCRJ+8,2,"Comment: "_$P(IBNCR2,"^",1))
 D SET(IBNCRJ+10,IBNCROFF,"            Date ROI Added: "_$$DAT1^IBOUTL($P(IBNCR1,U,1)))
 D SET(IBNCRJ+11,IBNCROFF,"         User Adding Entry: "_$$USR^IBNCPEV($P(IBNCR1,U,2)))
 D SET(IBNCRJ+12,IBNCROFF,"     Date ROI Last Updated: "_$$DAT1^IBOUTL($P(IBNCR1,U,3)))
 D SET(IBNCRJ+13,IBNCROFF,"        User Last Updating: "_$$USR^IBNCPEV($P(IBNCR1,U,4)))
 D SET(IBNCRJ+14,IBNCROFF,"            Date Last Used: "_$$DAT1^IBOUTL($P(IBNCR1,U,5)))
BLDQ ;
 Q
 ;
BLANK(LINE) ; -- Build blank line
 D SET^VALM10(.LINE,$J("",80))
 Q
 ;
SET(LINE,COL,TEXT,ON,OFF) ; -- set display info in array
 D:'$D(@VALMAR@(LINE,0)) BLANK(.LINE)
 D SET^VALM10(.LINE,$$SETSTR^VALM1(.TEXT,@VALMAR@(LINE,0),.COL,$L(TEXT)))
 ;S VALMCNT=VALMCNT+1
 D:$G(ON)]""!($G(OFF)]"") CNTRL^VALM10(.LINE,.COL,$L(TEXT),$G(ON),$G(OFF))
 Q
 ;
HDR ; -- screen header for initial screen
 D PID^VADPT
 S VALMHDR(1)="ROI Management for Patient: "_$E($P($G(^DPT(DFN,0)),"^"),1,20)_" "_$E($G(^(0)),1)_VA("BID")
 S VALMHDR(2)=" "
 Q
 ;
FNL ; -- exit and clean up
 K ^TMP("IBNCRVR",$J)
 K IBFASTXT
 D CLEAN^VALM10
 K VA,VAERR
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
