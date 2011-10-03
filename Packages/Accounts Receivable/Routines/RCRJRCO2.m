RCRJRCO2 ;WISC/RFJ-start of the ar2 data collector ;3/7/00  12:17 PM
 ;;4.5;Accounts Receivable;**96,152,156,174,191**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
DQ ;  start queued task from taskmanager here
 D START(PRCASITE,DATEBEG,DATEEND)
 Q
 ;
 ;
START(PRCASITE,DATEBEG,DATEEND) ;  start ar2 collector
 N %,BATCNAME,STRTTIME,TOTAL,X,Y
 ;
 ;  set start time
 D NOW^%DTC S STRTTIME=%
 ;
 D STATEMNT,PAYDEP,IRS
 ;
 ;  ---------- send to ndb ----------
 K ^TMP($J,"RCRJRCORMM")
 ;  build the first two control lines in mail message
 S Y=DATEBEG D DD^%DT
 S BATCNAME="AR2-"_$E(Y,1,3)_$E(DATEBEG,6,7)_$TR($P(Y,",",2)," ")
 S Y=DATEEND D DD^%DT
 S BATCNAME=BATCNAME_"-"_$E(Y,1,3)_$E(DATEEND,6,7)_$TR($P(Y,",",2)," ")
 S ^TMP($J,"RCRJRCORMM",1)="T$ "_PRCASITE_"$"_BATCNAME_"$$$$$*"
 ;  get end time (in %)
 D NOW^%DTC
 S ^TMP($J,"RCRJRCORMM",2)="S$ "_STRTTIME_"^"_%_"$0$5"
 S ^TMP($J,"RCRJRCORMM",3)="D$ :1/1/"_TOTAL(1)_":2/2/"_TOTAL(2)_":3/3/"_TOTAL(3)_":4/4/"_TOTAL(4)_":5/5/"_TOTAL(5)
 ;
 S XMY("S.PRQN DATA COLLECTION MONITOR@FO-ALBANY.MED.VA.GOV")=""
 S %=$$SENDMSG^RCRJRCOR("AR2 "_$E(DATEEND,4,5)_"/"_$E(DATEEND,2,3)_" NDB DATA FOR SITE "_PRCASITE,.XMY)
 K ^TMP($J,"RCRJRCORMM")
 Q
 ;
 ;
STATEMNT ;  count statements
 N ADMIN,COUNT,DA,DATA,DATE,DATESTRT,DATESTOP,DEBTOR,INTEREST,PRINBAL
 S DATESTRT=9999999-DATEEND,DATESTOP=9999999.999999-DATEBEG
 ;
 S (COUNT,PRINBAL,INTEREST,ADMIN)=0
 S DEBTOR=0 F  S DEBTOR=$O(^RC(341,"AD",DEBTOR)) Q:'DEBTOR  D
 .   S DATE=DATESTRT F  S DATE=$O(^RC(341,"AD",DEBTOR,2,DATE)) Q:'DATE!(DATE>DATESTOP)  D
 .   .   S DA=0 F  S DA=$O(^RC(341,"AD",DEBTOR,2,DATE,DA)) Q:'DA  D
 .   .   .   S DATA=$G(^RC(341,DA,1))
 .   .   .   S COUNT=COUNT+1,PRINBAL=PRINBAL+$P(DATA,"^"),INTEREST=INTEREST+$P(DATA,"^",2),ADMIN=ADMIN+$P(DATA,"^",3)
 ;
 ;  1 is data collector index for statements
 S TOTAL(1)=COUNT_"^"_PRINBAL_"^"_INTEREST_"^"_ADMIN
 Q
 ;
 ;
