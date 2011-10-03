PRCHURP ;WISC/KMB/CR-UNAPPROVED RECONCILIATION ;7/09/98  11:10
 ;;5.1;IFCAP;**8,35**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;
 N CHK,OFF,CPS,S1,S2,RDATE,LINE1,CRD,PONUM,STRING,AMT,AMT1,FLAG,FLAG1,CP,USER,TDATE,EDATE,FDATE,HDATE,DIR,ZP,P,PRC,X,Y,F1,F2,F3,XXZ,EX
 K ^TMP($J)
 W @IOF
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))  Q:$G(X)="^"
 S DIR("A")="Enter beginning date",DIR("?")="Enter the first date for which you wish to see records"
 S DIR(0)="D^^" D ^DIR K DIR Q:+Y<1  S FDATE=+Y W "   ",Y(0)
 S DIR("A")="Enter ending date",DIR("?")="Enter the last date for which you wish to see records"
 S DIR(0)="D^^" D ^DIR K DIR Q:+Y<1  S EDATE=+Y W "   ",Y(0)
 I EDATE<FDATE W !,"Date range is incorrect." G START
 S (FLAG,FLAG1)=0,DIR("A")="Do you want to include all the Approving Officials in this report",DIR(0)="Y^^" D ^DIR K DIR Q:Y<0  S FLAG=Y
 ;
 I FLAG=0 S DIC="^VA(200,",DIC(0)="AEMQZ",DIC("A")="Select one Approving Official (or Alternate): ",DIC("S")="I $D(^PRC(440.5,""I"",PRC(""SITE""),+Y))!($D(^PRC(440.5,""J"",PRC(""SITE""),+Y)))" D ^DIC K DIC Q:Y<0  S FLAG1=+Y
 S %ZIS("B")="",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="DETAIL^PRCHURP",ZTSAVE("*")="" D ^%ZTLOAD,^%ZISC Q
 D DETAIL,^%ZISC Q
 ;
DETAIL ;
 D NOW^%DTC S Y=% D DD^%DT S HDATE=Y
 S (P,EX)=1
 U IO S ZP="" F  S ZP=$O(^PRC(442,"F",25,ZP)) Q:ZP=""  D DETAIL1
 D WRITE
 K ^TMP($J)
 QUIT
 ;
DETAIL1 ;
 S F1=$G(^PRC(442,ZP,0)),F2=$G(^PRC(442,ZP,1)),F3=$G(^PRC(442,ZP,23))
 I $D(PRC("SITE")) Q:$P(F1,"-",1)'=PRC("SITE")
 S Y=$P(F2,"^",15),CP=$P(F1,"^",3),CPS=+CP,CP=$E(CP,1,19)
 Q:CP=""  Q:Y<FDATE  Q:Y>EDATE
 D DD^%DT S TDATE=Y
 ; quit if order has not been reconciled
 S CHK=$P($G(^PRC(442,ZP,7)),"^") I CHK'=96,CHK'=97 Q
 S Y=$P(F3,"^",19),CRD=$P(F3,"^",8) Q:CRD=""  S OFF=$P($G(^PRC(440.5,CRD,0)),"^",9)
 I $G(OFF)="" S OFF="NOT ASSIGNED"
 ; allow the report for Alternate Approving Officials too
 I $G(FLAG)=0,$G(FLAG1)'=OFF S OFF=$P(^PRC(440.5,CRD,0),"^",10) Q:OFF'=$G(FLAG1)
 S:+OFF'=0 OFF=$P(^VA(200,+OFF,0),"^") D DD^%DT S RDATE=Y
 S USER=$P(F3,"^",22),USER=$P($G(^VA(200,+USER,0)),"^"),PONUM=$P(F1,"^"),AMT=$P(F1,"^",15)
 Q:USER=""  S LINE1=TDATE_"^"_PONUM_"^"_USER_"^"_CP_"^"_AMT
 S LINE2=RDATE
 S ^TMP($J,OFF,CPS,USER,ZP,1)=LINE1,^TMP($J,OFF,CPS,USER,ZP,2)=LINE2
 QUIT
 ;
WRITE ;
 I '$D(^TMP($J)) S OFF="",P=1 D HEADER W !!!!,?10,"*** NO RECORDS TO PRINT ***" Q
 S (OFF,S1,S2,ZP)="" F  S OFF=$O(^TMP($J,OFF)) Q:EX[U  Q:OFF=""  D
 .D HEADER
 .F  S S1=$O(^TMP($J,OFF,S1)) Q:EX[U  Q:S1=""  D
 ..F  S S2=$O(^TMP($J,OFF,S1,S2)) Q:EX[U  Q:S2=""  D
 ...F  S ZP=$O(^TMP($J,OFF,S1,S2,ZP)) Q:EX[U  Q:ZP=""  D
 ....I (IOSL-$Y)<6 D HOLD Q:EX[U
 ....S LINE1=^TMP($J,OFF,S1,S2,ZP,1) W !,$P(LINE1,"^"),?15,$P(LINE1,"^",2),?28,$P(LINE1,"^",3),?49,$P(LINE1,"^",4) S AMT1=$P(LINE1,"^",5) W ?72,$J(AMT1,0,2)
 ....W !,?3,^TMP($J,OFF,S1,S2,ZP,2),!
 .I $E(IOST)'="P",EX'["^" W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ["^" EX="^" S:'$T EX=U
 W !,"END OF REPORT" QUIT
 ;
HOLD G HEADER:$E(IOST)="P"!(IO'=IO(0)) W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ["^" EX="^" S:'$T EX=U D:EX'=U HEADER Q
 ;
HEADER ;
 W @IOF
 W !,"UNAPPROVED RECONCILIATION REPORT",?40,HDATE,?68,"PAGE ",P,!
 W "STATION NUMBER: "_PRC("SITE")
 W !,"PURCHASE DATE",?15,"PC ORDER #",?28,"CARDHOLDER",?49,"FCP",?72,"AMOUNT"
 W !,?3,"DATE RECONCILED"
 W ! F I=1:1:10 W "--------"
 W !!,?10,"APPROVING OFFICIAL: ",OFF,!
 S P=P+1 Q
