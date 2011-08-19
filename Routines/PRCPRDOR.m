PRCPRDOR ;WISC/RFJ-distribution duein and dueout reports            ;22 Oct 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")="W" W !,"THIS OPTION SHOULD ONLY BE USED BY PRIMARIES AND SECONDARIES." Q
 N %,TYPE,UPDATE
 S TYPE="OUT" I PRCP("DPTYPE")="S" S TYPE="IN"
 W !!,"DUE-",TYPE," REPORT for inventory point ",PRCP("IN")
 I $$KEY^PRCPUREP("PRCP"_$S(TYPE="IN":"2",1:"")_" MGRKEY",DUZ) D  Q:%<1  S:%=1 UPDATE=1
 .   K X S X(1)="You have the option to update the DUE-"_TYPE_"'s to the calculated values.  If you choose to do this, the distribution order file and inventory point will"
 .   S X(2)="be locked and NO orders can be placed and NO data in the inventory point can be changed until the program finishes.  Therefore, I suggest this be done outside of normal business hours."
 .   D DISPLAY^PRCPUX2(5,75,.X)
 .   S XP="Do you want to update the inventory DUE-"_TYPE_"'s"
 .   S XH="Enter 'YES' to update the DUE-"_TYPE_"'s, 'NO' to only print the report, '^' to exit."
 .   W ! S %=$$YN^PRCPUYN(2)
 W ! I $G(UPDATE) W !,"In order to update the DUE-",TYPE,"'s, this report must be queued !"
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  Q
 .   S ZTDESC="Distribution Order Due-"_TYPE_" Report",ZTRTN="DQ^PRCPRDO1"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("TYPE")="",ZTSAVE("UPDATE")="",ZTSAVE("ZTREQ")="@"
 .   D ^%ZTLOAD
 I $G(UPDATE) W !,"I am not updating the DUE-",TYPE,"'s since this report has not be QUEUED !" K UPDATE
 W !!,"<*> please wait <*>"
 D DQ^PRCPRDO1
 Q
