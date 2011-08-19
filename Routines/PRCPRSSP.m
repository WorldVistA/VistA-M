PRCPRSSP ;WOIFO/DAP-stock status report for primaries and secondaries; 10/16/06 2:07pm ; 2/23/07 4:59pm
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;*83 Routine PRCPLO2 associated with PRC*5.1*83 is a modified copy of
 ;this routine and any changes made to this routine should also be
 ;considered for that routine as well.
 ;
 ;*98 Changed previous displays of "issues" to "usages"
 ;
ENT ;*98 Entry point from PRCPRSSR when inventory point is confirmed to be
 ;primary or secondary
 ; 
 N ZTDESC,ZTRTN,ZTSAVE,POP
 W ! S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Stock Status Report",ZTRTN="DQ^PRCPRSSP"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("DATE*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 ;
DQ ;  queue starts here
 N ACCT,ADJ,ADJN,AVERAGE,D,DA,DATE,DATELONG,DUEIN,DUEOUT,INACT,INACTN,INVVAL,ISS,ISSN,ITEMDA,LONG,LONGN,NONISS,NONISSN,ONHAND,OPEN,QTY,REC,RECN,TOTAL,TOTDAYS,TRANSNO,TYPE,VALUE
 N ODITEM,NODE1,X,X1,X2
 K ^TMP($J)
 K OPEN
 ;*98 Modified calculations to separate ODI and Standard Items
 ;
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  D
 .   S NODE1=1
 .   S ODITEM=$$ODITEM^PRCPUX2(PRCP("I"),ITEMDA)
 .   I ODITEM="Y" S NODE1=2
 .   S ACCT=$$ACCT1^PRCPUX1($$FSC^PRCPUX1(ITEMDA))
 .   ;*98 Added item counter logic
 .   S ^TMP($J,NODE1,"CNT",ACCT)=$G(^TMP($J,NODE1,"CNT",ACCT))+1
 ;  
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.1,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S X=$$GETOPEN^PRCPUBAL(PRCP("I"),ITEMDA,$E(DATESTRT,1,5)) I X'="" D
 .   S NODE1=1
 .   S ODITEM=$$ODITEM^PRCPUX2(PRCP("I"),ITEMDA)
 .   I ODITEM="Y" S NODE1=2
 .   S ACCT=$$ACCT1^PRCPUX1($$FSC^PRCPUX1(ITEMDA))
 .   ;*98 Added item counter logic
 .   S $P(^TMP($J,NODE1,"OPEN",ACCT),"^")=$P($G(^TMP($J,NODE1,"OPEN",ACCT)),"^")+$P(X,"^",2)+$P(X,"^",3)
 .   S $P(^TMP($J,NODE1,"OPEN",ACCT),"^",2)=$P($G(^TMP($J,NODE1,"OPEN",ACCT)),"^",2)+$P(X,"^",8)
 S DATE=DATESTRT F  S DATE=$O(^PRCP(445.2,"AX",PRCP("I"),DATE)) Q:$E(DATE,1,5)'=$E(DATESTRT,1,5)  S TYPE="" F  S TYPE=$O(^PRCP(445.2,"AX",PRCP("I"),DATE,TYPE)) Q:TYPE=""  D
 .   S DA=0 F  S DA=$O(^PRCP(445.2,"AX",PRCP("I"),DATE,TYPE,DA)) Q:'DA  D
 ..  S D=$G(^PRCP(445.2,DA,0)) I '$P(D,"^",5) Q
 ..  ;  non-issuable
 ..  Q:$P(D,"^",11)="N"  ;count if not flagged as non-issueable
 ..  S ACCT=$$ACCT1^PRCPUX1($$FSC^PRCPUX1($P(D,"^",5)))
 ..  S TRANSNO=$P(D,"^",19)
 ..  S INVVAL=$P(D,"^",7)*$P(D,"^",8) I $P(D,"^",22)'="" S INVVAL=$P(D,"^",22)
 ..  S NODE1=1
 ..  I $$ODITEM^PRCPUX2(PRCP("I"),$P(D,"^",5))="Y" S NODE1=2
 ..  ;  set transno temporary for primary and secondary to
 ..  ;  indicate type of transaction
 ..  ;*98 Removed warehouse check from loop entry below
 ..  D
 ... I TYPE="R"!(TYPE="C")!(TYPE="E")!(TYPE="U")!(TYPE="S") S TRANSNO="--1" Q  ;usage
 ... I TYPE="RC" S TRANSNO=1 Q  ;receipt
 ... S TRANSNO="" ;adjustment
 ..  ;  other adjustments
 ..  ;*98 Removed line featuring warehouse logic 
 ..  ;I PRCP("DPTYPE")="W",$P(TRANSNO,"-",2)="" S ^TMP($J,NODE1,"ADJ",ACCT)=$G(^TMP($J,NODE1,"ADJ",ACCT))+INVVAL,^TMP($J,NODE1,"ADJN",ACCT)=$G(^TMP($J,NODE1,"ADJN",ACCT))+1 Q
 ..  I TRANSNO="" S ^TMP($J,NODE1,"ADJ",ACCT)=$G(^TMP($J,NODE1,"ADJ",ACCT))+INVVAL,^TMP($J,NODE1,"ADJN",ACCT)=$G(^TMP($J,NODE1,"ADJN",ACCT))+1
 ..  E  D
 ... ;  purchase order
 ... I $P(TRANSNO,"-",3)="" S ^TMP($J,NODE1,"REC",ACCT)=$G(^TMP($J,NODE1,"REC",ACCT))+INVVAL,^TMP($J,NODE1,"RECN",ACCT)=$G(^TMP($J,NODE1,"RECN",ACCT))+1 Q
 ... ;  usage
 ... S ^TMP($J,NODE1,"ISS",ACCT)=$G(^TMP($J,NODE1,"ISS",ACCT))+INVVAL,^TMP($J,NODE1,"ISSN",ACCT)=$G(^TMP($J,NODE1,"ISSN",ACCT))+1
 ;
 ;  calculate inactive, long supply, set non-issuable
 ;
 ;*98 Modified long supply range to be 90 days instead of 270 days for 
 ;warehouse, primary, and secondary reporting
 ;
 S X1=$E(DT,1,5)_"01",X2=-89 D C^%DTC S DATELONG=$E(X,1,5),X1=DT,X2=$E(X,1,5)_"00" D ^%DTC S TOTDAYS=X
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S D=$G(^(ITEMDA,0)) I D'="" D
 .   S NODE1=1
 .   S ODITEM=$$ODITEM^PRCPUX2(PRCP("I"),ITEMDA)
 .   I ODITEM="Y" S NODE1=2
 .   S ACCT=$$ACCT1^PRCPUX1($$FSC^PRCPUX1(ITEMDA))
 .   ;  value
 .   S ^TMP($J,NODE1,"VALUE",ACCT)=$G(^TMP($J,NODE1,"VALUE",ACCT))+$P(D,"^",27)
 .   S ^TMP($J,NODE1,"DUEIN",ACCT)=$G(^TMP($J,NODE1,"DUEIN",ACCT))+($$GETIN^PRCPUDUE(PRCP("I"),ITEMDA)*$P(D,"^",22))
 .   S ^TMP($J,NODE1,"DUEOUT",ACCT)=$G(^TMP($J,NODE1,"DUEOUT",ACCT))+($$GETOUT^PRCPUDUE(PRCP("I"),ITEMDA)*$P(D,"^",22))
 .   ;*98 Removed non-issuable section since they never appear for primary or secondary inventory points
 .   ;
 .   ;  inactive
 .   ;  if reusable, quit
 .   I $$REUSABLE^PRCPU441(ITEMDA) Q
 .   S QTY=$P(D,"^",7)+$P(D,"^",19)
 .   I QTY,'$O(^PRCP(445,PRCP("I"),1,ITEMDA,2,$E(DATEINAC,1,5)-.01)),'$O(^PRCP(445,PRCP("I"),1,ITEMDA,3,DATEINAC)) D
 . . S ^TMP($J,NODE1,"INACT",ACCT)=$G(^TMP($J,NODE1,"INACT",ACCT))+$P(D,"^",27),^TMP($J,NODE1,"INACTN",ACCT)=$G(^TMP($J,NODE1,"INACTN",ACCT))+1 Q
 .   ;  long supply
 .   S DATE=DATELONG-.01,TOTAL=0 F  S DATE=$O(^PRCP(445,PRCP("I"),1,ITEMDA,2,DATE)) Q:'DATE  S TOTAL=TOTAL+$P($G(^(DATE,0)),"^",2)
 .   S AVERAGE=$J(TOTAL/TOTDAYS,0,2),TOTAL=$S('AVERAGE&(QTY):9999999,'AVERAGE:0,1:QTY/AVERAGE\1)
 .   I TOTAL>90 S ^TMP($J,NODE1,"LONG",ACCT)=$G(^TMP($J,NODE1,"LONG",ACCT))+$P(D,"^",27),^TMP($J,NODE1,"LONGN",ACCT)=$G(^TMP($J,NODE1,"LONGN",ACCT))+1
 ;
 ;*98 Create consolidated array of Standard and ODI items
 N I,PRCPQ1,PRCPQ2,L,TEMPDATA
 F I=1:1:2 D
 .   S PRCPQ1=""
 .   F  S PRCPQ1=$O(^TMP($J,I,PRCPQ1)) Q:PRCPQ1=""  D
 ..  S PRCPQ2=""
 ..  F  S PRCPQ2=$O(^TMP($J,I,PRCPQ1,PRCPQ2)) Q:PRCPQ2=""  D
 ... S TEMPDATA=^TMP($J,I,PRCPQ1,PRCPQ2)
 ... F L=1:1:2 S $P(^TMP($J,3,PRCPQ1,PRCPQ2),"^",L)=$P($G(^TMP($J,3,PRCPQ1,PRCPQ2)),"^",L)+$P(TEMPDATA,"^",L)
 ;
 ;*98 Routed printing based on Primary/Secondary status
 D PRINT^PRCPRSS1
 Q
