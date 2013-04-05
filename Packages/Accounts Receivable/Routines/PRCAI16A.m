PRCAI16A ;WISC/RFJ-post init patch 169 continued ; 1 Apr 01
 ;;4.5;Accounts Receivable;**169**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
START ;  start post init (fix exempt transactions)
 ;  break out the exempt transaction to interest and admin
 N RCDATE,RCTRANDA
 ;
 ;  start finding exempt transactions and fixing them
 S RCDATE=9999999 F  S RCDATE=$O(^PRCA(433,"AT",14,RCDATE),-1) Q:'RCDATE  D
 .   S RCTRANDA=999999999999999
 .   F  S RCTRANDA=$O(^PRCA(433,"AT",14,RCDATE,RCTRANDA),-1) Q:'RCTRANDA  D FIXEXEM(RCTRANDA)
 Q
 ;
 ;
FIXEXEM(RCTRANDA) ;  fix an exempt charge
 ;  if transaction status not valid, quit
 I '$$VALID^RCRJRCOT(RCTRANDA) Q
 ;
 N ADMIN,BALANCE,CC,INTEREST,MF,RCBALANC,RCBILLDA,RCDATA7,RCLIST,TRANTOTL
 ;
 L +^PRCA(433,RCTRANDA)
 ;
 ;  if node 2 already breaks out the int/admin, quit
 I $G(^PRCA(433,RCTRANDA,2))'="" L -^PRCA(433,RCTRANDA) Q
 ;
 S RCBILLDA=$P(^PRCA(433,RCTRANDA,0),"^",2)
 ;  no bill on transaction
 I 'RCBILLDA L -^PRCA(433,RCTRANDA) Q
 ;
 ;  lock the bill and get the current bill balance
 L +^PRCA(430,RCBILLDA)
 S RCBALANC=$$GETTRANS^RCDPBTLM(RCBILLDA)
 S TRANTOTL=$P(^PRCA(433,RCTRANDA,1),"^",5) I 'TRANTOTL D UNLOCK Q
 ;
 ;  if the bill is in balance and the balance is zero,
 ;  make the transaction all interest
 I $TR($P(RCBALANC,"^",2,5),"^0")="",$$OUTOFBAL^RCBDBBAL(RCBILLDA)="" S $P(^PRCA(433,RCTRANDA,2),"^",7)=TRANTOTL D UNLOCK Q
 ;
 ;  if the interest balance is equal to the admin balance and
 ;  the interest balance is zero, move to admin
 I $P(RCBALANC,"^",2)<0,-$P(RCBALANC,"^",2)=$P(RCBALANC,"^",3) D  Q
 .   S ADMIN=$P(RCBALANC,"^",3) I ADMIN>TRANTOTL S ADMIN=TRANTOTL
 .   S INTEREST=TRANTOTL-ADMIN
 .   S (MF,CC)=0
 .   D SET
 ;
 ;  if the stored interest balance minus the calculated
 ;  interest balance is equal to the transaction total
 ;  of the exemption, then the exemption is
 ;  for all admin.
 S RCDATA7=$P($G(^PRCA(430,RCBILLDA,7)),"^",1,5)
 I ($P(RCDATA7,"^",2)-$P(RCBALANC,"^",2))=TRANTOTL D  Q
 .   S (INTEREST,MF,CC)=0
 .   S ADMIN=TRANTOTL D SET
 ;
 ;  calculate the bills balance up to the exempt transaction
 S BALANCE=$$CALCBAL(0,RCTRANDA-1)
 ;
 S (INTEREST,ADMIN,MF,CC)=""
 S INTEREST=$P(BALANCE,"^",2) I INTEREST<0 S INTEREST=0
 I INTEREST'<TRANTOTL S INTEREST=TRANTOTL D SET Q
 ;
 S ADMIN=$P(BALANCE,"^",3) I ADMIN<0 S ADMIN=0
 I (INTEREST+ADMIN)'<TRANTOTL S ADMIN=TRANTOTL-INTEREST D SET Q
 ;
 S MF=$P(BALANCE,"^",4) I MF<0 S MF=0
 I (INTEREST+ADMIN+MF)'<TRANTOTL S MF=TRANTOTL-INTEREST-ADMIN D SET Q
 ;
 S CC=$P(BALANCE,"^",5) I CC<0 S CC=0
 I (INTEREST+ADMIN+MF+CC)'<TRANTOTL S CC=TRANTOTL-INTEREST-ADMIN-MF D SET Q
 ;
 ;  set as all interest
 S INTEREST=TRANTOTL,(ADMIN,MF,CC)="" D SET
 Q
 ;
 ;
SET ;  set the exempt node
 N DATA2
 S DATA2=$G(^PRCA(433,RCTRANDA,2))
 I INTEREST S $P(DATA2,"^",7)=INTEREST
 I ADMIN S $P(DATA2,"^",8)=ADMIN
 I MF S $P(DATA2,"^",5)=MF
 I CC S $P(DATA2,"^",6)=CC
 S ^PRCA(433,RCTRANDA,2)=DATA2
 D UNLOCK
 Q
 ;
 ;
UNLOCK ;  unlock the transaction and bill
 L -^PRCA(433,RCTRANDA)
 L -^PRCA(430,RCBILLDA)
 Q
 ;
 ;
CALCBAL(RCDATE,RCTRANDA) ;  calculate a bills balance
 ;  up to a certain date and/or transaction
 ;    rclist(date,tranda) must be defined from calling
 ;      gettrans^rcdpbtlm
 ;
 I 'RCDATE N RCDATE S RCDATE=9999999
 I 'RCTRANDA N RCTRANDA S RCTRANDA=999999999999999
 ;
 N ADMBAL,CCBAL,DATE,INTBAL,MFBAL,PRINBAL,TRANDA,RCSTOP
 S (PRINBAL,INTBAL,ADMBAL,MFBAL,CCBAL)=0
 ;
 S DATE="" F  S DATE=$O(RCLIST(DATE)) Q:DATE=""!($G(RCSTOP))  D
 .   I $E(DATE,1,7)>$E(RCDATE,1,7) S RCSTOP=1 Q
 .   ;
 .   S TRANDA="" F  S TRANDA=$O(RCLIST(DATE,TRANDA)) Q:TRANDA=""  D
 .   .   I TRANDA>RCTRANDA S RCSTOP=1 Q
 .   .   ;
 .   .   S PRINBAL=PRINBAL+$P(RCLIST(DATE,TRANDA),"^",2)
 .   .   S INTBAL=INTBAL+$P(RCLIST(DATE,TRANDA),"^",3)
 .   .   S ADMBAL=ADMBAL+$P(RCLIST(DATE,TRANDA),"^",4)
 .   .   S MFBAL=MFBAL+$P(RCLIST(DATE,TRANDA),"^",5)
 .   .   S CCBAL=CCBAL+$P(RCLIST(DATE,TRANDA),"^",6)
 ;
 Q PRINBAL_"^"_INTBAL_"^"_ADMBAL_"^"_MFBAL_"^"_CCBAL
