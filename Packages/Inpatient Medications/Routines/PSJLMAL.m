PSJLMAL ;BIR/LC-ACTIVE ORDERS ;14 JAN 97 / 10:39 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
EN ; -- main entry point
 D EN^VALM("PSJ LM ALLERGY DISPLAY")
 Q
 ;
HDR ; -- header code
 D HDR^PSJLMHED(DFN)
 Q
 ;
INIT ; -- init variables and list array
 S VALMCNT=PSJAL
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 Q
 ;
EXPND ; -- expand code
 Q
 ;
