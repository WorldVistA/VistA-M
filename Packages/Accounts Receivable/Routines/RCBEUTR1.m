RCBEUTR1 ;WISC/RFJ-add int,admin chg or increase,decrease principal  ;1 Jun 00
 ;;4.5;Accounts Receivable;**153,169,192,226,270,276**;Mar 20, 1995;Build 87
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
INTADM(RCBILLDA,RCVALUE,RCCOMMNT,RCDATE) ;  add an intererst/admin charge (transaction type=13)
 ;  for a bill.  rcvalue = interest ^ admin ^ penalty ^ marshal fee ^ court cost
 ;  for the transaction.  rcdate = process date (optional)
 ;  returns transaction number if successful
 ;
 N RCDRSTRG,RCTRANDA,Y
 ;  add the transaction (if added to 433, transaction is locked)
 S RCTRANDA=$$ADD433^RCBEUTRA(RCBILLDA,13) I 'RCTRANDA Q 0
 ;
 ;  build dr string
 ;  transaction date (strip off time)
 S RCDRSTRG="11////"_$S($G(RCDATE):$P(RCDATE,"."),1:DT)_";"
 ;
 ;  transaction values
 S RCDRSTRG=RCDRSTRG_"15////"_($P(RCVALUE,"^")+$P(RCVALUE,"^",2)+$P(RCVALUE,"^",3)+$P(RCVALUE,"^",4)+$P(RCVALUE,"^",5))_";"
 I $P(RCVALUE,"^",4) S RCDRSTRG=RCDRSTRG_"25////"_$P(RCVALUE,"^",4)_";"  ;marshal fee
 I $P(RCVALUE,"^",5) S RCDRSTRG=RCDRSTRG_"26////"_$P(RCVALUE,"^",5)_";"  ;court cost
 I $P(RCVALUE,"^",1) S RCDRSTRG=RCDRSTRG_"27////"_$P(RCVALUE,"^",1)_";"  ;interest
 I $P(RCVALUE,"^",2) S RCDRSTRG=RCDRSTRG_"28////"_$P(RCVALUE,"^",2)_";"  ;admin
 I $P(RCVALUE,"^",3) S RCDRSTRG=RCDRSTRG_"29////"_$P(RCVALUE,"^",3)_";"  ;penalty
 I $G(RCDATE) S RCDRSTRG=RCDRSTRG_"19////"_RCDATE_";"  ;date entered
 ;
 ;  input the fields for the transaction
 S Y=$$EDIT433^RCBEUTRA(RCTRANDA,RCDRSTRG) I 'Y L -^PRCA(433,RCTRANDA) Q 0
 ;
 ;  set the comment
 I $D(RCCOMMNT(1)) D ADDCOMM^RCBEUTRA(RCTRANDA,.RCCOMMNT)
 ;
 ;  move over 433 from 430 (no principal, just move it)
 D FY433^RCBEUTRA(RCTRANDA)
 ;
 ;  mark transaction as processed
 D PROCESS^RCBEUTRA(RCTRANDA)
 ;
 ;  update the bill file with the balance of the transaction
 D SETBAL^RCBEUBIL(RCTRANDA)
 ;
 ;  if the bill has no balance, close or cancel it
 D CLOSEIT(RCBILLDA)
 ;
 ;  clear the lock and return the transaction added
 L -^PRCA(433,RCTRANDA)
 Q RCTRANDA
 ;
 ; PRCA*4.5*270 add CRD flag so FMS knows this is a corrected record
 ; INCDEC(RCBILLDA,RCVALUE,RCCOMMNT,RCDATE,RCPREPAY,RCONTADJ) ;  automatically
