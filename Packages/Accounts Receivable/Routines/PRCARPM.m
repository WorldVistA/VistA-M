PRCARPM ;ALB/DRF-CREATE MULTIPLE ACCOUNT REPAYMENT DATE SCHEDULE ;08/09/2016  4:40 PM
 ;;4.5;Accounts Receivable;**315**;Mar 20, 1995;Build 67
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
BEGIN ;Start here
 N ACT,ADD,ALL,D0,DEL,DIC,DIR,LIST,LSTDATE,MULTI,NON,PAYDATE,PLN,PLNAMT,PLNDAY,PLNDT
 N PLNFRST,PLNLST,PLNNXT,PLNRMN,PLNTDUE,PRCA,PRCADAY,PRCADT,PRCAFP,PRCAFPD,PRCAMT
 N PRCANPAY,PRCAPB,PRCAREM,SUCCESS,SURE,TOTAL,TOTDUE,X,Y
 I $G(DEBTOR)]"" L -^RCD(340,+DEBTOR) ;Release previous debtor lock
 S DEBTOR=$$DEBTOR^PRCARPU()
 I $G(DEBTOR)="" K DEBTOR Q
 W "  ",$$NAM^RCFN01(+DEBTOR)
 L +^RCD(340,+DEBTOR):1 I '$T W !,"Another user is editing this record",!! G BEGIN
 D ACCOUNTS^PRCARPU(+DEBTOR,.ALL,.PLN,.NON,.ACT)
 I ACT=0 W !,"No active bills for this debtor",!! G BEGIN
 I PLN=0 G NOPLAN ;No current plan
 S MULTI=$$MULTI^PRCARPU(.PLN) I MULTI G MULTPLN ;Multiple existing plans
 I PLN G PLAN ;Single existing plan
 G BEGIN
 ;
PLAN ;There is an existing Repayment Plan
 S DIR(0)="SA^E:EDIT;D:DELETE;V:VIEW^",DIR("B")="V"
 S DIR("A")="This Veteran has a Repayment Plan - (D)elete, (E)dit or (V)iew it? "
 D ^DIR
 I Y="V" G VIEW
 I Y="D" G DELETE
 I Y="E",NON G EDITADD
 I Y="E",NON=0 G EDIT
 G BEGIN
 ;
MULTPLN ;There is more than one existing Repayment Plan
 S DIR(0)="Y"
 S DIR("A")="This Debtor has multiple plans - view them"
 S DIR("?")="Enter Y to view multiple Repayment Plans"
 D ^DIR
 I 'Y G BEGIN
 D DSMPLNS^PRCARPU(DEBTOR,.PLN)
 S DIR(0)="Y"
 S DIR("A")="This Debtor has multiple plans - consolidate them"
 S DIR("?")="Enter Y to consolidate multiple Repayment Plans into one"
 D ^DIR
 I 'Y G MLTDEL
 S TOTDUE=$$DUEARR^PRCARPU(.PLN) ;New total amount due
 S SUCCESS=$$INQPLAN^PRCARPU(TOTDUE,PLNDT)
 I 'SUCCESS W !! G BEGIN
 D RPDEL^PRCARPU(.PLN)
 D ADDPLAN^PRCARPU(.PLN,PRCAMT,PRCADAY,PRCAFPD,PRCADT)
 W !,"The Repayment Plan has been consolidated.",! D PAUSE^PRCARPU
 I 'Y G BEGIN
 D ACCOUNTS^PRCARPU(+DEBTOR,.ALL,.PLN,.NON,.ACT) ;Reload accounts after change is filed
 I NON G EDITADD
 D RPDIS^PRCARPU(DEBTOR,.PLN)
 D DISPLAY^PRCARPU(.PLN,0)
 D PAUSE^PRCARPU
 I 'Y G BEGIN
 D PAYDISP^PRCARPU(+DEBTOR,PLNDT)
 D CMTENTR^PRCARPU(+DEBTOR)
 G BEGIN
 ;
DELETE ;Delete a Repayment Plan
 D RPDIS^PRCARPU(DEBTOR,.PLN)
 D DISPLAY^PRCARPU(.PLN,0)
 S SURE=$$CORRECT^PRCARPU()
 I '+SURE G BEGIN
 D RPDEL^PRCARPU(.PLN,1)
 W !!,"The Repayment Plan for "_$P(DEBTOR,U,2)_" has been Deleted.",! D PAUSE^PRCARPU
 I 'Y G BEGIN
 D CMTENTR^PRCARPU(+DEBTOR)
 G BEGIN
 ;
EDITADD ;Edit a Repayment Plan with new bills
 D RPDIS^PRCARPU(DEBTOR,.PLN)
 D DISPLAY^PRCARPU(.PLN,0)
 D PAUSE^PRCARPU
 I 'Y G BEGIN
 D PAYDISP^PRCARPU(+DEBTOR,PLNDT)
 W !,"Bills not in Repayment Plan:",!
 S TOTAL=$$DISPLAY^PRCARPU(.NON,1)
 I TOTAL=0 G NOBILLS
 K ADD
 S LIST=$$SELECT^PRCARPU(.NON)
 I LIST="" W !,"  No Bills selected",! D PAUSE^PRCARPU G:'Y BEGIN G NOBILLS
 D SUMM^PRCARPU(.NON,LIST,.ADD)
 S TOTDUE=$$DUEARR^PRCARPU(.ADD) ;Amount being added
 W !!,"Total amount chosen is $",$J(TOTDUE,8,2),!
 S SURE=$$CORRECT^PRCARPU()
 I 'SURE W !! G BEGIN
 M DEL=PLN
 D MERGE^PRCARPU(.PLN,.ADD)
