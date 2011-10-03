DGTEMP ;ALB/MRL - ADT TEMPLATE SELECTION ; 11 MAY 87
 ;;5.3;Registration;;Aug 13, 1993
1 I '$D(^DG(43.7,"AI",+X)) S C=1 G END
 S X1=$O(^DG(43.7,"AI",+X,0)) I '$D(^DG(43.7,+X1,0)) S C=1 G END
 S DGD=^DG(43.7,+X1,0),DGTMP=$P(DGD,"^",4) I "^E^S^P^"'[("^"_DGTMP_"^") S C=2 G END
 S DGTMP1=$P(DGD,"^",$S(DGTMP="P":6,DGTMP="E":5,1:7)),DGG="^"_$S(DGTMP="P":"DIPT",DGTMP="E":"DIE",1:"DIBT")_"("_DGTMP1_",0)" I $D(@DGG) S X="["_$P(@DGG,"^",1)_"]" G Q
END S DGNO=1 W !!,*7,"Unable to run option..." I C=1 W "This option is not defined in the ADT TEMPLATE file!" G Q
 I C=2 W "Template Type not defined!" G Q
 W "Selected template doesn't exist in '",$S(DGTMP="P":"PRINT",DGTMP="E":"INPUT",1:"SORT"),"' TEMPLATE file!"
Q K DIE,C,DA,Y,DR,DGN,DGEDIT,DGG,DGD,DGSORT,DGTMP,DGTMP1,I,X1 Q
2 W !! S DGEDIT=1,DIC="^DG(43.7,",DIC(0)="AEQMZL",DIC("A")="Edit which TEMPLATE:  " D ^DIC K DIC G Q:Y'>0 S DGD=+Y
 S (DA,Y)=DGD,DIE=DIC,DR=".01;2:4;S Y=$S(X=""P"":6,X=""E"":5,1:7);5;S Y=8;6;S Y=8;7:8" D ^DIE K DR G 2
EDIT ;Enter Local Template Name
 W !! S DGEDIT=1,DIC="^DG(43.7,",DIC(0)="AEQMZ",DIC("A")="Select ADT TEMPLATE Option:  " D ^DIC K DIC("A") G Q:Y'>0 S DGD=+Y,DGN=^DG(43.7,+Y,0)
 W !,"[DISTRIBUTED '",$S($P(DGN,"^",4)="P":"PRINT",$P(DGN,"^",4)="E":"INPUT",1:"SORT"),"' TEMPLATE NAME IS '",$P(DGN,"^",8),"']"
 S (DA,Y)=DGD,DIE=DIC,DR=$S($P(DGN,"^",4)="P":6,$P(DGN,"^",4)="E":5,1:7)_";" D ^DIE K DR G EDIT
STAN ;Set Standard [distributed] Template name
 F I=0:0 S I=$O(^DG(43.7,I)) Q:'I  I $D(^(I,0)) S DGD=^(0),DGX=$P(DGD,"^",8),(DGEDIT,DGTEMPE)="" D S1
 K DA,X,Y,DIC,I,DGX,DGD,DR,DIE,DGTEMPE,DGEDIT Q
S1 I DGX']"" W !,"No '",DGX,"' template on file for '",$P(DGD,"^",1),"'." Q
 W !,"'",DGX,"' template filed for '",$P(DGD,"^",1),"'." S (DA,Y)=+I,DIE="^DG(43.7,",DIC(0)="E",DR=$S($P(DGD,"^",4)="P":6,$P(DGD,"^",4)="E":5,1:7)_"///^S X=DGX" D ^DIE Q
