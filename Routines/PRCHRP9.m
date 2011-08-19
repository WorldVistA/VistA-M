PRCHRP9 ;WISC/KMB-DISPUTED PURCHASE CARD ORDERS  ;8/21/96  12:09
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
STRT S FLAG=1 ;Buyer report.
 G EN
START ;
 S FLAG=2 ;Official report.
EN K ^TMP($J)
 S LABEL="START" S:$G(FLAG)=1 LABEL="STRT"
 W @IOF S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))
 Q:$G(X)="^"
 S %ZIS("B")="",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="DETAIL^PRCHRP9",ZTSAVE("FLAG")="",ZTSAVE("PRC*")="" D ^%ZTLOAD,^%ZISC Q
 D DETAIL,^%ZISC
 D CLEAN
 Q
 ;
CLEAN ;
 K ^TMP($J),I,ID,FLAG,LN,Z0,Z1,Z2,Z3,PO,LABEL,X,XX,F0,F1,F2,F3,F4,F23,RECDT,YY,Y,PDATE,VEND,RDATE,PC,PC0,PC1,USER,AMT,XXZ,EX,PCNAME,AA,P,TIMDATE,PRCRI,ZIP
 Q
 ;
DETAIL ;
 S (EX,XX)="" F  S XX=$O(^PRC(440.5,XX)) Q:XX=""  D
 .S ZIP=$G(^PRC(440.5,XX,0)),ID=$P(ZIP,"^") S:$P(ZIP,"^",9)=DUZ AA(ID)="" S:$P(ZIP,"^",10)=DUZ AA(ID)=""
 S (EX,XX)="" F  S XX=$O(^PRC(442,"F",25,XX)) Q:XX=""  D
 .S F0=$G(^PRC(442,XX,0))
 .S F1=$G(^PRC(442,XX,1))
 .S F23=$G(^PRC(442,XX,23))
 .I $P(F23,"^",9)="" Q
 .I $P(F23,"^",9)="N" Q
 .I $G(FLAG)=1,$P(F1,"^",10)'=DUZ Q
 .Q:("^40^41^45^"[("^"_$P($G(^PRC(442,XX,7)),U,2)_"^"))
 .S PC1=+$P(F23,"^",8),PC0=$G(^PRC(440.5,PC1,0))
 .S PC=$P(PC0,"^") Q:+PC=0
 .Q:$P(F0,"-",1)'=PRC("SITE")  ;Don't mix stations
 .S USER=$P(PC0,"^",8),USER=$P($G(^VA(200,+USER,0)),"^")
 .Q:USER=""
 .;
 .; See if the Approving Official or Alternate have anything to approve.
 .I $G(FLAG)=2 Q:'$D(AA(PC))
 .I $G(FLAG)=2 Q:$P(PC0,"^",9)'=DUZ&($P(PC0,"^",10)'=DUZ)
 .S F3=$G(^PRC(442,XX,2,1,1,1,0))
 .S F4=$G(^PRC(442,XX,4,1,0))
 .S PCNAME=$P(PC0,"^",11),PCNAME=$E(PCNAME,1,15)
 .S VEND=$P(F1,"^"),VEND=$P($G(^PRC(440,+VEND,0)),"^"),AMT=$J($P(F0,"^",15),0,2)
 .I VEND="SIMPLIFIED",$P($G(^PRC(442,XX,24)),"^",2)'="" S VEND=$P($G(^PRC(442,XX,24)),"^",2)
 .S VEND=$E(VEND,1,25)
 .S PO=$P(F0,"^")
 .S (YY,Y)=$P(F1,"^",15) D DD^%DT S PDATE=Y
 .Q:YY=""
 .S Y=$P(F23,"^",19) D DD^%DT S RECDT=$P(Y,".")
 .S ^TMP($J,USER,PC,YY,PO,0)=PCNAME_"^"_PDATE_"^"_AMT_"^"_PO_"^"_VEND_"^"_RECDT
 .S ^TMP($J,USER,PC,YY,PO,1)=$E(F3,1,45),^TMP($J,USER,PC,YY,PO,2)=$E(F4,1,99)
 ;
WRITE ; Let's go to the printer.
 U IO S U="^"
 S X=DT D NOW^%DTC,YX^%DTC S TIMDATE=Y
 S P=1,Z0="" I $O(^TMP($J,0))="" D HEADER W !!!!,?10," **** NO RECORDS TO PRINT ****" QUIT
 S Z0="" F  S Z0=$O(^TMP($J,Z0)) Q:EX[U  Q:Z0=""  D
 .D HEADER
 .S Z1="" F  S Z1=$O(^TMP($J,Z0,Z1)) Q:Z1=""  Q:EX[U  D
 ..S Z2="" F  S Z2=$O(^TMP($J,Z0,Z1,Z2)) Q:Z2=""  Q:EX[U  D
 ...S Z3="" F  S Z3=$O(^TMP($J,Z0,Z1,Z2,Z3)) Q:Z3=""  Q:EX[U  D
 ....W ! S LN=^TMP($J,Z0,Z1,Z2,Z3,0) W !,$P(LN,"^"),?15,$P(LN,"^",2),?30,$P(LN,"^",3),?41,$P(LN,"^",4),?54,$P(LN,"^",5)
 ....W !,$P(LN,"^",6),?20,^TMP($J,Z0,Z1,Z2,Z3,1)
 ....W !,^TMP($J,Z0,Z1,Z2,Z3,2)
 ....I (IOSL-$Y)<6 D HOLD
 .I $E(IOST,1,2)'="P-",EX'[U W !!,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ[U EX=U S:'$T EX=U
 Q
 ;
HOLD G HEADER:$E(IOST,1,2)="P-"!(IO'=IO(0)) W !!,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ[U EX=U S:'$T EX=U D:EX'=U HEADER
 Q
 ;
HEADER ;
 W @IOF
 W "DISPUTED PURCHASE CARD ORDERS",?40,TIMDATE,?70,"PAGE ",P
 W !,"PC NAME",?15,"P.O. DATE",?30,"$AMT",?41,"PC ORDER #",?54,"VENDOR",!,"DATE RECONCILED",?20,"DESCRIPTION",!,"COMMENTS"
 W ! F I=1:1:8 W "----------"
 W !,"BUYER: ",Z0
 S P=P+1
 QUIT
