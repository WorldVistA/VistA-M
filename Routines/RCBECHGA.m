RCBECHGA ;WISC/RFJ-add admin charges to account (called by rcbechgs) ;1 Jun 00
 ;;4.5;Accounts Receivable;**153,167**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ADMIN ;  this is called by rcbechgs and is a continuation of that routine
 ;  variables passed to this entry point:
 ;    rcdebtda = the ien of the debtor entry in file 340
 ;    rcdata0  = the 0th node for the debtor in rcd(340,rcdebtda,0)
 ;    rcupdate = the fm date that charges are being added
 ;      the rcupdate variable is the statement date for non-benefit
 ;      debts or (statement date minus 3 days) for benefit (first
 ;      party debts)
 ;
 N RCADDATE,RCBILLDA,RCDATA6,RCDATE,RCFADMIN,RCFQUIT,RCLASTDT,RCXDAYS,REPAYDAT,X
 ;
 ;  get the last date admin was charged to this account
 S RCADDATE=$P($G(^RCD(340,+RCDEBTDA,.1)),"^",2)
 ;  take the current statement date in variable rcupdate
 ;  (this is actually 3 days before the statement date for
 ;  benefit first party debts and is when admin charges
 ;  get added) and subtract 1 month (this date will be the
 ;  last statement date).  If the last admin charge date
 ;  is greater than the last statement date, do not add
 ;  admin a second time for the same month.
 I RCADDATE>$$FPS^RCAMFN01(RCUPDATE,-1) Q
 ;
 S RCDATE=0 F  S RCDATE=$O(^TMP("RCBECHGS",$J,"LIST",RCDATE)) Q:'RCDATE  D  I $G(RCFQUIT) Q
 .   S RCBILLDA=0 F  S RCBILLDA=$O(^TMP("RCBECHGS",$J,"LIST",RCDATE,RCBILLDA)) Q:'RCBILLDA  D  I $G(RCFQUIT) Q
 .   .   ;  bill category is set up to not charge admin, get next bill
 .   .   I '$P($G(^PRCA(430.2,+$P(^PRCA(430,RCBILLDA,0),"^",2),0)),"^",11) Q
 .   .   S RCDATA6=$G(^PRCA(430,RCBILLDA,6))
 .   .   ;
 .   .   ;  --- block begin ------------------------------------------
 .   .   ;  --- once sites begin populating the new field .12      ---
 .   .   ;  --- in file 340, the following block of code can       ---
 .   .   ;  --- be removed:                                        ---
 .   .   ;  get the last date admin was charged to this bill.
 .   .   ;  rcaddate is the last date for the account.  since
 .   .   ;  this may not be populated, check the following:
 .   .   ;  use field .12 in file 430, or use field 67
 .   .   S RCLASTDT=RCADDATE
 .   .   I 'RCLASTDT S RCLASTDT=$P($G(^PRCA(430,RCBILLDA,.1)),"^",2) I 'RCLASTDT S RCLASTDT=$P(RCDATA6,"^",7)
 .   .   ;  take the current statement date in variable rcupdate
 .   .   ;  (this is actually 3 days before the statement date for
 .   .   ;  benefit first party debts and is when admin charges
 .   .   ;  get added) and subtract 1 month (this date will be the
 .   .   ;  last statement date).  If the last admin charge date
 .   .   ;  is greater than the last statement date, do not add
 .   .   ;  admin a second time for the same month.
 .   .   I RCLASTDT>$$FPS^RCAMFN01(RCUPDATE,-1) S RCFQUIT=1 Q
 .   .   ;  --- block end ---------------------------------------------
 .   .   ;
 .   .   ;  *** the account has RCXDAYS from the initial            ***
 .   .   ;  *** notification (in letter1 date) to pay the account   ***
 .   .   ;  *** in full or setup a repayment plan.  RCXDAYS is 30   ***
 .   .   ;  *** for non-benefit debts and 57 for benefit (first     ***
 .   .   ;  *** party debts)                                        ***
 .   .   ;  *** letter 1 = initial notification                     ***
 .   .   ;  *** letter 2 = 30 days from initial notification        ***
 .   .   ;  *** letter 3 = 60 days from initial notification        ***
 .   .   ;
 .   .   ;  non-benefit debt, no letter1 date so not been 30 days
 .   .   I $P(RCDATA0,"^")'["DPT(" D  I RCXDAYS=0 Q
 .   .   .   S RCXDAYS=30
 .   .   .   I '$P(RCDATA6,"^",1) S RCXDAYS=0 Q
 .   .   .   ;  rcupdate is the statement date for non-benefit debts
 .   .   .   ;  check to see if it has been 1 month (30 days) by
 .   .   .   ;  adding a month to the letter1 date.  if this date is
 .   .   .   ;  greater than the current statement date (in rcupdate)
 .   .   .   ;  then it has not been 30 days from initial notification
 .   .   .   I RCUPDATE<$$FPS^RCAMFN01($P(RCDATA6,"^",1),1) S RCXDAYS=0
 .   .   ;
 .   .   ;  benefit debt, no letter2 date so not been 57 days
 .   .   I $P(RCDATA0,"^")["DPT(" D  I RCXDAYS=0 Q
 .   .   .   S RCXDAYS=57
 .   .   .   I '$P(RCDATA6,"^",2) S RCXDAYS=0 Q
 .   .   .   ;  since the update happens 3 days before the statement
 .   .   .   ;  date, you must add 3 days to the update before checking
 .   .   .   ;  to see if it is less than the letter3 date (letter2
 .   .   .   ;  date plus 1 month)
 .   .   .   I $$FMADD^XLFDT(RCUPDATE,3)<$$FPS^RCAMFN01($P(RCDATA6,"^",2),1) S RCXDAYS=0
 .   .   ;
 .   .   ;  this variable is used to indicate the reason why admin is
 .   .   ;  being charged
 .   .   S RCFADMIN=""
 .   .   ;  get the repayment plan date
 .   .   S REPAYDAT=$P($G(^PRCA(430,RCBILLDA,4)),"^")
 .   .   ;  if there is repayment plan established, test for the date
 .   .   ;  it was established and if the account defaulted on it.
 .   .   ;  return rcfadmin equal null if admin should not be charged
 .   .   I REPAYDAT D  I RCFADMIN="" Q
 .   .   .   ;  check to see if a repayment plan was set up within
 .   .   .   ;  RCXDAYS of the initial notification and if not, charge
 .   .   .   ;  admin on the account.  letter1 date is the initial
 .   .   .   ;  notification. set rcfadmin to reason to charge admin
 .   .   .   I REPAYDAT>$$FMADD^XLFDT($P(RCDATA6,"^"),RCXDAYS) S RCFADMIN="Repayment plan not established in "_RCXDAYS_" days from initial notification." Q
 .   .   .   ;  check to see if the account defaulted on the repayment
 .   .   .   ;  plan up to the date the admin is being charged, if so
 .   .   .   ;  charge admin on the account
 .   .   .   S X=$$REPAYDEF(RCBILLDA,RCUPDATE) I X S RCFADMIN=$P(X,"^",3)
 .   .   ;
 .   .   ;  charge admin
 .   .   I RCFADMIN="" S RCFADMIN="Full payment or repayment plan not established in "_RCXDAYS_" days from initial notification."
 .   .   S X=+$P($$ADM^RCMSFN01(),"^") I 'X Q
 .   .   S $P(^TMP("RCBECHGS",$J,"ADDCHG",RCBILLDA),"^",2)=X
 .   .   S $P(^TMP("RCBECHGS",$J,"ADDCHG",RCBILLDA),"^",4)=RCFADMIN
 .   .   ;  set this variable to exit loop for rest of bills for account
 .   .   S RCFQUIT=1
 Q
 ;
 ;
REPAYDEF(RCBILLDA,RCUPDATE) ;  check to see if bill is in default of the
 ;  repayment plan up to a specified date (rcupdate)
 ;  return piece 1 is 1 if in default, 0 if not in default
 ;         piece 2 is the date of default
 ;         piece 3 is the reason why bill found in default
 ;
 N DATA,REPAYDAT
 ;  get the last payment date
 S REPAYDAT=$O(^PRCA(430,RCBILLDA,5,"B",RCUPDATE),-1)
 I 'REPAYDAT Q 0
 S DATA=$G(^PRCA(430,RCBILLDA,5,+$O(^PRCA(430,RCBILLDA,5,REPAYDAT,0)),0))
 ;  in some cases, the repayment date is in the form YYYMM (no day)
 I $L(REPAYDAT)=5 S REPAYDAT=REPAYDAT_"01"
 ;  payment not received for date prior to repayment date
 I '$P(DATA,"^",2) Q "1^"_REPAYDAT_"^Payment Not Received before due date "_$$FORMATDT(REPAYDAT)
 Q 0
 ;
 ;
REPDATA(RCBILLDA,DAYS) ; - Return Repayment Plan information
 ;  Input: RCBILLDA=Pointer to the AR file #430
 ;             DAYS=Number of days over the due date for a payment not 
 ;                  received to be considered defaulted.
 ; Output: String with the following "^" (up-arrow) pieces:
 ;              1. Repayment Plan Start Date (FM Format)
 ;              2. Balance (Repayment Plan)
 ;              3. Monthly Payment Amount
 ;              4. Due Date (day of the month)
 ;              5. Last Payment Date (from file #433)
 ;              6. Last Payment Amount (from file #433)
 ;              7. Number of Payments Due
 ;              8. Number of Payments Defaulted
 ;         or NULL if no Repayment Plan were found for the Bill
 ; 
 N RCPMT,RCDEF,RCDUE,RCELM,RCLDAM,RCLTR,RCRP,RCTRA,Y
 ;
 S (RCDUE,RCDEF,RCLTR)=0,RCPMT="A"
 F  S RCPMT=$O(^PRCA(430,RCBILLDA,5,RCPMT),-1) Q:'RCPMT  D  Q:RCLTR
 .   S RCELM=$G(^PRCA(430,RCBILLDA,5,RCPMT,0)) Q:RCELM=""
 .   ;
 .   ; - Payment received. Assume it's the last payment made on the Plan
 .   I $P(RCELM,"^",2) S RCLTR=$P(RCELM,"^",4) Q
 .   ; 
 .   ; - A payment will be considered defaulted if a payment had not
 .   ;   been received on an installment where the due date is at
 .   ;   least DAYS days the past.
 .   I $$FMDIFF^XLFDT(DT,$P(RCELM,"^"))'<DAYS D 
 .   .   S RCDEF=RCDEF+1
 .   ;
 .   S RCDUE=RCDUE+1
 ;
 ; - If there are no DUE Payments, the Repayment Plan is paid in full
 ;   In this case, no information is returned
 I 'RCDUE Q ""
 ;
 ; - Gets the Date & Amount of the last payment on the Repayment Plan.
 ;   Retrieves it from file #433 (AR Transaction)
 S RCLDAM="^"
 I RCLTR S RCTRA=$G(^PRCA(433,RCLTR,1)) D
 .   S RCLDAM=($P(RCTRA,"^",9)\1)_"^"_$P(RCTRA,"^",5)
 ;
 S RCRP=$G(^PRCA(430,RCBILLDA,4))
 S Y=$P(RCRP,"^")_"^"_($P(RCRP,"^",3)*RCDUE)_"^"_$P(RCRP,"^",3)
 S Y=Y_"^"_$P(RCRP,"^",2)_"^"_RCLDAM_"^"_RCDUE_"^"_RCDEF
 Q Y
 ;
FORMATDT(DATE) ;  format the date to return
 Q $E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
