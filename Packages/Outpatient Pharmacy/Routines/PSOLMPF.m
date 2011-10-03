PSOLMPF ;BHAM ISC/LC - PROFILE ; 13-MAR-1995
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
EN ; -- main entry point for PSO LM PROFILE
 D EN^VALM("PSO LM PROFILE")
 Q
 ;
HDR ; -- header code
 D HDR^PSOLMUTL
 Q
 ;
INIT ; -- init variables and list array
 S VALMCNT=PSOPF
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 S PSOQFLG=1 Q
 ;
EXPND ; -- expand code
 Q
 ;
