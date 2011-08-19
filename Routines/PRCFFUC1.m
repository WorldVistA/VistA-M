PRCFFUC1 ;WISC/SJG-UTILITY ROUTINE FOR HOLD FUNCTIONALITY ;7/18/95  10:39
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
H1 ; Help prompt for new accounting period
 K MSG S HELP=1,MSG(1)=" "
 S MSG(2)="Enter the calendar month and year of the accounting period that"
 S MSG(3)="this transaction should affect FMS.  Usually, accounting period"
 S MSG(4)="is used during the overlap period to affect the previous open"
 S MSG(5)="accounting period, so the default provided is the previous accounting"
 S MSG(6)="period.  FMS will accept any OPEN previous accounting period, but if you"
 S MSG(7)="choose one that is closed in FMS, the document will reject."
 S MSG(8)="Enter '??' at the accounting period prompt to view a table showing"
 S MSG(9)="the Accounting Periods."
 S MSG(10)=" "
 D EN^DDIOL(.MSG) K MSG D PAUSE
 Q
H2 ; Help for relating accounting period to calendar month
 N LN,BAR S BAR="|",HELP=1
 W !,"The values relationship between the Calendar Month",!,"and the Accounting Period and Fiscal Months is as follows:"
 S $P(LN,"_",45)="" W !,LN K LN S $P(LN,"-",45)=""
 W !?15,BAR,?18,"Accounting",?30,BAR,?33,"Calendar"
 W !?3,"Month",?15,BAR,?20,"Period",?30,BAR,?34,"Month",!,LN
 W !?3,"October",?15,BAR,?22,"01",?30,BAR,?36,"10"
 W !?3,"November",?15,BAR,?22,"02",?30,BAR,?36,"11"
 W !?3,"December",?15,BAR,?22,"03",?30,BAR,?36,"12"
 W !?3,"January",?15,BAR,?22,"04",?30,BAR,?36,"01"
 W !?3,"February",?15,BAR,?22,"05",?30,BAR,?36,"02"
 W !?3,"March",?15,BAR,?22,"06",?30,BAR,?36,"03"
 W !?3,"April",?15,BAR,?22,"07",?30,BAR,?36,"04"
 W !?3,"May",?15,BAR,?22,"08",?30,BAR,?36,"05"
 W !?3,"June",?15,BAR,?22,"09",?30,BAR,?36,"06"
 W !?3,"July",?15,BAR,?22,"10",?30,BAR,?36,"07"
 W !?3,"August",?15,BAR,?22,"11",?30,BAR,?36,"08"
 W !?3,"September",?15,BAR,?22,"12",?30,BAR,?36,"09"
 K LN S $P(LN,"_",45)="" W !,LN K LN
 W !!,"Example:"
 W !,"March is Accounting Period '06' and Calendar Month '03'"
 D PAUSE
 Q
PAUSE ; Pause screen when data is displayed
 W !!,"Press 'RETURN' to continue" R X:DTIME
 Q 
