PRCHRP6 ;WISC/KMB/CR FISCAL DAILY REVIEW ;7/09/98  10:34
 ;;5.1;IFCAP;**8**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;
 N LINE1,LINE2,PONUM,STRING,LIN1,LIN2,AMT,AMT1,FLAG,STATUS,CP,VEND,USER,STATUS,TDATE,EDATE,FDATE,HDATE,DIR,ZP,P,X,Y,F1,F2,LINE3,TOT,XXZ,EX
 K ^TMP($J)
 W @IOF
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))  Q:$G(X)="^"
 S DIR("A")="Enter beginning date",DIR("?")="Enter the first date for which you wish to see records"
 S DIR(0)="D^^" D ^DIR K DIR Q:+Y<1  S FDATE=+Y W "   ",Y(0)
 S DIR("A")="Enter ending date",DIR("?")="Enter the last date for which you wish to see records"
 S DIR(0)="D^^" D ^DIR K DIR Q:+Y<1  S EDATE=+Y W "   ",Y(0)
 I EDATE<FDATE W !,"Date range is incorrect." G START
 S DIR("A")="Do you want to see delivery orders",DIR(0)="Y^^" D ^DIR K DIR Q:Y<0  S FLAG=Y
 S %ZIS("B")="",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="DETAIL^PRCHRP6",ZTSAVE("*")="" D ^%ZTLOAD,^%ZISC Q
 D DETAIL,^%ZISC
 Q
 ;
DETAIL ;
 D NOW^%DTC,YX^%DTC S HDATE=Y
 S (P,EX)=1
 S ZP="" F  S ZP=$O(^PRC(442,"F",25,ZP)) Q:ZP=""  D DETAIL1
 I $G(FLAG)=1 S ZP="" F  S ZP=$O(^PRC(442,"F",1,ZP)) Q:ZP=""  D DETAIL1
 D WRITE
 K ^TMP($J)
 Q
 ;
DETAIL1 ;
 S F1=$G(^PRC(442,ZP,0)),F2=$G(^PRC(442,ZP,1))
 I $D(PRC("SITE")) Q:$P(F1,"-")'=PRC("SITE")
 S Y=$P(F2,"^",15),CP=$P(F1,"^",3),CP=+$P(CP," ")
 Q:CP=""  Q:Y<FDATE  Q:Y>EDATE
 D DD^%DT S TDATE=Y
 S USER=$P(F2,"^",10),USER=$P($G(^VA(200,+USER,0)),"^"),VEND=$P(F2,"^"),VEND=$P($G(^PRC(440,+VEND,0)),"^"),AMT=$P(F1,"^",15)
 I VEND="SIMPLIFIED",$P($G(^PRC(442,ZP,24)),"^",2)'="" S VEND=$P($G(^PRC(442,ZP,24)),"^",2)
 S VEND=$E(VEND,1,25)
 S LINE1=TDATE_"^"_USER_"^"_VEND_"^"_AMT
 S PONUM=$P(F1,"^"),STATUS=$P($G(^PRC(442,ZP,7)),"^") Q:STATUS=1  Q:STATUS=45
 S:STATUS'="" STATUS=$P($G(^PRCD(442.3,STATUS,0)),"^"),STATUS=$E(STATUS,1,40)
 S LINE2=STATUS_"^"_PONUM
 S ^TMP($J,CP,ZP,1)=LINE1,^TMP($J,CP,ZP,2)=LINE2
 Q
 ;
WRITE ;
 U IO S P=1
 S STRING="PURCHASE CARD PO NUMBER" S:FLAG=1 STRING="TRANSACTION PO NUMBER"
 I '$D(^TMP($J)) S CP="" D HEADER W !!!!,?10,"*** NO RECORDS TO PRINT ***" Q
 S TOT=0,(CP,ZP)="" F  S CP=$O(^TMP($J,CP)) Q:EX[U  Q:CP=""  D
 .D HEADER
 .F  S ZP=$O(^TMP($J,CP,ZP)) Q:EX[U  Q:ZP=""  D
 ..S LINE1=^TMP($J,CP,ZP,1),LINE2=^TMP($J,CP,ZP,2) D
 ...W !,$P(LINE1,"^"),?15,$P(LINE1,"^",2),?40,$P(LINE1,"^",3) S AMT1=$P(LINE1,"^",4) W ?70,$J(AMT1,8,2)
 ...W !,$P(LINE2,"^"),?45,$P(LINE2,"^",2),!
 ...S TOT=TOT+AMT1
 ...I (IOSL-$Y)<5 D HOLD
 .I EX'[U W !,?25,"CONTROL POINT ",CP," SUBTOTAL: ",$J(TOT,0,2),! S TOT=0
 .I $E(IOST,1,2)'="P-",EX'[U W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ[U EX=U S:'$T EX=U W !
 Q
 ;
HOLD G HEADER:$E(IOST,1,2)="P-"!(IO'=IO(0)) W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ["^" EX="^" S:'$T EX="^" D:EX'="^" HEADER
 Q
 ;
HEADER ;
 W @IOF
 W !,"FISCAL DAILY REVIEW REPORT",?42,HDATE,?70,"PAGE ",P,!
 W !,"PURCHASE DATE",?15,"BUYER",?40,"VENDOR",?72,"AMOUNT"
 W !,?3,"STATUS",?45,STRING
 W ! F I=1:1:10 W "--------"
 W !!,"CONTROL POINT: ",CP,!
 S P=P+1
 Q
