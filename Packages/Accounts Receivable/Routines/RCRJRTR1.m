RCRJRTR1 ;WISC/RFJ-transaction report (print) ;1 Mar 97
 ;;4.5;Accounts Receivable;**68**;Mar 20, 1995
 Q
 ;
 ;
PRINT ;  print the report
 N %I,DATA,DATEDIS1,DATEDIS2,INTTOTAL,NDB,NDBFLAG,NOW,PAGE,PRINTOTL,RCRJFLAG,RCRJLINE,SCREEN,SIGN,TOTALC,TOTALT,X,Y
 ;
 ;  calculate new receivables from bills and store in 43C
 I $D(TRANTYPE(43)) S NDB("43C",2)=$P($$GETNEW^RCRJRCOL(DATESTRT,DATEEND,0),"^",2)
 ;
 S Y=$P(DATESTRT,".") D DD^%DT S DATEDIS1=Y
 S Y=$P(DATEEND,".") D DD^%DT S DATEDIS2=Y
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y
 S PAGE=1,RCRJLINE="",$P(RCRJLINE,"-",81)=""
 S SCREEN=0 I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C" S SCREEN=1
 U IO D H
 ;
 S TRANTYPE="" F  S TRANTYPE=$O(^TMP($J,"RCRJRTRA",TRANTYPE)) Q:TRANTYPE=""!($G(RCRJFLAG))  D
 .   I $Y>(IOSL-6) D:SCREEN PAUSE Q:$G(RCRJFLAG)  D H
 .   S TYPE=$TR(TRANTYPE," ")
 .   W !!,"TRANSACTION TYPE: ",TYPE,"  ",$P($G(^PRCA(430.3,+TYPE,0)),"^")
 .   I TYPE="12A" W "  [ADDED]"
 .   I TYPE="12E" W "  [EXEMPT]"
 .   I TYPE="35C" W "  [CONTRACTUAL ADJUSTMENTS]"
 .   I TYPE="34P" W "  [PRE-PAYMENTS]"
 .   ;
 .   K TOTALT
 .   S CATDA=0 F  S CATDA=$O(^TMP($J,"RCRJRTRA",TRANTYPE,CATDA)) Q:'CATDA!($G(RCRJFLAG))  D
 .   .   I $Y>(IOSL-6) D:SCREEN PAUSE Q:$G(RCRJFLAG)  D H
 .   .   W !?5,"CATEGORY: ",$E($S($L(CATDA)=1:" ",1:"")_CATDA_"  "_$P($G(^PRCA(430.2,CATDA,0)),"^"),1,20),?36
 .   .   ;
 .   .   K TOTALC
 .   .   S BILLDA=0 F  S BILLDA=$O(^TMP($J,"RCRJRTRA",TRANTYPE,CATDA,BILLDA)) Q:'BILLDA!($G(RCRJFLAG))  D
 .   .   .   ;
 .   .   .   S DA=0 F  S DA=$O(^TMP($J,"RCRJRTRA",TRANTYPE,CATDA,BILLDA,DA)) Q:'DA!($G(RCRJFLAG))  S DATA=^(DA) D
 .   .   .   .   I $Y>(IOSL-5) D:SCREEN PAUSE Q:$G(RCRJFLAG)  D H
 .   .   .   .   I RCRJSUMM=2 W !?10,$P($G(^PRCA(430,BILLDA,0)),"^"),?28,$P($G(^PRCA(433,DA,0)),"^"),?36
 .   .   .   .   F %=1:1:4 D:RCRJSUMM=2 WRITE($P(DATA,"^",%)) I $P(DATA,"^",%)'="" S TOTALC(%)=$G(TOTALC(%))+$P(DATA,"^",%)
 .   .   I $G(RCRJFLAG) Q
 .   .   I RCRJSUMM=2 W !?10,$E($TR(RCRJLINE,"-","."),11,80),!?10,"TOTALS FOR CATEGORY ...",?36
 .   .   F %=1:1:4 D WRITE($G(TOTALC(%))) I $G(TOTALC(%))'="" S TOTALT(%)=$G(TOTALT(%))+TOTALC(%)
 .   .   I $Y>(IOSL-6) D:SCREEN PAUSE Q:$G(RCRJFLAG)  D H
 .   ;
 .   I $G(RCRJFLAG) Q
 .   W !?5,$E($TR(RCRJLINE,"-","."),6,80),!?5,"TOTALS FOR TRANSACTION TYPE ...",?36
 .   F %=1:1:4 D WRITE($G(TOTALT(%))) I $G(TOTALT(%))'="" S NDB(TYPE,%)=$G(NDB(TYPE,%))+TOTALT(%)
 .   I $Y>(IOSL-6) D:SCREEN PAUSE Q:$G(RCRJFLAG)  D H
 ;
 I $G(RCRJFLAG) Q
 ;
 ;  set ndbflag to change header for ndb totals (see H)
 S NDBFLAG=1
 D:SCREEN PAUSE Q:$G(RCRJFLAG)  D H
 ;
 ;  print national database totals
 S PRINTOTL=0,INTTOTAL=0
 W !!,"NATIONAL DATABASE TOTALS (VALUES FROM THE REPORT) ...",!
 D NDB(13,43,2)
 D NDB(13,"43C",2)
 D NDB(13,43,3)
 D NDB(13,43,4)
 D NDB(14,1,2)
 D NDB(16,35,2)
 D NDB(18,34,2)
 D NDB(19,2,2)
 D NDB(20,"35C",2)
 D NDB(21,"34P",2)
 D NDB(22,10,2),NDB(22,10,3),NDB(22,10,4)
 D NDB(23,11,2),NDB(23,11,3),NDB(23,11,4)
 D NDB(24,9,2),NDB(24,9,3),NDB(24,9,4)
 D NDB(25,8,2),NDB(25,8,3),NDB(25,8,4)
 D NDB(38,34,3),NDB(38,"34P",3),NDB(38,2,3)
 D NDB(39,34,4),NDB(39,2,4)
 D NDB(40,"12A",3),NDB(40,13,3)
 D NDB(41,"12A",4),NDB(41,13,4)
 D NDB(42,"12E",3),NDB(42,"12E",4),NDB(42,14,3)
 D NDB(43,41,2)
 W !,$E(RCRJLINE,1,80),!,"BALANCE GAINS/LOSSES FOR DATE RANGE",?42,"+/-",$J(PRINTOTL,13,2),$J(INTTOTAL,11,2)
 ;
 W !!,"  The following formula can be used to balance the values in the national"
 W !,"  database.  Note: This report must be run for the entire month and all"
 W !,"  transaction types must be selected.  Also, this will only balance for"
 W !,"  the months following the installation of this patch."
 W !,"                                                           Principal     Int/Adm",!
 W !,"Previous months receivables from NDB (category 1)    + __________.__  _______.__"
 W !,"Current months gains/losses from this report       +/-",$J(PRINTOTL,14,2),$J(INTTOTAL,12,2)
 W !,$E(RCRJLINE,1,80)
 W !,"Current months receivables from NDB (category 1)     = __________.__  _______.__"
 ;
 Q
 ;
 ;
