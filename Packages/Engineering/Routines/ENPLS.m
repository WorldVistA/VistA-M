ENPLS ;WISC/SAB-SELECT PROJECTS ;8/17/95
 ;;7.0;ENGINEERING;**23**;Aug 17, 1993
EN(ENTY,ENLK) ; Entry Point
 ; input variables
 ;   (optional) ENTY - type of projects (F,A,R)
 ;   (optional) ENLK - true if selected projects should be locked
 ; output variables
 ;   ^TMP($J,"L")=project count^current year of FYFP if ENTY="F"
 ;   ^TMP($J,"L",project number)=ien
 ;
 N ENC,ENDA,ENFY,ENPN,ENSEL,ENSN
 K ^TMP($J,"L")
 I "^F^A^R^"'[(U_$G(ENTY)_U) S ENTY="",ENSEL=1
 S ENLK=$G(ENLK)
 I ENTY]"" D  G:$D(DIRUT) EXIT S ENSEL=Y
 . S DIR("A")="Choose method of project selection"
 . S DIR(0)="S^1:INDIVIDUAL PROJECTS"
 . S:ENTY="F" DIR(0)=DIR(0)_";2:FROM LIST OF FYFP PROJECTS RETURNED TO SITE"
 . S:ENTY="F" DIR(0)=DIR(0)_";3:ALL PROJECTS IN FIVE YEAR FACILITY PLAN"
 . S:ENTY="A" DIR(0)=DIR(0)_";2:FROM LIST OF PROJECT APPLICATIONS RETURNED TO SITE"
 . S:ENTY="A" DIR(0)=DIR(0)_";3:SELECTED PROJECTS FROM PROGRAM-YEAR LIST"
 . S:ENTY="R" DIR(0)=DIR(0)_";2:ALL PROJECTS WITH MONTHLY UPDATES = YES"
 . D ^DIR K DIR
 ; need year for FYFP
 I ENTY="F" D  G:$D(DIRUT) EXIT
 . S DIR(0)="N^1993:2099:0",DIR("A")="Budget Year of 5-Yr Plan"
 . S DIR("?")="Enter the 4-digit Budget Year of the Plan"
 . S DIR("B")=$E(17000000+DT,1,4)+$S($E(DT,4,7)>0600:2,1:1)
 . D ^DIR K DIR Q:$D(DIRUT)
 . S ENFY=Y-1
 I ENSEL=1 D  I $D(DTOUT)!$D(DUOUT) D:ENLK UNLOCK K ^TMP($J,"L") G EXIT
 . ; individual projects chosen
 . S ENC=0
 . S DIC=6925,DIC(0)="AQEM",DIC("A")="Select PROJECT NUMBER: "
 . F  D ^DIC Q:Y'>0  S ENDA=+Y  D
 . . S ENPN=$P($G(^ENG("PROJ",ENDA,0)),U) Q:ENPN']""
 . . I ENLK L +^ENG("PROJ",ENDA):10 I '$T W !,"Another user is editing this project. Can't select.",$C(7) Q 
 . . S ^TMP($J,"L",ENPN)=+Y,ENC=ENC+1
 . K DIC
 . S:ENC ^TMP($J,"L")=ENC_$S(ENTY="F":U_ENFY,1:"")
 I ENTY="F",ENSEL=2 D RET,LOCK:ENLK ; returned FYFP projects
 I ENTY="F",ENSEL=3 D  G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT) EXIT D:ENLK LOCK
 . ; FYFP projects chosen
 . S DIC="^DIC(4,",DIC(0)="AEMQ",DIC("B")=$P($G(^DIC(6910,1,0)),U,2)
 . D ^DIC K DIC I Y<1!$D(DTOUT)!$D(DUOUT) Q
 . S ENSN=$E($$GET1^DIQ(4,+Y_",",99),1,3)
 . D FYFP^ENPLS1(ENSN,ENFY)
 I ENTY="A",ENSEL=2 D RET,LOCK:ENLK ; returned project applications
 I ENTY="A",ENSEL=3 D PYLIST^ENPLS2,LOCK:ENLK ; program,year project list
 I ENTY="R",ENSEL=2 D  D LOCK:ENLK
 . ; monthly updates chosen
 . S (ENC,ENDA)=0 F  S ENDA=$O(^ENG("PROJ",ENDA)) Q:'ENDA  D
 . . S ENPN=$$GET1^DIQ(6925,ENDA_",",.01) Q:ENPN=""
 . . I $$GET1^DIQ(6925,ENDA_",",2.5)="YES" S ^TMP($J,"L",ENPN)=ENDA,ENC=ENC+1
 . S:ENC ^TMP($J,"L")=ENC
 I '$D(^TMP($J,"L")) W !,"No projects selected!",$C(7) G EXIT
