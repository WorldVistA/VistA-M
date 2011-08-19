PRCAEOL ;SF-ISC/YJK-EDIT INCOMPLETE OLD BILL ;2/28/95  10:35 AM
V ;;4.5;Accounts Receivable;**67,153**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;This edits incomplete old bill. The account is classified
 ;with category.
 ;
 ;===================== EDIT INCOMPLETE AR ===========================
EDIN ;edit incomplete accounts receivable.
 D CKSITE^PRCAUDT G:'$D(PRCA("SITE")) END
EN S DIC("S")="S Z0=$S($D(^PRCA(430.3,+$P(^(0),U,8),0)):$P(^(0),U,3),1:0) I Z0=106"
 D DIC^PRCAUDT G:'$D(PRCABN) END S PRCA("MESS1")="THE ACCOUNT IS STILL INCOMPLETE OLD BILL"
 K PRCADINO D EDT
 I $G(PRCABN)>0,$P(^PRCA(430,PRCABN,0),U,8)=$O(^PRCA(430.3,"AC",102,"")) D PREPAY^RCBEPAYP(PRCABN)
 D KILLV G EDIN
EDT D DIE Q:PRCA("LOCK")=1  I $D(PRCADINO),($P(^PRCA(430,PRCABN,0),U,2)="")!($P(^(0),U,9)="") S PRCADEL=1 Q
 I $D(PRCADINO) W !!,*7,PRCA("MESS1"),!! Q
 D COMMENTS^PRCAUT3 G:$D(PRCA("EXIT")) DIP1
DIP S PRCAT=+$P(^PRCA(430,PRCABN,0),U,2) D:$P(^PRCA(430.2,PRCAT,0),U,3)>0 SEGMT S PRCAT=$S($D(^PRCA(430.2,PRCAT,0)):$P(^(0),U,6),1:"") D DISPL S PRCAOK=0 D ASK1 G:$D(PRCA("EXIT")) DIP1
 I PRCAOK=1 G:'$D(PRCANM) DIP1 W !! D KILLV Q
 D ASK2 I PRCAOK=1 D DIE G DIP
DIP1 W !!,PRCA("MESS1"),! S PRCA("STATUS")=$O(^PRCA(430.3,"AC",106,"")) D UPSTATS^PRCAUT2 K PRCA("STATUS") D KILLV Q  ;end of EDIN
KILLV L -^PRCA(430,+$G(PRCABN))
 K PRCADEL,DIC,DR,DIE,PRCAT,PRCAGLN,PRCA("CKSITE"),PRCADINO,PRCAOK,PRCA("MESS1"),PRCA("EXIT"),PRCA("MESS2"),PRCAT,PRCANM,PRCADEL,PRCATY Q
END D KILLV K PRCABN,PRCAREF,PRCA Q
 ;======================= SUBROUTINES ================================
DIE K PRCAT W ! S DA=PRCABN,DIC="^PRCA(430,",PRCA("LOCK")=0 D LOCKF^PRCAWO1 Q:PRCA("LOCK")=1  S DIE=DIC,DR="[PRCA CAT SET]" D ^DIE I +$P(^PRCA(430,PRCABN,0),U,2)'>0 S PRCADINO="" Q
 I '$$ACCK^PRCAACC(PRCABN) W !!,*7,"This catergory of bill CAN NOT be re-established.",! S PRCADINO="" Q
 S PRCAT=$P(^PRCA(430.2,+$P(^PRCA(430,PRCABN,0),U,2),0),U,6),PRCAGLN=$P(^(0),U,4) S:$P(^(0),U,7)=24 PRCAT("C")=1
D1 S PRCAREF=1,DR="[PRCA OLD SET]" D ^DIE K DR
 I $P(^PRCA(430,PRCABN,0),U,9)'>0 W !,"Debtor input is not entered.",! S PRCADINO="" Q
 I +$P(^PRCA(430,PRCABN,0),U,5)'>0 W !,"'Bill Resulting From' input is not set.",! S PRCADINO="" Q
 Q
DISPL ;display the accounts receivable data user has entered.
 Q:'$D(PRCABN)  I '$D(IOF) S IOP="" D ^%ZIS
 S D0=PRCABN K ^UTILITY($J,"W") S PRCAIO=IO,PRCAIO(0)=IO(0) D PROC^PRCAPRO Q
ASK2 S %=2 W !!,"DO YOU WANT TO EDIT THE DATA" D YN^DICN Q:(%<0)!(%=2)
 I %=0 W "   ANSWER 'Y'(YES) OR 'N'(NO)" G ASK2
 S PRCAOK=1 Q
ASK1 S %=2 W !!,"IS THIS DATA CORRECT" D YN^DICN I %<0 S PRCA("EXIT")="" Q
 I %=0 W "   ANSWER 'Y'(YES) OR 'N'(NO)" G ASK1
 Q:%'=1  I $P(^PRCA(430,PRCABN,0),U,8)=$O(^PRCA(430.3,"AC",106,"")) W !,"This account has an 'OLD BILL' status and should be edited.",! S PRCAOLD="",DIE="^PRCA(430,",DA=PRCABN,DR="8" D ^DIE K DIE,DR,PRCAOLD
 I $P(^PRCA(430,PRCABN,0),U,8)=$O(^PRCA(430.3,"AC",106,"")) W !,"This account still has an 'OLD BILL' status." Q
 S $P(^PRCA(430,PRCABN,9),U,6)=$O(^PRCA(430.3,"AC",106,""))
 S PRCAOK=1,DA=PRCABN D SIG^PRCASIG,NOW^%DTC
 I $D(PRCANM) S $P(^PRCA(430,PRCABN,9),U,1,3)=+DUZ_U_PRCANM_U_%
 Q
DELETE ;delete new AR which has no category and debtor field.
 S PRCACOMM="USER CANCELED" D DELETE^PRCABIL4 K PRCACOMM
 W *7,!,"The accounts receivable has been deleted!",! Q
SEGMT ;save segment number in the file 430 for AMIS report.
 Q:'$D(PRCAT)!$P(^PRCA(430,PRCABN,0),"^",21)  N PRCARI,Y
 S PRCARI=$O(^PRCA(430.2,"AC",21,0))
 I PRCAT=PRCARI S X=PRCABN D:$D(^DGCR(399,PRCABN)) ^IBCAMS S:'$D(^DGCR(399,PRCABN)) Y=297
 S:'$D(Y) Y=-1 S %=$S(PRCARI=PRCAT&(Y<1):"0",PRCARI=PRCAT:Y,$D(^PRCA(430.2,PRCAT,0)):$P(^(0),U,3),1:"0")
 I %=240 S %=$S($P(^PRCA(430,PRCABN,0),U,16)>0:$P(^PRCA(430.2,$P(^PRCA(430,PRCABN,0),U,16),0),U,3),1:%)
 S $P(^PRCA(430,PRCABN,0),U,21)=% K %,PRCARI,Y Q
