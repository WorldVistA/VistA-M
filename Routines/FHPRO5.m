FHPRO5 ; HISC/REL - Recipe Preparation ;7/18/94  16:39 
 ;;5.5;DIETETICS;**3**;Jan 28, 2005
 ;RVD 5/23/05 0 - as part of AFP project.
 I FHP3="Y"!(FHP4="Y") D Q1 D:FHP3="Y" Q2 D:FHP4="Y" ^FHPRO6
 D:FHP5="Y" ^FHPRO7 Q
Q1 ; Set-up Recipe Prep and Storeroom scratch global
 K R S K4="" F K=0:0 S K4=$O(^TMP($J,"FH","T",K4)) Q:K4=""  F L1=0:0 S L1=$O(^TMP($J,"FH","T",K4,L1)) Q:L1<1  S:'$D(R(L1)) R(L1)=0 S R(L1)=R(L1)+^(L1)
G1 F K1=0:0 S K1=$O(R(K1)) Q:K1<1  D P3
 G:$O(R(""))'="" G1
 Q
P3 S X0=$G(^FH(114,K1,0)),P1=R(K1),MUL=$P(X0,"^",2) K R(K1) Q:'MUL  S MUL=P1/MUL
 S S1=$P(X0,"^",12) S:S1 S1=$P($G(^FH(114.2,S1,0)),"^",3)
 S S1=$S(S1<1:99,S1<10:"0"_S1,1:S1)_$E($P(X0,"^",1),1,28)
 I FHP3="Y" S:$D(^TMP($J,"FH","I",S1,K1))#2=0 ^TMP($J,"FH","I",S1,K1)=0 S ^(K1)=^(K1)+P1
 F KK=0:0 S KK=$O(^FH(114,K1,"I",KK)) Q:KK<1  S Y=^(KK,0) D P4
 F KK=0:0 S KK=$O(^FH(114,K1,"R",KK)) Q:KK<1  S Y=^(KK,0) D P6
 Q
P4 S X1=+Y,Q=$P(Y,"^",2)*MUL
 S Y0=$G(^FHING(X1,0))
 S S2=$P(Y0,"^",12) S:S2 S2=$P($G(^FH(113.1,S2,0)),"^",3)
 S S2=$S(S2<1:99,S2<10:"0"_S2,1:S2)_$E($P(Y0,"^",1),1,28) G:FHP3'="Y" P5
 S:'$D(^TMP($J,"FH","I",S1,K1,S2,X1)) ^TMP($J,"FH","I",S1,K1,S2,X1)=0 S ^(X1)=^(X1)+Q
P5 Q:FHP4'="Y"
 S:'$D(^TMP($J,"FH","S",S2,X1,S1,K1)) ^TMP($J,"FH","S",S2,X1,S1,K1)=0 S ^(K1)=^(K1)+Q Q
P6 S P1=$P(Y,"^",2)*MUL S:'$D(R(+Y)) R(+Y)=0 S R(+Y)=R(+Y)+P1 Q
Q2 ; Print Recipe Preparation
 S OLD="",R1="" I $P(FHPAR,"^",4)'="Y" S PG=0 D HDR
S1 S R1=$O(^TMP($J,"FH","I",R1)) I R1="" W ! Q
 F K1=0:0 S K1=$O(^TMP($J,"FH","I",R1,K1)) Q:K1<1  S TOT=^(K1),FLG=0,R2="",X0=^FH(114,K1,0) D S2
 G S1
S2 I $P(FHPAR,"^",4)="Y",OLD'=$E(R1,1,2) S OLD=$E(R1,1,2),PG=0 D HDR
S3 S R2=$O(^TMP($J,"FH","I",R1,K1,R2)) Q:R2=""
 F X1=0:0 S X1=$O(^TMP($J,"FH","I",R1,K1,R2,X1)) Q:X1<1  D S4
 G S3
S4 D:$Y>(IOSL-7) HDR W ! G:FLG S5 W !,$P(X0,"^",1) S FLG=1
 I $P(FHPAR,"^",4)'="Y" S Z=$P(X0,"^",12) S:Z Z=$P(^FH(114.2,Z,0),"^",2) W:Z'="" " (",Z,")"
 W ?39,$J(TOT,5,0)
S5 S (Y,I1)=^TMP($J,"FH","I",R1,K1,R2,X1)
 S Y(0)=$G(^FHING(X1,0)),UNT=$P(Y(0),"^",16) D EN2^FHREC1
 W ?46,$E($P(Y(0),"^",1),1,42),?90,Y S I2=$P(Y(0),"^",17) Q:'I2  S I1=I1/I2 Q:'I1
 S I1=+$J(I1,0,1) W ?113,I1," ",$P(Y(0),"^",6) Q
B0 S LAB=$P(FHPAR,"^",10),R2=LAB=2*5+32
 F KK=0:0 S KK=$O(^TMP($J,"FH","I",KK)) Q:KK<1  F K1=0:0 S K1=$O(^TMP($J,"FH","I",KK,K1)) Q:K1<1  D B1
 F X1=1:1:18 W !
 Q
B1 F X1=0:0 S X1=$O(^TMP($J,"FH","I",KK,K1,X1)) Q:X1<1  S (Y,I1)=^(X1) D B2
 Q
B2 S Y(0)=^FHING(X1,0),UNT=$P(Y(0),"^",16) D EN2^FHREC1
 S I2=$P(Y(0),"^",17) Q:'I2  S I1=I1/I2
 S I1=$S(I1<1:1,I1#1<.1:I1\1,1:I1+.9\1)
 W !,$E($P(Y(0),"^",1),1,R2),!!,I1," ",$P(Y(0),"^",6),!!,$E($P(^FH(114,K1,0),"^",1),1,R2),! Q
HDR S PG=PG+1 W @IOF,!,DTP,?48,"R E C I P E   P R E P A R A T I O N",?125,"Page ",PG
 W !,FHRETYP,?(131-$L(FHP6)),FHP6
 W ! D:$P(FHPAR,"^",4)="Y" PRE W ?(132-$L(TIM)\2),TIM
 W !!,"Recipe",?40,"Port. Ingredient",?90,"Quantity",?113,"Storeroom Amount"
 W ! F K=1:1:131 W "-"
 Q
PRE S K=$P(X0,"^",12) S:K K=$P($G(^FH(114.2,K,0)),"^",1)
 W:K'="" K Q
