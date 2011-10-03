PRCPRCFP ;WISC/RFJ/DST-conversion factor report (primary, secondary)    ;09 Jun 93
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
PRIMARY ;  conversion factor report for primary and secondary
 N GROUPALL,X
 K X S X(1)="The Conversion Factor Report will display the inventory point items with procurement sources and conversion factors."
 S X(2)="This report will sort the Primary and Secondary inventory items by the Group Category, Description, and Procurement Source."
 D DISPLAY^PRCPUX2(40,79,.X)
 K X S X(1)="Select the Group Categories to display" D DISPLAY^PRCPUX2(2,40,.X)
 D GROUPSEL^PRCPURS1(PRCP("I"))
 I '$G(GROUPALL),'$O(^TMP($J,"PRCPURS1","YES",0)) W !,"*** NO GROUP CATEGORIES SELECTED !" D Q Q
 W !,"NOTE:  The report will",$S('$G(GROUPALL):" NOT",1:"")," include items not stored in a group category."
 ; Prompt for On-Demand Item selection, if not warehouse
 N ODIS
 S ODIS=$$ODIPROM^PRCPUX2(0)
 I 'ODIS D Q Q
 ;
 W ! S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Conversion Factor Report",ZTRTN="DQ^PRCPRCFP"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("GROUPALL")="",ZTSAVE("ODIS")="",ZTSAVE("^TMP($J,""PRCPURS1"",")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 N %,%H,%I,DESCR,GROUP,GROUPNM,ITEMDA,ITEMDATA,NOW,NSN,PAGE,PRCPFLAG,SCREEN,VENDATA,VENNM,X,Y
 N ODI  ; On-Demand Item flag
 K ^TMP($J,"PRCPRCFP")
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  D
 .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 .   S GROUP=+$P(ITEMDATA,"^",21)
 .   I 'GROUP,'$G(GROUPALL) Q
 .   I $G(GROUPALL),$D(^TMP($J,"PRCPURS1","NO",GROUP)) Q
 .   I '$G(GROUPALL),'$D(^TMP($J,"PRCPURS1","YES",GROUP)) Q
 .   S GROUPNM=$$GROUPNM^PRCPEGRP(GROUP)
 .   I GROUPNM'="" S GROUPNM=$E(GROUPNM,1,20)_" (#"_GROUP_")"
 .   S:GROUPNM="" GROUPNM=" "
 .   S DESCR=$$DESCR^PRCPUX1(PRCP("I"),ITEMDA) S:DESCR="" DESCR=" "
 .   S X=0 F  S X=$O(^PRCP(445,PRCP("I"),1,ITEMDA,5,X)) Q:'X  S VENDATA=$G(^(X,0)) I VENDATA'="" D
 .   .   S VENNM=$$VENNAME^PRCPUX1($P(VENDATA,"^")) S:VENNM="" VENNM=" "
 .   .   S ^TMP($J,"PRCPRCFP",GROUPNM,$E(DESCR,1,30),ITEMDA,$E(VENNM,1,20))=VENDATA
 ;  print report
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S GROUP="" F  S GROUP=$O(^TMP($J,"PRCPRCFP",GROUP)) Q:GROUP=""!($G(PRCPFLAG))  D
 .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   W !!?5,"GROUP: ",$S(GROUP=" ":"<<NONE>>",1:GROUP)
 .   S DESCR="" F  S DESCR=$O(^TMP($J,"PRCPRCFP",GROUP,DESCR)) Q:DESCR=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRCFP",GROUP,DESCR,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  D
 .   .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 .   .   ; On-Demand Item flag check and display
 .   .   S ODI=$$ODITEM^PRCPUX2(PRCP("I"),ITEMDA)
 .   .   Q:(ODIS=1)&(ODI="Y")
 .   .   Q:(ODIS=2)&(ODI'="Y")
 .   .   ;
 .   .   W !,DESCR,?32,$S(ODI="Y":"D",1:""),?46,ITEMDA,?53,$J(+$P(ITEMDATA,"^",7),8),$J($$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/"),10)
 .   .   S VENNM="" F  S VENNM=$O(^TMP($J,"PRCPRCFP",GROUP,DESCR,ITEMDA,VENNM)) Q:VENNM=""!($G(PRCPFLAG))  S VENDATA=^(VENNM) D
 .   .   .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   .   .   S %=$S($P(VENDATA,"^")["PRCP(445":"I#",1:"V#")_+VENDATA
 .   .   .   W !?29,VENNM,?51,$J(%,8),?61,$J($$UNITVAL^PRCPUX1($P(VENDATA,"^",3),$P(VENDATA,"^",2),"/"),10),$J($P(VENDATA,"^",4),9)
 .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>"
 I '$G(PRCPFLAG) D END^PRCPUREP
Q D ^%ZISC K ^TMP($J,"PRCPRCFP"),^TMP($J,"PRCPURS1")
 Q
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"CONVERSION FACTOR REPORT FOR: ",$E(PRCP("IN"),1,20),?(80-$L(%)),%
 W !,$S(ODIS=2:"ON-DEMAND ITEMS ONLY",ODIS=3:"ALL ITEMS (STANDARD AND ON-DEMAND)",1:"STANDARD ITEMS ONLY")
 S %="",$P(%,"-",81)=""
 W !,"DESCRIPTION",?32,"OD",?46,"IM",$J("QTY OH",13),$J("UNIT/IS",10)
 W !?29,"PROCUREMENT SOURCE",?55,"IV#",?61,$J("UNIT/RE",10),$J("CF",9),!,%
 Q
