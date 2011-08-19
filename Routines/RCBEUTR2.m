RCBEUTR2 ;WISC/RFJ-create an exempt transaction                      ;1 Jun 00
 ;;4.5;Accounts Receivable;**153,169**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
EXEMPT(RCBILLDA,RCVALUE,RCCOMMNT,RCDATE) ;  exempt an intererst/admin charge
 ;  for a bill.  rcvalue = interest ^ admin ^ penalty ^ mf ^ cc
 ;  for the transaction.  rcdate = process date (optional)
 ;  returns transaction number if successful
 ;
 N RCDRSTRG,RCTRANDA,Y
 ;  add the transaction (if added to 433, transaction is locked)
 S RCTRANDA=$$ADD433^RCBEUTRA(RCBILLDA,14) I 'RCTRANDA Q 0
 ;
 ;  build dr string
 ;  transaction date (strip off time)
 S RCDRSTRG="11////"_$S($G(RCDATE):$P(RCDATE,"."),1:DT)_";"
 ;  transaction values
 S RCDRSTRG=RCDRSTRG_"15////"_($P(RCVALUE,"^")+$P(RCVALUE,"^",2)+$P(RCVALUE,"^",3))_";"
 I $P(RCVALUE,"^",1) S RCDRSTRG=RCDRSTRG_"27////"_$P(RCVALUE,"^",1)_";"  ;interest
 I $P(RCVALUE,"^",2) S RCDRSTRG=RCDRSTRG_"28////"_$P(RCVALUE,"^",2)_";"  ;admin
 I $P(RCVALUE,"^",3) S RCDRSTRG=RCDRSTRG_"29////"_$P(RCVALUE,"^",3)_";"  ;penalty
 I $P(RCVALUE,"^",4) S RCDRSTRG=RCDRSTRG_"25////"_$P(RCVALUE,"^",4)_";"  ;mf
 I $P(RCVALUE,"^",5) S RCDRSTRG=RCDRSTRG_"26////"_$P(RCVALUE,"^",5)_";"  ;cc
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
 ;  mark the transaction as processed
 D PROCESS^RCBEUTRA(RCTRANDA)
 ;
 ;  update the bill file with the balance of the transaction
 D SETBAL^RCBEUBIL(RCTRANDA)
 ;
 ;  if the bill has no balance, close or cancel it
 D CLOSEIT^RCBEUTR1(RCBILLDA)
 ;
 ;  clear the lock and return the transaction added
 L -^PRCA(433,RCTRANDA)
 Q RCTRANDA
