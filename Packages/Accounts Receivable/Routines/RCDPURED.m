RCDPURED ;WISC/RFJ-file 344 receipt/payment dd calls ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,169,174,196,202,244,268**;Mar 20, 1995;Build 2
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
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
 N ORIGDATA,TRANDA
 S ORIGDATA=^RCY(344,DA(1),1,DA,0)
 ;  no original payment amount
 I '$P(ORIGDATA,"^",4) Q
 ;  payment amount did not change
 I +$P(ORIGDATA,"^",4)=+X Q
 ;  payment amount increased
 I $P(ORIGDATA,"^",4)<X Q
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
 I $L(X)>20!($L(X)<1) K X Q
 ;
 N DFN,RCBILL,RCINPUT,RCOUTPUT,Y,RCTYP,DIC
 ;
 S RCINPUT=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;  try and lookup on bill number
 S X=$S($O(^PRCA(430,"B",RCINPUT,0)):$O(^(0))_";PRCA(430,",$O(^PRCA(430,"D",RCINPUT,0)):$O(^(0))_";PRCA(430,",1:RCINPUT)
 I X[";PRCA(430," D DISPLAY(X)
 ;  bill not found, try and lookup on patient
 I X=RCINPUT S DIC="^DPT(",DIC(0)="EM" D ^DIC S X=+Y_";DPT("
 ;  new value in variable X (output in X)
 ;
 ;  patient not found, type of payment = check/mo
 I +$G(Y)<0,($P($G(^RCY(344,DA(1),0)),"^",4)=4) D
 .   S (X,Y)=$$REC^IBRFN(RCINPUT,.RCTYP),(RCBILL,X)=X_";PRCA(430,"
 .   I Y>0 D
 .   .   N DIR,DIQ2,DIRUT,DTOUT,DUOUT,RCPRM
 .   .   S RCTYP=$G(RCTYP,1)
 .   .   S RCPRM=$S(RCTYP=1:"TRICARE reference number",RCTYP=2:"ECME Rx reference number",RCTYP=3:"prescription number",1:"reference number")
 .   .   S DIR("A")="Is this "_RCPRM_" - "_RCINPUT
 .   .   S DIR("B")="No",DIR("A",1)=" "
 .   .   S DIR(0)="Y^O" D ^DIR S:'Y Y=-1
 .   .   I Y'>0 Q
 .   .   W !!,$P($G(^PRCA(430,+RCBILL,0)),"^")," "
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
CHECKPAT(DFN) ;  check patient for other charges, etc., show message
 N X
 S X="IBARXEU" X ^%ZOSF("TEST")
 I $T S X=$$RXST^IBARXEU(DFN,DT) I X D
 .   W !?2,"* Patient is exempt from RX Copay: ",$P(X,"^",4)," *"
 S X="PSOCOPAY" X ^%ZOSF("TEST")
 I $T S X=$$POT^PSOCOPAY(DFN) I X D
 .   N DA,VAEL,VAERR,X1,RCX
 .   S RCX=X
 .   D ELIG^VADPT S DA=$O(^IBE(350.1,"B","PSO "_$S(VAEL(3):"",1:"N")_"SC RX COPAY NEW",0)) I DA D COST^IBAUTL
 .   S X1=+$G(X1)
 .   W !?2,"* This patient has ",RCX,"-30 day RX's totaling $",$FN(RCX*X1,",",2)," that are potentially *"
 .   W !?2,"* billable.  This represents any Window Rx's issued today. *"
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
