PRCPBAL3 ;WISC/RFJ/DWA-release,print the pick ticket for barcode orders ;04 Dec 92
 ;;5.1;IFCAP;**47**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
RELEASE ;  release orders in ^tmp($j,"prcpbal3",orderda)
 N ITEMDA,ORDERDA,PRCPFLAG,PRCPORD,PRCPPAT,PRCPPRIM,PRCPSECO
 S ORDERDA=0 F  S ORDERDA=$O(^TMP($J,"PRCPBAL3",ORDERDA)) Q:'ORDERDA  D
 .   L +^PRCP(445.3,ORDERDA):2 Q:'$T
 .   D VARIABLE^PRCPOPU
 .   I PRCPORD(0)="" L -^PRCP(445.3,ORDERDA) Q
 .   W !,"Order # ",$P(PRCPORD(0),"^")
 .   I $P(PRCPORD(0),"^",6)'="" W ?20,"Already released" L -^PRCP(445.3,ORDERDA) Q
 .   ;  check for items
 .   S (ITEMDA,PRCPFLAG)=0 F  S ITEMDA=$O(^PRCP(445.3,ORDERDA,1,ITEMDA)) Q:'ITEMDA  I $P($G(^(ITEMDA,0)),"^",2),$$ITEMCHK^PRCPOPER(PRCPPRIM,PRCPSECO,ITEMDA)'="" S PRCPFLAG=1 Q
 .   I PRCPFLAG W ?20,"NOT RELEASED, errors found with ordered items." K ^TMP($J,"PRCPBAL3",ORDERDA) L -^PRCP(445.3,ORDERDA) Q
 .   D RELEASE^PRCPOPR(ORDERDA)
 .   L -^PRCP(445.3,ORDERDA)
 .   W ?20,"Released !"
 Q
 ;
 ;
PICKTICK ;  print picking tickets in ^tmp($j,"prcpbal3",orderda)
 ;
DEVICE ;
 K X S X(1)="Enter the DEVICE which will be used to print the picking tickets." D DISPLAY^PRCPUX2(2,40,.X)
 W ! S %ZIS="Q" D ^%ZIS Q:POP
 I IO=IO(0) W !,"YOU CANNOT SELECT YOUR CURRENT DEVICE FOR PRINTING PICKING TICKETS." G DEVICE
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Print Picking Tickets",ZTRTN="DQ^PRCPBAL3"
 .   S ZTSAVE("^TMP($J,""PRCPBAL3"",")="",ZTSAVE("ZTREQ")="@"
 ;
DQ ;  print picking tickets for orders in ^tmp($j,"prcpbal3",orderda)
 N ORDERDA,PRCPORD,PRCPPAT,PRCPPRIM,PRCPSECO,X
 S ORDERDA=0 F  S ORDERDA=$O(^TMP($J,"PRCPBAL3",ORDERDA)) Q:'ORDERDA  D
 .   L +^PRCP(445.3,ORDERDA)
 .   D VARIABLE^PRCPOPU
 .   I PRCPORD(0)="" L -^PRCP(445.3,ORDERDA) Q
 .   U IO(0) W !,"Order # ",$P(PRCPORD(0),"^")
 .   I $P(PRCPORD(0),"^",6)'="R" W ?20,"Not released" L -^PRCP(445.3,ORDERDA) Q
 .   D BUILD^PRCPOPT(ORDERDA)
 .   D DQ^PRCPOPT1
 .   L -^PRCP(445.3,ORDERDA)
 .   U IO(0) W ?20,"Printed !"
 D Q^PRCPOPT
 Q
