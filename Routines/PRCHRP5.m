PRCHRP5 ;WISC/KMB/CR-RECONCILED PURCHASE CARD ORDERS  ;6/29/98 15:27
 ;;5.1;IFCAP;**8**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;
 ; set check for reconciled reports
 N FLAG S FLAG=1 G EN
START1 ;
 ; entry point for unreconciled reports
 N FLAG S FLAG=0
EN K ^TMP($J)
 N CCTOT,XXZ,LIN,CCREF,CCRF,CCAMT,CP,PCARD,PO,P,PA,PRC,PRCRI,LABEL,XX,F1,F2,F3,F4,STATUS,YY,Y,PDATE,VEND,RDATE,RPTDATE,PC,USER,AMT,XXZ,EX,COUNT,FDATE,EDATE,TYPE
 N RMPR,RMPR1,OSTAT,OREC,OREC6,MERC,CNTCC,CNTSTR,P,LN,Z0,Z1,Z2,Z3,Z4
 S:$G(FLAG)="" FLAG=0 S:$G(FLG)="" FLG=""
 S:$G(FLAG)=1 LABEL="START" S:$G(FLAG)=0 LABEL="START1"
 S PRCF("X")="S" D ^PRCFSITE I '$D(PRC("SITE")) K FLAG QUIT
 Q:$G(X)="^"
 ;
RANGE ;
 S DIR("A")="Enter beginning date",DIR("?")="Enter the first date for which you wish to see records"
 S DIR(0)="D^^" D ^DIR K DIR Q:+Y<1  S FDATE=+Y W "   ",Y(0)
 S DIR("A")="Enter ending date",DIR("?")="Enter the last date for which you wish to see records"
 S DIR(0)="D^^" D ^DIR K DIR Q:+Y<1  S EDATE=+Y W "   ",Y(0)
 I EDATE<FDATE W !,"Date range is incorrect." G RANGE
 I $G(X)="^" K FLG,FLAG Q
 S %ZIS("B")="",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="DETAIL^PRCHRP5",ZTSAVE("*")="" D ^%ZTLOAD,^%ZISC K FLG,FLAG,^TMP($J) Q
 D DETAIL,^%ZISC K FLG,FLAG,^TMP($J)
 Q
