RCDPRPL1 ;WISC/RFJ-receipt profile listmanager options ;1 Jun 99
 ;;4.5;Accounts Receivable;**114**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;  this routine contains the entry points for payment transactions
 ;
 ;
ENTRTRAN ;  option: enter a payment transaction
 ;  this option can only be selected for unapproved receipts
 ;  screen placed in protocol file and below as backup
 D FULL^VALM1
 S VALMBCK="R"
 ;
 I '$$LOCKREC^RCDPRPLU(RCRECTDA) Q
 ;
 N %,RCTRANDA,RCTYPE
 S RCTYPE=$P($G(^RC(341.1,+$P(^RCY(344,RCRECTDA,0),"^",4),0)),"^",2)
 ;
 W !
 W !,"                 Type of payment: ",$P($G(^RC(341.1,+$P(^RCY(344,RCRECTDA,0),"^",4),0)),"^")
 W !,"Adding a NEW payment transaction: "
 S RCTRANDA=$$ADDTRAN^RCDPURET(RCRECTDA)
 I 'RCTRANDA D  Q
 .   S VALMSG="Unable to ADD a new payment transaction."
 .   D WRITE^RCDPRPLU(VALMSG)
 .   L -^RCY(344,RCRECTDA)
 ;
 W "# ",RCTRANDA
 S %=$$EDITTRAN^RCDPURET(RCRECTDA,RCTRANDA)
 I '% D  Q
 .   S VALMSG=%
 .   D WRITE^RCDPRPLU(VALMSG)
 .   L -^RCY(344,RCRECTDA)
 ;
 S VALMSG="Transaction # "_RCTRANDA_" has been ADDED."
 ;
 D INIT^RCDPRPLM
 L -^RCY(344,RCRECTDA)
 Q
 ;
 ;
EDITTRAN ;  option: edit a payment transaction
 ;  this option can only be selected for unapproved receipts
 ;  screen placed in protocol file and below as backup
 D FULL^VALM1
 S VALMBCK="R"
 ;
 N %,RCTRANDA
 ;  select the payment transaction
 S RCTRANDA=$$SELPAY(RCRECTDA) I RCTRANDA<1 Q
 ;
 I '$$LOCKREC^RCDPRPLU(RCRECTDA) Q
 ;
 ;  transaction is cancelled, cannot edit
 I '$P(^RCY(344,RCRECTDA,1,RCTRANDA,0),"^",4),$P($G(^RCY(344,RCRECTDA,1,RCTRANDA,1)),"^")'="" D  Q
 .   S VALMSG="Payment Transaction "_RCTRANDA_" is CANCELLED."
 .   D WRITE^RCDPRPLU(VALMSG)
 .   L -^RCY(344,RCRECTDA)
 ;
 W !!,"Editing Payment: ",RCTRANDA
 S %=$$EDITTRAN^RCDPURET(RCRECTDA,RCTRANDA)
 I '% S VALMSG="Transaction DELETED." D WRITE^RCDPRPLU(VALMSG)
 ;
 D INIT^RCDPRPLM
 L -^RCY(344,RCRECTDA)
 Q
 ;
 ;
CANCTRAN ;  option: cancel a transaction
 ;  this option can only be selected for unapproved receipts
 ;  screen placed in protocol file and below as backup
 D FULL^VALM1
 S VALMBCK="R"
 ;
 N RCTRANDA
 ;  select the payment transaction
 S RCTRANDA=$$SELPAY(RCRECTDA) I RCTRANDA<1 Q
 ;
 I '$$LOCKREC^RCDPRPLU(RCRECTDA) Q
 ;
 ;  check to see if already cancelled
 I $P($G(^RCY(344,RCRECTDA,1,RCTRANDA,0)),"^",4)=0,$P($G(^(1)),"^")'="" D  Q
 .   S VALMSG="Payment Transaction "_RCTRANDA_" is already CANCELLED."
 .   D WRITE^RCDPRPLU(VALMSG)
 .   L -^RCY(344,RCRECTDA)
 ;
 ;  ask to cancel
 I $$ASKCANC(RCTRANDA)=1 D
 .   D CANCTRAN^RCDPURET(RCRECTDA,RCTRANDA)
 .   S VALMSG="Transaction # "_RCTRANDA_" has been CANCELLED"
 ;
 D INIT^RCDPRPLM
 L -^RCY(344,RCRECTDA)
 Q
 ;
 ;
