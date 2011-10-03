PSOLMPI ;BHAM ISC/LC - PATIENT INFORMATION ; 08-MAR-1995
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
EN ; -- main entry point for PSO LM Patient Information
 I '$D(^TMP("PSOPI",$J)) D ^PSOORUT2
 D EN^VALM("PSO LM Patient Information")
 Q
 ;
HDR ; -- header code
 D HDR^PSOLMUTL
 S VALMHDR(4)="  SEX: "_^TMP("PSOHDR",$J,5,0)
 Q
 ;
INIT ; -- init variables and list array
 S VALMCNT=PSOPI
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAN^VALM10 Q
 ;
EXPND ; -- expand code
 Q
 ;
