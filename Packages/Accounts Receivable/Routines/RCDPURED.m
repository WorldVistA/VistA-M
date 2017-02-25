RCDPURED ;WISC/RFJ - File 344 receipt/payment dd calls ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,169,174,196,202,244,268,271,304,301,312**;Mar 20, 1995;Build 13
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to $$REC^IBRFN supported by DBIA 2031
 ;
 Q
 ;
 ;
 ;  ***** dd references from file 344 (receipts) *****
 ;
 ;
DUPLCATE ;  called by input transform receipt number (.01)
 ;  make sure no duplicate receipt numbers
 I $O(^RCY(344,"B",X,"")) K X W !,"This is a duplicate receipt number." Q
 I $O(^PRCA(433,"AF",X,"")) K X W !,"This receipt number has already been used and has been purged from the system. " K X
 Q
 ;
 ;
PAYCOUNT(RCRECTDA) ;  called by computed field number of transactions (101)
 ;  return the count of payments for the receipt
 N COUNT,X
 S COUNT=0
 S X=0 F  S X=$O(^RCY(344,+$G(RCRECTDA),1,X)) Q:'X  S COUNT=COUNT+1
 Q COUNT
 ;
 ;
PAYTOTAL(RCRECTDA) ;  called by computed field total amount of receipts (.15)
 ;  return the total dollars for payments entered for the receipt
 N TOTAL,X
 S TOTAL=0
 S X=0 F  S X=$O(^RCY(344,+$G(RCRECTDA),1,X)) Q:'X  S TOTAL=TOTAL+$P($G(^(X,0)),"^",4)
 Q TOTAL
 ;
 ;
 ;  ***** dd references from sub-file 344.01 (transactions) *****
 ;
 ;
CHGAMT ;  called from the input transform on the transaction amount (.04)
 ;  field.  if the amount is changed, this will create a new cancelled
 ;  transaction showing the original amount before the change.
 Q:$G(CSNOPROC)  ; prca*4.5*301 ; LEG
 N ORIGDATA,TRANDA
 S ORIGDATA=^RCY(344,DA(1),1,DA,0)
 ;  no original payment amount
 I '$P(ORIGDATA,"^",4) Q
 ;  payment amount did not change
 I +$P(ORIGDATA,"^",4)=+X Q
 ;  payment amount increased
 I $P(ORIGDATA,"^",4)<X Q
 ;PRCA*4.5*304 - surpress new transaction if from Multiple split Link Payment.
 ;  undeclared parameter RCSPRSS is defined (only defined in RCDPLPL4)
 I $G(RCSPRSS) Q
 ;  amount was changed
 ;  enter a new transaction
 S TRANDA=$$ADDTRAN^RCDPURET(DA(1))
 I 'TRANDA W !,"  Unable to edit amount." K X Q
 ;  copy the current data for the transaction
 ;  do not use fileman, will overwrite variables
 ;  set the cancel comment (field 1.01)
 S $P(^RCY(344,DA(1),1,TRANDA,1),"^")="Amount $"_$P(ORIGDATA,"^",4)_" decreased in original trans#"_DA
 ;  set the payment amount to zero (for cancelled)
 S $P(ORIGDATA,"^",4)=0
 S $P(ORIGDATA,"^",14)=DUZ
 S $P(^RCY(344,DA(1),1,TRANDA,0),"^",2,99)=$P(ORIGDATA,"^",2,99)
 Q
 ;
 ;
