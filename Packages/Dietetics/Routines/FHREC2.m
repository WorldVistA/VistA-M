FHREC2 ; HISC/REL - Adjust Recipe ;4/28/95  09:45
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Adjust Recipe - R1 = Recipe File No., S1 = No. Portions
 S R0=^FH(114,R1,0),P1=$P(R0,"^",2) Q:P1<1!(S1<1)
 D DISP D LN S N=0,MUL=S1/P1 W !
N1 S N=$O(^FH(114,R1,"I",N)) G:N<1 N2 S X=^(N,0),I2=+$P(X,"^",1),Y=$P(X,"^",2)*MUL
 S Y(0)=$G(^FHING(I2,0)),UNT=$P(Y(0),"^",16) D EN2^FHREC1
 W !!,$P(Y(0),"^",1),?60,Y G N1
N2 F K=0:0 S K=$O(^FH(114,R1,"R",K)) Q:K<1  S Y(0)=^(K,0) I +Y(0) W !!,"*",$P(^FH(114,+Y(0),0),"^",1),?60,$J(MUL*$P(Y(0),"^",2),0,0)," Portions"
 D LN W ! F K=0:0 S K=$O(^FH(114,R1,"X",K)) Q:K<1  W !,^(K,0)
 D LN W ! Q:$G(^FH(114,R1,"DBX",0))=""
 S P="" W !,"Diabetic Exchange: "
 F K=0:0 S K=$O(^FH(114,R1,"DBX",K)) Q:K<1  S Z=^(K,0) S:P'="" P=P_", " S Z1=$S($P(Z,"^",2):$P(Z,"^",2),1:1)_" "_$P($G(^FH(114.1,+Z,0)),"^",1) D:$L(P)+$L(Z1)'<60 EX S P=P_Z1
 W:P'="" ?19,P,!
 D LN W ! Q
EX W ?19,P S P="" W !
 Q
DISP W:PG @IOF W !?25,"A D J U S T E D   R E C I P E",?71,$E(DTP,1,9)
 S N=$P(R0,"^",1) W !!?(80-$L(N)\2),N
 W !!,"Portion Size: ",$P(R0,"^",3),?40,"No. Portions: ",S1
 W !,"Prep. Time:   ",$P(R0,"^",4),?40,"Srv. Utensil: " S Z=$P(R0,"^",6) I Z W $P(^FH(114.3,Z,0),"^",1)
 W !,"Equipment:    " S N=$O(^FH(114,R1,"E",0)) I N>0 S Z=^(N,0) W $P(^FH(114.4,Z,0),"^",1)
 W ?40,"Category:     " S Z=$P(R0,"^",7) I Z W $P(^FH(114.1,Z,0),"^",1)
 I N>0 F N=N:0 S N=$O(^FH(114,R1,"E",N)) Q:N<1  S Z=^(N,0) W !?14,$P(^FH(114.4,Z,0),"^",1)
 Q
LN W !!,"-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -" Q
EN2 ; Print adjusted recipe
 S X="T",%DT="X" D ^%DT K %DT S DTP=Y D DTP^FH
 K DIC S DIC="^FH(114,",DIC(0)="AEQM" W ! D ^DIC K DIC G KIL:"^"[X!$D(DTOUT),EN2:Y<1 S R1=+Y
R0 R !!,"Number of Portions: ",S1:DTIME G KIL:'$T!("^"[S1) I +S1'=S1!(S1<1)!(S1>5000) W *7,"  Enter a number from 1 to 5000" G R0
 W ! K IOP,%ZIS S %ZIS("A")="Select Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="R1^FHREC2",FHLST="R1^S1^DTP" D EN2^FH G EN2
 U IO D R1 D ^%ZISC K %ZIS,IOP G EN2
R1 ; Entry Point to Print adjusted recipe
 K R F K1=0:0 S K1=$O(^FH(114,R1,"R",K1)) Q:K1<1  S Y=^(K1,0) D R2
 S PG=0 D EN1 S PG=1
 F R1=0:0 S R1=$O(R(R1)) Q:R1=""  S S1=R(R1) D EN1
 Q
R2 S MUL=$P(^FH(114,R1,0),"^",2) Q:'MUL  S MUL=S1/MUL
 S P1=$P(Y,"^",2)*MUL S:'$D(R(+Y)) R(+Y)=0 S R(+Y)=R(+Y)+P1 Q
KIL G KILL^XUSCLEAN
