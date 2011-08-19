RCRJRCOB ;WISC/RFJ-calculate a bills balance ;1 Mar 97
 ;;4.5;Accounts Receivable;**68,96,103,153,156**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
BILLBAL(BILLDA,DATEEND) ;  find bills balance on dateend
 ;  returns principal ^ interest ^ admin ^ mf ^ cc
 N ACTDATE,ADMIN,CC,DATA1,DATA7,INTEREST,LASTTRAN,MF,PRINBAL,TRANDA,TYPE,VALUE
 ;
 ;  bill activated after dateend
 S ACTDATE=$P($P($G(^PRCA(430,BILLDA,6)),"^",21),".")
 I 'ACTDATE!(ACTDATE>DATEEND) Q "^^^^"
 ;
 ;  this lock cannot fail and must be executed to prevent bill
 ;  activity during the calculation of the bills balance
 L +^PRCA(430,BILLDA)
 ;
 ;  try and find last 433 transaction
 S LASTTRAN=999999999999 F  S LASTTRAN=$O(^PRCA(433,"C",BILLDA,LASTTRAN),-1) Q:'LASTTRAN  S DATA1=$G(^PRCA(433,LASTTRAN,1)) I $P($P(DATA1,"^",9),".")'>DATEEND,$P(DATA1,"^",2)'=45 Q
 ;
 ;  there are no transactions in file 433
 I 'LASTTRAN  D  G UNLOCK
 .   S PRINBAL=+$P($G(^PRCA(430,BILLDA,0)),"^",3)
 .   S (INTEREST,ADMIN,MF,CC)=0
 ;
 ;  the last transaction may not be in date order
 S TRANDA=LASTTRAN F  S TRANDA=$O(^PRCA(433,"C",BILLDA,TRANDA)) Q:'TRANDA  I $P($P($G(^PRCA(433,TRANDA,1)),"^",9),".")'>DATEEND S LASTTRAN=TRANDA
 ;
 ;  the last transaction was during time period, use bill balance
 I '$O(^PRCA(433,"C",BILLDA,LASTTRAN)) D  G UNLOCK
 .   S DATA7=$G(^PRCA(430,BILLDA,7))
 .   S PRINBAL=+$P(DATA7,"^")
 .   S INTEREST=+$P(DATA7,"^",2)
 .   S ADMIN=$P(DATA7,"^",3)
 .   S MF=$P(DATA7,"^",4)
 .   S CC=$P(DATA7,"^",5)
 ;
 ;  calculate balance
 S DATA7=$G(^PRCA(430,BILLDA,7))
 S PRINBAL=+$P(DATA7,"^")
 S INTEREST=+$P(DATA7,"^",2)
 S ADMIN=$P(DATA7,"^",3)
 S MF=$P(DATA7,"^",4)
 S CC=$P(DATA7,"^",5)
 ;
 ;  if the bill's status is write-off, balance and int = 0
 I $P($G(^PRCA(430,BILLDA,0)),"^",8)=23 S (PRINBAL,INTEREST,ADMIN,MF,CC)=0
 ;
 S TRANDA=LASTTRAN
 F  S TRANDA=$O(^PRCA(433,"C",BILLDA,TRANDA)) Q:'TRANDA  I $P($G(^PRCA(433,TRANDA,0)),"^",4)=2 D
 .   S VALUE=$$TRANBAL^RCRJRCOT(TRANDA) I VALUE="" Q
 .   ;
 .   S TYPE=$P($G(^PRCA(433,TRANDA,1)),"^",2)
 .   I TYPE=1!(TYPE=12)!(TYPE=13)!(TYPE=43) D  Q
 .   .   S PRINBAL=PRINBAL-$P(VALUE,"^")
 .   .   S INTEREST=INTEREST-$P(VALUE,"^",2)
 .   .   S ADMIN=ADMIN-$P(VALUE,"^",3)
 .   .   S MF=MF-$P(VALUE,"^",4)
 .   .   S CC=CC-$P(VALUE,"^",5)
 .   I TYPE=2!(TYPE=8)!(TYPE=9)!(TYPE=10)!(TYPE=11)!(TYPE=14)!(TYPE=29)!(TYPE=34)!(TYPE=35)!(TYPE=41) D  Q
 .   .   S PRINBAL=PRINBAL+$P(VALUE,"^")
 .   .   S INTEREST=INTEREST+$P(VALUE,"^",2)
 .   .   S ADMIN=ADMIN+$P(VALUE,"^",3)
 .   .   S MF=MF+$P(VALUE,"^",4)
 .   .   S CC=CC+$P(VALUE,"^",5)
 ;
 ;  do not allow balances to be negative
 I PRINBAL<0 S PRINBAL=0
 ;  for transaction type 2,9,14, admin could not be broken out separate
 ;  if its negative, add it to interest
 I ADMIN<0 S INTEREST=INTEREST+ADMIN,ADMIN=0
 I INTEREST<0 S ADMIN=ADMIN+INTEREST,INTEREST=0
 ;
