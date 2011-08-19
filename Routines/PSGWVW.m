PSGWVW ;BHAM ISC/PTD,CML-Lookup Item and List Wards/AOUs Which Stock It ; 29 Dec 93 / 2:31 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 W !!,"Using this option, you may look up the wards and/or Areas of Use",!,"which stock the item you select.",!!,"The right margin for this report is 80.",!,"You may queue the report to print at a later time.",!!
DIC S DIC="^PSDRUG(",DIC(0)="QEAOM",DIC("A")="Select ITEM Name: " D ^DIC K DIC G:Y<0 END S DRGNUM=+Y
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED." G END
DEV I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^PSGWVW",ZTDESC="Print Ward/AOU List for Item" S ZTSAVE("DRGNUM")=""
 I  D ^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
ENQ ;ENTRY POINT WHEN QUEUED
 S AOU=0 K ^TMP("PSGWITEM",$J) S $P(LN,"-",80)=""
AOULP S AOU=$O(^PSI(58.1,AOU)) G:'AOU PRINT S AOUN=$P(^PSI(58.1,AOU,0),"^") I $D(^PSI(58.1,AOU,"I")),^("I")]"",^("I")'>DT S AOUN=AOUN_"^"_"I"
DRGLP I $D(^PSI(58.1,AOU,1,"B",DRGNUM)) D CHKDRG
 G AOULP
 ;
CHKDRG S DRGDA=0,DRGDA=$O(^PSI(58.1,AOU,1,"B",DRGNUM,DRGDA))
 I $P(^PSI(58.1,AOU,1,DRGDA,0),"^",10)="Y",$P(^(0),"^",3)="" S $P(^(0),"^",10)=""
 Q:$P(^PSI(58.1,AOU,1,DRGDA,0),"^",3)'=""
 S LOCN=$S($P(^PSI(58.1,AOU,1,DRGDA,0),"^",8)'="":$P(^(0),"^",8),1:"NOT LISTED") S STLEV=$S($P(^PSI(58.1,AOU,1,DRGDA,0),"^",2)'="":$P(^(0),"^",2),1:"NOT LISTED")
 I '$O(^PSI(58.1,AOU,1,DRGDA,4,0)) S WARD=" ",^TMP("PSGWITEM",$J,DRGNUM,WARD,AOUN,LOCN,STLEV)="" Q
 S WRD=0 F J=0:0 S WRD=$O(^PSI(58.1,AOU,1,DRGDA,4,WRD)) Q:'WRD  S WARD=$S($D(^DIC(42,WRD,0)):$P(^(0),"^"),1:"NOT FOUND") S ^TMP("PSGWITEM",$J,DRGNUM,WARD,AOUN,LOCN,STLEV)=""
 Q
 ;
PRINT ;
 S DRG=0,QFLG="" D HDR1 I '$O(^TMP("PSGWITEM",$J,0)) W !!,$P(^PSDRUG(DRGNUM,0),"^")," is not a Ward Stock/Auto Replenishment item." G DONE
LOOP S DRG=$O(^TMP("PSGWITEM",$J,DRG)) G:'DRG MSG G:QFLG END S DRGNAM=$P(^PSDRUG(DRG,0),"^"),WARD="" D HDR2
WD S WARD=$O(^TMP("PSGWITEM",$J,DRG,WARD)),AOUN="" G:WARD="" LOOP I $Y+5>IOSL D PRTCHK G:QFLG END W !
 W WARD
AOU S AOUN=$O(^TMP("PSGWITEM",$J,DRG,WARD,AOUN)),LOCN="" G:AOUN="" WD W ?28,$P(AOUN,"^") I $P(AOUN,"^",2)="I" S INACT=1 W "  *"
LOC S LOCN=$O(^TMP("PSGWITEM",$J,DRG,WARD,AOUN,LOCN)),STLEV="" G:LOCN="" AOU W ?56,LOCN
STK S STLEV=$O(^TMP("PSGWITEM",$J,DRG,WARD,AOUN,LOCN,STLEV)) G:STLEV="" LOC W ?70,$S(STLEV'="NOT LISTED":$J(STLEV,4),1:STLEV),!
 G STK
 ;
MSG I INACT W !!!,"* Indicates AOU is currently Inactive"
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST)="C" D:'QFLG SS^PSGWUTL1
END K ANS,QFLG,Y,LN,ZTSK,AOU,AOUN,DRG,DRGDA,DRGNAM,DRGNUM,INACT,J,LOCN,WARD,STLEV,WRD,^TMP("PSGWITEM",$J),IO("Q")
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@" Q
HDR1 ;
 S INACT=0
 W:$Y @IOF W !,"WARD/AOU LIST FOR AN ITEM",?60,"DATE: " S Y=DT X ^DD("DD") W Y,!,"ITEM NAME",!?70,"STOCK",!?10,"WARD",?35,"AREA OF USE",?56,"LOCATION",?70,"LEVEL",!,LN Q
HDR2 W !!,"==>",DRGNAM,!! Q
PRTCHK ;
 I INACT W !!,"* Indicates AOU is currently Inactive"
 I $E(IOST)="C" W !!,"Press <RETURN> to Continue or ""^"" to Exit: " R ANS:DTIME S:'$T ANS="^" D:ANS?1."?" HELP^PSGWUTL1 I ANS="^" S QFLG=1 Q
 D HDR1,HDR2 Q
