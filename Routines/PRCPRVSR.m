PRCPRVSR ;WISC/RFJ-voucher summary (option, whse) ;9.9.97
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$D(PRCP("I"))
 N %,%H,%I,DATESTRT,X,Y
 K X S X(1)="The Voucher Summary Report will print a listing of all issues, receipts, and adjustments.  It will display the opening and closing balances by account codes."
 D DISPLAY^PRCPUX2(40,79,.X)
 K X S X(1)="Enter the date (month-year) for the Voucher Summary Report." D DISPLAY^PRCPUX2(2,40,.X)
 D NOW^%DTC S Y=$E(X,1,5)_"00" S %DT(0)=-Y D DD^%DT S %DT="AEP",%DT("B")=Y,%DT("A")="Print Voucher Summary for MONTH and YEAR: " D ^%DT K %DT I Y<1 Q
 S DATESTRT=$E(Y,1,5)_"00"
 W ! S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Voucher Summary Report",ZTRTN="DQ^PRCPRVSR"
 .   S ZTSAVE("PRC*")="",ZTSAVE("DATESTRT")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 N ACCT,CC,D,DA,DATE,INVVAL,ISSUE,ITEMDA,OPEN,REFNO,SA,SELLVAL,TRANSID,TRANSNO,TYPE,X,Y
 K OPEN
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.1,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S X=$$GETOPEN^PRCPUBAL(PRCP("I"),ITEMDA,$E(DATESTRT,1,5)) I X'="" D
 .   S ACCT=$$ACCT1^PRCPUX1($E($$NSN^PRCPUX1(ITEMDA),1,4))
 .   S $P(OPEN(ACCT),"^")=$P($G(OPEN(ACCT)),"^")+$P(X,"^",2)+$P(X,"^",3)
 .   S $P(OPEN(ACCT),"^",2)=$P($G(OPEN(ACCT)),"^",2)+$P(X,"^",8)
 K ^TMP($J,"PRCPRVSR")
 S DATE=DATESTRT F  S DATE=$O(^PRCP(445.2,"AX",PRCP("I"),DATE)) Q:$E(DATE,1,5)'=$E(DATESTRT,1,5)  S TYPE="" F  S TYPE=$O(^PRCP(445.2,"AX",PRCP("I"),DATE,TYPE)) Q:TYPE=""  D
 .   S DA=0 F  S DA=$O(^PRCP(445.2,"AX",PRCP("I"),DATE,TYPE,DA)) Q:'DA  D
 .   .   S D=$G(^PRCP(445.2,DA,0)) I '$P(D,"^",5) Q
 .   .   ;  non-issuable
 .   .   I $P(D,"^",11)'="" Q
 .   .   S ACCT=$$ACCT1^PRCPUX1($P($$NSN^PRCPUX1($P(D,"^",5)),"-"))
 .   .   S REFNO=$P(D,"^",15),TRANSNO=$P(D,"^",19),TRANSID=$P(D,"^",2),(ISSUE,CC,SA)=""
 .   .   S INVVAL=$P(D,"^",7)*$P(D,"^",8),SELLVAL=$P(D,"^",7)*$P(D,"^",9)
 .   .   I $P(D,"^",22)'="" S INVVAL=$P(D,"^",22),SELLVAL=$P(D,"^",23)
 .   .   ;  other adjustments
 .   .   I $P(TRANSNO,"-",2)="" S TRANSNO="OTHER"
 .   .   ;  purchase order
 .   .   I +TRANSNO,$P(TRANSNO,"-",3)="" S REFNO=$P($P(D,"^",19),"-",2),TRANSNO=$P(TRANSNO,"-"),SELLVAL=INVVAL
 .   .   ;  issue
 .   .   I +TRANSNO,$P(TRANSNO,"-",3)'="" D
 .   .   .   S CC=$P($G(^PRCS(410,+$O(^PRCS(410,"B",TRANSNO,0)),3)),"^",3),CC=+$S($D(^PRCD(420.1,+CC,0)):$P(^(0),"^"),1:CC),SA=$$SUBACCT^PRCPU441(+$P(D,"^",5)),TRANSNO=$P(TRANSNO,"-")_"-"_$P(TRANSNO,"-",4,5)
 .   .   S:REFNO="" REFNO="?????"
 .   .   I $D(^TMP($J,"PRCPRVSR",ACCT,REFNO,$E($P(D,"^",3),1,7),TRANSID)) S %=^(TRANSID) I $P(%,"^",3)=CC S $P(%,"^",5)=$P(%,"^",5)+$P(D,"^",7),$P(%,"^",6)=$P(%,"^",6)+INVVAL,$P(%,"^",7)=$P(%,"^",7)+SELLVAL,^(TRANSID)=% Q
 .   .   S ^TMP($J,"PRCPRVSR",ACCT,REFNO,$E($P(D,"^",3),1,7),$P(D,"^",2))=TRANSNO_"^"_$P(D,"^",2)_"^"_CC_"^"_SA_"^"_$P(D,"^",7)_"^"_INVVAL_"^"_SELLVAL
 D PRINT^PRCPRVS0
 Q
