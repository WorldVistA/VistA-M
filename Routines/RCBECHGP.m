RCBECHGP ;WISC/RFJ-add penalty charges to bills (called by rcbechgs) ;1 Jun 00
 ;;4.5;Accounts Receivable;**153**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PENALTY ;  this is called by rcbechgs and is a continuation of that routine
 ;  variables passed to this entry point:
 ;    rcupdate = the fm date that charges are being added
 ;      the rcupdate variable is the statement date for non-benefit
 ;      debts or (statement date minus 3 days) for benefit (first
 ;      party debts)
 ;
 ;  penalty charges are not applied to first party bills, check to make
 ;  sure the account does not contain DPT( before calling.
 ;
 N DAYSPEN,FROMDATE,RCBILLDA,RCDATA6,RCDATE,RCFPEN,RCLASTDT,RCLET120,REPAYDAT,X
 ;
 ;  penalty charges are assessed on each bill, not just the account
 ;  loop all bills for the account
 S RCDATE=0 F  S RCDATE=$O(^TMP("RCBECHGS",$J,"LIST",RCDATE)) Q:'RCDATE  D
 .   S RCBILLDA=0 F  S RCBILLDA=$O(^TMP("RCBECHGS",$J,"LIST",RCDATE,RCBILLDA)) Q:'RCBILLDA  D
 .   .   ;  bill category set up to not charge penalty, get next bill
 .   .   I '$P($G(^PRCA(430.2,+$P(^PRCA(430,RCBILLDA,0),"^",2),0)),"^",12) Q
 .   .   S RCDATA6=$G(^PRCA(430,RCBILLDA,6))
 .   .   ;  get the last date penalty was charged to this bill
 .   .   ;  if the last date is not set in field .13, use field 67
 .   .   S RCLASTDT=$P($G(^PRCA(430,RCBILLDA,.1)),"^",3) I 'RCLASTDT S RCLASTDT=$P(RCDATA6,"^",7)
 .   .   ;  take the current statement date in variable rcupdate
 .   .   ;  (this is actually 3 days before the statement date for
 .   .   ;  benefit first party debts and is when penalty charges
 .   .   ;  get added) and subtract 1 month (this date will be the
 .   .   ;  last statement date).  If the last penalty charge date
 .   .   ;  is greater than the last statement date, do not add
 .   .   ;  penalty a second time for the same month.
 .   .   I RCLASTDT>$$FPS^RCAMFN01(RCUPDATE,-1) Q
 .   .   ;
 .   .   ;  calculate 4 months from initial notification.  this
 .   .   ;  date is 120 days from letter1 date.
 .   .   I '$P(RCDATA6,"^") Q
 .   .   S RCLET120=$$FPS^RCAMFN01($P(RCDATA6,"^",1),4)
 .   .   ;
 .   .   ;  if the current update date is greater than (the letter1
 .   .   ;  date + 4 months), it has not been 120 days from the
 .   .   ;  initial notification, do not add penalty charges
 .   .   I RCUPDATE<RCLET120 Q
 .   .   ;
 .   .   ;  get the repayment plan date
 .   .   S REPAYDAT=$P($G(^PRCA(430,RCBILLDA,4)),"^")
 .   .   ;  check to see if it was established within 120 days of
 .   .   ;  initial notification.  if not charge penalty on bill
 .   .   I REPAYDAT>RCLET120 S REPAYDAT=0
 .   .   ;
 .   .   ;  if no repayment plan date, penalty charge from initial
 .   .   ;  delinquency date (31st day).
 .   .   ;  calculate the number of days of penalty from the last
 .   .   ;  penalty charge date to the date the account is being
 .   .   ;  updated (rcupdate).  rcupdate is usually the current
 .   .   ;  statement day.  if the last penalty charge is not defined,
 .   .   ;  use the letter1 date.  if not letter1 date, quit
 .   .   I 'REPAYDAT D  Q
 .   .   .   S FROMDATE=RCLASTDT I 'FROMDATE S FROMDATE=$P(RCDATA6,"^") I 'FROMDATE Q
 .   .   .   S DAYSPEN=$$FMDIFF^XLFDT(RCUPDATE,$P(FROMDATE,"."))
 .   .   .   I DAYSPEN<1 Q
 .   .   .   ;  calculate the penalty
 .   .   .   S X=$$CALCPEN(RCBILLDA,DAYSPEN) I 'X Q
 .   .   .   S $P(^TMP("RCBECHGS",$J,"ADDCHG",RCBILLDA),"^",3)=X
 .   .   .   S $P(^TMP("RCBECHGS",$J,"ADDCHG",RCBILLDA),"^",5)="Full payment or repayment plan not established in 120 days from initial notification."
 .   .   ;
 .   .   ;  check to see if the account defaulted on the repayment
 .   .   ;  plan up to the date the penalty is being charged, if so
 .   .   ;  charge penalty on the bill
 .   .   S RCFPEN=$$REPAYDEF^RCBECHGA(RCBILLDA,RCUPDATE) I 'RCFPEN Q
 .   .   ;
 .   .   ;  account defaulted on repayment, charge penalty
 .   .   ;  charge penalty after the 121st day from the date of default
 .   .   I $$FMADD^XLFDT($P(RCFPEN,"^",2),121)>RCUPDATE Q
 .   .   ;  charge penalty from the last penalty charge date or
 .   .   ;  back to the date of default on the repayment plan
 .   .   S FROMDATE=RCLASTDT I 'FROMDATE S FROMDATE=$P(RCFPEN,"^",2)
 .   .   S DAYSPEN=$$FMDIFF^XLFDT(RCUPDATE,FROMDATE)
 .   .   I DAYSPEN<1 Q
 .   .   ;  calculate the penalty
 .   .   S X=$$CALCPEN(RCBILLDA,DAYSPEN) I 'X Q
 .   .   S $P(^TMP("RCBECHGS",$J,"ADDCHG",RCBILLDA),"^",3)=X
 .   .   S $P(^TMP("RCBECHGS",$J,"ADDCHG",RCBILLDA),"^",5)=$P(RCFPEN,"^",3)
 Q
 ;
 ;
CALCPEN(RCBILLDA,DAYSPEN) ;  calc the penalty for a number of days (dayspen)
 N DATEPREP,PENALTY,PRINCPAL
 ;  get the date the bill was prepared
 S DATEPREP=$P($G(^PRCA(430,RCBILLDA,0)),"^",10) I 'DATEPREP Q 0
 ;  get the principal balance
 S PRINCPAL=$P($G(^PRCA(430,RCBILLDA,7)),"^") I 'PRINCPAL Q 0
 ;  the penalty based on the date the bill is prepared (rcdate)
 ;  divided by 360 days in the year equals the current daily rate.
 ;  multiply by the number of days to charge penalty and by the
 ;  principal balance
 S PENALTY=+$J(+$$PEN^RCMSFN01(DATEPREP)/360*DAYSPEN*PRINCPAL,0,2)
 Q PENALTY
