PRCHRP7 ;WISC/KMB/CR-DELINQUENT PC LISTING ;6/05/98  13:17
 ;;5.1;IFCAP;**8**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
STRT ;
 N FLAG S FLAG=2
STRT1 ;
 S:$G(FLAG)="" FLAG=1
START ;
 K ^TMP($J)
 N AMT1,END,PNUM,Y,P,USER,VEN,VEND,PC,PC1,STATUS,VPHONE,ADATE,TDATE,Z1,Z2,Z3,QTY,QTYOUT,CP,X,XXZ,EX,QTYORD,QTYPRCD,QTYOUT,ITEM,PART,PARTDATE,STR,YDATE,TAMT,TIMEDATE
 N DETAIL1,DETAIL2,DETAIL3,I,PCNAME,ZP,CC,LDESC,CCP,ORDTOT,QTYAMT,QSTATUS
 N AMTDSCT,PDATE,PRC,PRCRI,STR1,STR2,STR3,Q,Q1,Q2,Q3
 S:$G(FLAG)="" FLAG=0
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))  Q:$G(X)="^"
 W !,"Please enter a device for printing this report",!
 S %ZIS("B")="",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTSAVE("*")="",ZTRTN="DEL^PRCHRP7" D ^%ZTLOAD,^%ZISC K FLAG QUIT
 D DEL,^%ZISC K FLAG
 Q
 ;
