PRCPRSSR ;WISC/RFJ/dh/DWA/DAP-stock status report (option, whse) ;3.13.98
 ;;5.1;IFCAP;**17,41,98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;*83 Routine PRCPLO2 associated with PRC*5.1*83 is a modified copy of
 ;this routine and any changes made to this routine should also be
 ;considered for that routine as well.
 ;
 ;*98 Changed previous displays of "issues" to "usage"
 ;
 D ^PRCPUSEL Q:'$D(PRCP("I"))
 N %,%DT,%H,%I,DATEINAC,DATESTRT,TODAY,X,X1,X2,Y
 K X S X(1)="The Stock Status Report will print a summary of all usage, receipts, and adjustments with the opening and closing balances by account codes."
 S X(2)="It will calculate the turnover rate, inactive item percent, long supply percent, and non-issuable percent."
 D DISPLAY^PRCPUX2(40,79,.X)
 K X S X(1)="Enter the date (month-year) for the Stock Status Report." D DISPLAY^PRCPUX2(2,40,.X)
 D NOW^%DTC S TODAY=X,Y=$E(X,1,5)_"00" S %DT(0)=-Y D DD^%DT S %DT="AEP",%DT("B")=Y,%DT("A")="Print Stock Status for MONTH and YEAR: " D ^%DT K %DT I Y<1 Q
 S DATESTRT=$E(Y,1,5)_"00"
 K X S X(1)="The inactive item percent is calculated for items which have not had activity (receipts or usage) after a specified cutoff date." D DISPLAY^PRCPUX2(40,79,.X)
 K X S X(1)="Enter the Inactivity cutoff date." D DISPLAY^PRCPUX2(2,40,.X)
 S X1=TODAY,X2=-90 D C^%DTC S Y=$E(X,1,5)_"00" D DD^%DT
 S %DT(0)=-($E(TODAY,1,5)_"00"),%DT="AEP",%DT("B")=Y,%DT("A")="Enter Inactivity Cutoff MONTH and YEAR: " D ^%DT K %DT I Y<1 Q
 S DATEINAC=$E(Y,1,5)_"00"
 ;
 ;*98 Branch to PRCPRSSP if the inventory point being reported is a 
 ;primary or secondary
 ;
 I PRCP("DPTYPE")'="W" D ENT^PRCPRSSP Q
 ; 
 N ZTDESC,ZTRTN,ZTSAVE,POP
 W ! S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Stock Status Report",ZTRTN="DQ^PRCPRSSR"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("DATE*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 ;
