PRCAI162 ;WISC/RFJ-post init patch 162 ;4 Oct 00
 ;;4.5;Accounts Receivable;**162**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
START ;  start post init
 D BMES^XPDUTL(" >>  Adding a time to exempted interest/admin transactions ...")
 ;
 N %,DATA1,RCDATE,RCDAY,RCTRANDA,RCTRDATE
 ;
 ;  get the sites statement day
 S RCDAY=+$P($G(^RC(342,1,0)),"^",11) I 'RCDAY Q
 I $L(RCDAY)=1 S RCDAY="0"_RCDAY
 ;
 ;  start with june 2000 and loop each date to make sure
 ;  the time is entered on exempt transactions.  this date
 ;  is the same as the date interest and admin charges are
 ;  added (statement date minus 3 days).  if a charge is
 ;  exempted on the same day, make sure there is a time.
 F RCDATE=30006:1:30012 D
 .   S RCTRDATE=$$FMADD^XLFDT(RCDATE_RCDAY,-3)
 .   ;
 .   ;  loop transaction on the date
 .   S RCTRANDA=0 F  S RCTRANDA=$O(^PRCA(433,"AT",14,RCTRDATE,RCTRANDA)) Q:'RCTRANDA  D
 .   .   S DATA1=$G(^PRCA(433,RCTRANDA,1))
 .   .   I $P($P(DATA1,"^",9),".",2)="" S %=$$EDIT433^RCBEUTRA(RCTRANDA,"19////"_RCTRDATE_".2359;")
 ;
 D BMES^XPDUTL(" >>  Fixing RC DOJ CODE field on payment transactions ...")
 ;
 ;  loop payment transactions and fix RC DOJ CODE field 7, file 433
 N PAYTYPE,RCDATE,RCRECTDA,RCTRAN,RCTRANDA,RCTYPE
 F RCTRAN=2,34 S RCDATE=0 F  S RCDATE=$O(^PRCA(433,"AT",RCTRAN,RCDATE)) Q:'RCDATE  D
 .   S RCTRANDA=0 F  S RCTRANDA=$O(^PRCA(433,"AT",RCTRAN,RCDATE,RCTRANDA)) Q:'RCTRANDA  D
 .   .   ;  get the type of payment
 .   .   S RCTYPE=$P($G(^PRCA(433,RCTRANDA,0)),"^",7)
 .   .   ;  type of payment does not exist or is correct
 .   .   I RCTYPE="" Q
 .   .   I RCTYPE="DC"!(RCTYPE="DOJ")!(RCTYPE="IRS")!(RCTYPE="RC")!(RCTYPE="TOP") Q
 .   .   ;  check to see if it is set as the receipt number, if not quit
 .   .   S RCRECTDA=$O(^RCY(344,"B",RCTYPE,0)) I 'RCRECTDA Q
 .   .   ;  get the type of payment on the receipt
 .   .   S PAYTYPE=$P($G(^RCY(344,RCRECTDA,0)),"^",4)
 .   .   ;  set the transaction type of payment
 .   .   S RCTYPE=""
 .   .   I PAYTYPE=3 S RCTYPE="RC"
 .   .   I PAYTYPE=5 S RCTYPE="DOJ"
 .   .   I PAYTYPE=11 S RCTYPE="IRS"
 .   .   I PAYTYPE=13 S RCTYPE="TOP"
 .   .   S $P(^PRCA(433,RCTRANDA,0),"^",7)=RCTYPE
 ;
 D REPAY
 Q
 ;
 ;
