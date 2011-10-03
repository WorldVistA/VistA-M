PSOSUDPR ;BIR/RTR-Delete printed Rx's from Suspense File ; 10/4/96
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
 I '$D(PSOPAR) D ^PSOLSET I '$D(PSOPAR) W $C(7),!!,?5,"Site Parameters must be defined to use this option!",! Q
 W !!,"This option allows you to delete printed Rx's from suspense.",!
EN K DIR,PSOCODE S DIR(0)="SB^R:Rx;P:Patient;D:Date Range;B:Batch",DIR("B")="Rx",DIR("A")="Delete by"
 S DIR("A",1)="Enter 'R' to delete one Rx, 'P' to delete by patient, 'D' by date range,",DIR("A",2)="or 'B' to delete by printed batches. Enter '^' to Exit.",DIR("A",3)=""
 S DIR("?",1)="This option allows you to remove Rx's from suspense that have already been",DIR("?",2)="printed. This will ensure that they cannot be reprinted if suspense is reset",DIR("?",3)="for reprinting.",DIR("?",4)=""
 S DIR("?",5)="You may delete a single Rx, all Rx's for a particular patient, all Rx's that",DIR("?",6)="fall within a specified date range, or all Rx's from a printed batch.",DIR("?")=" "
 W ! D ^DIR K DIR S PSOCODE=Y I Y["^"!($D(DTOUT))!($D(DUOUT)) G END
 S PSODIVS=0 F ZZZ=0:0 S ZZZ=$O(^PS(59,ZZZ)) Q:'ZZZ  S PSODIVS=PSODIVS+1
 I PSOCODE="P" D ALL G EN
 I PSOCODE="D" D DATE G EN
 I PSOCODE="B" D ^PSOSUDP1 G EN
SING ;Delete single RX
 K DIR S DIR("A")="Select Rx #: ",DIR(0)="FOA",DIR("?")="Enter the prescription number or wand the barcode" W ! D ^DIR K DIR I $D(DTOUT)!($D(DUOUT))!(X="") D MES G EN
 S OUT=0,ANS=Y D:Y["-" PSOINST^PSOSUPAT D:OUT MES G:OUT SING
 S:Y["-" Y=$P(Y,"-",2),X=$P($G(^PSRX(+Y,0)),"^")
 S:ANS'["-" X=Y W ! S DIC("S")="I $D(^PSRX(+$P(^PS(52.5,+Y,0),""^""),0))",DIC="^PS(52.5,",DIC(0)="ZQE" D ^DIC K DIC W ! G:$D(DTOUT)!($D(DUOUT)) EN D MES:Y<0 G SING:Y<0 S (RXINT,RXREC)=+Y(0),SUSINT=$P(Y,"^")
 S RXEXT=$P($G(^PSRX(RXINT,0)),"^") I $P($G(^PS(52.5,SUSINT,"P")),"^")=0!($P($G(^("P")),"^")="") W $C(7),!?5,"Cannot delete, Rx# ",RXEXT," has not been printed yet!" G SING
 I $P($G(^PS(52.5,SUSINT,0)),"^",6)'=PSOSITE S PSPOP=0 D CKDIV^PSOSUPAT I PSPOP W ! D MES G SING
 W ! K DIR S DIR("A")="OK to delete Rx# "_$G(RXEXT)_" from suspense",DIR("B")="Y",DIR(0)="Y" D ^DIR K DIR I 'Y D MES G SING
 S DA=SUSINT,DIK="^PS(52.5," D ^DIK W !!?5,"Rx# ",RXEXT," deleted from suspense!",!
 G EN
DATE ;
 S PSONLY=0
 W !!,"Deleting by date range will delete based on the day the Rx was",!,"actually printed from suspense!"
BDATE W ! K %DT S %DT="AEX",%DT("A")="Start Date : " D ^%DT K %DT G:Y=-1&(X'["^") BDATE I X["^"!($D(DTOUT)) D MES Q
EDATE S BDATE=$E(Y,1,7) S %DT(0)=Y,%DT="AEX",%DT("A")="End Date :" D ^%DT K %DT G:Y=-1&(X'["^") EDATE I X["^"!($D(DTOUT)) D MES Q
 S EDATE=$E(Y,1,7) W !
 I PSODIVS>1 K DIR S DIR(0)="Y",DIR("A")="Delete printed Rx's for all Divisions",DIR("B")="Y" D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) D MES Q
 I PSODIVS>1,'Y S PSONLY=1
 W ! K DIR S DIR(0)="Y",DIR("B")="Y",DIR("A")="OK to delete printed Rx's for the date range entered" D ^DIR K DIR I 'Y D MES Q
 W !!,"Deleting printed suspense entries."
 S EDATE=EDATE+.9999 S BDATE=BDATE-.0001 F SS=BDATE:0 S SS=$O(^PS(52.5,"ADL",SS)) Q:'SS!(SS>EDATE)  D
 .F QQ=0:0 S QQ=$O(^PS(52.5,"ADL",SS,QQ)) Q:'QQ  S PDIVFLAG=0,PSINT=$P($G(^PS(52.5,QQ,0)),"^") D:PSONLY  I 'PDIVFLAG,$P($G(^PS(52.5,QQ,"P")),"^")=1 S DA=QQ,DIK="^PS(52.5," D ^DIK W "."
 ..I PSOSITE'=$P($G(^PS(52.5,QQ,0)),"^",6) S PDIVFLAG=1
 W !,"Finished!"
 Q
ALL ;
 W ! K DIR S DIR("A")="Are you entering patient name or RX barcode",DIR(0)="SB^P:Patient Name;B:Barcode" D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) D MES Q
 S PSALL=Y
BAR S OUT=0 I PSALL="B" W ! K DIR S DIR("A")="Enter/wand barcode",DIR(0)="FO^5:20" D ^DIR K DIR G:Y["^"!($D(DTOUT))!($D(DUOUT)) ALL S BCNUM=Y D  G:OUT BAR
 .D PSOINST^PSOSUPAT Q:OUT  S RXN=$P(BCNUM,"-",2) I '$D(^PSRX(RXN,0))!('$P($G(^PSRX(RXN,0)),"^",2)) W !!,"Invalid Prescription!",! S OUT=1 Q
 .S PSODFN=$P($G(^PSRX(RXN,0)),"^",2) W !!,"Patient:  ",$P($G(^DPT(PSODFN,0)),"^")
 I PSALL'="B" K DIC W ! S DIC(0)="QEAMZ",DIC="^DPT(",DIC("S")="I $D(^PS(52.5,""AF"",+Y))" D ^DIC K DIC G:Y<0!($D(DTOUT))!($D(DUOUT)) ALL S PSODFN=+Y
 W ! K DIR S DIR(0)="Y",DIR("B")="Y",DIR("A")="OK to delete printed entries for "_$P($G(^DPT(PSODFN,0)),"^") D ^DIR K DIR I 'Y D MES Q
 W !!,"Deleting Suspense entries for ",$P($G(^DPT(PSODFN,0)),"^")
 F EE=0:0 S EE=$O(^PS(52.5,"AF",PSODFN,EE)) Q:'EE  I $P($G(^PS(52.5,EE,"P")),"^")=1&($P(^PS(52.5,EE,0),"^",7)'["QL") S PSORXIN=$P($G(^PS(52.5,EE,0)),"^"),DA=EE,DIK="^PS(52.5," D ^DIK W "."
 W !!,"Finished!",! G ALL
END K ANS,BCNUM,BDATE,DA,DFN,DIC,DIR,PDIVFLAG,EDATE,EE,OUT,PSALL,PSINT,PSOCODE,PSODFN,PSODIVS,PSONLY,PSORXIN,PSPOP,QQ,RXINT,RXN,RXREC,SS,SUSINT,X,Y,ZZZ Q
 ;
MES W !!?3,"Nothing deleted!",! Q
