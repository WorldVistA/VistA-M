PSOVERC ;BHAM ISC/DMA,SAB - discontinue duplicate class from verify ; 07/22/95 17:11
 ;;7.0;OUTPATIENT PHARMACY;**146,223,148,249**;DEC 1997;Build 9
 W !,$C(7)," *** SAME CLASS *** OF DRUG IN RX # ",$P(^PSRX(+$P(RX0,"^"),0),"^"),"  ",$P(DRG,"^") Q:'$P(PSOPAR,"^",18)
 S PTST="" I $D(^PS(55,PSDFN,"PS")) S Z=+^("PS") I $D(^PS(53,Z,0)) S PTST=^(0)
DATA S DUPRX0=^PSRX($P(RX0,"^"),0),$P(DUPRX0,"^",15)=+$G(^("STA")),PSRFLS=$P(DUPRX0,"^",9),ISSD=$P(^(0),"^",13),RX0=DUPRX0,RX2=^(2),CAN=$P(DUPRX0,"^",15)'<11 K PSONULN S $P(PSONULN,"-",79)="-"
 W !!,$J("Status: ",24) S J=$P(RX0,"^") D STAT^PSOFUNC W ST K RX0,RX2 W ?40,$J("Issued: ",24),$E(ISSD,4,5),"-",$E(ISSD,6,7),"-",$E(ISSD,2,3)
 W !,$J("SIG: ",24),$P(DUPRX0,"^",10),!,$J("QTY: ",24),$P(DUPRX0,"^",7),?40,$J("# of refills: ",24),PSRFLS
 S PHYS=$S($D(^VA(200,+$P(DUPRX0,"^",4),0)):^(0),1:"UNKNOWN")
 W !,$J("Provider: ",24),$P(PHYS,"^"),?40,$J("Refills remaining: ",24),PSRFLS-$S($D(^PSRX($P(RX0,"^"),1,0)):$P(^(0),"^",4),1:0)
 S LSTFL=+^PSRX($P(RX0,"^"),3) W !?40,$J("Last filled on: ",24),$E(LSTFL,4,5),"-",$E(LSTFL,6,7),"-",$E(LSTFL,2,3)
 W !,PSONULN,! I (CAN)!($P(DUPRX0,"^",15)=12) S CAN=1 Q
 I PTST["AUTH ABS",'$P(PSOPAR,"^",5) S X=1 Q
ASKC S DIR("A")="Discontinue Prescription #"_$P(DUPRX0,"^")_" ",DIR("B")="N",DIR(0)="SA^1:YES;0:NO",DIR("?")="Enter Y to discontinue this Prescription." D ^DIR K DIR
 I 'Y W "  Prescription was not discontinued..." Q
CANOLD S $P(^PSRX($P(RX0,"^"),"STA"),"^")=12,$P(^PSRX($P(RX0,"^"),3),"^",5)=DT
 S PSMSG="Discontinued by new prescription",PSREA="C",PSRXREF=0 N PSOVRCTP S PSOVRCTP=$P(RX0,"^") D REVERSE^PSOBPSU1(PSOVRCTP,,"DC",7),CAN^PSOTPCAN(PSOVRCTP) D ACTLOG
 S PSI="",$P(PSD(DRG),"^",3)=12 W "  Prescription has been discontinued." S DA=$O(^PS(52.5,"B",$P(RX0,"^"),0)) I DA S PSI=$G(^PS(52.5,DA,"P")),DIK="^PS(52.5," D ^DIK K DIK,DA
 D:'PSI SUSPCAN^PSOUTL
 Q
ACTLOG ;adds activity log for discontinuations
 S RXF=0 F JJ=0:0 S JJ=$O(^PSRX($P(RX0,"^"),1,JJ)) Q:'JJ  S RXF=JJ S:JJ>5 RXF=JJ+1
 S IR=0 F JJ=0:0 S JJ=$O(^PSRX($P(RX0,"^"),"A",JJ)) Q:'JJ  S IR=JJ
 S IR=IR+1,^PSRX($P(RX0,"^"),"A",IR,0)=DT_"^C^"_DUZ_"^"_RXF_"^"_PSMSG K RXF,JJ,IR
 Q
