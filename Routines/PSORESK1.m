PSORESK1 ;BHAM ISC/SAB - return to stock continued ;06/03/97 10:12
 ;;7.0;OUTPATIENT PHARMACY;**9,201**;DEC 1997
HP W !!,"Wand the barcode number of the Rx or manually key in",!,"the number below the barcode or the Rx number."
 W !,"The barcode number format is - 'NNN-NNNNNNN'",!!,"Press 'ENTER' to process Rx or ""^"" to quit"
 Q
STAT S RX0=^PSRX(RXP,0),RX2=^PSRX(RXP,2),J=RXP S $P(RX0,"^",15)=$P($G(^PSRX(RXP,"STA")),"^") D ^PSOFUNC
 W !!,$C(7),$C(7),"Rx status of "_ST_" and cannot be returned to stock.",! K RX0,ST Q
CP D NOW^%DTC S PSODT=%
 S PSOCPRX=$P(^PSRX(RXP,0),"^") S PSO=1,PSODA=RXP,PSOPAR7=$G(^PS(59,PSOSITE,"IB")) W !!,"Attempting to remove copay charges",! D RXED^PSOCPA
 I COPAYFLG=0 W !!,"Reason must be entered. Rx "_$P(^PSRX(RXP,0),"^")_" not returned to stock.",!
 ;PFS: send Rx info to external billing system when copay and no copay.
 Q
ACT S IFN=0 F I=0:0 S I=$O(^PSRX(RXP,"A",I)) Q:'I  S IFN=I
 I $G(PSOWHERE) S COM=$G(COM)_" (Released by CMOP)"
 I +$G(PSOPFS) S:$P(PSOPFS,"^",3)'="" COM=$G(COM)_" (External Billing Charge ID: "_$P(PSOPFS,"^",3)_")"
 D NOW^%DTC S IFN=IFN+1,^PSRX(RXP,"A",0)="^52.3DA^"_IFN_"^"_IFN,^PSRX(RXP,"A",IFN,0)=%_"^I^"_DUZ_"^"_$S(XTYPE="O":0,$G(TYPE)'<0&($G(TYPE)<6)&(XTYPE):TYPE,$G(TYPE)>5&(XTYPE):(TYPE+1),1:6)_"^"_COM
 K DA Q
CMOP ;original released by CMOP?  Called by PSORESK
 S PSXREL=$P($G(^PSRX(RXP,2)),"^",13)
 I $G(PSXREL),($D(^PSRX("AR",PSXREL,RXP,0))) W !!,$C(7),"Rx # "_$P(^PSRX(RXP,0),"^")_":",?20," Was dispensed by the CMOP and may not be returned"
 I  W !,?20," to stock at this facility." Q
 K PSXREL
 Q
CMOP1 ; REFILL released by CMOP?  Called by PSORESK
 I +$G(XTYPE) S PSXREL=$P($G(^PSRX(RXP,1,TYPE,0)),"^",18)
 I $G(PSXREL),($D(^PSRX("AR",PSXREL,RXP,TYPE))) W !!,"REFILL # "_TYPE_":",?20," Was dispensed by the CMOP and may not be returned"
 I  W !,?20," to stock at this facility." Q
 K PSXREL
 Q
