PRCPRPIR ;WISC/RFJ-print picking ticket from tmp global             ;06 Sep 91
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PICK ;  come here to print picking ticket from tmp global
 ;  tmp($j,"pick",storelocation,nsn,itemda)
 ;  =itemda^nsn^storloc^description^onhand^unitiss^qtyordXX^qtytopick
 ;  ^invcost^sellcost^costcntr/subacct^accountcode
 N %,%H,%I,ACCT,DATA,DATE,ITEMDA,NSN,NUMBER,PAGE,PRCPFLAG,SCREEN,STORLOC,TOTAL,UNITCOST
 D NOW^%DTC S Y=% D DD^%DT S DATE=Y,TOTAL=0,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP,STORLOC="",NUMBER=1 U IO D H
 F  S STORLOC=$O(^TMP($J,"PRCPRPIR",STORLOC)) Q:STORLOC=""  D STORLOC S NSN="" F  S NSN=$O(^TMP($J,"PRCPRPIR",STORLOC,NSN)) Q:NSN=""  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRPIR",STORLOC,NSN,ITEMDA)) Q:'ITEMDA  S DATA=^(ITEMDA) D
 .   I $Y>(IOSL-8),$Q(^TMP($J,"PRCPRPIR",STORLOC,NSN,ITEMDA))'="" D:SCREEN P^PRCPUREP S:$D(PRCPFLAG) (STORLOC,NSN,ITEMDA)="zzzzz" Q:$D(PRCPFLAG)  D H,STORLOC
 .   W !!,$P(DATA,"^",2),?17,$E($P(DATA,"^",4),1,33),?52,"[#",ITEMDA,"]",?63,$J($P(DATA,"^",5),8),?72,"|------|"
 .   W !,"-",NUMBER,"-",?12,"ISS MULT   UNIT per ISS  UNIT COST   TOT COST",?60,"QTY TO PICK",?72,"|",?79,"|"
 .   S NUMBER=NUMBER+1,UNITCOST=0 I $P(DATA,"^",9) S UNITCOST=$J($P(DATA,"^",11)/$P(DATA,"^",9),0,3)
 .   W !?12,$J($P(DATA,"^",7),8),?21,$P(DATA,"^",6),?34,$J(UNITCOST,12,3),$J($P(DATA,"^",11),11,3),?61,$J($P(DATA,"^",9),10)," |______|"
 .   W !?12,"CC/SA: ",$P(DATA,"^",12),"    ACCT: ",$P(DATA,"^",13)
 .   S TOTAL=TOTAL+$P(DATA,"^",11),ACCT(+$P(DATA,"^",13))=$G(ACCT(+$P(DATA,"^",13)))+$P(DATA,"^",10)
 ;
 I '$D(PRCPFLAG),$Y>(IOSL-6) D:SCREEN P^PRCPUREP I '$D(PRCPFLAG) D H
 I $D(PRCPFLAG) D Q Q
 ;
 S (NUMBER,Y)=0 F  S NUMBER=$O(^PRCS(410,TRANDA,"IT",NUMBER)) Q:'NUMBER  S DATA=$G(^(NUMBER,0)) I +$P(DATA,"^",2)'=+$P(DATA,"^",12) D
 .   I Y=0 D H1 S Y=1
 .   W !,$$NSN^PRCPUX1(+$P(DATA,"^",5)),?18,"[",+$P(DATA,"^",5),"]",?27,$J(NUMBER,5),$J(+$P(DATA,"^",2),12),$J(+$P(DATA,"^",12),12),?65,$S($P(DATA,"^",14)["S":"SUBSTITUTED",$P(DATA,"^",14)["C":"CANCELLED",1:"")
 .   I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H,H1
 I '$D(PRCPFLAG) D END^PRCPRPIQ
Q D ^%ZISC K ^TMP($J,"PRCPRPIR")
 Q
 ;
 ;
H S %=DATE_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"PICKING TICKET ",$S($D(PRCPFREP):"**REPRINT**",1:"PRINT"),?(80-$L(%)),%
 W !,?10,"FROM: ",PRCP("IN"),?49,"TO: ",$G(PRCPNAME)
 W !?6,"DELIV PT: ",$E($G(DELPT),1,20),?43,"DATE REQ: ",$G(DATEREQ)
 W !,"TRANSACTION NO: ",PRCPTRNO,?38,"REF VOUCHER #: ",PRCPORD,?59,"TRAN ID: ",PRCPTRID,!?3,"DATE POSTED: ",PRCPPOST,?44,"BY USER: ",$E(PRCPUSER,1,17)
 S %="",$P(%,"-",81)="" W !,"NSN",?19,"DESCRIPTION",?52,"[#MI]",?60,"QTY ON-HAND",?74,"PICKED",!,%
 Q
 ;
 ;
H1 ;header for exceptions
 W !!,"EXCEPTIONS TO ISSUE BOOK REQUEST:",!,"NSN",?18,"[MI#]",?27,$J("LINE#",5),$J("QTY ORDER",12),$J("QTY POSTED",12),?65,"REASON"
 Q
 ;
 ;
STORLOC W !!?4,"STORAGE LOCATION: ",$S(STORLOC="?":"(NONE)",1:STORLOC) Q
