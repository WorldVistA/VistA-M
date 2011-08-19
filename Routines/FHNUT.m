FHNUT ; HISC/NCA - Read in the and Calculate 100 Grams ;2/23/00  12:38
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Enter Data
 K DIC S FHX1=0,DIC="^FHNU(",DIC(0)="EMZ"
 R !!,"Food Nutrient Name: ",TIT:DTIME G:'$T!("^"[TIT) KIL I TIT'?.ANP W *7,"  ??" G EN1
 S DIC("S")="I $E($P(^(0),U,1),1)'=""*"""
 S X=TIT D ^DIC K DIC G:U[X!($D(DTOUT)) EN1 I Y<1 G:TIT["?" EN1 D ADD G KIL:'FHX1,R2
 S FHX1=+Y I $P($G(^FHNU(FHX1,0)),"^",6)="N" W !!,"  USDA Handbook Values Not Editable" Q
R2 W !!,"Portion Size: " R X:DTIME G:'$T!("^"[X) KIL
 I X'?.N.1".".N!(X<0)!(X>9999) W *7,!,"Enter the gram Portion Size.",!,"Enter a number From 1-9999." G R2
 S POR=X
STOR K A S ANS="" F L=1:1:66 S A(L)=""
 F K=1:1:34 S Y=$T(COM+K^FHNU6),Z1=$P(Y,";",3) G:ANS="^" KIL D:Z1 CALC
 F K=35:1:70 S Y=$T(COM+K^FHNU6),Z1=$P(Y,";",3) G:ANS="^" KIL D:Z1 CALC
 S (Z1,Z2,Z3,Z4)="" S $P(^FHNU(FHX1,0),"^",4)=POR F K=1:1:20 S $P(Z1,"^",K)=A(K)
 F K=21:1:38 S $P(Z2,"^",K-20)=A(K)
 F K=39:1:56 S $P(Z3,"^",K-38)=A(K)
 F K=57:1:66 S $P(Z4,"^",K-56)=A(K)
 S ^FHNU(FHX1,1)=Z1,^(2)=Z2 S:Z3'="" ^FHNU(FHX1,3)=Z3 S:Z4'="" ^FHNU(FHX1,4)=Z4
 G EN1
KIL G KILL^XUSCLEAN
ADD ; Add the new entry
 W !!,"ADD ",TIT," as a New Entry? Y// " R X:DTIME Q:'$T!(X="^")  S:X="" X="Y" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Answer YES or NO" G ADD
 S X=$E(X,1) Q:X="N"
 K DIC,DD,DO,X S (DIC,DIE)="^FHNU(",DIC(0)="L",DLAYGO=112
A L +^FHNU(0) S DA=$P(^FHNU(0),"^",3)+1 I $D(^FHNU(DA)) S $P(^FHNU(0),"^",3)=DA L -^FHNU(0) G A
 S X=TIT D FILE^DICN L -^FHNU(0) S FHX1=+Y K DIC,DLAYGO
 S DA=+Y,DR=".01;2;4:5;7;98;99" S:$D(^XUSEC("FHMGR",DUZ)) DIDEL=112 D ^DIE S:$D(DTOUT)!($D(Y))!('$D(DA)) FHX1=0 K DA,DIE,DR,Y
 Q
CALC ; Read in Food Nutrient and Calculate 100 gms
 W !,$P(Y,";",4)_": " R X:DTIME I '$T S ANS="^" Q
 I X["^" W *7,"  Required Field." G CALC
 I X'?.N.1".".N!(X<0)!(X>99999) W *7,"  Enter a number from 0-99999" G CALC
 I X'="" S DEC=$S(Z1>64:2,1:3),A(Z1)=X/POR*100,A(Z1)=$S(A(Z1):+$J(A(Z1),0,DEC),1:0) W "... ",A(Z1)
 Q
