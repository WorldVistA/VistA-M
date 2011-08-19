ENPL9 ;(WASH ISC)/LKG-CHIEF ENG/VAMC DIRECTOR PROJ APPROVAL ;5/15/95
 ;;7.0;ENGINEERING;**11,23**;Aug 17, 1993
EN S ENF=$S($D(^XUSEC("ENPLK001",DUZ)):244,$D(^XUSEC("ENPLK002",DUZ)):247,1:"")
A I ENF="" W $C(7),!,"Sorry, You lack a Security Key required for Approval Authority",! G EX
SEL ; select project
 K ENDA,ENIEN,ENQ,ENY0
 S DIC="^ENG(""PROJ"",",DIC(0)="AEMQZ",DIC("A")="Select PROJECT NUMBER: "
 S DIC("S")="I "";5;6;7;8;9;10;11;12;13;14;15;""[("";""_$P($G(^(1)),U,3)_"";"")"
 D ^DIC K DIC G:Y<1!$D(DTOUT)!$D(DUOUT) EX S ENDA=+Y
 L +^ENG("PROJ",ENDA):5 I '$T W $C(7),!,"File in Use, Please try later",! G SEL
 S ENY0=Y(0),ENIEN=ENDA_","
 D GETS^DIQ(6925,ENIEN,"155;158.1;244;245;246;247;248;249","","ENQ")
 I ENF=247,ENQ(6925,ENIEN,244)'="YES",ENQ(6925,ENIEN,247)'="YES" W $C(7),!,"Chief Engineer must sign approval before VAMC Director",! L -^ENG("PROJ",ENDA) G SEL
 W @IOF,!,"Project Number: ",$P(ENY0,U),?27,"Title: ",$E($P(ENY0,U,3),1,45)
 W !,"Program: ",ENQ(6925,ENIEN,155),?27,"Category: ",ENQ(6925,ENIEN,158.1),!!
 S DIR(0)="Y",DIR("A")="Do you wish to view a project summary:"
 S DIR("B")="NO"
 S DIR("?")="Enter 'Y' to see additional information about this project."
 D ^DIR K DIR I $D(DIRUT) L -^ENG("PROJ",ENDA) G EX
 I Y D
 . S L=0,DIC=6925,FLDS="[ENPLP005]",BY="@#.01"
 . S (FR,TO)=$P(ENY0,U),DHD="@",IOP="HOME"
 . D EN1^DIP K L,DIC,FLDS,BY,FR,TO,DHD
 ;
 I ENQ(6925,ENIEN,ENF)="YES" D  G:$D(DIRUT) EX G:'Y SEL
 . W !!,"Project was previously approved by ",ENQ(6925,ENIEN,ENF+1)," on ",ENQ(6925,ENIEN,ENF+2)
 . S DIR(0)="Y",DIR("A")="Do you want to change the approval status"
 . S DIR("B")="NO"
 . D ^DIR K DIR
 I ENQ(6925,ENIEN,ENF)="YES" S DA=ENDA,DR=ENF_"///@",DIE="^ENG(""PROJ""," D ^DIE K DIE,DR,DA ;  delete current approval to ensure triggers performed
 S DA=ENDA,DR=ENF_"//YES",DIE="^ENG(""PROJ"","
 D ^DIE K DIE,DR,DA L -^ENG("PROJ",ENDA) G:$D(DTOUT)!$D(DUOUT) EX
 W @IOF G SEL
EX K DA,DIC,DIE,DIRUT,DIROUT,DR,DTOUT,DUOUT,X,Y
 K ENDA,ENF,ENIEN,ENQ,ENY0
 Q