NDB(NDBTYPE,TRANTYPE,NODE)      ;  write ndb totals and calc end total
 I +$G(NDB(TRANTYPE,NODE))=0 Q
 ;
 W !,"(",NDBTYPE,") ",$$NDBCATEG(NDBTYPE),?36
 ;
 S SIGN="-"
 I TRANTYPE=1!(TRANTYPE="12A")!(TRANTYPE=13)!(TRANTYPE=43)!(TRANTYPE="43C")!(TRANTYPE=46) S SIGN="+"
 W $J(SIGN_"  ",11),$J($G(NDB(TRANTYPE,NODE)),$S(NODE=2:11,1:22),2)
 W ?75,"(",$J(TRANTYPE,3),")"
 ;
 I NODE=2 S PRINTOTL=PRINTOTL+$S(SIGN="+":$G(NDB(TRANTYPE,NODE)),1:-$G(NDB(TRANTYPE,NODE)))
 I NODE=3!(NODE=4) S INTTOTAL=INTTOTAL+$S(SIGN="+":$G(NDB(TRANTYPE,NODE)),1:-$G(NDB(TRANTYPE,NODE)))
 Q
 ;
 ;
NDBCATEG(NDBTYPE)  ;  return ndb category
 I NDBTYPE=13 Q "NEW RECEIVABLES"
 I NDBTYPE=14 Q "TOTAL INCREASE ADJUSTMENTS"
 I NDBTYPE=16 Q "TOTAL DECREASE ADJUSTMENTS"
 I NDBTYPE=18 Q "COLLECTIONS - FULL PAYMENT"
 I NDBTYPE=19 Q "COLLECTIONS - PART PAYMENT"
 I NDBTYPE=20 Q "COLLECTIONS - CONTRACT ADJ"
 I NDBTYPE=21 Q "COLLECTIONS - PREPAYMENTS"
 I NDBTYPE=22 Q "COLLECTIONS - WAIVED IN FULL"
 I NDBTYPE=23 Q "COLLECTIONS - WAIVED IN PART"
 I NDBTYPE=24 Q "COLLECTIONS - TERM COMPROMISE"
 I NDBTYPE=25 Q "COLLECTIONS - TERM FISCAL OFF"
 I NDBTYPE=38 Q "COLLECTIONS - INTEREST"
 I NDBTYPE=39 Q "COLLECTIONS - ADMIN"
 I NDBTYPE=40 Q "INTEREST ADDED"
 I NDBTYPE=41 Q "ADMINISTRATIVE COST ADDED"
 I NDBTYPE=42 Q "INTEREST/ADMIN COST EXEMPT"
 I NDBTYPE=43 Q "REFUNDS"
 Q "UNKNOWN"
 ;
 ;
WRITE(VALUE)       ;  write value
 I VALUE="" W $J(VALUE,11) Q
 W $J(VALUE,11,2)
 Q
 ;
 ;
PAUSE ;  pause at end of page
 N X U IO(0) W !,"Press RETURN to continue, '^' to exit:" R X:DTIME S:'$T X="^" S:X["^" RCRJFLAG=1 U IO Q
 ;
 ;
H ;  header
 S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"AR TRANSACTION LISTING REPORT",?(80-$L(%)),%
 W !,"  FOR THE DATE RANGE: ",DATEDIS1,"  TO  ",DATEDIS2,?65,$J("TYPE: "_$S(RCRJSUMM=1:"SUMMARY",1:"DETAILED"),15)
 ;
 I '$G(NDBFLAG) W !?26,$J("TRANSACTION AMOUNT",21),$J("PRINCIPAL",11),$J("INTEREST",11),$J("ADMIN",11)
 I $G(NDBFLAG) W !,"NATIONAL DATABASE CATEGORY",?26,$J("ADD (+)/SUB (-)",21),$J("PRINCIPAL",11),$J("INT/ADM",11),$J("TRANSTYPE",11)
 ;
 W !,RCRJLINE
 Q