NOBILLS ;No new bill were chosen
 S TOTDUE=$$DUEARR^PRCARPU(.PLN) ;New total amount due
 S SUCCESS=$$INQPLAN^PRCARPU(TOTDUE,PLNDT)
 I 'SUCCESS W !! G BEGIN
 I $G(DEL)>0 D RPDEL^PRCARPU(.DEL,1)
 K DEL
 D ADDPLAN^PRCARPU(.PLN,PRCAMT,PRCADAY,PRCAFPD,PRCADT,1)
 W !!,"The Repayment Plan has been updated.",! D PAUSE^PRCARPU
 I 'Y G BEGIN
 K ADD
 D ACCOUNTS^PRCARPU(+DEBTOR,.ALL,.PLN,.NON,.ACT) ;Reload accounts after change is filed 
 D RPDIS^PRCARPU(DEBTOR,.PLN)
 D DISPLAY^PRCARPU(.PLN,0)
 D CMTENTR^PRCARPU(+DEBTOR)
 G BEGIN
 ;
EDIT ;Edit a Repayment Plan, no new bills
 D RPDIS^PRCARPU(DEBTOR,.PLN)
 D DISPLAY^PRCARPU(.PLN,0)
 W !,"There are no new bills to be added.",!!
 D PAUSE^PRCARPU
 I 'Y G BEGIN
 D PAYDISP^PRCARPU(+DEBTOR,PLNDT)
 S SUCCESS=$$INQPLAN^PRCARPU(PLNTDUE,PLNDT)
 I 'SUCCESS W !! G BEGIN
 D RPDEL^PRCARPU(.PLN,1)
 D ADDPLAN^PRCARPU(.PLN,PRCAMT,PRCADAY,PRCAFPD,PRCADT,1)
 W !,"The Repayment Plan has been updated.",! D PAUSE^PRCARPU
 I 'Y G BEGIN
 D ACCOUNTS^PRCARPU(+DEBTOR,.ALL,.PLN,.NON,.ACT) ;Reload accounts after change is filed 
 D RPDIS^PRCARPU(DEBTOR,.PLN)
 D DISPLAY^PRCARPU(.PLN,0)
 D CMTENTR^PRCARPU(+DEBTOR)
 G BEGIN
 ;
NOPLAN ;Debtor has no Repayment Plan
 W !,"This Veteran does not have a Repayment Plan",!!,"List of Active Bills:",!!
 S TOTAL=$$DISPLAY^PRCARPU(.NON,1)
 S LIST=$$SELECT^PRCARPU(.NON)
 I LIST="" W !! G BEGIN
 D SUMM^PRCARPU(.NON,LIST,.ADD)
 S TOTDUE=$$DUEARR^PRCARPU(.ADD)
 W !!,"Total amount chosen is $",$J(TOTDUE,8,2),!
 S SURE=$$CORRECT^PRCARPU()
 I 'SURE W !! G BEGIN
 S SUCCESS=$$INQPLAN^PRCARPU(TOTDUE)
 I 'SUCCESS W !! G BEGIN
 D ADDPLAN^PRCARPU(.ADD,PRCAMT,PRCADAY,PRCAFPD,PRCADT)
 W !,"The Repayment Plan has been established.",! D PAUSE^PRCARPU
 I 'Y G BEGIN
 D ACCOUNTS^PRCARPU(+DEBTOR,.ALL,.PLN,.NON,.ACT) ;Reload accounts after change is filed
 D RPDIS^PRCARPU(DEBTOR,.PLN)
 D DISPLAY^PRCARPU(.PLN,0)
 D CMTENTR^PRCARPU(+DEBTOR)
 G BEGIN
 ;
MLTDEL ;Delete all multiple plans
 S DIR(0)="Y"
 S DIR("A")="Delete ALL current Repayment Plans for this Debtor"
 S DIR("?")="Enter Y to delete ALL current Repayment Plans"
 D ^DIR
 I 'Y G BEGIN
 D RPDEL^PRCARPU(.PLN)
 W !,"All Repayment Plans have been deleted.",! D PAUSE^PRCARPU
 G BEGIN
 ;
VIEW ;View a Repayment Plan
 D RPDIS^PRCARPU(DEBTOR,.PLN)
 D DISPLAY^PRCARPU(.PLN,0)
 D PAUSE^PRCARPU
 I 'Y G BEGIN
 D PAYDISP^PRCARPU(+DEBTOR,PLNDT)
 W !,"Bills not in Repayment Plan:",!
 S TOTAL=$$DISPLAY^PRCARPU(.NON,1)
 G BEGIN
