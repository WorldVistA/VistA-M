RCRJRCOL ;WISC/RFJ-start of the ar data collector ;1 Mar 97
 ;;4.5;Accounts Receivable;**68,96,101,103,170,176,191**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
START(PRCASITE,DATEBEG,DATEEND) ;  start ar1 collector and fms data collector
 N %,ACTDATE,AYEAROLD,BILLDA,CLOSED,CRITERIA,DATA0,DATASTOR,DATE,IBCNS,PREVSTAT,STAT,STRTTIME
 D KILLTMP
 ;
 ;  set start time
 D NOW^%DTC S STRTTIME=%
 ;
 S DATASTOR="^TMP($J,""RCRJRCOLNDB"",CRITERIA)"
 ;
 ;  count new receivables
 S %=$$GETNEW(DATEBEG,DATEEND,1)
 ;
 ;  used to determine future payments less than a year old
 S AYEAROLD=$$FMADD^XLFDT(DATEEND,365)
 ;
 ;  count current receivables for period and decrease in debts
 ;  do not look at bills not approved/finished (18,20,27,31)
 S STAT=0 F  S STAT=$O(^PRCA(430,"ASDT",STAT)) Q:'STAT  I STAT'=18,STAT'=20,STAT'=27,STAT'=31 D
 .   S DATE=0,CLOSED=0
 .   ;  do not look at bills closed before begin date
 .   ;  count decrease number of debts, must be closed in month
 .   ;  stat 17 (in-active)       ; stat 22 (collected/closed)
 .   ;  stat 23 (write-off)       ; stat 26 (cancelled)
 .   ;  stat 39 (cancellation)    ; stat 41 (refunded)
 .   I ",17,22,23,26,39,41,"[(","_STAT_",") S DATE=DATEBEG-1,CLOSED=1
 .   F  S DATE=$O(^PRCA(430,"ASDT",STAT,DATE)) Q:'DATE  D
 .   .   S BILLDA=0 F  S BILLDA=$O(^PRCA(430,"ASDT",STAT,DATE,BILLDA)) Q:'BILLDA  D
 .   .   .   ;  do not count bills already skipped
 .   .   .   I $D(^TMP($J,"RCRJRCOL","COUNT",BILLDA,0)) Q
 .   .   .   S DATA0=$G(^PRCA(430,BILLDA,0))
 .   .   .   I '$P(DATA0,"^",12) S ^TMP($J,"RCRJRCOL","COUNT",BILLDA,0)="" Q
 .   .   .   ;  no original amount
 .   .   .   I $P(DATA0,"^",3)="" S ^TMP($J,"RCRJRCOL","COUNT",BILLDA,0)="" Q
 .   .   .   ;
 .   .   .   ;  do not look at bills activated after end date
 .   .   .   S ACTDATE=$P($P($G(^PRCA(430,BILLDA,6)),"^",21),".")
 .   .   .   I 'ACTDATE!(ACTDATE>DATEEND) S ^TMP($J,"RCRJRCOL","COUNT",BILLDA,0)="" Q
 .   .   .   ;
 .   .   .   ;  bill is closed before end date, decrease debt
 .   .   .   I CLOSED,DATE'>DATEEND D  Q
 .   .   .   .   ;  if previous status was:
 .   .   .   .   ;  18 (new bill), 27 (incomplete), 20 (pend approval)
 .   .   .   .   ;  then the bill was never counted as a new receivable
 .   .   .   .   ;  and should not be counted as a decrease in debts
 .   .   .   .   S PREVSTAT=$P($G(^PRCA(430,BILLDA,9)),"^",6)
 .   .   .   .   I PREVSTAT=18!(PREVSTAT=20)!(PREVSTAT=27) S ^TMP($J,"RCRJRCOL","COUNT",BILLDA,0)="" Q
 .   .   .   .   D SETTOTAL^RCRJRCO1(17,0,0)
 .   .   .   ;
 .   .   .   D CURRENT^RCRJRCOB(BILLDA,DATEEND,AYEAROLD)
 ;
 ;  collect data from file 433
 D START^RCRJRCO1
 ;  send data to ndb and fms
 D SEND^RCRJRCOR
 ;  print summary report
 D SUMMARY^RCRJRCOR
 ;
 ;  compile and print bad debt report
 I '$G(RCRJFBDR) D START^RCRJRBD(DATEEND)
 ;
KILLTMP ;  kill tmp globals
 K ^TMP($J,"RCRJRBD")        ;stores the bad debt report
 K ^TMP($J,"RCRJRCOL")       ;used internally
 K ^TMP($J,"RCRJRCOLNDB")    ;stores the ndb data
 K ^TMP($J,"RCRJROIG")       ;stores the data for the oig extract
 K ^TMP($J,"RCRJRCOLSV")     ;stores the fms sv code sheet
 K ^TMP($J,"RCRJRCOLWR")     ;stores the fms wr code sheet
 K ^TMP($J,"RCRJRCOLREPORT") ;stores the user report
 K ^TMP($J,"RCBMILLDATA")    ;stores the mccf/hsif payment split for rx
 Q
 ;
 ;
GETNEW(DATEBEG,DATEEND,RCRJFSTO) ;  get new receivables between two dates
 ;  rcrjfsto is a flag which is set to 1 for the ndb rollup and it
 ;  will store the data in tmp.  If its not a 1, it will count the 
 ;  new bills and just return the count ^ amount.
 N COUNT,DATE,ORIGAMT,PRINBAL
 S COUNT=0,PRINBAL=0
 S DATE=DATEBEG-1
 F  S DATE=$O(^PRCA(430,"ACTDT",DATE)) Q:'DATE!(DATE>DATEEND)  D
 .   S BILLDA=0 F  S BILLDA=$O(^PRCA(430,"ACTDT",DATE,BILLDA)) Q:'BILLDA  D
 .   .   S ORIGAMT=$$TESTNEW(BILLDA,DATEBEG,DATEEND)
 .   .   ;  not a new receivable
 .   .   I ORIGAMT="" S:RCRJFSTO ^TMP($J,"RCRJRCOL","COUNT",BILLDA,0)="" Q
 .   .   ;  store for ndb
 .   .   I RCRJFSTO D SETTOTAL^RCRJRCO1(13,ORIGAMT,0)
 .   .   S COUNT=COUNT+1,PRINBAL=PRINBAL+ORIGAMT
 ;
 Q COUNT_"^"_PRINBAL
 ;
 ;
TESTNEW(BILLDA,DATEBEG,DATEEND) ;  test to see if a bill is a new receivable
 ;  returns the principal balance if a bill is new
 N DATA0,STAT
 S DATA0=$G(^PRCA(430,BILLDA,0))
 ;  no site
 I '$P(DATA0,"^",12) Q ""
 ;  bill never had an original amount (prepayments would not be
 ;  picked up here since they do not have an original amount)
 I $P(DATA0,"^",3)="" Q ""
 ;
 S STAT=$P(DATA0,"^",8)
 ;  no status
 I 'STAT Q ""
 ;  bill was cancelled the same month
 ;I STAT=26,($E($P(DATA0,"^",14),1,5)=$E(DATEBEG,1,5)) Q ""
 I STAT=26&($P(DATA0,"^",14)<DATEBEG!($P(DATA0,"^",14)>DATEEND)) Q ""
 ;  bill incomplete
 I STAT=27 Q ""
 ;  bill new
 I STAT=18 Q ""
 ;  bill pending approval
 I STAT=20 Q ""
 ;  bill returned from AR (new)
 I STAT=31 Q ""
 ;
 ;  yes, its a new receivable, return its original amount
 Q +$P(DATA0,"^",3)
 ;
 ;
CRITERIA(BILLDA) ;  find a bills criteria/category 1,3,4,5
 ;  returns 1--3-4-5  where the number is the criteria number
 ;  the second piece is set at settotal^rcrjrco1
 ;
 N %,CRITER1,CRITER35,DATA0,X
 S DATA0=$G(^PRCA(430,BILLDA,0))
 ;
 ;  % = segment
 S %=$P(DATA0,"^",21)
 S CRITER1=$S(%=243:1,%=244:3,%=245:2,%=246:8,%=247:9,%=248:10,%=249:5,%=251:14,%=252:16,%=292:6,%=293:7,%=294:11,%=295:19,%=296:20,%=297:4,%=298:12,1:0)
 ;
 ;   acck = accrual
 I CRITER1=8,'$$ACCK^PRCAACC(BILLDA) S CRITER1=18
 ;
 I 'CRITER1 D
 . S %=$P($G(^PRCA(430.2,+$P(DATA0,"^",2),0)),"^",7)
 . ; % = Category Number:
 . ; 22 TORT FEASOR
 . ; 18 SHARING AGREEMENTS
 . ; 33 PREPAYMENT
 . ; 40 ADULT DAY HEALTH CARE
 . ; 41 DOMICILIARY
 . ; 42 RESPITE CARE-INSTITUTIONAL
 . ; 43 RESPITE CARE-NON-INSTITUTIONAL
 . ; 44 GERIATRIC EVAL-INSTITUTIONAL
 . ; 45 GERIATRIC EVAL-NON-INSTITUTION
 . ; 46 NURSING HOME CARE-LTC
 . S CRITER1=$S(%=22:15,%=18:17,%=33:13,%=40:1,%=41:20,%=42:20,%=43:1,%=44:20,%=45:1,%=46:20,1:18)
 ;
 ;  determine criteria 3,4,5
 S CRITER35="0-0-0"
 I CRITER1>3,CRITER1<8  D
 .   S %=$TR($$CRIT^IBRFN2(BILLDA),"^","-") ;integration agreement 1182
 .   I %=-1 S CRITER35="3-1-4" Q
 .   I $P(%,"-")="" S $P(%,"-")=3
 .   I $P(%,"-",2)="" S $P(%,"-",2)=1
 .   I $P(%,"-",3)="" S $P(%,"-",3)=4
 .   S CRITER35=%
 ;
 Q CRITER1_"--"_CRITER35
