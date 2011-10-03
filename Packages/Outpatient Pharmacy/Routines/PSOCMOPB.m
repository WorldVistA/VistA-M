PSOCMOPB ;BIR/HTW-CMOP Release/Edit Utility ; 6/17/97 [ 12/15/97  2:11 PM ]
 ;;7.0;OUTPATIENT PHARMACY;**11,148**;DEC 1997
OREL(RXP) ;      Called from PSODISP to check for CMOP during manual Release
 ; IF ePharmacy Rx and it was returned to Stock, allow release
 I $$STATUS^PSOBPSUT(RXP,0)'="",$$RXRLDT^PSOBPSUT(RXP,0)="",$$GET1^DIQ(52,RXP,32.1,"I") G D1
 D LAST
 ;      This for original fill. No release unless cancelled.
 I $G(CMOP(0))=0!($G(CMOP(0))=1)!($G(CMOP(0))=2) S ISUF=1
 G D1
RREL(RXP,RFL) ;      This for Release Refills PSODISP
 ; IF ePharmacy Rx and it was returned to Stock, allow release
 I $$STATUS^PSOBPSUT(RXP,RFL)'="",$$RXRLDT^PSOBPSUT(RXP,RFL)="",$$GET1^DIQ(52.1,RFL_","_RXP,14,"I") G D1
 D LAST
 ; 
RREL1 ; No release of fills unless cancelled
 I $G(CMOP(YY))=0!($G(CMOP(YY))=1)!($G(CMOP(YY))=2) S ISUF=1
 G D1
CS(RXP) N YY,ISUF
 I +$G(XTYPE) S YY=$P($G(XTYPE),"^",2) D RREL(RXP,YY) I $G(ISUF) S XFLAG=1 K ISUF Q
 I $P($G(XTYPE),"^")="" D OREL(RXP) I $G(ISUF) S XFLAG=1 K ISUF Q
 Q
LAST ; Find last event, Find last fill
 F B=0:0 S B=$O(^PSRX(RXP,4,B)) Q:(+B<1)  S CMOP($P(^PSRX(RXP,4,B,0),"^",3))=$P(^PSRX(RXP,4,B,0),"^",4)
 Q
D1 ;
 K CMOP,PSXACT,PSXRXN,PSXDA,PSXRX0,PSXRXS,PSXRXP,PSXLFD,PSXRXF,PSXFDA,PSXIR
 K PSXACT,CNT,PPLSAVE,PSXPPL1,PSXCK,P1,P2,PSXPPL,PSXIEN,PSXDRUG,PSXLF
 K PSXRX,PSXSD,FLAG,NEWDT,PSXFDT,I,SUSPT,PSX1,PSX2,PSXER,PSXJOB,B,C
 Q
SUS ; From SUP^PSORXED1 If suspense date edited to future date resuspend
 S RXN=DA,RX0=^PSRX(DA,0),DA=RXS,DIK="^PS(52.5," D ^DIK S DA=RXN
 S DIC="^PS(52.5,",DIC(0)="L",X=RXN
 S DIC("DR")=".02///"_SD_";.03////"_$P(^PSRX(DA,0),"^",2)_";.04///M;.05///0;.06////"_PSOSITE_";2///0;3////Q;9////"_$G(RFD)
 K DD,DO D FILE^DICN K DD,DO
 K ^PS(52.5,"AC",$P(^PSRX(RXN,0),"^",2),SD,+Y)
 S IR=0 F FDA=0:0 S FDA=$O(^PSRX(DA,"A",FDA)) Q:'FDA  S IR=FDA
 S IR=IR+1,^PSRX(DA,"A",0)="^52.3DA^"_IR_"^"_IR
 D NOW^%DTC S ^PSRX(DA,"A",IR,0)=%_"^E^"_DUZ_"^"_RFD_"^Suspended for CMOP until "_$E(SD,4,5)_"-"_$E(SD,6,7)_"-"_$E(SD,2,3)
 W !,"RX# "_$P(RX0,"^")_" HAS BEEN SUSPENDED FOR CMOP UNTIL "_$E(SD,4,5)_"-"_$E(SD,6,7)_"-"_$E(SD,2,3)_".",!
 K PSOCMOP
 Q
EQTY ;W !,"Y=",Y
 S DIR(0)="52,7" S DRG=+$P(^PSRX(ZRX,0),"^",6) S DIR("A")="QTY "_$S($D(^PSDRUG("AQ",DRG)):$G(^PSDRUG(DRG,5)),1:"")
 S:$P(^PSRX(ZRX,0),"^",7) DIR("B")=$P(^(0),"^",7)
 D ^DIR K DIR
 I Y["^",($L(Y)>1) W $C(7),"   Sorry no ^ jumping allowed" K Y G EQTY
 I Y["^"!($D(DTOUT)) S PSXEXIT=1
 K Y,DIR
 Q
EQTY2 ;
 S DIR(0)="52.1,1" S DRG=+$P(^PSRX(ZRX,0),"^",6)
 S DIR("A")="QTY "_$S($D(^PSDRUG("AQ",DRG)):$G(^PSDRUG(DRG,5)),1:"")
 S DIR("B")=$P(^PSRX(ZRX,1,PSXRFL,0),"^",4)
 D ^DIR
 I Y["^",($L(Y)>1) W $C(7),"   Sorry no ^ jumping allowed" K Y G EQTY2
 I Y["^"!($D(DTOUT)) S PSXEXIT=1
 D QTY
 I $G(X)']"" G EQTY2
 K Y S:X>0 $P(^PSRX(ZRX,1,PSXRFL,0),"^",4)=X
 Q
QTY ;Check quantity
 I X>99999999!($L(X)>11)!(X'?.N.1".".2N) K X G HELP
 Q
HELP ; QTY HELP
 W !!,"This is a CMOP drug.  The quantity may not contain alpha characters (i.e.; ML)    or more than two decimal places (i.e.; .01)."
 W !,"Enter a whole number between 0 and 99999999 inclusive. The total entry cannot     exceed 11 characters." K Z0
 Q
