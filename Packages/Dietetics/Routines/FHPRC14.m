FHPRC14 ; HISC/NCA - Meal Analysis (cont.) ;4/11/95  15:57
 ;;5.5;DIETETICS;;Jan 28, 2005
PD ; Store Meal and Production Diet of menu on Local Array
 F K=0:0 S K=$O(^FHUM(MENU,1,K)) Q:K<1  F K1=0:0 S K1=$O(^FHUM(MENU,1,K,1,K1)) Q:K1<1  S Y=$G(^(K1,0)),M1=$P(Y,"^",2),PD=$P(Y,"^",3) D P1
 Q
P1 S $P(M(K),"^",K1)=$S(M1'="":+M1,1:"")_";"_$S(PD'="":+PD,1:"")_"~"_$P($G(^FH(116.2,+PD,0)),"^",2)
 Q
SRCH ; Search for Recipes of a Meal for a Production Diet
 K ^TMP($J,"RECIPES",DAY,MEAL) Q:'M1  S ^TMP($J,"RECIPES",DAY,MEAL,0)=M1_"^"_PD
 F REC=0:0 S REC=$O(^FH(116.1,M1,"RE",REC)) Q:REC<1  S Y=$G(^(REC,0)) D
 .F CAT=0:0 S CAT=$O(^FH(116.1,M1,"RE",REC,"R",CAT)) Q:CAT<1  S MCA=$G(^(CAT,0)) D
 ..S LIST=$P(MCA,"^",2) I LIST[CODE S ^TMP($J,"RECIPES",DAY,MEAL,+Y)=1_"^"_$P($G(^FH(114,+Y,0)),"^",14)
 ..Q
 .Q
 Q
LIS ; List Recipes in the Meal for a Production Diet
 I $O(^TMP($J,"RECIPES",DAY,MEAL,0))="" W !!,"No Recipes in this Meal for this Production Diet" Q
 K N S ANS="" F LL=0:0 S LL=$O(^TMP($J,"RECIPES",DAY,MEAL,LL)) Q:LL<1  S X=$P($G(^FH(114,+LL,0)),"^",1),N(X)=""
 S CTR=0 W !! S LL="" F  S LL=$O(N(LL)) Q:LL=""  S CTR=CTR+1 W !,LL I CTR=20 D PAUSE Q:ANS="^"  S CTR=0
 K N Q
L1 ; List Meals of each day for the Menu
 S CTR=0,ANS="" F L=0:0 S L=$O(M(L)) Q:L=""  S STR=$G(M(L)) W !!,"Day ",L,! S CTR=CTR+1 D L2 I CTR=2 D PAUSE Q:ANS="^"  S CTR=0
 Q
L2 F LL=1:1:6 S Y=$P(STR,"^",LL) I Y'="" W !,"Meal ",LL,?8,$S($P(Y,"~",2)'="":$P(Y,"~",2),1:""),?12,$S(+Y:$P($G(^FH(116.1,+Y,0)),"^",1),1:"")
 Q
OLD ; Get old Recipes and Food Nutrient stored
 Q:'M1  S ^TMP($J,"RECIPES",DAY,MEAL,0)=M1_"^"_PD
 F REC=0:0 S REC=$O(^FHUM(MENU,1,DAY,1,MEAL,2,REC)) Q:REC<1  S Y=$G(^(REC,0)),^TMP($J,"RECIPES",DAY,MEAL,+Y)=$P(Y,"^",2)_"^"_$P($G(^FH(114,+Y,0)),"^",14)
 Q
