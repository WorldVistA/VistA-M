FHADR10 ; HISC/NCA - Dietetic Equipment ;1/5/94  14:30
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Enter/Edit Dietetic Equipment
 D YR^FHADR1 G:'PRE KIL
 S X1=PRE,X2=-356 D C^%DTC S OLD=$E(X,1,4)_"400" I $O(^FH(117.3,PRE,"EQUI",0))<1 D S1
 K DIC,DIE W ! S DIE="^FH(117.3,",DA=PRE,DR="38:39"
 D ^DIE K DA,DIC,DIE,DR S OLD=PRE
SET ; Set all three quarters with the Dietetic Equipment Data
 F QTR=2:1:4 S PRE=$E(OLD,1,4)_QTR_"00" D S1
KIL G KILL^XUSCLEAN
S1 S TIT="EQUI"
 I $O(^FH(117.3,OLD,TIT,0))>0 K ^FH(117.3,PRE,TIT) D
 .S $P(^FH(117.3,PRE,3),"^",1)=$P($G(^FH(117.3,OLD,3)),"^",1)
 .I '$D(^FH(117.3,PRE,TIT,0)) S ^(0)="^117.338P^^"
 .F K1=0:0 S K1=$O(^FH(117.3,OLD,TIT,K1)) Q:K1<1  S L1=$G(^(K1,0)) D
 ..S ^FH(117.3,PRE,TIT,K1,0)=L1,^FH(117.3,PRE,TIT,"B",+L1,K1)=""
 ..S Z=$G(^FH(117.3,PRE,TIT,0))
 ..S $P(^FH(117.3,PRE,TIT,0),"^",3,4)=K1_"^"_($P(Z,"^",4)+1)
 ..Q
 .Q
 Q
EN2 ; Print the CMR Cost,Dietetic Equipment, and Brand
 D HDR
 S PRE=FHYR_"0000",X1=""
 F L1=PRE:0 S L1=$O(^FH(117.3,L1)) Q:L1<1!($E(L1,1,3)'=$E(PRE,1,3))  I $P($G(^FH(117.3,L1,3)),"^",1)'<1 S X1=L1
 I X1'="" S Z=$P($G(^FH(117.3,X1,3)),"^",1) W !,"CMR Cost",!?2,"Total",?46 S X=Z,X2="0$" D COMMA^%DTC W X
 W !!,"EQUIPMENT",?40,"BRAND",! S X1=""
 F L1=PRE:0 S L1=$O(^FH(117.3,L1)) Q:L1<1!($E(L1,1,3)'=$E(PRE,1,3))  I $P($G(^FH(117.3,L1,"EQUI",0)),"^",3)'="" S X1=L1
 Q:X1=""
 S L2=0 F  S L2=$O(^FH(117.3,X1,"EQUI",L2)) Q:L2<1  D
 .S X=$G(^FH(117.3,X1,"EQUI",L2,0))
 .S Z=$P(X,"^",1),Z=$P($G(^FH(117.4,Z,0)),"^",1),BRD=$P(X,"^",2)
 .W !,Z,?40,BRD
 .Q
 Q
HDR ; Print Heading for Dietetic Equipment
 D:$Y'<21 HDR^FHADRPT
 W !!!,"S E C T I O N  VII   E Q U I P M E N T",!!
 Q
