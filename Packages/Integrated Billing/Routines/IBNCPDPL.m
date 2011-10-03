IBNCPDPL ;DALOI/SS - for ECME RESEARCH SCREEN ELIGIBILITY VIEW ;3/6/08  16:22
 ;;2.0;INTEGRATED BILLING;**276,384**;21-MAR-94;Build 74
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ;
 Q
 ;
 ; -- main entry point for IBNCPDP LSTMN ELIGIBILITY
 ;entry point for ECME "VE View Eligibility" menu option
 ;of the main ECME User Screen
EN1(DFN) ;
 I $G(DFN)>0 D EN^VALM("IBNCPDP LSTMN ELIGIBILITY")
 Q
 ;
HDR ; -- header code
 D HDR^IBJTEA
 Q
 ;
INIT ; -- init variables and list array
 ;D INIT^IBJTEA
 ;borrowed from INIT^IBJTEA with some changes
 K ^TMP("IBJTEA",$J)
 I '$G(DFN) S VALMQUIT="" Q
 D BLD^IBJTEA
 Q
 ;
HELP ; -- help code
 D HELP^IBJTEA
 Q
 ;
EXIT ; -- exit code
 D EXIT^IBJTEA
 Q
 ;
EXPND ; -- expand code
 Q
 ;
