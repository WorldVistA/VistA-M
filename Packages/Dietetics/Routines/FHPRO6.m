FHPRO6 ; HISC/REL - Storeroom Requisition ;4/25/93  15:59 
 ;;5.5;DIETETICS;**3**;Jan 28, 2005
 ;RVD 5/23/05 - as part of AFP project.
 S OLD="",R2="" I $P(FHPAR,"^",6)'="Y" S PG=0 D HDR
S1 S R2=$O(^TMP($J,"FH","S",R2)) I R2="" W ! Q
 F X1=0:0 S X1=$O(^TMP($J,"FH","S",R2,X1)) Q:X1<1  D S2
 G S1
S2 S Y(0)=$G(^FHING(X1,0)),UNT=$P(Y(0),"^",16),(FLG,TOT)=0
 I $P(FHPAR,"^",6)="Y",OLD'=$E(R2,1,2) S OLD=$E(R2,1,2),PG=0 D HDR
 S R1="" F K4=0:0 S R1=$O(^TMP($J,"FH","S",R2,X1,R1)) Q:R1=""  F K1=0:0 S K1=$O(^TMP($J,"FH","S",R2,X1,R1,K1)) Q:K1<1  S TOT=TOT+^(K1)
 S R1="" F K4=0:0 S R1=$O(^TMP($J,"FH","S",R2,X1,R1)) Q:R1=""  F K1=0:0 S K1=$O(^TMP($J,"FH","S",R2,X1,R1,K1)) Q:K1<1  S Y=^(K1) D S4
 Q
