PRCPRAIP ;WISC/RFJ/DST-abbreviated item report (primary, second)        ;09 Jun 93
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
PRIMARY ;  abbreviated item report for primary and secondary
 N GROUPALL,X
 N ODI,ODIS  ; for On-Demand Item 
 K X S X(1)="The Abbreviated Item Report will sort the Primary or Secondary inventory items by the group category code and description." D DISPLAY^PRCPUX2(40,79,.X)
 K X S X(1)="Select the Group Categories to display" D DISPLAY^PRCPUX2(2,40,.X)
 D GROUPSEL^PRCPURS1(PRCP("I"))
 I '$G(GROUPALL),'$O(^TMP($J,"PRCPURS1","YES",0)) W !,"*** NO GROUP CATEGORIES SELECTED !" D Q Q
 W !,"NOTE:  The report will",$S('$G(GROUPALL):" NOT",1:"")," include items not stored in a group category."
 ; Prompt for On-Demand Item selection
 S ODIS=$$ODIPROM^PRCPUX2(0)
 I 'ODIS D Q Q
 ;
 W ! S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Abbreviated Item Report",ZTRTN="DQ^PRCPRAIP"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("GROUPALL")="",ZTSAVE("ODIS")="",ZTSAVE("^TMP($J,""PRCPURS1"",")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 N %,%H,%I,GROUP,GROUPNM,DESCR,ITEMDA,ITEMDATA,NOW,PAGE,PRCPFLAG,SCREEN,X,Y
 K ^TMP($J,"PRCPRAIP")
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
 .   S ^TMP($J,"PRCPRAIP",GROUPNM,$E(DESCR,1,15),ITEMDA)=DESCR
 ;  print report
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S GROUP="" F  S GROUP=$O(^TMP($J,"PRCPRAIP",GROUP)) Q:GROUP=""!($G(PRCPFLAG))  D
 .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   W !!?5,"GROUP: ",$S(GROUP=" ":"<<NONE>>",1:GROUP)
 .   S DESCR="" F  S DESCR=$O(^TMP($J,"PRCPRAIP",GROUP,DESCR)) Q:DESCR=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRAIP",GROUP,DESCR,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  S X=^(ITEMDA) D
 .   .   ; Check ODI flag for this item
 .   .   S ODI=$$ODITEM^PRCPUX2(PRCP("I"),ITEMDA)
 .   .   ; If On-Demand Item display not selected, and is ODI, Quit
 .   .   Q:(ODIS=1)&(ODI="Y")
 .   .   ; If only On-Demand Item display selected, and not ODI, Quit
 .   .   Q:(ODIS=2)&(ODI'="Y")
 .   .   ;
 .   .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 .   .   W !,$E(X,1,23),?24,ITEMDA,?31,$S(ODI="Y":"D",1:""),?46,$J(+$P(ITEMDATA,"^",7),8),$J($$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/"),10),$J($$STORAGE^PRCPESTO(PRCP("I"),ITEMDA),16)
 .   .   S %=0 F  S %=$O(^PRCP(445,PRCP("I"),1,ITEMDA,1,%)) Q:'%!($G(PRCPFLAG))  D
 .   .   .   I $X>60 W !
 .   .   .   S X=$E($$STORELOC^PRCPESTO(%),1,15),X="     "_X_$E("               ",$L(X)+1,15)
 .   .   .   W X
 .   .   .   I $X>60,$Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>"
 I '$G(PRCPFLAG) D END^PRCPUREP
Q D ^%ZISC K ^TMP($J,"PRCPRAIP"),^TMP($J,"PRCPURS1")
 Q
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"ABBREVIATED ITEM REPORT FOR: ",$E(PRCP("IN"),1,20),?(80-$L(%)),%
 S %="",$P(%,"-",81)=""
 W !,$S(ODIS=2:"ON-DEMAND ITEMS ONLY",ODIS=3:"ALL ITEMS (STANDARD AND ON-DEMAND)",1:"STANDARD ITEMS ONLY")
 W !,"DESCRIPTION",?24,"IM",?31,$S(ODIS>1:"OD",1:""),?41,$J("QTY OH",13),$J("UNIT/IS",10),$J("MAIN STORAGE",16),!?5,"ADD STORAGE",?26,"ADD STORAGE",?46,"ADD STORAGE",?66,"ADD STORAGE",!,%
 Q
