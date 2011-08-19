PSOLMPO1 ;ISC-BHAM/SAB - complete pending orders ;03/13/1995
 ;;7.0;OUTPATIENT PHARMACY;**46,71,225**;DEC 1997;Build 29
EN ; -- main entry point for PSO LM COMPLETE ORDER
 D EN^VALM("PSO LM COMPLETE ORDER")
 K PSOANSQD
 Q
 ;
HDR ; -- header code
 D HDR^PSOLMUTL
 Q
 ;
INIT ; -- init variables and list array
 S VALMCNT=IEN,VALM("TITLE")=$S($P(OR0,"^",23):"FL-",1:"")_"Pending OP Orders ("_$S($P($G(OR0),"^",14)="S":"STAT",$P($G(OR0),"^",14)="E":"EMERGENCY",1:"ROUTINE")_")"
 D RV^PSONFI Q
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
