PRCPEIPS ;WISC/RFJ-procurement sources edit                         ;01 Dec 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SOURCES(INVPT,ITEMDA) ;  check/update procurement sources invpt itemda
 I '$D(^PRCP(445,+INVPT,1,+ITEMDA,0)) Q
 ;
 N %,DATA,DIC,MANSRCE,TYPE,UP,UR,VENDA,VENDATA,VENDOR,Y
 S TYPE=$P($G(^PRCP(445,+INVPT,0)),"^",3)
 S IOP="HOME" D ^%ZIS K IOP W @IOF
 ;
 ;  add procurement sources which should be there
 W !!?5,"...adding ",$S(TYPE="S":"inventory points",1:"vendors from item master file")," as procurement sources"
 ;  for warehouse and primaries
 I TYPE'="S" D
 .   S DIC="^PRC(440,"
 .   S VENDA=0 F  S VENDA=$O(^PRC(441,ITEMDA,2,VENDA)) Q:'VENDA  I '$$GETVEN^PRCPUVEN(INVPT,ITEMDA,VENDA_";PRC(440,",1) S Y=VENDA D SCREEN^PRCPUMAN(INVPT,ITEMDA,0) I $T D
 .   .   W !?15,$P($G(^PRC(440,VENDA,0)),"^"),"  added" D ADDVEN^PRCPUVEN(INVPT,ITEMDA,VENDA_";PRC(440,","","","")
 .   .   I $Y>(IOSL-2) D R^PRCPUREP W @IOF
 ;  secondaries
 I TYPE="S" D
 .   S DIC="^PRCP(445,"
 .   S VENDA=0 F  S VENDA=$O(^PRCP(445,"AB",INVPT,VENDA)) Q:'VENDA  I '$$GETVEN^PRCPUVEN(INVPT,ITEMDA,VENDA_";PRCP(445,",1),$P($G(^PRCP(445,VENDA,0)),"^",3)="P",$D(^(2,INVPT,0)),$D(^PRCP(445,VENDA,1,ITEMDA,0)) D
 .   .   W !?15,$P(^PRCP(445,VENDA,0),"^"),"  added" D ADDVEN^PRCPUVEN(INVPT,ITEMDA,VENDA_";PRCP(445,","","","")
 .   .   I $Y>(IOSL-2) D R^PRCPUREP W @IOF
 I $Y>(IOSL-2) D R^PRCPUREP W @IOF
 ;
 ;  check procurement sources
 W !!?5,"...checking currently stored procurement sources"
 S VENDA=0 F  S VENDA=$O(^PRCP(445,INVPT,1,ITEMDA,5,VENDA)) Q:'VENDA  S DATA=^(VENDA,0) I DATA'="" D
 .   S VENDOR=$$VENNAME^PRCPUX1($P(DATA,"^")),DIC=$S($P(DATA,"^")["PRCP(445":"^PRCP(445,",1:"^PRC(440,")
 .   I $Y>(IOSL-6) D R^PRCPUREP W @IOF
 .   W !?15,VENDOR S Y=+$P(DATA,"^") D SCREEN^PRCPUMAN(INVPT,ITEMDA,0)
 .   I '$T  W "  deleted" D DELVEN^PRCPUVEN(INVPT,ITEMDA,VENDA) Q
 .   ;
 .   ;  update data
 .   ;  secondaries
 .   I TYPE="S" D  Q
 .   .   S VENDATA=$G(^PRCP(445,+$P(DATA,"^"),1,ITEMDA,0)),UP=$$UNITVAL^PRCPUX1($P(VENDATA,"^",14),$P(VENDATA,"^",5)," per ")
 .   .   S UR=$$UNITVAL^PRCPUX1($P(DATA,"^",3),$P(DATA,"^",2)," per ")
 .   .   W !?25,"UNIT per PURCHASE: ",UP,!?25,"UNIT per RECEIPT: ",UR
 .   .   I UP'=UR,UP'["?" S $P(DATA,"^",3)=$P(VENDATA,"^",14),$P(DATA,"^",2)=$P(VENDATA,"^",5) W !?25,"*** UNIT per RECEIPT changed to UNIT per PURCHASE ***"
 .   .   I '$P(DATA,"^",4) S %=$P(^PRCP(445,INVPT,1,ITEMDA,0),"^",14) S:'% %=1 S $P(DATA,"^",4)=($P(DATA,"^",3)/%)\1 S:'$P(DATA,"^",4) $P(DATA,"^",4)=1
 .   .   W !?25,"CONVERSION FACTOR: ",$P(DATA,"^",4)
 .   .   S ^PRCP(445,INVPT,1,ITEMDA,5,VENDA,0)=DATA
 .   ;
 .   ;  for primary and warehouse
 .   S VENDATA=$G(^PRC(441,ITEMDA,2,+$P(DATA,"^"),0)),UP=$$UNITVAL^PRCPUX1($P(VENDATA,"^",8),$P(VENDATA,"^",7)," per ")
 .   S UR=$$UNITVAL^PRCPUX1($P(DATA,"^",3),$P(DATA,"^",2)," per ")
 .   W ?54,"LAST COST: ",$J($P(VENDATA,"^",2),0,3),!?25,"UNIT per PURCHASE: ",UP,!?25,"UNIT per RECEIPT : ",UR
 .   I UP'=UR,UP'["?" S $P(DATA,"^",3)=$P(VENDATA,"^",8),$P(DATA,"^",2)=$P(VENDATA,"^",7) W !?25,"*** UNIT per RECEIPT changed to UNIT per PURCHASE ***"
 .   I '$P(DATA,"^",4) S %=$P($G(^PRCP(445,INVPT,1,ITEMDA,0)),"^",14) S:'% %=1 S $P(DATA,"^",4)=($P(DATA,"^",3)/%)\1 S:'$P(DATA,"^",4) $P(DATA,"^",4)=1
 .   W !?25,"CONVERSION FACTOR: ",$P(DATA,"^",4)
 .   S ^PRCP(445,INVPT,1,ITEMDA,5,VENDA,0)=DATA
 I $Y>(IOSL-3) D R^PRCPUREP W @IOF
 ;
 ;  check mandatory source
 W !!?5,"...checking mandatory source in the inventory point"
 S MANSRCE=+$$MANDSRCE^PRCPU441(ITEMDA)
 I TYPE="W",MANSRCE'=$O(^PRC(440,"AC","S",0)) D
 .   W !,"ITEM IS NOT SET UP AS POSTED STOCK.  THE MANDATORY SOURCE IN THE ITEM MASTER",!,"FILE DOES NOT EQUAL THE WAREHOUSE VENDOR."
 .   D SETMAN^PRCPEIPU(INVPT,ITEMDA,"")
 I TYPE="P",MANSRCE D SETMAN^PRCPEIPU(INVPT,ITEMDA,MANSRCE_";PRC(440,")
 Q
