RCRJRTRA ;WISC/RFJ-transaction report ;1 Mar 97
 ;;4.5;Accounts Receivable;**68,153**;Mar 20, 1995
 N DATEEND,DATESTRT,RCRJSUMM,TRANTYPE
 ;
 ;  select date range
 D DATESEL("AR TRANSACTIONS") I '$G(DATEEND) Q
 S DATEEND=DATEEND+.99
 ;
 ;  select transaction types
 D TRANTYPE(DATESTRT,DATEEND) I '$O(TRANTYPE(0)) W !,"NO transaction types selected." Q
 ;
 S RCRJSUMM=$$SUMMARY I 'RCRJSUMM Q
 ;
 ;  select device
 W ! S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="AR Transaction Listing Report",ZTRTN="DQ^RCRJRTRA"
 .   S ZTSAVE("DATE*")="",ZTSAVE("RCRJ*")="",ZTSAVE("TRANTYPE*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 ;
DQ ;  report (queue) starts here
 N ADM,BILLDA,CATDA,DA,DATA0,DATE,INT,PRIN,TYPE,VALUE,X,Y
 K ^TMP($J,"RCRJRTRA")
 ;
 S TRANTYPE=0 F  S TRANTYPE=$O(TRANTYPE(TRANTYPE)) Q:'TRANTYPE  I $D(^PRCA(433,"AT",TRANTYPE)) D
 .   S DATE=DATESTRT-.01 F  S DATE=$O(^PRCA(433,"AT",TRANTYPE,DATE)) Q:'DATE!(DATE>DATEEND)  D
 .   .   S DA=0 F  S DA=$O(^PRCA(433,"AT",TRANTYPE,DATE,DA)) Q:'DA  D
 .   .   .   S DATA0=$G(^PRCA(433,DA,0))
 .   .   .   ;
 .   .   .   S BILLDA=+$P(DATA0,"^",2)
 .   .   .   ;  bill not linked to a site
 .   .   .   I '$P($G(^PRCA(430,BILLDA,0)),"^",12) Q
 .   .   .   ;
 .   .   .   S CATDA=+$P($G(^PRCA(430,BILLDA,0)),"^",2)
 .   .   .   I 'CATDA Q
 .   .   .   ;
 .   .   .   S VALUE=$$TRANBAL^RCRJRCOT(DA) I VALUE="" Q
 .   .   .   S PRIN=$P(VALUE,"^"),INT=$P(VALUE,"^",2),ADM=$P(VALUE,"^",3)+$P(VALUE,"^",4)+$P(VALUE,"^",5)
 .   .   .   ;
 .   .   .   S TYPE=TRANTYPE
 .   .   .   ;  contract adjustment
 .   .   .   I TYPE=35,$P($G(^PRCA(433,DA,8)),"^",8) S TYPE="35C"
 .   .   .   ;  pre-payments
 .   .   .   I (TYPE=2!(TYPE=34)),$P($G(^PRCA(433,DA,5)),"^") S TYPE="34P"
 .   .   .   ;
 .   .   .   I TYPE'=12 D SETVALUE(TYPE,PRIN,INT,ADM) Q
 .   .   .   ;
 .   .   .   ;  if trans is 12, breakout charges added + and exempt -
 .   .   .   ;  both +, charges added
 .   .   .   I INT'<0,ADM'<0 D SETVALUE("12A","",INT,ADM) Q
 .   .   .   ;  both -, charges exempt
 .   .   .   I INT<0,ADM<0 D SETVALUE("12E","",-INT,-ADM) Q
 .   .   .   ;  one is + and the other -
 .   .   .   I INT<0 D:ADM SETVALUE("12A","","",ADM) D SETVALUE("12E","",-INT,"") Q
 .   .   .   I ADM<0 D:INT SETVALUE("12A","",INT,"") D SETVALUE("12E","","",-ADM) Q
 ;
 D PRINT^RCRJRTR1
 ;
 D ^%ZISC
 K ^TMP($J,"RCRJRTRA")
 Q
 ;
 ;
SETVALUE(TYPE,PRIN,INT,ADM) ;  store value in tmp global for printing
 ;  =  trans amt ^ prin amt ^ int amt ^ adm amt
 ;  add spaces to type for sorting in numerical order
 S TYPE=" "_$S($L(+TYPE)=1:" ",1:"")_TYPE
 S ^TMP($J,"RCRJRTRA",TYPE,CATDA,BILLDA,DA)=(PRIN+INT+ADM)_"^"_PRIN_"^"_INT_"^"_ADM
 Q
 ;
 ;
DATESEL(DESCR) ;  select starting and ending dates in days
 ;  returns datestrt and dateend
 N %,%DT,%H,%I,DEFAULT,X,Y
 K DATEEND,DATESTRT
START S Y=$E(DT,1,5)_"01" D DD^%DT S DEFAULT=Y
 S %DT("A")="Start with "_$S(DESCR'="":DESCR_" ",1:"")_"Date: ",%DT("B")=DEFAULT,%DT="AEP",%DT(0)=-DT D ^%DT I Y<0 Q
 I $E(Y,6,7)="00" S Y=$E(Y,1,5)_"01"
 S DATESTRT=Y
 S Y=DT D DD^%DT S DEFAULT=Y
 S %DT("A")="  End with "_$S(DESCR'="":DESCR_" ",1:"")_"Date: ",%DT("B")=DEFAULT,%DT="AEP",%DT(0)=-DT D ^%DT I Y<0 Q
 I $E(Y,6,7)="00" S Y=$E(Y,1,5)_"01"
 I Y<DATESTRT W !,"END DATE MUST BE GREATER THAN OR EQUAL TO THE START DATE.",! G START
 S DATEEND=Y,Y=DATESTRT D DD^%DT
 W !?5,"***  Selected date range from ",Y," to " S Y=DATEEND D DD^%DT W Y,"  ***"
 Q
 ;
 ;
TRANTYPE(DATESTRT,DATEEND)          ;  select transaction types
 ;  requires datestrt and dateend for date range         
 ;  returns TRANTYPE(#) for selected entries
 N %,COUNT,DATE,DIR,DIRUT,RCRJFLAG,TRANLIST,X,Y
 K TRANTYPE
 ;
 ;  compile a list of available transactions in date range
 S TRANLIST="",DATE=DATESTRT-.01
 S TRANTYPE=0 F  S TRANTYPE=$O(^PRCA(433,"AT",TRANTYPE)) Q:'TRANTYPE  S %=+$O(^PRCA(433,"AT",TRANTYPE,DATE)) I %,%<DATEEND D
 .   I TRANTYPE=45 Q  ;do not look at comments
 .   S %=$P($G(^PRCA(430.3,TRANTYPE,0)),"^")
 .   S TRANLIST(TRANTYPE)=%
 .   S TRANLIST=TRANLIST_TRANTYPE_":"_$E(%,1,10)_";"
 I TRANLIST="" W !,"There are NO transactions within the date range." Q
 S TRANLIST=TRANLIST_"*:ALL transactions;-:NO transactions;"
 ;
 F  D  Q:$G(RCRJFLAG)
 .   D SHOWLIST
 .   S DIR(0)="SOA^"_TRANLIST,DIR("A")="Select TRANSACTION TYPE: "
 .   D ^DIR
 .   I $D(DIRUT) S RCRJFLAG=1 Q
 .   I Y="*" S %=0 F  S %=$O(TRANLIST(%)) Q:'%  S TRANTYPE(%)=""
 .   I Y="-" K TRANTYPE Q
 .   S Y=+Y
 .   I $D(TRANLIST(Y)) D
 .   .   I $D(TRANTYPE(Y)) K TRANTYPE(Y) W "  un-selected" Q
 .   .   S TRANTYPE(Y)="" W "  selected"
 Q
 ;
 ;
SHOWLIST ;  show list of available/selected transaction types
 W !!,"The following is a list of available transactions within the date range.",!,"Asterisks (**) next to the transaction indicates it has been selected",!,"for the report."
 S %=0 F COUNT=1:1 S %=$O(TRANLIST(%)) Q:'%  D
 .   I (COUNT#2)'=0 W !
 .   E  W ?40
 .   W $S($D(TRANTYPE(%)):"**",1:"  ")," "
 .   W $S($L(%)=1:" ",1:""),%,"  ",TRANLIST(%)
 Q
 ;
 ;
SUMMARY() ;  ask to print detailed or summary report
 N DIR,DIRUT,X,Y
 S DIR(0)="SOA^D:detailed;S:summary;",DIR("A")="Type of report to print: ",DIR("B")="summary"
 W ! D ^DIR
 I $D(DIRUT) Q 0
 Q $S(Y="S":1,Y="D":2,1:0)
