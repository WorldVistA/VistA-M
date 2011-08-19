FHNU1 ; HISC/REL - List Menu ;11/16/93  09:49 
 ;;5.5;DIETETICS;;Jan 28, 2005
 D GET G:'MENU KIL K IOP S %ZIS="MQ",%ZIS("B")="HOME" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="F0^FHNU1",FHLST="MENU^MNAM^TYP" D EN2^FH G KIL
 U IO D F0 D ^%ZISC K %ZIS,IOP G KIL
F0 ; List the Menu
 S DAY=0 W:$E(IOST,1,2)="C-" @IOF
F1 S DAY=$O(^FHUM(MENU,1,DAY)),(MEAL,H1)=0 I DAY<1 W ! G KIL
F2 S MEAL=$O(^FHUM(MENU,1,DAY,1,MEAL)) G:MEAL<1 F1 S (ITM,H2)=0
F3 S ITM=$O(^FHUM(MENU,1,DAY,1,MEAL,1,ITM)) G:ITM<1 F2
 I 'H1 W !!,"Menu: ",MNAM,?60,"Day: ",DAY,! S H1=1
 I 'H2 W !!?18,"----------  Meal ",MEAL,"  ----------",! S H2=1
 S X=^FHUM(MENU,1,DAY,1,MEAL,1,ITM,0),Y(0)=^FHNU(+X,0)
 W !,$P(Y(0),"^",1)," - ",$P(X,"^",2)," ",$S(TYP="C":$P(Y(0),"^",3),1:"gms") G F3
EN1 ; Display Meal
 D GET G:'MENU KIL
SEL S (DAY,MEAL)=0 K DIC I '$D(^FHUM(MENU,1,0)) S ^FHUM(MENU,1,0)="^112.61^^"
S1 S DIC="^FHUM(MENU,1,",DIC(0)="AEQM",DIC("DR")="",DA(1)=MENU,DIC("A")="Select DAY #: " D ^DIC G KIL:"^"[X!$D(DTOUT),S1:Y<1 S (DAY,DA)=+Y
 K DR I '$D(^FHUM(MENU,1,DAY,1,0)) S ^FHUM(MENU,1,DAY,1,0)="^112.62^^"
S2 S DIC="^FHUM(MENU,1,DAY,1,",DIC("A")="Select MEAL #: " D ^DIC G KIL:"^"[X!$D(DTOUT),S2:Y<1 S MEAL=+Y K DIC
 K IOP S %ZIS="MQ",%ZIS("B")="HOME" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="S3^FHNU1",FHLST="MENU^MNAM^TYP^DAY^MEAL" D EN2^FH G KIL
 U IO D S3 D ^%ZISC K %ZIS,IOP G KIL
S3 ; Print Meal
 W:$E(IOST,1,2)="C-" @IOF W !,"Menu: ",MNAM,"     Day: ",DAY,"     Meal: ",MEAL,! S (ITM,H1)=0
D1 S ITM=$O(^FHUM(MENU,1,DAY,1,MEAL,1,ITM)) I ITM<1 W ! W:'H1 !,"NO Items Selected for this Meal!" Q
 S X=^FHUM(MENU,1,DAY,1,MEAL,1,ITM,0),Y(0)=^FHNU(+X,0),H1=H1+1
 W !,$P(Y(0),"^",1)," - ",$P(X,"^",2)," ",$S(TYP="C":$P(Y(0),"^",3),1:"gms") G D1
KIL G KILL^XUSCLEAN
GET K DIC S MENU=0,DIC="^FHUM(",DIC(0)="AEQMZ",DIC("S")="I '$P(^(0),U,5)" W ! D ^DIC Q:U[X!$D(DTOUT)  G:Y<1 GET S MENU=+Y,MNAM=$P(Y,U,2),TYP=$P(Y(0),U,2) Q
