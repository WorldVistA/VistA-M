PSOLMRN ;ISC-BHAM/SAB - displays renewal rxs ;04/21/1995
 ;;7.0;OUTPATIENT PHARMACY;**11,46,84,225**;DEC 1997;Build 29
EN ; -- main entry point for PSO LM RENEW LIST
 S VALMCNT=PSOPF,PSOLM=1
 D EN^VALM("PSO LM RENEW LIST")
 Q
 ;
HDR ; -- header code
 K ^TMP("PSOHDR",$J) D HDR^PSOLMUTL
 Q
 ;
INIT ; -- init variables and list array
 ;F LINE=1:1:30 D SET^VALM10(LINE,LINE_"     Line number "_LINE)
 S VALMCNT=PSOPF,PSOLM=1
 D RV^PSONFI Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 I $G(Y)=-1!($G(Y)="Q") S PSOQUIT=1
 I $G(Y)="Q",$P($G(Y(1)),"^",3)="QU" S PSOQQ=1
 K FLAGLINE D CLEAN^VALM10
 Q
 ;
EXPND ; -- expand code
 Q
 ;
