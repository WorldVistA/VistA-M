PRCHRP2 ;WISC/KMB/CR UNPAID PC TRANSACTION BY FCP ;6/05/98  11:15
 ;;5.1;IFCAP;**62**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;
 N BDATE,EDATE,PODATE,PC1,ARR,XXZ,EX,CP,VEND,USER,STATUS,TDATE,EDATE,FDATE,DIR,ZP,P,X,Y,F1,F2,LINE3,TOT,PCNUM,ZTR,ZTR1
 N AMT,AMT1,LINE1,LINE2,LSTATUS,PRCST,PRCSJ,ZIP,BOC,CC,CCREC,PP,QSTATUS
 K ^TMP($J)
 ;
 W @IOF,!!,"Detailed Report of Unpaid PC Transactions by FCP"
 ;
DATE S DIR(0)="D",DIR("A")="P.O. DATE (BEGIN RANGE) ",DIR("B")="T-30"
 D ^DIR Q:$D(DIRUT)  S BDATE=Y
 ;
 S DIR("A")="P.O. DATE (END RANGE) ",DIR("B")="T"
 D ^DIR Q:$D(DIRUT)  S EDATE=Y
 ;
 I BDATE'<EDATE,BDATE'=EDATE D  G DATE
 . W !,"Please enter a valid date range",!
 ;
 W !,"Please select a device for printing this report.",!
 ;
 S %ZIS("B")="",%ZIS="MQ" D ^%ZIS Q:POP
 ;
 ;Queue the report
 I $D(IO("Q")) D  Q
 . S ZTRTN="DETAIL^PRCHRP2"
 . S ZTSAVE("BDATE")=""
 . S ZTSAVE("EDATE")=""
 . D ^%ZTLOAD,^%ZISC Q
 ;
 D DETAIL,^%ZISC Q
 ;
DETAIL ;
 F ZTR=1,24,29,32,34,37,38,40,41,45,50,51 S ARR(ZTR)=""
 U IO S U="^",(P,EX)=1,ZP="" F  S ZP=$O(^PRC(442,"F",25,ZP)) Q:ZP=""  D
 .S ZTR1=+$P($G(^PRC(442,ZP,7)),"^",2) Q:ZTR1=""
 .Q:$D(ARR(ZTR1))
 .S F1=$G(^PRC(442,ZP,0)),F2=$G(^PRC(442,ZP,1)),LINE3=$G(^PRC(442,ZP,2,1,1,1,0))
 .S (PODATE,Y)=$P(F2,"^",15)
 .I PODATE<BDATE!(PODATE>EDATE) Q
 .S STATUS=+$P($G(^PRC(442,ZP,7)),"^",1),LSTATUS=$P($G(^PRCD(442.3,STATUS,0)),"^",1)
 .S PCNUM=$P(F1,"^"),CP=$P(F1,"^",3),CP=$P(CP," ")
 .S ZTR1=+$P($G(^PRC(442,ZP,7)),"^",2) Q:$D(ARR(ZTR1))
 .Q:CP=""
 .S PC1=$P($G(^PRC(442,ZP,23)),"^",8) Q:PC1=""
 .D DD^%DT S TDATE=Y
 .S USER=$P($G(^PRC(440.5,PC1,0)),"^",8),USER=$P($G(^VA(200,+USER,0)),"^"),VEND=$P(F2,"^"),VEND=$P($G(^PRC(440,+VEND,0)),"^"),AMT=$P(F1,"^",15),VEND=$E(VEND,1,30)
 .I VEND="SIMPLIFIED",$P($G(^PRC(442,ZP,24)),"^",2)'="" S VEND=$P($G(^PRC(442,ZP,24)),"^",2)
 .S LINE1=CP_"^"_PCNUM_"^"_USER_"^"_VEND
 .S CC=$P(F1,"^",5),BOC=$P($G(^PRC(442,ZP,2,1,0)),"^",4),BOC=$E(BOC,1,20)
 .S LINE2=AMT_"^"_TDATE_"^"_CC_"^"_$E(BOC,1,30)
 .S CP=+CP,^TMP($J,CP,ZP,1)=LINE1,^TMP($J,CP,ZP,2)=LINE2,^TMP($J,CP,ZP,3)=LINE3,^TMP($J,CP,ZP,4)=LSTATUS
 ;
WRITE ;
 I '$D(^TMP($J)) S P=1 D HEADER W !!!!,?10,"*** NO RECORDS TO PRINT ***" Q
 S (TOT,CP,ZP)="" F  S CP=$O(^TMP($J,CP)) Q:EX[U  Q:CP=""  D
 .F  S ZP=$O(^TMP($J,CP,ZP)) Q:EX[U  Q:ZP=""  D
 ..D:P=1 HEADER I (IOSL-$Y)<6 D HOLD Q:EX[U
 ..S LINE1=^TMP($J,CP,ZP,1) W !,$P(LINE1,"^"),?6,$P(LINE1,"^",2),?25,$P(LINE1,"^",3),?50,$P(LINE1,"^",4)
 ..S AMT1=$P(^TMP($J,CP,ZP,2),"^",1) W !,?3,$J(AMT1,0,2),?20,$P(^TMP($J,CP,ZP,2),"^",2),?36,$P(^TMP($J,CP,ZP,2),"^",3),?50,$P(^TMP($J,CP,ZP,2),"^",4)
 ..W !,^TMP($J,CP,ZP,3),!,^TMP($J,CP,ZP,4),!
 ..S TOT=TOT+AMT1
 .I EX'[U W !,?40,"CONTROL POINT ",CP," SUBTOTAL: ",$J(TOT,0,2),! S TOT=0
 QUIT
 ;
HOLD G HEADER:$E(IOST)="P"!(IO'=IO(0)) W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ["^" EX=U S:'$T EX=U D:EX'=U HEADER Q
 ;
HEADER ;
 W @IOF
 W !,"DETAILED REPORT OF UNPAID PURCHASE CARD TRANSACTIONS BY FCP",?65,"PAGE: ",P
 W !,"FCP",?6,"PC NUMBER",?25,"BUYER",?50,"VENDOR"
 W !,?3,"AMOUNT",?20,"PURCHASE DATE",?36,"COST CENTER",?50,"BUDGET OBJECT CODE",!,"FIRST LINE ITEM DESCRIPTION",!,"STATUS"
 W ! F I=1:1:10 W "--------"
 S P=P+1 Q
