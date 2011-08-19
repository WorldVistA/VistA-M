QAPSDEL ;557/THM-DELETE A SURVEY, QUESTIONS, RESPONSES [ 06/20/95  12:40 PM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 D SCREEN^QAPUTIL
EN W @IOF,! S QAPHDR="Delete a Survey, Questions, and Responses" X QAPBAR W !!
 W "This program will ",BLDON,"COMPLETELY",BLDOFF," delete a survey, its questions",!,"and responses.",!!!
 S DIC("S")="I $P(^(0),U,5)=DUZ!($D(^XUSEC(""QAP MANAGER"",DUZ)))!($D(^QA(748,""AB"",DUZ,+Y)))"
 S DIC="^QA(748,",DIC(0)="AEQMZ" D ^DIC G:X=""!(X[U) EXIT  S SURVEY=+Y
 S OWNER=$P(Y(0),U,5)
 W ! K DIR S DIR("?")="Enter Y if it is the right one or N if not",DIR(0)="Y",DIR("A")="Is this the correct survey" D ^DIR G:$D(DTOUT) EXIT G:Y=0!(X[U)!($D(DIRUT)) EN
 I DUZ'=OWNER W *7,!!,"This survey belongs to ",BLDON,$S($D(^VA(200,+OWNER,0)):$P(^(0),U,1),1:"an unknown survey developer"),BLDOFF,".",!," Be sure you want to delete ",BLDON,"THIS",BLDOFF," survey !!",! H 1
 S DELETE=0 W !! K DIR
 S DIR("?")="Enter Y if you are COMPLETELY sure or N if not"
 S DIR(0)="Y",DIR("A")="Are you absolutely sure" D ^DIR G:$D(DTOUT) EXIT G:Y=0!(X[U)!($D(DIRUT)) EN
 I Y=1 DO
 .W !!,*7,"Survey now DISABLED ... ",!! H 1 S DIE="^QA(748,",DR=".05///e",DA=SURVEY D ^DIE
 .L ^QA(748,SURVEY,0) S DA=SURVEY,DIK="^QA(748," W !,"Deleting the survey . . ." D ^DIK W "."
 .L ^QA(748.25,SURVEY,0) S DA=SURVEY,DIK="^QA(748.25," W !,"Deleting the questions . . ." D ^DIK W "."
 .W !,"Deleting the responses . . ." F DA=0:0 S DA=$O(^QA(748.3,"B",SURVEY,DA)) Q:DA=""  S DIK="^QA(748.3," D ^DIK W "."
 .LOCK  H 1
 G EN
 ;
EXIT G EXIT^QAPUTIL
