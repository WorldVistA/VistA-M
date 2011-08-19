PSOHELP3 ;BHAM ISC/SAB - outpatient utility routine #4 ;2/17/93 18:00:36
 ;;7.0;OUTPATIENT PHARMACY;**20,291**;DEC 1997;Build 2
XREF ;code to create 'APD' xref on Drug Interaction file (#56)
 ;I '$D(ZTSK),'$D(PSMSG) D WAIT^DICD W "Building 'APD' X-Ref."
 ;The following code accessing files 56 and 50.416 is no longer executed
 S ID1=$P(^PS(56,DA,0),"^",2),ID2=$P(^(0),"^",3),TOT=0
 F I1=0:0 S I1=$O(^PS(50.416,ID1,1,I1)) Q:'I1  S R2=$P(^(I1,0),"^") F I2=0:0 S I2=$O(^PS(50.416,ID2,1,I2)) Q:'I2  S D2=$P(^(I2,0),"^") W:+$G(PSMSG) "." D SEC
 F I1=0:0 S I1=$O(^PS(50.416,"APS",ID1,I1)) Q:'I1  F I3=0:0 S I3=$O(^PS(50.416,I1,1,I3)) Q:'I3  S R2=$P(^(I3,0),"^") F I5=0:0 S I5=$O(^PS(50.416,"APS",ID2,I5)) Q:'I5  F I6=0:0 S I6=$O(^PS(50.416,I5,1,I6)) Q:'I6  S D2=$P(^(I6,0),"^") D SEC
 F I1=0:0 S I1=$O(^PS(50.416,ID1,1,I1)) Q:'I1  S R2=$P(^(I1,0),"^") F I5=0:0 S I5=$O(^PS(50.416,"APS",ID2,I5)) Q:'I5  F I6=0:0 S I6=$O(^PS(50.416,I5,1,I6)) Q:'I6  S D2=$P(^(I6,0),"^") D SEC
 F I2=0:0 S I2=$O(^PS(50.416,ID2,1,I2)) Q:'I2  S D2=$P(^(I2,0),"^") F I1=0:0 S I1=$O(^PS(50.416,"APS",ID1,I1)) Q:'I1  F I3=0:0 S I3=$O(^PS(50.416,I1,1,I3)) Q:'I3  S R2=$P(^(I3,0),"^") D SEC
 S $P(^PS(56,DA,0),"^",6)=TOT
EX K TOT,I5,I6,D2,I4,I3,PRI,I1,I2,R2,PS1,PS2,ID2,ID1
 Q
SEC I +$G(DEL) K ^PS(56,"APD",R2,D2,DA),^PS(56,"APD",D2,R2,DA) Q
 S ^PS(56,"APD",R2,D2,DA)="",^PS(56,"APD",D2,R2,DA)="",TOT=TOT+2
 Q
DRUG ;selects drug and updates Rx file with cost (pso*7*20)
 W !!,"This option will update the drug cost on all fills in the PRESCRIPTION"
 W !,"file (#52) based on the selected date range and the current cost in the"
 W !,"DRUG file (#50).",!
 K X,Y,DA,DIC S DIC(0)="AQEM",DIC=50 D ^DIC I $G(DUOUT) K DIC,Y,X,DA Q
 I Y<0 G OUT
 S (DRG,DA)=+Y K DIC,DR,DIQ S DIC=50,DR=16,DIQ="PSODRG",DIQ(0)="I"
 D EN^DIQ1 S COST=PSODRG(50,DA,16,"I") K PSODRG,DIC,DA,DR,DIQ,DIR
 W ! S DIR("A")="Do you want to exclude Refills and Partials",DIR(0)="Y",DIR("B")="No" D ^DIR K DIR I $G(DIRUT) K COST,X,DRG,Y Q
 S REF=$S(Y:0,1:1)
 S X1=DT,X2=-485 D C^%DTC S (DEF,Y)=X X ^DD("DD")
 W !!,"You can only go back One Year plus 120 days."
 S %DT(0)=DEF,%DT="AQEX",%DT("A")="Enter starting fill date: ",%DT("B")=Y D ^%DT K %DT("B"),DEF I Y<0!($D(DTOUT)) K REF,COST,DRG,X,Y Q
 S (FBCK,%DT(0))=Y,%DT("A")="Enter ending fill date: " D ^%DT
 K %DT I Y<0!($D(DTOUT)) K FBCK,REF,COST,DRG,X,Y Q
 S FAHD=Y
 S PSOFUTR=0 I FAHD>(DT-1) S PSOFUTR=1 D
 .W !!,"Since you selected an end fill date of today or in the future, this option"
 .W !,"will update the cost for all existing and suspended fills that have a"
 .W !,"fill date in the future.",!
 K DIR,X,Y S DIR(0)="Y",DIR("A")="Do you want to Queue to run at a specific Time",DIR("B")="Yes" D ^DIR K DIR I $D(DIRUT) G OUT
 I Y S PSOQ=1 K ZTDTH D  G OUT
 .S ZTRTN="EN^PSOHELP3",ZTIO="",ZTDESC="Outpatient Pharmacy Rx Cost Update"
 .F G="REF","COST","DRG","FBCK","FAHD","PSOQ","PSOFUTR" S:$D(@G) ZTSAVE(G)=""
 .D ^%ZTLOAD I $D(ZTSK) W !!,"Rxs Cost Update Queued",! K ZTSK
EN W:'$G(PSOQ) !,"Updating cost. Please wait... "
 S FDT=FBCK-1 F  S FDT=$O(^PSRX("ADL",FDT)) Q:'FDT  D  Q:FDT>FAHD
 .I '$G(PSOFUTR) I FDT>FAHD Q
 .S RXN=0 F  S RXN=$O(^PSRX("ADL",FDT,DRG,RXN)) Q:'RXN  D  W:'$G(PSOQ) "."
 ..I $P($G(^PSRX(RXN,0)),"^",6)=DRG,$P($G(^(2)),"^",2)=FDT S $P(^PSRX(RXN,0),"^",17)=COST
 I 'REF G OUT
 D REFILL,PARTIAL
OUT K G,COST,I,X,Y,REF,RXN,FDT,FAHD,FBCK,DRG,PSOQ,DIRUT,PSOFUTR I $D(ZTQUEUED) S ZTREQ="@"
 Q
POST ;post install entry point.  builds new "ADL" xref for file 52 pso*7*20
 S ZTRTN="EN1^PSOHELP3",ZTIO="",ZTDESC="Outpatient Pharmacy Rx XREF Update"
 S ZTDTH=$H D ^%ZTLOAD I $D(ZTSK) D BMES^XPDUTL(" Post Install Background Job Queued.") K ZTSK
 Q
EN1 K ^PSRX("ADL") S X1=DT,X2=-485 D C^%DTC S DEF=X-1 W !,"DEF: "_DEF
 F  S DEF=$O(^PSRX("AD",DEF)) Q:'DEF  F IFN=0:0 S IFN=$O(^PSRX("AD",DEF,IFN)) Q:'IFN  S FTY="" F  S FTY=$O(^PSRX("AD",DEF,IFN,FTY)) Q:FTY=""  I FTY=0 D
 .I $P($G(^PSRX(IFN,2)),"^",2),$P($G(^(0)),"^",6) S ^PSRX("ADL",$P($G(^PSRX(IFN,2)),"^",2),$P($G(^(0)),"^",6),IFN)=""
 K X,Y,DEF,FTY,IFN S ZTREQ="@"
 Q
REFILL ;
 N FILL,FDT,RXN
 S FDT=FBCK-1 F  S FDT=$O(^PSRX("AD",FDT)) Q:'FDT  D  Q:FDT>FAHD
 .I '$G(PSOFUTR),FDT>FAHD Q
 .S RXN="" F  S RXN=$O(^PSRX("AD",FDT,RXN)) Q:'RXN  D
 ..I $P($G(^PSRX(RXN,0)),"^",6)'=DRG Q
 ..S FILL=0 F  S FILL=$O(^PSRX("AD",FDT,RXN,FILL)) Q:'FILL  I $D(^PSRX(RXN,1,FILL,0)) S $P(^(0),"^",11)=COST
 Q
PARTIAL ;
  N FILL,FDT,RXN
  S FDT=FBCK-1 F  S FDT=$O(^PSRX("ADP",FDT)) Q:'FDT  D  Q:FDT>FAHD
 .I '$G(PSOFUTR),FDT>FAHD Q
 .S RXN="" F  S RXN=$O(^PSRX("ADP",FDT,RXN)) Q:'RXN  D
 ..I $P($G(^PSRX(RXN,0)),"^",6)'=DRG Q
 ..S FILL=0 F  S FILL=$O(^PSRX("ADP",FDT,RXN,FILL)) Q:'FILL  I $D(^PSRX(RXN,"P",FILL,0)) S $P(^(0),"^",11)=COST
 Q
