FHADR1 ; HISC/NCA - Dietetic Facility Profile ;1/23/98  15:03
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Enter/Edit Facility Data and Specialized Medical Programs
 S (FLG1,FLG2)=0 D YR G:'PRE KIL
 D GET G:Y<1 KIL S FHX1=+Y
 S ST=$G(^DIC(4,+FHX1,0)) Q:ST=""
 S X1=PRE,X2=-356 D C^%DTC S OLD=$E(X,1,4)_"400" I '$D(^FH(117.3,PRE,0)) D S1
E1 W ! K DIR S DIR(0)="YAO",DIR("A")="Enter/Edit Facility Data? " D ^DIR G:$D(DIRUT)!($D(DIROUT)) KIL
 I 'Y K Y G E2
 S FLG1=1 D:FLG1 EDIT S FLG1=0
E2 W ! K DIR S DIR(0)="YAO",DIR("A")="Enter/Edit Specialized Medical Programs? "
 D ^DIR I $D(DIRUT)!($D(DIROUT)) G KIL
 I 'Y K Y S OLD=PRE D SET G KIL
 S FLG2=1 D:FLG2 EDIT
 S OLD=PRE D SET
KIL G KILL^XUSCLEAN
EDIT ; Edit the Fields
 K DIC,DIE W ! S DIE="^FH(117.3,",DA=PRE
 L +^FH(117.3,PRE,0):0 I '$T W !?5,"Another user is editing this entry." G KIL
 I '$D(^FH(117.3,PRE,0)) D
 .S $P(^FH(117.3,PRE,0),"^",1)=PRE,^FH(117.3,"B",PRE,PRE)=""
 .S Z=$G(^FH(117.3,0)),$P(^FH(117.3,0),"^",3,4)=PRE_"^"_($P(Z,"^",4)+1)
 .S ZZ=$P($G(^FH(117.3,OLD,0)),"^",2,13)
 .I ZZ="" S $P(ZZ,"^",2,3)=$P(ST,"^",7)_"^"_$P($G(^DIC(4,+FHX1,"DIV")),"^",1)
 .S $P(^FH(117.3,PRE,0),"^",2,13)=ZZ
 .Q
 S DR=$S(FLG1:"2:11;13;51//Y;S:X'=""Y"" Y="""";52",1:"12;W !;53//Y;S:X'=""Y"" Y=""@1"";54;@1;55//Y;S:X'=""Y"" Y="""";56:57")
 D ^DIE L -^FH(117.3,PRE,0) K DA,DIC,DIE,DR,Z,ZZ Q
SET ; Set all three quarters with the Facility Profile Data
 F QTR=2:1:4 S PRE=$E(OLD,1,4)_QTR_"00" D S1
 Q
S1 ; Process Storage of Facility Profile Data
 Q:'$D(^FH(117.3,OLD,0))
 I '$D(^FH(117.3,PRE,0)) S $P(^FH(117.3,PRE,0),"^",1)=PRE,^FH(117.3,"B",PRE,PRE)="",Z=$G(^FH(117.3,0)),$P(^FH(117.3,0),"^",3,4)=PRE_"^"_($P(Z,"^",4)+1)
 S $P(^FH(117.3,PRE,0),"^",2,26)=$P($G(^FH(117.3,OLD,0)),"^",2,26)
 F TIT="AREA","DELV","SPEC" D
 .I $O(^FH(117.3,OLD,TIT,0))>0 K ^FH(117.3,PRE,TIT) D
 ..I '$D(^FH(117.3,PRE,TIT,0)) S ^(0)=$S(TIT="AREA":"^117.356S^^",TIT="DELV":"^117.313P^^",1:"^117.312P^^")
 ..F K1=0:0 S K1=$O(^FH(117.3,OLD,TIT,K1)) Q:K1<1  S L1=$G(^(K1,0)) D
 ...S ^FH(117.3,PRE,TIT,K1,0)=L1,^FH(117.3,PRE,TIT,"B",+L1,K1)=""
 ...S Z=$G(^FH(117.3,PRE,TIT,0)),$P(^FH(117.3,PRE,TIT,0),"^",3,4)=K1_"^"_($P(Z,"^",4)+1)
 ...Q
 ..Q
 .Q
 Q
GET ; Get the Facility Data from Institution file
 D SITE^FH
 K DIC S DIC="^DIC(4,",DIC(0)="AEMQ",DIC("A")="Enter Station Number: ",DIC("B")=SITE(1),D="D"
 W ! D MIX^DIC1 K DIC,SITE Q:"^"[X!($D(DTOUT))  Q:Y<1
 Q
QR ; Read in Qtr and Year
 S (PRE,QTR)=0 D NOW^%DTC S NOW=%\1
 ;S YR=$E(NOW,2,3),S1=$E(NOW,4,5),QTR=$S(S1<4:1,S1<7:2,S1<10:3,1:4)
 S YR=$E(NOW,1,3)+1700,S1=$E(NOW,4,5),QTR=$S(S1<4:1,S1<7:2,S1<10:3,1:4)
Q1 K %DT W !!,"Enter Qtr/Yr: "_QTR_"/"_YR_"// " R X:DTIME Q:'$T!(X["^")
 I X="" S X=$E(NOW,1,3)_"0"_QTR_"00"
 D ^%DT
 I $E(Y,6,7) W *7,?28,"  Do Not Enter Dates." G Q1
 ;I $E(Y,4,5)<1!($E(Y,4,5)>4)!($E(Y,1,3)>$E(NOW,1,3)) W *7,"  Answer Qtr 1-4 and Yr as Qtr/Yr.",!?28,"  Yr CANNOT be greater than now." G Q1
 I $E(Y,4,5)<1!($E(Y,4,5)>4)!($E(Y,1,3)>$E(NOW,1,3)) D  G Q1
 .W *7,"  Answer Qtr 1-4 and Yr as 4 digit year, ie 2001."
 .W !?28,"  Example:  4/2001 for 4th quarter, year 2001."
 .W !?28,"  Yr CANNOT be greater than now."
 I $E(Y,4,5)>QTR&($E(Y,1,3)=$E(NOW,1,3)) W *7,"  Qtr/Yr must not be greater than default." G Q1
 S YR=$E(Y,2,3),QTR=$E(Y,5),PRE=$E(Y,1,5)_"00" Q
YR ; Read in the Year
 W ! K %DT S PRE="",%DT="AEP",%DT("A")="Enter YR: "
 D ^%DT S:$D(DTOUT) X="^" Q:U[X  G:Y<1 YR
 I $E(Y,1,3)>$E(DT,1,3) W *7,"  Do Not Enter Future Year." G YR
 I $E(Y,4,7)>0 W *7,"  Enter Year Only." G YR
 S Y=$E(Y,1,3)_"0100",PRE=Y Q
