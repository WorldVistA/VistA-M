FHPRC13 ; HISC/NCA - Enter/Edit Recipe Menu ;3/13/95  11:16
 ;;5.5;DIETETICS;;Jan 28, 2005
 K ^TMP($J)
GET W ! K DIC S DIC="^FHUM(",DIC(0)="AEQLMZ",DIC("S")="I $P(^(0),U,5)",DIC("DR")=".01",DLAYGO=112.6 D ^DIC K DLAYGO G KIL:U[X!$D(DTOUT),GET:Y<1 S MENU=+Y,NEW=$P(Y,U,3)
 I 'NEW S DIE=DIC K DIC S DA=MENU,DR=".01",DIDEL=112.6 D ^DIE K DIDEL G:'$D(^FHUM(MENU))!($D(Y)) KIL D PD^FHPRC14 G SEL
 S %DT="X",X="T" D ^%DT S $P(^FHUM(MENU,0),U,2,5)="C"_"^"_Y_"^"_DUZ_"^"_1
SEL S (DAY,MEAL)=0 K DIC I '$D(^FHUM(MENU,1,0)) S ^FHUM(MENU,1,0)="^112.61^^"
S1 S DIC="^FHUM(MENU,1,",DIC(0)="EQLM",DIC("DR")="",DA(1)=MENU,DLAYGO=112.6
 R !,"Select Day #: ",X:DTIME G:'$T!(X["^") KIL
 I X="" W ! G STOR:$O(M(0))>0,E8
 D ^DIC K DIC,DLAYGO G:Y<1 S1 S (DAY,DA)=+Y
 K DR I '$D(^FHUM(MENU,1,DAY,1,0)) S ^FHUM(MENU,1,DAY,1,0)="^112.62^^"
S2 S DIC="^FHUM(MENU,1,DAY,1,",DIC(0)="EQLM",DLAYGO=112.6
 R !,"Select Meal #: ",X:DTIME G:'$T!(X["^") KIL
 I X="" W ! G S1:$G(M(DAY))'="",E7
 D ^DIC K DLAYGO G:Y<1 S2 S MEAL=+Y K DIC
 S OLD=$S($G(M(DAY))'="":$P(M(DAY),"^",MEAL),1:""),M1=$P(OLD,";",1),P=$P(OLD,";",2),PD=+P,CODE=$P(P,"~",2),OLD=M1_"^"_CODE I 'NEW D OLD^FHPRC14
S3 K DIC S DIC="^FH(116.1,",DIC(0)="EQM"
 W !,"Select Meal: " W:M1'="" $S($G(^FH(116.1,M1,0))'="":$P(^FH(116.1,M1,0),"^",1)_" // ",1:"") R X:DTIME G:'$T!(X["^") KIL
 I X="@" G DEL
 I X="" S:M1'="" X=$P($G(^FH(116.1,M1,0)),"^",1) W ! G:M1="" E6
 D ^DIC G:Y<1 S3 S M1=+Y K DIC
S4 K DIC S DIC="^FH(116.2,",DIC(0)="EQMZ"
 W !,"Select Production Diet: " W:PD $S($G(^FH(116.2,+PD,0))'="":$P(^FH(116.2,+PD,0),"^",1)_" // ",1:"") R X:DTIME G:'$T!(X["^") KIL
 I X="@" I PD S PD=0 G S4
 I X="@" I 'PD W *7,?27,"No Production Diet to Delete!" G S4
 I X="" S:PD X=$P($G(^FH(116.2,+PD,0)),"^",1)
 D ^DIC G:Y<1 S4 K DIC
 S PD=+Y,CODE=$P(Y(0),"^",2),ZZ=M1_"^"_CODE
 I $P(OLD,"^",1,2)=ZZ G:$D(^TMP($J,"RECIPES",DAY,MEAL)) R1
 S S1=M1_";"_PD_"~"_CODE,$P(M(DAY),"^",MEAL)=S1
 D SRCH^FHPRC14
R1 ; Edit Recipe and Portion
 K DIC S DIC="^FH(114,",DIC(0)="EQM"
 R !!,"Select Recipe: ",X:DTIME G KIL:'$T!(X["^"),S2:X=""
 I X="?" D LIS^FHPRC14 G R1
 D ^DIC G:Y<1 R1 K DIC S REC=+Y S:'$D(^TMP($J,"RECIPES",DAY,MEAL,REC)) ^TMP($J,"RECIPES",DAY,MEAL,REC)=1_"^"_$P($G(^FH(114,REC,0)),"^",14)
R2 W !,"Serving Portion: ",+$G(^TMP($J,"RECIPES",DAY,MEAL,REC))_"// " R X:DTIME G:'$T!(X["^") KIL G:X="" R1
 I X'?.N.1".".N!(X<0)!(X>9999) W *7,!,"Enter amount of serving portion.  Enter 0 to omit recipe;",!,"otherwise enter a number greater than 0 but less than 9999." G R2
 S $P(^TMP($J,"RECIPES",DAY,MEAL,REC),"^",1)=X
 G R1
STOR D L1^FHPRC14 R !!,"Okay to Save the Menu? YES// ",YN:DTIME G:'$T!(YN["^") KIL S:YN="" YN="Y" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G STOR
 I YN?1"Y".E W ! G E5
 G SEL
E5 W !,"...Storing Recipes and Food Nutrient"
 F DAY=0:0 S DAY=$O(^TMP($J,"RECIPES",DAY)) Q:DAY<1  F MEAL=0:0 S MEAL=$O(^TMP($J,"RECIPES",DAY,MEAL)) Q:MEAL<1  D A1
 W !,"...Done"
 G KIL
DEL ; Delete Meal
 I '$D(^TMP($J,"RECIPES",DAY,MEAL)) W *7,?17,"No Meal to Delete!" G S2
 K ^TMP($J,"RECIPES",DAY,MEAL)
 G E6
A1 S ZZ=$G(^TMP($J,"RECIPES",DAY,MEAL,0)),$P(^FHUM(MENU,1,DAY,1,MEAL,0),"^",2,3)=ZZ
 I 'NEW,$D(^FHUM(MENU,1,DAY,1,MEAL,2,0)) K ^FHUM(MENU,1,DAY,1,MEAL,2),^FHUM(MENU,1,DAY,1,MEAL,1)
 I '$D(^FHUM(MENU,1,DAY,1,MEAL,1,0)) S ^(0)="^112.63P^^"
 I '$D(^FHUM(MENU,1,DAY,1,MEAL,2,0)) S ^(0)="^112.64P^^"
 S K=0
A2 S K=$O(^TMP($J,"RECIPES",DAY,MEAL,K)) Q:K<1  S L1=K,Y=$G(^(K)),QTY=+Y,NP=$P(Y,"^",2) G:'NP A2
 S $P(^FHUM(MENU,1,DAY,1,MEAL,2,0),U,3,4)=L1_"^"_($P(^FHUM(MENU,1,DAY,1,MEAL,2,0),U,4)+1)
 S ^FHUM(MENU,1,DAY,1,MEAL,2,L1,0)=L1_"^"_QTY
 S $P(^FHUM(MENU,1,DAY,1,MEAL,1,0),U,3,4)=+NP_"^"_($P(^FHUM(MENU,1,DAY,1,MEAL,1,0),"^",4)+1)
 S ^FHUM(MENU,1,DAY,1,MEAL,1,+NP,0)=+NP_"^"_QTY
 G A2
E6 I $D(^FHUM(MENU,1,DAY,1,MEAL)) K ^FHUM(MENU,1,DAY,1,MEAL) S $P(^FHUM(MENU,1,DAY,1,0),U,4)=$P(^FHUM(MENU,1,DAY,1,0),U,4)-1 S:$D(M(DAY)) $P(M(DAY),"^",MEAL)="" W !,"No Meal-Meal Deleted"
E7 I $O(^FHUM(MENU,1,DAY,1,0))>0 G S2
 K ^FHUM(MENU,1,DAY) W !,"No Meals Remains-Day Deleted"
 S $P(^FHUM(MENU,1,0),U,4)=$P(^FHUM(MENU,1,0),U,4)-1 I $D(M(DAY)) K M(DAY)
 I $O(^FHUM(MENU,1,0))>0 W ! G SEL
E8 K DA,DIC,DIE,DIK S DIK="^FHUM(",DA=MENU D ^DIK W !,"...Menu Deleted"
 W !
KIL K ^TMP($J) G KILL^XUSCLEAN
