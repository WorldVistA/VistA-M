PSGWAP ;BHAM ISC/PTD,CML-Purge Old AMIS Data ; 14 Feb 1989  1:36 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 W !!,"This option will purge data from file PSI(58.5) - AMIS stats file.",!,"You should retain the data for at least 1 quarter.",!,"Therefore, the option will NOT ALLOW DELETION of data newer than ""T-100"".",!!
BDT S BDT=0 I '$O(^PSI(58.5,"B",BDT)) W !,"There is NO data in the AMIS stats file.",!! K BDT Q
 E  S BDT=$O(^PSI(58.5,"B",BDT))
EDT S %DT="AEXP",%DT("A")="Purge AMIS data older than (and including): ",%DT("B")="T-100" D ^%DT K %DT G:Y<0 END S (EDT,X2)=Y
 D NOW^%DTC S X1=$P(%,".") D ^%DTC I X<100 W !!,"Data less than 100 days old may NOT BE DELETED!",!! G EDT
 I BDT>EDT W !!,"No AMIS data to purge in selected date range.",!! G END
ASK S Y=EDT X ^DD("DD") W !!,"I will now delete AMIS data that is older than (and including) ",Y,!,"Are you SURE that is what you want to do?  NO// " R X:DTIME
 G:'$T!("^Nn"[$E(X)) END
 I "Yy"'[$E(X) W *7,*7,!!,"Answer ""yes"" if you wish to purge AMIS data.",!,"Answer ""no"" or <return> if you do not.",!! G ASK
 S ZTRTN="ENQ^PSGWAP",ZTDTH=$H,ZTIO="",ZTDESC="Purge Old AMIS Data" F G="BDT","EDT" S:$D(@G) ZTSAVE(G)=""
 D ^%ZTLOAD,HOME^%ZIS W !,"AMIS purge queued!" K ZTSK G END
 ;
ENQ ;ENTRY POINT WHEN QUEUED
 S LPDT=BDT-1,DATDA=0
DTLP S LPDT=$O(^PSI(58.5,"B",LPDT)) G:(LPDT>EDT)!'LPDT END
DTDA S DATDA=$O(^PSI(58.5,"B",LPDT,DATDA)) G:'DATDA DTLP
 S DIE="^PSI(58.5,",DA=DATDA,DR=".01///@" D ^DIE K DIE G DTDA
 ;
END K ZTSK,BDT,EDT,X,Y,LPDT,DATDA,%,%I,%H,G,ZTIO,DA,DR S:$D(ZTQUEUED) ZTREQ="@" Q
