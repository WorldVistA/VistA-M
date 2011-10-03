PRCPRISR ;WISC/RFJ-inventory sales (option, whse)                   ;24 May 93
V ;;5.1;IFCAP;**1**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")="P" D PRIMARY^PRCPRISP Q
 I PRCP("DPTYPE")="S" D SECOND^PRCPRISS Q
 ;
 ;  inventory sales report for whse
 N DATEEND,DATESTRT,DISTRALL,PRCPEND,PRCPSTRT,PRCPSUMM,X
 K X S X(1)="The Inventory Sales Report will display all sales from the Warehouse to the Primary inventory points.  This report is sorted by NSN, the distribution point, and date issued." D DISPLAY^PRCPUX2(40,79,.X)
 K X S X(1)="Select the range of NSNs to display" W !! D DISPLAY^PRCPUX2(2,40,.X)
 D NSNSEL^PRCPURS0 I '$D(PRCPSTRT) Q
 K X S X(1)="Select the DISTRIBUTION POINTS to display" D DISPLAY^PRCPUX2(2,40,.X)
 D DISTRSEL^PRCPURS3(PRCP("I"))
 I '$G(DISTRALL),'$O(^TMP($J,"PRCPURS3","YES",0)) W !,"*** NO DISTRIBUTION POINTS SELECTED !" D Q Q
 K X S X(1)="Select the range of ISSUE DATES to display" W !! D DISPLAY^PRCPUX2(2,40,.X)
 D DATESEL^PRCPURS2("Issue") I '$G(DATEEND) D Q Q
 S PRCPSUMM=$$SUMMARY^PRCPURS0 I PRCPSUMM<0 D Q Q
 W ! S %ZIS="Q" D ^%ZIS G:POP Q I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK D Q Q
 . S ZTDESC="Warehouse Inventory Sales Report",ZTRTN="DQ^PRCPRISR"
 . S ZTSAVE("PRCP*")="",ZTSAVE("DATE*")="",ZTSAVE("DISTRALL")="",ZTSAVE("^TMP($J,""PRCPURS3"",")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 D PRINT^PRCPRISW
Q D ^%ZISC K ^TMP($J,"PRCPURS3"),^TMP($J,"PRCPRISR"),^TMP($J,"PRCPRISR TOT")
 Q
