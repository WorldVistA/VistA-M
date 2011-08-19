ENPROJ ;(WIRMFO)/DLM/DH/SAB-Project Tracking Enter/Edit ;4/25/97
 ;;7.0;ENGINEERING;**23,28**;Aug 17, 1993
 ;
EDALLT ;Enter/Edit All Project Data - Template
 S ENDR="[ENPRI001]" G TEMPL
 ;
EDALLS ;Enter/Edit All Project Data - Screen
 S ENDR="[ENPR ALL]" G SCREEN
 ;
EDPREL ;Enter/Edit Preliminary Project Data - Screen
 S ENDR="[ENPR PRELIM]" G SCREEN
 ;
EDMS ;Enter/Edit Milestone Data - Screen
 S ENDR="[ENPR MS]" G SCREEN
 ;
EDAE ;Enter/Edit A/E Data - Screen
 S ENDR="[ENPR AE]" G SCREEN
 ;
EDCO ;Enter/Edit Contractor Data - Screen
 S ENDR="[ENPR CO]" G SCREEN
 ;
EDCHG ;Enter/Edit Changes & Remarks - Screen
 S ENDR="[ENPR CHG]" G SCREEN
 ;
EDLOCAL ;Enter/Edit Local Project Data - Template
 S ENDR=$S($D(^DIE("B","ENZPRLOCAL")):"[ENZ",1:"[EN")_"PRLOCAL]" G TEMPL
 ;
TEMPL ; called for input template edits
 ; input
 ;   ENDR - name of template
 D ASKPROJ G:'ENDA TEMPLX
 S DIE="^ENG(""PROJ"",",DA=ENDA,DR=ENDR
 D ^DIE K DIE,DR
 I '$D(DTOUT),$D(^ENG("PROJ",ENDA,0)) D VALPROJ
 L -^ENG("PROJ",ENDA)
 I '$D(DTOUT),'$D(DUOUT) G TEMPL
TEMPLX ; exit
 K DA,DIC,DIE,DIROUT,DIRUT,DR,DUOUT,DTOUT,X,Y
 K ENAMI,ENAY,ENBC,ENBCI,ENBO,ENBOI,ENCAF,ENCMI,ENCY,ENDA,ENDR
 K ENFT,ENPC,ENPCI,ENPN,ENPR,ENRY
 Q
 ;
SCREEN ; called for screen edits
 ; input
 ;   ENDR - name of form
 D ASKPROJ G:'ENDA SCREENX
 S DDSFILE=6925,DA=ENDA,DR=ENDR,DDSPARM="S"
 D ^DDS
 I $G(DDSSAVE),'$D(DTOUT),$D(^ENG("PROJ",ENDA,0)) D VALPROJ
 L -^ENG("PROJ",ENDA)
 I '$D(DTOUT),'$D(DUOUT) G SCREEN
SCREENX ; exit
 K DA,DIC,DIE,DIROUT,DIRUT,DR,DUOUT,DTOUT,X,Y
 K DDSFILE,DDSPAGE,DDSPARM,DDSSAVE
 K ENDA,ENDR,ENPN
 Q
 ;
ASKPROJ ; Ask project to edit
 ; output
 ;   ENDA  - ien of locked project (or null)
 S ENDA=""
 S DIC="^ENG(""PROJ"",",DIC(0)="AELMQ",DIC("A")="Select PROJECT NUMBER: "
 S DLAYGO=6925 D ^DIC K DIC,DLAYGO I Y'>0!$D(DTOUT)!$D(DUOUT) Q
 L +^ENG("PROJ",+Y):5 I '$T D  Q
 . W $C(7),!!,"Project is locked by another user. Please try later",!
 S ENDA=+Y,ENPN=$P(Y,U,2)
 I $P(Y,U,3)=1 D
 . ; populate fields for new project
 . N DA,DR,DIE,ENMCI
 . S ENMCI=$$FIND1^DIC(4,"","O",$P(ENPN,"-"),"D")
 . S DR=""
 . S:ENMCI DR=DR_";3///^S X=ENMCI"
 . S:"4567"[$E(ENPN) DR=DR_";158///VHA"
 . S:"89"[$E(ENPN) DR=DR_";158///NCS"
 . I $E(DR)=";" S DR=$E(DR,2,999)
 . I DR]"" S DIE="^ENG(""PROJ"",",DA=ENDA D ^DIE
 Q
 ;
VALPROJ ; Validate edited project
 ; input
 ;   ENDA - ien of project
 ;   ENPN - project number
 S ^TMP($J,"L")=1,^TMP($J,"L",ENPN)=ENDA
 D EN^ENPLV("R")
 K ^TMP($J,"L")
 Q
 ;
 ;ENPROJ
