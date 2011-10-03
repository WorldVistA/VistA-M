PSGWAR ;BHAM ISC/PTD,CML-Print AMIS Report ; 14 Feb 1989  1:36 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 I $O(^PSI(58.5,"B",0)) S Y=$O(^(0)) X ^DD("DD") W !,"Earliest date for which you have AMIS data is: ",Y,!!
 I $D(^PS(59.7,1,50)),^(50)]"" S Y=^(50),UPDT=$P(Y,".") X ^DD("DD") W $P(Y,"@")," at ",$P(Y,"@",2)," is the last date that AMIS Statistics",!,"were updated by the nightly TaskMan routine.",!!
 S X1=DT,X2=$S($D(UPDT):UPDT,1:"") D ^%DTC I X>2 W *7,*7,!?24,"** WARNING **",!,"Please contact ADP and request that Taskmanager option",!,"""PSGW UPDATE AMIS STATS"" be RESCHEDULED to run nightly.",!!
BDT S %DT="AEX",%DT("A")="BEGINNING date for AMIS report: " D ^%DT K %DT G:Y<0 END^PSGWAR1 S BDT=Y
EDT S %DT="AEX",%DT(0)=BDT,%DT("A")="ENDING date for AMIS report: " D ^%DT K %DT G:Y<0 END^PSGWAR1 S EDT=Y
 I '$O(^PSI(58.5,"B",BDT-1)) W !!,"There is NO data in the AMIS Stats file for selected dates." G END^PSGWAR1
 I $O(^PSI(58.5,"AEX",BDT-1)),$O(^PSI(58.5,"AEX",BDT-1))'>EDT W !!,"There are AMIS exceptions for the dates you selected.",!,"You MUST use the Incomplete AMIS Data option",!,"to supply missing data before AMIS will run!",!! G END^PSGWAR1
 I $O(^PSI(58.5,"AMISERR",0)) D ERRCHK I $O(AOU(0)) G END^PSGWAR1
 W !!,"The right margin for this report is 132.",!,"You may queue the report to print at a later time.",!!
DEV K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END^PSGWAR1
 I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^PSGWAR1",ZTDESC="Print AMIS Report" F G="BDT","EDT" S:$D(@G) ZTSAVE(G)=""
 I  D ^%ZTLOAD,HOME^%ZIS K ZTSK G DONE^PSGWAR1
 U IO G ENQ^PSGWAR1
 ;
ERRCHK ;
 F AOU=0:0 S AOU=$O(^PSI(58.5,"AMISERR",AOU)) Q:'AOU  S CURDT="" F LL=0:0 S CURDT=$O(^PSI(58.5,"AMISERR",AOU,CURDT)) Q:CURDT=""  F ADT=0:0 S ADT=$O(^PSI(58.5,"AMISERR",AOU,CURDT,ADT)) Q:'ADT  I ADT>BDT&(ADT'>EDT) S AOU(AOU)=""
 I '$O(AOU(0)) K AOU,CURDT,LL,ADT Q
 W !!,"The following AOU(s) have AMIS activity for the date range you have selected,",!,"but do NOT have a valid INPATIENT SITE designation:",! F AOU=0:0 S AOU=$O(AOU(AOU)) Q:'AOU  W !?5,$P(^PSI(58.1,AOU,0),"^")
 W !!,"The AMIS Report cannot be printed until the INPATIENT SITE field is edited",!,"for the listed AOU(s) and the TASKMAN job to update the AMIS Stats file,",!,"""PSGW UPDATE AMIS STATS"" is run."
 Q
