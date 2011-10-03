QAPSTATS ;557/THM-SURVEY GENERATOR STATISTICS, PART 1 [ 06/19/95  12:49 PM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
SCR D SCREEN^QAPUTIL
EN W @IOF,! S QAPHDR="Survey Statistics" X QAPBAR S QAPHDR="Survey Selection" X QAPBAR
 K DIC S DIC("S")="I $P(^(0),U,10)'=""c""!($P(^(0),U,5)=DUZ)!($D(^XUSEC(""QAP MANAGER"",DUZ)))!($D(^QA(748,""AB"",DUZ,+Y)))"
 S DIC="^QA(748,",DIC(0)="AEQMZ",DIC("A")="Select a survey: " D ^DIC K DIC G:X=""!(X[U) EXIT^QAPUTIL
 S SURVEY=+Y,TITLE=$P(^QA(748,SURVEY,0),U,6)
 ;
 W @IOF,! S QAPHDR="Survey Statistics" X QAPBAR S QAPHDR="Survey: "_TITLE X QAPBAR
BYPASS K %Y X CLEOP W "Do you want to include bypassed questions in the",!,"statistics calculations" S %=2 D YN^DICN G:%<0 EXIT^QAPUTIL S BYPASS=%
 I $D(%Y),%Y["?" W !!,"Enter Y to print questions skipped by the participants",!,"or No to not print them." H 3 X CLEOP G BYPASS
 ;
BYPASSNA K %Y X CLEOP W !!,"Do you want to include 'Not Applicable' responses in the",!,"statistics calculations" S %=2 D YN^DICN G:%<0 EXIT^QAPUTIL S BYPASSNA=%
 I $D(%Y),%Y["?" W !!,"Enter Y to print responses of 'Not Applicable'",!,"or No to not print them." H 3 G BYPASSNA
 ;
WPPRT K %Y X CLEOP W "Do you want to print word processing responses" S %=2 D YN^DICN G:%<0 EXIT^QAPUTIL S WPPRT=%
 I $D(%Y),%Y["?" W !!,"Enter Y to print word processing questions or No to not print them." H 3 G WPPRT
 S %ZIS="AEQ",%ZIS("A")="Output device: " W !! D ^%ZIS G:POP EXIT^QAPUTIL
 I $D(IO("Q")) S ZTREQ="@",ZTIO=ION,ZTRTN="PRINT^QAPSTAT1",ZTDESC="Print "_TITLE_" Survey Statistics" F X="SURVEY","TITLE","BYPASS*","WPPRT" S ZTSAVE(X)=""
 I  D ^%ZTLOAD W:$D(ZTSK) !!,"Queued as task #",ZTSK,!! H 2 K ZTSK G EXIT^QAPUTIL
 G PRINT^QAPSTAT1
