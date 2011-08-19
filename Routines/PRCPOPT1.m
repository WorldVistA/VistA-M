PRCPOPT1 ;WISC/RFJ-picking ticket for distribtuion order ; 4/27/99 9:19am
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
DQ ;  queue comes here to print picking ticket
 K ^TMP($J,"PRCPOPT"),^TMP($J,"PRCPCRPL-CC"),^TMP($J,"PRCPCRPL-IK")
 N %,%I,DATA,INVDATA,ITEMDA,LINE,NOW,NSN,PAGE,PRCPFLAG,REPRINT,SCREEN,STORLOC,TOTAL,UNITCOST,X,Y
 ;
 S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPOPT PICK LIST",ITEMDA)) Q:'ITEMDA  S DATA=$G(^(ITEMDA)) D
 .   S NSN=$$NSN^PRCPUX1(ITEMDA) S:NSN="" NSN=" " S INVDATA=$G(^PRCP(445,PRCPPRIM,1,ITEMDA,0)),STORLOC=$$STORELOC^PRCPESTO($P(INVDATA,"^",6))
 .   S:+$P(INVDATA,"^",25)=0 $P(INVDATA,"^",25)=1 S UNITCOST=+$P(DATA,"^",3) S:UNITCOST=0 UNITCOST=+$P(INVDATA,"^",15) S:UNITCOST=0 UNITCOST=+$P(INVDATA,"^",22)
 .   S %=ITEMDA_"^"_NSN_"^"_STORLOC_"^"_$$DESCR^PRCPUX1(PRCPPRIM,ITEMDA)_"^"_+$P(INVDATA,"^",7)_"^"_$J($$UNITVAL^PRCPUX1($P(INVDATA,"^",14),$P(INVDATA,"^",5)," per "),13)
 .   S ^TMP($J,"PRCPOPT",STORLOC,NSN,ITEMDA)=%_"^"_$P(INVDATA,"^",25)_"^"_$P(DATA,"^")_"^"_$P(DATA,"^",2)_"^"_UNITCOST_"^"_$J($P(DATA,"^")*UNITCOST,0,3)
 .   ;
 .   ;  set for cc or ik preparation list
 .   I $D(^PRCP(445.7,ITEMDA)) S ^TMP($J,"PRCPCRPL-CC",ITEMDA)=""
 .   I $D(^PRCP(445.8,ITEMDA)) S ^TMP($J,"PRCPCRPL-IK",ITEMDA)=""
 ;
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP
 S:$P(PRCPORD(0),"^",7)="Y" REPRINT=1
 I $E(IOST)="P",$D(^PRCP(445.3,ORDERDA,0)) S $P(^(0),"^",7)="Y"
 S Y=$P(PRCPORD(0),"^",4) D DD^%DT S $P(PRCPORD(0),"^",4)=Y
 S $P(PRCPORD(0),"^",8)=$P($$TYPE^PRCPOPU(ORDERDA),"ORDER")
 S $P(PRCPORD(0),"^",6)=$$STATUS^PRCPOPU(ORDERDA)
 ;  check for order already posted
 I '$D(^PRCP(445.3,ORDERDA,0)) S $P(PRCPORD(0),"^",6)="POSTED"
 ;
 S TOTAL=0,STORLOC="" U IO D H
 F  S STORLOC=$O(^TMP($J,"PRCPOPT",STORLOC)) Q:STORLOC=""!($G(PRCPFLAG))  D STORLOC D
 .   S NSN="" F  S NSN=$O(^TMP($J,"PRCPOPT",STORLOC,NSN)) Q:NSN=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPOPT",STORLOC,NSN,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  S DATA=^(ITEMDA) D
 .   .   I $Y>(IOSL-7),$Q(^TMP($J,"PRCPOPT",STORLOC,NSN,ITEMDA))'="" D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H,STORLOC
 .   .   W !!,$P(DATA,"^",2),?17,$E($P(DATA,"^",4),1,33),?52,"[#",ITEMDA,"]"
 .   .   W:$E($P(PRCPORD(0),"^",6))'="P" ?63,$J($P(DATA,"^",5),8)
 .   .   W ?72,"|------|"
 .   .   W !?4,"ISS MULT  QTY ORD  UNIT per ISS  UNIT COST   TOT COST",?60,"QTY TO PICK",?72,"|",?79,"|"
 .   .   W !?4,$J($P(DATA,"^",7),8) W:$P(DATA,"^",8)#$P(DATA,"^",7)'=0 "*" W ?14,$J($P(DATA,"^",8),7),$P(DATA,"^",6),?34,$J($P(DATA,"^",10),12,3),$J($P(DATA,"^",11),11,3),?61,$J($P(DATA,"^",8),10)," |______|"
 .   .   S TOTAL=TOTAL+$P(DATA,"^",11)
 I '$G(PRCPFLAG) D
 .   K DATA
 .   S LINE=1
 .   S X=$G(^PRCP(445.3,ORDERDA,8)) I X'="" S DATA(1)="REMARKS: "_$E(X,1,70),LINE=2 I $E(X,71)'="" S DATA(2)="         "_$E(X,71,140),LINE=3 I $E(X,141)'="" S DATA(3)="         "_$E(X,141,240),LINE=3
 .   I LINE'=1 S DATA(LINE)=" ",LINE=LINE+1
 .   F %=1:1 S DATA=$P($T(DATA+%),";",3,99) Q:DATA=""  S DATA(LINE)=DATA,LINE=LINE+1
 .   I $Y>(IOSL-%-4) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H
 .   W !!,"TOTAL DOLLAR AMOUNT OF ORDER: ",$J(TOTAL,0,3)
 .   W ! S %=0 F  S %=$O(DATA(%)) Q:'%  W !,DATA(%)
 ;
 I '$G(PRCPFLAG) I $D(^TMP($J,"PRCPCRPL-CC"))!($D(^TMP($J,"PRCPCRPL-IK"))) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D DQ^PRCPCRPL
 ;
 I '$G(PRCPFLAG) D END^PRCPUREP
 Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"PICKING TICKET ",$S($D(REPRINT):"RE-",1:""),"PRINT",?(80-$L(%)),%
 W !,?4,"FROM: ",$P(PRCPORD(0),"^",2),?39,"TO: ",$P(PRCPORD(0),"^",3)
 W !,"ORDER NO: ",$P(PRCPORD(0),"^"),?19,"DATE: ",$P($P(PRCPORD(0),"^",4),"@"),?37,"TYPE: ",$P(PRCPORD(0),"^",8),?54,"STATUS: ",$E($P(PRCPORD(0),"^",6),1,17)
 S %="",$P(%,"-",81)="" W !,"NSN",?17,"DESCRIPTION",?52,"[#MI]"
 I $E($P(PRCPORD(0),"^",6))'="P" W ?61,"QTY ON-HND"
 W ?74,"PICKED",!,% Q
 ;
 ;
STORLOC W !!?4,"STORAGE LOCATION: ",$S(STORLOC="?":"(NONE)",1:STORLOC) Q
 Q
 ;
 ;
DATA ;;print signature at bottom of report
 ;;SIGNATURE:_________________________                    PULLED BY:_______________
 ;;    TITLE:_________________________                  VERIFIED BY:_______________
 ;;     DATE:_________________________           DATE TO DELIVER ON:_______________
