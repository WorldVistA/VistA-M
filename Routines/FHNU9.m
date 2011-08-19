FHNU9 ; HISC/REL/NCA - Nutrient Analysis Utilities ;7/29/94  11:54 
 ;;5.5;DIETETICS;;Jan 28, 2005
RDA ; Calculate RDA values
 S ZR=^FH(112.2,RDA,1),KK=1
R1 S NODE=$E(NUT,KK) Q:'NODE  S ITM=+$E(NUT,KK+1,KK+2) Q:'ITM  S SIZ=$E(NUT,KK+3),Q=+$E(NUT,KK+5,KK+6),KK=KK+7 I 'Q S Q=$J("",SIZ) G R2
 S Z1=$S(NODE=1:$P(X1,"^",ITM),NODE=2:$P(X2,"^",ITM-20),NODE=3:$P(X3,"^",ITM-38),1:$P(X4,"^",ITM-56))
 S Q=$J($S($P(ZR,"^",Q):Z1/$P(ZR,"^",Q)*100,1:""),SIZ,0)
R2 W Q G R1
TOT ; Calculate total nutrient values
 K ^TMP($J) S DAY=0
T1 S DAY=$O(^FHUM(MENU,1,DAY)) Q:DAY<1  S MEAL=0,(D(1),D(2),D(3),D(4),D(5))=""
T2 S MEAL=$O(^FHUM(MENU,1,DAY,1,MEAL)) I MEAL<1 S ^TMP($J,"D",DAY,1)=D(1),^(2)=D(2),^(4)=D(4),^(5)=D(5) G T1
 S (ITM,NM)=0,(T(1),T(2),T(3),T(4))=""
T3 S ITM=$O(^FHUM(MENU,1,DAY,1,MEAL,1,ITM)) I ITM<1 S ^TMP($J,"M",DAY,MEAL,1)=T(1),^(2)=T(2),^(4)=T(4) D ADD G T2
 S X=^FHUM(MENU,1,DAY,1,MEAL,1,ITM,0),Y(0)=^FHNU(+X,0),Y(1)=$G(^(1)),Y(2)=$G(^(2)),Y(4)=$G(^(4))
 S AMT=$P(X,"^",2) I TYP="C" S AMT=AMT*$P(Y(0),"^",4)
 S MUL=AMT/100 F K=1:1:20 S Z1=$P(Y(1),"^",K) S:Z1="" $P(D(5),"^",K)=1 I Z1 S Z1=$J(Z1*MUL,0,3),$P(Y(1),"^",K)=Z1,$P(T(1),"^",K)=$P(T(1),"^",K)+Z1
 F K=1:1:18 S Z1=$P(Y(2),"^",K) S:Z1="" $P(D(5),"^",K+20)=1 I Z1 S Z1=$J(Z1*MUL,0,3),$P(Y(2),"^",K)=Z1,$P(T(2),"^",K)=$P(T(2),"^",K)+Z1
 F K=9,10 S Z1=$P(Y(4),"^",K) S:Z1="" $P(D(5),"^",K+56)=1 I Z1 S Z1=$J(Z1*MUL,0,3),$P(Y(4),"^",K)=Z1,$P(T(4),"^",K)=$P(T(4),"^",K)+Z1
 S NM=NM+1,^TMP($J,"I",DAY,MEAL,NM,0)=$E($P(^FHNU(+X,0),"^",1),1,15)_"^"_AMT
 S ^TMP($J,"I",DAY,MEAL,NM,1)=Y(1),^(2)=Y(2),^(4)=Y(4) G T3
ADD ; Calculate Total Nutrient Values For a Day
 F KK=1:1:20 S Z1=$P(T(1),"^",KK) I Z1 S $P(D(1),"^",KK)=$P(D(1),"^",KK)+Z1
 F KK=1:1:18 S Z1=$P(T(2),"^",KK) I Z1 S $P(D(2),"^",KK)=$P(D(2),"^",KK)+Z1
 F KK=9,10 S Z1=$P(T(4),"^",KK) I Z1 S $P(D(4),"^",KK)=$P(D(4),"^",KK)+Z1
 Q
