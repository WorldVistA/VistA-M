RCBMILLT ;WISC/RFJ-millennium bill (get TR data) ;1 Oct 01
 ;;4.5;Accounts Receivable;**170**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
GETPAY(RCDATEND) ;  get payments for the month
 ;  returns rctrans(fromfund,fromrsc) = tofund ^ torsc ^ amount to transfer
 ;  fromfund is 5287 and tofund is 5358.1
 ;
 N DATA,RCBILLDA,RCRSC,RCTOTAL,RCTRANDA,TORCRSC
 ;
 S RCBILLDA=0 F  S RCBILLDA=$O(^TMP($J,"RCBMILLDATA",RCBILLDA)) Q:'RCBILLDA  D
 .   ;  get the rsc for the bill
 .   S RCRSC=$$CALCRSC^RCXFMSUR(RCBILLDA)
 .   ;
 .   S RCTRANDA=0 F  S RCTRANDA=$O(^TMP($J,"RCBMILLDATA",RCBILLDA,RCTRANDA)) Q:'RCTRANDA  D
 .   .   ;
 .   .   ;  data piece 1 = type of transaction (1 letter)
 .   .   ;  data piece 2 = principal amt of transaction
 .   .   ;  data piece 3 = amount owed to mccf
 .   .   ;  data piece 4 = amount owed to hsif
 .   .   ;  data piece 5 = for payment, amount already paid to mccf
 .   .   ;  data piece 6 = for payment, amount already paid to hsif
 .   .   S DATA=^TMP($J,"RCBMILLDATA",RCBILLDA,RCTRANDA)
 .   .   ;
 .   .   ;  only count payments
 .   .   I $E(DATA)'="P" Q
 .   .   ;
 .   .   ;  only report the transfer if the payment was during the
 .   .   ;  current month
 .   .   I +$E($P($G(^PRCA(433,RCTRANDA,1)),"^",9),1,5)'=+$E(RCDATEND,1,5) Q
 .   .   ;
 .   .   ;  total the amount to transfer to hsif
 .   .   ;  (payment value is stored as a minus)
 .   .   S RCTOTAL(RCRSC)=$G(RCTOTAL(RCRSC))-$P(DATA,"^",4)
 ;
 ;  put dollars in rctrans(fromfund,fromrsc) = tofund ^ torsc ^ amount
 K RCTRANS
 S RCRSC="" F  S RCRSC=$O(RCTOTAL(RCRSC)) Q:RCRSC=""  D
 .   ;  if the rsc for the bill is 8BZZ, transfer to 8B1Z
 .   ;  if the rsc for the bill is 8CZZ, transfer to 8C1Z
 .   I RCRSC="8BZZ" S TORCRSC="8B1Z"
 .   I RCRSC="8CZZ" S TORCRSC="8C1Z"
 .   I RCTOTAL(RCRSC) S RCTRANS(5287,RCRSC)="5358.1^"_TORCRSC_"^"_RCTOTAL(RCRSC)
 Q
 ;
 ;
SETPAY(RCDATEND) ;  set payments for the month
 ;  this call will set the 433 transaction showing the dollars
 ;  transferred to hsif on the payment (fields 91 and 92)
 ;
 N DATA,RCBILLDA,RCTRANDA
 ;
 S RCBILLDA=0 F  S RCBILLDA=$O(^TMP($J,"RCBMILLDATA",RCBILLDA)) Q:'RCBILLDA  D
 .   ;
 .   S RCTRANDA=0 F  S RCTRANDA=$O(^TMP($J,"RCBMILLDATA",RCBILLDA,RCTRANDA)) Q:'RCTRANDA  D
 .   .   ;
 .   .   ;  data piece 1 = type of transaction (1 letter)
 .   .   ;  data piece 2 = principal amt of transaction
 .   .   ;  data piece 3 = amount owed to mccf
 .   .   ;  data piece 4 = amount owed to hsif
 .   .   ;  data piece 5 = for payment, amount already paid to mccf
 .   .   ;  data piece 6 = for payment, amount already paid to hsif
 .   .   S DATA=^TMP($J,"RCBMILLDATA",RCBILLDA,RCTRANDA)
 .   .   ;
 .   .   ;  only count payments
 .   .   I $E(DATA)'="P" Q
 .   .   ;
 .   .   ;  only report the transfer if the payment was during the
 .   .   ;  current month
 .   .   I +$E($P($G(^PRCA(433,RCTRANDA,1)),"^",9),1,5)'=+$E(RCDATEND,1,5) Q
 .   .   ;
 .   .   ;  set as paid
 .   .   S $P(^PRCA(433,RCTRANDA,9),"^",1,2)=(-$P(DATA,"^",3))_"^"_(-$P(DATA,"^",4))
 Q
