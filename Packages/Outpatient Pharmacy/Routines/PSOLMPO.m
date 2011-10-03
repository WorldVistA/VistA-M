PSOLMPO ;ISC-BHAM/LC - pending orders ;03/13/95
 ;;7.0;OUTPATIENT PHARMACY;**46,225**;DEC 1997;Build 29
EN ; -- main entry point for PSO LM PENDING ORDER
 S PSOLMC=0 D EN^VALM("PSO LM PENDING ORDER") K PSOLMC
 Q
 ;
HDR ; -- header code
 D HDR^PSOLMUTL
 Q
 ;
INIT ; -- init variables and list array
 ;F LINE=1:1:30 D SET^VALM10(LINE,LINE_"     Line number "_LINE)
 S VALMCNT=IEN,VALM("TITLE")=$S($P(OR0,"^",23):"FL-",1:"")_"Pending OP Orders ("_$S($P(OR0,"^",14)="S":"STAT",$P(OR0,"^",14)="E":"EMERGENCY",1:"ROUTINE")_")"
 D RV^PSONFI
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K FLAGLINE D CLEAN^VALM10
 Q
 ;
EXPND ; -- expand code
 Q
 ;
