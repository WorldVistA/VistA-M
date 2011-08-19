PSIVDRG ;BIR/PR-ADD OR EDIT IV DRUGS ; 15 May 98 / 9:26 AM
 ;;5.0; INPATIENT MEDICATIONS ;**3**;16 DEC 97
ENS ;Enter here to enter/edit solutions
 S DRUGEDIT=1,FI=52.7 L +^PS(FI):1 E  W $C(7),!!,"Someone else is entering drugs ... try later !",!! G K
ENS1 ;
 N DA,DIC,DLAYGO S DIC=FI,DIC(0)="AEQML",DLAYGO=52.7 D ^DIC I Y<0 G K1
 S DRUG=+Y,DIE=DIC,DA=+Y,DR=".01:.02;1;D GETD^PSIVDRG;2:8;10:15;17:99999" D ^DIE G ENS1
 ;
ENA ;Enter here to enter/edit additives.
 S DRUGEDIT=1,FI=52.6 L +^PS(FI):1 E  W $C(7),!!,"Someone else is entering drugs ... try later !",!! G K
ENA1 ;
 Q  ; no longer used in 5.0  now in PSSIVDRG
 ;N DA,DIC,DIE,DLAYGO S DIC=FI,DIC(0)="AEQL",DLAYGO=52.6 D ^DIC I Y<0 G K1
 ;S DRUG=+Y,DIE=DIC,DA=+Y,DR="[PSJI ADD]" D ^DIE G ENA1
 ;Q
ENC ;Enter here to enter/edit IV Categories
 D ^PSIVXU Q:$D(XQUIT)  K DA,DIC,DIE,DR,DLAYGO S DIC="^PS(50.2,",DIC(0)="AEQL",DLAYGO=50.2 D ^DIC G:Y<0 K S DIE=DIC,DR=".01;1",DA=+Y D ^DIE G K
 Q
 ;
K1 ;
 L -^PS(FI)
K D ENIVKV^PSGSETU
KDRG K B,DA,DG,DIC,DIE,DIJ,DIX,DIY,DIYS,DLAYGO,DO,DRUG,DRUGEDIT,FI,I,J,P,PSIV,PSIVAT,PSIVDRG,PSIVSC,XT,Z
 Q
 ;
GETD ;See if generic drug is inactive in file 50.
 I $D(^PSDRUG(X,"I")),^("I"),(DT+1>+^("I")) W $C(7),$C(7),!!,"This drug is inactive and will not be selectable during IV order entry.",! S ^PS(FI,DRUG,"I")=^PSDRUG(X,"I")
 Q
ENTDRG ;
 ;Will print word-processing field in IV add. file (52.6) and
 ;IV sol. file (52.7)
 N P W !!,"Are you inquiring on" S X="... an IV ADDITIVE or IV SOLUTION (A/S): ^ADDITIVE^^ADDITIVE,SOLUTION" D ENQ^PSIV S X=$E(X) Q:"^"[X  I X["?" S HELP="DRGINQ" D ^PSIVHLP1 G ENTDRG
 S FI=$S(X["A":52.6,1:52.7) N D0,D1,DA,DI,DIE,DP,DR,DQ
DRG F Y=0:0 W ! K DA,DIC S DIC="^PS("_FI_",",DIC(0)="QEAM" D ^DIC G:Y<0 KDRG S PSIVDRG=+Y D WPH,WP
 G KDRG
WPH ;
 W:$Y @IOF W ! F Y=1:1:79 W "-"
 W !,"Drug information on: ",$P(^PS(FI,PSIVDRG,0),"^")
 W !?7,"Last updated: " W:'$D(^PS(FI,PSIVDRG,4,0)) "N/A" I $D(^(0)) S Y=$P(^(0),"^",5) X ^DD("DD") W $P(Y,"@")," ",$P(Y,"@",2)
 W ! Q
WP W ! I '$D(^PS(FI,PSIVDRG,4,0)) W !,"*** No information on file. ***"
 F Z=0:0 S Z=$O(^PS(FI,PSIVDRG,4,Z)) Q:'Z  W !,^(Z,0) I $Y+5>IOSL W $C(7),!!,"Press return key: " R I:DTIME Q:'$T!(I["^")  D WPH
 W ! F Y=1:1:79 W "-"
 Q
ENT ;
 ;Will print out information on IV DRUGS
BEG W !!,"Are you printing drug information from ..." S X="the IV ADDITIVE file or IV SOLUTION file ? ^ADDITIVE^^ADDITIVE,SOLUTION" D ENQ^PSIV G:"^"[X K I X["?" S HELP="DRGINQ" D ^PSIVHLP1 G BEG
 S L=0,DIC="^PS("_$S(X["A":52.6,1:52.7)_"," D EN1^DIP D ^%ZISC G K
ELECTRO ;Edit Electrolyte file
 D ^PSIVXU Q:$D(XQUIT)  K DA,DIC S DIC="^PS(50.4,",DIC(0)="AEQLM",DLAYGO=50.4 D ^DIC G:Y<0 K
 S DIE=DIC,DR="[PSJIDE]",DA=+Y D ^DIE G ELECTRO
 Q
