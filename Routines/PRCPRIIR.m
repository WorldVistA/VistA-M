PRCPRIIR ;WISC/RFJ-inactive item report (option, whse)              ;10 Aug 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$D(PRCP("I"))
 I PRCP("DPTYPE")'="W" D PRIMARY^PRCPRIIP Q
 ;
 N DATEINAC,PRCPEND,PRCPSTRT,X,Y
 K X S X(1)="The Inactive Items Report will print items which have no receipts or issues after a specified cutoff date.  The report is sorted by NSN."
 D DISPLAY^PRCPUX2(40,79,.X)
 K X S X(1)="Select the range of NSNs to display" D DISPLAY^PRCPUX2(2,40,.X)
 D NSNSEL^PRCPURS0 I '$D(PRCPSTRT) Q
 K X S X(1)="Enter the Inactivity cutoff date." D DISPLAY^PRCPUX2(2,40,.X)
 S X1=DT,X2=-90 D C^%DTC S Y=$E(X,1,5)_"00" D DD^%DT
 S %DT(0)=-($E(DT,1,5)_"00"),%DT="AEP",%DT("B")=Y,%DT("A")="Enter Inactivity Cutoff MONTH and YEAR: " D ^%DT K %DT I Y<1 Q
 S DATEINAC=$E(Y,1,5)_"00"
 W ! S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Inactive Item Report",ZTRTN="DQ^PRCPRIIR"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("DATEINAC")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 N %,%I,D,DATEFROM,DUEOUT,ITEMDA,NOW,NSN,PAGE,PRCPFLAG,QTY,RECPT,SCREEN,TOTAL,TOTDAYS,USAGE,X,Y
 K ^TMP($J,"PRCPRIIR")
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S D=$G(^(ITEMDA,0)) I D'="" D
 .   ;  if reusable quit
 .   I $$REUSABLE^PRCPU441(ITEMDA) Q
 .   S QTY=$P(D,"^",7)+$P(D,"^",19) I 'QTY Q
 .   S NSN=$$NSN^PRCPUX1(ITEMDA) S:NSN="" NSN=" "
 .   I $E(NSN,1,$L(PRCPSTRT))'=PRCPSTRT,$E(NSN,1,$L(PRCPEND))'=PRCPEND I NSN']PRCPSTRT!(PRCPEND']NSN) Q
 .   I $O(^PRCP(445,PRCP("I"),1,ITEMDA,2,$E(DATEINAC,1,5)-.01))!($O(^PRCP(445,PRCP("I"),1,ITEMDA,3,DATEINAC))) Q
 .   ;  find last usage date
 .   S (USAGE,X)=0 F  S X=$O(^PRCP(445,PRCP("I"),1,ITEMDA,2,X)) Q:'X  S USAGE=X
 .   S USAGE=$S('USAGE:"",1:$E(USAGE,4,5)_"/"_$E(USAGE,2,3))
 .   ;  find last receipt date
 .   S (RECPT,X)=0 F  S X=$O(^PRCP(445,PRCP("I"),1,ITEMDA,3,X)) Q:'X  S RECPT=X
 .   S RECPT=$S('RECPT:"",1:$E(RECPT,4,5)_"/"_$E(RECPT,6,7)_"/"_$E(RECPT,2,3))
 .   S DUEOUT=$$GETOUT^PRCPUDUE(PRCP("I"),ITEMDA) I 'DUEOUT S DUEOUT=""
 .   S ^TMP($J,"PRCPRIIR",NSN,ITEMDA)=USAGE_"^"_RECPT_"^"_DUEOUT_"^"_QTY_"^"_$P(D,"^",27)_"^"_$S($P(D,"^",26)="Y":"*",1:"")
 ;  print report
 S X1=DT,X2=DATEINAC D ^%DTC S TOTDAYS=X
 S Y=DATEINAC D DD^%DT S DATEFROM=Y
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S TOTAL=0,NSN="" F  S NSN=$O(^TMP($J,"PRCPRIIR",NSN)) Q:NSN=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRIIR",NSN,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  S D=^(ITEMDA) D
 .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>" Q
 .   W !,$TR(NSN,"-"),?15,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,20),?36,ITEMDA
 .   W ?42,$J($P(D,"^"),5),$J($P(D,"^",2),10),$J($P(D,"^",3),6),$J($P(D,"^",4),7),$J($P(D,"^",5),8,2),$J($P(D,"^",6),2)
 .   S TOTAL=TOTAL+$P(D,"^",5)
 .   I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 I '$G(PRCPFLAG),$Y>(IOSL-3) D:SCREEN P^PRCPUREP I '$G(PRCPFLAG) D H
 I $G(PRCPFLAG) D Q Q
 W !!?30,"TOTAL INACTIVE ITEM VALUE IN STOCK: ",$J(TOTAL,12,2)
 D END^PRCPUREP
Q D ^%ZISC K ^TMP($J,"PRCPRIIR")
 Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"INACTIVE ITEM REPORT FOR: ",$E(PRCP("IN"),1,20),?(80-$L(%)),%
 S %="",$P(%,"-",81)=""
 W !?5,"INACTIVE ITEMS RANGE FROM ",DATEFROM,"  TO  ",$P(NOW,"@"),"  (",TOTDAYS," DAYS)",?79,"K"
 W !?42,$J("LAST",5),$J("LAST",10),$J("DUE",6),$J("QTY",7),$J("TOTAL",8),$J("W",2),!,"NSN",?15,"DESCRIPTION",?36,"MI",?42,$J("USAGE",5),$J("RECEIPT",10),$J("OUT",6),$J("ONHND",7),$J("VALUE",8),$J("Z",2),!,%
 Q
