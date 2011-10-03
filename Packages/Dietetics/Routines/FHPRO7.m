FHPRO7 ; HISC/REL - Print Recipes ;3/26/96  15:14
 ;;5.5;DIETETICS;**3**;Jan 28, 2005
 K N,R S K4="" F P0=0:0 S K4=$O(^TMP($J,"FH","T",K4)) Q:K4=""  F L1=0:0 S L1=$O(^TMP($J,"FH","T",K4,L1)) Q:L1<1  D C0
R0 F K1=0:0 S K1=$O(N(K1)) Q:K1<1  K N(K1) D R1
 G:$O(N(""))'="" R0
 F R1=0:0 S R1=$O(R(R1)) Q:R1=""  I $G(^FH(114,R1,0))'="" D:$P(^FH(114,R1,0),"^",8)'="N" R3
 S NX="" F KK=0:0 S NX=$O(^TMP($J,"FH","R",NX)) Q:NX=""  F R1=0:0 S R1=$O(^TMP($J,"FH","R",NX,R1)) Q:R1<1  S S1=R(R1) D EN1^FHREC2
 Q
R1 F KK=0:0 S KK=$O(^FH(114,K1,"R",KK)) Q:KK<1  S Y=^(KK,0) D R2
 Q
R2 S P1=R(K1),MUL=$P(^FH(114,K1,0),"^",2) Q:'MUL  S MUL=P1/MUL
 S P1=$P(Y,"^",2)*MUL S:'$D(R(+Y)) R(+Y)=0 S R(+Y)=R(+Y)+P1 Q
R3 S X=$G(^FH(114,R1,0)),K4=$P(X,"^",12),K4=$S($D(^FH(114.2,+K4,0)):$P(^(0),"^",3),1:99)
 S K4="A"_$S(K4<10:"0"_K4,1:K4)_$E($P(X,"^",1),1,27),^TMP($J,"FH","R",K4,R1)="" Q
C0 S:'$D(R(L1)) R(L1)=0 S R(L1)=R(L1)+^TMP($J,"FH","T",K4,L1),N(L1)="" Q
 ;
 ;PROCESS Advance Food Prep
P3 S TIMAFPML=""
 S FHPREASA="",FHIFLG=0
 S K4="",PG=0 F  S K4=$O(^TMP($J,"AFP","T",K4)) Q:K4=""  F K0=0:0 S K0=$O(^TMP($J,"AFP","T",K4,K0)) Q:K0'>0  S FHIFLG=1 D P3P
 Q
P3P S X0=$G(^FH(114,K0,0)),MUL=$P(X0,"^",2) Q:'MUL  S P1=^TMP($J,"AFP","T",K4,K0),MUL=P1/MUL
 S FHPREA="MISCELLANEOUS"
 S S1=$P(X0,"^",12) I S1 S FHPREA=$P($G(^FH(114.2,S1,0)),"^",1),S1=$P($G(^FH(114.2,S1,0)),"^",3)
 S FHUNAM=""
 S FHUTEN=$P(X0,"^",6) S:FHUTEN FHUNAM=$G(^FH(114.3,FHUTEN,0))
 S FHPOSI=$P(X0,"^",3)
 S S1=$S(S1<1:99,S1<10:"0"_S1,1:S1)_$E($P(X0,"^",1),1,28)
 K ^TMP($J,"FH")
 S ^TMP($J,"FH","I",S1,K0)=0 S ^(K0)=^(K0)+P1
 F KK=0:0 S KK=$O(^FH(114,K0,"I",KK)) Q:KK<1  S Y=^(KK,0) D P4
 F KK=0:0 S KK=$O(^FH(114,K0,"R",KK)) Q:KK<1  S Y=^(KK,0) D P6
 D Q2
 Q
P4 S X1=+Y,Q=$P(Y,"^",2)*MUL
 S Y0=$G(^FHING(X1,0))
 S S2=$P(Y0,"^",12) S:S2 S2=$P($G(^FH(113.1,S2,0)),"^",3)
 S S2=$S(S2<1:99,S2<10:"0"_S2,1:S2)_$E($P(Y0,"^",1),1,28)
 S:'$D(^TMP($J,"FH","I",S1,K0,S2,X1)) ^TMP($J,"FH","I",S1,K0,S2,X1)=0 S ^(X1)=^(X1)+Q
P5 ;
 S:'$D(^TMP($J,"FH","S",S2,X1,S1,K0)) ^TMP($J,"FH","S",S2,X1,S1,K0)=0 S ^(K0)=^(K0)+Q Q
P6 S P1=$P(Y,"^",2)*MUL S:'$D(R(+Y)) R(+Y)=0 S R(+Y)=R(+Y)+P1 Q
 ;
Q2 ; Print AFP
 S OLD="",R1="" I PG=0 D HDR
