RCDPXPAP ;WISC/RFJ-automatically process the deposits  ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,150,206**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PROCESS(RCDPDATE,RCPAYDA) ;  process the deposits
 ;  rcdpdate is the transmission date;  rcpayda is ien for the payment
 ;  type found in ^rc(341.1,rcpayda)
 N DR,PAYDESC,RCDEPDAT,RCDEPOSI,RCDEPTDA,RCDFN,RCDPDATA,RCLINE,RCRECTDA,RCTRANDA,STATUS
 K ^TMP($J,"RCDPXPAP")
 ;
 ;  file the data in the payment files 344 and 344.1
 ;  tmp global = acct number(1) ^ amount(2) ^ batch#(3) ^ sequence#(4) ^
 ;               pay type(5)    ^ pay desc fields(6)
 S RCDEPOSI="" F  S RCDEPOSI=$O(^TMP($J,"RCDPXPAY","DEPOSIT",RCDEPOSI)) Q:RCDEPOSI=""  D
 .   S RCDEPDAT=$G(^TMP($J,"RCDPXPAY","DEPDATE",RCDEPOSI))
 .   ;  add the deposit if not already in file
 .   ;  make sure deposit is 6 characters in length
 .   S X=$E("000000",1,6-$L(RCDEPOSI))_RCDEPOSI
 .   S RCDEPTDA=$$ADDDEPT^RCDPUDEP(X,RCDEPDAT)
 .   I 'RCDEPTDA D ERROR^RCDPXPAM(RCDPDATE,RCDPXMZ,"Unable to ADD deposit "_RCDEPOSI_" to the AR DEPOSIT file #344.1") Q
 .   ;
 .   ;  lock deposit
 .   L +^RCY(344.1,RCDEPTDA)
 .   ;  confirm deposit (close it to prevent modifications to it)
 .   D CONFIRM^RCDPUDEP(RCDEPTDA)
 .   ;  store the deposit for unlocking below
 .   S ^TMP($J,"RCDPXPAP","DEPOSITLOCK",RCDEPTDA)=""
 .   ;
 .   ;  create receipt for transmission date and deposit
 .   S RCRECTDA=$$ADDRECT^RCDPUREC(RCDPDATE,RCDEPTDA,RCPAYDA)
 .   I 'RCRECTDA D ERROR^RCDPXPAM(RCDPDATE,RCDPXMZ,"Unable to ADD receipt "_RCDPDATE_" to the AR BATCH PAYMENT file #344") Q
 .   ;
 .   ;  lock receipt
 .   L +^RCY(344,RCRECTDA)
 .   ;  check to see if receipt has been processed (fms document)
 .   D DIQ344^RCDPRPLM(RCRECTDA,"200;")
 .   ;  code sheet already sent once, this is a retransmission, check it
 .   I RCDPDATA(344,RCRECTDA,200,"E")'="" D
 .   .   S STATUS=$$STATUS^GECSSGET(RCDPDATA(344,RCRECTDA,200,"E"))
 .   .   ;  okay to continue if status is Error, Rejected, or not defined (-1)
 .   .   I $E(STATUS)="E"!($E(STATUS)="R")!(STATUS=-1) Q
 .   .   S ^TMP($J,"RCDPXPAP","DUPLICATE",RCRECTDA)="Receipt Not Changed^1"
 .   I $D(^TMP($J,"RCDPXPAP","DUPLICATE",RCRECTDA)) L -^RCY(344,RCRECTDA) Q
 .   ;
 .   ;  mark receipt as processed (closed) to prevent editing
 .   D MARKPROC^RCDPUREC(RCRECTDA,"")
 .   ;  store the receipt for automatic processing (and unlock) below
 .   ;  the 0 is the count of unlinked accts displayed in mail message
 .   S ^TMP($J,"RCDPXPAP","PROCESS",RCRECTDA)=0
 .   ;
 .   ;  build a list of the current stored payments by batch_sequence
 .   ;  number to prevent adding duplicates
 .   K ^TMP($J,"RCDPXPAP",RCRECTDA)
 .   S RCLINE=0 F  S RCLINE=$O(^RCY(344,RCRECTDA,1,RCLINE)) Q:'RCLINE  D
 .   .   S RCDPDATA=$G(^RCY(344,RCRECTDA,1,RCLINE,2))
 .   .   I '$P(RCDPDATA,"^",2)!('$P(RCDPDATA,"^",3)) Q
 .   .   S ^TMP($J,"RCDPXPAP",RCRECTDA,$P(RCDPDATA,"^",2),$P(RCDPDATA,"^",3))=RCLINE
 .   ;
 .   ;  loop transactions and add them to the receipt
 .   S RCLINE=0 F  S RCLINE=$O(^TMP($J,"RCDPXPAY","DEPOSIT",RCDEPOSI,RCLINE)) Q:'RCLINE  D
 .   .   ;  data in the form:
 .   .   ;  acct lookup(1)  ^ amount(2) ^ batch(3) ^ sequence(4) ^
 .   .   ;  payment type(5) ^ payment description(6)
 .   .   S RCDPDATA=^TMP($J,"RCDPXPAY","DEPOSIT",RCDEPOSI,RCLINE)
 .   .   ;  if batch and sequence number already stored get current entry
 .   .   ;  and do not add a new one
 .   .   S RCTRANDA=0
 .   .   I $P(RCDPDATA,"^",3),$P(RCDPDATA,"^",4) S RCTRANDA=+$G(^TMP($J,"RCDPXPAP",RCRECTDA,+$P(RCDPDATA,"^",3),+$P(RCDPDATA,"^",4)))
 .   .   I 'RCTRANDA S RCTRANDA=+$$ADDTRAN^RCDPURET(RCRECTDA)
 .   .   I 'RCTRANDA D ERROR^RCDPXPAM(RCDPDATE,RCDPXMZ,"Unable to ADD a new transaction to the AR BATCH PAYMENT file #344") Q
 .   .   ;
 .   .   ;  if the entry has already been processed, do not make any changes
 .   .   I $P(^RCY(344,RCRECTDA,1,RCTRANDA,0),"^",5) S:'$D(^TMP($J,"RCDPXPAP","DUPLICATE",RCRECTDA)) ^(RCRECTDA)="Receipt Not Changed" Q
 .   .   I $D(^TMP($J,"RCDPXPAP","DUPLICATE",RCRECTDA)) S ^(RCRECTDA)="Receipt Updated"
 .   .   ;
 .   .   ;  lookup account
 .   .   S RCDFN=$$FINDACCT($P(RCDPDATA,"^"))_";DPT("
 .   .   ;  acct not found, count as unlinked for mail message
 .   .   I 'RCDFN S ^TMP($J,"RCDPXPAP","PROCESS",RCRECTDA)=^TMP($J,"RCDPXPAP","PROCESS",RCRECTDA)+1
 .   .   ;
 .   .   ;  build dr string to store the data
 .   .   S DR=".21////"_$P(RCDPDATA,"^")_";"       ;account
 .   .   I RCDFN S DR=DR_".03////^S X=RCDFN;.09////^S X=RCDFN;"
 .   .   S DR=DR_".22////"_+$P(RCDPDATA,"^",3)_";" ;batch number
 .   .   S DR=DR_".23////"_+$P(RCDPDATA,"^",4)_";" ;sequence number
 .   .   S DR=DR_".24////"_$P(RCDPDATA,"^",5)_";"  ;payment type
 .   .   S DR=DR_".04////"_($P(RCDPDATA,"^",2)/100)_";" ;payment amount
 .   .   S DR=DR_".06////"_RCDEPDAT_";"            ;payment date = deposit date
 .   .   ;
 .   .   S PAYDESC=$P(RCDPDATA,"^",6)
 .   .   ;  payment type check
 .   .   I $P(RCDPDATA,"^",5)=2 D
 .   .   .   ;  check number : account number : bank routing number
 .   .   .   I $P(PAYDESC,":")'="" S DR=DR_".07////"_$P(PAYDESC,":")_";"
 .   .   .   I $P(PAYDESC,":",2)'="" S DR=DR_".13////"_$P(PAYDESC,":",2)_";"
 .   .   .   I $P(PAYDESC,":",3)'="" S DR=DR_".08////"_$P(PAYDESC,":",3)_";"
 .   .   ;  payment type credit, store credit card number
 .   .   I $P(RCDPDATA,"^",5)=3,$P(PAYDESC,":")'="" S DR=DR_".11////"_$P(PAYDESC,":")_";"
 .   .   ;
 .   .   ;  store the payment under the receipt
 .   .   D FILETRAN(RCRECTDA,RCTRANDA,DR)
 ;
 ;  automatically process the receipts added
 ;  ^tmp($j,"rcdpxpap","process",receiptda)=""
 S RCRECTDA=0 F  S RCRECTDA=$O(^TMP($J,"RCDPXPAP","PROCESS",RCRECTDA)) Q:'RCRECTDA  D
 .   D PROCESS^RCDPURE1(RCRECTDA,0)
 .   ;  clear the lock (set above)
 .   L -^RCY(344,RCRECTDA)
 ;
 ;  clear all locked deposits
 S RCDEPTDA=0 F  S RCDEPTDA=$O(^TMP($J,"RCDPXPAP","DEPOSITLOCK",RCDEPTDA)) Q:'RCDEPTDA  D
 .   ;  confirm deposit (recalc totals)
 .   D CONFIRM^RCDPUDEP(RCDEPTDA)
 .   L -^RCY(344.1,RCDEPTDA)
 ;
 ;  send a message to the users showing what was processed
 D PROCMSG^RCDPXPAM
 ;
 ;  need to delete the 344.2 entry
 D DELETRAN^RCDPXPA1(RCDPDATE)
 ;
 K ^TMP($J,"RCDPXPAP")
 Q
 ;
 ;
