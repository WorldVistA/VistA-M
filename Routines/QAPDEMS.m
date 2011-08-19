QAPDEMS ;557/THM-DEMOGRAPHICAL STATISTICS, PART 1 [ 06/19/95  12:49 PM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 D SCREEN^QAPUTIL
EN W @IOF,! S QAPHDR="Survey Demographical Statistics" X QAPBAR S QAPHDR="Survey Selection" X QAPBAR
 K DIC S DIC("S")="I $P(^(0),U,10)'=""c""!($P(^(0),U,5)=DUZ)!($D(^XUSEC(""QAP MANAGER"",DUZ)))!($D(^QA(748,""AB"",DUZ,+Y)))"
 S DIC="^QA(748,",DIC(0)="AEQMZ",DIC("A")="Select a survey: " D ^DIC K DIC G:X=""!(X[U) EXIT
 S SURVEY=+Y,TITLE=$P(^QA(748,SURVEY,0),U,6)
 W @IOF,! S QAPHDR="Survey Title: "_TITLE X QAPBAR S QAPHDR="Printing Demographical Information" X QAPBAR
 S DEMO="",DEMO=$O(^QA(748,SURVEY,1,"B",DEMO)) I DEMO="" W !!,*7,"There were no demographics specified for this survey.",!!,"Press RETURN  " R ANS:DTIME G:$D(DTOUT) EXIT G EN
 K DIR S DIR("A")="Choose a sorting demographic",DIR(0)="SB^",CNT=0
 S DEMO="" W !! F  S DEMO=$O(^QA(748,SURVEY,1,"B",DEMO)) Q:DEMO=""  F DA=0:0 S DA=$O(^QA(748,SURVEY,1,"B",DEMO,DA)) Q:DA=""  S CNT=CNT+1,DIR(0)=DIR(0)_CNT_":"_$P(^QA(748,SURVEY,1,DA,0),U,1)_";" W !?10,CNT,".  ",DEMO
 W !! D ^DIR G:$D(DIRUT) EXIT S SORTTXT=Y(0),SORT=$O(^QA(748,SURVEY,1,"B",$E(SORTTXT,1,30),0)) ;pull pointer to match later
 S DEMTYPE=$P(^QA(748,SURVEY,1,SORT,0),U,2)
 W @IOF,! S QAPHDR="Survey Title: "_TITLE X QAPBAR S QAPHDR="Printing Demographical Information" X QAPBAR
 ;
BYPASS X CLEOP W "Do you want to include bypassed questions in the",!,"statistics calculations" S %=2 D YN^DICN G:%<0 EXIT S BYPASS=%
 I $D(%Y),%Y["?" W !!,"Enter Y to print questions skipped by the participants",!,"or No to not print them." H 3 G BYPASS
 ;
BYPASSNA K %Y X CLEOP W !!,"Do you want to include 'Not Applicable' responses in the",!,"statistics calculations" S %=2 D YN^DICN G:%<0 EXIT S BYPASSNA=%
 I $D(%Y),%Y["?" W !!,"Enter Y to print responses of 'Not Applicable'",!,"or No to not print them." H 3 G BYPASSNA
 ;
WPPRT K %Y X CLEOP W "Do you want to print word processing responses" S %=2 D YN^DICN G:%<0 EXIT S WPPRT=%
 I $D(%Y),%Y["?" W !!,"Enter Y to print word processing questions or No to not print them." H 3 G WPPRT
 S %ZIS="AEQ",%ZIS("A")="Output device: " W !! D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTREQ="@",ZTIO=ION,ZTRTN="PRINT^QAPDEMS1",ZTDESC="Print "_TITLE_" Survey Demographical Statistics" F X="WPPRT","BYPASS*","DEMTYPE","SURVEY","TITLE","SORT*" S ZTSAVE(X)=""
 I  D ^%ZTLOAD W:$D(ZTSK) !!,"Queued as task #",ZTSK,!! H 3 G EXIT
 G ^QAPDEMS1
 ;
EXIT G EXIT^QAPUTIL
