PRCPRDI0 ;WISC/RFJ-update/print due-ins from 410 and 442            ;30 Aug 91
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,PRCPDATD,PRCPDATE,PRCPFLAG,PRCPFUPD,PRCPWHSE,X,Y
 S PRCPWHSE=$O(^PRC(440,"AC","S",0))_";PRC(440,"
 I '$D(^PRC(440,+PRCPWHSE,0)),PRCP("DPTYPE")'="W" W !,"THERE IS NOT A VENDOR IN THE VENDOR FILE (#440) DESIGNATED AS A SUPPLY WHSE.",!,"YOU WILL NOT BE ABLE TO CALCULATE DUE-INS FOR ISSUE BOOK REQUESTS."
 W !! S %DT="AEP",%DT("A")="Start with Transactions Requested After DATE: ",%DT(0)=-DT D ^%DT K %DT Q:Y<1  S PRCPDATE=Y D DD^%DT S PRCPDATD=Y
 ;
 I $$KEY^PRCPUREP("PRCP"_$TR(PRCP("DPTYPE"),"WSP","W2")_" MGRKEY",DUZ) D
 .   S DIR(0)="S^1:Print Report with Calculated Due-Ins;2:Update Due-Ins for Inventory Point",DIR("A")="Select OPTION",DIR("B")="Print Report with Calculated Due-Ins"
 .   W ! D ^DIR K DIR I Y<1 S PRCPFLAG=1 Q
 .   I Y'=2 Q
 .   I $P($H,",",2)>21600,$P($H,",",2)<64800 D
 .   .   K X S X(1)="If you choose to update the due-ins, ALL CONTROL POINT and INVENTORY POINT ACTIVITY will be HALTED for several hours.  I STRONGLY suggest you run this report after hours."
 .   .   D DISPLAY^PRCPUX2(5,75,.X)
 .   S XP="ARE YOU SURE YOU WANT TO UPDATE THE DUE-INS (FROM DATE: "_PRCPDATD_") FOR THIS",XP(1)="INVENTORY POINT"
 .   W ! S %=$$YN^PRCPUYN(2) I '% S PRCPFLAG=1 Q
 .   I %=1 S PRCPFUPD=1
 I $G(PRCPFLAG) Q
 ;
 W ! S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Calculate Due-Ins",ZTRTN="DQ^PRCPRDI1"
 .   S ZTSAVE("PRC*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 D DQ^PRCPRDI1
 Q
