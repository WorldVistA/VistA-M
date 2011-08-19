PSXEDUTL ;BIR/HTW-CMOP Release/Edit Utility ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
OREL ;      Called from PSODISP to check for CMOP during manual Release
 D LAST
 ;      This for original fill
 ;      No release unless cancelled.
 I $G(B(0))=0!($G(B(0))=1)!($G(B(0))=2) S ISUF=1 G D1
 Q
RREL ;      This for Release Refills PSODISP
 D LAST
 ; No release of fills unless cancelled
RREL1 I $G(B(YY))=0!($G(B(YY))=1)!($G(B(YY))=2) S ISUF=1 G D1
 Q
CS N YY,ISUF
 I +$G(XTYPE) S YY=$P($G(XTYPE),"^",2) D RREL I $G(ISUF) S PSXFLAG=1 K ISUF Q
 I $P($G(XTYPE),"^")="" D OREL I $G(ISUF) S PSXFLAG=1 K ISUF Q
 Q
LAST ; Find last event, Find last fill
 F B=0:0 S B=$O(^PSRX(RXP,4,B)) Q:(+B<1)  S B($P(^PSRX(RXP,4,B,0),"^",3))=$P(^PSRX(RXP,4,B,0),"^",4)
 Q
D1 ;
 K PSXACT,PSXRXN,PSXDA,PSXRX0,PSXRXS,PSXRXP,PSXLFD,PSXRXF,PSXFDA,PSXIR
 K PSXACT,CNT,PPLSAVE,PSXPPL1,PSXCK,P1,P2,PSXPPL,PSXIEN,PSXDRUG,PSXLF
 K PSXRX,PSXSD,FLAG,NEWDT,PSXFDT,I,SUSPT,PSX1,PSX2,PSXER,PSXJOB,B,C
 Q
SUS ; From SUP^PSORXED1 If suspense date edited to future date resuspend
 S RXN=DA,RX0=^PSRX(DA,0),DA=RXS,DIK="^PS(52.5," D ^DIK S DA=RXN
 S DIC="^PS(52.5,",DIC(0)="L",X=RXN
 S DIC("DR")=".02///"_SD_";.03////"_$P(^PSRX(DA,0),"^",2)_";.04///M;.05///0;.06////"_PSOSITE_";2///0;3////Q"
 K DD,DO
 D FILE^DICN
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
 I Y["^",($L(Y)>1) W "   Sorry no ^ jumping allowed" K Y G EQTY
 I Y["^"!($D(DTOUT)) S PSXEXIT=1
 K Y,DIR
 Q
EQTY2 ;
 S DIR(0)="52.1,1" S DRG=+$P(^PSRX(ZRX,0),"^",6)
 S DIR("A")="QTY "_$S($D(^PSDRUG("AQ",DRG)):$G(^PSDRUG(DRG,5)),1:"")
 S DIR("B")=$P(^PSRX(ZRX,1,PSXRFL,0),"^",4)
 D ^DIR
 I Y["^",($L(Y)>1) W "   Sorry no ^ jumping allowed" K Y G EQTY2
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
