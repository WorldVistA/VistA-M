PRCHRP10 ;WISC/KMB/CR HISTORY OF PURCHASE CARD TRANSACTIONS ;6/26/98  11:21
 ;;5.1;IFCAP;**8**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
STR1 S FLAG=0
STR2 S:$G(FLAG)="" FLAG=1
START ;
 N AMT,AMT1,ARR,BOC,CC,CP,CSTATUS,DIR,EDATE,EX,F1,F2,FDATE,GTOT,I,LINE1
 N LINE2,LINE3,LINE4,LSTATUS,P,PAT,PC,POSTATUS,QSTATUS,STATUS,TDATE,TOT
 N USER,VEND,X,XXZ,Y,ZP,ZTR,HDATE,PRC
 K ^TMP($J),^TMP("CANC",$J)
 W @IOF
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))  Q:$G(X)="^"
 S DIR("A")="Enter beginning date",DIR("?")="Enter the first date for which you wish to see records"
 S DIR(0)="D^^" D ^DIR K DIR Q:+Y<1  S FDATE=+Y W "   ",Y(0)
 S DIR("A")="Enter ending date",DIR("?")="Enter the last date for which you want to see records"
 S DIR(0)="D^^" D ^DIR K DIR Q:+Y<1  S EDATE=+Y W "   ",Y(0)
 I EDATE<FDATE W !,"Date range is incorrect." G START
 S DIR(0)="S^P:Paid;U:Unpaid;B:Both",DIR("A")="STATUS" D ^DIR K DIR Q:Y["^"  S STATUS=Y
 S:STATUS["P" STATUS="P" S:STATUS["U" STATUS="U" S:STATUS["B" STATUS=""
 S %ZIS("B")="",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="DETAIL^PRCHRP10",ZTSAVE("*")="" D ^%ZTLOAD,^%ZISC K FLAG Q
 D DETAIL,^%ZISC K FLAG Q
DETAIL ;
 D NOW^%DTC S Y=$P(%,".") D DD^%DT S HDATE=Y
 U IO S U="^",P=1,(EX,POSTATUS,ZP)=""
 F I=24,29,32,34,37,38,40,41,50,51 S ARR(I)=""
 F  S ZP=$O(^PRC(442,"F",25,ZP)) Q:ZP=""  D
 .S PC=$P($G(^PRC(442,ZP,23)),"^",8) Q:PC=""
 .I $G(FLAG)=1 I ($P($G(^PRC(440.5,+PC,0)),"^",10)'=DUZ)&($P($G(^PRC(440.5,+PC,0)),"^",9)'=DUZ) Q
 .I $G(FLAG)=0 I $P($G(^PRC(440.5,+PC,0)),"^",8)'=DUZ QUIT
 .S CSTATUS=$P($G(^PRC(442,ZP,7)),"^"),CSTATUS=$P($G(^PRCD(442.3,+CSTATUS,0)),"^",2)
 .I STATUS="U" Q:$D(ARR(CSTATUS))
 .I STATUS="P" Q:'$D(ARR(CSTATUS))
 .S F1=$G(^PRC(442,ZP,0)),F2=$G(^PRC(442,ZP,1)),LINE3=$G(^PRC(442,ZP,2,1,1,1,0)),POSTATUS=$P($G(^PRC(442,ZP,7)),"^"),POSTATUS=$P($G(^PRCD(442.3,+POSTATUS,0)),"^",1)
 .;Do not mix data from different stations 
 .I $D(PRC("SITE")) Q:$P(F1,"-",1)'=PRC("SITE")
 .S Y=$P(F2,"^",15),CP=$P(F1,"^",3),CP=$P(CP," ")
 .Q:CP=""  Q:Y<FDATE  Q:Y>EDATE
 .D DD^%DT S TDATE=Y
 .S USER=$P($G(^PRC(440.5,PC,0)),"^",8),USER=$E($P($G(^VA(200,+USER,0)),"^"),1,20),VEND=$P(F2,"^"),VEND=$P($G(^PRC(440,+VEND,0)),"^"),AMT=$P(F1,"^",15)
 .I VEND="SIMPLIFIED",$P($G(^PRC(442,ZP,24)),"^",2)'="" S VEND=$P($G(^PRC(442,ZP,24)),"^",2)
 .S VEND=$E(VEND,1,20)
 .S PAT=$P(F1,"^")
 .S LINE1=CP_"^"_PAT_"^"_TDATE_"^"_USER_"^"_VEND
 .S CC=$P(F1,"^",5),BOC=$P($G(^PRC(442,ZP,2,1,0)),"^",4),BOC=$E(BOC,1,40)
 .S LSTATUS=POSTATUS_"^"_CSTATUS
 .S LINE2=AMT_"^"_CC_"^"_BOC
 .S CP=+CP,^TMP($J,CP,ZP,1)=LINE1,^TMP($J,CP,ZP,2)=LINE2,^TMP($J,CP,ZP,3)=LINE3,^TMP($J,CP,ZP,4)=LSTATUS
 ;
WRITE ;
 I '$D(^TMP($J)) S P=1 S:STATUS["P" STATUS="P" S:STATUS["U" STATUS="U" S:STATUS["B" STATUS="" D HEADER W !!!!,?10,"*** NO RECORDS TO PRINT ***" Q
 S (GTOT,TOT,CP,ZP)="" F  S CP=$O(^TMP($J,CP)) Q:CP=""  Q:EX="^"  D
 .S TOT=0 F  S ZP=$O(^TMP($J,CP,ZP)) Q:ZP=""  Q:EX="^"  D
 ..D:P=1 HEADER
 ..S LINE1=^TMP($J,CP,ZP,1) W !,$P(LINE1,"^"),?6,$P(LINE1,"^",2),?19,$P(LINE1,"^",3),?36,$P(LINE1,"^",4),?58,$P(LINE1,"^",5)
 ..S AMT1=$P(^TMP($J,CP,ZP,2),"^",1) W !,?3,$J(AMT1,0,2),?18,$P(^TMP($J,CP,ZP,2),"^",2),?36,$P(^TMP($J,CP,ZP,2),"^",3)
 ..W !,^TMP($J,CP,ZP,3),!
 ..S LINE4=^TMP($J,CP,ZP,4) I +$P(LINE4,"^",2)'=45 W $P(LINE4,"^",1),!
 ..I +$P(LINE4,"^",2)=45 S AMT1=0,^TMP("CANC",$J)=1 W $P(LINE4,"^",1),!
 ..I (IOSL-$Y)<6 D HOLD Q:EX="^"
 ..S TOT=TOT+AMT1,GTOT=GTOT+AMT1
 .I EX'="^" W !,?30,"CONTROL POINT ",$P(LINE1,"^")," SUBTOTAL: ",$J(TOT,0,2),! S TOT=0
 I GTOT'=0,EX'="^" W ?30,"TOTAL: ",$J(GTOT,0,2) W:$D(^TMP("CANC",$J)) !?30,"(EXCLUDES Cancelled Orders)"
 K ^TMP($J),^TMP("CANC",$J)
 QUIT
 ;
HOLD G HEADER:$E(IOST)="P"!(IO'=IO(0)) W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ="^" EX="^" S:'$T EX="^" D:EX'="^" HEADER Q
 ;
HEADER ;
 W @IOF
 W !,"HISTORY OF PURCHASE CARD TRANSACTIONS REPORT - " W $S(STATUS="U":"UNPAID",STATUS="P":"PAID",1:"ALL")
 W ?56,HDATE,?70,"PAGE ",P
 W !,"FCP",?6,"PO NUMBER",?19,"PURCHASE DATE",?36,"BUYER",?58,"VENDOR"
 W !,?3,"AMOUNT",?18,"COST CENTER",?36,"BUDGET OBJECT CODE",!,"FIRST LINE ITEM DESCRIPTION",!,"STATUS"
 W ! F I=1:1:10 W "--------"
 S P=P+1 Q
