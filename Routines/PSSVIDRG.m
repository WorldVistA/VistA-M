PSSVIDRG ;BIR/PR,WRT-ADD OR EDIT IV DRUGS ; 04/17/98 9:13
 ;;1.0;PHARMACY DATA MANAGEMENT;**2,10,32,38,125**;9/30/97;Build 2
 ;
 ;Reference to ENIVKV^PSGSETU is supported by DBIA # 2153.
 ;Reference to ^PSIV is supported by DBIA # 2155.
 ;Reference to ^PSIVHLP1 is supported by DBIA # 2156.
 ;Reference to ^PSIVXU is supported by DBIA # 2157.
 ;
ENS ;Enter here to enter/edit solutions
 S DRUGEDIT=1,FI=52.7 L +^PS(FI):$S($G(DILOCKTM)>0:DILOCKTM,1:3) E  W $C(7),!!,"Someone else is entering drugs ... try later !",!! G K
ENS1 ;
 N DA,DIC,DLAYGO S DIC=FI,DIC(0)="AEQML",DLAYGO=52.7 D ^DIC I Y<0 G K1
 S PSSASK="SOLUTIONS",DRUG=+Y,DIE=DIC,(DA,ENTRY)=+Y,DR=".01:.02" D ^DIE,EECK S DIE="^PS(52.7,",DA=ENTRY,DR="1;D GETD^PSSVIDRG;2:8;10:15;17:99999" D ^DIE,MFS^PSSDEE
 Q
 ;
ENA ;Enter here to enter/edit additives.
 S DRUGEDIT=1,FI=52.6 L +^PS(FI):$S($G(DILOCKTM)>0:DILOCKTM,1:3) E  W $C(7),!!,"Someone else is entering drugs ... try later !",!! G K
ENA1 ;
 N DA,DIC,DIE,DLAYGO S DIC=FI,DIC(0)="AEQL",DLAYGO=52.6 D ^DIC I Y<0 G K1
 S PSSASK="ADDITIVES",DRUG=+Y,DIE=DIC,(DA,ENTRY)=+Y,DR=".01" D EECK S DIE="^PS(52.6,",DA=ENTRY,DR="[PSSIV ADD]" D ^DIE,MFA^PSSDEE
 Q
ENC ;Enter here to enter/edit IV Categories
 ;S X="PSIVXU" X ^%ZOSF("TEST") I  D ^PSIVXU Q:$D(XQUIT)  K DA,DIC,DIE,DR,DLAYGO S DIC="^PS(50.2,",DIC(0)="AEQL",DLAYGO=50.2 D ^DIC G:Y<0 K S DIE=DIC,DR=".01;1",DA=+Y D ^DIE G K
 Q
 ;
K1 ;
 L -^PS(FI)
K S X="PSGSETU" X ^%ZOSF("TEST") I  D ENIVKV^PSGSETU
KDRG K B,DA,DG,DIC,DIE,DIJ,DIX,DIY,DIYS,DLAYGO,DO,DRUG,DRUGEDIT,FI,I,J,P,PSIV,PSIVAT,PSSIVDRG,PSIVSC,XT,Z
 Q
 ;
GETD ;See if generic drug is inactive in file 50.
 I $D(^PSDRUG(X,"I")),^("I"),(DT+1>+^("I")) W $C(7),$C(7),!!,"This drug is inactive and will not be selectable during IV order entry.",! S ^PS(FI,DRUG,"I")=^PSDRUG(X,"I")
 Q