DQ ;  queue starts here
 N ACCT,ADJ,ADJN,AVERAGE,D,DA,DATE,DATELONG,DUEIN,DUEOUT,INACT,INACTN,INVVAL,ISS,ISSN,ITEMDA,LONG,LONGN,NONISS,NONISSN,ONHAND,OPEN,QTY,REC,RECN,TOTAL,TOTDAYS,TRANSNO,TYPE,VALUE
 K OPEN
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.1,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S X=$$GETOPEN^PRCPUBAL(PRCP("I"),ITEMDA,$E(DATESTRT,1,5)) I X'="" D
 .   S ACCT=$$ACCT1^PRCPUX1($$FSC^PRCPUX1(ITEMDA))
 .   S $P(OPEN(ACCT),"^")=$P($G(OPEN(ACCT)),"^")+$P(X,"^",2)+$P(X,"^",3)
 .   S $P(OPEN(ACCT),"^",2)=$P($G(OPEN(ACCT)),"^",2)+$P(X,"^",8)
 S DATE=DATESTRT F  S DATE=$O(^PRCP(445.2,"AX",PRCP("I"),DATE)) Q:$E(DATE,1,5)'=$E(DATESTRT,1,5)  S TYPE="" F  S TYPE=$O(^PRCP(445.2,"AX",PRCP("I"),DATE,TYPE)) Q:TYPE=""  D
 .   S DA=0 F  S DA=$O(^PRCP(445.2,"AX",PRCP("I"),DATE,TYPE,DA)) Q:'DA  D
 .   .   S D=$G(^PRCP(445.2,DA,0)) I '$P(D,"^",5) Q
 .   .   ;  non-issuable
 .   .   Q:$P(D,"^",11)="N"  ;count if not flagged as non-issueable
 .   .   S ACCT=$$ACCT1^PRCPUX1($$FSC^PRCPUX1($P(D,"^",5)))
 .   .   S TRANSNO=$P(D,"^",19)
 .   .   S INVVAL=$P(D,"^",7)*$P(D,"^",8) I $P(D,"^",22)'="" S INVVAL=$P(D,"^",22)
 .   .   ;  set transno temporary for primary and secondary to
 .   .   ;  indicate type of transaction
 .   .   I PRCP("DPTYPE")'="W" D
 .   .   .   I TYPE="R"!(TYPE="C")!(TYPE="E")!(TYPE="U")!(TYPE="S") S TRANSNO="--1" Q  ;usage
 .   .   .   I TYPE="RC" S TRANSNO=1 Q  ;receipt
 .   .   .   S TRANSNO="" ;adjustment
 .   .   ;  other adjustments
 .   .   I PRCP("DPTYPE")="W",$P(TRANSNO,"-",2)="" S ADJ(ACCT)=$G(ADJ(ACCT))+INVVAL,ADJN(ACCT)=$G(ADJN(ACCT))+1 Q
 .   .   I TRANSNO="" S ADJ(ACCT)=$G(ADJ(ACCT))+INVVAL,ADJN(ACCT)=$G(ADJN(ACCT))+1
 .   .   E  D
 .   .   .   ;  purchase order
 .   .   .   I $P(TRANSNO,"-",3)="" S REC(ACCT)=$G(REC(ACCT))+INVVAL,RECN(ACCT)=$G(RECN(ACCT))+1 Q
 .   .   .   ;  usage
 .   .   .   S ISS(ACCT)=$G(ISS(ACCT))+INVVAL,ISSN(ACCT)=$G(ISSN(ACCT))+1
 ;
 ;  calculate inactive, long supply, set non-issuable
 ;
 ;*98 Modified long supply range to be 90 days instead of 270 days for 
 ;warehouse, primary, and secondary reporting
 ;
 S X1=$E(DT,1,5)_"01",X2=-89 D C^%DTC S DATELONG=$E(X,1,5),X1=DT,X2=$E(X,1,5)_"00" D ^%DTC S TOTDAYS=X
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S D=$G(^(ITEMDA,0)) I D'="" D
 .   S ACCT=$$ACCT1^PRCPUX1($$FSC^PRCPUX1(ITEMDA))
 .   ;  value
 .   S VALUE(ACCT)=$G(VALUE(ACCT))+$P(D,"^",27)
 .   S DUEIN(ACCT)=$G(DUEIN(ACCT))+($$GETIN^PRCPUDUE(PRCP("I"),ITEMDA)*$P(D,"^",22))
 .   S DUEOUT(ACCT)=$G(DUEOUT(ACCT))+($$GETOUT^PRCPUDUE(PRCP("I"),ITEMDA)*$P(D,"^",22))
 .   ;  non-issuable
 .   I $P(D,"^",19) S NONISS(ACCT)=$G(NONISS(ACCT))+($J($P(D,"^",19)*$P(D,"^",22),0,2)),NONISSN(ACCT)=$G(NONISSN(ACCT))+1
 .   ;  inactive
 .   ;  if reusable, quit
 .   I $$REUSABLE^PRCPU441(ITEMDA) Q
 .   S QTY=$P(D,"^",7)+$P(D,"^",19)
 .   I QTY,'$O(^PRCP(445,PRCP("I"),1,ITEMDA,2,$E(DATEINAC,1,5)-.01)),'$O(^PRCP(445,PRCP("I"),1,ITEMDA,3,DATEINAC)) S INACT(ACCT)=$G(INACT(ACCT))+$P(D,"^",27),INACTN(ACCT)=$G(INACTN(ACCT))+1
 .   ;  long supply
 .   S DATE=DATELONG-.01,TOTAL=0 F  S DATE=$O(^PRCP(445,PRCP("I"),1,ITEMDA,2,DATE)) Q:'DATE  S TOTAL=TOTAL+$P($G(^(DATE,0)),"^",2)
 .   S AVERAGE=$J(TOTAL/TOTDAYS,0,2),TOTAL=$S('AVERAGE&(QTY):9999999,'AVERAGE:0,1:QTY/AVERAGE\1)
 .   I TOTAL>90 S LONG(ACCT)=$G(LONG(ACCT))+$P(D,"^",27),LONGN(ACCT)=$G(LONGN(ACCT))+1
 ;
 ;*98 Routed printing based on Warehouse
 D PRINT^PRCPRSS0
 Q
