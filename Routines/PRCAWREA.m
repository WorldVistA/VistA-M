PRCAWREA ;WASH-ISC@ALTOONA,PA/TJK-RE-ESTABLISH BILL ;7/24/96  2:35 PM
V ;;4.5;Accounts Receivable;**16,49,153**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;;Select bill to make active, cancellation, suspended, coll/clos or write-off
 N DA,DIC,DIE,I,PRCABN,PRCATAMT,PRCAEN,PRCA,PRCAWO,PRCAPB,PRCATYPE,PRCATY,X,Y,FMSNUM,FMSAMT,PRCASTAT
 D CKSITE^PRCAUDT I '$D(PRCA("CKSITE")) W !,"Your site is not defined." G EXIT
 K DIC,DA S PRCAWO="," F I=109,240,111,108 S PRCAWO=$G(PRCAWO)_$O(^PRCA(430.3,"AC",I,0))_","
 I $G(PRCAWO)']"" W !,"Transaction Types not defined, please contact IRM." G EXIT
 S DIC("S")="I $P(^(0),U,2)'=26,"""_PRCAWO_"""[("",""_$P(^(0),U,8)_"","")" D BILLN^PRCAUTL G:$G(PRCABN)="" EXIT
 L +^PRCA(430,PRCABN):1 I '$T W !!,*7,"ANOTHER USER IS EDITING THIS BILL" G EXIT
 S PRCAPB=$G(^PRCA(430,PRCABN,7)),PRCASTAT=$P(^PRCA(430,PRCABN,0),U,8)
 S PRCATAMT=0 F I=1:1:5 S PRCATAMT=PRCATAMT+$P(PRCAPB,U,I)
 I PRCATAMT=0&('$$ACCK^PRCAACC(PRCABN)) D  G EXIT
  .W !!,*7,"A bill with ZERO dollars CANNOT BE RE-ESTABLISHED."
  .W !!,"Create a new bill."
  .Q
 S FMSAMT=PRCATAMT
 I PRCATAMT=0 D AMT I PRCATAMT'>0 W !!,"Sorry, no bill amount entered!" G EXIT
 D SETTR^PRCAUTL,UPCALM^PRCAWO,PATTR^PRCAUTL
 S PRCATYPE=$S($P(^PRCA(430,PRCABN,0),"^",8)=$O(^PRCA(430.3,"AC",240,0)):$O(^PRCA(430.3,"AC",18,0)),1:$O(^PRCA(430.3,"AC",250,0)))
 K DIC,DIE,DR,DA S (DIC,DIE)="^PRCA(433,",DA=PRCAEN,DR="[PRCA RE-ESTABLISH WRITE-OFF]" D ^DIE K DIC,DA,DIE,DR
 S PRCA("SDT")=DT,PRCA("STATUS")=$O(^PRCA(430.3,"AC",102,0)) D UPSTATS^PRCAUT2
 S $P(^PRCA(433,PRCAEN,4,$O(^PRCA(433,PRCAEN,4,0)),0),U,5)=PRCATAMT
 S $P(^PRCA(433,PRCAEN,0),U,4)=2 L -^PRCA(430,PRCABN)
 W !!,*7,?5,$P(^PRCA(430,PRCABN,0),U,1)," is in the ",$P(^PRCA(430.3,$P(^PRCA(430,PRCABN,0),U,8),0),U,1)," status for $",$P(^PRCA(433,PRCAEN,1),U,5)
 I $P(^PRCA(430,PRCABN,0),U,8)=$O(^PRCA(430.3,"AC",102,"")) D PREPAY^RCBEPAYP(PRCABN)
 I FMSAMT>0,PRCASTAT'=40,'$$ACCK^PRCAACC(PRCABN) D
  .S FMSNUM=$P($G(^PRCA(430,PRCABN,11)),U,22),MOD=1
  .I FMSNUM="" S FMSNUM=$$ENUM^RCMSNUM,MOD=0
  .D MODWR^PRCAFWO(PRCABN,FMSAMT,FMSNUM,PRCAEN,MOD)
  .Q
EXIT Q
AMT ;
 ;;Ask for amount to be re-established
 N Y
AMTE R !!,"Enter Re-Establish Amount: ",Y:DTIME I '$T!(Y["^") S Y=0 G AMTQ
 I Y="" W !,*7,"The amount is required.  Enter ""^"" to exit!",!
 I Y["?"!(Y'?.N.1".".2N)!(Y>999999.99)!(Y<.01) D AMTH G AMTE
AMTQ S PRCATAMT=+Y I Y>0 S PRCAPB=PRCATAMT_"^^^^^",$P(^PRCA(430,PRCABN,7),U,1)=Y,$P(^PRCA(430,PRCABN,2,$O(^PRCA(430,PRCABN,2,0)),0),U,2)=PRCATAMT
 Q
AMTH W !,"Enter in an amount from .01 to 999999.99, 2 decimal digits"
 W !!,"The bill must have an amount inorder to be re-established."
 W !,"This amount will be the principal balance of the bill."
 Q
