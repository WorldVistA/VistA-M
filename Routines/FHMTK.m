FHMTK ; HISC/REL/NCA - Enter/Edit Diet Patterns ;12/6/00  15:15
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;last edited NOV 27,2000
 S FLG=0 K ^TMP($J)
F0 K DI S N1=0,ANS=""
F1 W ! K DIC S DIC="^FH(111,",DIC(0)="AEQMZ" D ^DIC K DIC G KIL:X[U!$D(DTOUT),F5:X="",F1:Y<1
 S PREC=$P(Y(0),U,4) I PREC,$D(DI(PREC)) W *7,!!,"This conflicts with ",$P(DI(PREC),"^",2),! G F1
 S N1=N1+1,DI(PREC)=+Y_"^"_Y(0) G F5:+Y=1,F1:N1<5 W *7,!!,"You have now selected the maximum of 5 Diet Modifications!"
F5 I 'N1,'FLG G KIL
 I 'N1 D CLEANTMP^FHMTK8 D ^FHMTK7 G KIL ;P30
 I N1>1 D  I CHK W !!,"You can not order REGULAR with another Diet." G F0
 .S CHK=0 F D0=0:0 S D0=$O(DI(D0)) Q:D0=""  I +DI(D0)=1 S CHK=1 Q
 .Q
 W !!,"You have selected the following Diet:",!
 F D0=0:0 S D0=$O(DI(D0)) Q:D0=""  W !?5,$P(DI(D0),U,2)
F9 R !!,"Is this Correct? Y// ",Y:DTIME G:'$T!(Y="^") KIL S:Y="" Y="Y" S X=Y D TR^FH S Y=X
 I $P("YES",Y,1)'="",$P("NO",Y,1)'="" W *7,!,"  Answer YES to accept diet list; NO to select diets again" G F9
 I Y'?1"Y".E W !!,"Select new diets ..." G F0
 S FHOR="^^^^",N1=0 F D0=0:0 S D0=$O(DI(D0)) Q:D0=""  S N1=N1+1,$P(FHOR,U,N1)=+DI(D0)
 S Y="" F A1=1:1:5 S D3=$P(FHOR,"^",A1) Q:'D3  S:Y'="" Y=Y_", " S Y=Y_$P(^FH(111,D3,0),"^",7)
 S DA=$O(^FH(111.1,"AB",FHOR,0)) G:DA F09
 K DIC,DD,DO S DIC="^FH(111.1,",DIC(0)="L",X=Y D FILE^DICN S DA=+Y
 S $P(^FH(111.1,DA,0),"^",2,6)=FHOR,^FH(111.1,"AB",FHOR,DA)=""
F09 D NEWTMP^FHMTK8 ;P30
 S FHDA=DA D TRAN G:ANS="^" KIL K A1
 D CODE I Z,'$P($G(^FH(111.1,FHDA,0)),"^",7) S $P(^FH(111.1,FHDA,0),"^",7)=Z
F10 K DIC,DIE W ! S DIE="^FH(111.1,",DA=FHDA,DR="10:99" D ^DIE K DIC,DIE,DR
 I $P($G(^FH(111.1,FHDA,0)),"^",7)="" S DIK="^FH(111.1,",DA(1)=111.1,DA=FHDA D ^DIK W *7,!,"<Pattern deleted>" K DIK,DA,^FH(111.1,"AB",FHOR,FHDA)
 S FLG=1 G F0
KIL K ^TMP($J) G KILL^XUSCLEAN
CODE ; Recode diet
 S Z=0 Q:"^^^^"[FHOR  I FHOR="1^^^^" S Z=1 G C1
 S M="^" F K1=1:1:5 S Z=$P(FHOR,"^",K1) Q:Z<1  S M=M_+$P(^FH(111,Z,0),"^",5)_"^"
 F LC=0:0 S LC=$O(^FH(116.2,"AR",LC)) Q:LC<1  S X=^(LC) F K1=1:1 S X1=$P(X,"^",K1) Q:X1<1  D REC G:Z C1
 S Z=0
C1 Q
REC S Z=$P(X1,":",1),X1=$P(X1,":",2) F K2=1:1 S C=$P(X1," ",K2) Q:C<1  G:M'[("^"_C_"^") R1
 Q
R1 S Z=0 Q
TRAN R !!,"Do you want to import Recipe Categories from another Diet Pattern? N // ",X:DTIME
 I '$T!(X["^") S ANS="^" Q
 S:X="" X="N" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,!,"  Answer YES or NO" G TRAN
 S ANS=X?1"Y".E Q:'ANS
T1 W ! K DIC S DIC="^FH(111.1,",DIC(0)="AEMQ" D ^DIC K DIC
 I "^"[X!($D(DTOUT)) S ANS="^" Q
 G:Y<1 T1 S FHD=+Y
 L +^FH(111.1,FHDA,0)
 S SF=$P($G(^FH(111.1,FHD,0)),"^",8),$P(^FH(111.1,FHDA,0),"^",8)=SF
 S:'$D(^FH(111.1,FHDA,"B",0)) ^(0)="^111.115P^^"
 S:'$D(^FH(111.1,FHDA,"N",0)) ^(0)="^111.116P^^"
 S:'$D(^FH(111.1,FHDA,"E",0)) ^(0)="^111.117P^^"
 F MEAL="B","N","E" F LP=0:0 S LP=$O(^FH(111.1,FHD,MEAL,LP)) Q:LP<1  S L1=$G(^(LP,0)) D ADD
 S:'$D(^FH(111.1,FHDA,"BS",0)) ^(0)="^111.11P^^"
 S:'$D(^FH(111.1,FHDA,"NS",0)) ^(0)="^111.12P^^"
 S:'$D(^FH(111.1,FHDA,"ES",0)) ^(0)="^111.13P^^"
 F MEAL="BS","NS","ES" F LP=0:0 S LP=$O(^FH(111.1,FHD,MEAL,LP)) Q:LP<1  S L1=$G(^(LP,0)) D ADD
 S:'$D(^FH(111.1,FHDA,"RES",0)) ^(0)="^111.119P^^"
 S MEAL="RES" F LP=0:0 S LP=$O(^FH(111.1,FHD,MEAL,LP)) Q:LP<1  S L1=$G(^(LP,0)) D ADD
 L -^FH(111.1,FHDA,0) W !,"..Done" Q
ADD I $D(^FH(111.1,FHDA,MEAL,"B",+L1)) Q
A S FHX1=$G(^FH(111.1,FHDA,MEAL,0)),FHX2=$P(FHX1,"^",3)+1
 S $P(^FH(111.1,FHDA,MEAL,0),"^",3)=FHX2
 I $D(^FH(111.1,FHDA,MEAL,FHX2,0)) G A
 S $P(^FH(111.1,FHDA,MEAL,0),"^",4)=($P(FHX1,"^",4)+1)
 S ^FH(111.1,FHDA,MEAL,FHX2,0)=+L1_"^"_$P(L1,"^",2)
 S ^FH(111.1,FHDA,MEAL,"B",+L1,FHX2)=""
 Q
 ;