S1 S R1=$O(^TMP($J,"FH","I",R1)) I R1="" W ! Q
 F K11=0:0 S K11=$O(^TMP($J,"FH","I",R1,K11)) Q:K11<1  S TOT=^(K11),FLG=0,R2="",X0=^FH(114,K11,0) D S2
 G S1
S2 ;I $P(FHPAR,"^",4)="Y",OLD'=$E(R1,1,2) S OLD=$E(R1,1,2),PG=0 D HDR
S3 S R2=$O(^TMP($J,"FH","I",R1,K11,R2)) Q:R2=""
 F X1=0:0 S X1=$O(^TMP($J,"FH","I",R1,K11,R2,X1)) Q:X1<1  D S4
 G S3
S4 D:$Y>(IOSL-7) HDR W ! G:FLG S5 D:(FHPREASA'=FHPREA) HDR W !,$E($P(X0,"^",1),1,22) S FLG=1
 ;I $P(FHPAR,"^",4)'="Y"
 S Z=$P(X0,"^",12) S:Z Z=$P(^FH(114.2,Z,0),"^",2) W:Z'="" " (",Z,")"
 W ?30,FHPOSI
S5 S (Y,I1)=^TMP($J,"FH","I",R1,K11,R2,X1)
 S Y(0)=$G(^FHING(X1,0)),UNT=$P(Y(0),"^",16) D EN2^FHREC1
 W ?40,$E($P(Y(0),"^",1),1,42)
 S FHYQU=$P(Y," ",1),FHYQUNA=$E(Y,$L(FHYQU)+1,$L(Y))
 W ?84,$J(FHYQU,6,0),?90,FHYQUNA S I2=$P(Y(0),"^",17) Q:'I2  S I1=I1/I2 Q:'I1
 S I1=+$J(I1,0,1)
 S I1=$S($L(I1)=1:"      "_I1,$L(I1)=2:"     "_I1,$L(I1)=3:"    "_I1,$L(I1)=4:"   "_I1,$L(I1)=5:"  "_I1,$L(I1)=6:" "_I1,1:I1)
 W ?108,I1,?116,$P(Y(0),"^",6)
 I $G(FHIFLG) W ?126,$J(TOT,5,0) S FHIFLG=0
 Q
B0 S LAB=$P(FHPAR,"^",10),R2=LAB=2*5+32
 F KK=0:0 S KK=$O(^TMP($J,"FH","I",KK)) Q:KK<1  F K12=0:0 S K12=$O(^TMP($J,"FH","I",KK,K12)) Q:K12<1  D B1
 F X1=1:1:18 W !
 Q
B1 F X1=0:0 S X1=$O(^TMP($J,"FH","I",KK,K12,X1)) Q:X1<1  S (Y,I1)=^(X1) D B2
 Q
B2 S Y(0)=^FHING(X1,0),UNT=$P(Y(0),"^",16) D EN2^FHREC1
 S I2=$P(Y(0),"^",17) Q:'I2  S I1=I1/I2
 S I1=$S(I1<1:1,I1#1<.1:I1\1,1:I1+.9\1)
 W !,$E($P(Y(0),"^",1),1,R2),!!,I1," ",$P(Y(0),"^",6),!!,$E($P(^FH(114,K12,0),"^",1),1,R2),! Q
HDR S PG=PG+1 W @IOF,!,DTP,?48,"Advance Food Prep (Grand Total)",?125,"Page ",PG
 W !,FHRETYP,?(131-$L(FHP6)),FHP6
 ;W ! D:$P(FHPAR,"^",4)="Y" PRE
 W !,FHPREA S FHPREASA=FHPREA
 W ?(132-$L(TIMAFP)\2),TIMAFP
 W !!,"Recipe",?30,"Portion",?40,"Ingredient",?88,"Quantity",?108,"Storeroom Amount",?126,"Total"
 W ! F K=1:1:131 W "-"
 Q
PRE S K=$P(X0,"^",12) S:K K=$P($G(^FH(114.2,K,0)),"^",1)
 W:K'="" K Q
 ;
AAR ;prints AFP Adjusted Recipes
 ;
 K N,R S K4="" F P0=0:0 S K4=$O(^TMP($J,"AFP","T",K4)) Q:K4=""  F L1=0:0 S L1=$O(^TMP($J,"AFP","T",K4,L1)) Q:L1<1  D AC0
AR0 F K1=0:0 S K1=$O(N(K1)) Q:K1<1  K N(K1) D AR1
 G:$O(N(""))'="" AR0
 F R1=0:0 S R1=$O(R(R1)) Q:R1=""  I $G(^FH(114,R1,0))'="" D:$P(^FH(114,R1,0),"^",8)'="N" AR3
 S NX="" F KK=0:0 S NX=$O(^TMP($J,"FH","R",NX)) Q:NX=""  F R1=0:0 S R1=$O(^TMP($J,"FH","R",NX,R1)) Q:R1<1  S S1=R(R1) D AEN1
 Q
AR1 F KK=0:0 S KK=$O(^FH(114,K1,"R",KK)) Q:KK<1  S Y=^(KK,0) D AR2
 Q
AR2 S P1=R(K1),MUL=$P(^FH(114,K1,0),"^",2) Q:'MUL  S MUL=P1/MUL
 S P1=$P(Y,"^",2)*MUL S:'$D(R(+Y)) R(+Y)=0 S R(+Y)=R(+Y)+P1 Q
AR3 S X=$G(^FH(114,R1,0)),K4=$P(X,"^",12),K4=$S($D(^FH(114.2,+K4,0)):$P(^(0),"^",3),1:99)
 S K4="A"_$S(K4<10:"0"_K4,1:K4)_$E($P(X,"^",1),1,27),^TMP($J,"FH","R",K4,R1)="" Q
AC0 S:'$D(R(L1)) R(L1)=0 S R(L1)=R(L1)+^TMP($J,"AFP","T",K4,L1),N(L1)="" Q
 ;
AEN1 ; Adjust Recipe - R1 = Recipe File No., S1 = No. Portions
 S R0=^FH(114,R1,0),P1=$P(R0,"^",2) Q:P1<1!(S1<1)
 D DISP D LN S N=0,MUL=S1/P1 W !
AN1 S N=$O(^FH(114,R1,"I",N)) G:N<1 AN2 S X=^(N,0),I2=+$P(X,"^",1),Y=$P(X,"^",2)*MUL
 S Y(0)=$G(^FHING(I2,0)),UNT=$P(Y(0),"^",16) D EN2^FHREC1
 W !!,$P(Y(0),"^",1),?60,Y G AN1
AN2 F K=0:0 S K=$O(^FH(114,R1,"R",K)) Q:K<1  S Y(0)=^(K,0) I +Y(0) W !!,"*",$P(^FH(114,+Y(0),0),"^",1),?60,$J(MUL*$P(Y(0),"^",2),0,0)," Portions"
 D LN W ! F K=0:0 S K=$O(^FH(114,R1,"X",K)) Q:K<1  W !,^(K,0)
 D LN W ! Q:$G(^FH(114,R1,"DBX",0))=""
 S P="" W !,"Diabetic Exchange: "
 F K=0:0 S K=$O(^FH(114,R1,"DBX",K)) Q:K<1  S Z=^(K,0) S:P'="" P=P_", " S Z1=$S($P(Z,"^",2):$P(Z,"^",2),1:1)_" "_$P($G(^FH(114.1,+Z,0)),"^",1) D:$L(P)+$L(Z1)'<60 EX S P=P_Z1
 W:P'="" ?19,P,!
 D LN W ! Q
EX W ?19,P S P="" W !
 Q
DISP W @IOF W !?20,"A F P   A D J U S T E D    R E C I P E S",?71,$E(DTP,1,9)
 S N=$P(R0,"^",1) W !!?(80-$L(N)\2),N
 W !!,"Portion Size: ",$P(R0,"^",3),?40,"No. Portions: ",S1
 W !,"Prep. Time:   ",$P(R0,"^",4),?40,"Srv. Utensil: " S Z=$P(R0,"^",6) I Z W $P(^FH(114.3,Z,0),"^",1)
 W !,"Equipment:    " S N=$O(^FH(114,R1,"E",0)) I N>0 S Z=^(N,0) W $P(^FH(114.4,Z,0),"^",1)
 W ?40,"Category:     " S Z=$P(R0,"^",7) I Z W $P(^FH(114.1,Z,0),"^",1)
 I N>0 F N=N:0 S N=$O(^FH(114,R1,"E",N)) Q:N<1  S Z=^(N,0) W !?14,$P(^FH(114.4,Z,0),"^",1)
 Q
LN W !!,"-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -" Q
AEN2 ; Print adjusted recipe
BR1 ; Entry Point to Print adjusted recipe
 K R F K1=0:0 S K1=$O(^FH(114,R1,"R",K1)) Q:K1<1  S Y=^(K1,0) D BR2
 S PG=0 D AEN1 S PG=1
 F R1=0:0 S R1=$O(R(R1)) Q:R1=""  S S1=R(R1) D AEN1
 Q
BR2 S MUL=$P(^FH(114,R1,0),"^",2) Q:'MUL  S MUL=S1/MUL
 S P1=$P(Y,"^",2)*MUL S:'$D(R(+Y)) R(+Y)=0 S R(+Y)=R(+Y)+P1
 Q
KIL G KILL^XUSCLEAN
