PSJLMDA ;BIR/LC-DETAILED ALLERGY LIST ;14 JAN 97 / 10:40 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
EN ; -- main entry point for PSO LM DETAILED ALLERGY
 D EN^VALM("PSJ LM DETAILED ALLERGY")
 Q
 ;
HDR ; -- header code
 D HDR^PSJLMHED(DFN)
 Q
 ;
INIT ; -- init variables and list array
 S:'$G(DFN) DFN=PSGP D BEG^PSJORDA
 S VALMCNT=PSJDA
 Q
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K AGN,PSJAL,PSJALL,PSJDA,VALMSG
 Q
 ;
EXPND ; -- expand code
 Q
 ;
