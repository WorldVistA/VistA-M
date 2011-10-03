PRCPRDCR ;WISC/RFJ-dietetics cost report                            ;27 May 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,%H,%I,DATEEND,DATESTRT,INVPT,PRCPFLAG,PRCPIN,X,Y
 K X S X(1)="The Dietetic Cost Report is sorted by the inventory point (selectable), food group from the item master file, NSN, and date received (selectable)." D DISPLAY^PRCPUX2(40,79,.X)
 K X S X(1)="You can select multiple dietetic inventory points for printing this report.  A dietetic inventory point is defined as a primary inventory point with the first two digits of the department number equal to '11'."
 D DISPLAY^PRCPUX2(5,40,.X)
 K ^TMP($J,"PRCPRDIE") S PRCPIN=PRCP("IN")
 S PRCPIN="" I $E($P($G(^PRCP(445,PRCP("I"),0)),"^",8),1,2)="11" S PRCPIN=PRCP("IN")
 F  S INVPT=$$INVPT^PRCPUINV(PRC("SITE"),"P",0,1,PRCPIN) S:INVPT["^" PRCPFLAG=1 Q:'INVPT  D
 .   S PRCPIN=""
 .   I $E($P($G(^PRCP(445,+INVPT,0)),"^",8),1,2)'="11" W !?2,"CANNOT BE SELECTED.  FIRST TWO DIGITS OF DEPARTMENT NUMBER NOT EQUAL TO '11'." Q
 .   S ^TMP($J,"PRCPRDIE",INVPT)=""
 I $G(PRCPFLAG) D Q Q
 I '$O(^TMP($J,"PRCPRDIE",0)) Q
 W !
 K X S X(1)="Select the range of RECEIPT DATES to display" W !! D DISPLAY^PRCPUX2(5,40,.X)
 D DATESEL^PRCPURS2("Receipt") I '$G(DATEEND) D Q Q
 W ! S %ZIS="Q" D ^%ZIS G:POP Q I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK D Q Q
 .   S ZTDESC="Dietetic Cost Report",ZTRTN="DQ^PRCPRDCR"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("DATE*")="",ZTSAVE("^TMP($J,""PRCPRDIE"",")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 D START^PRCPRDC0
Q D ^%ZISC K ^TMP($J,"PRCPRDIE"),^TMP($J,"PRCPRDIET")
 Q
