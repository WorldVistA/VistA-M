PRCPRCAT ;WISC/RFJ/DL-order form ;  1/28/98  1000
V ;;5.1;IFCAP;**1,132**;Oct 20, 2000;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N PRCPBLNK,PRCPDATE,PRCPEND,PRCPINFR,PRCPINPT,PRCPFLAG,PRCPFONE,PRCPFNON,PRCPSSIT,X,Y,Z
 K X S X(1)="The Order Form prints the current or selected inventory point's items sorted by main storage location and description.  Blanks for daily ordering may be included."
 D DISPLAY^PRCPUX2(40,79,.X)
 ;
 I PRCP("DPTYPE")="S" S PRCPINPT=PRCP("I") G MONTHYR
 ;
 K X S X(1)="Select a Distribution Point or press the <return> key to select the current inventory point."
 D DISPLAY^PRCPUX2(2,40,.X)
 S PRCPINPT=$$TO^PRCPUDPT(PRCP("I")) Q:PRCPINPT["^"
 I 'PRCPINPT S PRCPINPT=PRCP("I")
 ;
 ;  jump to here if a secondary
MONTHYR W ! K X S X(1)="Select the month-year of the order form for "_$$INVNAME^PRCPUX1(PRCPINPT)_"."
 D DISPLAY^PRCPUX2(2,40,.X)
 S %DT("A")="Print Catalog/Order Form for DATE: "
 S %DT("B")="TODAY",%DT="AEX" D ^%DT K %DT Q:Y<0
 S PRCPEND=$P("31^28^31^30^31^30^31^31^30^31^30^31","^",+$E(Y,4,5))
 I PRCPEND=28 S Z=$E(Y,1,3)+1700,PRCPEND=$S(Z#400=0:29,(Z#4=0&(Z#100'=0)):29,1:28)
 S Y=$E(Y,1,5)_"00" D DD^%DT S PRCPDATE=Y
 ;
 D  Q:$G(PRCPFLAG)  G BLANKS:$P($G(^PRCP(445,PRCPINPT,0)),"^",3)="S"
 .   S PRCPSSIT=1
 .   S XP="Print only items with a non-zero normal level"
 .   S XH="Enter YES to print only items whose normal level is not zero in "_$$INVNAME^PRCPUX1(PRCPINPT)_"."
 .   S XH(1)="Enter NO to print all items in "_$$INVNAME^PRCPUX1(PRCPINPT)_"."
 .   S XH(2)="Enter ^ to exit."
 .   W ! S %=$$YN^PRCPUYN(1) I %<1 S PRCPFLAG=1 Q
 .   I %=2 K PRCPSSIT
 ;
 S PRCPINFR=$$FROMCHEK^PRCPUDPT(PRCPINPT,0)
 I PRCPINFR D  Q:$G(PRCPFLAG)
 .   S XP="Print only the items stocked by "_$$INVNAME^PRCPUX1(PRCPINFR)
 .   S XH="Enter YES to only print the items stocked by "_$$INVNAME^PRCPUX1(PRCPINFR)_"."
 .   S XH(1)="Enter NO to print all items in "_$$INVNAME^PRCPUX1(PRCPINPT)_"."
 .   S XH(2)="Enter ^ to exit."
 .   W ! S %=$$YN^PRCPUYN(1) I %<1 S PRCPFLAG=1 Q
 .   I %=2 K PRCPINFR
 ;
BLANKS S PRCPBLNK=1
 I "SP"[(PRCP("DPTYPE")) D
 .   S XP="Include blanks on printout"
 .   S XH="Enter YES to print blanks on the order form."
 .   S XH(1)="Enter NO to print just the items and related information."
 .   S XH(2)="Enter ^ to exit."
 .   W ! S %=$$YN^PRCPUYN(1) I %<1 S PRCPFLAG=1 Q
 .   I %=2 K PRCPBLNK
 ;
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Order Form",ZTRTN="DQ^PRCPRCAT"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 ;
 ;  queue comes here
DQ N %I,DAY,DAY1,DESCR,ITEMCOST,ITEMDA,ITEMDATA,MAINLOC,NOW,PAGE,PRCPFLAG,PRCPINNM,SCREEN,WHSESRCE,X,Y
 K ^TMP($J,"PRCPRCAT")
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCPINPT,1,ITEMDA)) Q:'ITEMDA  D
 .   I $G(PRCPINFR),'$D(^PRCP(445,PRCPINFR,1,ITEMDA,0)) Q
 .   I '$D(^PRCP(445,PRCPINPT,1,ITEMDA,0)) Q
 .   I $G(PRCPSSIT),$P(^PRCP(445,PRCPINPT,1,ITEMDA,0),"^",9)'>0 Q
 .   S MAINLOC=$$STORAGE^PRCPESTO(PRCPINPT,ITEMDA)
 .   S DESCR=$$DESCR^PRCPUX1(PRCPINPT,ITEMDA) S:DESCR="" DESCR=" "
 .   S ^TMP($J,"PRCPRCAT",MAINLOC,$E(DESCR,1,20),ITEMDA)=""
 ;
 ;  setup order form format
 S DAY="" F %=1:1:PRCPEND S DAY=DAY_"| "_$J(%,2)
 I IOM<81 S DAY1="|"_$P(DAY,"15|",2),DAY=$P(DAY,"15|")_"15"
 ;
 S WHSESRCE=+$O(^PRC(440,"AC","W",0))
 S PRCPINNM=$$INVNAME^PRCPUX1(PRCPINPT)
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,SCREEN=$$SCRPAUSE^PRCPUREP,PAGE=1 U IO D H
 S MAINLOC="" F  S MAINLOC=$O(^TMP($J,"PRCPRCAT",MAINLOC)) Q:MAINLOC=""!($G(PRCPFLAG))  D
 .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>" Q
 .   I $Y>(IOSL-7) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H
 .   W !!?5,"MAIN STORAGE LOCATION: ",$S(MAINLOC=" ":"<< NONE >>",1:MAINLOC)
 .   I '$G(PRCPBLNK) W !
 .   S DESCR="" F  S DESCR=$O(^TMP($J,"PRCPRCAT",MAINLOC,DESCR)) Q:DESCR=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRCAT",MAINLOC,DESCR,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  D
 .   .   I $Y>(IOSL-8) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H
 .   .   S ITEMDATA=$G(^PRCP(445,PRCPINPT,1,ITEMDA,0))
 .   .   S ITEMCOST=$P(ITEMDATA,"^",22) I $P(ITEMDATA,"^",15)>ITEMCOST S ITEMCOST=$P(ITEMDATA,"^",15)
 .   .   I $G(PRCPBLNK) W !!
 .   .   W $E($$DESCR^PRCPUX1(PRCPINPT,ITEMDA),1,28),?29,ITEMDA,?35,$TR($$NSN^PRCPUX1(ITEMDA),"-"),?50,$J($$UNIT^PRCPUX1(PRCPINPT,ITEMDA,"/"),8),$J($P(ITEMDATA,"^",10),6),$J($P(ITEMDATA,"^",9),6),$J(ITEMCOST,9,2),!
 .   .   I $$MANDSRCE^PRCPU441(ITEMDA)=WHSESRCE W "*"
 .   .   I $G(PRCPBLNK) D
 .   .   .   W ?2,"DAY: ",DAY,"|",!?2,"QTY: ",$TR(DAY,"1234567890","          "),"|"
 .   .   .   I $D(DAY1) W !?2,"DAY: ",DAY1,"|",!?2,"QTY: ",$TR(DAY1,"1234567890","          "),"|"
 I '$G(PRCPFLAG) D END^PRCPUREP
 K ^TMP($J,"PRCPRCAT") D ^%ZISC Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"ORDER FORM FOR: ",PRCPINNM,?(IOM-$L(%)),%
 W !?5,"FOR THE MONTH-YEAR: ",PRCPDATE
 W ?58,$J("STAND",6),$J("NORM",6),$J("UNIT",10),!,"DESCRIPTION",?29,"MI#",?35,"NSN",?50,$J("UNIT/IS",8),$J("REOPT",6),$J("STLVL",6),$J("COST",10)
 S %="",$P(%,"-",IOM+1)="" W !,%,!
 Q
