PRCPRAVP ;WISC/RFJ-availability list report (primary)               ;18 May 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PRIMARY ;  availability list for primary (called from prcpravl)
 N GROUPALL,PRCPSUMM
 K X S X(1)="The Availability Listing will display the current quantity and value of the inventory point items.  The report will sort Primary or Secondary inventory items by Group Category and Description." D DISPLAY^PRCPUX2(40,79,.X)
 S PRCPSUMM=$$SUMMARY^PRCPURS0 I PRCPSUMM<0 Q
 I PRCPSUMM S GROUPALL=1 G DEVICE
 K X S X(1)="Select the Group Categories to display" W ! D DISPLAY^PRCPUX2(2,40,.X)
 D GROUPSEL^PRCPURS1(PRCP("I"))
 I '$G(GROUPALL),'$O(^TMP($J,"PRCPURS1","YES",0)) W !,"*** NO GROUP CATEGORIES SELECTED !" D Q Q
 W !,"NOTE:  The report will",$S('$G(GROUPALL):" NOT",1:"")," include items not stored in a group category."
DEVICE W ! S %ZIS="Q" D ^%ZIS G:POP Q I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK D Q Q
 .   S ZTDESC="Primary Availability Listing",ZTRTN="DQ^PRCPRAVP"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("GROUPALL")="",ZTSAVE("^TMP($J,""PRCPURS1"",")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 N %I,DESCR,DESCRIP,GROUP,GROUPNM,ITEMDA,ITEMDATA,NOW,NSN,PAGE,PRCPFLAG,SCREEN,TOTAL,TOTINV,X,Y
 K ^TMP($J,"PRCPRAVP"),^TMP($J,"PRCPRAVP TOT")
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S ITEMDATA=$G(^(ITEMDA,0)) D
 .   S GROUP=+$P(ITEMDATA,"^",21)
 .   I 'GROUP,'$G(GROUPALL) Q
 .   I $G(GROUPALL),$D(^TMP($J,"PRCPURS1","NO",GROUP)) Q
 .   I '$G(GROUPALL),'$D(^TMP($J,"PRCPURS1","YES",GROUP)) Q
 .   S GROUPNM=$$GROUPNM^PRCPEGRP(GROUP)
 .   I GROUPNM'="" S GROUPNM=$E(GROUPNM,1,20)_" (#"_GROUP_")"
 .   S:GROUPNM="" GROUPNM=" "
 .   S DESCR=$$DESCR^PRCPUX1(PRCP("I"),ITEMDA) S:DESCR="" DESCR=" "
 .   S ^TMP($J,"PRCPRAVP",GROUPNM,$E(DESCR,1,15),ITEMDA)=DESCR
 ;  print report
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S GROUPNM="" F  S GROUPNM=$O(^TMP($J,"PRCPRAVP",GROUPNM)) Q:GROUPNM=""!($G(PRCPFLAG))  D
 .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   W:'PRCPSUMM !!?5,"GROUP NAME: ",$S(GROUPNM=" ":"<<ITEMS NOT STORED IN A GROUP CATEGORY>>",1:GROUPNM)
 .   S DESCR="" F  S DESCR=$O(^TMP($J,"PRCPRAVP",GROUPNM,DESCR)) Q:DESCR=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRAVP",GROUPNM,DESCR,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  D
 .   .   S DESCRIP=^TMP($J,"PRCPRAVP",GROUPNM,DESCR,ITEMDA)
 .   .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 .   .   S NSN=$$NSN^PRCPUX1(ITEMDA) S:NSN="" NSN="<<NO NSN>>"
 .   .   W:'PRCPSUMM !!,$TR(NSN,"-"),?15,$E(DESCRIP,1,38),?54,"[",ITEMDA,"]",?63,$J($$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/"),8),?79,$S($P(ITEMDATA,"^",26)="Y":"*",1:"")
 .   .   W:'PRCPSUMM !,$J("ONHAND",16),$J("DUEIN",8),$J("DUEOUT",8),$J("REORDPT",8),$J("ISSMUL",8),$J("AVGCOST",10),$J("TOTVALUE",22)
 .   .   W:'PRCPSUMM !,$J(+$P(ITEMDATA,"^",7),16),$J($$GETIN^PRCPUDUE(PRCP("I"),ITEMDA),8),$J($$GETOUT^PRCPUDUE(PRCP("I"),ITEMDA),8),$J(+$P(ITEMDATA,"^",10),8)
 .   .   W:'PRCPSUMM $J($P(ITEMDATA,"^",25),8),$J($P(ITEMDATA,"^",22),10,3)
 .   .   I +$J($P(ITEMDATA,"^",7)*$P(ITEMDATA,"^",22),0,2)'=+$P(ITEMDATA,"^",27) W:'PRCPSUMM "  <=/=>"
 .   .   W:'PRCPSUMM ?64,$J($P(ITEMDATA,"^",27),15,2)
 .   .   S ^TMP($J,"PRCPRAVP TOT",GROUPNM)=$G(^TMP($J,"PRCPRAVP TOT",GROUPNM))+$P(ITEMDATA,"^",27)
 .   .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>"
 I $G(PRCPFLAG) D Q Q
 I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 W !!?2,"TOTALS :",?40,"INVENTORY VALUE",!?2,"--------",?40,"---------------"
 S TOTINV=0,GROUPNM="" F  S GROUPNM=$O(^TMP($J,"PRCPRAVP TOT",GROUPNM)) Q:GROUPNM=""!($G(PRCPFLAG))  S TOTAL=^(GROUPNM) D
 .   W !?2,"GROUP  ",$S(GROUPNM=" ":"<<NONE>>",1:GROUPNM),?40,":",$J(TOTAL,14,2)
 .   S TOTINV=TOTINV+TOTAL
 .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 W !?2,"--------",?40,"---------------"
 W !?2,"TOTALS :",?40,$J(TOTINV,15,2)
 D END^PRCPUREP
Q D ^%ZISC K ^TMP($J,"PRCPRAVP"),^TMP($J,"PRCPRAVP TOT"),^TMP($J,"PRCPRURS1")
 Q
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"AVAILABILITY LISTING FOR: ",$E(PRCP("IN"),1,20),?(80-$L(%)),%
 S %="",$P(%,"-",81)=""
 I PRCPSUMM W !?1,"*** ONLY SUMMARY OF ITEMS PRINTED ***",!,% Q
 W !,"DESCR",?15,"DESCRIPTION",?40,"MI",$J("UNIT/IS",14),?77,"KWZ",!,%
 Q
