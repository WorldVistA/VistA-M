PRCPRADJ ;WISC/RFJ-adjustment voucher recap (option, whse) ;9.9.97
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,%DT,%H,%I,DEFAULT,PRCPDATE,PRCPSUMM,X,Y
 K X S X(1)="The Adjustment Voucher Recap Report will print all adjustments to the inventory point for a specified month-year."
 I PRCP("DPTYPE")="W" S X(2)="The report will sort Warehouse inventory items by the NSN and the date of the adjustment."
 E  S X(2)="The report will sort Primary and Secondary inventory items by the description and the date of the adjustment."
 D DISPLAY^PRCPUX2(40,79,.X)
 S Y=$E(DT,1,5)_"00" D DD^%DT S DEFAULT=Y
 K X S X(1)="Select the Adjustment Month-Year to display" D DISPLAY^PRCPUX2(2,40,.X)
 S %DT("A")="Print Adjustment Voucher Recap for Month-Year: ",%DT("B")=DEFAULT,%DT="AEP",%DT(0)=-DT D ^%DT I Y<0 Q
 S PRCPDATE=Y
 S PRCPSUMM=$$SUMMARY^PRCPURS0 I PRCPSUMM<0 Q
 W ! S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Adjustment Voucher Recap",ZTRTN="DQ^PRCPRADJ"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 I PRCP("DPTYPE")'="W" D DQ^PRCPRADP Q
 ;  adjustment voucher recap for whse
 N ACCT,DA,DATA,DATE,DATEREPT,FCP,ITEMDA,ITEMDATA,NOW,NSN,PAGE,PRCPFLAG,REASON,SCREEN,TOTAL,TOTALM,TOTALP
 K ^TMP($J,"PRCPRADJ")
 S DATE=$E(PRCPDATE,1,5)_"00" F  S DATE=$O(^PRCP(445.2,"AX",PRCP("I"),DATE)) Q:'DATE!($E(DATE,1,5)'=$E(PRCPDATE,1,5))  D
 .   S DA=0 F  S DA=$O(^PRCP(445.2,"AX",PRCP("I"),DATE,"A",DA)) Q:'DA  D
 .   .   S DATA=$G(^PRCP(445.2,DA,0)),ITEMDA=+$P(DATA,"^",5) I 'ITEMDA Q
 .   .   S NSN=$$NSN^PRCPUX1(ITEMDA),ACCT=$$ACCT1^PRCPUX1($E(NSN,1,4)) S:NSN="" NSN=" "
 .   .   S %=$P(DATA,"^",19),REASON="O",FCP=$P(%,"-",4) I FCP'="" S REASON="I"
 .   .   I %'="",FCP="" S REASON="R"
 .   .   S ^TMP($J,"PRCPRADJ",ACCT,NSN,ITEMDA,DATE,DA)=$P(DATA,"^",15)_"^"_$P(DATA,"^",2)_"^"_$P(DATA,"^",6)_"^"_$P(DATA,"^",7)_"^"_$P(DATA,"^",22)_"^"_$P(DATA,"^",23)_"^"_FCP_"^"_REASON_"^"_$P(DATA,"^",16)
 ;  print report
 S Y=PRCPDATE D DD^%DT S DATEREPT=Y
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 K TOTAL
 S ACCT=0 F  S ACCT=$O(^TMP($J,"PRCPRADJ",ACCT)) Q:'ACCT!($G(PRCPFLAG))  D
 .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>" Q
 .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   W:'PRCPSUMM !!?5,"ACCOUNT NUMBER: ",ACCT
 .   S NSN="" F  S NSN=$O(^TMP($J,"PRCPRADJ",ACCT,NSN)) Q:NSN=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRADJ",ACCT,NSN,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  D
 .   .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 .   .   W:'PRCPSUMM !!,$TR(NSN,"-"),?15,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,23),?39,"[",ITEMDA,"]",?48,$J($$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/"),8)
 .   .   S DATE=0 F  S DATE=$O(^TMP($J,"PRCPRADJ",ACCT,NSN,ITEMDA,DATE)) Q:'DATE!($G(PRCPFLAG))  S DA=0 F  S DA=$O(^TMP($J,"PRCPRADJ",ACCT,NSN,ITEMDA,DATE,DA)) Q:'DA!($G(PRCPFLAG))  S DATA=^(DA) D
 .   .   .   W:'PRCPSUMM !?5,$P(DATA,"^"),?12,$P(DATA,"^",2),?22,$J($E(DATE,6,7),2),$J($P(DATA,"^",3),8),$J($P(DATA,"^",4),10),$J($P(DATA,"^",5),12,2),$J($P(DATA,"^",6),12,2),$J($P(DATA,"^",7),6),$J($P(DATA,"^",8),3)
 .   .   .   W:'PRCPSUMM $J($E($$INITIALS^PRCPUREP($P(DATA,"^",9)),1,5),5)
 .   .   .   I $P(DATA,"^",5)>0 S TOTAL(ACCT,"+")=$G(TOTAL(ACCT,"+"))+$P(DATA,"^",5)
 .   .   .   I $P(DATA,"^",5)<0 S TOTAL(ACCT,"-")=$G(TOTAL(ACCT,"-"))+$P(DATA,"^",5)
 .   .   .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 I $G(PRCPFLAG) D Q Q
 I $Y>(IOSL-10) D:SCREEN P^PRCPUREP G:$G(PRCPFLAG) Q D H
 W !!?5,"ACCT SUMMARY",?20,$J("PLUS ADJUSTMENTS",20),$J("MINUS ADJUSTMENTS",20),$J("DIFFERENCE",20)
 S (ACCT,TOTALM,TOTALP)=0 F  S ACCT=$O(TOTAL(ACCT)) Q:'ACCT!($G(PRCPFLAG))  D
 .   W !?5,"ACCT: ",ACCT,?20,$J($G(TOTAL(ACCT,"+")),20,2),$J($G(TOTAL(ACCT,"-")),20,2),$J($G(TOTAL(ACCT,"+"))+$G(TOTAL(ACCT,"-")),20,2)
 .   S TOTALM=TOTALM+$G(TOTAL(ACCT,"-")),TOTALP=TOTALP+$G(TOTAL(ACCT,"+"))
 .   I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H
 I $G(PRCPFLAG) D Q Q
 W !?5,"TOTAL",?20,$J(TOTALP,20,2),$J(TOTALM,20,2),$J(TOTALP+TOTALM,20,2)
 W:'PRCPSUMM !!?26,"REASON CODE (I:ISSUES, O:OTHER, R:RECEIPTS) == RC"
 D END^PRCPUREP
Q D ^%ZISC K ^TMP($J,"PRCPRADJ")
 Q
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"ADJUSTMENT VOUCHER RECAP FOR: ",$E(PRCP("IN"),1,20),?(80-$L(%)),%
 W !?5,"ADJUSTMENTS FOR MONTH-YEAR: ",DATEREPT
 S %="",$P(%,"-",81)=""
 I PRCPSUMM W !?1,"*** ONLY SUMMARY OF ADJUSTMENTS PRINTED ***",!,% Q
 W !,"NSN",?15,"DESCRIPTION",?40,"MI",$J("ISSUE",14)
 W !?5,"REF#",?12,"TRAN#",?22,"DT",$J("UNITS",8),$J("QUANTITY",10),$J("INV VALUE",12),$J("SELL VALUE",12),$J("FCP",6),$J("RC",3),$J("USER",5)
 W !,%
 Q
