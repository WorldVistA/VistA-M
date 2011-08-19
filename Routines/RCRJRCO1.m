RCRJRCO1 ;WISC/RFJ/BGJ-continuation of ar data collector ;1 Mar 97
 ;;4.5;Accounts Receivable;**68,96,101,120,103,153,156,170,182,203**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
START ;  calculate ndb values from file 433 transactions
 ;  needs datebeg, dateend
 ;  total is total by category
 ;
 N ADMIN,BILLDA,DATE,INTEREST,PRINBAL,TRANDA,TRANTYPE,VALUE,RCNOHSIF
 ;
 S RCNOHSIF=$$NOHSIF^RCRJRCO() ; no HSIF (disabled)
 ;
 F TRANTYPE=1,2,3,8,9,10,11,12,13,14,34,35,41,43 D
 .   S DATE=DATEBEG-1
 .   F  S DATE=$O(^PRCA(433,"AT",TRANTYPE,DATE)) Q:'DATE!(DATE>DATEEND)  D
 .   .   S TRANDA=0
 .   .   F  S TRANDA=$O(^PRCA(433,"AT",TRANTYPE,DATE,TRANDA)) Q:'TRANDA  D
 .   .   .   S BILLDA=+$P($G(^PRCA(433,TRANDA,0)),"^",2) I 'BILLDA Q
 .   .   .   ;  bill not linked to a site
 .   .   .   I '$P($G(^PRCA(430,BILLDA,0)),"^",12) Q
 .   .   .   ;
 .   .   .   ;  get a transactions balance
 .   .   .   S VALUE=$$TRANBAL^RCRJRCOT(TRANDA) I VALUE="" Q
 .   .   .   S PRINBAL=$P(VALUE,"^"),INTEREST=$P(VALUE,"^",2),ADMIN=$P(VALUE,"^",3)+$P(VALUE,"^",4)+$P(VALUE,"^",5)
 .   .   .   ;
 .   .   .   D @TRANTYPE
 Q
 ;
 ;
1 ;  increase adjustments
 D SETTOTAL(14,PRINBAL,0)
 Q
 ;
 ;