ENTDRG ;This module is no longer utilized by the Inpatient Medications application.
 ;Will print word-processing field in IV add. file (52.6) and
 ;IV sol. file (52.7).
 ;
 Q
 ;S X="PSIV" X ^%ZOSF("TEST") I  D ^PSIV Q:$D(XQUIT)
 S X="PSIV" X ^%ZOSF("TEST") I  D ^PSIVHLP1 Q:$D(XQUIT)
 N P W !!,"Are you inquiring on" S X="... an IV ADDITIVE or IV SOLUTION (A/S): ^ADDITIVE^^ADDITIVE,SOLUTION" D ENQ^PSIV S X=$E(X) Q:"^"[X  I X["?" S HELP="DRGINQ" D ^PSIVHLP1 G ENTDRG
 S FI=$S(X["A":52.6,1:52.7) N D0,D1,DA,DI,DIE,DP,DR,DQ
DRG F Y=0:0 W ! X ^DD(55.11,.01,12.1) K DA,DIC S DIC="^PS("_FI_",",DIC(0)="QEAM" D ^DIC G:Y<0 KDRG S PSSIVDRG=+Y D WPH,WP
 G KDRG
WPH ;
 W:$Y @IOF W ! F Y=1:1:79 W "-"
 W !,"Drug information on: ",$P(^PS(FI,PSSIVDRG,0),"^")
 W !?7,"Last updated: " W:'$D(^PS(FI,PSSIVDRG,4,0)) "N/A" I $D(^(0)) S Y=$P(^(0),"^",5) X ^DD("DD") W $P(Y,"@")," ",$P(Y,"@",2)
 W ! Q
WP W ! I '$D(^PS(FI,PSSIVDRG,4,0)) W !,"*** No information on file. ***"
 F Z=0:0 S Z=$O(^PS(FI,PSSIVDRG,4,Z)) Q:'Z  W !,^(Z,0) I $Y+5>IOSL W $C(7),!!,"Press return key: " R I:DTIME Q:'$T!(I["^")  D WPH
 W ! F Y=1:1:79 W "-"
 Q
ENT ;
 ;Will print out information on IV DRUGS
 Q
 ;S X="PSIV" X ^%ZOSF("TEST") I  D ^PSIV Q:$D(XQUIT)
        S X="PSIV" X ^%ZOSF("TEST") I  D ^PSIVHLP1 Q:$D(XQUIT)
 ;
BEG W !!,"Are you printing drug information from ..." S X="the IV ADDITIVE file or IV SOLUTION file ? ^ADDITIVE^^ADDITIVE,SOLUTION" D ENQ^PSIV G:"^"[X K I X["?" S HELP="DRGINQ" D ^PSIVHLP1 G BEG
 S L=0,DIC="^PS("_$S(X["A":52.6,1:52.7)_"," D EN1^DIP D ^%ZISC G K
ELECTRO ;Edit Electrolyte file
 S X="PSIVXU" X ^%ZOSF("TEST") I  D ^PSIVXU Q:$D(XQUIT)  K DA,DIC S DIC="^PS(50.4,",DIC(0)="AEQLM",DLAYGO=50.4 D ^DIC G:Y<0 K
 S DIE=DIC,DR="[PSSJIDE]",DA=+Y D ^DIE G ELECTRO
 Q
EECK I $D(PSSZ) S:PSSASK="ADDITIVES" FILE=^PS(52.6,ENTRY,0) S:PSSASK="SOLUTIONS" FILE=^PS(52.7,ENTRY,0) S PSSIEN=$P(FILE,"^",2) D:PSSIEN']"" PASSIN I PSSIEN'=DISPDRG D ECK,EECK1
 Q
EECK1 W !,"This Additive or Solution is tied to ",$P(^PSDRUG(PSSIEN,0),"^",1),".",!,"You are editing dispense drug ",$P(^PSDRUG(DISPDRG,0),"^",1),".",!
 Q
ECK W !,"You are editing a Additive or Solution which is tied to a different",!,"dispense drug from the one you are currently editing."
 Q
SOI I $D(^PS(59.7,1,80)),$P(^PS(59.7,1,80),"^",2)>1 W !!,"You are NOW in the ORDERABLE ITEM matching for Solutions." S Y=ENTRY_"^"_$P(^PS(52.7,ENTRY,0),"^",1),PSMASTER=1 D MAS^PSSSOLIT K PSMASTER
 Q
ADDOI I $D(^PS(59.7,1,80)),$P(^PS(59.7,1,80),"^",2)>1 W !!,"You are NOW in the ORDERABLE ITEM matching for Additives." S Y=ENTRY_"^"_$P(^PS(52.6,ENTRY,0),"^",1),PSMASTER=1 D MAS^PSSADDIT K PSMASTER
 Q
PASSIN S:PSSASK="ADDITIVES" ROOT="^PS(52.6," S:PSSASK="SOLUTIONS" ROOT="^PS(52.7," S DIE=ROOT,DA=ENTRY,DR="1////"_DISPDRG D ^DIE D RFILE S X=DISPDRG
 Q
RFILE S:PSSASK="ADDITIVES" FILE=^PS(52.6,ENTRY,0) S:PSSASK="SOLUTIONS" FILE=^PS(52.7,ENTRY,0) S PSSIEN=$P(FILE,"^",2)
 Q
MASTER F PSSOR=0:0 S PSSOR=$O(^PS(50.7,PSSOR)) Q:'PSSOR  D EN2^PSSHL1(PSSOR,"MUP")
 Q
