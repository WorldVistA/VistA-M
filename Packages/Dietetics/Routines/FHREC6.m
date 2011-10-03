FHREC6 ; HISC/REL/NCA - Recipe Analysis Output ;7/30/93  15:05 
 ;;5.5;DIETETICS;;Jan 28, 2005
 K DIC S DIC="^FH(114,",DIC(0)="AEQM" W ! D ^DIC G:Y<1 KIL S REC=+Y
 S L1=$P($G(^FH(114,REC,0)),"^",14)
 I 'L1 W !!,"This Recipe has not been analyzed." G FHREC6
 K DIC S DIC="^FH(112.2,",DIC(0)="AEQM",DIC("A")="Select DRI Category: " W ! D ^DIC G:X["^"!$D(DTOUT) KIL S RDA=$S(Y<1:0,1:+Y) K DIC
 K IOP,%ZIS S %ZIS("A")="Print on Device: ",%ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHREC6",FHLST="L1^RDA^REC" D EN2^FH G FHREC6
 U IO D Q1 D ^%ZISC K %ZIS,IOP G FHREC6
Q1 ; List Analysis
 S PW=$P($G(^FHNU(L1,0)),"^",4) Q:'PW
 S Y=$G(^FHNU(L1,1)) F K=1:1:20 S Z1=$P(Y,"^",K) I Z1'="" S A(K)=$J(Z1*PW/100,0,3)
 S Y=$G(^FHNU(L1,2)) F K=21:1:38 S Z1=$P(Y,"^",K-20) I Z1'="" S A(K)=$J(Z1*PW/100,0,3)
 S Y=$G(^FHNU(L1,3)) F K=39:1:56 S Z1=$P(Y,"^",K-38) I Z1'="" S A(K)=$J(Z1*PW/100,0,3)
 S Y=$G(^FHNU(L1,4)) F K=57:1:66 S Z1=$P(Y,"^",K-56) I Z1'="" S A(K)=$J(Z1*PW/100,0,3)
 S ZR=$S(RDA:^FH(112.2,RDA,1),1:""),TIT=$P($G(^FH(114,REC,0)),"^",1),ANS=""
 S Z1=4*A(1)+(9*A(2))+(4*A(3)) S:'Z1 Z1=1 F KK=1,3,2 S C(KK)=$J(A(KK)*$S(KK=2:900,1:400)/Z1,4,0)
 K B F KK=1:1:66 S B(KK)=0
 K M,N F KK=0:0 S KK=$O(^FH(114,REC,"R",KK)) Q:KK<1  S Y0=$G(^(KK,0)) D R1
 F KK=0:0 S KK=$O(^FH(114,REC,"I",KK)) Q:KK<1  S Y0=$G(^(KK,0)) I +Y0 S ER="A",NAM=$P($G(^FHING(+Y0,0)),"^",1) I NAM'="" D GET
 W:$E(IOST,1,2)="C-" @IOF W !?25,"--- Recipe Ingredient List ---",!!?(80-$L(TIT)\2),TIT
 W !!,"Number of Portions: ",$P($G(^FH(114,REC,0)),"^",2)
 W !!,"Ingredient",?34,"Amt In Lbs",?46,"Associated Nutrient",!
 S ER="A",CTR=0 D P1 Q:ANS="^"
 K M(ER) S R2="" F KK=0:0 S R2=$O(N(R2)) Q:R2=""  S ER=$G(N(R2)) W !!,"Embedded Recipe: ",R2,!!,"Ingredient",?34,"Amt In LBS",?46,"Associated Nutrient",! S CTR=CTR+1 D P1 Q:ANS="^"
 D PSE Q:ANS="^"  W @IOF,!?23,"--- Analysis of Recipe Portion ---",!!?(80-$L(TIT)\2),TIT,!!?34,"%",?39,"%",?76,"%",!
 W ?33,"DRI",?37,"Kcal",?75,"DRI",!
 F K=1:1:34 S Y=$T(COM+K^FHNU6),Z1=$P(Y,";",3) D LST
 D PSE Q:ANS="^"  F K=35:1:70 S Y=$T(COM+K^FHNU6),Z1=$P(Y,";",3) D LST
 W !!,"Grams/Portion: ",PW D PSE W ! Q
LST W:K#2 ! Q:'Z1  S T1=$S(K#2:0,1:42)
 W ?T1,$P(Y,";",4)," (",B(Z1),")" I B(Z1) W ?(T1+21),$J(A(Z1),7,$P(Y,";",6))," ",$P(Y,";",5)
 S Z2=$P(Y,";",7) I Z2,ZR'="",$D(A(Z1)) S Z2=A(Z1)/$P(ZR,U,Z2) W ?(T1+33),$J(Z2*100,3,0)
 I $D(C(Z1)) W ?(T1+37),C(Z1)
 Q
R1 ; Embedded Recipe List
 S R1=+Y0 Q:'R1  S R2=$P($G(^FH(114,R1,0)),"^",1) Q:R2=""  S ER=R1 S:'$D(N(R2)) N(R2)=R1
 F LL=0:0 S LL=$O(^FH(114,R1,"I",LL)) Q:LL<1  S Y0=$G(^(LL,0)) I +Y0 S NAM=$P($G(^FHING(+Y0,0)),"^",1) I NAM'="" D GET
 Q
GET ; Set Ingredient List
 S K1=+$P(Y0,"^",3)
 S:'$D(M(ER,NAM)) M(ER,NAM)=$E($P($G(^FHNU(K1,0)),"^",1),1,33)_"^"_$P(Y0,"^",4)
 S Y=$G(^FHNU(K1,1)) F K=1:1:20 S Z1=$P(Y,"^",K) I Z1'="" S B(K)=B(K)+1
 S Y=$G(^FHNU(K1,2)) F K=21:1:38 S Z1=$P(Y,"^",K-20) I Z1'="" S B(K)=B(K)+1
 S Y=$G(^FHNU(K1,3)) F K=39:1:56 S Z1=$P(Y,"^",K-38) I Z1'="" S B(K)=B(K)+1
 S Y=$G(^FHNU(K1,4)) F K=57:1:66 S Z1=$P(Y,"^",K-56) I Z1'="" S B(K)=B(K)+1
 Q
P1 S NAM=""
 F LL=0:0 S NAM=$O(M(ER,NAM)) Q:NAM=""  D  Q:ANS="^"
 .W !,$E(NAM,1,30),?32,$S($P(M(ER,NAM),"^",2):$J($P(M(ER,NAM),"^",2),10,3),1:$J("***",10)),?46,$S($P(M(ER,NAM),"^",1)'="":$P(M(ER,NAM),"^",1),1:"***")
 .S CTR=CTR+1 I CTR>18 D PSE S CTR=0
 .Q
 Q
PSE I IOST?1"C-".E R !!,"Press RETURN to Continue ",X:DTIME W ! S:'$T!(X["^") ANS="^" Q:ANS="^"  I "^"'[X W !,"Enter a RETURN to Continue." G PSE
 Q
KIL G KILL^XUSCLEAN
