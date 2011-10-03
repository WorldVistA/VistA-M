PRCHRP3 ;WISC/KMB/CR SUMMARY OF UNPAID PURCHASE CARDS ;7/15/98  8:43 AM
 ;;5.1;IFCAP;**8,131,149**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
UNPAID ;   create summary report of unpaid purchase card orders
 N P,PRC,ARR,XXZ,EX,I,CP,HDATE,ZP,TOT,AMT,ZTR,ZTR0,ZTR1,NOTASK
 ;PRC*5.3*149 insures NOTASK is set for tasked job to avoid undefined
 S NOTASK=0
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))  Q:$G(X)="^"
 W !,"Please select a device for display/print of this report.",!
 S %ZIS("B")="",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="REPORT^PRCHRP3",ZTSAVE("*")="" D ^%ZTLOAD,^%ZISC QUIT
 S NOTASK=1 W !,"COMPILING."
 D REPORT,^%ZISC QUIT
 ;
REPORT ;
 K ^TMP($J) S (EX,P)=1
 F I=24,29,32,34,37,38,40,41,45,50,51 S ARR(I)=""
 S ZP="" F I=1:1 S ZP=$O(^PRC(442,"F",25,ZP)) Q:ZP=""  W:NOTASK=1&(I#5000=0) "." D
 .S ZTR0=$G(^PRC(442,ZP,0))
 .I $D(PRC("SITE")) Q:$P(ZTR0,"-")'=PRC("SITE")
 .S ZTR1=+$P($G(^PRC(442,ZP,7)),"^") Q:ZTR1=""
 .S ZTR1=$P($G(^PRCD(442.3,ZTR1,0)),"^",2) Q:$D(ARR(ZTR1))
 .S AMT=$P($G(^PRC(442,ZP,0)),"^",15)
 .S CP=$P($G(^PRC(442,ZP,0)),"^",3),CP=+$P(CP," ")
 .Q:CP=0
 .S:'$D(^TMP($J,CP)) ^TMP($J,CP)=0 S ^TMP($J,CP)=^TMP($J,CP)+AMT
 I '$D(^TMP($J)) S P=1 D HEADER1 W !!!!,?10,"*** NO RECORDS TO PRINT ***" Q
 S CP="" F  S CP=$O(^TMP($J,CP)) Q:CP=""  Q:EX="^"  D
 .D:P=1 HEADER1
 .W !,"CONTROL POINT: ",CP,?40,"TOTAL: $",$J(^TMP($J,CP),0,2)
 .I (IOSL-$Y)<6 D HOLD1 Q:EX["^"
 QUIT
 ;
HOLD1 G HEADER1:$E(IOST)="P"!(IO'=IO(0)) W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ="^" EX="^" S:'$T EX="^" D:EX'="^" HEADER1 Q
 ;
HEADER1 ;
 W @IOF
 D NOW^%DTC S Y=$P(%,".") D DD^%DT S HDATE=Y
 W !,"UNPAID PURCHASE CARD TRANSACTION BY FCP - SUMMARY",?55,HDATE,?70,"PAGE ",P
 W:$D(PRC("SITE")) !,?15,"STATION #: "_PRC("SITE")
 W ! F I=1:1:8 W "----------"
 S P=P+1
 QUIT
 ;
CANDEL ;cancel delivery card transaction
 N FLG S FLG=1
CAN ;cancel purchase card transaction
 N I,TMP1,CREF,CPREF,LABEL,KDA,ZIP,DA,KX,KY D ST^PRCHE Q:'$D(PRC("SITE"))
 S DIC("A")="P.O./REQ. NO.: ",DIC(0)="AEMQZ",D="C",DIC("S")="I $P(^(0),""^"",2)=25,$P(^(12),""^"",2)="""",$P(^(7),""^"")<80,$P(^(7),""^"")'=45",DIC="^PRC(442,"
 I $G(FLG)=1 S DIC("S")="I $P(^(0),""^"",2)=1,$P(^(12),""^"",2)="""",$P(^(7),""^"")<80"
 W !! D IX^DIC K DIC Q:+Y<0  S (DA,KDA)=+Y
 S LABEL="CAN" S:$G(FLG)=1 LABEL="CANDEL" S CPREF=$P($G(^PRC(442,KDA,0)),"^",3),CPREF=+$P(CPREF," "),ZIP=$O(^PRC(420,"A",DUZ,PRC("SITE"),CPREF,0))
 I ZIP="" W !,"You are not a user for this transaction's control point." G @LABEL
 D START^PRCH410
 S TMP1=$P(^PRC(442,KDA,0),"^",15)
 S X=$O(^PRCD(442.3,"C",45,0)),$P(^PRC(442,KDA,0),"^",15,16)="0^0" K ^(9) S (KX,KY)=45,DA=KDA
 Q:$G(^PRCD(442.3,KY,0))=""
 L +^PRC(442,KDA):5 E  W !!,$C(7),?8,"Another user is editing this entry, try later." K KDA Q
 S X=Y,DIE="^PRC(442,",DR=".5////"_KY D ^DIE L -^PRC(442,KDA) K DIE,DR,X,Y,DA,DIC
 L +^PRCS(410,CCDA):5 E  W !!,$C(7),?8,"Another user is editing this entry, try later." K CCDA Q
 S DIE="^PRCS(410,",DA=CCDA,DR="20///^S X=TMP1"_";"_"27///^S X=TMP1"_";"_"451////^S X=""""" D ^DIE
 S $P(^PRCS(410,CCDA,10),U,3)="",$P(^PRCS(410,CCDA,1),U,2)="" I $P($G(^PRCS(410,CCDA,4)),U,5)'="" K ^PRCS(410,"D",$P(^PRCS(410,CCDA,4),U,5),CCDA)
 S $P(^PRCS(410,CCDA,4),U,5)=""
 I $D(^PRC(442,KDA,4,0)) S CCNUM=$P($G(^(0)),"^",4) D
 .Q:CCNUM=""  F I=1:1:CCNUM S ^PRCS(410,CCDA,"RM",I,0)=^PRC(442,KDA,4,I,0)
 .S ^PRCS(410,CCDA,"RM",0)="^442.04^"_CCNUM_"^"_CCNUM
 S CREF=$P($G(^PRCS(410,CCDA,0)),"^") W !!,"Use transaction ",CREF," to access this record",!,"from your fund control point." H 3
 W !!,$C(7),"Conversion completed." L -^PRCS(410,CCDA) K CCNUM,CCDA,DA
 QUIT
 ;
R1 S FLG=1
R2 S:$G(FLG)'=1 FLG=2
R3 K FLAG D START^PRCHRP5 K FLG,FLAG QUIT
UR1 S FLG=1
UR2 S:$G(FLG)'=1 FLG=2
UR3 K FLAG D START1^PRCHRP5 K FLG,FLAG QUIT
