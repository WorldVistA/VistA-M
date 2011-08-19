PSGWPL ;BHAM ISC/MPH,CML-Print AOU Inventory Pick List ; 29 Dec 93 / 2:30 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 I '$D(PSGWSITE) D ^PSGWSET Q:'$D(PSGWSITE)  S PSGWFLG=1
 I $P(PSGWSITE,"^",5) W !!,?5,"You may not run the Pick List because you have the",!,?5,"""Merge Inventory Sheet and Pick List"" site parameter set to ""YES""." Q
DIC I '$D(PSGWIDA) S DIC="^PSI(58.19,",DIC(0)="QEAMNZ",DIC("A")="SELECT DATE/TIME FOR INVENTORY: " D ^DIC K DIC G:Y<0 END^PSGWPL0 S PSGWIDA=+Y
 I '$D(^PSI(58.19,"AINV",PSGWIDA)) W !!,"Pick List can't be run for inventory # ",PSGWIDA,!,"You must first print the inventory sheet",!,"using the Inventory Sheet Print Option.",! K PSGWIDA G DIC
 ;
EN1 ; PSGWIDA = DA of inventory being edited
 K PSGST,PSGW("PO") S PSGPAGE=1,Y=DT X ^DD("DD") S PSGTODAY=Y,NOPRT=0
RD R !,"Print total for each item on pharmacy pick list? Y// ",X:DTIME S:X=""&($T) X="Y" S:'$T X="^" G:"^"[$E(X) END^PSGWPL0 I "YyNn"'[$E(X) D HELP1 G RD
RD2 I "Nn"[$E(X) R !!,"Print sub-total for each item by AOU? Y// ",X1:DTIME S:X1="" (X1,PSGST)="Y" G:"^Nn"[$E(X1)!('$T) END^PSGWPL0 S:"Yy"[$E(X1) PSGST="Y" I "YyNn"'[$E(X1) D HELP2 G RD2
 W !,"Right margin for this printout is 132!",!! K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END^PSGWPL0
DEV I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^PSGWPL0",ZTDESC="Print Pick List" S:$D(PSGST) ZTSAVE("PSGST")="" F G="PSGWIDA","PSGTODAY","PSGWSITE","PSGPAGE","NOPRT" S ZTSAVE(G)=""
 I  D ^%ZTLOAD,HOME^%ZIS K ZTSK G END^PSGWPL0
 U IO G ENQ^PSGWPL0
 ;
HELP1 W !!,"Enter ""N"" or ""n"" for NO, or press return to accept the default answer of yes.",!,"Print total for each item on pharmacy pick list will give totals",!,"without showing sub-total breakdown for each area of use.",! Q
 ;
HELP2 W !!,"Enter ""N"" or ""n"" for NO, or press return to accept the default answer of yes.",!,"Print sub-total for each item by AOU will give a total to dispense,",!,"as well as a sub-total for each AOU requesting that item.",! Q
 ;
EN2 ;Print Pick List Headings
 W:$Y @IOF W !,"WARD STOCK PICK LIST FOR " S Y=PSGWIN X ^DD("DD") W ?26,Y,"  INVENTORY # ",PSGWIDA,?99,PSGTODAY,?120,"PAGE ",PSGPAGE
 I $P(^PSI(58.19,PSGWIDA,0),"^",4)="" W !!,"AOU INVENTORY GROUP MISSING" Q
 W !,"GROUP: " D WRTGRP^PSGWPI2
 I PSGPAGE=1 W !!,?83,"INVENTORIED BY ____________________________",!
 W !,?10,"ITEM",?51,"STOCK",?58,"QUICK",?71,"ON",?91,"BACKORDERED",?106,"TO BE",?115,"ACT DISPENSED"
 W !,?51,"LEVEL",?58,"CODE",?71,"HAND",?105,"DISPENSED",?115,"IF < TO BE",!
 F I=1:1:132 W "-"
 S PSGPAGE=PSGPAGE+1
 W !!,?12,$S($D(^PSI(58.1,PSGDA,0)):$P(^(0),"^"),1:"") I $D(^PSI(58.1,PSGDA,"I")),^("I")]"",^("I")'>DT W "   *** INACTIVE ***"
 Q
