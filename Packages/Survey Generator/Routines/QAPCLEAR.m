QAPCLEAR ;557/THM-CLEAR A SURVEY OF RESPONSES [ 02/19/95  9:53 PM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 D SCREEN^QAPUTIL
EN W @IOF,! S QAPHDR="Clear a Survey of Responses" X QAPBAR W !?45,BLDON,"Type RETURN or ^ to exit",BLDOFF,!! W "This program will COMPLETELY clear a survey of its associated responses.",!!
 K DIC S DIC("S")="I $P(^(0),U,5)=DUZ!($D(^XUSEC(""QAP MANAGER"",DUZ)))!($D(^QA(748,""AB"",DUZ,+Y)))"
 S DIC="^QA(748,",DIC(0)="AEQMZ" D ^DIC G:X=""!(X[U) EXIT  S SURVEY=+Y
 W ! K DIR S DIR("?")="Enter Y if the correct one or N if not.",DIR(0)="Y",DIR("A")="Is this the correct survey",DIR("B")="YES" D ^DIR G:X[U!($D(DIRUT)) EXIT I Y'=1 G EN
 S DELETE=0 W !! K DIR S DIR("?")="Enter Y if you are sure or N if not.",DIR(0)="Y",DIR("A")="Are you sure you want to remove all responses to this survey",DIR("B")="NO" D ^DIR G:X[U!($D(DIRUT)) EXIT I Y'=1 G EN
 I Y=1 S DELETE=1
 S CNT=0 I DELETE=1 W !,"Deleting the responses . . ." F DA=0:0 S DA=$O(^QA(748.3,"B",SURVEY,DA)) Q:DA=""  S DIK="^QA(748.3," D ^DIK W "." S CNT=CNT+1
 W !!,"Responses deleted: ",CNT,!
 K DIR S DIR(0)="E" D ^DIR I X'[U,'$D(DIRUT) G EN
 ;
EXIT G EXIT^QAPUTIL
