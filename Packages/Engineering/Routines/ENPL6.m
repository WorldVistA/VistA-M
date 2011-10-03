ENPL6 ;(WASH ISC)/LKG- ENVIRONMENTAL ANALYSIS FM E/E ;6/23/93  14:49
 ;;7.0;ENGINEERING;;Aug 17, 1993
ENT ;Entry point for enter/editing project application fields related to
 ;;Environmental Analyses (VAF 10-1193a)
A S DIC="^ENG(""PROJ"",",DIC(0)="AEMQ",DIC("A")="Select PROJECT NUMBER: "
 D ^DIC K DIC,DO
 I Y<1!$D(DUOUT)!$D(DTOUT) G EX
 S (ENDA,DA)=+Y
 L +^ENG("PROJ",DA):5 E  W *7,!,"File in Use, Please try later",! G C
 S DR="[ENPLI003]",DIE="^ENG(""PROJ""," D ^DIE K DR,DIE
 L -^ENG("PROJ",ENDA)
C K DA,ENDA
 I '$D(DTOUT),'$D(DUOUT) G A
EX K ENDA,DA,DIC,DIE,DUOUT,DTOUT
 Q