INCDEC(RCBILLDA,RCVALUE,RCCOMMNT,RCDATE,RCPREPAY,RCONTADJ,RCCRD) ;
 ;  automatically create an increase or decrease adjustment for a bill
 ;  pass variables:
 ;      rcvalue  = principal value for the transaction.
 ;                 if rcvalue is less than zero, it will create a
 ;                 decrease adjustment.  if rcvalue is greater than
 ;                 zero, it will create an increase adjustment.
 ;      rccommnt = the comments for the word processing field.
 ;      rcdate   = optional processing date and time.  if not
 ;                 passed, the current date and time will be used
 ;      rcprepay = optional prepayment transaction.  this is the
 ;                 payment transaction applied to the bill to
 ;                 create the decrease adjustment.  this gets
 ;                 stored in field 20 (file 433).
 ;      rcontadj = optional contract adjustment.  if 1 then this
 ;                 gets stored in field 88 (file 433).
 ;      rccrd    = optional corrected flag.  If 1, then FMS must 1st cancel or delete the
 ;                 original billing document before creating the new one.
 ;
 ;  returns transaction number added to 433 if successful.
 ;
 N ADJNUMB,RCDRSTRG,RCTRANDA,X,Y,RCNEG
 ;
 ;  add the transaction (if added to 433, transaction is locked)
 S RCTRANDA=$$ADD433^RCBEUTRA(RCBILLDA,$S(RCVALUE>0:1,1:35)) I 'RCTRANDA Q 0
 ;
 ;  build dr string
 ;  11=transaction date (strip off time)
 S RCDRSTRG="11////"_$S($G(RCDATE):$P(RCDATE,"."),1:DT)_";"
 ;  transaction value (make sure it is not negative)
 I RCVALUE<0 S RCVALUE=-RCVALUE
 S RCDRSTRG=RCDRSTRG_"15////"_RCVALUE_";"
 S RCDRSTRG=RCDRSTRG_"81////"_RCVALUE_";"
 ;
 ;  get the next adjustment number if increase(1) or decrease(35)
 ;  start with the last transaction and work backwards
 S X=999999999999,ADJNUMB=1
 F  S X=$O(^PRCA(433,"C",RCBILLDA,X),-1) Q:'X  I $P($G(^PRCA(433,X,1)),"^",4) I $P(^(1),"^",2)=1!($P(^(1),"^",2)=35) S ADJNUMB=$P(^(1),"^",4)+1 Q
 S RCDRSTRG=RCDRSTRG_"14////"_ADJNUMB_";"
 ;
 ;  date entered
 I $G(RCDATE) S RCDRSTRG=RCDRSTRG_"19////"_RCDATE_";"
 ;
 ;  store the prepayment transaction
 I $G(RCPREPAY) D
 .   S RCDRSTRG=RCDRSTRG_"20////"_RCPREPAY_";"
 .   ;  for prepayments, set the incomplete transaction flag
 .   ;  this will no longer be used after patch 146 and can
 .   ;  be removed
 .   S RCDRSTRG=RCDRSTRG_"10////1;"
 ;
 ;  contract adjustment
 I $G(RCONTADJ) S RCDRSTRG=RCDRSTRG_"88///1;"
 ;
 ;  input the fields for the transaction
 S Y=$$EDIT433^RCBEUTRA(RCTRANDA,RCDRSTRG) I 'Y L -^PRCA(433,RCTRANDA) Q 0
 ;
 ;  set the comment
 I $D(RCCOMMNT(1)) D ADDCOMM^RCBEUTRA(RCTRANDA,.RCCOMMNT)
 ;
 ;  mark the transaction processed
 D PROCESS^RCBEUTRA(RCTRANDA)
 ;
 ;  update the fiscal year multiple (must be done after marked as
 ;  processed so the value is defined)
 D FYMULT^RCBEUTRA(RCTRANDA)
 ;
 ;  update the bill file with the balance of the transaction
 ; PRCA276 - add exception condition - needs to quit receipt processing when negative claim balance could result
 S RCNEG=0 D SETBAL^RCBEUBIL(RCTRANDA,.RCNEG) I RCNEG D DEL433^RCBEUTRA(RCTRANDA,"CANCELLED WORKLIST DEC ADJ TO PREVENT NEG PRIN BAL",1) L -^PRCA(433,RCTRANDA) Q "0^1"
 ;
 ;  if the bill has no balance, close or cancel it
 D CLOSEIT(RCBILLDA)
 ;
 ;  send FMS document if non-accrued (redo this later on)
 I '$$ACCK^PRCAACC(RCBILLDA) D
 .   N D0,DA,DI,DIC,DIE,DIQ2,DQ,DR,ENT,FMSNUM,GECSDATA
 .   N CATEG,DATA1,ERR
 .   S CATEG=$P($G(^PRCA(430,RCBILLDA,0)),"^",2)
 .   ;
 .   ;  category=29 champva, do not send to fms, quit
 .   I CATEG=29 Q
 .   ;
 .   ;  category=30 tricare or 32 tricare third party, and contract adj
 .   I (CATEG=30!(CATEG=32)),$P($G(^PRCA(433,RCTRANDA,8)),"^",8) D  Q
 .   .   S DATA1=$G(^PRCA(433,RCTRANDA,1))
 .   .   D EN^PRCAFWO(RCBILLDA,$P(DATA1,"^",1),$P(DATA1,"^",5),$$SITE^RCMSITE,RCTRANDA)
 .   ;
 .   ;  all other categories
 .   ;  pass trans amount(1;5),trans type(1;2),trans date(1;1)
 .   S DATA1=$G(^PRCA(433,RCTRANDA,1))
 .   ;
 .   ; PRCA*4.5*270 - pass CRD flag to FMS
 .   D EN^PRCAFBDM(RCBILLDA,$P(DATA1,"^",5),$P(DATA1,"^",2),$P(DATA1,"^",1),RCTRANDA,.ERR,$G(RCCRD))
 ;
 ;  clear the lock and return the transaction added
 L -^PRCA(433,RCTRANDA)
 Q RCTRANDA
 ;
 ;
CLOSEIT(RCBILLDA) ;  check to cancel or close bill with no balance
 N AMTPAID,BILLBAL,DATA7,TRANDA
 ;  if the bill has no balance, close or cancel it
 S DATA7=$G(^PRCA(430,RCBILLDA,7))
 S BILLBAL=$P(DATA7,"^")+$P(DATA7,"^",2)+$P(DATA7,"^",3)+$P(DATA7,"^",4)+$P(DATA7,"^",5)
 I 'BILLBAL D
 .   ;  get payments recorded against the bill.  if payments have been
 .   ;  made, then the status of the bill should be collected/closed.
 .   S AMTPAID=$P(DATA7,"^",7)+$P(DATA7,"^",8)+$P(DATA7,"^",9)+$P(DATA7,"^",10)+$P(DATA7,"^",11)
 .   I AMTPAID D CHGSTAT^RCBEUBIL(RCBILLDA,22) Q
 .   ;  if the last transaction was a decrease contract adjustment,
 .   ;  then the status will be collected/closed
 .   S TRANDA=+$O(^PRCA(433,"C",RCBILLDA,999999999999),-1)
 .   I $P($G(^PRCA(433,TRANDA,8)),"^",8) D CHGSTAT^RCBEUBIL(RCBILLDA,22) Q
 .   ;  otherwise it should be cancellation
 .   D CHGSTAT^RCBEUBIL(RCBILLDA,39)
 Q