REPAY ;  fix repayment plans
 D BMES^XPDUTL(" >>  Fixing Repayment Plans ...")
 ;
 N COUNT,DATA,DATA0,DATA2,DATA3,DATA4,DATE,INTADM,LINE,PAYAMT,RCAMT,RCDATE,RCBILLDA,RCPAY,RCPAYAMT,RCREPDA,RCSTOP,RCSTOP1,RCTRAN,RCTRANDA,RCTRANDB,REPAYAMT,REPAYDAT,RSC,TYPE,XMDUN,XMY,XMZ
 K ^TMP("PRCAI162",$J)
 ;
 D MES^XPDUTL("     ...looping payment transactions.")
 ;  loop all payment transactions and build a list of repayments by bill
 ;  and by date paid
 F RCTRAN=2,34 S RCDATE=0 F  S RCDATE=$O(^PRCA(433,"AT",RCTRAN,RCDATE)) Q:'RCDATE  D
 .   S RCTRANDA=0 F  S RCTRANDA=$O(^PRCA(433,"AT",RCTRAN,RCDATE,RCTRANDA)) Q:'RCTRANDA  D
 .   .   ;  get the bill for the payment
 .   .   S RCBILLDA=+$P($G(^PRCA(433,RCTRANDA,0)),"^",2) I 'RCBILLDA Q
 .   .   ;
 .   .   ;  get the repayment data
 .   .   I '$O(^PRCA(430,RCBILLDA,5,0)) Q
 .   .   S DATA4=$G(^PRCA(430,RCBILLDA,4))
 .   .   S REPAYAMT=+$P(DATA4,"^",3) I 'REPAYAMT Q
 .   .   S REPAYDAT=+$P($P(DATA4,"^"),".") I 'REPAYDAT Q
 .   .   ;  verify the payment date after repayment plan established
 .   .   I RCDATE<REPAYDAT Q
 .   .   ;  verify the paid amount is less than the repayment amount
 .   .   S RCAMT=+$P($G(^PRCA(433,RCTRANDA,1)),"^",5) I RCAMT<REPAYAMT Q
 .   .   ;
 .   .   S ^TMP("PRCAI162",$J,RCBILLDA,RCDATE,RCTRANDA)=RCAMT
 ;
 ;  this is used to store data to generate the mailman message
 K ^TMP("PRCAI162REPAY")
 ;
 D MES^XPDUTL("     ...fixing repayment plan payment errors.")
 ;
 ;  loop the payments stored by bill and date paid and build an array
 ;  of repayments in rcpay(count)
 S RCBILLDA=0 F  S RCBILLDA=$O(^TMP("PRCAI162",$J,RCBILLDA)) Q:'RCBILLDA  D
 .   S REPAYAMT=+$P($G(^PRCA(430,RCBILLDA,4)),"^",3)
 .   K RCPAY
 .   S COUNT=0
 .   S RCDATE=0 F  S RCDATE=$O(^TMP("PRCAI162",$J,RCBILLDA,RCDATE)) Q:'RCDATE  D
 .   .   S RCTRANDA=0 F  S RCTRANDA=$O(^TMP("PRCAI162",$J,RCBILLDA,RCDATE,RCTRANDA)) Q:'RCTRANDA  D
 .   .   .   S RCPAYAMT=^TMP("PRCAI162",$J,RCBILLDA,RCDATE,RCTRANDA)
 .   .   .   F  D  Q:RCPAYAMT<REPAYAMT
 .   .   .   .   S COUNT=COUNT+1,RCPAY(COUNT)=RCTRANDA
 .   .   .   .   S RCPAYAMT=RCPAYAMT-REPAYAMT
 .   ;
 .   ;  now loop the repayments and make sure they match the rcpay(count)
 .   ;  array of repayments against the bill
 .   S RCREPDA=0 F COUNT=1:1 S RCREPDA=$O(^PRCA(430,RCBILLDA,5,RCREPDA)) Q:'RCREPDA  D
 .   .   S DATA0=$G(^PRCA(430,RCBILLDA,5,RCREPDA,0)) I DATA0="" Q
 .   .   ;  if no payments left, the repayment plan should no longer
 .   .   ;  show payments being received
 .   .   I '$D(RCPAY(COUNT)) D  Q
 .   .   .   I $P(DATA0,"^",2)'=0!($P(DATA0,"^",4)'="") S $P(DATA0,"^",2)=0,$P(DATA0,"^",4)="" D SET(DATA0)
 .   .   ;
 .   .   ;  payment recorded on wrong transaction
 .   .   I $P(DATA0,"^",2)=1,$P(DATA0,"^",4)'=RCPAY(COUNT) D  Q
 .   .   .   S $P(DATA0,"^",4)=RCPAY(COUNT) D SET(DATA0)
 .   .   ;
 .   .   ;  payment not shown as being made
 .   .   I $P(DATA0,"^",2)=0,$P(DATA0,"^",4)'=RCPAY(COUNT) D  Q
 .   .   .   S $P(DATA0,"^",2)=1,$P(DATA0,"^",4)=RCPAY(COUNT) D SET(DATA0)
 .   .   .   ;
 .   .   .   ;
 .   .   .   ;  check for int/admin charges applied after the payment transaction received
 .   .   .   ;  this is used to build the mailman message showing potential problems
 .   .   .   S RCSTOP=0
 .   .   .   S RCTRANDA=RCPAY(COUNT) F  S RCTRANDA=$O(^PRCA(433,"C",RCBILLDA,RCTRANDA)) Q:'RCTRANDA  D  I RCSTOP Q
 .   .   .   .   ;  only look at the int/admin charges after 8/1/2000
 .   .   .   .   I $P($G(^PRCA(433,RCTRANDA,1)),"^",9)<3000801 Q
 .   .   .   .   ;  found an interest/admin charge
 .   .   .   .   I $P($G(^PRCA(433,RCTRANDA,1)),"^",2)=13 D
 .   .   .   .   .   S DATA2=$G(^PRCA(433,RCTRANDA,2))
 .   .   .   .   .   S ^TMP("PRCAI162REPAY",RCBILLDA,RCTRANDA,"IA")=$P(DATA2,"^",7)_"^"_$P(DATA2,"^",8)
 .   .   .   .   .   S RCSTOP=1
 .   .   .   .   .   ;
 .   .   .   .   .   ;  get the next payment transaction
 .   .   .   .   .   S RCSTOP1=0
 .   .   .   .   .   S RCTRANDB=RCTRANDA F  S RCTRANDB=$O(^PRCA(433,"C",RCBILLDA,RCTRANDB)) Q:'RCTRANDB  D  I RCSTOP1 Q
 .   .   .   .   .   .   S TYPE=$P($G(^PRCA(433,RCTRANDB,1)),"^",2)
 .   .   .   .   .   .   I TYPE=2!(TYPE=34) D
 .   .   .   .   .   .   .   S DATA3=$G(^PRCA(433,RCTRANDB,3))
 .   .   .   .   .   .   .   S ^TMP("PRCAI162REPAY",RCBILLDA,RCTRANDA,"PA")=$P(DATA3,"^",2)_"^"_$P(DATA3,"^",3)_"^"_RCTRANDB
 .   .   .   .   .   .   .   S RCSTOP1=1
 ;
 D MES^XPDUTL("     ...generating mailman message to G.RCDP PAYMENTS.")
 ;
 ;  generate mailman message to user
 K ^TMP($J,"RCRJRCORMM")
 S ^TMP($J,"RCRJRCORMM",1)="The following bills need to be reviewed.  The interest and"
 S ^TMP($J,"RCRJRCORMM",2)="admin charges shown below may need to be exempted.  The"
 S ^TMP($J,"RCRJRCORMM",3)="payments shown below may require a decrease to the principal"
 S ^TMP($J,"RCRJRCORMM",4)="on the bill and a modification to FMS.  Interest is reported"
 S ^TMP($J,"RCRJRCORMM",5)="to FMS in fund 1435 and admin in fund 3220.  The Revenue"
 S ^TMP($J,"RCRJRCORMM",6)="Source Code has been included for the bill to help in creating"
 S ^TMP($J,"RCRJRCORMM",7)="a transfer from 1435 or 3220 to fund 5287."
 S ^TMP($J,"RCRJRCORMM",8)=" "
 ;
 S ^TMP($J,"RCRJRCORMM",9)="BILL#       RSC   TRANS#      DATE      TYPE                 "_$J("INTEREST",8)_$J("ADMIN",8)
 S ^TMP($J,"RCRJRCORMM",10)="-----------------------------------------------------------------------------"
 S LINE=10
 ;
 S RCBILLDA=0 F  S RCBILLDA=$O(^TMP("PRCAI162REPAY",RCBILLDA)) Q:'RCBILLDA  D
 .   ;  get the revenue source code
 .   S RSC=$$CALCRSC^RCXFMSUR(RCBILLDA)
 .   S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE)=" "
 .   S COUNT=0
 .   S RCTRANDA=0 F  S RCTRANDA=$O(^TMP("PRCAI162REPAY",RCBILLDA,RCTRANDA)) Q:'RCTRANDA  D
 .   .   S INTADM=$G(^TMP("PRCAI162REPAY",RCBILLDA,RCTRANDA,"IA"))
 .   .   S PAYAMT=$G(^TMP("PRCAI162REPAY",RCBILLDA,RCTRANDA,"PA"))
 .   .   ;
 .   .   ;  first time bill is displayed
 .   .   I COUNT=0 S DATA=$E($P(^PRCA(430,RCBILLDA,0),"^")_"               ",1,12)_$E(RSC_"      ",1,6)
 .   .   E  S DATA="            "_"      "
 .   .   S COUNT=1
 .   .   ;
 .   .   S DATA=DATA_$E(RCTRANDA_"               ",1,12)
 .   .   S DATE=$P($G(^PRCA(433,RCTRANDA,1)),"^",9) I DATE="" S DATE="       "
 .   .   S DATA=DATA_$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)_"  "
 .   .   S DATA=DATA_"Interest/Admin Charge"
 .   .   S DATA=DATA_$J($P(INTADM,"^"),8,2)_$J($P(INTADM,"^",2),8,2)
 .   .   S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE)=DATA
 .   .   ;  if payment, show it also
 .   .   I PAYAMT'="" D
 .   .   .   S DATA="            "_"      "
 .   .   .   S DATA=DATA_$E($P(PAYAMT,"^",3)_"               ",1,12)
 .   .   .   S DATE=$P($G(^PRCA(433,$P(PAYAMT,"^",3),1)),"^",9) I DATE="" S DATE="       "
 .   .   .   S DATA=DATA_$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)_"  "
 .   .   .   S DATA=DATA_"Payment              "
 .   .   .   S DATA=DATA_$J($P(PAYAMT,"^"),8,2)_$J($P(PAYAMT,"^",2),8,2)
 .   .   .   S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE)=DATA
 ;
 I LINE=10 S ^TMP($J,"RCRJRCORMM",11)="<<No Bills Or Transactions Found For You to Review>>"
 ;
 ;  send mail message
 N DIFROM  ;  need to be newed or mailman will not deliver the message
 S XMY("G.RCDP PAYMENTS")=""
 S XMY(.5)=""
 S XMY(DUZ)=""
 S XMZ=$$SENDMSG^RCRJRCOR("AR Patch 162 Interest/Admin Transactions",.XMY)
 K ^TMP($J,"RCRJRCORMM")
 K ^TMP("PRCAI162",$J),^TMP("PRCAI162REPAY",$J)
 Q
 ;
 ;
SET(DATA0) ;  set the repayment plan data node
 S ^PRCA(430,RCBILLDA,5,RCREPDA,0)=DATA0
 Q