PAUSE ; Pause to Scroll
 R !!,"Press RETURN to Continue ",X:DTIME W @IOF S:'$T!(X["^") ANS="^" Q:ANS="^"  I "^"'[X W !,"Enter a RETURN to Continue." G PAUSE
 Q
RET ; Retrieve the Stored Menu
 F K=0:0 S K=$O(^FHUM(MENU,1,K)) Q:K<1  F K1=0:0 S K1=$O(^FHUM(MENU,1,K,1,K1)) Q:K1<1  S L1=$G(^FHUM(MENU,1,K,1,K1,0)) D A1
 Q
A1 S M1=$P(L1,"^",2),PD=$P(L1,"^",3) Q:'M1
 S ^TMP($J,"RECIPES",K,K1,0)=M1_"^"_PD
 S REC=0
A2 S REC=$O(^FHUM(MENU,1,K,1,K1,2,REC)) Q:REC<1  S Y=$G(^(REC,0)),NP=$P($G(^FH(114,REC,0)),"^",14) G:'NP A2
 I '$D(^FHUM(MENU,1,K,1,K1,1,NP,0)) G A2
 S ^TMP($J,"RECIPES",K,K1,REC)=$P(Y,"^",2)_"^"_NP
 G A2
Q1 ; Process Meal Analysis
 K ^TMP($J,"D"),^TMP($J,"M"),^TMP($J,"R") S DAY=0
Q2 S DAY=$O(^TMP($J,"RECIPES",DAY)) Q:DAY<1  S M1=0,(D(1),D(2),D(3),D(4),D(5))=""
Q3 S M1=$O(^TMP($J,"RECIPES",DAY,M1)) I M1<1 S ^TMP($J,"D",DAY,1)=D(1),^(2)=D(2),^(4)=D(4),^(5)=D(5) G Q2
 S REC=0,(T(1),T(2),T(3),T(4))=""
ANAL ; Analyze
 K A S (AMT,PW)=0 F KK=1:1:66 S A(KK)=0
 S REC=$O(^TMP($J,"RECIPES",DAY,M1,REC)) I REC<1 S ^TMP($J,"M",DAY,M1,1)=T(1),^(2)=T(2),^(4)=T(4) D ADD^FHNU9 G Q3
 S S1=$G(^TMP($J,"RECIPES",DAY,M1,REC)),SVG=+S1
 I '$D(^FH(114,REC,0))!('SVG) G ANAL
 S RNAM=$E($P($G(^FH(114,REC,0)),"^",1),1,18),K1=$P(S1,"^",2) G:'K1 ANAL
 S AMT=$P($G(^FHNU(K1,0)),"^",4) G:'AMT ANAL S AMT=AMT*SVG,PW=PW+AMT,AMT=AMT/100
 S Y=$G(^FHNU(K1,1)) F K=1:1:20 S Z1=$P(Y,"^",K) S:Z1="" $P(D(5),"^",K)=1 I Z1 S A(K)=$J(Z1*AMT,0,3),$P(T(1),"^",K)=$P(T(1),"^",K)+A(K)
 S Y=$G(^FHNU(K1,2)) F K=21:1:38 S Z1=$P(Y,"^",K-20) S:Z1="" $P(D(5),"^",K)=1 I Z1 S A(K)=$J(Z1*AMT,0,3),$P(T(2),"^",K-20)=$P(T(2),"^",K-20)+A(K)
 S Y=$G(^FHNU(K1,4)) F K=65,66 S Z1=$P(Y,"^",K-56) S:Z1="" $P(D(5),"^",K)=1 I Z1 S A(K)=$J(Z1*AMT,0,3),$P(T(4),"^",K-56)=$P(T(4),"^",K-56)+A(K)
 S:'$D(^TMP($J,"R",DAY,M1,RNAM,0)) (^(0),^(1),^(2),^(3),^(4))=""
 S $P(^TMP($J,"R",DAY,M1,RNAM,0),"^",1,2)=SVG_"^"_PW
 F K=1:1:20 S $P(^TMP($J,"R",DAY,M1,RNAM,1),"^",K)=A(K)
 F K=21:1:38 S $P(^TMP($J,"R",DAY,M1,RNAM,2),"^",K-20)=A(K)
 F K=65,66 S $P(^TMP($J,"R",DAY,M1,RNAM,4),"^",K-56)=A(K)
 G ANAL
