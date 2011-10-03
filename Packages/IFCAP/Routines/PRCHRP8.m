PRCHRP8 ;WISC/KMB/CR-PC STATISTICS REPORT ;7/16/98  14:55
 ;;5.1;IFCAP;**8**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;
 N C1,C2,C3,C4,C5,AMT,PC,P,PRC,ZP,CP,LCT,BOC,CNT,PDATE,TRAN,XXZ,EX,Y,YY,PCLCT,PCCNT,BB,AA,COUNT,FDATE,EDATE,PCN,GTOT,END,TDATE
 N PCNUM,SEQNUM,CTR,CTR1,CPCNT,I,PRCRI,Z0,Z1,Z7,Z23,ZP1,ZIP,USER,%
 K ^TMP($J)
 W @IOF S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))
 Q:$G(X)="^"
 ;
RANGE ;
 S DIR("A")="Enter beginning date",DIR("?")="Enter the first date for which you wish to see records"
 S DIR(0)="D^^" D ^DIR K DIR Q:+Y<1  S FDATE=+Y W "   ",Y(0)
 S DIR("A")="Enter ending date",DIR("?")="Enter the last date for which you wish to see records"
 S DIR(0)="D^^" D ^DIR K DIR Q:+Y<1  S EDATE=+Y W "   ",Y(0)
 I EDATE<FDATE W !,"Date range is incorrect." G RANGE
 S %ZIS("B")="",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="DETAIL^PRCHRP8",ZTSAVE("EDATE")="",ZTSAVE("FDATE")="",ZTSAVE("PRC*")="" D ^%ZTLOAD,^%ZISC Q
 D DETAIL,^%ZISC Q
 ;
DETAIL ;
 D NOW^%DTC S Y=% D DD^%DT S TDATE=Y
 S GTOT=0,U="^",(COUNT,P,EX,CNT)=1
 S CTR=FDATE F  S CTR=$O(^PRC(442,"AB",CTR)) Q:+CTR=0  Q:CTR>EDATE  D
 .S CTR1=0 F  S CTR1=$O(^PRC(442,"AB",CTR,CTR1)) Q:+CTR1=0  D
 ..S ZP1=CTR1 S Z0=$G(^PRC(442,ZP1,0)),Z1=$G(^PRC(442,ZP1,1)),Z7=$P(Z0,"^",12) S:Z7="" Z7=0
 ..I $D(PRC("SITE")) Q:$P(Z0,"-")'=PRC("SITE")
 ..S SEQNUM=$P(Z0,"^")
 ..S Z23=$G(^PRC(442,ZP1,23))
 ..S (Y,YY)=$P(Z1,"^",15) Q:YY<FDATE  Q:YY>EDATE
 ..S CP=$P(Z0,"^",3),CP=+$P(CP," ") Q:CP=0
 ..S:$G(AA(CP,1))="" AA(CP,1)=0 S AA(CP,1)=AA(CP,1)+1
 ..S PC=$P(Z23,"^",8) Q:PC=""  S PCNUM=$P($G(^PRC(440.5,PC,0)),"^") Q:PCNUM=""  S PCN=$P($G(^PRC(440.5,PC,0)),"^",11),PCN=$E(PCN,1,28)
 ..D DD^%DT S PDATE=Y
 ..S:$G(AA(CP))="" AA(CP)=0 S:$G(AA(CP,2))="" AA(CP,2)=0
 ..S AMT=$P(Z0,"^",15),LCT=$P($G(^PRCS(410,Z7,"IT",0)),"^",4),AA(CP,2)=AA(CP,2)+AMT,AA(CP)=AA(CP)+1,GTOT=GTOT+AMT
 ..S USER=$P($G(^PRC(440.5,PC,0)),"^",8) Q:USER=""  S USER=$P($G(^VA(200,USER,0)),"^") Q:USER=""
 ..S ^TMP($J,CP,USER,PCNUM,YY,COUNT)=PCN_"^"_SEQNUM_"^"_LCT_"^"_AMT_"^"_PDATE,COUNT=COUNT+1
 ..I '$D(BB(PCNUM)) S (BB(PCNUM),BB(PCNUM,1),BB(PCNUM,2))=0
 ..S BB(PCNUM)=BB(PCNUM)+LCT,BB(PCNUM,1)=BB(PCNUM,1)+1,BB(PCNUM,2)=BB(PCNUM,2)+AMT
 ;
WRITE ;
 U IO
 I '$D(^TMP($J)) S C1="",C2="" D HEADER W !!!!,?10,"*** NO RECORDS TO PRINT ***" Q
 S (C1,C2,C3,C4,C5)=0 F  S C1=$O(^TMP($J,C1)) Q:EX[U  Q:C1=""  D
 .F  S C2=$O(^TMP($J,C1,C2)) Q:EX[U  Q:C2=""  D
 ..D HEADER
 ..F  S C3=$O(^TMP($J,C1,C2,C3)) Q:EX[U  Q:C3=""  D
 ...F  S C4=$O(^TMP($J,C1,C2,C3,C4)) Q:EX[U  Q:C4=""  D
 ....F  S C5=$O(^TMP($J,C1,C2,C3,C4,C5)) Q:EX[U  Q:C5=""  D
 .....S ZIP=^TMP($J,C1,C2,C3,C4,C5) W !,$P(ZIP,"^"),?30,$P(ZIP,"^",2),?43,$P(ZIP,"^",3) S AMT=$P(ZIP,"^",4) W ?52,$J(AMT,12,2),?67,$P(ZIP,"^",5)
 .....I (IOSL-$Y)<8 D HOLD Q:EX[U
 ...I EX'[U S PCCNT=BB(C3,2)/BB(C3,1),PCLCT=BB(C3)/BB(C3,1) W !!,"AVERAGE DOLLAR COST FOR CARD: $",$J(PCCNT,0,2),!,"  AVERAGE LINE COUNT FOR CARD: ",$J(PCLCT,0,2),!
 ..I EX'[U S CPCNT=100*(AA(C1)/AA(C1,1)) W !!,"% OF PC ORDERS FOR CP ",C1,": ",$J(CPCNT,0,3),!,"PC ORDER COUNT: ",AA(C1),?30,"TOTAL ORDER COUNT: ",AA(C1,1),!,"   PC SUBTOTAL: ",$J(AA(C1,2),0,2)
 ..I $E(IOST,1,2)'="P-",EX'[U W !,"Press return to continue, '^', to exit: " R XXZ:DTIME S:XXZ[U EX=U S:'$T EX=U
 I EX'[U W !?25,"STATION GRAND TOTAL - $",$J(GTOT,0,2)
 K ^TMP($J)
 QUIT
 ;
HOLD G HEADER:$E(IOST,1,2)="P-"!(IO'=IO(0)) W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ[U EX=U S:'$T EX=U D:EX'=U HEADER
 QUIT
 ;
HEADER ;
 W @IOF
 W "PURCHASE CARD STATISTICS REPORT",?42,TDATE,?70,"PAGE ",P
 W !,"PURCHASE CARD NAME",?30,"PO NUMBER",?43,"LINE ITEMS",?58,"AMOUNT",?67,"DATE PLACED"
 W ! F I=1:1:8 W "----------"
 W !!,"FCP: ",C1,?20,"BUYER: ",C2,!
 S P=P+1 QUIT
