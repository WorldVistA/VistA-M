ENPL4 ;(WASH ISC)/LKG- 5-YR PLAN CONSTRUCTION PROJ E/E ;7/10/95
 ;;7.0;ENGINEERING;**23**;Aug 17, 1993
EN ;Entry point for editing 5-Yr Plan project.
 ; Determine budget year of plan to avoid inappropriate questions
 ; for out-year projects and support validation checks.
 S DIR(0)="N^1995:2099:0",DIR("A")="Budget Year of 5-Yr Plan"
 S DIR("B")=1700+$E(DT,1,3)+$S($E(DT,4,7)>0600:2,1:1)
 S DIR("?",1)="Enter a Fiscal Year between 1995 and 2099"
 S DIR("?",2)="Note: This is the Plan's, not the Project's Budget Year"
 S DIR("?")="This year enables differentiation among current, budget and out year projects"
 D ^DIR K DIR G:$D(DIRUT) EX S ENBY=Y
A ; select and edit project
 S DIC="^ENG(""PROJ"",",DIC(0)="AELMQ",DIC("A")="Select PROJECT NUMBER: "
 S DLAYGO=6925 D ^DIC K DIC,DLAYGO I $D(DTOUT)!$D(DUOUT)!(Y<1) G EX
 S (DA,ENDA)=+Y S:$P(Y,U,3)'=1 ENOLD=1
 L +^ENG("PROJ",DA):5 E  W *7,!,"File in Use, Please try later",! G C
 S DR="[ENPLI002]",DIE="^ENG(""PROJ""," D ^DIE K DIE,DR G:$D(DTOUT) C
 ; validate project
 I $D(^ENG("PROJ",ENDA,0)) D
 . S ^TMP($J,"L")=1_U_(ENBY-1),^TMP($J,"L",ENPN)=ENDA
 . D EN^ENPLV("F")
 . K ^TMP($J,"L")
C L -^ENG("PROJ",ENDA)
 K DA,ENDA,ENOLD
 I '$D(DTOUT),'$D(DUOUT) G A
EX K DA,DIC,DIE,DIROUT,DIRUT,DR,DUOUT,DTOUT,X,Y
 K ENAY,ENBC,ENBCI,ENBO,ENBOI,ENBY,ENCY,ENDA,ENFT,ENLY,ENOL
 K ENPC,ENPCI,ENPN,ENPR,ENRY
 Q