EXIT ; Exit
 K DIC,DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,Y
 Q
RET ; Select from Returned projects
 N ENACL,ENC,ENDA,ENFLD,ENI,ENJ,ENK,ENPN,ENPR,ENY,ENY0
 K ^TMP($J,"R")
 S ENFLD=$S(ENTY="F":181.1,ENTY="A":251,1:"")
 ; find,sort returned projects
 S ENDA=0
 F  S ENDA=$O(^ENG("PROJ",ENDA)) Q:'ENDA  D
 . Q:$$GET1^DIQ(6925,ENDA_",",ENFLD)'="RETURNED TO SITE"
 . S ENY0=$G(^ENG("PROJ",ENDA,0)) Q:$P(ENY0,U)=""!($P(ENY0,U,6)="")
 . S ^TMP($J,"R",$P(ENY0,U,6),$P(ENY0,U))=$P(ENY0,U)_U_$P(ENY0,U,6)_U_$P(ENY0,U,3)_U_ENDA
 I '$D(^TMP($J,"R")) W !!,"No 'Returned' Projects Found!",! G RETEX
 S ENI=0,ENPR=""
 F  S ENPR=$O(^TMP($J,"R",ENPR)) Q:ENPR=""  S ENPN="" F  S ENPN=$O(^TMP($J,"R",ENPR,ENPN)) Q:ENPN=""  S ENI=ENI+1,^TMP($J,"SCR",ENI)=^(ENPN)
 S:ENTY="F" ^TMP($J,"SCR")=ENI_U_"RETURNED Five Year Plan Projects"
 S:ENTY="A" ^TMP($J,"SCR")=ENI_U_"RETURNED Project Applications"
 S ^TMP($J,"SCR",0)="5;11;PROJECT #^19;7;PROGRAM^29;50;TITLE"
 D ^ENPLS2
 ; save selected projects (if any)
 S ENC=0,ENJ="" F  S ENJ=$O(ENACL(ENJ)) Q:ENJ=""  D
 . F ENK=1:1 S ENI=$P(ENACL(ENJ),",",ENK) Q:ENI=""  D
 . . S ENY=^TMP($J,"SCR",ENI),^TMP($J,"L",$P(ENY,U))=$P(ENY,U,4),ENC=ENC+1
 S:ENC ^TMP($J,"L")=ENC_$S(ENTY="F":U_ENFY,1:"")
RETEX ; exit
 K ^TMP($J,"R"),^TMP($J,"SCR")
 Q
LOCK ; Lock List
 N ENDA,ENDEL,ENPN
 S ENDEL=0
 S ENPN="" F  S ENPN=$O(^TMP($J,"L",ENPN)) Q:ENPN=""  D
 . S ENDA=$P(^TMP($J,"L",ENPN),U)
 . L +^ENG("PROJ",ENDA):10 I '$T S ENDEL=1 W !,"Project ",ENPN," is currently being edited!"
 I ENDEL D UNLOCK K ^TMP($J,"L")
 Q
UNLOCK ; Unlock List
 N ENDA,ENPN
 S ENPN="" F  S ENPN=$O(^TMP($J,"L",ENPN)) Q:ENPN=""  D
 . S ENDA=$P(^TMP($J,"L",ENPN),U)
 . L -^ENG("PROJ",ENDA)
 Q
 ;ENPLS
