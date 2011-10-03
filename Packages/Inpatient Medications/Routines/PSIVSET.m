PSIVSET ;BIR/PR-IV PACKAGE ENTRY POINT ;12 DEC 97 / 9:18 AM 
 ;;5.0; INPATIENT MEDICATIONS ;**35,81,91**;16 DEC 97
 ;
 ; Reference to ^PS(59.7 is supported by DBIA# 2181.
 ;
 D NOW^%DTC S Y=%
 ;W !!,"INPATIENT MEDICATIONS (IV) (Version: ",$P($P($T(PSIVSET+1),";;",2)," ",1,2),")",!
ENOR ;
 S (PSIVCT,PSIVSN)=0 D NOW^%DTC F X=0:0 S X=$O(^PS(59.5,X)) Q:'X  D
 .I $S(+'$G(^PS(59.5,X,"I")):1,+$G(^PS(59.5,X,"I"))>%:1,1:0) S PSIVCT=PSIVCT+1 S PSIVSN=X
 I PSIVCT=1 D ENCHK I $D(%) S:%=-1!(%=2) XQUIT="" G:%=2!(%=-1) Q1
 ;I PSIVCT=1 S PSIVSN=$O(^PS(59.5,0)) D ENCHK I $D(%) S:%=-1!(%=2) XQUIT="" G:%=2!(%=-1) Q1
MULT ;
 I PSIVCT>1 K DIC S DIC="^PS(59.5,",DIC(0)="QEAM",DIC("S")="I $S($P($G(^(""I"")),U)="""":1,1:$P(^(""I""),U)>DT)" D ^DIC K DIC S:Y<0 XQUIT="" Q:Y<0  S PSIVSN=+Y D ENCHK I $D(%) G:%=2 MULT S:%=-1 XQUIT="" G:%=-1 Q1
 I 'PSIVCT W !!,"Whoops ... You don't have an IV ROOM defined ... ",!,"You MUST define at least one IV ROOM before you can continue.",! S DIC="^PS(59.5,",DIC(0)="QEAML",DLAYGO=59.5,DIC("A")="Select IV ROOM: " D ^DIC I Y'>0 S XQUIT="" G Q1
 I 'PSIVCT S DIE=DIC,(DA,PSIVSN)=+Y,DR="[PSJI SITE PARAMETERS]" K DIC D ^DIE,ENCHK
Q ;
 I PSIVSN<1 W !!,"You have not selected a valid IV ROOM" S %=1 D YN^DICN I %=0 G Q
 I PSIVSN<1 G:%=1 PSIVSET S XQUIT="" G Q1
 S IOP=$P(^PS(59.5,PSIVSN,0),U,2) I IOP]"" S %ZIS="QN" D ^%ZIS I ION]"" W !!,"Current IV LABEL device is: ",ION S PSIVPL=ION
 E  D ENLD
 S IOP=$P(^PS(59.5,PSIVSN,0),U,3) I IOP]"" S %ZIS="QN" D ^%ZIS I ION]"" W !!,"Current IV REPORT device is: ",ION S PSIVPR=ION
 E  D ENPD
 ;D ^%ZISC  - check if %ZISC created mismatch in PSIVPL/PSIVPR = ION; don't que later
 D ^%ZISC S:PSIVPL="HOME" PSIVPL=ION S:PSIVPR="HOME" PSIVPR=ION
Q1 K IOP,PSIVCT,%ZIS,% Q
 ;
ENCHK ;
 S PSIV=1 S:'$D(^PS(59.5,PSIVSN,5)) $P(^(5),U)="" I '$D(^PS(59.5,PSIVSN,1)) S PSIV=0 W !!,$C(7),"This IV room is missing parameters."
 E  S PSIVSITE=^PS(59.5,PSIVSN,1),$P(PSIVSITE,U,20,21)=$G(^PS(59.5,PSIVSN,5)) D
 . F TYP="A","P","H","S","C" I '$D(^PS(59.5,PSIVSN,2,"AC",TYP)) W !!,$C(7),"Manufacturing Time(s) missing for " S X=$$CODES^PSIVUTL(TYP,59.51,.02) W X S PSIV=0
AGA ;
 I 'PSIV R !!,"Would you like to edit this IV room" S %=1 D YN^DICN Q:%=2!(%=-1)  W:'% !,"Answer Yes or No.",! G:'% AGA S DIE="^PS(59.5,",DR="[PSJI SITE PARAMETERS]",DA=PSIVSN D ^DIE G ENCHK
 I PSIVSN W !!,"You are signed on under the ",$P(^PS(59.5,PSIVSN,0),"^")," IV ROOM" K %
 K PSIV,TYP,%X,%Y,C,D,D0,D1,DA,DIC,DIE,DR,X,Y,Z Q
 ;
ENLD ;Get label device.
 W ! K IOP S %ZIS="NQ",%ZIS("B")=$S($P(^PS(59.5,PSIVSN,0),U,2)]"":$P(^(0),U,2),1:"HOME"),%ZIS("A")="Enter IV LABEL device: " D ^%ZIS S:POP ION="HOME"
 S PSIVPL=ION K IOP,%ZIS Q
ENPD ;Get printer device.
 W ! K IOP S %ZIS("B")=$S($P(^PS(59.5,PSIVSN,0),U,3)]"":$P(^(0),U,3),1:"HOME"),%ZIS="NQ",%ZIS("A")="Enter IV REPORT device: " D ^%ZIS S:POP ION="HOME"
 S PSIVPR=ION K IOP,%ZIS Q
DEVX W !!,$C(7),"You must select a device."
 Q
SITEPARM ; Edit IV Site Parameters.
 D ^PSIVXU Q:$D(XQUIT)
 N CHK,DIC,DIE,DA,DR,DLAYGO,DIOV,DTOUT,PSGDT,Z
 S DIC=59.7,DIC(0)="AEMQ" D ^DIC Q:Y<0
 S DIE=DIC,DA=+Y,DR=32 D ^DIE
 D ^PSIVXU Q:$D(XQUIT)  S (DIC,DLAYGO)=59.5,DIC(0)="AEQMLZ" D ^DIC S:Y>0 DIE=DIC,DA=+Y,DR="[PSJI SITE PARAMETERS]" D:Y>0 ^DIE,ENCHK^PSIVSET,SET^PSIVXU D ENIVKV^PSGSETU