2 ;  payment in partial
 N CATEGORY
 ;  prepayment transaction (field #20)
 I $P($G(^PRCA(433,TRANDA,5)),"^") D  Q
 . D SETTOTAL(21,PRINBAL,0)
 . I INTEREST D SETTOTAL(38,INTEREST,0)
 . I ADMIN D SETTOTAL(39,ADMIN,0)
 ;
 ;  check to see if payment is rx copay and is split between
 ;  mccf and hsif.  if the bill has been run through the
 ;  calculator, do it now and report the mccf split to the ndb.
 ;  the amount owed to mccf is in piece 3 and is returned negative
 S CATEGORY=$P(^PRCA(430,BILLDA,0),"^",2)
 I 'RCNOHSIF,PRINBAL,(CATEGORY=22!(CATEGORY=23)),'$D(^TMP($J,"RCBMILLDATA",BILLDA,TRANDA)) D
 . S %=$$BILLFUND^RCBMILLC(BILLDA)
 ;
 ; changed by patch PRCA*4.5*182 to no longer separate the mccf and
 ; hsif components.  the entire amount is now reported to the ndb.
 ;
 ;.   S PRINBAL=-$P($G(^TMP($J,"RCBMILLDATA",BILLDA,TRANDA)),"^",3)
 ;
 ;  partial payments (trantype=2), full payments (trantype=34)
 D SETTOTAL($S(TRANTYPE=2:19,1:18),PRINBAL,0)
 I INTEREST D SETTOTAL(38,INTEREST,0)
 I ADMIN D SETTOTAL(39,ADMIN,0)
 ;
 ;  irs, district counsel, dept of justice (#7)
 S %=$P($G(^PRCA(433,TRANDA,0)),"^",7) I %="" Q
 I %="IRS" D SETTOTAL(28,PRINBAL,0) Q
 I %="DC" D SETTOTAL(31,PRINBAL,0) Q
 I %="DOJ" D SETTOTAL(34,PRINBAL,0) Q
 Q
 ;
 ;
3 ;  refer to district counsel
 D SETTOTAL(30,PRINBAL,0)
 Q
 ;
 ;
8 ;  terminate by fiscal officer
 D WRITEOFF^RCRJRCOC(BILLDA,VALUE,$S(TRANTYPE=8:25,1:24))
 ;  decrease in number of debts
 I '$D(^TMP($J,"RCRJRCOL","COUNT",BILLDA,17)) D SETTOTAL(17,0,0)
 Q
 ;
 ;
9 ;  terminate by compromise
 D 8
 Q
 ;
 ;
10 ;  payment waived in full
 D WRITEOFF^RCRJRCOC(BILLDA,VALUE,22)
 Q
 ;
 ;
11 ;  payment waived in partial
 D WRITEOFF^RCRJRCOC(BILLDA,VALUE,23)
 Q
 ;
 ;
12 ;  admin cost / charge
 ;  interest/admin added
 I INTEREST>0 D SETTOTAL(40,INTEREST,0)
 I ADMIN>0 D SETTOTAL(41,ADMIN,0)
 ;  interest/admin cost exempt
 I INTEREST<0 D SETTOTAL(42,-INTEREST,0)
 I ADMIN<0 D SETTOTAL(42,-ADMIN,0)
 Q
 ;
 ;
13 ;  interest / admin charge
 D 12
 Q
 ;
 ;
14 ;  exempt interest / admin cost
 D SETTOTAL(42,INTEREST,0)
 Q
 ;
 ;
34 ;  payment in full
 D 2
 ;  decrease in number of debts
 I '$D(^TMP($J,"RCRJRCOL","COUNT",BILLDA,17)) D SETTOTAL(17,0,0)
 Q
 ;
 ;
35 ;  decrease adjustment
 N CONTRACT
 ;  contractual adjustment (field #88)
 S CONTRACT=$P($G(^PRCA(433,TRANDA,8)),"^",8)
 I CONTRACT D WRITEOFF^RCRJRCOC(BILLDA,VALUE,20) Q
 D SETTOTAL(16,PRINBAL,0)
 Q
 ;
 ;
41 ;  refund
 D SETTOTAL(43,PRINBAL,0)
 Q
 ;
 ;
43 ;  re-establishment
 D SETTOTAL(13,PRINBAL,INTEREST+ADMIN)
 Q
 ;
 ;
SETTOTAL(CRITER2,AMOUNT,INTEREST) ;  store results
 N RSC,TYPE
 ;
 ;  this line of code will prevent duplicate counts if a sites cross
 ;  references in file 430 (actdt and asdt) are duplicated (incorrect)
 I CRITER2<13,$D(^TMP($J,"RCRJRCOL","COUNT",BILLDA,CRITER2)) Q
 ;
 ;  get a bills criteria 1,3,4,5
 S CRITERIA=$G(^TMP($J,"RCRJRCOL","CRITERIA",BILLDA))
 I CRITERIA="" S CRITERIA=$$CRITERIA^RCRJRCOL(BILLDA),^TMP($J,"RCRJRCOL","CRITERIA",BILLDA)=CRITERIA
 ;
 ;  store for ndb
 S $P(CRITERIA,"-",2)=CRITER2
 ;
 ;  store results for ndb
 S %=$G(@DATASTOR)
 S $P(%,"^")=$P(%,"^")+1
 S $P(%,"^",2)=$P(%,"^",2)+AMOUNT
 S $P(%,"^",3)=$P(%,"^",3)+INTEREST
 S @DATASTOR=%
 ;
 ;  keep a count of which category (criter2) a bill is counted in
 S ^TMP($J,"RCRJRCOL","COUNT",BILLDA,CRITER2)=""
 S ^TMP($J,"RCRJRCOL","CRIT2",CRITER2,BILLDA)=""
 ;
 ;  pick up bills with activity which may not have been picked up as
 ;  a current receivable because of the wrong status date
 I CRITER2>13,CRITER2'=17,'$D(^TMP($J,"RCRJRCOL","COUNT",BILLDA,1)),'$D(^TMP($J,"RCRJRCOL","COUNT",BILLDA,17)) D CURRENT^RCRJRCOB(BILLDA,DATEEND,AYEAROLD)
 Q