PAYDEP ;  process payments and deposits
 N COUNT,DA,DATA0,DATECONF,DEPAMT,DEPCNT,DEPTICDA,TDATA0,TDATA1,TOTALAMT,TOTALDEP,TRANDA,TYPE
 S (COUNT,TOTALAMT,DEPCNT,TOTALDEP)=0
 S DA=0 F  S DA=$O(^RCY(344,DA)) Q:'DA  S DATA0=$G(^(DA,0)) I $P(DATA0,"^",8) D
 .   S TYPE=$P($G(^RC(341.1,+$P(DATA0,"^",4),0)),"^")
 .   I TYPE'["PAYMENT" Q
 .   ;
 .   ;  count payment transactions and amount
 .   S DEPAMT=0
 .   S TRANDA=0 F  S TRANDA=$O(^RCY(344,DA,1,TRANDA)) Q:'TRANDA  D
 .   .   S TDATA0=$G(^RCY(344,DA,1,TRANDA,0)),TDATA1=$G(^(1))
 .   .   I $P(TDATA1,"^",2)'="" Q
 .   .   S DEPAMT=DEPAMT+$P(TDATA0,"^",4)
 .   .   I $P(TDATA0,"^",6)<DATEBEG!($P(TDATA0,"^",6)>DATEEND) Q
 .   .   I $P(TDATA0,"^",4) S COUNT=COUNT+1,TOTALAMT=TOTALAMT+$P(TDATA0,"^",4)
 .   ;
 .   ;  count total deposits and amount
 .   I 'DEPAMT Q
 .   S DEPTICDA=$P(DATA0,"^",6) I 'DEPTICDA Q
 .   S DATECONF=$P($P($G(^RCY(344.1,DEPTICDA,0)),U,11),".")
 .   I DATECONF<DATEBEG!(DATECONF>DATEEND) Q
 .   S TOTALDEP=TOTALDEP+DEPAMT
 .   I '$D(DEPCNT(DATECONF)) S DEPCNT(DATECONF)="",DEPCNT=DEPCNT+1
 ;
 ;  2 is data collector index for deposits
 ;  3 is data collector index for payment transactions
 S TOTAL(2)=DEPCNT_"^"_TOTALDEP
 S TOTAL(3)=COUNT_"^"_TOTALAMT
 Q
 ;
 ;
IRS ;  count of irs letters and amounts
 ;  count of 1st party accounts and bills under $25 with total amt.
 N AMOUNT,BILLDA,COUNT,COUNTED,DATA6,DEBTOR
 N L25BCNT,L25ACNT,L25AMT,L25FLG,DEBAMT,DEBCNT,DATA7,P181DT
 N BAMT,DATA0,I
 S P181DT=$$FMADD^XLFDT(DATEEND,-181)
 S (AMOUNT,COUNT,L25BCNT,L25ACNT,L25AMT)=0
 S DEBTOR=0 F  S DEBTOR=$O(^PRCA(430,"C",DEBTOR)) Q:'DEBTOR  D
 .   S (COUNTED,DEBAMT,DEBCNT,L25FLG)=0
 .   S BILLDA=0 F  S BILLDA=$O(^PRCA(430,"C",DEBTOR,BILLDA)) Q:'BILLDA  D
 .   .   S DATA6=$G(^PRCA(430,BILLDA,6))
 .   .   ; if the first party account is still less than $25, get the
 .   .   ; next active bill and add those dollars
 .   .   D:'L25FLG
 .   .   .   ; not a 1st party account
 .   .   .   I $P($G(^RCD(340,DEBTOR,0)),U)'[";DPT(" S L25FLG=1 Q
 .   .   .   ; bill not activated for more than 180 days
 .   .   .   Q:$P(DATA6,U,21)>P181DT
 .   .   .   S DATA0=$G(^PRCA(430,BILLDA,0))
 .   .   .   ; bill not active or in suspended status
 .   .   .   ; not necessary to check for open status because of age of
 .   .   .   ; bill (should not be open for more than 30 days)
 .   .   .   I $P(DATA0,"^",8)'=16,$P(DATA0,"^",8)'=40 Q
 .   .   .   S DATA7=$G(^PRCA(430,BILLDA,7))
 .   .   .   S BAMT=0 F I=1:1:5 S BAMT=BAMT+$P(DATA7,U,I)
 .   .   .   ; no outstanding balance on the bill
 .   .   .   Q:'BAMT
 .   .   .   S DEBAMT=DEBAMT+BAMT
 .   .   .   ; accounts is greater than $25, do not count it
 .   .   .   I DEBAMT'<25 S L25FLG=1 Q
 .   .   .   S DEBCNT=DEBCNT+1
 .   .   .   Q
 .   .   I $P(DATA6,"^",14)<DATEBEG!($P(DATA6,"^",14)>DATEEND) Q
 .   .   I 'COUNTED S COUNT=COUNT+1,COUNTED=1
 .   .   S AMOUNT=AMOUNT+$P(DATA6,"^",19)
 .   .   Q
 .   ;increment account less than 25 totals
 .   I 'L25FLG,DEBAMT S L25ACNT=L25ACNT+1,L25AMT=L25AMT+DEBAMT,L25BCNT=L25BCNT+DEBCNT
 .   Q
 ;
 ;  4 is data collector index for irs letters and amounts
 S TOTAL(4)=COUNT_"^"_AMOUNT
 ;
 ;  5 is data collector index for accounts less than $25, total
 ;  amount of accounts under $25, # of bills covered by those accounts
 S TOTAL(5)=L25ACNT_"^"_L25AMT_"^"_L25BCNT
 Q
