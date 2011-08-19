ONCOSA ;Hines OIFO - ANNUAL CROSS TABS-CANNED REPORTS ;9/3/93
 ;;2.11;ONCOLOGY;**1,44**;Mar 07, 1995
ACT ;ANNUAL CROSS TABS
 W @IOF,!!!?21,"CROSS TABS for ANNUAL Reports"
 W !?25,"requires definition of"
 W !?22,"YEAR and Row for all TABLES"
Y S BYR=$O(^ONCO(165.5,"AY",0)) F YR=$E(DT,1)+17_$E(DT,2,3)-1:-1:BYR-1 S EYR=$O(^ONCO(165.5,"AY",YR)) Q:EYR'=""
 ;
A W !! K DIR S YR=$E(DT,1)+17_$E(DT,2,3),DIR("A")="     Select YEAR for Cross Tab Reports",DIR("B")=$E(DT,1)+17_$E(DT,2,3)-1,DIR(0)="N^"_BYR_":"_EYR D ^DIR G EX:Y["^"!(Y=""),A:Y>YR,A:Y'?1.N S ONCOS("YR")=Y_"^"_Y
ST W !! K DIR S DIR(0)="L^"_BYR_":"_EYR,DIR("A")="     Specify Time Frame for Total Registry" D ^DIR Q:Y["^"!(Y="")  S N=$L(Y,",")-1,Y1=$P(Y,","),Y2=$P(Y,",",N)
 ;TASK RANGE
 W !!?20,"Year for Annual Report is: ",+ONCOS("YR"),!!?20,"Complete Registry is "_Y1_" to "_Y2,!! K DIR S DIR("A")="    Definitions OK",DIR(0)="Yes",DIR("B")="Y" D ^DIR Q:Y="^"!(Y="")  G A:Y=0 S ONCOS("RG")=Y1_"^"_Y2
 ;
ROW ;SELECT ROW
 K DIR S DIR("A")="     Select Row",DIR(0)="SO^1:PRIMARY SITE/GP;2:ICDO-SITE;3:ICDO-TOPOGRAPHY;4:SELECTED SITES;5:SYSTEMS" D ^DIR G EX:Y="^"!(Y="") S ONCOS("R")=$P($P(DIR(0),";",Y),":",2)
 K DIR S DIR("A")="      Percentages",DIR(0)="Y" W ! D ^DIR G EX:Y="^"!(Y="") S ONCOS("P")=$S(Y=0:"",1:1)
QUE ;QUE to run report
 W !!!?10,"-QUE ('Q') to run this report at night.",!?10,"-Ask your IRM for the appropriate time.",!!
 K IO("Q"),IOP S %ZIS="Q",%ZIS("A")="     Select Device to Print Annual Cross Tabs: " D ^%ZIS S IOP=ION I POP S ONCOUT="" G EX
 I '$D(IO("Q")) D TSK^ONCOSA1 G EX
 S ONCOION=ION,ONCOIOM=IOM,ZTSAVE("ONCOION")="",ZTSAVE("ONCOIOM")="",ZTRTN="TSK^ONCOSA1",ZTDESC="ONCOLOGY ANNUAL CROSS TABS",ZTSAVE("ONCOS*")="" D ^%ZTLOAD K ZTSK G EX
 ;
EX ;EXIT TASK
 K DIR,ONCOS,RG,CT,YR,BYR,EYR,CC,G,GLO,HEAD,J,NM,O11,OC,OS,OT,RC,ROWDEF
 K SX,T,TX,W,Y2,%DT,%T,%ZISOS,Y2,ONCOIOM,ONCOION
 Q
