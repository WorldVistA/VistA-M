PSSVIDRG ;BIR/PR,WRT-ADD OR EDIT IV DRUGS ;June 3, 2018@20:00
 ;;1.0;PHARMACY DATA MANAGEMENT;**2,10,32,38,125,146,174,189,229**;9/30/97;Build 1
 ;
 ;Reference to ENIVKV^PSGSETU is supported by DBIA # 2153.
 ;Reference to ^PSIV is supported by DBIA # 2155.
 ;Reference to ^PSIVHLP1 is supported by DBIA # 2156.
 ;Reference to ^PSIVXU is supported by DBIA # 2157.
 ;
ENS ;Enter here to enter/edit solutions
 N FI,PSPRNM S DRUGEDIT=1,FI=52.7
 L +^PS(FI):$S($G(DILOCKTM)>0:DILOCKTM,1:3) E  W $C(7),!!,"Someone else is entering drugs ... try later !",!! G K
ENS1 ;
 ; PSS*1*146 Compare and confirm SOLUTION Print name change
 N DA,DIC,DLAYGO,II,PSDA,PSI,PSSY,PSSDG,PSSEL1,PSSDRG
NS2 S PSI=0 I $G(DISPDRG),$O(^PS(52.7,"AC",DISPDRG,0)) S PSSY=0 F  S PSSY=$O(^PS(52.7,"AC",DISPDRG,PSSY)) Q:'PSSY  S PSI=PSI+1,PSSY(PSI)=PSSY
 ;I PSI=1 S DIC("B")=$G(PSSY(1)) S DIC=FI,DIC(0)="QEALMNTV",DLAYGO=52.7,DIC("T")="" D ^DIC I Y<0 K PSFLGA G K1
 I PSI=0 S DIC=FI,DIC(0)="QEALMNTV",DLAYGO=52.7 D ^DIC I Y<0 K PSFLGA G K1
 ;
