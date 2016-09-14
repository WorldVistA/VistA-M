RCDPLPL4 ;ALB/SAB - Multiple Bill Link Payments ;17 Mar 16
 ;;4.5;Accounts Receivable;**304**;Mar 20, 1995;Build 104
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
MULTIPLE(RCRECTDA,RCTRANDA,RCGECSCR,RCSTATUS) ; Process multiple bills for the same receipt transaction.
 ;
 N RCAMT,RCCT,RCAMTRM,RCEXIT,RCMSG,RCNWTRAN,RCTACCT,RCTAMT,RCTDATA,RCACT,RCARRAY,RCEXT,RCRSP,RCSPRSS
 N RCDACNO,I,RCNM,RCBLIEN,RCDACNOI,RCUNAPN,RCQTSP,RCANS,RCDACT,RCDATA,RCPIEN,RCTACCTT
 N RCTAMT,RCTCMT,RCTDNM,RCUNRCN
 ;
 S (RCSPRSS,RCEXIT,RCCT)=0
 S RCTDATA=$G(^RCY(344,RCRECTDA,1,RCTRANDA,0))
 I RCTDATA="" D  Q
 .  S RCMSG="The initial receipt transaction data is missing.  Unable to link a claim to this transaction."
 .  D WRITE^RCDPRPLU(RCMSG)
 ;
 ; Retrieve payment amount on the transaction
 S (RCAMT,RCAMTRM)=+$P(RCTDATA,U,4)
 ;
 I RCAMT=0 D  Q
 .  S RCMSG="The transaction balance is 0.  Unable to link a claim to this transaction."
 .  D WRITE^RCDPRPLU(RCMSG)
 ;
 ;Retrieve list of Bills to link to payment
 F  D  Q:RCAMTRM=0  Q:RCEXIT
 . ;
 . ;Re-init the suspense quit flag
 . S RCQTSP=0
 . ;
 . ;Ask the user for the account
 . S RCACCT=$$GETACCT(RCRECTDA)
 . I RCACCT=-1 D  Q
 . . S RCRSP=$$CONQUIT()
 . . S:RCRSP=1 RCEXIT=1
 . ;
 . I RCACCT=0 D  Q
 . . W !,?6,"Invalid Bill Number, Please try again...."
 . S:RCACCT="SUSPENSE" RCACCT=""     ;Payment needs to remain in suspense.
 . ;
 . ;Ask the user for the amount
 . S RCAMT=$$GETAMT(RCACCT,RCAMTRM)
 . Q:RCAMT=-1
 . ;
 . ;Ask the user for Comment if no account is entered.
 . S RCCMT=""
 . I RCACCT="" S RCCMT=$$GETCMT()
 . ;timed out or ^ - exit.
 . I (RCCMT=-1)!(RCCMT="^") Q
 . ;
 . ;Update the array and amount remaining.
 . S RCCT=RCCT+1
 . S RCARRAY(RCCT)=RCACCT_U_RCAMT_U_RCCMT_U_$$GETACTNM(RCACCT)
 . S RCAMTRM=RCAMTRM-RCAMT
 . ;
 . ;Check to see if user wishes to continue
 . I RCAMTRM>0 D
 . . ;
 . . ;ask if user wishes to continue
 . . S RCRSP=$$CONTINUE(RCAMTRM)
 . . ;
 . . ;User wishes to continue
 . . Q:RCRSP=1
 . . ;
 . . ;if no, ask if user is sure and that all selected payments will not be linked.
 . . S RCRSP=$$CONQUIT()
 . . I RCRSP=1 S RCEXIT=1
 ;
 ; If the user is exiting before completion, quit.
 Q:RCEXIT
 ;
 ;State all money is disbursed and display all accounts for confirmation
 W !!,"*** RECEIPT HAS BEEN FULLY DISBURSED ***",!
 ;
 ; Ask if user wishes to review the list again
 S RCANS=$$GETANS(1)
 ;
 ;Spacing line
 W !
 ;
 ; Review the list if necessary
 I RCANS=1 D
 . S I=0
 . W !,?5,"PATIENT NAME",?36,"ACCOUNT",?50,"PAYMENT TO APPLY",!
 . F I=1:1:RCCT D
 . . S (RCNM,RCDACNO,RCDACNOI)=""
 . . S RCDATA=$G(RCARRAY(I))
 . . S RCDACT=$P(RCDATA,U)
 . . S:RCDACT="" RCNM="SUSPENSE"
 . . I RCDACT[";DPT" D
 . . . S RCNM=$P($G(^DPT($P(RCDACT,";"),0)),U)
 . . . S RCDACNO=""
 . . I RCDACT[";PRCA" D
 . . . S RCDACNOI=$P(RCDACT,";")
 . . . S RCDACNO=$P($G(^PRCA(430,$P(RCDACNOI,U),0)),U)
 . . . S RCPIEN=$P($G(^DGCR(399,RCDACNOI,0)),U,2)
 . . . I RCPIEN="" S RCNM="PATIENT NAME NOT FOUND" Q
 . . . S RCNM=$P($G(^DPT(RCPIEN,0)),U)
 . . . I RCNM="" S RCNM="PATIENT NAME NOT FOUND"
 . . W ?5,RCNM,?36,RCDACNO,?50,"$",$J($FN($P(RCDATA,U,2),",",2),15),!
 ;
 ; Ask the user if they wish to update.  Quit if they time out, "^" out, or say No to updating.
 S RCANS=$$GETANS(2)
 Q:RCANS'=1
 ;
 ;Initialize error flag
 S RCERROR=0
 ;
 ;Surpress PNORBILL^RCDPURED output
 S RCSPRSS=1
 ;
 ;create line spacing
 W !!
 ;
 ;Link the payments
 F RCACT=1:1:RCCT D  Q:RCERROR
 . ;
 . ;Extract data to update
 . S RCTAMT=$P(RCARRAY(RCACT),U,2)   ;Payment Amount
 . S RCTACCT=$P(RCARRAY(RCACT),U,1)    ;Account to link to.
 . S RCTCMT=$P(RCARRAY(RCACT),U,3)
 . S RCTDNM=$P(RCARRAY(RCACT),U,4)
 . S RCTACCTT=$S(RCTACCT="":"the Suspense Item",1:RCTACCT)
 . ;
 . ;If not the first transaction, create a new one
 . I RCACT'=1 D  Q
 . . ;
 . . ; Create new transaction
 . . S RCNWTRAN=$$COPYTRAN(RCRECTDA,RCTDATA,RCTAMT,RCGECSCR)
 . . ;
 . . ; Link the Payment using the display name
 . . D LINKPAY(RCRECTDA,RCNWTRAN,RCTDNM)
 . . ;
 . . ; build unapplied deposit number
 . . S RCUNRCN=$P($G(^RCY(344,RCRECTDA,0)),U)
 . . S RCUNAPN=$S($L(RCUNRCN)>9:$E(RCUNRCN,$L(RCUNRCN-9),$L(RCUNRCN)),1:RCUNRCN)
 . . S RCUNAPN=RCUNAPN_$E("0000",1,4-$L(RCNWTRAN))_RCNWTRAN
 . . D SETUNAPP^RCDPURET(RCRECTDA,RCNWTRAN,RCUNAPN) ; add new unapplied deposit #
 . . ;
 . . ; If creating a new suspense item, update the comment field and audit logs
 . . I RCTCMT'="" D
 . . . ;
 . . . D UPDCMT(RCRECTDA,RCNWTRAN,RCTCMT)  ; add comment
 . . . I $G(RCGECSCR)'="" D
 . . . . D AUDIT^RCBEPAY(RCRECTDA,RCNWTRAN,"I")
 . . . . D SUSPDIS^RCBEPAY(RCRECTDA,RCNWTRAN,"P")
 . . . W !,"***** PAYMENT AMOUNT LEFT IN SUSPENSE = $",$J(RCTAMT,"",2)," ... done."
 . . ;
 . . ; If linking an account, process the linking
 . . I RCTCMT="" D
 . . . ;
 . . . ; If the receipt has been processed, process the payment
 . . . I $G(RCGECSCR)'="" D  Q
 . . . . W !,RCTDNM," - Updating the Linked Account with PMT = $",$J(RCTAMT,"",2)," ... done."
 . . . . D REMCMT(RCRECTDA,RCNWTRAN)   ; Remove the supense comment.  No longer needed.
 . . . . D PROCESS(RCRECTDA,RCNWTRAN,RCTDNM)
 . . . ;
 . . . ; The receipt has not been processed
 . . . W !,RCTDNM," - Receipt has not been processed.  Account linked but not"
 . . . W !,?6,"updated for the PMT = $",$J(RCTAMT,"",2)
 . ;
 . ;If this is the first transaction, adjust the payment amount to be the amount not split out.
 . I RCACT=1 D
 . . ;
 . . ; Modify the original payment amount
 . . D ADJTRAMT(RCRECTDA,RCTRANDA,RCTAMT,RCGECSCR)
 . . ;
 . . ; Adjusting the amount in suspense, update the comment field and audit logs
 . . I RCTCMT'="" D  Q
 . . . D UPDCMT(RCRECTDA,RCTRANDA,RCTCMT)  ; add comment
 . . . I $G(RCGECSCR)'="" D
 . . . . D AUDIT^RCBEPAY(RCRECTDA,RCTRANDA,"I")
 . . . . D SUSPDIS^RCBEPAY(RCRECTDA,RCTRANDA,"P")
 . . . W !,"***** PAYMENT AMOUNT LEFT IN SUSPENSE = $",$J(RCTAMT,"",2)," ... done."
 . . ;
 . . ; Link the Payment, send account if PRCA, Patient name in Patient
 . . D LINKPAY(RCRECTDA,RCTRANDA,RCTDNM)
 . . ;
 . . ;Remove the comment, item is no longer in suspense
 . . D REMCMT(RCRECTDA,RCTRANDA)
 . . ;
 . . ; If the receipt has been processed, process the payment
 . . I $G(RCGECSCR)'="" D  Q
 . . . W !,RCTDNM," - Updating the Linked Account with PMT = $",$J(RCTAMT,"",2)," ... done."
 . . . D PROCESS(RCRECTDA,RCTRANDA,RCTDNM)
 . . ;
 . . ; The receipt has not been processed
 . . W !,RCTDNM," - Receipt has not been processed.  Account linked but not"
 . . W !,?6,"updated for the PMT = $",$J(RCTAMT,"",2)
 ;
 W !!
 ;
 D ENDMSG(RCSTATUS)
 ;
 D WRITE^RCDPRPLU(" ")
 ;
 Q
 ;
GETACCT(RCRECTDA) ; Ask the user for the account
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT,DA,RCSUSFLG,RCSTAT
 ;
 S RCSUSFLG=0
 S DIR("A")="BILL NUMBER: ",DIR(0)="FAO"
 S DIR("PRE")="I X=""SUSPENSE"" S X=""^"",RCSUSFLG=1"
 D ^DIR
 Q:RCSUSFLG "SUSPENSE"
 I $D(DTOUT)!$D(DUOUT)!(Y="")  Q -1
 ;
 ;Force to all caps
 S Y=$$UP^XLFSTR(Y)
 ;
 ; Check for valid bill number
 I '$O(^PRCA(430,"D",Y,"")) S Y=""      ; Not a valid bill number
 ;
 Q:Y="" 0   ; quit if invalid bill number or lookup number
 ;
 S X=Y
 S DA(1)=RCRECTDA
 D PNORBILL^RCDPURED
 ; 
 ;if this is an account, is it active?  If not, request a new account.
 I $G(X)[";PRCA" D  Q:RCSTAT'="ACTIVE" 0
 . S RCSTAT=$$GET1^DIQ(430,$P($G(X),";")_",",8,"E")
 . I RCSTAT'="ACTIVE",$P($G(^RCD(340,+$P(^PRCA(430,$P($G(X),";"),0),"^",9),0)),"^")[";DPT(" W !,"This bill's status is currently ",RCSTAT,".",!,"Please select a different account."
 ;
 ;Something went wrong.  Try again.
 I '$D(X) Q 0
 ;
 ; Account found, return it
 Q X
 ;
GETAMT(RCACCT,RCAMT) ; Ask the user for the amount
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT,DA,RCFLG,AMTFLG
 ;
 ;
 S RCFLG=0
 F  D  Q:RCFLG
 . S AMTFLG=1  ; Set amount flag check to 1 in case the account is a SUSPENSE account
 . S DIR("A")="Amount to apply to Account",DIR(0)="N^0.01:"_$J(RCAMT,"",2)_":2"
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT)!(Y="")  S Y=-1,RCFLG=1 Q
 . ;If not a SUSPENSE account, check the balance.
 . I RCACCT'="" S AMTFLG=$$PAYCHK(RCACCT,Y)
 . ;amount applied is greater than the amount owed.  Try again
 . Q:'AMTFLG
 . I +Y>0 S RCFLG=1 Q
 . S Y=0,RCFLG=1
 Q Y
 ;
GETCMT() ; Ask the user for the amount
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 F  D  Q:Y'=""
 . S DIR(0)="FAO^3:50"
 . S DIR("A")="Comment: "
 . D ^DIR
 . ;strip all leading and trailing spaces
 . S Y=$$TRIM^XLFSTR(Y)
 . I Y="" W !,"A comment is required when changing the status of an item in Suspense.  Please",!,"try again." Q
 . I $D(DTOUT) S Y=-1
 Q Y
 ;
CONTINUE(RCAMTRM) ; Ask the user to see if they wish to continue
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 S DIR("A")="Receipt has $"_$J(RCAMTRM,10,2)_" left to link.  Do you wish to link another? ",DIR(0)="YA"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="")  Q -1
 Q Y
 ;
 ; Confirm with the user that the wish to stop before completing the linking of payments
CONQUIT() ;
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 S DIR("A",1)="Exiting now will prevent the linking of any previously selected claims to this"
 S DIR("A")="receipt.  Are you sure? ",DIR(0)="YA"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="")  Q 1
 Q Y
 ;
 ;Create a new transaction using an existing transaction as the foundation.
