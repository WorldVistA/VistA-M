PSOLMLST ;ISC-BHAM/SAB - list orders for processing ; 18-APR-1995
 ;;7.0;OUTPATIENT PHARMACY;**46**;DEC 1997
 ;External reference to ^PS(50.7 supported by DBIA 2223
EN ; -- main entry point for PSO LM ORDER SELECTION
 D EN^VALM("PSO LM ORDER SELECTION")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="This is a test header for PSO LM ORDER SELECTION."
 S VALMHDR(2)="This is the second line"
 Q
 ;
INIT ; -- init variables and list array
 ;F LINE=1:1:30 D SET^VALM10(LINE,LINE_"     Line number "_LINE)
 S $P(RN," ",12)=" ",VALMCNT=PSOPF
 S VALM("TITLE")="OP Medications ("_$S($P(^PSRX($P(PSOLST(ORN),"^",2),"STA"),"^")=5:"SUSPENDED",$P(^PSRX($P(PSOLST(ORN),"^",2),"STA"),"^")=11:"EXPIRED",1:$P(PSOLST(ORN),"^",3))_")"
 S:'$D(^PS(50.7,+$G(^PSRX($P(PSOLST(ORN),"^",2),"OR1")),0)) VALMSG="No Pharmacy Orderable Item !"
 D RV^PSONFI Q
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
