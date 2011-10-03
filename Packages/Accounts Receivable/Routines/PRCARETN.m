PRCARETN ;SF-ISC/YJK-RETURN BILL TO THE SERVICE ;10/17/96  5:39 PM
V ;;4.5;Accounts Receivable;**57**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
RETN Q:'$D(DUZ)
RET1 S DIC("S")="I +$G(^PRCA(430,Y,100)) S Z0=$S($D(^PRCA(430.3,+$P(^PRCA(430,Y,0),U,8),0)):$P(^(0),U,3),1:0) I Z0=102"
 W ! D BILLN^PRCAUTL G:'$D(PRCABN) END D RET2,KILLV G RET1
RET2 S %=2 W !,"Are you sure you want to return this bill to the Service " D YN^DICN
 I %=0 W !,"Answer 'Y' or 'YES' if you want to return this bill to the service that originated it, answer 'N' or 'NO' if not",! G RET2
 Q:%'=1
 K PRCAQRET S DA=PRCABN,DR="[PRCAF RETURN BILL]",(DIC,DIE)="^PRCA(430," D LCK^PRCAUPD I '$D(DA) D KILLV Q
 D ^DIE I $D(PRCAQRET) S PRCA("STATUS")=$O(^PRCA(430.3,"AC",230,"")),PRCA("SDT")=DT,PRCASV("STATUS")=1 D UPSTATS^PRCAUT2,EN1 K PRCASV("STATUS")
 Q
EN1 D SETTR^PRCAUTL Q:'$D(PRCAEN)  S DIE="^PRCA(433,",DA=PRCAEN,DR=".03////"_PRCABN_";12////"_PRCA("STATUS")_";3////0;4////2" D ^DIE
 S $P(^PRCA(433,PRCAEN,8),U,1,5)=$P($G(^PRCA(430,PRCABN,7)),U,1,5),$P(^PRCA(433,PRCAEN,8),U,6)=$P(^PRCA(430,PRCABN,3),U,6)
 S $P(^PRCA(433,PRCAEN,1),U,1)=$P(^PRCA(430,PRCABN,3),U,1),$P(^PRCA(433,PRCAEN,1),U,5)=$P($G(^PRCA(430,PRCABN,7)),U,1)
 D PATTR^PRCAUTL,UNIT^PRCAUTL K PRCA Q
AMEND S DIC("S")="S Z0=$S($D(^PRCA(430.3,+$P(^(0),U,8),0)):$P(^(0),U,3),1:0) I Z0=110",DIC(0)="AEQM",DIC="^PRCA(430," D BILLN^PRCAUTL K DIC G:'$D(PRCABN) END D AMD1,END G AMEND
AMD1 D DISP
ASK1 S %=2 W !,"Is this correct " D YN^DICN G:%<0 MESS
 D MTCHK^PRCAUDT I $D(PRCA("EXIT")) K PRCA("EXIT") S %=2
 I %=1 D EN2 Q
 I %=0 D M1^PRCAMESG G ASK1
ASK2 S %=2 W !,"Do you want to return this bill to the service again " D YN^DICN I %=0 W !,"Answer 'Y' or 'YES' if you want to return this bill, answer 'N' or 'NO' if not.",! G ASK2
 I %=1 D RET2 Q
MESS W !,"You should audit this amended bill !" Q
EN2 D SETTR^PRCAUTL Q:'$D(PRCAEN)  S PRCA("STATUS")=$O(^PRCA(430.3,"AC",110,""))
 S DIE="^PRCA(433,",DA=PRCAEN,DR=".03////"_PRCABN_";12////"_PRCA("STATUS")_";3////0;4////2" D ^DIE K DR,DA,DIE
 S $P(^PRCA(433,PRCAEN,1),U,5)=$P(^PRCA(430,PRCABN,3),U,5),$P(^PRCA(433,PRCAEN,8),U,6)=$P(^PRCA(430,PRCABN,3),U,7),$P(^(1),U,1)=DT
 D PATTR^PRCAUTL,UNIT^PRCAUTL S PRCA("STATUS")=$O(^PRCA(430.3,"AC",102,"")),PRCA("SDT")=DT D UPSTATS^PRCAUT2,WR,PRT Q
PRT S %=1 W !,"Do you want to print the amended bill data " D YN^DICN Q:(%=2)!(%<0)
 I %=0 W !,"Answer 'Y' or 'YES' if you want to print the data, answer 'N' or 'NO' if not.",! G PRT
 S %ZIS="Q" D ^%ZIS Q:POP  I IO=IO(0) D DISP K %ZIS,IO("Q") Q
 I $D(IO("Q")) K ZTSAVE S ZTRTN="DISP^PRCARETN",ZTDTH=$H,ZTSAVE("PRCABN")=PRCABN,ZTDESC="Print Amended Bill" D ^%ZTLOAD K IO("Q"),ZTSAVE,ZTRTN,ZTDTH,%ZIS Q
 U IO D DISP D ^%ZISC Q
WR W !!,"OK!, The Bill is active now, you may need to do the following:"
 W ! F I=1:1:80 W "-"
 K I W !,"|  1. If the bill has been cancelled in the service, run the option",?79,"|"
 W !,"|",?6,"'Decrease Adjustment' to decrease the balance to 0. The",?79,"|"
 W !,"|",?6,"status of the bill will be changed to CANCELLATION automatically.",?79,"|",!,"|",?79,"|"
 W !,"|  2.  If the amended bill needs to change the original amount,",?79,"|",!,"|      use 'Adjustment to AR' option.",?79,"|",!,"|",?79,"|"
 W !,"|  3.  If the debtor's address has been changed in the amended bill,",?79,"|",!,"|      use 'Edit Debtor's Address' option.",?79,"|",!
 F I=1:1:80 W "-"
 K I W !! Q
DISP K DXS S D0=PRCABN D ^PRCATR2 K DXS Q
KILLV L -^PRCA(430,+$G(PRCABN)) K DR,DA,DIE,DIC
END K PRCABIL,PRCATY,PRCAEN,PRCA,PRCABN,PRCAQRET Q