S4 D:$Y>(IOSL-7) HDR W ! G:FLG S5 W !,$P(Y(0),"^",1) S FLG=1 I $P(FHPAR,"^",6)'="Y",$E(R2,1,2)'=99 S Z=$P(Y(0),"^",12) S:Z Z=$P($G(^FH(113.1,Z,0)),"^",2) W:Z'="" " (",Z,")"
 S I2=$P(Y(0),"^",17) G:'I2 S5 S I1=TOT/I2
 S I1=$S(I1<1:1,I1#1<.1:I1\1,1:I1+.9\1) W ?60,I1," ",$P(Y(0),"^",6)
S5 D EN2^FHREC1 W ?80,$P($G(^FH(114,K1,0)),"^",1),?112,$E(Y,1,19) Q
HDR S PG=PG+1 W @IOF,!,DTP,?45,"S T O R E R O O M   R E Q U I S I T I O N",?125,"Page ",PG
 W !,FHRETYP,?(131-$L(FHP6)),FHP6
 W ! D:$P(FHPAR,"^",6)="Y" STO W ?(132-$L(TIM)\2),TIM
 W !!,"Ingredient",?60,"Storeroom Amount",?80,"Recipe",?112,"Quantity"
 W ! F K=1:1:131 W "-"
 Q
STO S K=$P(Y(0),"^",12) S:K K=$P($G(^FH(113.1,K,0)),"^",1)
 W:K'="" K Q
 ;
AFP ;print advance food prep storeroom requesition (grand total)
 D Q1,AS0
 Q
 ;
Q1 ; sets Storeroom scratch global for AFP
 K R S K4="" F K=0:0 S K4=$O(^TMP($J,"AFP","T",K4)) Q:K4=""  F L1=0:0 S L1=$O(^TMP($J,"AFP","T",K4,L1)) Q:L1<1  S:'$D(R(L1)) R(L1)=0 S R(L1)=R(L1)+^(L1)
G1 F K1=0:0 S K1=$O(R(K1)) Q:K1<1  D P3
 G:$O(R(""))'="" G1
 Q
P3 S X0=$G(^FH(114,K1,0)),P1=R(K1),MUL=$P(X0,"^",2) K R(K1) Q:'MUL  S MUL=P1/MUL
 S S1=$P(X0,"^",12) S:S1 S1=$P($G(^FH(114.2,S1,0)),"^",3)
 S S1=$S(S1<1:99,S1<10:"0"_S1,1:S1)_$E($P(X0,"^",1),1,28)
 S:$D(^TMP($J,"AFP","I",S1,K1))#2=0 ^TMP($J,"AFP","I",S1,K1)=0 S ^(K1)=^(K1)+P1
 F KK=0:0 S KK=$O(^FH(114,K1,"I",KK)) Q:KK<1  S Y=^(KK,0) D P4
 F KK=0:0 S KK=$O(^FH(114,K1,"R",KK)) Q:KK<1  S Y=^(KK,0) D P5
 Q
P4 S X1=+Y,Q=$P(Y,"^",2)*MUL
 S Y0=$G(^FHING(X1,0))
 S FHSTR="MISCELLANEOUS"
 I $P(Y0,"^",12) S FHSTR=$P($G(^FH(113.1,$P(Y0,"^",12),0)),"^")
 S S2=$P(Y0,"^",12) S:S2 S2=$P($G(^FH(113.1,S2,0)),"^",3)
 S S2=$S(S2<1:99,S2<10:"0"_S2,1:S2)_$E($P(Y0,"^",1),1,28) ;G:FHP3'="Y" P5
 S:'$D(^TMP($J,"AFP","I",S1,K1,S2,X1)) ^TMP($J,"AFP","I",S1,K1,S2,X1)=0 S ^(X1)=^(X1)+Q
P5 ;Q:FHP4'="Y"
 S:'$D(^TMP($J,"AFP","S",FHSTR,S2,X1,S1,K1)) ^TMP($J,"AFP","S",FHSTR,S2,X1,S1,K1)=0 S ^(K1)=^(K1)+Q
 Q
 ;prints
AS0 S (FH1,R2)="",PG=0
AST F  S FH1=$O(^TMP($J,"AFP","S",FH1)) Q:FH1=""  S FH2="" F  S FH2=$O(^TMP($J,"AFP","S",FH1,FH2)) Q:FH2=""  D:'$G(PG) AHDR D
 .F FH3=0:0 S FH3=$O(^TMP($J,"AFP","S",FH1,FH2,FH3)) Q:FH3'>0  D AS2
 Q
 ;
AS1 S R2=$O(^TMP($J,"AFP","S",R2)) I R2="" G AST
 F X1=0:0 S X1=$O(^TMP($J,"AFP","S",FHS1,R2,X1)) Q:X1'>0  D AS2
 G AS1
 ;
AS2 S Y(0)=$G(^FHING(FH3,0)),UNT=$P(Y(0),"^",16),(FLG,TOT)=0
 ;I $P(FHPAR,"^",6)="Y",OLD'=$E(R2,1,2) S OLD=$E(R2,1,2),PG=0 D AHDR
 S R1="" F K4=0:0 S R1=$O(^TMP($J,"AFP","S",FH1,FH2,FH3,R1)) Q:R1=""  F K1=0:0 S K1=$O(^TMP($J,"AFP","S",FH1,FH2,FH3,R1,K1)) Q:K1'>0  S TOT=TOT+^(K1)
 S R1="" F K4=0:0 S R1=$O(^TMP($J,"AFP","S",FH1,FH2,FH3,R1)) Q:R1=""  F K1=0:0 S K1=$O(^TMP($J,"AFP","S",FH1,FH2,FH3,R1,K1)) Q:K1'>0  S Y=^(K1) D AS4
 Q
AS4 D:$Y>(IOSL-7) AHDR W ! G:FLG AS5 W !,$P(Y(0),"^",1) S FLG=1 ;I $P(FHPAR,"^",6)'="Y",$E(R2,1,2)'=99 S Z=$P(Y(0),"^",12) S:Z Z=$P($G(^FH(113.1,Z,0)),"^",2) W:Z'="" " (",Z,")"
 ;S Z=$P(Y(0),"^",12) S:Z Z=$P($G(^FH(113.1,Z,0)),"^",2) W:Z'="" " (",Z,")"
 S I2=$P(Y(0),"^",17) G:'I2 AS5 S I1=TOT/I2
 S I1=$S(I1<1:1,I1#1<.1:I1\1,1:I1+.9\1)
 S I1=+$J(I1,0,1)
 S I1=$S($L(I1)=1:"      "_I1,$L(I1)=2:"     "_I1,$L(I1)=3:"    "_I1,$L(I1)=4:"   "_I1,$L(I1)=5:"  "_I1,$L(I1)=6:" "_I1,1:I1)
 W ?51,I1," ",$P(Y(0),"^",6)
AS5 D EN2^FHREC1
 S FHYQU=$P(Y," ",1),FHYQUNA=$E(Y,$L(FHYQU)+1,$L(Y))
 W ?76,$P($G(^FH(114,K1,0)),"^",1)
 W ?105,$J(FHYQU,6,0),?111,FHYQUNA
 ;W ?80,$P($G(^FH(114,K1,0)),"^",1),?112,$E(Y,1,19) Q
 Q
 ;
AHDR S PG=PG+1 W @IOF,!,DTP,?40,"A F P  S T O R E R O O M   R E Q U I S I T I O N",?125,"Page ",PG
 W !,FHRETYP,?(131-$L(FHP6)),FHP6
 W !,FH1
 ;W ! D:$P(FHPAR,"^",6)="Y" STO W ?(132-$L(TIM)\2),TIM
 W ?(132-$L(TIMAFP)\2),TIMAFP
 W !!,"Ingredient",?56,"Storeroom Amount",?76,"Recipe",?108,"Quantity"
 W ! F K=1:1:131 W "-"
 Q
