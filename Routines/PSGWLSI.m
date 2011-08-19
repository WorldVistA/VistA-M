PSGWLSI ;BHAM ISC/PTD,CML-List Active Stock Items for AOU(s) ; 05/25/90 8:50
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 D SEL^PSGWUTL1 G:'$D(SEL) END I SEL="I" F JJ=0:0 S JJ=$O(AOULP(JJ)) Q:'JJ  I $S('$D(^PSI(58.1,JJ,"I")):0,'^("I"):0,^("I")>DT:0,1:1) K AOULP(JJ)
 G:SEL="I" START
ASKAOU F JJ=0:0 S DIC="^PSI(58.1,",DIC(0)="QEAM",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,^(""I"")>DT:1,1:0)" D ^DIC K DIC Q:Y<0  S AOULP(+Y)=""
 I '$D(AOULP)&(X'="^ALL") G END
 I X="^ALL" F AOU=0:0 S AOU=$O(^PSI(58.1,AOU)) Q:'AOU  I $S('$D(^PSI(58.1,AOU,"I")):1,'^("I"):1,^("I")>DT:1,1:0) S AOULP(AOU)=""
START G:'$D(AOULP) END W !!,"You may print by either of these sorting methods:",!?5,"(1)  By TYPE/LOCATION/ITEM",!?5,"(2)  Alphabetical by ITEM"
SRTBY W !!,"Select SORT ORDER for report (enter 1 or 2): " R ANS:DTIME S:'$T ANS="^" G:"^"[ANS END
 I ANS'=1&(ANS'=2) W *7,!!,"Enter ""1"" if you wish to print the AOU stock list sorted",!,"by type, and within type by location.",!,"Enter ""2"" to print the AOU stock list alphabetically." G SRTBY
 W !!,"The right margin for this report is 132.",!,"You may queue the report to print at a later time.",!!
DEV K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q") S ZTRTN=$S(ANS=1:"ENQ^PSGWLSI1",1:"ENQ^PSGWLSI2"),ZTDESC="List Stock Items" S:$D(AOULP) ZTSAVE("AOULP(")="" F G="AOU","ANS","SEL","IGDA" S:$D(@G) ZTSAVE(G)=""
 I  D ^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO G:ANS=1 ENQ^PSGWLSI1 G:ANS=2 ENQ^PSGWLSI2
 ;
END K JJ,X,Y,ZTSK,AOU,AOULP,ANS,G,SEL,IGDA,IO("Q")
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@" Q
