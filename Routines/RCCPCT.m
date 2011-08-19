RCCPCT ;WASH-ISC@ALTOONA,PA/LDB - CCPC Statements totals ;11/7/96  10:53 AM
V ;;4.5;Accounts Receivable;**34**;Mar 20, 1995;
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;;
EN ;Ask for device
 D HOME^%ZIS S %ZIS="AEQ" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 .S ZTRTN="START^RCCPCT",ZTDESC="CCPC PATIENT STATEMENT TOTAL REPORT"
 .;S ZTIO=ION_";"_IOST_";"_IOM_";"_IOSL_";"_$G(IO("DOC"))
 .D ^%ZTLOAD,^%ZISC
 .K ZTRTN,ZTDESC
 ;
START ;find all transmission record totals
 N DATE,PTOT,TTOT,X
 U IO S (TTOT,X)=0 F  S X=$O(^RCT(349,X)) Q:'X  I $D(^(X,0)) S TTOT=$P(^(0),"^",7)+TTOT
 S (PTOT,X)=0 F  S X=$O(^RCPS(349.2,X)) Q:'X  I $G(^(X,6)) S PTOT=PTOT+1
 S DATE=$O(^RCT(349,0)) S:DATE DATE=$G(^(DATE,0))
 I DATE]"" S DATE=$P(DATE,"^",9),DATE=$E(DATE,1,2)_"/"_$E(DATE,3,4)_"/"_$E(DATE,5,8)
 E  S DATE="N/A (NO TRANSMISSIONS)"
 I IOST?1"C".E W @IOF
 W !,?25,"CCPC Message Totals for ",DATE,!!
 W "Transmission Statement Total  : ",$J(TTOT,9)
 W !,"CCPC Statements Printed Total : ",$J(PTOT,9)
 W !!,"Total Not Printed             : ",$J(TTOT-PTOT,9)
 D ^%ZISC Q