COPYTRAN(RCRECTDA,RCTDATA,RCAMT,RCGECSCR) ;
 ;
 N RCNWTRAN,DR,DA,DTOUT,DIE,X,Y,RCTDATA3
 ;
 S RCTDATA3=$G(^RCY(344,RCRECTDA,1,RCTRANDA,3))
 ;Create a new transaction
 S RCNWTRAN=$$ADDTRAN^RCDPURET(RCRECTDA)
 S RCCMT="Multi-Trans Split"
 ;
 ;Update Transaction
 S DR=".02////"_$P(RCTDATA,U,2)       ;Original Confirmation #
 S DR=DR_";.04///"_RCAMT              ;Amount
 S DR=DR_";.06////"_$P(RCTDATA,U,6)   ;Original date of payment
 S DR=DR_";.07////"_$P(RCTDATA,U,7)   ;Original Check #
 S DR=DR_";.08////"_$P(RCTDATA,U,8)   ;Original Check routing #
 S DR=DR_";.1////"_$P(RCTDATA,U,10)   ;Original date on the check
 S DR=DR_";.11////"_$P(RCTDATA,U,11)  ;Original CC number
 S DR=DR_";.12////"_$P(RCTDATA,U,12)  ;Original user who entered the check
 S DR=DR_";.13////"_$P(RCTDATA,U,13)  ;Original check account #
 S DR=DR_";.14///"_DUZ                ;User Linking the payment
 S DR=DR_";1.02////"_RCCMT            ;Initial Comment
 S DR=DR_";3.02////"_$P(RCTDATA3,U,2) ;Date Trans. originally suspense
 S DR=DR_";3.03////"_$P(RCTDATA3,U,3) ;User who originally suspended Trans.
 S DIE="^RCY(344,"_RCRECTDA_",1,"
 S DA=RCNWTRAN,DA(1)=RCRECTDA
 D ^DIE
 ;
 ;Update the Audit Log
 I $G(RCGECSCR)'="" D AUDIT^RCBEPAY(RCRECTDA,RCNWTRAN,"I")
 ;
 Q RCNWTRAN
 ;
 ;Adjust the original transaction's payment amount to match to the actual, split amount.
