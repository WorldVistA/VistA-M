RCRJRCOT ;WISC/RFJ-calculate a transactions balance ;1 Mar 97
 ;;4.5;Accounts Receivable;**68,134,103,153,168*;Mar 20, 1995
 Q
 ;
 ;
TRANBAL(TRANDA)    ;  gets a transactions balance
 ;  returns principal ^ interest ^ admin cost ^ mf ^ cc
 N ADMIN,COURT,DATA1,DATA2,DATA3,DATA8,INTEREST,MARSHAL,PRINBAL,TRANTYPE
 ;  transaction not valid
 I '$$VALID(TRANDA) Q ""
 S DATA1=$G(^PRCA(433,TRANDA,1))
 S PRINBAL=$P(DATA1,"^",5),INTEREST="",ADMIN="",MARSHAL="",COURT=""
 ;
 S TRANTYPE=+$P(DATA1,"^",2)
 I $T(@TRANTYPE)'="" D @TRANTYPE
 ;
 Q PRINBAL_"^"_INTEREST_"^"_ADMIN_"^"_MARSHAL_"^"_COURT
 ;
 ;
 ;
 ;
1 ;  increase adjustment
 S PRINBAL=+$P(DATA1,"^",5),(INTEREST,ADMIN,MARSHAL,COURT)=""
 Q
 ;
 ;
2 ;  payment
 S DATA3=$G(^PRCA(433,TRANDA,3))
 S PRINBAL=+$P(DATA3,"^")
 S INTEREST=+$P(DATA3,"^",2)
 S ADMIN=+$P(DATA3,"^",3)
 S MARSHAL=+$P(DATA3,"^",4)
 S COURT=+$P(DATA3,"^",5)
 Q
 ;
 ;
3 ;  refer to district counsel
 S PRINBAL=+$P(DATA1,"^",5),(INTEREST,ADMIN,MARSHAL,COURT)=""
 Q
 ;
 ;
8 ;  terminate by fiscal officer
 S DATA8=$G(^PRCA(433,TRANDA,8))
 S PRINBAL=+$P(DATA8,"^")
 S INTEREST=+$P(DATA8,"^",2)
 S ADMIN=+$P(DATA8,"^",3)
 S MARSHAL=+$P(DATA8,"^",4)
 S COURT=+$P(DATA8,"^",5)
 ;
 ;  if data8 node not defined, lookup on bill
 ;  once patch 146 gets out, this can be removed
 I $TR($P(DATA8,"^",1,5),"^0")="" D
 .   N BILLDA,DATA7
 .   S BILLDA=+$P(^PRCA(433,TRANDA,0),"^",2)
 .   S DATA7=$P($G(^PRCA(430,BILLDA,7)),"^",1,5)
 .   S PRINBAL=+$P(DATA7,"^")
 .   S INTEREST=+$P(DATA7,"^",2)
 .   S ADMIN=+$P(DATA7,"^",3)
 .   S MARSHAL=+$P(DATA7,"^",4)
 .   S COURT=+$P(DATA7,"^",5)
 Q
 ;
 ;
9 ;  terminate by compromise
 D 8
 Q
 ;
 ;
10 ;  payment waived in full
 D 8
 Q
 ;
 ;
11 ;  payment waived in partial
 D 8
 Q
 ;
 ;
12 ;  admin cost / charge
 S DATA2=$G(^PRCA(433,TRANDA,2))
 S PRINBAL=""
 S INTEREST=+$P(DATA2,"^",7)
 S ADMIN=$P(DATA2,"^")+$P(DATA2,"^",2)+$P(DATA2,"^",3)+$P(DATA2,"^",4)+$P(DATA2,"^",8)+$P(DATA2,"^",9)
 S MARSHAL=+$P(DATA2,"^",5)
 S COURT=+$P(DATA2,"^",6)
 Q
 ;
 ;
13 ;  interest / admin charge
 D 12
 Q
 ;
 ;
14 ;  exempt interest / admin cost
 S PRINBAL=""
 S DATA2=$G(^PRCA(433,TRANDA,2))
 S INTEREST=$P(DATA2,"^",7)
 S ADMIN=$P(DATA2,"^")+$P(DATA2,"^",2)+$P(DATA2,"^",3)+$P(DATA2,"^",4)+$P(DATA2,"^",8)+$P(DATA2,"^",9)
 S MARSHAL=+$P(DATA2,"^",5)
 S COURT=+$P(DATA2,"^",6)
 ;  prior to patch 103, exempt interest and admin charges could
 ;  not be broken out
 I (INTEREST+ADMIN+MARSHAL+COURT)'=$P(DATA1,"^",5) S INTEREST=$P(DATA1,"^",5),ADMIN="",MARSHAL="",COURT=""
 Q
 ;
 ;
29 ;  terminate by rc/doj
 D 8
 Q
 ;
 ;
34 ;  payment in full
 D 2
 Q
 ;
 ;
35 ;  decrease adjustment
 S PRINBAL=+$P(DATA1,"^",5),(INTEREST,ADMIN,MARSHAL,COURT)=""
 ;  make negative amounts positive
 I PRINBAL<0 S PRINBAL=-PRINBAL
 Q
 ;
 ;
41 ;  refund
 S PRINBAL=+$P(DATA1,"^",5),(INTEREST,ADMIN,MARSHAL,COURT)=""
 ;  make negative amounts positive
 I PRINBAL<0 S PRINBAL=-PRINBAL
 Q
 ;
 ;
43 ;  re-establishment
 S DATA8=$G(^PRCA(433,TRANDA,8))
 S PRINBAL=+$P(DATA8,"^")
 S INTEREST=+$P(DATA8,"^",2)
 S ADMIN=+$P(DATA8,"^",3)
 S MARSHAL=+$P(DATA8,"^",4)
 S COURT=+$P(DATA8,"^",5)
 Q
 ;
 ;
46 ;  unsuspended
 S DATA8=$G(^PRCA(433,TRANDA,8))
 S PRINBAL=+$P(DATA8,"^")
 S INTEREST=+$P(DATA8,"^",2)
 S ADMIN=+$P(DATA8,"^",3)
 S MARSHAL=+$P(DATA8,"^",4)
 S COURT=+$P(DATA8,"^",5)
 Q
 ;
 ;
47 ;  suspended
 D 46
 Q
 ;
 ;
TRANAMT(TRANDA) ;  calculate transaction amount for transaction tranda
 N %,AMT
 S AMT=0
 S %=0 F  S %=$O(^PRCA(433,TRANDA,4,%)) Q:'%  S AMT=AMT+$P($G(^(%,0)),"^",5)
 Q AMT
 ;
 ;
VALID(TRANDA) ;  test to see if a transaction is valid
 ;  return 1 if it is, 0 if not
 ;  date entered is not set (this is the processed date)
 I '$P($G(^PRCA(433,TRANDA,1)),"^",9) Q 0
 N DATA0
 S DATA0=$G(^PRCA(433,TRANDA,0))
 ;  transaction status is not complete (2)
 I $P(DATA0,"^",4)'=2 Q 0
 ;  incomplete transaction flag set (invalid transaction)
 ;I $P(DATA0,"^",10) Q 0
 Q 1
