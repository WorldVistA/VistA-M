RCBEUTR2 ;WISC/RFJ - create an exempt transaction                      ;1 Jun 00
 ;;4.5;Accounts Receivable;**153,169,353,377**;Mar 20, 1995;Build 45
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ;PRCA*4.5*353 Added RCVALL flag parameter to ensure
 ;             Marshall Cost and Court Cost are used
 ;             as correct total increase when clearing
 ;             all associated cost when Principal value
 ;             goes to zero via a decrease transaction
 ;
EXEMPT(RCBILLDA,RCVALUE,RCCOMMNT,RCDATE,RCVALL) ;  exempt an intererst/admin charge
 ;  for a bill.  rcvalue = interest ^ admin ^ penalty ^ mf ^ cc
 ;  for the transaction.  rcdate = process date (optional)
 ;  rcval indicates to also account for marshall cost & court cost in value calc
 ;  returns transaction number if successful
 ;
 N RCDRSTRG,RCTRANDA,Y,RCDTOTL,RCDATA7,RCTOTB
 ;  add the transaction (if added to 433, transaction is locked)
 S RCTRANDA=$$ADD433^RCBEUTRA(RCBILLDA,14) I 'RCTRANDA Q 0
 ;
 ;  build dr string
 ;  transaction date (strip off time)
 S RCDRSTRG="11////"_$S($G(RCDATE):$P(RCDATE,"."),1:DT)_";"
 ;  transaction values
 S RCDTOTL=0 S RCDTOTL=$P(RCVALUE,"^")+$P(RCVALUE,"^",2)+$P(RCVALUE,"^",3)   ;PRCA*4.5*353
 I $G(RCVALL) D   ;PRCA*4.5*353
 . S RCDTOTL=RCDTOTL+$P(RCVALUE,"^",4)+$P(RCVALUE,"^",5)
 . S RCCOMMNT(1)=RCCOMMNT
 S RCDRSTRG=RCDRSTRG_"15////"_RCDTOTL_";"   ;PRCA*4.5*353
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
 ;PRCA*4.5*377 - update Repayment Plan with Exemption amount
 D UPDBAL^RCRPU1(RCBILLDA,RCTRANDA)
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