ADJTRAMT(RCRECTDA,RCTRANDA,RCAMT,RCGECSCR) ;
 ;
 N RCCMT,DR,DIE,DA,DTOUT
 S RCCMT="Multi-Trans Split"
 ;
 S DR=".04///"_RCAMT_";1.02///"_RCCMT
 S DIE="^RCY(344,"_RCRECTDA_",1,"
 S DA=RCTRANDA,DA(1)=RCRECTDA
 D ^DIE
 D LASTEDIT^RCDPUREC(RCRECTDA)
 ;
 ;Update the Audit Log
 I $G(RCGECSCR)'="" D AUDIT^RCBEPAY(RCRECTDA,RCTRANDA,"I")
 Q
 ;
 ;Link the Transaction to an existing account
LINKPAY(RCRECTDA,RCTRANDA,RCACCT) ;
 ;
 N DR,DIE,DA,DTOUT
 S DR=".09///"_RCACCT
 S DIE="^RCY(344,"_RCRECTDA_",1,"
 S DA=RCTRANDA,DA(1)=RCRECTDA
 D ^DIE
 D LASTEDIT^RCDPUREC(RCRECTDA)
 Q
 ;
 ;Remove the suspense comment, item no longer in suspense
REMCMT(RCRECTDA,RCTRANDA) ;
 ;
 N DR,DIE,DA,DTOUT
 S DR="1.02///@"
 S DIE="^RCY(344,"_RCRECTDA_",1,"
 S DA=RCTRANDA,DA(1)=RCRECTDA
 D ^DIE
 D LASTEDIT^RCDPUREC(RCRECTDA)
 Q
 ;