UNLOCK ;  come here to unlock global and return results  
 L -^PRCA(430,BILLDA)
 ;
 Q PRINBAL_"^"_INTEREST_"^"_ADMIN_"^"_MF_"^"_CC
 ;
 ;
CURRENT(BILLDA,DATEEND,AYEAROLD) ; finds a bills balance and age
 N DA,DATA4,COUNTCUR,CURRAMT,FUTURAMT,INTEREST,NONCURR,PRINBAL,RCVALUE,TOTREPAY
 ;
 ;  find a bills balance
 S RCVALUE=$$BILLBAL(BILLDA,DATEEND)
 ;
 ;  count as a current receivable
 D CURRENT^RCRJRCOC(BILLDA,RCVALUE)
 ;
 S PRINBAL=$P(RCVALUE,"^"),INTEREST=$P(RCVALUE,"^",2)+$P(RCVALUE,"^",3)+$P(RCVALUE,"^",4)+$P(RCVALUE,"^",5)
 ;  if no repay plan date or its greater than date range or no amt due
 S DATA4=$G(^PRCA(430,BILLDA,4))
 I '$P(DATA4,"^")!($P($P(DATA4,"^"),".")>DATEEND)!('$P(DATA4,"^",3)) D SETTOTAL^RCRJRCO1(2,PRINBAL,INTEREST),AGE Q
 ;
 ;  total number of repayment due dates
 S TOTREPAY=$P($G(^PRCA(430,BILLDA,5,0)),"^",3)
 I 'TOTREPAY D SETTOTAL^RCRJRCO1(2,PRINBAL,INTEREST),AGE Q
 ;
 ;  count the number of current repayments (less than yr old)
 S DA=0 F COUNTCUR=0:1 S DA=$O(^PRCA(430,BILLDA,5,DA)) Q:'DA!($P($G(^(DA,0)),"^")>AYEAROLD)
 ;
 ;  how many repayments are non-current
 S NONCURR=TOTREPAY-COUNTCUR
 ;  all are current
 I 'NONCURR D SETTOTAL^RCRJRCO1(2,PRINBAL,INTEREST),AGE Q
 ;
 ;  future amount = noncurrent bills * repayment amount due
 S FUTURAMT=NONCURR*$P(DATA4,"^",3),CURRAMT=PRINBAL-FUTURAMT
 ;  no current amt (all future)
 I 'CURRAMT D SETTOTAL^RCRJRCO1(12,FUTURAMT,INTEREST),AGE Q
 ;
 D SETTOTAL^RCRJRCO1(2,CURRAMT,INTEREST)
 D SETTOTAL^RCRJRCO1(12,FUTURAMT,0)
 D AGE
 Q
 ;
 ;
AGE ;  finds the age of delinquents
 ;  the date the 2nd letter was sent
 N DAYSDIFF,LETRDATE
 S LETRDATE=$P($P($G(^PRCA(430,BILLDA,6)),"^",2),".")
 I 'LETRDATE!(LETRDATE>DATEEND) Q
 ;
 S DAYSDIFF=$$FMDIFF^XLFDT(DATEEND,LETRDATE,1)
 ;  pass criteria 2 based on days difference
 D SETTOTAL^RCRJRCO1($S(DAYSDIFF<31:3,DAYSDIFF<61:4,DAYSDIFF<91:5,DAYSDIFF<121:6,DAYSDIFF<181:7,DAYSDIFF<366:8,DAYSDIFF<731:9,DAYSDIFF<1096:10,1:11),PRINBAL,INTEREST)
 Q
