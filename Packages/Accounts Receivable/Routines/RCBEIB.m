RCBEIB ;WISC/RFJ-integrated billing entry points ;1 Jun 00
 ;;4.5;Accounts Receivable;**157,270**;Mar 20, 1995;Build 25
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ; PRCA*4.5*270 add CRD flag
 ; CANCEL(RCBILLDA,RCCANDAT,RCCANDUZ,RCCANAMT,RCCANCOM) ;  this entry point is
CANCEL(RCBILLDA,RCCANDAT,RCCANDUZ,RCCANAMT,RCCANCOM,RCCRD) ;  this entry point is
 ;  called when a bill is cancelled in IB
 ;  input   rcbillda = ien of bill to cancel
 ;          rccandat = (optional) the date the bill was cancelled
 ;          rccanduz = (optional) the user cancelling the bill
 ;          rccanamt = (optional) amount being cancelled
 ;          rccancom = (optional) comments
 ;          rccrd    = (optional) CRD flag, indicates corrected record which FMS must handle differently
 ;
 ;  if the optional fields are passed, they will be stored in the
 ;  comment field (98) of the bill.
 ;
 ;  returns 1 if bill is cancelled in AR
 ;          0^error message if process fails to cancel bill in AR
 ;
 N ACTDATE,COMMENT,DATA,INTADM,LINE,PIECE,RCBALANC,RCDATA0,RCDATE,RCFCANC,RCLIST,RCOMMENT,RCPAYAMT,RCPAYMNT,RCTRANDA,VALUE,X,XMDUN,XMY,Y
 ;
 ;  lock the bill
 L +^PRCA(430,RCBILLDA):10
 I '$T Q "0^AR bill is locked by another process"
 ;
 S RCDATA0=$G(^PRCA(430,RCBILLDA,0))
 I RCDATA0="" L -^PRCA(430,RCBILLDA) Q "0^AR bill not found"
 ;
 ;  add comments to bill
 S RCOMMENT(1)="Bill was cancelled in IB on "_$$FMTE^XLFDT($$NOW^XLFDT)_".",LINE=2
 S Y=$G(RCCANDAT) I Y S Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3),LINE=LINE+1,RCOMMENT(LINE)="   Cancel Date: "_Y
 S Y=$G(RCCANDUZ) I Y S Y=$P($G(^VA(200,+RCCANDUZ,0)),"^"),LINE=LINE+1,RCOMMENT(LINE)="   Cancel   By: "_Y
 S Y=$G(RCCANAMT) I Y S Y=$J(Y,0,2),LINE=LINE+1,RCOMMENT(LINE)=" Cancel Amount: "_Y
 I $G(RCCANCOM)'="" S LINE=LINE+1,RCOMMENT(LINE)="      Comments: "_RCCANCOM
 I LINE'=2 S RCOMMENT(2)="The following information was passed from IB:"
 D ADDCOMM^RCBEUBIL(RCBILLDA,.RCOMMENT)
 ;
 ;  test to see if the bill is active in AR
 S ACTDATE=$P($G(^PRCA(430,RCBILLDA,6)),"^",21)
 ;
 ;  === bill not activated ===
 ;  set status to cancelled bill (26)
 I 'ACTDATE D CHGSTAT^RCBEUBIL(RCBILLDA,26) L -^PRCA(430,RCBILLDA) Q 1
 ;
 ;  === bill is activated ===
 ;
 ;  get the balance of the bill
 S RCBALANC=$$GETTRANS^RCDPBTLM(RCBILLDA)
 ;
 ;  calculate payments made
 S RCDATE="",RCPAYAMT=0,RCPAYMNT=""
 F  S RCDATE=$O(RCLIST(RCDATE)) Q:'RCDATE  D
 .   S RCTRANDA=0
 .   F  S RCTRANDA=$O(RCLIST(RCDATE,RCTRANDA)) Q:'RCTRANDA  D
 .   .   I RCLIST(RCDATE,RCTRANDA)'["PAYMENT" Q
 .   .   F PIECE=2:1:6 D
 .   .   .   ;  total payments
 .   .   .   S RCPAYAMT=RCPAYAMT+$P(RCLIST(RCDATE,RCTRANDA),"^",PIECE)
 .   .   .   ;  total payments by prin ^ int ^ adm ^ mf ^ cc
 .   .   .   S $P(RCPAYMNT,"^",PIECE-1)=$P(RCPAYMNT,"^",PIECE-1)+$P(RCLIST(RCDATE,RCTRANDA),"^",PIECE)
 ;
 ;  if the current bill status is active, cancel it
 I $P(^PRCA(430,RCBILLDA,0),"^",8)=16!($P(^PRCA(430,RCBILLDA,0),"^",8)=42) D
 .   ;  if there is a principal balance, decrease it
 .   S COMMENT(1)="Bill cancelled in IB.  Automatic decrease adjustment created."
 .   ;
 .   ; PRCA*4.5*270 need to  let FMS know if this is a corrected record
 .   ;I $P(RCBALANC,"^") S RCTRANDA=$$INCDEC^RCBEUTR1(RCBILLDA,-$P(RCBALANC,"^"),.COMMENT) I 'RCTRANDA Q
 .   I $P(RCBALANC,"^") S RCTRANDA=$$INCDEC^RCBEUTR1(RCBILLDA,-$P(RCBALANC,"^"),.COMMENT,"","","",$G(RCCRD)) I 'RCTRANDA Q
 .   ;
 .   ;  create an int/adm charge (minus)
 .   ;  determine if there is an interest ^ admin ^ mf ^ cc charge
 .   ;  set value = interest ^ admin ^ mf ^ cc (and make negative)
 .   S INTADM=0,VALUE=""
 .   F PIECE=2:1:5 S INTADM=INTADM+$P(RCBALANC,"^",PIECE),VALUE=VALUE_(-$P(RCBALANC,"^",PIECE))_"^"
 .   I INTADM S RCTRANDA=$$INTADM^RCBEUTR1(RCBILLDA,VALUE,.COMMENT) I 'RCTRANDA Q
 .   ;
 .   ;  mark bill as cancellation (39)
 .   D CHGSTAT^RCBEUBIL(RCBILLDA,39)
 ;
 ;  recheck status to see if bill was cancelled
 ;  set rcfcanc to indicate bill could not be canceled
 S RCDATA0=$G(^PRCA(430,RCBILLDA,0))
 I $P(RCDATA0,"^",8)'=39,$P(RCDATA0,"^",8)'=26 S RCFCANC="AR could not automatically CANCEL the bill.  User action is required."
 ;
 ;  if the bill was cancelled in AR and no payments, do not send mail
 I $G(RCFCANC)="",'RCPAYAMT L -^PRCA(430,RCBILLDA) Q 1
 ;
 ;
 ;  bill could not be cancelled in AR or payments made,
 ;  send mailman message to user
 K ^TMP($J,"RCRJRCORMM")
 S ^TMP($J,"RCRJRCORMM",1,0)="Integrated Billing has cancelled bill "_$P(RCDATA0,"^")_"."
 S ^TMP($J,"RCRJRCORMM",2,0)=" "
 S ^TMP($J,"RCRJRCORMM",3,0)="     BILL: "_$P(RCDATA0,"^")_"            STATUS: "_$P($G(^PRCA(430.3,+$P(^PRCA(430,RCBILLDA,0),"^",8),0)),"^")
 S DATA=$$ACCNTHDR^RCDPAPLM($P(RCDATA0,"^",9))
 S ^TMP($J,"RCRJRCORMM",4,0)="  ACCOUNT: "_$P(DATA,"^")_" "_$P(DATA,"^",2)
 S ^TMP($J,"RCRJRCORMM",5,0)=" "
 S ^TMP($J,"RCRJRCORMM",6,0)="                                Principal  Interest     Admin"
 S ^TMP($J,"RCRJRCORMM",7,0)="  Current Balance:             "_$J($P(RCBALANC,"^"),10,2)_$J($P(RCBALANC,"^",2),10,2)_$J($P(RCBALANC,"^",3)+$P(RCBALANC,"^",4)+$P(RCBALANC,"^",5),10,2)
 S LINE=7
 ;
 ;  if payments made, show amount paid
 I RCPAYAMT S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE,0)="  Payments   Made:             "_$J(-$P(RCPAYMNT,"^"),10,2)_$J(-$P(RCPAYMNT,"^",2),10,2)_$J(-$P(RCPAYMNT,"^",3)-$P(RCPAYMNT,"^",4)-$P(RCPAYMNT,"^",5),10,2)
 ;
 ;  if comments passed from IB, include them
 I $D(RCOMMENT(2)) D
 .   S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE,0)=" "
 .   F X=1:1 Q:'$D(RCOMMENT(X))  S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE,0)=RCOMMENT(X)
 ;
 ;  if the bill could not be cancelled in AR, let user know the error
 I $G(RCFCANC)'="" D
 .   S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE,0)=" "
 .   S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE,0)="* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
 .   S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE,0)=RCFCANC
 .   S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE,0)="* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
 ;
 ;  if a payment has been made, let user know it needs to be refunded
 I RCPAYAMT D
 .   S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE,0)=" "
 .   S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE,0)="* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
 .   S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE,0)="In AR, a payment of $ "_$J(-RCPAYAMT,0,2)_" has been collected and needs to be REFUNDED."
 .   S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE,0)="* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
 ;
 ;  send report
 S XMY("G.PRCA ADJUSTMENT TRANS")=""
 S X=$$SENDMSG^RCRJRCOR("AR User Action Required "_$P(RCDATA0,"^"),.XMY)
 K ^TMP($J,"RCRJRCORMM")
 ;
 L -^PRCA(430,RCBILLDA)
 ;
 Q $S($G(RCFCANC)'="":"0^"_RCFCANC,1:1)
