QAPEDIT ;557/THM-CREATE/EDIT/MAINTAIN A SURVEY [ 05/18/95  7:03 AM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 D SCREEN^QAPUTIL
EN W @IOF,! S QAPHDR="Create/Edit/Maintain a Survey" X QAPBAR
 W ! S VERS=$P($T(+2),";;",2),VERS=$P(VERS,";",1) W ?68,"v "_VERS
 K DIR,OUT,DIC,STOP,Y W !! S DIR("?")="^D HELP2^QAPUTIL2"
 S DIR("A")="Selection"
 S DIR(0)="SO^C:Create a New Survey;B:Edit Basic Survey data;D:Add or Edit Demographic Survey Fields;E:Edit All Questions Sequentially;I:Add/Edit Individual Questions;P:Print a Survey;Q:Quit (also uparrow, or <RETURN>)"
 D ^DIR G:$D(DIRUT)!(X="") EXIT^QAPUTIL S ACTION=X,ACTION=$TR(ACTION,"cbdeipq","CBDEIPQ")
 I ACTION="C" D DV^QAPADD G:$D(STOP) EXIT^QAPUTIL G EN
 I ACTION="P" S CREATE=1 D ^QAPPT0 K CREATE G:$D(STOP) EXIT^QAPUTIL G EN
 I ACTION="Q" G EXIT^QAPUTIL
 ;
BASIC W @IOF,! S QAPHDR="Survey Name Selection" X QAPBAR
 S DIC("S")="I $P(^(0),U,5)=DUZ!($D(^XUSEC(""QAP MANAGER"",DUZ)))!($D(^QA(748,""AB"",DUZ,+Y)))"
 S DIC="^QA(748,",DIC(0)="AEQMZ",DIC("A")="Survey NAME: " D ^DIC G:X=""!(X[U) EXIT^QAPUTIL S SURVEY=+Y,SUBJ=Y(0,0) K DIC("S")
 I ACTION="D" D EN^QAPDEM G:$D(DTOUT) EXIT^QAPUTIL G EN
 I ACTION="B" K STOP,OUT S DA=SURVEY,DIC="^QA(748,",DIC(0)="EQM",DR=".01;.015;.03;.04;4;.05;.08;.1;5;1;2",DIE=DIC,QAPHDR="Survey Name: "_SUBJ
 I ACTION="B" W @IOF,! X QAPBAR S QAPHDR="Change Basic Data" X QAPBAR D ^DIE G:$D(DTOUT) EXIT^QAPUTIL DO  G EN
 .W !! I $O(^QA(748,DA,2,0))="" W !,*7,"The survey description was not entered !",! H 2
 .I $O(^QA(748,DA,4,0))="" W !,*7,"The survey instructions were not entered !",! H 2
 S SUBJ=$P(^QA(748,SURVEY,0),U) ;reset for name corrections
 G ^QAPEDIT1
