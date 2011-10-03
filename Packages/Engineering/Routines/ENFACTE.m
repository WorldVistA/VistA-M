ENFACTE ;(WCIOFO)/SAB-FAP CAPITALIZATION THRESHOLD EDIT ;5/22/2002
 ;;7.0;ENGINEERING;**63,71**;August 17, 1993
 ;
 N ENCMR,ENCSN,ENDA,ENL,ENTSK,X,Y
 S ENL=$$REPEAT^XLFSTR("-",IOM-1)
 ;
ASKEQ ; ask equipment
 ;S DIC("S")="I $$CHKFA^ENFAUTL(+Y)>0" ; ?screen for reported to FAP
 W !! D GETEQ^ENUTL G:Y'>0 EXIT S ENDA=+Y
 S ENCMR=$E($$GET1^DIQ(6914,ENDA,19),1,5)
 S ENCSN=$$GET1^DIQ(6914,ENDA,18)
 ;
 ; display info
 W !,ENL
 W !,"ENTRY #: ",ENDA,?24,"CMR: ",ENCMR
 W ?38,"ASSET VALUE: ",$FN($$GET1^DIQ(6914,ENDA,12),",",2)
 W !,"CSN: ",ENCSN
 I ENCSN]"" W " (",$$GET1^DIQ(6914,ENDA,"18:2"),")"
 W !
 ;
 ; lock pseudo node to avoid conflict with equipment edit options
 ;   since field 99 will not be updated by those options
 L +^ENG(6914,"RC",ENDA):2 I '$T D  G ASKEQ
 . W $C(7)
 . W !,"Another user is currently editing this item with this option."
 . W !,"Please try again later."
 ;
 ; determine and display current status related to task
 S ENTSK=$$CHKEXP^ENFACTU(ENDA)
 I $P(ENTSK,U)=0 D
 . W !,"This equipment will not be expensed by the task because"
 . W !,"  ",$P(ENTSK,U,2)
 I $P(ENTSK,U)="U" D
 . W !,"This equipment will not be expensed by the task solely because"
 . W !,"  ",$P(ENTSK,U,2)," indicated that it should remain capitalized."
 I $P(ENTSK,U)=1 D
 . W !,"This equipment will be expensed by the task."
 ;
 ; if item meets critera to expense (or was exempted by user) then edit
 I $P(ENTSK,U)'=0 D
 . W !
 . S DIR(0)="Y",DIR("B")=$S($P(ENTSK,U)="U":"YES",1:"NO")
 . S DIR("A")="Should this item remain capitalized"
 . S DIR("?",1)="Enter YES to exempt this equipment item from being expensed"
 . S DIR("?",2)="by the one-time task that will run on July 24, 2002."
 . S DIR("?",3)="Enter NO if the item should be expensed by the task."
 . S DIR("?",4)=" "
 . S DIR("?")="Enter YES or NO"
 . D ^DIR K DIR Q:$D(DIRUT)
 . S DR=""
 . I Y,$P(ENTSK,U)=1 S DR="99////^S X=DUZ" ; exempts from task
 . I 'Y,$P(ENTSK,U)="U" S DR="99///@" ; removes exemption
 . I DR]"" S DA=ENDA,DIE="^ENG(6914," D ^DIE K DIE,DA
 . K DR
 ;
 ; unlock
 L -^ENG(6914,"RC",ENDA)
 ;
 G ASKEQ
 ;
EXIT ;
 K DIROUT,DIRUT,DTOUT,DUOUT
 Q
 ;ENFACTE
