PSGWEXR ;BHAM ISC/CML-Drug Expiration Date Report by Selected Date Range/AOU ; 26 Oct 95 8:12AM
 ;;2.3; Automatic Replenishment/Ward Stock ;**5,6**;4 JAN 94
BDT S %DT="AEXT",%DT("A")="BEGINNING date for report: " D ^%DT K %DT G:Y<0 QUIT S BDT=Y
EDT S %DT="AEXT",%DT(0)=BDT,%DT("A")="ENDING date for report: " D ^%DT K %DT G:Y<0 QUIT S EDT=Y
 S LPDT=BDT I BDT#100=1 S LPDT=LPDT-1
 I '$O(^PSI(58.1,"AEXP",LPDT-1))!($O(^PSI(58.1,"AEXP",LPDT-1))>EDT) W *7,!!,"NO DATA FOUND FOR THIS DATE RANGE!",! G BDT
EN D SEL^PSGWUTL1 G:'$D(SEL) QUIT I SEL="I" F JJ=0:0 S JJ=$O(AOULP(JJ)) Q:'JJ  I $S('$D(^PSI(58.1,JJ,"I")):0,'^("I"):0,^("I")>DT:0,1:1) K AOULP(JJ)
 G:SEL="I" AOUCNT
ASKAOU ;
 F JJ=0:0 S DIC="^PSI(58.1,",DIC(0)="QEAM",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,^(""I"")>DT:1,1:0)" D ^DIC K DIC Q:Y<0  S AOULP(+Y)=""
 I '$D(AOULP)&(X'="^ALL") G QUIT
 I X="^ALL" F AOU=0:0 S AOU=$O(^PSI(58.1,AOU)) Q:'AOU  I $S('$D(^PSI(58.1,AOU,"I")):1,'^("I"):1,^("I")>DT:1,1:0) S AOULP(AOU)=""
AOUCNT G:'$D(AOULP) QUIT S LOCFLG=0 S JJ="" F CNT=0:1 S JJ=$O(AOULP(JJ)) Q:'JJ  S AOULP(JJ)=$P(^PSI(58.1,JJ,0),"^",6) S:AOULP(JJ) LOCFLG=1
 ;SORT=1 - DATE/DRUG/AOU  SORT=2 - DATE/AOU/DRUG
 S SORT="" I CNT>1 W !!?5,"Since you have chosen multiple AOUs,",!?5,"please select a sort order for the report:",!!?5,"(1) Date/Drug/AOU  or (2) Date/AOU/Drug" D ASKSORT
 G:SORT="^" QUIT
 W !!,"The right margin for this report is 80.",!,"You may queue the report to print at a later time.",!!
DEV K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G QUIT
 I $D(IO("Q")) K IO("Q") S PSGWIO=ION,ZTIO="" K ZTSAVE,ZTDTH,ZTSK
 I  S ZTRTN="START^PSGWEXR",ZTDESC="Print Drug Expiration Date Report" S:$D(AOULP) ZTSAVE("AOULP(")="" F G="BDT","EDT","CNT","PSGWIO","SORT","SEL","IGDA","LOCFLG","LPDT" S:$D(@G) ZTSAVE(G)=""
 I  D ^%ZTLOAD,HOME^%ZIS K ZTSK G QUIT
 U IO
 ;
START ;ENTRY POINT WHEN QUEUED
 K ^TMP("PSGWEXR",$J)
 F EXDT=LPDT-1:0 S EXDT=$O(^PSI(58.1,"AEXP",EXDT)) Q:'EXDT  Q:EXDT>EDT  F DRG=0:0 S DRG=$O(^PSI(58.1,"AEXP",EXDT,DRG)) Q:'DRG  F AOU=0:0 S AOU=$O(^PSI(58.1,"AEXP",EXDT,DRG,AOU)) Q:'AOU  I $D(AOULP(AOU)) D SET
 I '$D(ZTQUEUED) G:LOCFLG PRINT^PSGWEXR2 G:'LOCFLG PRINT^PSGWEXR1
PRTQUE ;AFTER DATA IS COMPILED, QUEUE THE PRINT
 K ZTSAVE,ZTIO S ZTIO=PSGWIO,ZTRTN=$S(LOCFLG:"PRINT^PSGWEXR2",1:"PRINT^PSGWEXR1"),ZTDESC="Print Drug Expiration Date Report",ZTDTH=$H,ZTSAVE("^TMP(""PSGWEXR"",$J,")=""
 S:$D(AOULP) ZTSAVE("AOULP(")="" F G="BDT","EDT","CNT","SORT","SEL","IGDA" S:$D(@G) ZTSAVE(G)=""
 D ^%ZTLOAD K ^TMP("PSGWEXR",$J)
QUIT K %,%H,%I,%Z,AOU,AOULP,AOUNM,BDT,DRG,DRGNM,EDT,EXDT,HDT,HH,JJ,LOC,LOCFLG,LN,LPDT,PG,SEL,IGDA,X,Y,CNT,SORT,P1,PSGWIO,P2,G,TAB,ZTSK,IO("Q") D ^%ZISC
 Q
SET ;
 S DRGNM=$S($D(^PSDRUG(DRG,0)):$P(^(0),"^"),1:"DRUG NAME MISSING"),AOUNM=$S($D(^PSI(58.1,AOU,0)):$P(^(0),"^"),1:"AOU NAME MISSING")
 S:SORT=1!(CNT<2) ^TMP("PSGWEXR",$J,EXDT,DRGNM,AOUNM)=AOU S:SORT=2 ^TMP("PSGWEXR",$J,EXDT,AOUNM,DRGNM)=AOU Q
ASKSORT ;
 F JJ=0:0 R !!,"Enter '1' or '2' or ""^"" to Exit ==> ",SORT:DTIME S:'$T SORT="^" Q:"^"[SORT  Q:SORT=1!(SORT=2)  D HELP
 S:SORT="" SORT="^" Q
HELP ;
 W:SORT'?."?" *7," ??" W !!,?5,"Enter '1' to sort by Expiration Date, then Drug, then AOU.",!?5,"Enter '2' to sort by Expiration Date, then AOU, then Drug.",!?5,"Enter ""^"" to Exit." Q