FINDACCT(ACCT) ;  lookup the patient and return the dfn
 ;  if more than one patient matches acct, return null
 ;  acct in the form 123456789ABCDE
 I ACCT'?9N1.5A  D  Q DFN
 . S DFN=+ACCT I $G(^DPT(DFN,0))'="" Q
 . S DFN=$E(DFN,1,10)_"."_$E(DFN,11,99) I $G(^DPT(DFN,0))'="" Q 
 . S DFN=0
 . ;
 N COUNT,DFN,FOUND,NAME,SSN
 S SSN=$E(ACCT,1,9),NAME=$E(ACCT,10,99)
 I SSN="" Q 0
 S NAME=$TR(NAME,"/","'")
 S COUNT=0  ;used to count number of matches
 S FOUND=0  ;used to store matching acct's DFN number
 S DFN=0 F  S DFN=$O(^DPT("SSN",SSN,DFN)) Q:'DFN  I $E($TR($P($G(^DPT(DFN,0)),"^")," "),1,$L(NAME))=NAME S COUNT=COUNT+1,FOUND=DFN
 ;  multiple acct matches, return null
 I COUNT>1 Q 0
 ;  acct found, return dfn of account which matches
 I FOUND Q FOUND
 ;  try looking up the name without the apostrophe
 S NAME=$TR(NAME,"'")
 S DFN=0 F  S DFN=$O(^DPT("SSN",SSN,DFN)) Q:'DFN  I $E($TR($P($G(^DPT(DFN,0)),"^")," "),1,$L(NAME))=NAME S COUNT=COUNT+1,FOUND=DFN
 ;  multiple acct matches, return null
 I COUNT>1 Q 0
 ;  return dfn of account which matches, or 0 if not found
 Q +FOUND
 ;
 ;
FILETRAN(RECTDA,TRANDA,DR) ;  file the payment transaction
 N %,D,D0,D1,DA,DI,DIC,DICR,DIE,DIG,DIH,DIU,DIV,DIW,DQ,X,Y
 S (DIC,DIE)="^RCY(344,"_RECTDA_",1,"
 S DA=TRANDA,DA(1)=RECTDA
 D ^DIE
 Q
