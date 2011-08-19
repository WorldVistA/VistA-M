PSGWPIS ;BHAM ISC/CML-Print AOU Inventory Sheet for a single AOU ; 29 Dec 93 / 9:15 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 I '$D(PSGWSITE) D ^PSGWSET Q:'$D(PSGWSITE)  S PSGWFLG=1
BAR S BARFLG=1 W !!,"This option will print a bar coded Inventory Sheet.  In order to do so, you",!,"must queue the output to a printer that is properly set up to produce bar codes."
EN ; Entry point for no bar codes
 I '$D(PSGWSITE) D ^PSGWSET Q:'$D(PSGWSITE)  S PSGWFLG=1
 W !!,"This option will print an Inventory Sheet for a single AOU that is included in",!,"an existing Inventory Date/Time.",!
ASKINV S DIC="^PSI(58.19,",DLAYGO=58.19,DIC(0)="QEAMLNZ",DIC("A")="SELECT DATE/TIME FOR INVENTORY: " D ^DIC K DIC,DLAYGO G:Y<0 QUIT S PSGWIDA=+Y
 D LIST G:'$D(AOU) ASKINV W ! S DIC="^PSI(58.1,",DIC(0)="QEAM",DIC("S")="I $D(^PSI(58.19,PSGWIDA,1,""B"",+Y,+Y))",DIC("A")="Select AOU: " D ^DIC K DIC G:Y<0 QUIT S AOU=+Y
 W !!,"Right margin for this printout is 132!",!! S PSGWDT=DT
DEV K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G QUIT
 I $D(BARFLG),'$D(^%ZIS(2,^%ZIS(1,IOS,"SUBTYPE"),"BAR0"))!('$D(^%ZIS(2,^%ZIS(1,IOS,"SUBTYPE"),"BAR1"))) W *7,!!,"THE DEVICE YOU HAVE SELECTED IS NOT SET UP TO PRINT BAR CODES!!",! G DEV
 I $D(IO("Q")) K IO("Q") S ZTRTN="EN1^PSGWPIS",ZTDESC=$S($D(BARFLG):"Print Single Bar Coded Inventory Sheet",1:"Print Single Inventory Sheet") F G="PSGWIDA","PSGWDT","PSGWSITE","BARFLG","AOU","PRTFLG" S:$D(G) ZTSAVE(G)=""
 I  D ^%ZTLOAD,HOME^%ZIS K ZTSK G QUIT
EN1 U IO D EN1^PSGWPI1
QUIT K PSGW("PO"),PSG1,PSG2,PSG3,PSGDA,PSGDDA,PSGDR,PSGINAD,PSGNT,PSGPAGE,PSGSORTK,STKCHG,PSGTN,PSGTODAY,PSGWIDA,PSGWIN,PSGWN,PSGTYP,PSGWGRP,PSGWLP,PSGWPC,PSGD,PSGISORT,PSGLSORT,PSGSORT,PSGT,PSGW,PSGWDUP,PSGWN,PSGWPGD,PSI,PSGWDT,DIE,DR
 K CHK,GROUP,ZTSK,BARFLG,PSGWBARS,PSGWBAR0,PSGWBAR1,I,LOC,STLEV,DRGDA,J,K,G,K1,EXP,LN,LN1,LN2,LNCNT,TAB1,TAB2,TYPE,Q,LFC,SK,X,Y,MH,NN,AA,D1,DA,PSGSW,SKK,GRP,LP,PC,AOULP,AOU,JJ,AOUCNT,IO("Q") D ^%ZISC
 K:$D(PSGWFLG) PSGWFLG,PSGWSITE
 S:$D(ZTQUEUED) ZTREQ="@" Q
LIST ; List all the AOUs included in the inventory
 I '$O(^PSI(58.19,PSGWIDA,1,"B",0)) W *7,!,"There are not any AOUs defined for this Inventory!",! Q
 S AOUCNT=0 F AOU=0:0 S AOU=$O(^PSI(58.19,PSGWIDA,1,"B",AOU)) Q:'AOU  S AOULP($P(^PSI(58.1,AOU,0),"^"))="",AOUCNT=AOUCNT+1
 W !!,"The following AOU",$S(AOUCNT>1:"s are",1:" is")," included on this Inventory Sheet:" S AOU="" F JJ=0:0 S AOU=$O(AOULP(AOU)) Q:AOU=""  W !?5,AOU
 Q
