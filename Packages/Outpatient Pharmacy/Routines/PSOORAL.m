PSOORAL ;BHAM-ISC/SAB - activity log list ;08/23/17  20:19
 ;;7.0;OUTPATIENT PHARMACY;**148,281,441**;DEC 1997;Build 208
EN ; -- main entry point for PSO LM ACTIVITY LOGS
 D EN^VALM("PSO LM ACTIVITY LOGS")
 Q
 ;
HDR ; -- header code
 D HDR^PSOLMUTL
 Q
 ;
INIT ; -- init variables and list array
 I $G(PS)="VIEW"!($G(PS)="DELETE")!($G(PS)="REJECT")!($G(PS)="REJECTMP") D
 .I ST<12,$P(RX2,"^",6)<DT S ST=11
 .S VALM("TITLE")="Rx View "_"("_$P("Error^Active^Non-Verified^Refill^Hold^Non-Verified^Suspended^^^^^Done^Expired^Discontinued^Deleted^Discontinued^Discontinued (Edit)^Provider Hold^","^",ST+2)_")"
 .I ST=0,$G(^PSRX(RXN,"PARK")) S VALM("TITLE")="Rx View (ACTIVE/PARKED)"  ;441 PAPI
 S VALMCNT=PSOAL
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 S VALMBCK="Q" Q
 ;
EXPND ; -- expand code
 Q
 ;