PAYCHK ;  called from the input transform on the transaction amount (.04)
 ;  field.  This will compare the amount paid with the amount owed
 ;  for a bill.
 Q:$G(CSNOPROC)  ; prca*4.5*301 ; LEG
 N ACCOUNT,AMOUNT,OWED
 S ACCOUNT=$P($G(^RCY(344,DA(1),1,DA,0)),"^",3)
 ;  quit, account not a bill
 I ACCOUNT'["PRCA(430," Q
 ;  quit, account is a patient
 I $P($G(^RCD(340,+$P($G(^PRCA(430,+ACCOUNT,0)),"^",9),0)),"^")[";DPT(" Q
 ;  calculate amount owed for a bill
 S OWED=$G(^PRCA(430,+ACCOUNT,7))
 S OWED=$P(OWED,"^")+$P(OWED,"^",2)+$P(OWED,"^",3)+$P(OWED,"^",4)+$P(OWED,"^",5)
 ;  compare amount paid (in x) with amount owed (if not processed 0;7)
 I X>OWED,'$P($G(^RCY(344,DA(1),0)),"^",7) W "  WARNING: Payment amount greater than amount of bill!"
 ;  check for other bills
 S AMOUNT=$$EOB^IBCNSBL2(+ACCOUNT,+$P($G(^PRCA(430,+ACCOUNT,0)),"^",3),$$PAID^PRCAFN1(+ACCOUNT))
 I AMOUNT W !!,$P(AMOUNT,"^",2)," may also be billable.",!
 Q
 ;
 ;
PNORBILL ;  called by the input transform in receipt file 344, transaction
 ;  multiple (field 1), patient name or bill number (sub field .09)
 S CSNOPROC=0 I $G(RCDCHKSW)=0,$G(HRCDCKSW) S RCDCHKSW=1 ; prca*4.5*301 ; LEG
 I $L(X)>20!($L(X)<1) K X Q
 ;
 N DFN,RCBILL,RCINPUT,RCOUTPUT,Y,RCTYP,DIC,RCDISP,RCLKFLG,RCPAY,RCPMTTYP,RCMSG
 ;
 S RCINPUT=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;  try and lookup on bill number
 I $G(RCDCHKSW),$G(RCRECTDA),$G(RCTRANDA) S RCPMTTYP=$P($G(^RCY(344,RCRECTDA,1,RCTRANDA,0)),"^",19)     ;prc*4.5*301
 S X=$S($O(^PRCA(430,"B",RCINPUT,0)):$O(^(0))_";PRCA(430,",$O(^PRCA(430,"D",RCINPUT,0)):$O(^(0))_";PRCA(430,",1:RCINPUT)
 I X[";PRCA(430," D DISPLAY(X)  ; PRCA*4.5*301; LEG
 I '$G(RCDCHKSW),X[";PRCA(430," I $D(^PRCA(430,"TCSP",+X)) D  Q  ; PRCA*4.5*301
 . W !," BILL HAS BEEN REFERRED TO CROSS-SERVICING.",!," NO MANUAL PAYMENTS ARE ALLOWED."
 . S X="^",CSNOPROC=1
 ;prca*4.5*301
 I $G(RCDCHKSW),$G(RCPMTTYP),X[";PRCA(430," D  Q:CSNOPROC=1
 . I RCPMTTYP=170,$D(^PRCA(430,"TCSP",+X)) Q
 . I RCPMTTYP=170,'$D(^PRCA(430,"TCSP",+X)) S RCMSG=1 D ERRMSG Q
 . I RCPMTTYP=168,$D(^PRCA(430,"TCSP",+X)) S RCMSG=3 D ERRMSG Q
 . I RCPMTTYP=169,$D(^PRCA(430,"TCSP",+X)) S RCMSG=2 D ERRMSG Q
 . I RCPMTTYP<168!(RCPMTTYP>170),$D(^PRCA(430,"TCSP",+X)) S RCMSG=4 D ERRMSG Q
 ;  bill not found, try and lookup on patient
 ;PRCA*4.5*304 - Echo info back to the user if not surpressed
 I X=RCINPUT S DIC="^DPT(",DIC(0)=$S($G(RCSPRSS):"M",1:"EM") D ^DIC S X=+Y_";DPT("
 ;  new value in variable X (output in X)
 ;
 ;PRCA*4.5*304 - allow EDI Lockbox payment type to look up bills by ECME and RX #'s
 ;  patient not found, type of payment = check/mo or EDI LOCKBOX
 S RCPAY=$P($G(^RCY(344,DA(1),0)),"^",4)
 S RCLKFLG=$S(RCPAY=4:1,RCPAY=14:1,1:0)
 I +$G(Y)<0,RCLKFLG D
 .   S (X,Y)=$$REC^IBRFN(RCINPUT,.RCTYP,.RCDISP),(RCBILL,X)=X_";PRCA(430,"    ; DBIA 2031
 .   I Y>0 D
 .   .   N DIR,DIQ2,DIRUT,DTOUT,DUOUT,RCPRM
 .   .   S RCTYP=$G(RCTYP,1)
 .   .   S RCPRM=$S(RCTYP=1:"TRICARE reference number",RCTYP=2:"ECME Rx reference number",RCTYP=3:"prescription number",1:"reference number")
 .   .   S DIR("A")="Is this "_RCPRM_" - "_$S($G(RCDISP)'="":RCDISP,1:RCINPUT)
 .   .   S DIR("B")="No",DIR("A",1)=" "
 .   .   S DIR(0)="Y^O" D ^DIR S:'Y Y=-1
 .   .   I Y'>0 Q
 .   .   I '$G(RCSPRSS) W !!,$P($G(^PRCA(430,+RCBILL,0)),"^")," "  ;PRCA*4.5*304
 .   .   D DISPLAY(RCBILL)
 .   .   S X=RCBILL
 ;  output in variable X
 ;
 I +$G(Y)<0 K X Q
 ;
 S RCOUTPUT=X
 ;
 ;  patient account, show messages and quit (output still in variable X)
 I RCOUTPUT[";DPT(" D CHECKPAT(+RCOUTPUT) Q
 ;
 ;  bill account
 I $$IB^IBRUTL(+RCOUTPUT) W " ... This bill appears to have other patient bills on 'hold'."
 S X=$P($G(^RCD(340,+$P(^PRCA(430,+RCOUTPUT,0),"^",9),0)),"^")
 I X[";DPT(" D CHECKPAT(+X)
 S X=RCOUTPUT
 Q
 ;
 ;
CHECKPAT(DFN) ; check patient for other charges, etc., show message
 N RCLIST,RCNODE,RCTYPE,RCPSO,RCX,RCREF,RCTOTAL,RCCOUNT
 N X,Y,DI  ; need to protect FM within FM
 S (RCTOTAL,RCCOUNT)=0
 S X="IBARXEU" X ^%ZOSF("TEST")
 I $T S X=$$RXST^IBARXEU(DFN,DT) I X D
 . W !?2,"* Patient is exempt from RX Copay: ",$P(X,"^",4)," *"
 S RCLIST="RCPSO52",RCNODE="0,2,R,I"
 K ^TMP($J,RCLIST,DFN)
 D RX^PSO52API(DFN,RCLIST,,,RCNODE,$$FMADD^XLFDT(DT,-1))
 I $G(^TMP($J,RCLIST,DFN,0))<1 G CHECKQ
 S RCPSO=0 F  S RCPSO=$O(^TMP($J,RCLIST,DFN,RCPSO)) Q:'RCPSO  D
 . ; protect aginst tier 0 drugs
 . I $G(^TMP($J,RCLIST,DFN,RCPSO,6)),$P($$CPTIER^PSNAPIS("",DT,+^(6)),"^")=0 Q
 . ; original fills
 . S RCTYPE=+$G(^TMP($J,RCLIST,DFN,RCPSO,105)) Q:'RCTYPE
 . I +$G(^TMP($J,RCLIST,DFN,RCPSO,22))=DT,$P($G(^(11)),"^")="W",'$G(^(31)) D  Q
 .. S RCX=$G(^TMP($J,RCLIST,DFN,RCPSO,8))
 .. S RCX=RCX/30\1+$S(RCX#30:1,1:0)
 .. S RCCOUNT=RCCOUNT+RCX
 .. S RCTOTAL=RCTOTAL+($$ARCOST^IBAUTL(DFN,RCTYPE,RCPSO)*RCX)
 . ; refills
 . S RCREF=0 F  S RCREF=$O(^TMP($J,RCLIST,DFN,RCPSO,"RF",RCREF)) Q:'RCREF  I $P($G(^TMP($J,RCLIST,DFN,RCPSO,"RF",RCREF,.01)),"^")=DT,$P($G(^(2)),"^")="W",'$G(^(17)) D
 .. S RCX=$G(^TMP($J,RCLIST,DFN,RCPSO,"RF",RCREF,1.1))
 .. S RCX=RCX/30\1+$S(RCX#30:1,1:0)
 .. S RCCOUNT=RCCOUNT+RCX
 .. S RCTOTAL=RCTOTAL+($$ARCOST^IBAUTL(DFN,RCTYPE,RCPSO)*RCX)
 I RCTOTAL D
 . W !?2,"* This patient has ",RCCOUNT,"-30 day RX's totaling $",$FN(RCTOTAL,",",2)," that are potentially *"
 . W !?2,"* billable. This represents any Window Rx's issued today. *"
 ;
CHECKQ ;
 K ^TMP($J,RCLIST,DFN)
 Q
 ;
 ;
DISPLAY(RCBILLDA) ;  display bill
 N DATA
 S DATA=$P(^PRCA(430,+RCBILLDA,0),"^",9) W:DATA "  ",$$NAM^RCFN01(DATA)
 S DATA=$P(^PRCA(430,+RCBILLDA,0),"^",8) I DATA D
 .   W "   ",$P(^PRCA(430.3,DATA,0),"^")
 .   I $P(^PRCA(430.3,DATA,0),"^",3)'=102,$P($G(^RCD(340,+$P(^PRCA(430,+RCBILLDA,0),"^",9),0)),"^")'[";DPT(" W !,"This bill is not in 'active' status."
 S DATA=$G(^PRCA(430,+RCBILLDA,7)) W "   $",$J($P(DATA,"^")+$P(DATA,"^",2)+$P(DATA,"^",3)+$P(DATA,"^",4)+$P(DATA,"^",5),1,2)
 Q
 ;
PAYDATE ;  called by the input transform in receipt file 344, transaction
 ;  multiple (field 1), date of payment (sub field .06)
 ;  date of payment not in future or more than one month ago
 N DAYSDIFF
 S DAYSDIFF=$$FMDIFF^XLFDT(X,DT)
 I DAYSDIFF<-31!(DAYSDIFF>0) K X
 Q
 ;
 ;
 ;  ***** dd references from file 344.1 (deposits) *****
 ;
 ;
RECTOTAL(RCDEPTDA) ;  called from computed field TOTAL AMT OF RECEIPTS (.18) in
 ;  deposit file (344.1)
 ;  this returns the total dollars paid for all receipts on deposit ticket
 N RCRECTDA,TOTAL
 S TOTAL=0
 S RCRECTDA=0 F  S RCRECTDA=$O(^RCY(344,"AD",+RCDEPTDA,RCRECTDA)) Q:'RCRECTDA  D
 .   S TOTAL=TOTAL+$$PAYTOTAL(RCRECTDA)
 Q TOTAL
 ;
 ;
RECCOUNT(RCDEPTDA) ;  called from computed field TOTAL RECEIPTS (100) in deposit file (344.1)
 ;  this returns a count of the number of receipts on a deposit ticket
 N RCRECTDA,COUNT
 S COUNT=0
 S RCRECTDA=0 F  S RCRECTDA=$O(^RCY(344,"AD",+RCDEPTDA,RCRECTDA)) Q:'RCRECTDA  D
 .   S COUNT=COUNT+1
 Q COUNT
ERRMSG ;prnt error message and set exit variables      ;prca*4.5*301
 W !!,$P($T(LINKMSG+RCMSG),";",2),! S CSNOPROC=1,RCDCHKSW=0,HRCDCKSW=1 S X=0
 Q
LINKMSG ;Linking error messages      ;prca*4.5*301   
 ;** Linking Treasury payment (170) to a non Cross-Servicing bill not allowed
 ;** Linking a TOP payment (169) to a Cross-Servicing bill is not allowed
 ;** Linking a DMC payment (168) to a Cross-Servicing bill is not allowed
 ;** Linking a MISC payment to a Cross-Servicing bill is not allowed
