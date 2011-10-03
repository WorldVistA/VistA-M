PRCHRP4 ;WISC/KMB/CR-PC ORDERS READY FOR APPROVAL  ;06/11/98  1:50 PM
 ;;5.1;IFCAP;**25**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;
 N APO,APO1,APO2,LN,PC1,I,LN,X,XX,PO,P,PA,F1,F2,USER,XUSER,F3,YY,Y,PDATE,VEND,RDATE,PC,USER,AMT,XXZ,EX,STATUS,ID,ZIP,AA,Z0,Z1,Z2,Z3,Z4,TIMDATE
 K ^TMP($J) W @IOF
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))
 Q:$G(X)="^"
 S %ZIS("B")="",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="DETAIL^PRCHRP4",ZTSAVE("PRC*")="" D ^%ZTLOAD,^%ZISC Q
 D DETAIL,^%ZISC Q
 ;
DETAIL ;
 S APO=DUZ,CNT=0
 S XUSER="" F  S XUSER=$O(^PRC(442,"MAPP",XUSER)) Q:XUSER=""  D
 .S XX="" F  S XX=$O(^PRC(442,"MAPP",XUSER,XX)) Q:XX=""  D
 ..;Keep orders from different stations separate
 ..I $D(PRC("SITE")) Q:$P(^PRC(442,XX,0),"-",1)'=PRC("SITE")
 ..S (PC,PC1)=$P($G(^PRC(442,XX,23)),"^",8),PC=$P($G(^PRC(440.5,+PC,0)),"^") S:PC="" PC=0
 ..S F1=$G(^PRC(442,XX,0)),F2=$G(^PRC(442,XX,1)),F3=$G(^PRC(442,XX,2,1,1,1,0))
 ..;Get the approving official or alternate app. official
 ..S APO1=$P($G(^PRC(440.5,+PC1,0)),"^",9)
 ..I APO1'=DUZ S APO2=$P($G(^PRC(440.5,+PC1,0)),"^",10) Q:APO2=""
 ..S APO=$S(APO1=DUZ:DUZ,APO2=DUZ:DUZ,1:"")
 ..S:APO'="" APO=$P($G(^VA(200,APO,0)),"^")
 ..S USER=$P($G(^PRC(440.5,+PC1,0)),"^",8),USER=$P($G(^VA(200,+USER,0)),"^"),VEND=$P(F2,"^"),VEND=$P($G(^PRC(440,+VEND,0)),"^"),AMT=$P(F1,"^",15),VEND=$E(VEND,1,30)
 ..I VEND="SIMPLIFIED",$P($G(^PRC(442,XX,24)),"^",2)'="" S VEND=$P($G(^PRC(442,XX,24)),"^",2)
 ..Q:USER=""!(APO="")
 ..S PO=$P(F1,"^")
 ..S Y=$P(^PRC(442,XX,23),"^",19) D DD^%DT S RDATE=Y
 ..S (YY,Y)=$P(F2,"^",15) D DD^%DT S PDATE=Y
 ..S ^TMP($J,USER,-YY,APO,PC,PO)=PDATE_"^"_RDATE_"^"_PO_"^"_AMT_"^"_VEND
 ..S ^TMP($J,USER,-YY,APO,PC,PO,1)=$E(F3,1,45),CNT=$G(CNT)+1
 ;
WRITE ;
 U IO S U="^"
 S X=DT D NOW^%DTC,YX^%DTC S TIMDATE=Y
 I '$D(^TMP($J)) S P=1,Z0="" D HEADER W !!!!,?10,"*** NO RECORDS TO PRINT ***" Q
 S (P,EX)=1,Z0=0 F  S Z0=$O(^TMP($J,Z0)) Q:EX[U  Q:Z0=""  D
 .D HEADER
 .S Z1="" F  S Z1=$O(^TMP($J,Z0,Z1)) Q:Z1=""  Q:EX[U  D
 ..S Z2="" F  S Z2=$O(^TMP($J,Z0,Z1,Z2)) Q:Z2=""  Q:EX[U  D
 ...S Z3="" F  S Z3=$O(^TMP($J,Z0,Z1,Z2,Z3)) Q:Z3=""  Q:EX[U  D
 ....S Z4="" F  S Z4=$O(^TMP($J,Z0,Z1,Z2,Z3,Z4)) Q:Z4=""  Q:EX[U  D
 .....I (IOSL-$Y)<6 D HOLD Q:EX[U
 .....W ! S LN=^TMP($J,Z0,Z1,Z2,Z3,Z4)
 .....W !,$P(LN,"^"),?20,$P(LN,"^",2),?37,$P(LN,"^",3),?55,$J($P(LN,"^",4),0,2)
 .....W !,$P(LN,"^",5),?35,^TMP($J,Z0,Z1,Z2,Z3,Z4,1)
 .I $E(IOST)'="P",EX'["^" W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ["^" EX="^" S:'$T EX=U
 W !!,?10,"Total number of orders found: ",CNT
 K ^TMP($J),CNT
 QUIT
 ;
HOLD G HEADER:$E(IOST)="P"!(IO'=IO(0)) W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ["^" EX="^" S:'$T EX=U D:EX'=U HEADER Q
 ;
HEADER ;
 W @IOF
 W !,"PURCHASE CARD ORDERS READY FOR APPROVAL",?45,TIMDATE,?70,"PAGE ",P
 W !,"PO DATE",?20,"DATE RECONCILED",?37,"PO NUMBER",?55,"$AMT",!,?8,"VENDOR",?35,"DESCRIPTION"
 W ! F I=1:1:8 W "----------"
 W !,?20,"BUYER: ",Z0
 S P=P+1
 QUIT
