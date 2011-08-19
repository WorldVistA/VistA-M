FHNU4 ; HISC/REL - Edit Menu ;11/16/93  09:52 
 ;;5.5;DIETETICS;;Jan 28, 2005
GET W ! K DIC S DIC="^FHUM(",DIC(0)="AEQLMZ",DIC("S")="I '$P(^(0),U,5)",DIC("DR")=".01",DLAYGO=112.6 D ^DIC K DLAYGO G KIL:U[X!$D(DTOUT),GET:Y<1 S MENU=+Y,MNAM=$P(Y,U,2)
 S NEW=$P(Y,U,3),DIE=DIC K DIC S DA=MENU,DR=$S(NEW:".6",1:".01"),DIDEL=112.6 D ^DIE K DIDEL G KIL:'$D(^FHUM(MENU)) I NEW S %DT="X",X="T" D ^%DT S $P(^FHUM(MENU,0),U,3,4)=Y_"^"_DUZ
 S TYP=$P(^FHUM(MENU,0),U,2)
SEL S (DAY,MEAL)=0 K DIC I '$D(^FHUM(MENU,1,0)) S ^FHUM(MENU,1,0)="^112.61^^"
S1 S DIC="^FHUM(MENU,1,",DIC(0)="AEQLM",DIC("DR")="",DA(1)=MENU,DIC("A")="Select DAY #: ",DLAYGO=112.6 D ^DIC K DLAYGO G KIL:U[X!$D(DTOUT),S1:Y<1 S (DAY,DA)=+Y
 K DR I '$D(^FHUM(MENU,1,DAY,1,0)) S ^FHUM(MENU,1,DAY,1,0)="^112.62^^"
S2 S DIC="^FHUM(MENU,1,DAY,1,",DIC("A")="Select MEAL #: " D ^DIC G KIL:U[X!$D(DTOUT),S2:Y<1 S MEAL=+Y K DIC I $P(Y,U,3) S ^FHUM(MENU,1,DAY,1,MEAL,1,0)="^112.63P^^" K FHM G E5
ED D LIS R !!,"Do you wish to EDIT this list? NO// ",YN:DTIME G:'$T!(YN["^") KIL S:YN="" YN="N" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G ED
 I YN?1"N".E W ! G SEL
E0 G:'NM E5 R !!,"Do you wish to change any amounts? NO// ",YN:DTIME G:'$T!(YN["^") KIL S:YN="" YN="N" S X=YN D TR^FH S YN=X
 I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7,!,"  Answer YES or NO" G E0
 G E2:YN?1"N".E
E1 R !,"Change item # : ",X:DTIME G KIL:'$T,E2:X="",ED:X["^" I X'?1N.N!(X<1)!(X>NM) W *7,"  ??" G E1
 S X=$P(XT,",",X) I TYP="C" S UNIT=$P(FHM(X),",",2),WT=$P(FHM(X),",",3)
 W *7,"  from ",(+FHM(X))," ",UNIT," to: " R Y:DTIME G KIL:'$T,E1:Y["^" I Y'?.N.1".".N!(Y'>0)!(Y>99999) W "  ??" G E1
 W " ",UNIT S Y=+Y,$P(FHM(X),",",1)=Y
 S $P(^FHUM(MENU,1,DAY,1,MEAL,1,X,0),"^",2)=Y G E1
E2 R !!,"Do you wish to delete any items? NO// ",YN:DTIME G:'$T!(YN["^") KIL S:YN="" YN="N" S X=YN D TR^FH S YN=X
 I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7,!,"  Answer YES or NO" G E2
 G E4:YN?1"N".E
E3 R !,"Delete item # : ",X:DTIME G KIL:'$T,E4:X="",ED:X["^" I X'?1N.N!(X<1)!(X>NM) W *7,"  ??" G E3
 S X=$P(XT,",",X) K FHM(X),^FHUM(MENU,1,DAY,1,MEAL,1,X,0) W " ... deleted"
 S $P(^FHUM(MENU,1,DAY,1,MEAL,1,0),U,4)=$P(^FHUM(MENU,1,DAY,1,MEAL,1,0),U,4)-1 G E3
E4 R !!,"Do you wish to add more food items? NO// ",YN:DTIME G:'$T!(YN["^") KIL S:YN="" YN="N" S X=YN D TR^FH S YN=X
 I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7,!,"  Answer YES or NO" G E4
 G E6:YN?1"N".E
E5 D ^FHNU7 I FFN="" G E6
 I $D(^FHUM(MENU,1,DAY,1,MEAL,1,FFN,0)) S $P(^(0),"^",2)=AMT G E5
 S $P(^FHUM(MENU,1,DAY,1,MEAL,1,0),U,3,4)=FFN_"^"_($P(^FHUM(MENU,1,DAY,1,MEAL,1,0),U,4)+1)
 S ^FHUM(MENU,1,DAY,1,MEAL,1,FFN,0)=FFN_"^"_AMT G E5
E6 I $O(^FHUM(MENU,1,DAY,1,MEAL,1,0))>0 G ED
 K ^FHUM(MENU,1,DAY,1,MEAL) W !!?5,"No Items Remain - Meal Deleted!"
 S $P(^FHUM(MENU,1,DAY,1,0),U,4)=$P(^FHUM(MENU,1,DAY,1,0),U,4)-1
 I $O(^FHUM(MENU,1,DAY,1,0))>0 W ! G SEL
 K ^FHUM(MENU,1,DAY) W !?5,"No Meals Remain - Day Deleted!"
 S $P(^FHUM(MENU,1,0),U,4)=$P(^FHUM(MENU,1,0),U,4)-1 W ! G SEL
KIL G KILL^XUSCLEAN
LIS W @IOF,!!,"Current Food List for Menu: ",MNAM,"     Day: ",DAY,"     Meal: ",MEAL,! S (NX,NM)=0,XT="",UNIT="gm." K FHM
L1 S NX=$O(^FHUM(MENU,1,DAY,1,MEAL,1,NX)) I NX="" W:'NM !?5,"No items selected." Q
 S AMT=$P(^FHUM(MENU,1,DAY,1,MEAL,1,NX,0),"^",2),X=^FHNU(NX,0),NM=NM+1 I TYP="C" S UNIT=$P(X,"^",3),WT=$P(X,"^",4) D UNT
 S XT=XT_NX_",",FHM(NX)=AMT I TYP="C" S FHM(NX)=FHM(NX)_","_UNIT_","_WT
 W !,$J(NM,4,0),"  ",$P(X,"^",1)," - ",AMT," ",UNIT G L1
UNT I AMT'>1,UNIT'["." S L=$L(UNIT)-1,L=$S($E(UNIT,L)'="e":L,"hos"'[$E(UNIT,L-1):L,1:L-1),UNIT=$E(UNIT,1,L) I $E(UNIT,L-1,L)="ie" S UNIT=$E(UNIT,1,L-2)_"y"
 Q
