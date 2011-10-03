PSGWTOT ;BHAM ISC/PTD,CML-Usage Report for an Item ; 19 Mar 93 / 8:35 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;**16**;4 JAN 94
 W !,"Usage Report may be printed for:",!?15,"a single item for one AOU,",!?15,"a single item for ALL AOUs,",!?15,"ALL items for one AOU, or",!?15,"ALL items for ALL AOUs.",!!
 W !,"To select all AOUs, enter ""^ALL"" at the",!,"""Select PHARMACY AOU STOCK AREA OF USE (AOU):"" prompt.",!,"To select all items, enter ""^ALL"" at the ""Select ITEM:"" prompt.",!!
BDT S %DT="AEX",%DT("A")="BEGINNING date for report: " D ^%DT K %DT G:Y<0 END S BDT=Y
EDT S %DT="AEX",%DT(0)=BDT,%DT("A")="ENDING date for report: " D ^%DT K %DT G:Y<0 END S EDT=Y
ASKAOU S DIC="^PSI(58.1,",DIC(0)="QEAM" D ^DIC K DIC G:(Y<0)&(X'="^ALL") END
 I X'="^ALL" S AOU=+Y,AOUFL=0
 E  S AOU=0,AOUFL=1
ASKITEM I AOUFL=1 S DIC="^PSDRUG(",DIC(0)="QEAOM",DIC("A")="Select ITEM: ",DIC("S")="I $S('$D(^(""I"")):1,+^(""I"")>DT:1,1:0)" D ^DIC K DIC G:(Y<0)&(X'="^ALL") END S:X'="^ALL" ITNAM=$P(Y,"^",2),ITMFL=0,DRGNM=$P(Y,"^")
 ;VMP IOFO BAY PINES;ELR;PSGW*2.3*16
 I AOUFL=0 S DIC="^PSI(58.1,AOU,1,",DIC(0)="QEAM",D="B" D IX^DIC K DIC G:(Y<0)&(X'="^ALL") END S:X'="^ALL" ITMFL=0,DRGNM=$P(Y,"^",2)
 I (AOUFL=0)&(X'="^ALL") I '$O(^PSDRUG(DRGNM,0)) S DIK="^PSI(58.1,"_AOU_",1,",DA=$P(Y,"^"),DA(1)=AOU D ^DIK K DIK W " ??",*7,*7 G ASKITEM
 I (AOUFL=0)&(X'="^ALL") S ITNAM=$P(^PSDRUG(DRGNM,0),"^")
 I X="^ALL" S ITNAM=0,ITMFL=1
 W !!,"The right margin for this report is 80.",!,"You may queue the report to print at a later time.",!!
DEV K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q") S PSGWIO=ION,ZTIO="" K ZTSAVE,ZTDTH,ZTSK S ZTRTN=$S(ITMFL=1:"ENQ^PSGWTOT1",1:"ENQ^PSGWTOT2"),ZTDESC="Compile Usage Report" F G="BDT","EDT","AOU","AOUFL","ITNAM","ITMFL","DRGNM","PSGWIO" S:$D(@G) ZTSAVE(G)=""
 I  D ^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO G:ITMFL=1 ENQ^PSGWTOT1 G:ITMFL=0 ENQ^PSGWTOT2
 ;
END K AOU,AOUFL,BDT,DRGNM,EDT,ITNAM,ITMFL,PSGWIO,G,ZTIO,ZTSK,DA,X,Y,IO("Q")
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@" Q
