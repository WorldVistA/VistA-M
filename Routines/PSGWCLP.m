PSGWCLP ;BHAM ISC/CML-Clear AMIS Exceptions Print ; 17 Aug 93 / 9:04 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
ASK ;ASK TO PRINT WORKSHEET
 W !!,"Do you want to print a worksheet first" S %=2 D YN^DICN Q:%=2!(%<0)
 I '% W !?5,"Enter:",!?7,"""YES"" if you wish to print a worksheet of the drugs with incomplete data.",!?7,"""NO"" or ""^"" if you do not want to print a worksheet." G ASK
 W !!,"The right margin for this worksheet is 80",!,"You may queue it to run at a later time.",!!
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR WORKSHEET PRINTED!!" Q
 I $D(IO("Q")) K IO("Q") S QUEFLG=1,ZTRTN="EN^PSGWCLP",ZTDESC="Print Incomplete AMIS Data Worksheet" F G="BDT","EDT" S:$D(@G) ZTSAVE(G)=""
 I  D ^%ZTLOAD,HOME^%ZIS K ZTSK G QUIT
 U IO
EN ;
 S PG=0,MSG=0,Y=BDT X ^DD("DD") S HBDT=Y,Y=EDT X ^DD("DD") S HEDT=Y S HDT=$$PSGWDT^PSGWUTL1,$P(LN,"-",80)="" D HDR
 F AMDT=BDT-1:0 S AMDT=$O(^PSI(58.5,"AEX",AMDT)) Q:'AMDT!(AMDT>EDT)  F SITE=0:0 S SITE=$O(^PSI(58.5,"AEX",AMDT,SITE)) Q:'SITE  F DRG=0:0 S DRG=$O(^PSI(58.5,"AEX",AMDT,SITE,DRG)) Q:'DRG  D SET
DONE I $E(IOST)'="C" W @IOF
QUIT K %,%H,%I,ACAT,ACON,AMDT,DISP,DRG,DRGDA,DRGNM,HBDT,HDT,HEDT,LN,LOC,LOC1,LOC2,MSG,PG,POU,SITE,X,Y,IO("Q"),ZTSK
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@" Q
SET ;
 Q:'$D(^PSI(58.5,AMDT,"S",SITE,"DRG",DRG,0))
 S DRGDA=+^PSI(58.5,AMDT,"S",SITE,"DRG",DRG,0) Q:$D(LOC(DRGDA))  S (DRGNM,LOC1,LOC2)="" I DRGDA,$D(^PSDRUG(DRGDA,0)) S DRGNM=$P(^(0),"^") S:$D(^PSDRUG(DRGDA,660)) LOC1=^(660) S:$D(^PSDRUG(DRGDA,"PSG")) LOC2=^("PSG")
 Q:DRGNM=""  S POU=$P(LOC1,"^",3),DISP=$P(LOC1,"^",5),ACAT=$P(LOC2,"^",2),ACON=$P(LOC2,"^",3)
 I POU'="",DISP'="",ACAT'="",ACON'="" S MSG=1
PRT ;WRITE DATA LINES
 S LOC(DRGDA)="" D:$Y+5>IOSL HDR W !!,"=> ",DRGNM I MSG D CHKDATA
 W !!?23,$S(POU:$J(POU,8,2),1:"__________"),?39,$S(DISP:$J(DISP,7),1:"_______")
 W ?52,$S(ACAT'="":$J(ACAT,6),1:"_______"),?65,$S(ACON:$J(ACON,6),1:"_______") Q
HDR ;
 W:$Y @IOF S PG=PG+1 W !,"INCOMPLETE AMIS DATA WORKSHEET",?72,"PAGE ",PG,!,"FOR PERIOD ",HBDT," to ",HEDT,?61,HDT,!!,"=> DRUG",?23,"PRICE PER",?35,"DISPENSE UNITS",?51,"AR/WS AMIS",?63,"AR/WS AMIS"
 W !?23,"ORDER UNIT",?35,"PER ORDER UNIT",?51,"CATEGORY",?63,"CONVERSION #",!,LN
 Q
CHKDATA ;
 W !?5,"** It appears that the missing data for this drug has been supplied.",!?5,"** Please verify the data when editing this drug." S MSG=0 Q
