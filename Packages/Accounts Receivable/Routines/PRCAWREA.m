PRCAWREA ;WASH-ISC@ALTOONA,PA/TJK-RE-ESTABLISH BILL ;7/24/96  2:35 PM
V ;;4.5;Accounts Receivable;**16,49,153,315**;Mar 20, 1995;Build 67
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Select bill to make active, cancellation, suspended, coll/clos or write-off
 N DA,DIC,DIE,I,PRCABN,PRCATAMT,PRCAEN,PRCA,PRCAWO,PRCAPB,PRCATYPE,PRCATY,X,Y,FMSNUM,FMSAMT,PRCASTAT
 D CKSITE^PRCAUDT I '$D(PRCA("CKSITE")) W !,"Your site is not defined." G EXIT
 K DIC,DA S PRCAWO="," F I=109,240,111,108 S PRCAWO=$G(PRCAWO)_$O(^PRCA(430.3,"AC",I,0))_","
 I $G(PRCAWO)']"" W !,"Transaction Types not defined, please contact IRM." G EXIT
 S DIC("S")="I $P(^(0),U,2)'=26,"""_PRCAWO_"""[("",""_$P(^(0),U,8)_"","")" D BILLN^PRCAUTL G:$G(PRCABN)="" EXIT
 ;
APJ ; Entry point from the ENAP entry point (below) for the Account Profile screen  *315
 ;
 L +^PRCA(430,PRCABN):1 I '$T W !!,*7,"ANOTHER USER IS EDITING THIS BILL" G EXIT
 S PRCAPB=$G(^PRCA(430,PRCABN,7)),PRCASTAT=$P(^PRCA(430,PRCABN,0),U,8)
 S PRCATAMT=0 F I=1:1:5 S PRCATAMT=PRCATAMT+$P(PRCAPB,U,I)
 I PRCATAMT=0&('$$ACCK^PRCAACC(PRCABN)) D  G EXIT
  .W !!,*7,"A bill with ZERO dollars CANNOT BE RE-ESTABLISHED."
  .W !!,"Create a new bill."
  .L -^PRCA(430,PRCABN)       ; *315 bug fix - unlock the bill before exit
  .Q
 S FMSAMT=PRCATAMT
 I PRCATAMT=0 D AMT I PRCATAMT'>0 W !!,"Sorry, no bill amount entered!" L -^PRCA(430,PRCABN) G EXIT    ; *315 unlock bill
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
 ;
ENAP(PRCABN) ; Entry point for Re-Establish bill from the Account Profile screen - *315
 ; originally called from REESTAB^RCDPAPL1.  PRCABN is the internal bill# and is required.
 ;
 N PG,PRS,I,PRCAWO,PRCATY,PRCA,PRCATAMT,PRCAEN,PRCAPB,PRCATYPE,PRCASTAT,FMSNUM,FMSAMT,MOD
 N DA,DIC,DIE,DR,X,Y
 ;
 ; set other variables related to the bill
 S PG=$G(^PRCA(430,PRCABN,0))
 S PRCATY=$P(PG,U,2)                                    ; ar category ien
 S PRCA("SEG")=$S(+$P(PG,U,21)>240:$P(PG,U,21),1:"")    ; segment - used in the input template
 S PRCA("STATUS")=$P(PG,U,8)                            ; current status of the bill
 S PRCA("APPR")=$P(PG,U,18)                             ; appropriation symbol
 ;
 ; get site stuff
 S PRS=+$P($G(^RC(342,1,0)),U,1)       ; main AR site
 S PRCA("SITE")=+$$GET1^DIQ(4,PRS,99)  ; station#
 I PRCA("SITE") S PRCA("CKSITE")=""    ; station# check flag
 ;
 ; build a string of valid internal status ien's (WRITE-OFF, SUSPENDED, CANCELLATION, COLLECTED/CLOSED)
 S PRCAWO="," F I=109,240,111,108 S PRCAWO=PRCAWO_$O(^PRCA(430.3,"AC",I,0))_","
 I '$F(PRCAWO,","_PRCA("STATUS")_",") D  G ENAPX
 . W !,"The Re-Establish action is not available for this bill because the current"
 . W !,"AR status of this bill is "_$$GET1^DIQ(430,PRCABN,8)_"."
 . W !,"Valid statuses are WRITE-OFF, SUSPENDED, CANCELLATION, or COLLECTED/CLOSED."
 . Q
 ;
 I PRCATY=26 D  G ENAPX
 . W !,"The Re-Establish action is not available for this bill because the current"
 . W !,"AR category of this bill is "_$$GET1^DIQ(430,PRCABN,2)_".  This is the only one not allowed."
 . Q
 ;
 G APJ       ; jump into the routine at the proper point
 ;
ENAPX ;
 Q
 ;