MOVETRAN ;  move a transaction from one receipt to another
 D FULL^VALM1
 S VALMBCK="R"
 ;
 N RCNEWREC,RCNEWTRA,RCTRANDA
 ;  select the payment transaction
 S RCTRANDA=$$SELPAY(RCRECTDA) I RCTRANDA<1 Q
 ;
 I '$$LOCKREC^RCDPRPLU(RCRECTDA) Q
 ;
 ;  transaction is cancelled, cannot edit
 I '$P(^RCY(344,RCRECTDA,1,RCTRANDA,0),"^",4),$P($G(^RCY(344,RCRECTDA,1,RCTRANDA,1)),"^")'="" D  Q
 .   S VALMSG="Payment Transaction "_RCTRANDA_" is CANCELLED."
 .   D WRITE^RCDPRPLU(VALMSG)
 .   D UNLOCK
 ;
 ;  select the receipt to move transaction to (can add new one)
 F  D  Q:RCNEWREC
 .   W !!,"Select the RECEIPT to move the payment transaction #"_RCTRANDA_" to:"
 .   S RCNEWREC=$$SELRECT^RCDPUREC(1)
 .   I RCNEWREC<1 S RCNEWREC=-1 Q
 .   I RCNEWREC=RCRECTDA W !,"Cannot copy transaction to same receipt." S RCNEWREC=0 Q
 .   I '$$CHECKREC^RCDPRPLU(RCNEWREC) W !,"Cannot copy to a receipt which is CLOSED." S RCNEWREC=0 Q
 I RCNEWREC<1 D UNLOCK Q
 ;
 I '$$LOCKREC^RCDPRPLU(RCNEWREC) D UNLOCK Q
 ;
 W !
 I $P($G(^RCY(344,RCNEWREC,0)),"^",4)'=$P(^RCY(344,RCRECTDA,0),"^",4) W !,"WARNING, receipt types of payment are not the same type of payment."
 ;
 I $$ASKMOVE(RCNEWREC)'=1 D UNLOCK Q
 ;
 ;  movetran will add the new transaction, and allow the user to
 ;  edit the data.  returns error message if not successful or
 ;  returns the transaction number.
 S RCNEWTRA=$$MOVETRAN^RCDPURET(RCRECTDA,RCTRANDA,RCNEWREC)
 I 'RCNEWTRA D  Q
 .   S VALMSG=%
 .   D WRITE^RCDPRPLU(VALMSG)
 .   D UNLOCK
 ;
 ;  delete the transaction just moved
 D DELETRAN^RCDPURET(RCRECTDA,RCTRANDA)
 ;
 D INIT^RCDPRPLM
 S VALMSG="Transaction # "_RCTRANDA_" has been MOVED/DELETED."
 ;
UNLOCK ;  unlock receipts
 L -^RCY(344,RCRECTDA)
 I $G(RCNEWREC)>0 L -^RCY(344,RCNEWREC)
 Q
 ;
 ;
SELPAY(RCRECTDA) ;  select the payment transaction for the receipt (from listmanager options)
 N RCTRANDA
 ;  if no payments, quit
 I '$O(^RCY(344,RCRECTDA,1,0)) S VALMSG="There are NO payments." Q 0
 ;  if only one payment, select that one automatically
 I $P($G(^RCY(344,RCRECTDA,1,0)),"^",4)=1 S RCTRANDA=$O(^RCY(344,RCRECTDA,1,0))
 ;  select the payment transaction
 I '$G(RCTRANDA) W ! S RCTRANDA=$$SELTRAN^RCDPURET(RCRECTDA)
 Q RCTRANDA
 ;
 ;
ASKCANC(RCTRANDA) ;  ask if its okay to cancel a transaction
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="  Are you sure you want to CANCEL transaction # "_RCTRANDA
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
 ;
 ;
ASKMOVE(RECTDA) ;  ask if its okay to move the transaction
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="  Are you sure you want to MOVE this payment to receipt "_$P($G(^RCY(344,RECTDA,0)),"^")
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
