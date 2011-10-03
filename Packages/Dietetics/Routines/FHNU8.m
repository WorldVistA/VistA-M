FHNU8 ; HISC/REL/NCA - Nutrient Intake Study ;11/16/93  09:52 
 ;;5.5;DIETETICS;;Jan 28, 2005
 S %DT="X",X="T" D ^%DT,HDR S DT=Y
F4 K DIC S MENU=0,DIC="^FHUM(",DIC(0)="AEQMZ",DIC("S")="I '$P(^(0),U,5)" W ! D ^DIC G KIL:U[X!$D(DTOUT),F4:Y<1 S MENU=+Y,MNAM="Menu: "_$P(Y,U,2),TYP=$P(Y(0),U,2)
F5 K DIC S DIC="^FH(112.2,",DIC(0)="AEQM",DIC("A")="Select DRI Category: " W ! D ^DIC G:X["^"!$D(DTOUT) KIL S RDA=$S(Y<1:0,1:+Y) K DIC
F1 S ALL=1 D ^FHDPA G PAT:X="*",KIL:'DFN G:FHDFN="" KIL S NAM=$P(Y(0),U,1),SEX=$P(Y(0),U,2),AGE=$P(Y(0),U,3) G:SEX=""!(AGE="") P1
 I $P($G(^DPT(DFN,.35)),"^",1) W *7,!!?5,"  [ Patient has expired. ]" G KIL
 S AGE=$E(DT,1,3)-$E(AGE,1,3)-($E(DT,4,7)<$E(AGE,4,7))
F2 K IOP S %ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHNU8",FHLST="MENU^MNAM^TYP^RDA^NAM^SEX^AGE^DTP" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Printing Nutrient Intake
 S %DT="X",X="T" D ^%DT S (DT,DTP)=Y D DTP^FH
 D TOT^FHNU9,HEAD S (DAY,NDAY)=0,(T(1),T(2),T(3),T(4),T(5))=""
C1 S DAY=$O(^TMP($J,"M",DAY)) G:DAY="" C4 S MEAL=0 W !!,"Day ",DAY
C2 S MEAL=$O(^TMP($J,"M",DAY,MEAL)) G:MEAL="" C3 S X1=$G(^(MEAL,1)),X2=$G(^(2)),X3=$G(^(3)),X4=$G(^(4))
 W !," Meal ",MEAL,?7 D LIS^FHNU2 G C2
C3 S X1=$G(^TMP($J,"D",DAY,1)),X2=$G(^(2)),X3=$G(^(3)),X4=$G(^(4)),X5=$G(^(5)) W !!," Total",?8 D LIS^FHNU3
 S NDAY=NDAY+1 I RDA W !," % DRI",?7 D RDA^FHNU9
 W !," % Kcal",?14 S Z1=$P(X1,"^",4) S:'Z1 Z1=1 F KK=1,3,2 W $J($P(X1,"^",KK)*$S(KK=2:900,1:400)/Z1,7,0)
 D RAT F K=1:1:20 S Z1=$P(X1,"^",K) I Z1 S $P(T(1),"^",K)=$P(T(1),"^",K)+Z1
 F K=1:1:13 S Z1=$P(X2,"^",K) I Z1 S $P(T(2),"^",K)=$P(T(2),"^",K)+Z1
 F K=1:1:33 S:$P(X5,"^",K) $P(T(5),"^",K)=1
 G C1
C4 D AVG^FHNU3 W !!,"Day Avg." S X1=T(1),X2=T(2),X5=T(5) D LIS^FHNU3
 I RDA W !," % DRI",?7 D RDA^FHNU9
 W !," % Kcal",?14 S Z1=$P(X1,"^",4) S:'Z1 Z1=1 F KK=1,3,2 W $J($P(X1,"^",KK)*$S(KK=2:900,1:400)/Z1,7,0)
 D RAT W !!,"'+' following a daily value indicates that incomplete data exists.",!
KIL K ^TMP($J) G KILL^XUSCLEAN
HDR W @IOF,!!?19,"N U T R I E N T   I N T A K E   S T U D Y",!! Q
RAT W:$P(X1,"^",1) !," Kcal:N Ratio = ",$J(6.25*$P(X1,"^",4)/$P(X1,"^",1),0,0),":1" Q
PAT R !!,"Enter Patient's Name: ",NAM:DTIME G:'$T!("^"[NAM) KIL
 I NAM["?"!(NAM'?.ANP)!(NAM["^") W *7,!?5,"Enter Patient's Name to be printed on the report." G PAT
P1 R !,"Sex: ",SEX:DTIME G:'$T!("^"[SEX) KIL S X=SEX D TR^FH S SEX=X I $P("MALE",SEX,1)'="",$P("FEMALE",SEX,1)'="" W *7,"  Enter M or F" G P1
 S SEX=$E(SEX,1)
P2 R !,"Age: ",AGE:DTIME G:'$T!("^"[AGE) KIL I AGE'?1N.N!(AGE<6)!(AGE>124) W !?5,"Enter Age in years between 6 and 124" G P2
 G F2
HEAD W:$E(IOST,1,2)="C-" @IOF W !?19,"N U T R I E N T   I N T A K E   S T U D Y",?68,DTP,!
 W !,"Patient: ",NAM,?40,$S(SEX="M":"Male",1:"Female"),?70,"Age: ",AGE,!
 W !?9,"Energ    Pro    CHO    Fat    Sod    Pot   Calc   Phos   Chol    H2O"
 W !?10,"KCal     Gm     Gm     Gm     Mg     Mg     Mg     Mg     Mg     Ml",!
 S NUT="1047000101710110371001027100113701911270201087011111701222970001057000" Q
