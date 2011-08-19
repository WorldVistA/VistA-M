RCBECHGI ;WISC/RFJ-add interest charges to bill (called by rcbechgs) ;1 Jun 00
 ;;4.5;Accounts Receivable;**153**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
INTEREST ;  this is called by rcbechgs and is a continuation of that routine
 ;  variables passed to this entry point:
 ;    rcdata0  = the 0th node for the debtor in file 340
 ;    rcupdate = the fm date that charges are being added
 ;      the rcupdate variable is the statement date for non-benefit
 ;      debts or (statement date minus 3 days) for benefit (first
 ;      party debts)
 ;
 N DAYSINT,FROMDATE,RCBILLDA,RCDATA6,RCDATE,RCLASTDT
 ;
 S RCDATE=0 F  S RCDATE=$O(^TMP("RCBECHGS",$J,"LIST",RCDATE)) Q:'RCDATE  D
 .   S RCBILLDA=0 F  S RCBILLDA=$O(^TMP("RCBECHGS",$J,"LIST",RCDATE,RCBILLDA)) Q:'RCBILLDA  D
 .   .   ;  bill category is set up to not charge interest
 .   .   I '$P($G(^PRCA(430.2,+$P(^PRCA(430,RCBILLDA,0),"^",2),0)),"^",10) Q
 .   .   S RCDATA6=$G(^PRCA(430,RCBILLDA,6))
 .   .   ;  get the last date interest was charged to this bill
 .   .   ;  if the last date is not set in field .11, use field 67
 .   .   S RCLASTDT=$P($G(^PRCA(430,RCBILLDA,.1)),"^") I 'RCLASTDT S RCLASTDT=$P(RCDATA6,"^",7)
 .   .   ;  take the current statement date in variable rcupdate
 .   .   ;  (this is actually 3 days before the statement date for
 .   .   ;  benefit first party debts and is when interest charges
 .   .   ;  get added) and subtract 1 month (this date will be the
 .   .   ;  last statement date).  If the last interest charge date
 .   .   ;  is greater than the last statement date, do not add
 .   .   ;  interest a second time for the same month.
 .   .   I RCLASTDT>$$FPS^RCAMFN01(RCUPDATE,-1) Q
 .   .   ;
 .   .   ;  *** for benefit debts (first party) notified by CCPC    ***
 .   .   ;  *** interest assessed unless payment is received within ***
 .   .   ;  *** the first 57 days after initial notification. after ***
 .   .   ;  *** initial charge, interest is assessed every 30 days  ***
 .   .   ;  *** letter 1 = initial notification                     ***
 .   .   ;  *** letter 2 = 30 days from initial notification        ***
 .   .   ;  *** letter 3 = 60 days from initial notification        ***
 .   .   ;  if it is a first party bill (file 340 data node 0)
 .   .   I $P(RCDATA0,"^")["DPT(" D  Q
 .   .   .   ;  if the letter3 date is not set and there is interest
 .   .   .   ;  balance, then this bill has had interest charged for
 .   .   .   ;  57 days do not charge interest until after letter3 sent
 .   .   .   I '$P(RCDATA6,"^",3),$P($G(^PRCA(430,RCBILLDA,7)),"^",2)>0 Q
 .   .   .   ;  calculate the days of interest. if the 2nd letter sent,
 .   .   .   ;  then days of interest is 57.  if the 3rd letter sent,
 .   .   .   ;  then days of interest is 30
 .   .   .   S DAYSINT=0
 .   .   .   I $P(RCDATA6,"^",2) S DAYSINT=57
 .   .   .   I $P(RCDATA6,"^",3) S DAYSINT=30
 .   .   .   ;  calculate the interest
 .   .   .   S $P(^TMP("RCBECHGS",$J,"ADDCHG",RCBILLDA),"^")=$$CALCINT(RCBILLDA,DAYSINT)
 .   .   ;
 .   .   ;  *** for non-benefit debts (vendor,ex-employee,employee) ***
 .   .   ;  *** interest is assessed unless payment is received with***
 .   .   ;  *** in 30 days of initial notification                  ***
 .   .   ;  has the initial notification been sent?
 .   .   I '$P(RCDATA6,"^",1) Q
 .   .   ;  has it been 1 month since the initial notification?
 .   .   I RCUPDATE<$$FPS^RCAMFN01($P(RCDATA6,"^",1),1) Q
 .   .   ;  calculate the number of days of interest from the last int
 .   .   ;  charge date to the date the account is being updated
 .   .   ;  (rcupdate).  rcupdate is usually the current day (the
 .   .   ;  statement date).  if the last int charge is not defined,
 .   .   ;  use the letter1 date.
 .   .   S FROMDATE=RCLASTDT I 'FROMDATE S FROMDATE=$P(RCDATA6,"^",1)
 .   .   S DAYSINT=$$FMDIFF^XLFDT(RCUPDATE,$P(FROMDATE,"."))
 .   .   I DAYSINT<1 Q
 .   .   ;  calculate the interest
 .   .   S $P(^TMP("RCBECHGS",$J,"ADDCHG",RCBILLDA),"^")=$$CALCINT(RCBILLDA,DAYSINT)
 Q
 ;
 ;
CALCINT(RCBILLDA,DAYSINT) ;  calc the interest for a number of days (daysint)
 N DATEPREP,INTEREST,PRINCPAL
 ;  get the date the bill was prepared
 S DATEPREP=$P($G(^PRCA(430,RCBILLDA,0)),"^",10) I 'DATEPREP Q 0
 ;  get the principal balance
 S PRINCPAL=$P($G(^PRCA(430,RCBILLDA,7)),"^") I 'PRINCPAL Q 0
 ;  the interest rate based on the date the bill is prepared (rcdate)
 ;  divided by 360 days in the year equals the current daily rate.
 ;  multiply by the number of days to charge interest and by the
 ;  principal balance
 S INTEREST=+$J(+$$INT^RCMSFN01(DATEPREP)/360*DAYSINT*PRINCPAL,0,2)
 I 'INTEREST S INTEREST=""
 Q INTEREST