DEL ;
 D NOW^%DTC S TDATE=$P(%,"."),(P,EX)=1
 S ZP="" F  S ZP=$O(^PRC(442,"F",25,ZP)) Q:ZP=""  D
 .S Z1=$G(^PRC(442,ZP,0)),Z2=$G(^PRC(442,ZP,1)),Z3=$G(^PRC(442,ZP,23)) S ADATE=$P($G(^PRC(442,ZP,1)),"^",15)
 .;Do not mix orders from different stations.
 .I $D(PRC("SITE")) Q:$P(Z1,"-")'=PRC("SITE")
 .Q:$P(Z1,"^",10)>TDATE
 .S QSTATUS=+$P($G(^PRC(442,ZP,7)),"^",2)
 .Q:"^22^23^24^25^26^29^32^34^39^44^46^47^"'[("^"_QSTATUS_"^")
 .S Y=$P(ADATE,".") D DD^%DT S PDATE=Y
 .Q:$G(^PRC(442,ZP,2,0))=""
 .S VEN=$P(Z2,"^"),VPHONE=$P($G(^PRC(440,+VEN,0)),"^",10),VEND=$P($G(^PRC(440,+VEN,0)),"^")
 .I VEND="SIMPLIFIED",$P($G(^PRC(442,ZP,24)),"^",2)'="" S VEND=$P($G(^PRC(442,ZP,24)),"^",2)
 .S STATUS=$P($G(^PRC(442,ZP,7)),"^")
 .S STATUS=$P($G(^PRCD(442.3,+STATUS,0)),"^") S:STATUS="" STATUS=0
 .S STATUS=$E(STATUS,1,34)
 .S PC1=$P(Z3,"^",8) Q:+PC1=0  S PC=$P($G(^PRC(440.5,+PC1,0)),"^") Q:PC=""
 .I $G(FLAG)=1 I $P($G(^PRC(440.5,+PC1,0)),"^",9)'=DUZ QUIT
 .I $G(FLAG)=2 I $P($G(^PRC(440.5,+PC1,0)),"^",8)'=DUZ QUIT
 .S PCNAME=$P($G(^PRC(440.5,PC1,0)),"^",11),PCNAME=$E(PCNAME,1,15)
 .S CP=$P(Z1,"^",3),CP=$P(CP," ")
 .S USER=$P($G(^PRC(440.5,PC1,0)),"^",8),USER=$P($G(^VA(200,+USER,0)),"^") Q:USER=""
 .S PNUM=$P(Z1,"^",1)
 .S ITEM=0 F  S ITEM=$O(^PRC(442,ZP,2,ITEM)) Q:ITEM=""  D
 ..Q:'$D(^PRC(442,ZP,2,"C",ITEM))
 ..;
 ..;Get the orders with partials received.
 ..I $D(^PRC(442,ZP,2,ITEM))&($D(^PRC(442,ZP,2,ITEM,3))) D
 ...S DETAIL1=^PRC(442,ZP,2,ITEM,0),QTYORD=$P(DETAIL1,"^",2),QTYAMT=$P(DETAIL1,"^",9)
 ...S (PART,ORDTOT)=0 F  S PART=$O(^PRC(442,ZP,2,ITEM,3,PART)) Q:PART=""  D
 ....S STR=$G(^PRC(442,ZP,2,ITEM,3,PART,0)) Q:STR=""
 ....S YDATE=$P(STR,"^")
 ....S Y=$P(YDATE,".") D DD^%DT S PARTDATE=Y
 ....D DETAIL2
 ..;
 ..;Get orders without any partials received.
 ..I $D(^PRC(442,ZP,2,ITEM))&('$D(^PRC(442,ZP,2,ITEM,3))) D
 ...S DETAIL1=^PRC(442,ZP,2,ITEM,0),QTYORD=$P(DETAIL1,"^",2),QTYAMT=$P(DETAIL1,"^",9)
 ...S YDATE=$P(^PRC(442,ZP,0),"^",10)
 ...S Y=$P(YDATE,".") D DD^%DT S PARTDATE=Y
 ...D DETAIL2
 ;
 D PRINT
 K ^TMP($J)
 Q
 ;
DETAIL2 ; Get common calculations in one place, account for discounts too.
 S DETAIL3=$G(^PRC(442,ZP,2,ITEM,2)),QTYPRCD=$P(DETAIL3,"^",8)
 S AMTDSCT=$P(DETAIL3,"^",6)
 S QTYOUT=QTYORD-QTYPRCD
 S ORDTOT=QTYOUT*QTYAMT I AMTDSCT>0 S ORDTOT=ORDTOT-AMTDSCT
 S ORDTOT=$J(ORDTOT,0,2)
 S LDESC=$G(^PRC(442,ZP,2,ITEM,1,1,0)),LDESC=$E(LDESC,1,40)
 S ^TMP($J,USER,PNUM,STATUS,PC,1)=PCNAME_"^"_PNUM_"^"_STATUS_"^"_PDATE
 S ^TMP($J,USER,PNUM,STATUS,PC,2,ITEM)=PARTDATE_"^"_ITEM_"^"_QTYORD_"^"_QTYOUT_"^"_ORDTOT_"^"_LDESC
 S ^TMP($J,USER,PNUM,STATUS,PC,3)=VEND_"^"_VPHONE
 Q
 ;
PRINT ; Variable AMT1 equals the total amount outstanding by purchase card
 ; and user.
 D NOW^%DTC S Y=% D DD^%DT S TIMEDATE=Y
 U IO
 I '$D(^TMP($J)) S P=1,Q="" D HEADER W !!!!,?10,"*** NO RECORDS TO PRINT ***" Q
 S Q=0 F  S Q=$O(^TMP($J,Q)) Q:Q=""  Q:EX="^"  D
 .D HEADER
 .S AMT1=0
 .S Q1="" F  S Q1=$O(^TMP($J,Q,Q1)) Q:Q1=""  Q:EX="^"  D
 ..S Q2="" F  S Q2=$O(^TMP($J,Q,Q1,Q2)) Q:Q2=""  Q:EX="^"  D
 ...S Q3="" F  S Q3=$O(^TMP($J,Q,Q1,Q2,Q3)) Q:Q3=""  Q:EX="^"  D
 ....S STR1=^TMP($J,Q,Q1,Q2,Q3,1),STR2=^TMP($J,Q,Q1,Q2,Q3,3)
 ....W !,$P(STR1,"^"),?20,$P(STR1,"^",2),?32,$P(STR1,"^",3),?68,$P(STR1,"^",4),!,$P(STR2,"^"),?45,$P(STR2,"^",2)
 ....S ITEM="" F  S ITEM=$O(^TMP($J,Q,Q1,Q2,Q3,2,ITEM)) Q:ITEM=""  Q:EX="^"  D
 .....S STR3=^TMP($J,Q,Q1,Q2,Q3,2,ITEM) W !,$P(STR3,"^"),?15,$P(STR3,"^",2),?40,$P(STR3,"^",3),?54,$P(STR3,"^",4),!,$P(STR3,"^",5),?30,$P(STR3,"^",6)
 .....S AMT1=$P(STR3,"^",5)+$G(AMT1)
 .....I (IOSL-$Y)<7 D HOLD Q:EX[U
 ....W !,"PURCHASE CARD SUBTOTAL: ",$J(AMT1,0,2),!
 .I $E(IOST,1,2)="C-",EX'["^" W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ["^" EX="^" S:'$T EX=U
 QUIT
 ;
HOLD G HEADER:$E(IOST,1,2)'="C-"!(IO'=IO(0)) W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ["^" EX="^" S:'$T EX=U I EX'="^",$G(Q3)'="" D HEADER
 QUIT
 ;
HEADER ;
 W @IOF
 W "DELINQUENT PURCHASE CARD LISTING",?45,TIMEDATE,?70,"PAGE ",P
 W !!,"PURCHASE CARD NAME",?20,"PO NUMBER",?32,"STATUS",?67,"PO DATE",!,"VENDOR",?45,"VENDOR PHONE"
 W !,"DELIVERY DATE",?15,"LINE ITEM OUTSTANDING",?40,"QTY ORDERED",?54,"QTY OUTSTANDING",!,"AMOUNT OUTSTANDING",?30,"ITEM DESCRIPTION"
 W ! F I=1:1:8 W "----------"
 W !,?20,"BUYER: ",Q,!
 S P=P+1 QUIT
