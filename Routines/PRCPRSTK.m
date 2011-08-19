PRCPRSTK ;WISC/RFJ/VAC-where is an item stocked                         ; 2/19/07 12:51pm
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;*98  Modified to accommodate On Demand Items.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,DATA,DATE,DESC,I,INVPT,ITEMDA,NSN,PAGE,PRCPFLAG,SCREEN,TYPE,X,Y
 N ODITEM,ODINVPT
ITEM S ITEMDA=$$ITEM^PRCPUITM(PRCP("I"),0,"","") Q:'ITEMDA
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK W !! G ITEM
 .   S ZTDESC="Display Where an Item is Stocked",ZTRTN="DQ^PRCPRSTK"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("ITEMDA")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;queue comes here
 K ^TMP($J,"PRCPRSTK"),PRCPFLAG S INVPT=0 F  S INVPT=$O(^PRCP(445,"AE",ITEMDA,INVPT)) Q:'INVPT  S %=$G(^PRCP(445,INVPT,0)) I %'="" S I=$P(%,"^"),TYPE=$P(%,"^",3) S:I="" I="??" S %=$G(^PRCP(445,INVPT,1,ITEMDA,0)) I %'="" D
 .   S TYPE=$S(TYPE="W":"WAREHOUSE",TYPE="P":"PRIMARY",TYPE="S":"SECONDARY",1:" "),^TMP($J,"PRCPRSTK",TYPE,I)=+$P(%,"^",7)_"^"_$J($$UNITVAL^PRCPUX1($P(%,"^",14),$P(%,"^",5)," / "),12)_"^"_INVPT
 D NOW^%DTC S Y=% D DD^%DT S DATE=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP,NSN=$$NSN^PRCPUX1(ITEMDA),DESC=$$DESCR^PRCPUX1(PRCP("I"),ITEMDA) U IO D H
 S TYPE="" F  S TYPE=$O(^TMP($J,"PRCPRSTK",TYPE)) Q:TYPE=""  S I="" F  S I=$O(^TMP($J,"PRCPRSTK",TYPE,I)) Q:I=""  S DATA=^(I) D
 .   S ODINVPT=$P(DATA,"^",3),ODITEM=$$ODITEM^PRCPUX2(ODINVPT,ITEMDA)
 .   I ODITEM="W" S ODITEM=""
 .   I ODITEM="Y" S ODITEM="D"
 .   W !,$E(TYPE,1,4),?12,I,?48,ODITEM,?50,$J($P(DATA,"^"),10),?66,$P(DATA,"^",2)
 .   I $Y>(IOSL-4) D:SCREEN P^PRCPUREP S:$D(PRCPFLAG) (I,TYPE)="zzzzzz" Q:$D(PRCPFLAG)  D H
 I '$D(PRCPFLAG) D END^PRCPUREP
 D ^%ZISC K ^TMP($J,"PRCPRSTK")
 I '$D(ZTQUEUED) W !! G ITEM
 Q
 ;
H S %=DATE_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"DISPLAY WHERE AN ITEM IS STOCKED",?(80-$L(%)),%,!?4,"PRINTED BY INVENTORY POINT: ",PRCP("IN")
 W !?4,"NSN: ",NSN,?30,$E(DESC,1,30),?62,"[#",ITEMDA,"]"
 W !,?48,"O"
 W ?55,"QTY",?72,"UNIT PER"
 W !,"TYPE",?12,"SITE-DISTRIBUTION POINT"
 W ?48,"D"
 W ?53,"ON-HAND",?73,"ISSUE"
 S %="",$P(%,"-",81)="" W !,% Q
