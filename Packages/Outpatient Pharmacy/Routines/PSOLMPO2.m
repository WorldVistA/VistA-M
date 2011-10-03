PSOLMPO2 ;ISC-BHAM/SAB - list template to complete backdoor orders ;03/13/1995
 ;;7.0;OUTPATIENT PHARMACY;**46,71,225**;DEC 1997;Build 29
EN ; -- main entry point for PSO LM BACKDOOR ORDER
 D EN^VALM("PSO LM BACKDOOR ORDER")
 Q
 ;
HDR ; -- header code
 D HDR^PSOLMUTL
 Q
 ;
INIT ; -- init variables and list array
 S VALMCNT=IEN,VALM("TITLE")="New OP Order ("_$S($G(COPY):"COPY",1:"ROUTINE")_")"
 S VALMCNT=PSOPF
 D RV^PSONFI Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K PSOANSQD
 S PSOQFLG=1
 K FLAGLINE D CLEAN^VALM10
 Q
 ;
EXPND ; -- expand code
 Q
 ;
