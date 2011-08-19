PSOCOSTP ;BHAM-ISC/SAB - Purges data from drug cost file (#50.9) ; 05/12/94 8:20
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
 I '$O(^PSCST(0)) W !,$C(7),"There is NO cost Data to be Purged !",! K ^PSOCST("B") Q
ST K ZTSK,ZTQUEUED,%DT S Y=$O(^PSCST(0)) D DD^%DT S DEF=Y
BEG W ! S %DT("A")="Purge Cost Data Starting: ",%DT="AEP",%DT("B")=DEF D ^%DT G:"^"[X EX G:Y<0 BEG S (%DT(0),BDT)=Y
END K %DT("B"),DEF S %DT("A")="Purge Cost Data Ending: ",%DT="AEP" D ^%DT G:"^"[X EX G:Y<0 END S EDT=Y
 W ! K DIR S DIR("A",1)="Are you sure you want to purge cost data",DIR("A")="from "_$E(BDT,4,5)_"/"_$E(BDT,6,7)_"/"_$E(BDT,2,3)_" to "_$E(EDT,4,5)_"/"_$E(EDT,6,7)_"/"_$E(EDT,2,3),DIR(0)="Y",DIR("B")="NO" D ^DIR
 G:$D(DTOUT)!($D(DUOUT)) EX I 'Y G ST
 W ! K DIR S DIR("A")="Do you want this option to run IMMEDIATELY or QUEUED? ",DIR(0)="SA^1:QUEUED;0:IMMEDIATELY",DIR("B")="Q" D ^DIR
 G:$D(DTOUT)!($D(DUOUT)) EX I 'Y D WAIT^DICD G EN
 S ZTRTN="EN^PSOCOSTP",ZTDESC="Outpatient Pharmacy Drug Cost file (50.9) Purge Option",ZTIO="",ZTSAVE("BDT")="",ZTSAVE("EDT")="" D ^%ZTLOAD W:$D(ZTSK) !,"Task #"_ZTSK_" QUEUED.",! G EX
EN S DIK="^PSCST(",PDT=BDT-1 F  S PDT=$O(^PSCST(PDT)) Q:'PDT!(PDT>EDT)  S DA=PDT D ^DIK W:'$D(ZTQUEUED) "."
EX K Y,X,T,%DT,DIR,BDT,EDT,PDT,DUOUT,DTOUT S:$D(ZTQUEUED) ZTREQ="@"
 Q
