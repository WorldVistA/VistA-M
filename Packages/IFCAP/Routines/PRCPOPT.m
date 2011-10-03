PRCPOPT ;WISC/RFJ-picking ticket for distribution order            ;27 Sep 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PICKLM ;  called from list manager to print picking ticket
 S VALMBCK="R"
 D FULL^VALM1
 D BUILD(ORDERDA)
 D VARIABLE^PRCPOPU
 S %ZIS="Q" D ^%ZIS I POP D Q Q
 I $D(IO("Q")) D  Q
 .   S ZTDESC="Print Picking Ticket (Primary to Secondary)",ZTRTN="DQ^PRCPOPT"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("ORDERDA")="",ZTSAVE("^TMP($J,""PRCPOPT PICK LIST"",")="",ZTSAVE("ZTREQ")="@"
 .   D ^%ZTLOAD K IO("Q"),ZTSK
 .   S:$D(^PRCP(445.3,ORDERDA,0)) $P(^(0),"^",7)="Y"
 .   D Q
 ;
DQ ;  queue comes here to print picking ticket
 D DQ^PRCPOPT1
Q ;  clean up
 D ^%ZISC
 K ^TMP($J,"PRCPOPT"),^TMP($J,"PRCPOPT PICK LIST"),^TMP($J,"PRCPCRPL-CC"),^TMP($J,"PRCPCRPL-IK")
 Q
 ;
 ;
BUILD(ORDERDA) ;  build order in tmp for printing the picking ticket
 N DATA,ITEMDA
 K ^TMP($J,"PRCPOPT PICK LIST")
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.3,ORDERDA,1,ITEMDA)) Q:'ITEMDA  S DATA=$G(^(ITEMDA,0)) I DATA'="" S ^TMP($J,"PRCPOPT PICK LIST",ITEMDA)=$P(DATA,"^",2)_"^"_$P(DATA,"^",4)
 Q
