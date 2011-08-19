ENPL2 ;(WASH ISC)/LKG- CONSTRUCTION PROJ E/E ;7/10/95
 ;;7.0;ENGINEERING;**23**;Aug 17, 1993
EN ;Entry point for project application Enter/Edit
A ; select and edit project
 S DIC="^ENG(""PROJ"",",DIC(0)="AELMQ",DIC("A")="Select PROJECT NUMBER: "
 S DLAYGO=6925 D ^DIC K DIC,DO,DLAYGO I $D(DTOUT)!$D(DUOUT)!(Y<1) G EX
 S (DA,ENDA)=+Y S:$P(Y,U,3)'=1 ENOLD=1
 I $P($G(^ENG("PROJ",ENDA,0)),U,6)="LE" W $C(7),!,"Project Applications are not currently supported for Lease projects." G C
 L +^ENG("PROJ",DA):5 E  W $C(7),!,"File in Use, Please try later",! G C
 S DR="[ENPLI001]",DIE="^ENG(""PROJ""," D ^DIE K DR,DIE G:$D(DTOUT) C
 ; validate project
 I $D(^ENG("PROJ",ENDA,0)) D
 . S ^TMP($J,"L")=1,^TMP($J,"L",ENPN)=ENDA
 . D EN^ENPLV("A")
 . K ^TMP($J,"L")
C L -^ENG("PROJ",ENDA)
 K DA,ENDA,ENOLD
 I '$D(DTOUT),'$D(DUOUT) G A
EX K DA,DIC,DIE,DIROUT,DIRUT,DR,DUOUT,DTOUT,X,Y
 K ENAY,ENBC,ENBCI,ENBO,ENBOI,ENCY,ENDA,ENENV,ENFT,ENLY,ENOLD
 K ENPC,ENPCI,ENPN,ENPR,ENRY
 Q
ACT ;Entry point for Enter/Edit of Project Activation information
 S DIC="^ENG(""PROJ"",",DIC(0)="AEMQ",DIC("A")="Select PROJECT NUMBER: "
 D ^DIC K DIC,DO
 I Y<1!$D(DUOUT)!$D(DTOUT) G EX2
 S (DA,ENDA)=+Y
 L +^ENG("PROJ",ENDA):5 E  W *7,!,"File in Use, Please try later",! G E
 S DR="187.5;189;190;188;190.2:190.4",DIE="^ENG(""PROJ""," D ^DIE K DR,DIE
E L -^ENG("PROJ",ENDA) K DA,ENDA,Y
 I '$D(DTOUT),'$D(DUOUT) G ACT
EX2 K DA,DIC,DIE,DUOUT,DTOUT,ENDA
 Q
