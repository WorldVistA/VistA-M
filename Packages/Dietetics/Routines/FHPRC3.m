FHPRC3 ; HISC/REL - List Meal ;4/12/95  13:56
 ;;5.5;DIETETICS;;Jan 28, 2005
 S DIC="^FH(116.1,",DIC(0)="AEQM" W ! D ^DIC K DIC G KIL:U[X!$D(DTOUT),FHPRC3:Y<1 S FHMN=+Y
 K IOP S %ZIS="MQ",%ZIS("A")="Select Listing Device: ",%ZIS("B")="HOME" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHPRC3",FHLST="FHMN" D EN2^FH G FHPRC3
 U IO D Q1 D ^%ZISC K %ZIS,IOP G FHPRC3
Q1 ; Print Meal
 S Y=^FH(116.1,FHMN,0),N1=$P(Y,"^",1) W:$E(IOST,1,2)="C-" @IOF
 W !!?(77-$L(N1)\2),"Meal: ",N1,!!,"Recipe",?28,"Cat.",?34,"Production Diets"
 K ^TMP($J)
 F M=0:0 S M=$O(^FH(116.1,FHMN,"RE",M)) Q:M<1  S Y=$G(^(M,0)),L1=+Y D Q2
 S K4="" F P0=0:0 S K4=$O(^TMP($J,K4)) Q:K4=""  F L1=0:0 S L1=$O(^TMP($J,K4,L1)) Q:L1<1  S X=^(L1) D Q3
 W ! G KIL
Q2 S X=$G(^FH(114,L1,0)),N1=$P(X,"^",1) Q:N1=""  S MCA=$O(^FH(116.1,FHMN,"RE",M,"R",0)),K4=$S(MCA:+$G(^FH(116.1,FHMN,"RE",M,"R",MCA,0)),1:99)
 S K4=$S($D(^FH(114.1,+K4,0)):$P(^(0),"^",3),1:99)
 S K4=$S(K4<1:99,K4<10:"0"_K4,1:K4)_$E(N1,1,28)
 S ^TMP($J,K4,L1)=N1_"^"_M Q
Q3 W !!,$E($P(X,"^",1),1,27) S M=$P(X,"^",2)
 F CAT=0:0 S CAT=$O(^FH(116.1,FHMN,"RE",M,"R",CAT)) Q:CAT<1  S MCA=$G(^(CAT,0)),CODE=+MCA D
 .S CODE=$P($G(^FH(114.1,+CODE,0)),"^",2) D SRT
 .W ?29,$J(CODE,3) S X=$E(PD,1,200) D Q4 W !
 .Q
 G Q5
Q4 I $L(X)<44 W ?34,X Q
 F N1=44:-1:1 Q:$E(X,N1)=" "
 W ?34,$E(X,1,N1-1) S X=$E(X,N1+1,999) I X'="" W ! G Q4
 Q
Q5 Q:'$D(^FH(116.1,FHMN,"RE",M,"D"))
 F P1=0:0 S P1=$O(^FH(116.1,FHMN,"RE",M,"D",P1)) Q:P1<1  S X=^(P1,0),A1=$P(X,"^",2),X1=^FH(119.72,P1,0) D DP
 Q
DP I $G(^FH(119.72,P1,"I"))="Y" Q
 S A2=$P(X1,"^",4) S:A2="" A2=$E($P(X1,"^",1),1,10) W !?3,A2
 S A2=$P(X1,"^",2) W ?15,$S(A2["C":"Cafe",1:"Tray")," ",$S(A1="":100,1:A1),"% " Q
SRT S FHPD=$P(MCA,"^",2) K SR
 F LP=1:1 S FHX1=$P(FHPD," ",LP) Q:FHX1=""  S PD=$P(FHX1,";",1) I PD'="" S Z=0,Z=$O(^FH(116.2,"C",PD,Z)) I Z D
 .S Z1=$P($G(^FH(116.2,+Z,0)),"^",6),Z1=$S(Z1<1:99,Z1<10:"0"_Z1,1:Z1)
 .S:'$D(SR(Z1_"~"_PD)) SR(Z1_"~"_PD)=FHX1 Q
 S (PD,XX)="" F  S XX=$O(SR(XX)) Q:XX=""  S Z=$G(SR(XX)) I Z'="" S:PD'="" PD=PD_" " S PD=PD_Z
 Q
KIL K ^TMP($J) G KILL^XUSCLEAN
