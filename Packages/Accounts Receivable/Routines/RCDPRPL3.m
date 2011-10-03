RCDPRPL3 ;WISC/RFJ-receipt profile listmanager options ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,148,153,173**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;  routine contains the entry points for receipt management
 ;
 ;
EDITREC ;  option: edit the receipt, deposit #
 D FULL^VALM1
 S VALMBCK="R"
 ;
 I '$$LOCKREC^RCDPRPLU(RCRECTDA) Q
 ;
 W !
 D EDITREC^RCDPUREC(RCRECTDA)
 L -^RCY(344,RCRECTDA)
 ;
 ;  rebuild the header
 D HDR^RCDPRPLM
 Q
 ;
 ;
PROCESS ;  option: process receipt
 N RCOK,RCEFT,RCEFT1,RCHAC,RC,RCERA,RCAMT,RCQUIT,CRTR,Z
 D FULL^VALM1
 S VALMBCK="R"
 ;
 S RC=$S('$P($G(^RCY(344,RCRECTDA,0)),U,6)&$$LBEVENT^RCDPEU():1,1:0),CRTR=$P("cash^transfer",U,RC+1)
 W !!,"This option will process the payments for the receipt updating the AR"
 W !,"Package and generate the "_CRTR_" receipt document to FMS.  Any decrease"
 W !,"adjustments entered via the EDI Lockbox Worklist will also be generated."
 W !,"Once a receipt has been processed, the receipt status will change to closed"
 W !,"and no further processing of the receipt can occur.  If the FMS "_CRTR
 W !," receipt document rejects, you can use this same option to reprocess the"
 W !,"receipt.",!
 ;
 S RCEFT=+$P($G(^RCY(344,RCRECTDA,0)),U,17),RCERA=$P($G(^(0)),U,18),RCHAC=0
 S RCAMT=+$$PAYTOTAL^RCDPURED(RCRECTDA)
 ;
 S RCQUIT=0
 I RCERA,'RCEFT D  Q:RCQUIT
 . I +$P($G(^RCY(344.4,+RCERA,0)),U,5)'=RCAMT D  S RCQUIT=1 Q
 .. W !,"This receipt cannot be processed because the total amount of the associated",!," ERA ("_$J(+$P($G(^RCY(344.4,+RCERA,0)),U,5),"",2)_") does not equal the total amount on the receipt ("_$J(RCAMT,"",2)_")"
 .. S VALMSG="Receipt total not = ERA total - Receipt NOT processed"
 .. D RET^RCDPEWL2
 ;
 I RCEFT D  Q:'RCOK
 . N RCOK1
 . S RCOK=0,RCEFT1=+$G(^RCY(344.3,+RCEFT,0)),RCHAC=($E($P($G(^RCY(344.3,RCEFT1,0)),U,6),1,3)="HAC")
 . N Z,DIR,DIE,DA,DR
 . I $P($G(^RCY(344.3,+RCEFT1,0)),U,10) D  Q
 .. W !,"This receipt cannot be processed until EDI Lockbox checksum exception is",!," cleared on the EFT transmission"
 .. S VALMSG="EDI LOCKBOX exception still exists - Receipt NOT processed"
 .. D RET^RCDPEWL2
 . ;
 . I +$P($G(^RCY(344.31,+RCEFT,0)),U,7)'=RCAMT D  Q
 .. W !,"This receipt cannot be processed - the receipt total does not match the",!," EFT total for this EDI Lockbox receipt"
 .. S VALMSG="EDI LOCKBOX total of receipt not = EFT - Receipt NOT processed"
 .. D RET^RCDPEWL2
 . ; Check that EFT funds were posted
 . S RCOK1=1
 . I $P($G(^RCY(344.3,+$G(^RCY(344.31,+RCEFT,0)),0)),U,8),$P($G(^RCY(344.31,+RCEFT,0)),U,7) D  Q:'RCOK1
 .. N RCRECTDA,RCDEPDA
 .. S RCDEPDA=+$P($G(^RCY(344.3,+$G(^RCY(344.31,+RCEFT,0)),0)),U,3),RCRECTDA=+$O(^RCY(344,"AD",+RCDEPDA,0)) ; Get deposit and its receipt
 .. I RCRECTDA S Z=$P($$FMSSTAT^RCDPUREC(RCRECTDA),U,2) I $E(Z)="A" Q  ; Accepted by FMS
 .. W !,"This receipt cannot be processed yet - the EFT's deposit has not been",!," successfully sent to FMS.  Status currently is "_Z
 .. S VALMSG="EDI LOCKBOX EFT not yet posted",RCOK1=0
 .. D RET^RCDPEWL2
 . S RCOK=1
 ;
 I +$P($G(^RCY(344,RCRECTDA,0)),U,6),+$P(^(0),U,17) D  Q:'RCOK
 . S RCOK=0
 . S DIR("A",1)="A DEPOSIT CANNOT BE ASSOCIATED WITH AN EDI LOCKBOX EFT DETAIL RECEIPT"
 . S DIR(0)="YA",DIR("A")="DO YOU WANT TO DELETE THIS RECEIPT'S DEPOSIT REFERENCE NOW?: ",DIR("B")="NO" W ! D ^DIR K DIR
 . I Y=1 S DIE="^RCY(344,",DR=".06///@",DA=RCRECTDA D ^DIE S RCOK=1 Q
 . S VALMSG="EDI LBOX ERA receipt cannot have a deposit - Receipt NOT processed"
 ;
 N RCDEPTDA,RCDPDATA,RCDPFLAG,RCDPFHLP,RCTRDA,RCSCR,STATUS,RCADJ
 ;
 ;  lock receipt
 I '$$LOCKREC^RCDPRPLU(RCRECTDA) S VALMSG="Receipt NOT Processed." Q
 ;
 ;  apply decrease adjustments from worklist entry
 S RCSCR=+$O(^RCY(344.4,"ARCT",RCRECTDA,0)),RCSCR=$S($D(^RCY(344.49,+RCSCR,0)):RCSCR,1:0)
 S RCADJ=$$ERAWL^RCDPRPL4(RCSCR)
 I RCADJ=2 D UNLOCK Q
 I RCADJ<0 D  Q
 . W !,"The bill balance for the bills listed above must be manually increased to",!,"accommodate the automatic ERA Worklist dec adjustment amounts and to allow",!,"the ERA receipt to be balanced - Receipt NOT processed."
 . D UNLOCK
 ;
 ;  warning no transactions
 I '$O(^RCY(344,RCRECTDA,1,0)) D
 .   W !,"WARNING, no transactions are on the receipt.  Processing will only change"
 .   W !,"the status of the receipt to closed."
 ;
 D DIQ344^RCDPRPLM(RCRECTDA,".06;.08;.17;.18;200;")
 ;  code sheet already sent once, this is a retransmission, check it
 I RCDPDATA(344,RCRECTDA,200,"E")'="" D
 .   S STATUS=$$STATUS^GECSSGET(RCDPDATA(344,RCRECTDA,200,"E"))
 .   W !,"This receipt has been previously processed to FMS in the cash receipt"
 .   W !,"document ",$TR(RCDPDATA(344,RCRECTDA,200,"E")," "),".  The current status for this document in the"
 .   W !,"Generic Code Sheet Stack file is ",STATUS,"."
 .   ;
 .   ;  okay to continue if status is Error, Rejected, or not defined (-1)
 .   I $E(STATUS)="E"!($E(STATUS)="R")!(STATUS=-1) Q
 .   ;  okay to continue if document has not been transmitted
 .   I $E(STATUS)="Q"!($E(STATUS)="M") Q
 .   ;  okay to continue if document is transmitted for 2 days
 .   I $E(STATUS)="T",$$FMDIFF^XLFDT(DT,RCDPDATA(344,RCRECTDA,.08,"I"))>1 Q
 .   ;
 .   ;  do not allow reprocessing
 .   S RCDPFLAG=1
 .   I $E(STATUS)="A" W !!,"You cannot reprocess and retransmit an ACCEPTED document."
 .   I $E(STATUS)="T" W !!,"You cannot reprocess and retransmit a document which has previously been",!,"transmitted and is waiting on confirmation (less than 2 days since",!,"processing)."
 I $G(RCDPFLAG) D UNLOCK Q
 ;
 ;  check payments to verify it doesn't exceed bill amt
 W !!,"Checking payment amounts versus billed amounts ..."
 S RCTRDA=0 F  S RCTRDA=$O(^RCY(344,RCRECTDA,1,RCTRDA)) Q:'RCTRDA  D
 .   S X=$$CHECKPAY(RCRECTDA,RCTRDA)
 .   I 'X Q
 .   ;  exceeds billed amt
 .   S RCDPFLAG=1
 .   ;  check for >1 pending payment for this transaction
 .   I +$P(X,"^",3)'=$P(^RCY(344,RCRECTDA,1,RCTRDA,0),"^",4) S RCDPFLAG=2
 .   W !," " I RCDPFLAG=2 W "*" S RCDPFHLP=1
 .   W "WARNING: Trans# ",RCTRDA,". Pending Payments $ ",$J($P(X,"^",3),0,2)," exceed billed amount $ ",$J($P(X,"^",2),0,2)
 I $G(RCDPFLAG) D  Q
 .   I $G(RCDPFHLP) W !,"NOTE: * Indicates more than one pending payment entered against this bill."
 .   W !,"Adjust payments listed above before processing."
 .   D UNLOCK
 ;
 W "  payments okay."
 ;
 S RCDEPTDA=RCDPDATA(344,RCRECTDA,.06,"I")
 ;  lock deposit tckt
 I RCDEPTDA I '$$LOCKDEP^RCDPDPLU(RCDEPTDA) D UNLOCK Q
 ;
 ;  check for critical fields, deposit ticket, date of deposit
 ; No deposit ticket is OK for ERA not related to an EFT or for HAC ERA
 I 'RCDEPTDA,$S('$G(RCDPDATA(344,RCRECTDA,.18,"I")):1,$$EDILB^RCDPEU(RCRECTDA)=2:0,1:'$$HAC^RCDPURE1(RCRECTDA)) D
 .   W !!,"WARNING, Deposit Ticket is missing.  If you continue with processing,"
 .   W !,"the AR accounts will be updated and a cash receipt (CR) document will"
 .   W !,"NOT be sent to FMS.  You have the option to add the Deposit Ticket now."
 .   D EDITREC^RCDPUREC(RCRECTDA,".06;")
 .   S (RCDEPTDA,RCDPDATA(344,RCRECTDA,.06,"I"))=$P(^RCY(344,RCRECTDA,0),"^",6)
 ;
 ;  deposit ticket added
 I RCDEPTDA D
 .   D EDITDEP^RCDPUDEP(RCDEPTDA,1)
 .   D DIQ3441^RCDPDPLM(RCDEPTDA,".03;")
 .   I RCDPDATA(344.1,RCDEPTDA,.03,"I") Q
 .   W !!,"No DEPOSIT DATE, you can edit the deposit data now."
 .   D EDITDEP^RCDPUDEP(RCDEPTDA,1)
 .   D DIQ3441^RCDPDPLM(RCDEPTDA,".03;")
 .   I RCDPDATA(344.1,RCDEPTDA,.03,"I") Q
 .   W !!,"Still No DEPOSIT DATE, use the Edit Deposit option under Deposit Processing."
 .   S RCDPFLAG=1
 I $G(RCDPFLAG) D UNLOCK Q
 ;
 W !
 I $$ASKPROC'=1 D  Q
 . I $G(RCADJ)>0 W !!,*7,"WARNING - EDI Lbox Worklist auto dec adjustments have already been made for",!,"this receipt!!!"
 . D UNLOCK
 ;
 ;  process receipt, pass 1 to show messages
 D PROCESS^RCDPURE1(RCRECTDA,1)
 D UNLOCK
 D INIT^RCDPRPLM
 D HDR^RCDPRPLM
 I $P(^RCY(344,RCRECTDA,0),"^",8) S VALMSG="Receipt PROCESSED."
 Q
 ;
 ;
UNLOCK ;  unlock/pause
 L -^RCY(344,RCRECTDA)
 I $G(RCDEPTDA) L -^RCY(344.1,RCDEPTDA)
 W !!,"Press RETURN to continue: " R X:DTIME
 S VALMSG="Receipt NOT Processed."
 D HDR^RCDPRPLM
 Q
 ;
 ;
CHECKPAY(RCRECTDA,RCTRDA) ;  called to check amt pd against amt of bill
 N PAYDATA,PENDING,X
 ;  receipt already processed
 I $P($G(^RCY(344,RCRECTDA,0)),"^",7) Q 0
 S PAYDATA=$G(^RCY(344,RCRECTDA,1,RCTRDA,0))
 ;  payment is 0
 I '$P(PAYDATA,"^",4) Q 0
 ;  payment processed
 I $P(PAYDATA,"^",5) Q 0
 ;  not a bill
 I $P(PAYDATA,"^",3)'["PRCA(430," Q 0
 ;  first party bill (do not check dollars)
 I $P($G(^RCD(340,+$P($G(^PRCA(430,+$P(PAYDATA,"^",3),0)),"^",9),0)),"^")["DPT(" Q 0
 ;  bill not activated or open
 S X=$P($G(^PRCA(430,+$P(PAYDATA,"^",3),0)),"^",8)
 I X'=42,X'=16 Q "1^0"
 ;  calculate dollars on receivable
 S X=$G(^PRCA(430,+$P(PAYDATA,"^",3),7)),X=$P(X,"^")+$P(X,"^",2)+$P(X,"^",3)+$P(X,"^",4)+$P(X,"^",5)
 ;  get pending payments
 ;  use pending since there may be more than one payment
 ;  to the same bill on the receipt
 S PENDING=$$PENDPAY^RCDPURET($P(PAYDATA,"^",3))
 K ^TMP($J,"RCDPUREC","PP") ;set by pending payment call
 ;  pending payments is not > billed
 I PENDING'>X Q 0
 ;  greater, return billed amt ^ pending payment amt
 Q "1^"_X_"^"_PENDING
 ;
 ;
ASKPROC() ;  ask if its okay to process the receipt
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="  Are you sure you want to PROCESS this receipt"
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
