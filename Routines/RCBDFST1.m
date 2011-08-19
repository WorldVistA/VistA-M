RCBDFST1 ;WISC/RFJ-patient statement utilities continued             ;1 Dec 00
 ;;4.5;Accounts Receivable;**162**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
CHEKACCT(RCDEBTDA) ;  check to see if a debtor is in balance
 ;  returns null if in balance, or the calculated statement
 ;  if out of balance
 ;  returns rcbilbal,rcevent,rcnewact,rcstate,rclastev
 ;  returns ^tmp("rcbdfst1",$j ... (see NEWTRANS below)
 ;
 N %,DATA1,OUTOFBAL
 ;  get the current balance of all active bills
 D BILLBAL(RCDEBTDA)
 ;  get the last statement, rclastev=ien file 341 ^ statement date
 S RCLASTEV=$$LASTEVNT(RCDEBTDA)
 I RCLASTEV L +^RC(341,+RCLASTEV)
 ;  get the last statement balance
 D EVENTBAL(+RCLASTEV)
 ;  get new activity after the statement date
 D NEWTRANS(RCDEBTDA,$P(RCLASTEV,"^",2),9999999)
 ;  test for out of balance
 ;  out of balance if the statement balance +/- new activity
 ;  does not equal the current bill balance
 S OUTOFBAL=""
 F %="PB","IN","AD","MF","CC" D
 .   ;  copy current statement to rcstate, rcstate used to track
 .   ;  what the statement balance should be
 .   S RCSTATE(%)=RCEVENT(%)
 .   I RCEVENT(%)+RCNEWACT(%)=RCBILBAL(%) Q
 .   S OUTOFBAL=1
 .   S RCSTATE(%)=RCBILBAL(%)-RCNEWACT(%)
 ;  compute calculated statement total
 S RCSTATE=0
 F %="PB","IN","AD","MF","CC" S RCSTATE=RCSTATE+RCSTATE(%)
 ;
 I OUTOFBAL S OUTOFBAL=RCSTATE("PB")_"^"_RCSTATE("IN")_"^"_RCSTATE("AD")_"^"_RCSTATE("CC")_"^"_RCSTATE("MF")
 ;
 L -^RC(341,+RCLASTEV)
 Q OUTOFBAL
 ;
 ;
BILLBAL(DEBTDA) ;  get the bill balances for a debtor
 ;  returns array RCBILBAL("PB")=principal balance
 ;                RCBILBAL("IN")=interest balance
 ;                RCBILBAL("AD")=admin balance
 ;                RCBILBAL("MF")=marshal fee balance
 ;                RCBILBAL("CC")=court cost balance
 ;                RCBILBAL      =total balance
 N %,BILLDA,DATA7,STATUS
 ;  initialize
 S RCBILBAL=0
 F %="PB","IN","AD","MF","CC" S RCBILBAL(%)=0
 ;
 ;  for active, open, and refund review (for prepayments),
 ;  calc bill balance
 F STATUS=16,42,44 S BILLDA=0 F  S BILLDA=$O(^PRCA(430,"AS",DEBTDA,STATUS,BILLDA)) Q:'BILLDA  D
 .   S DATA7=$P($G(^PRCA(430,BILLDA,7)),"^",1,5)
 .   ;  if prepayment, subtract it from active bills principal balance
 .   I $P($G(^PRCA(430,BILLDA,0)),"^",2)=26 S RCBILBAL("PB")=RCBILBAL("PB")-$P(DATA7,"^") Q
 .   ;  add balances
 .   S RCBILBAL("PB")=RCBILBAL("PB")+$P(DATA7,"^")    ;principal
 .   S RCBILBAL("IN")=RCBILBAL("IN")+$P(DATA7,"^",2)  ;interest
 .   S RCBILBAL("AD")=RCBILBAL("AD")+$P(DATA7,"^",3)  ;admin
 .   S RCBILBAL("MF")=RCBILBAL("MF")+$P(DATA7,"^",4)  ;marshal fee
 .   S RCBILBAL("CC")=RCBILBAL("CC")+$P(DATA7,"^",5)  ;court cost
 ;
 ;  compute total
 F %="PB","IN","AD","MF","CC" S RCBILBAL=RCBILBAL+RCBILBAL(%)
 Q
 ;
 ;
NEWTRANS(DEBTDA,BEGDATE,ENDDATE) ;  get new transaction activity between dates
 ;  returns global array
 ;    tmp("rcbdfst1",$j,account,transactiondate,bill,transaction)=value
 ;  where
 ;    value = ^ prin ^ int ^ admin ^ mf ^ cc
 ;
 N %,BILLDA,DATE,ORIGAMT,STATUS,TRANDA,VALUE
 ;  initialize
 S RCNEWACT=0
 F %="PB","IN","AD","MF","CC" S RCNEWACT(%)=0
 K ^TMP("RCBDFST1",$J,DEBTDA)
 ;
 ;  get new bills
 S DATE=BEGDATE F  S DATE=$O(^PRCA(430,"ATD",DEBTDA,DATE)) Q:'DATE!(DATE>ENDDATE)  D
 .   S BILLDA=0 F  S BILLDA=$O(^PRCA(430,"ATD",DEBTDA,DATE,BILLDA)) Q:'BILLDA  D
 .   .   S ORIGAMT=$P($G(^PRCA(430,BILLDA,0)),"^",3)
 .   .   S ^TMP("RCBDFST1",$J,DEBTDA,DATE,BILLDA,0)=ORIGAMT
 .   .   S RCNEWACT("PB")=RCNEWACT("PB")+ORIGAMT
 ;
 ;  get transactions
 S DATE=BEGDATE F  S DATE=$O(^PRCA(433,"ATD",DEBTDA,DATE)) Q:'DATE!(DATE>ENDDATE)  D
 .   S TRANDA=0 F  S TRANDA=$O(^PRCA(433,"ATD",DEBTDA,DATE,TRANDA)) Q:'TRANDA  D
 .   .   ;  if not a valid transaction, do not include it
 .   .   I '$$VALID^RCRJRCOT(TRANDA) Q
 .   .   S BILLDA=+$P(^PRCA(433,TRANDA,0),"^",2)
 .   .   ;  get the transaction value
 .   .   S VALUE=$$TRANVALU^RCDPBTLM(TRANDA)
 .   .   ;  transaction has no value
 .   .   I $TR(VALUE,"^0")="" Q
 .   .   ;  for patient statements, if the bill is a prepayment(26),
 .   .   ;  change the sign
 .   .   I $P($G(^PRCA(430,BILLDA,0)),"^",2)=26 F %=2:1:6 S $P(VALUE,"^",%)=-$P(VALUE,"^",%)
 .   .   S ^TMP("RCBDFST1",$J,DEBTDA,DATE,BILLDA,TRANDA)=VALUE
 .   .   S RCNEWACT("PB")=RCNEWACT("PB")+$P(VALUE,"^",2)
 .   .   S RCNEWACT("IN")=RCNEWACT("IN")+$P(VALUE,"^",3)
 .   .   S RCNEWACT("AD")=RCNEWACT("AD")+$P(VALUE,"^",4)
 .   .   S RCNEWACT("MF")=RCNEWACT("MF")+$P(VALUE,"^",5)
 .   .   S RCNEWACT("CC")=RCNEWACT("CC")+$P(VALUE,"^",6)
 ;
 ;  compute total
 F %="PB","IN","AD","MF","CC" S RCNEWACT=RCNEWACT+RCNEWACT(%)
 Q
 ;
 ;
LASTEVNT(DEBTDA) ;  get last type of event for debtor patient statement (2)
 N EVENTDA,REVDATE,TYPEDA
 ;  find the inverse date of the last statement, return 0 if none
 S TYPEDA=+$O(^RC(341.1,"AC",2,0))
 S REVDATE=+$O(^RC(341,"AD",DEBTDA,TYPEDA,0))
 I 'REVDATE Q 0
 ;  find the internal entry number of the statement
 S EVENTDA=+$O(^RC(341,"AD",DEBTDA,TYPEDA,REVDATE,0))
 ;  return the internal entry number ^ last statement date
 Q EVENTDA_"^"_(9999999.999999-REVDATE)
 ;
 ;
EVENTBAL(EVENTDA) ;  get the last statement balance
 ;  returns array RCEVENT("PB")=principal balance
 ;                RCEVENT("IN")=interest balance
 ;                RCEVENT("AD")=admin balance
 ;                RCEVENT("MF")=marshal fee balance
 ;                RCEVENT("CC")=court cost balance
 ;                RCEVENT      =total balance
 N %,DATA1
 S DATA1=$G(^RC(341,EVENTDA,1))
 S RCEVENT("PB")=$P(DATA1,"^",1)  ;principal
 S RCEVENT("IN")=$P(DATA1,"^",2)  ;interest
 S RCEVENT("AD")=$P(DATA1,"^",3)  ;admin
 S RCEVENT("CC")=$P(DATA1,"^",4)  ;court cost
 S RCEVENT("MF")=$P(DATA1,"^",5)  ;marshal fee
 ;  compute total
 S RCEVENT=0
 F %="PB","IN","AD","MF","CC" S RCEVENT=RCEVENT+RCEVENT(%)
 Q