ENS2 ; IV Solutions Editing
 N PSSQOX
 S PSSQUIT=0,PSSQOX=1
 I '$G(PSFLGA)&(PSI>0) F  D  Q:$G(Y)
 . W !!," ",$$GET1^DIQ(50,DISPDRG,.01)," currently linked to IV Solutions:",!
 . S (PSDA,II)=0 F  S PSDA=$O(PSSY(PSDA)) Q:'PSDA  S II=II+1 W !,?3,II_". ",$P(^PS(52.7,$G(PSSY(PSDA)),0),"^")_"   "_$P(^PS(52.7,$G(PSSY(PSDA)),0),"^",3)
 . W !!,"Select "_$S(PSI=1:1,1:"1-"_PSI)_" from list above or type 'NEW' to link to a new IV Solution: "
 . R X:DTIME I '$T!("^"[X) S Y=-1 Q
 . W ! I $$UP^XLFSTR(X)="NEW" D NEW(52.7) Q
 . I '$D(PSSY(X)) W !!,"Select the number corresponding to the IV SOLUTION you want to edit",!,"or type 'NEW' to link ",$$GET1^DIQ(50,DISPDRG,.01)," to a new IV SOLUTION.",$C(7) Q
 . I $D(PSSY(X)) S Y=$G(PSSY(X))
 G K1:($G(Y)<0)
 W ! K PSSEL1 S PSSASK="SOLUTIONS",DRUG=+Y,DIE=FI,(DA,ENTRY)=+Y,DR=".01" D EECK G K1:$G(PSSEL1)="^" I $G(PSSEL1)=2 S Y=0 W ! G NS2
 N PSSQUIT,PSSINADT S PSSQUIT=0
 S PSSINADT=$$GET1^DIQ(52.7,ENTRY,8,"I")
 S PSSDRG=$P($G(^PS(52.7,ENTRY,0)),"^",2),DA=ENTRY
 S DIE="^PS(52.7,",DR="D PRNMHD^PSSVIDRG;.01;.01///^S X=$$PRNM^PSSVIDRG();.02;"
 S DR=DR_"1///^S X=$$GEND^PSSVIDRG($S($G(DISPDRG):DISPDRG,$G(PSSDRG):PSSDRG,1:""""));D GETD^PSSVIDRG;"
 S DR=DR_"2:7;@8;8;D IVSOLINA^PSSVIDRG;10:15;17:99999"
 N PSSENTRY I $G(DA) S PSSENTRY=DA D ^DIE I '$G(PSSQUIT) S PSSQOX=0 D MFS^PSSDEE K PSFLGS,PSSY
 Q
ENA ;Enter here to enter/edit additives.
 N FI,PSPRNM S DRUGEDIT=1,FI=52.6
 L +^PS(FI):$S($G(DILOCKTM)>0:DILOCKTM,1:3) E  W $C(7),!!,"Someone else is entering drugs ... try later !",!! G K
 ;
ENA1 ;
 ; PSS*1*146 Compare and confirm ADDITIVE Print name change
 N DA,DIC,DIE,DLAYGO,PSI,PSSY,PSSEL1,PSSDRG
NA2 S PSI=0
 I $G(DISPDRG),$O(^PS(52.6,"AC",DISPDRG,0)) D
 . S PSSY=0 F  S PSSY=$O(^PS(52.6,"AC",DISPDRG,PSSY)) Q:'PSSY  S PSI=PSI+1,PSSY(PSI)=PSSY
 ;I PSI=1 S DIC("B")=$G(PSSY(1)) S DIC=FI,DIC(0)="QEALMNTV",DLAYGO=52.6,DIC("T")="" D ^DIC I Y<0 K PSFLGA G K1
 I PSI=0 S DIC=FI,DIC(0)="QEALMNTV",DLAYGO=52.6 D ^DIC I Y<0 K PSFLGA G K1
 ;
ENA2 ; IV Additives Editing
 N PSSQOX
 S PSSQUIT=0,PSSQOX=1
 I '$G(PSFLGA)&(PSI>0) F  D  Q:$G(Y)
 . W !!," ",$$GET1^DIQ(50,DISPDRG,.01)," currently linked to the following IV Additives:",!
 . S (PSDA,II)=0 F  S PSDA=$O(PSSY(PSDA)) Q:'PSDA  D
 .. S PSSY15=$P(^PS(52.6,$G(PSSY(PSDA)),0),"^",15) I $E($G(PSSY15))="." S PSSY15="0"_PSSY15
 .. S II=II+1 W !,?3,II_". ",$P(^PS(52.6,$G(PSSY(PSDA)),0),"^"),?32,"Additive Strength: "_$S($G(PSSY15)="":"N/A",1:$G(PSSY15))_" "_$S($G(PSSY15)="":"",1:$$GET1^DIQ(52.6,$G(PSSY(PSDA)),2))
 .. W:$D(^PSDRUG(+$P(^PS(52.6,$G(PSSY(PSDA)),0),"^",2),0)) !?15,$P(^(0),"^",10)
 .. F PSIV=0:0 S PSIV=$O(^PS(52.6,$G(PSSY(PSDA)),1,PSIV)) Q:'PSIV  D
 ... W !?7,"- ",$P(^(PSIV,0),"^")," -        Quick Code Strength: ",$S($P($G(^PS(52.6,$G(PSSY(PSDA)),1,PSIV,0)),"^",2)'="":$P($G(^PS(52.6,$G(PSSY(PSDA)),1,PSIV,0)),"^",2),1:"N/A")
 ... W "     Schedule: ",$S($P($G(^PS(52.6,$G(PSSY(PSDA)),1,PSIV,0)),"^",5)'="":$P($G(^PS(52.6,$G(PSSY(PSDA)),1,PSIV,0)),"^",5),1:"N/A"),!
 . W !!,"Select "_$S(PSI=1:1,1:"1-"_PSI)_" from list above or type 'NEW' to link to a new IV Additive: "
 . R X:DTIME I '$T!("^"[X) S Y=-1 Q
 . W ! I $$UP^XLFSTR(X)="NEW" D NEW(52.6) Q
 . I '$D(PSSY(X)) W !!,"Select the number corresponding to the IV ADDITIVE you want to edit",!,"or type 'NEW' to link ",$$GET1^DIQ(50,DISPDRG,.01)," to a new IV ADDITIVE.",$C(7) Q
 . I $D(PSSY(X)) S Y=$G(PSSY(X))
 G K1:($G(Y)<0)
 K PSSEL1 S PSSASK="ADDITIVES",DRUG=+Y,DIE=FI,(DA,ENTRY)=+Y D EECK  G K1:$G(PSSEL1)="^" I $G(PSSEL1)=2 S Y=0 W ! G NA2
 S PSSDRG=$P($G(^PS(52.6,ENTRY,0)),"^",2),DIE="^PS(52.6,",DA=ENTRY,DR="[PSSIV ADD]"
 N PSSENTRY I '$G(PSSQUIT),$G(DA) S PSSENTRY=DA D ^DIE S ENTRY=PSSENTRY,PSSQOX=0 D MFA^PSSDEE
 K PSFLGA,PSSY,PSSY15
 Q
ENC ;Enter here to enter/edit IV Categories
 ;S X="PSIVXU" X ^%ZOSF("TEST") I  D ^PSIVXU Q:$D(XQUIT)  K DA,DIC,DIE,DR,DLAYGO S DIC="^PS(50.2,",DIC(0)="AEQL",DLAYGO=50.2 D ^DIC G:Y<0 K S DIE=DIC,DR=".01;1",DA=+Y D ^DIE G K
 Q
K1 ;
 L -^PS(FI)
K S X="PSGSETU" X ^%ZOSF("TEST") I  D ENIVKV^PSGSETU
KDRG K B,DA,DG,DIC,DIE,DIJ,DIX,DIY,DIYS,DLAYGO,DO,DRUG,DRUGEDIT,FI,I,J,P,PSIV,PSIVAT,PSSIVDRG,PSIVSC,XT,Z
 Q
 ;
GETD ;See if generic drug is inactive in file 50.
 I $D(^PSDRUG(X,"I")),^("I"),(DT+1>+^("I")) D
 . W $C(7),$C(7),!!,"This drug is inactive and will not be selectable during IV order entry.",!
 . S ^PS(FI,DRUG,"I")=^PSDRUG(X,"I")
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
EECK I $D(PSSZ) S FILE=$S(PSSASK="ADDITIVES":$G(^PS(52.6,ENTRY,0)),1:$G(^PS(52.7,ENTRY,0))),PSSIEN=$P(FILE,"^",2) D:PSSIEN']"" PASSIN I PSSIEN'=DISPDRG D:$D(^PSDRUG(PSSIEN)) ECK,EECK1 D
 . W !,"Do you really want to link this ",$S(PSSASK="ADDITIVES":"Additive",1:"Solution")," to ",$P(^PSDRUG(DISPDRG,0),"^",1)
 . F  S %=2 D YN^DICN Q:%  W !,"  (A 'YES' or 'NO' response is required.)"
 . I %Y="^" S PSSEL1="^" Q
 . S PSSEL1=%
 Q
EECK1 Q:'$D(^PSDRUG(PSSIEN,0))  W !,"This Additive or Solution is linked to ",$P(^PSDRUG(PSSIEN,0),"^",1),".",!,"You are editing dispense drug ",$P(^PSDRUG(DISPDRG,0),"^",1),".",!
 Q
ECK W !,"You are editing a Additive or Solution which is linked to a different",!,"dispense drug from the one you are currently editing."
 Q
SOI I $D(^PS(59.7,1,80)),$P(^PS(59.7,1,80),"^",2)>1 W !!,"You are NOW in the ORDERABLE ITEM matching for Solutions." S Y=ENTRY_"^"_$P(^PS(52.7,ENTRY,0),"^",1),PSMASTER=1 D MAS^PSSSOLIT K PSMASTER
 Q
ADDOI I $D(^PS(59.7,1,80)),$P(^PS(59.7,1,80),"^",2)>1 W !!,"You are NOW in the ORDERABLE ITEM matching for Additives." S Y=ENTRY_"^"_$P(^PS(52.6,ENTRY,0),"^",1),PSMASTER=1 D MAS^PSSADDIT K PSMASTER
 Q
PASSIN S FILE=$S(PSSASK="ADDITIVES":$G(^PS(52.6,ENTRY,0)),1:$G(^PS(52.7,ENTRY,0))) S (X,PSSIEN)=DISPDRG ;146
 Q
MASTER F PSSOR=0:0 S PSSOR=$O(^PS(50.7,PSSOR)) Q:'PSSOR  D EN2^PSSHL1(PSSOR,"MUP")
 Q
PRNMHD ; PSS*1*146 Hold the print name when editing
 N FI K PSPRNM
 S FI=DIC I FI'["^" S FI="^PS("_FI_","
 S FI=FI_DA_",0)",PSPRNM=$P($G(@FI),"^")
 Q
PRNM() ; PSS*1*146 compare and confirm Print name change
 N PRNMDONE,%,FI,PRNAME,DUP,DUPLIC S PRNMDONE=0
 S FI=DIC I FI'["^" S FI="^PS("_FI_","
 S FI=FI_DA_",0)",PRNAME=$P($G(@FI),"^")
 I (PSPRNM]"")&(PRNAME]"")&(PSPRNM'=PRNAME) F  Q:$G(PRNMDONE)  D
 . W !,"  ARE YOU SURE YOU WANT TO CHANGE THE PRINT NAME TO "_PRNAME
 . S %=2 D YN^DICN
 . S:(%=1) PSPRNM=PRNAME S:% PRNMDONE=1
 . I %Y="^" S PSSQUIT=1,PRNMDONE=1
 . I 'PRNMDONE W !,"  Answer with 'Yes' or 'No'.",$C(7),! Q
 . W !,"  PRINT NAME set to "_PSPRNM
 Q PSPRNM
GEND(CUR) ;PSS*1*146
 ;Ask and Confirm generic drug.
 ;Returns Selected drug IEN (file 50)
 ; CUR -> Default (Current Drug)
 N DIC,%,PSSEL,Y,X
 S PSSEL=0,DIC=50,DIC("A")="GENERIC DRUG: ",DIC(0)="AEMQ",DIC("B")=$S($G(CUR):CUR,1:"")
 F  D  Q:PSSEL=1
 . D ^DIC W:(Y>0)&($G(CUR)']"") " ??" I $G(CUR)]""!(Y'>0),$G(DUOUT)!$G(DTOUT) S PSSEL=1,PSSQUIT=1 Q
 . I +Y=+CUR D  I PSSEL=1 Q
 . . I PSSASK="ADDITIVES",$D(^PS(52.6,"AC",+Y,+$G(DA))) S PSSEL=1 Q
 . . I PSSASK="SOLUTIONS",$D(^PS(52.7,"AC",+Y,+$G(DA))) S PSSEL=1 Q
 . I Y>0 F  D  Q:$G(PSSEL)
 . . N CURADD,CURGEND
 . . S CURADD=$S($G(PSSASK)="ADDITIVES":$$GET1^DIQ(52.6,$G(DA),.01,"E"),1:$$GET1^DIQ(52.7,$G(DA),.01,"E"))
 . . S CURGEND=$$GET1^DIQ($S($G(PSSASK)="ADDITIVES":52.6,1:52.7),$G(DA),1,"E")
 . . W !!,"  You are about to change the GENERIC DRUG linked to this "_$S($G(PSSASK)="ADDITIVES":"ADDITIVE.",1:"SOLUTION.")
 . . W !,"  "_$S($G(PSSASK)="ADDITIVES":"ADDITIVE",1:"SOLUTION")_" "_$G(CURADD)_" is "_$S($G(CURGEND)="":"not ",1:"")_"currently linked to "_$S($G(CURGEND)="":"any",1:"")
 . . W !,"  GENERIC DRUG "_$G(CURGEND)_"."
 . . W !!,"  Are you sure you want to link "_$S($G(PSSASK)="ADDITIVES":"ADDITIVE",1:"SOLUTION")_" "_$G(CURADD)
 . . W !,"  to GENERIC DRUG "_$$GET1^DIQ(50,+Y,.01,"E")
 . . S %=2 D YN^DICN S:% PSSEL=% I %Y="^" S PSSQUIT=1,DUOUT=1,PSSEL=1 Q
 . . I 'PSSEL W !,"   Answer with 'Yes' or 'No'.",$C(7),! Q
 Q $S($G(DUOUT)!$G(DTOUT)!(Y<0):"^",1:+Y)
 ;
NEW(FI) ; add new additive/solution
 N DA,DIC,DIE,DR,DLAYGO
 S (DLAYGO,DIC)=FI,DIC(0)="QEALMNTV",DIC("T")="" D ^DIC K DIC
 Q
 ;
IVSOLINA ; Checking for Duplicate IV Solution Volume when INACTIVATION DATE is removed
 ; Global variable: PSSINADT - INACTIVATION DATE value being deleted
 I '$G(PSSINADT),$$GET1^DIQ(52.7,DA,8,"I") S PSSINADT=$$GET1^DIQ(52.7,DA,8,"I")
 ;I +$G(PSSINADT),('X&PSSINADT)!(X&(X'=PSSINADT)) D
 I 'X!(X>DT) D
 . N OI
 . I $$GET1^DIQ(52.7,DA,17,"I") D
 . . S OI=+$$GET1^DIQ(52.7,DA,9,"I")
 . . I $$CKDUPSOL^PSSDDUT2(OI,DA,+$$GET1^DIQ(52.7,DA,2),1) D
 . . . S $P(^PS(52.7,DA,"I"),"^")=$G(PSSINADT)
 . . . S Y="@8"
 . . E  S PSSINADT=X
 E  S PSSINADT=X
 Q