DETAIL ;
 ;variable F4 is used to store the first line from the COMMENTS
 ;field.  If there is a Prosthetics entry for the order, the
 ;first line of file 664's REMARKS field is stored in F4.
 S COUNT=1,XX="" F  S XX=$O(^PRC(442,"F",25,XX)) Q:XX=""  D
 .S (CCREF,CCRF,CCAMT)=""
 .S F1=$G(^PRC(442,XX,0)) S CP=$P(F1,"^",3)
 .S F2=$G(^PRC(442,XX,1)),F3=$G(^PRC(442,XX,2,1,1,1,0))
 .S F4=$G(^PRC(442,XX,4,1,0))
 .S STATUS=+$P($G(^PRC(442,XX,7)),"^",2)
 .Q:(STATUS=1)!(STATUS=45)
 .I $G(FLAG)=1 Q:"^40^41^50^51^"'[("^"_STATUS_"^")
 .I $G(FLAG)=0 Q:"^4^5^6^40^41^50^51^"[("^"_STATUS_"^")
 .I $D(PRC("SITE")) Q:$P(F1,"-",1)'=PRC("SITE")
 .I $G(FLAG)=1 S Y=$P($G(^PRC(442,XX,23)),"^",19) Q:Y<FDATE  Q:Y>EDATE
 .I $G(FLAG)'=1 S Y=$P(F2,"^",15) Q:Y<FDATE  Q:Y>EDATE
 .I $P($G(^PRC(442,XX,24)),"^",3)="RMPR" S RMPR=$P(F1,"^") I $D(^RMPR(664,"AC",RMPR)) S RMPR1=$O(^RMPR(664,"AC",RMPR,0)),F4=$P($G(^RMPR(664,+RMPR1,1,1,0)),"^",8)
 .S PC=$P($G(^PRC(442,XX,23)),"^",8),PC=$P($G(^PRC(440.5,+PC,0)),"^") S:PC="" PC=0
 .S STATUS=$P($G(^PRC(442,XX,7)),"^")
 .I $G(FLAG)=1 Q:$P($G(^PRC(442,XX,23)),"^",19)=""
 .S PCARD=$P($G(^PRC(442,XX,23)),"^",8) Q:PCARD=""
 .I $G(FLG)=2 I $P($G(^PRC(440.5,PCARD,0)),"^",10)'=DUZ,$P($G(^PRC(440.5,PCARD,0)),"^",9)'=DUZ Q
 .I $G(FLG)=1 Q:$P($G(^PRC(440.5,PCARD,0)),"^",8)'=DUZ
 .S STATUS=$P($G(^PRCD(442.3,STATUS,0)),"^")
 .S USER=$P($G(^PRC(440.5,PCARD,0)),"^",8) Q:USER=""
 .S USER=$P($G(^VA(200,+USER,0)),"^"),VEND=$P(F2,"^"),VEND=$P($G(^PRC(440,+VEND,0)),"^"),AMT=$P(F1,"^",15)
 .I VEND="SIMPLIFIED",$P($G(^PRC(442,XX,24)),"^",2)'="" S VEND=$P($G(^PRC(442,XX,24)),"^",2)
 .S VEND=$E(VEND,1,30)
 .Q:USER=""
 .S PO=$P(F1,"^")
 .S (YY,Y)=$P(F2,"^",15) D DD^%DT S PDATE=Y
 .S Y=$P($G(^PRC(442,XX,23)),"^",19),TYPE=$P($G(^PRC(442,XX,23)),"^",11) D DD^%DT S RDATE=Y
 .S:TYPE["D" TYPE="DELIV." S:TYPE="P" TYPE="DETAILED" S:TYPE="S" TYPE="SIMPLIFIED"
 .S CCTOT=0 I $G(FLAG)=1,$O(^PRCH(440.6,"PO",XX,0))'="" S CCREF=0  D
 ..F  S CCREF=$O(^PRCH(440.6,"PO",XX,CCREF)) Q:CCREF=""  D
 ...S OREC=$G(^PRCH(440.6,CCREF,0)),OREC6=$G(^PRCH(440.6,CCREF,6))
 ...S OSTAT="NO" I $P($G(^PRCH(440.6,CCREF,1)),"^",4)="Y" S OSTAT="YES"
 ...S CCRF=$P(OREC,"^"),CCAMT=$P(OREC,"^",14),MERC=$P(OREC6,"^") S ^TMP($J,USER,PC,YY,COUNT,3,CCREF)=CCRF_"^"_CCAMT_"^"_MERC_"^"_OSTAT
 ...S CCTOT=CCTOT+CCAMT
 .S ^TMP($J,USER,PC,YY,COUNT,4)=$J(CCTOT,0,2)
 .S:$G(FLAG)=0&($P($G(^PRC(442,XX,23)),"^",19)'="") RDATE=""
 .S ^TMP($J,USER,PC,YY,COUNT)=PDATE_"^"_RDATE_"^"_PO_"^"_AMT_"^"_VEND_"^"_STATUS_"^"_TYPE_"^"_USER
 .S ^TMP($J,USER,PC,YY,COUNT,1)=$E(F3,1,35) S ^TMP($J,USER,PC,YY,COUNT,2)=$E(F4,1,55)
 .S:$G(^TMP($J,USER,2))="" ^TMP($J,USER,2)=0  S ^TMP($J,USER,2)=^TMP($J,USER,2)+AMT
 .S COUNT=COUNT+1
 ;
WRITE ;
 S X=DT D NOW^%DTC,YX^%DTC S RPTDATE=Y
 U IO S U="^",P=1,EX=""
 I '$D(^TMP($J)) S Z0="" S FLAG=$S($G(FLAG)=1:1,$G(FLAG)=0:0,1:1) D HEADER W !!!!,?10,"*** NO RECORDS TO PRINT ***" Q
 ;
 S Z0=0 F  S Z0=$O(^TMP($J,Z0)) Q:Z0=""  Q:EX[U  D
 .D HEADER
 .S Z1="" F  S Z1=$O(^TMP($J,Z0,Z1)) Q:Z1=""  Q:EX[U  D
 ..S Z2="" F  S Z2=$O(^TMP($J,Z0,Z1,Z2)) Q:Z2=""  Q:EX[U  D
 ...S Z3="" F  S Z3=$O(^TMP($J,Z0,Z1,Z2,Z3)) Q:Z3=""  Q:EX[U  D
 ....W ! S LN=^TMP($J,Z0,Z1,Z2,Z3) W !,$P(LN,"^"),?20,$P(LN,"^",2),?40,$P(LN,"^",3),?55,$J($P(LN,"^",4),0,2),?67,$P(LN,"^",7)
 ....S LIN=^TMP($J,Z0,Z1,Z2,Z3,1) W !,$P(LN,"^",5),?40,$P(LIN,"^")
 ....W !,$P(LN,"^",6)
 ....I $G(FLAG)=1,$G(FLG)=1 W !,^TMP($J,Z0,Z1,Z2,Z3,2)
 ....I $G(FLAG)=1 S CNTCC="" F  S CNTCC=$O(^TMP($J,Z0,Z1,Z2,Z3,3,CNTCC)) Q:CNTCC=""  S CNTSTR=^TMP($J,Z0,Z1,Z2,Z3,3,CNTCC) W !,$P(CNTSTR,"^"),?20,$P(CNTSTR,"^",2),?40,$P(CNTSTR,"^",3),?67,$P(CNTSTR,"^",4)
 ....I (IOSL-$Y)<6 D HOLD Q:EX[U
 ....I $G(FLAG)=1 W !,"          RECONCILED SUBTOTAL - $",^TMP($J,Z0,Z1,Z2,Z3,4)
 ....I $G(FLAG)=0 W !,^TMP($J,Z0,Z1,Z2,Z3,2)
 .W !,"          BUYER SUBTOTAL - $",$J(^TMP($J,Z0,2),0,2)
 .I $E(IOST,1,2)="C-",EX'[U W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ[U EX=U S:'$T EX=U
 K Z0,Z1,Z2,Z3
 Q
 ;
HOLD G HEADER:$E(IOST,1,2)'="C-"!(IO'=IO(0)) W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ[U EX=U S:'$T EX=U I EX'=U,$G(Z1)'="",$G(Z3)'="" D HEADER
 QUIT
 ;
HEADER ;
 W @IOF W !
 I $G(FLAG)=0 W "UNRECONCILED"
 I $G(FLAG)=1 W "RECONCILED"
 W " PURCHASE CARD ORDERS",?45,RPTDATE,?70,"PAGE ",P
 W !,"P.O. DATE"
 I $G(FLAG)=1 W ?20,"DATE RECONCILED"
 W ?40,"ORDER #",?55,"$AMT",?67,"TYPE(S/D)",!,"VENDOR",?40,"DESCRIPTION"
 W !,"STATUS" I $G(FLAG)=0 W !,"COMMENTS"
 I $G(FLAG)=1,$G(FLG)=1 W !,"COMMENTS"
 I $G(FLAG)=1 W !,"DOC-REF #",?20,"RECONCILED $AMT",?40,"RECONCILE VENDOR",?67,"FINAL CHARGE"
 W ! F I=1:1:8 W "----------"
 W !,"BUYER: ",Z0
 S P=P+1
 QUIT