GETACTNM(RCACCT) ;
 N RCACCTL,RCIEN,RCFILE
 S RCACCTL=""
 Q:RCACCT="" RCACCTL
 S RCFILE=$S(RCACCT[";PRCA(430":430,1:2)
 S RCIEN=$P(RCACCT,";")
 S RCACCTL=$$GET1^DIQ(RCFILE,RCIEN_",",".01","E")
 S:$L(RCACCTL,"-")>1 RCACCTL=$P(RCACCTL,"-",2)
 Q RCACCTL
 ;
 ;Update the suspense comment
UPDCMT(RCRECTDA,RCTRANDA,RCCMT) ;
 ;
 N DR,DIE,DA,DTOUT
 S DR="1.02///"_RCCMT_";" S DIE="^RCY(344,"_RCRECTDA_",1,"
 S DA=RCTRANDA,DA(1)=RCRECTDA
 D ^DIE
 Q
 ;
 ;Process and update the payment amounts
 ;Note:  some of the code and logic below is also in tag PROCESS^RCDPLPL3.  
 ;       If changes in logic are made below, please review this tag as well.
PROCESS(RCRECTDA,RCTRANDA,RCTDNM) ;
 ;
 N RCERROR
 S RCERROR=$$PROCESS^RCBEPAY(RCRECTDA,RCTRANDA)
 ;  an error occurred during processing a payment
 I RCERROR D  Q
 . W !
 . W !,"+------------------------------------------------------------------------------+"
 . W !,"|  An ERROR has occurred when processing payment ",RCTRANDA," on receipt ",$P(^RCY(344,RCRECTDA,0),"^"),".",?79,"|"
 . W !,"|  The error message returned during processing is:",?79,"|"
 . W !,"|",?79,"|"
 . W !,"|  ",$P(RCERROR,"^",2),?79,"|"
 . W !,"|",?79,"|"
 . W !,"|  You will need to correct the error before you can link the payment.",?79,"|"
 . W !,"+------------------------------------------------------------------------------+"
 . W !
 . D DELEACCT^RCDPURET(RCRECTDA,RCTRANDA)
 . W !,"Account "_RCTDNM_" was deleted and not linked."
 ;
 ;File entry in Audit Log
 D AUDIT^RCBEPAY(RCRECTDA,RCTRANDA,"P")
 ;
 ; Update Suspense Status
 D SUSPDIS^RCBEPAY(RCRECTDA,RCTRANDA,"PD")
 ;
 I $E(RCSTATUS)="A" D
 . ;  send mail message to the RCDP PAYMENTS mail group
 . D MAILMSG^RCDPLPSR(RCRECTDA,RCTRANDA)
 . ;  place an x in the fms doc field so it will show on the
 . ;  suspense report
 . D EDITFMS^RCDPURET(RCRECTDA,RCTRANDA,"x")
 Q
 ;
 ;Display end of processing message.
ENDMSG(RCSTATUS) ;
 ;
 I $E(RCSTATUS)="A" D
 . W !,"Since the FMS cash receipt document is Accepted in FMS, you need to go"
 . W !,"online in FMS and transfer the amount paid out of the station's suspense"
 . W !,"account.",!
 . W !,"Mail message(s) sent to RCDP PAYMENTS mail group.",!
 I $E(RCSTATUS)'="A" D
 . W !,"Since the FMS cash receipt document is NOT Accepted in FMS, you can use"
 . W !,"the option Process Receipt located under the Receipt Processing Menu"
 . W !,"to regenerate the cash receipt document to FMS.",!
 Q
 ;
 ;Get users answers to questions for reports.
GETANS(RCIDX) ;
 N DA,DIR,DTOUT,DUOUT,X,Y,DIRUT,DIROUT
 ;
 ; Ask the user what kind of report
 I RCIDX=1 D
 . S DIR("?")="Select to Y to review the payments, N to skip the review."
 . S DIR("A")="Do you want to review the payment list before updating accounts (Y/N)? "
 ;
 ; Ask the user for the payer to start the reporting on (Range Option)
 I RCIDX=2 D
 . S DIR("?")="Enter Y to update the accounts, N to return to the LP menu"
 . S DIR("A")="Do you want to update accounts with these payments (Y/N)? "
 ;
 S DIR(0)="YA"
 D ^DIR
 K DIR
 I $G(DTOUT)!$G(DUOUT) Q -1
 Q Y
 ;
 ;Retrieve the review response question from the user
GETANS1() ;
 ;
 N FLG,X,Y
 S FLG=0,Y=0
 F  D  Q:FLG=1
 . R !,"Do you want to review the payment list before updating accounts (Y/N)? ",X:DTIME
 . ;I $G(DTOUT) S FLG=1 Q    ;If it times out, treat it like a No and go to the next prompt.
 . I X="" W !,"Enter Y or N to continue." Q
 . I X["?" W !,"Select to Y to review the payments, N to skip the review." Q
 . S X=$$UP^XLFSTR(X)
 . I X="Y" S Y=1,FLG=1 Q
 . I X="N" S Y=0,FLG=1 Q
 . W !,"Select to Y to review the payments, N to skip the review."
 Q Y
 ;
 ;Is the amount entered < the amount owed. (AR ACCOUNTS ONLY, NO DEBTORS)
PAYCHK(RCACCT,RCAMT)  ;
 ;
 N OWED,FLG
 ;
 S FLG=0
 ; account is the debtor account. No need to check...
 Q:RCACCT'["PRCA" 1
 ;  calculate amount owed for a bill
 S OWED=$G(^PRCA(430,+RCACCT,7))
 S OWED=$P(OWED,"^")+$P(OWED,"^",2)+$P(OWED,"^",3)+$P(OWED,"^",4)+$P(OWED,"^",5)
 I RCAMT>OWED W !,"The requested payment is greater than then amount owed please try again.",! Q FLG
 S FLG=1
 Q FLG
