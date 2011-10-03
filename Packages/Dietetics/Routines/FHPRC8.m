FHPRC8 ; HISC/REL - Print Daily Diet Menus ;1/23/98  16:10
 ;;5.5;DIETETICS;;Jan 28, 2005
 S FHP=$O(^FH(119.71,0)) I FHP'<1,$O(^FH(119.71,FHP))<1 G F1
F0 R !!,"Select PRODUCTION FACILITY: ",X:DTIME G:'$T!("^"[X) KIL
 K DIC S DIC="^FH(119.71,",DIC(0)="EMQ" D ^DIC G:Y<1 F0 S FHP=+Y
F1 S %DT("A")="Select Date: ",%DT="AEX" W ! D ^%DT G:"^"[X!$D(DTOUT) KIL G:Y<1 F1 S D1=+Y
L0 W !!,"The Menu requires a 132 compressed printer.",!
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHPRC8",FHLST="D1^FHP" D EN2^FH G F1
 U IO D Q1 D ^%ZISC K %ZIS,IOP G F1
Q1 ; Print the Daily Menu
 D ^FHDEV S X=220 X ^%ZOSF("RM") K ^TMP($J) S X1=D1 D SET
 Q:'$D(^TMP($J))  D NOW^%DTC S NOW=%,PG=0,DTP=D1 D DTP^FH S DTE=DTP,DTP=NOW D DTP^FH
 S X=D1 D DOW^%DTC S DTE=$P("Sun^Mon^Tues^Wednes^Thurs^Fri^Satur","^",Y+1)_"day  "_DTE
 S TYP=$P($G(^FH(119.71,FHP,0)),"^",2) W @FHIO("P16") D PRT W @FHIO("P10") Q
SET D E1^FHPRC1 S X2="" I FHCY>0,$D(^FH(116,FHCY,"DA",FHDA,0)) S X2=^(0)
 I $D(^FH(116.3,D1,0)) S X=^(0) F K3=2:1:4 I $P(X,"^",K3) S $P(X2,"^",K3)=$P(X,"^",K3)
 S RG=$P(^FH(116.2,1,0),"^",2)
 K M,M1 F K=0:0 S K=$O(^FH(116.2,K)) Q:K<1  S X=^(K,0),PD=$P(X,"^",2) I PD'="",K=1!($P(X,"^",7)="Y") S K4=$P(X,"^",6),K4=$S(K4<1:99,K4<10:"0"_K4,1:K4) S M(PD)=K4_PD,M1(K4_PD)=K
 S REG=M(RG)
 F K3=1:1:3 S X=$P(X2,"^",K3+1) I X D S1
 K M Q
S1 K ^TMP($J,"R") F P1=0:0 S P1=$O(^FH(116.1,X,"RE",P1)) Q:P1<1  S Y0=^(P1,0) D S2
 S P1=0,NX="" F K=0:0 S NX=$O(^TMP($J,"R",NX)) Q:NX=""  S X=^(NX) D S3
 K Y,Y0 Q
S2 S L1=+Y0,Y=$G(^FH(114,L1,0)) Q:Y=""
 F CAT=0:0 S CAT=$O(^FH(116.1,X,"RE",P1,"R",CAT)) Q:CAT<1  S MCA=^(CAT,0) D
 .S K4=+MCA,K4=$P($G(^FH(114.1,+K4,0)),"^",3)
 .S K4=$S(K4<1:99,K4<10:"0"_K4,1:K4)_+MCA
 .S ^TMP($J,"R","A"_K4_$P(Y,"^",1))=$P(Y,"^",1)_"^"_$P(MCA,"^",2)_"^"_$P(Y,"^",3) Q
 Q
S3 S L1=$P(X,"^",1),X1=$P(X,"^",2),P1=P1+1
 S P0=0 I X1[RG S:'$D(^TMP($J,"X",K3,REG,0)) ^TMP($J,"X",K3,REG,0)=0 S P0=^(0)+1,^(0)=P0,^TMP($J,"X",K3,REG,P0)=L1_"^"_$P(X,"^",3)
 F K4=1:1 S Z=$E($P(X1," ",K4),1,2) Q:Z=""  I Z'=RG S Z=$S($D(M(Z)):M(Z),1:"") I Z'="" S:'$D(^TMP($J,"X",K3,Z,0)) ^TMP($J,"X",K3,Z,0)=0 S P2=^(0)+1,^(0)=P2,^TMP($J,"X",K3,Z,P2)=L1_"^"_P0
 Q
PRT K M2 S N1=0,NX="" F K=0:0 S NX=$O(M1(NX)) Q:NX=""  I NX'=REG S N1=N1+1,M2(N1)=NX
 S L2=0
P0 Q:L2=N1  S L1=L2+1,L2=L1+4 S:L2>N1 L2=N1 D HDR F K3=1:1:3 S P1=0 D P1
 W ! G P0
P1 S P1=P1+1,C=0,Y="|",NX="" S X=$G(^TMP($J,"X",K3,REG,P1)) S:X'="" C=1 S:X'=""&(TYP'="Y") X=$J(P1,2)_" "_X S Y=Y_" "_$E($P(X,"^",1)_$J("",30),1,30)_" | "_$E($P(X,"^",2)_$J("",15),1,15)_" |"
 F K4=L1:1:L2 S NX=M2(K4),X="",P2=0 S:$D(^TMP($J,"X",K3,NX,P1)) X=^(P1),P2=$P(X,"^",2),X=$P(X,"^",1),C=1 S:P2&(TYP'="Y") X=P2 S Y=Y_" "_$E(X_$J("",30),1,30)_" |"
 I C W !,Y G P1
 W !,LN Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !,DTP,?90,"D A I L Y   D I E T   M E N U S",?210,"Page ",PG,!!?(216-$L(DTE)\2),DTE
 W !!?2,"REGULAR",?35,"Portion Size" S KK=20 F K4=L1:1:L2 S NX=$E(M2(K4),3,4),NX=$O(^FH(116.2,"C",NX,0)),X=$P($G(^FH(116.2,+NX,0)),"^",1) S KK=KK+33 W ?KK,$E(X,1,30)
 S LN="",$P(LN,"-",L2-L1+1*33+53)="" W !,LN Q
KIL K ^TMP($J) G KILL^XUSCLEAN
