QAPADD ;557/THM-CREATE A NEW SURVEY, PART 1 [ 05/18/95  7:03 AM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 ;called by QAPEDIT
 Q  ;enter properly
DV I $D(DUZ(2))#2=0 W !!,*7,"You do not have a division defined.",!! H 2 Q
 I +DUZ(2)=0 W !!,*7,"Your division is incorrect.",!! H 2 Q
 ;
EN W @IOF,! S QAPHDR="Create a New Survey",QAPOUT=0 X QAPBAR
 S DIC("DR")=".055////"_DUZ,DIC="^QA(748,",DIC(0)="AEQMLZ",DIC("A")="Survey NAME: " X CLEOP D ^DIC S:$D(DTOUT) STOP=1 S:X=""!(X[U) QAPOUT=1 I $D(DTOUT)!(QAPOUT=1) K X,Y Q
 S SURVEY=+Y I $P(Y,U,3)'=1 W *7,!!,"This is not a new survey.",!,"Please use the edit feature for any changes.",! H 2 G EN
 ;
 K EDIT
EN1 K DIR,OUT,STOP,DIC,DIE,DR
 S SUBJ=$P(^QA(748,SURVEY,0),U) X CLEOP
 S DA=SURVEY,DIC="^QA(748,",DR=".02////"_$P(^DIC(4,DUZ(2),99),U,1)_";.01;.015;.03;.04;4;.05////d;.08;.1;5;1;2"
 S DIE=DIC D ^DIE D:'$D(Y)  S:'$D(Y) EDIT=1 I $D(DTOUT) S STOP=1 Q
 .W !! I $O(^QA(748,DA,2,0))="" W !,*7,"Note:  The survey description was not entered !",! H 2
 .I $O(^QA(748,DA,4,0))="" W *7,"Note:  The survey instructions were not entered !",! H 2
 ;
DEL K %,%Y I $D(Y),'$D(EDIT) W *7,!!,"Do you really want to delete this survey" S %=2 D YN^DICN I $D(DTOUT) S STOP=1 Q
 I $D(%Y),%Y["?" W !!,"If you answer Y you will have to re-enter the survey information.",!,"If you answer N you will return to editing.",!
 I $D(%) G:%'=1 EN1 S DA=SURVEY,DIK="^QA(748," D ^DIK W !!,">> Survey deleted <<",! H 2 G EN
 ;
REDIT K STOP,DTOUT,DUOUT W @IOF,! X QAPBAR W !!,"Do you wish to edit any of this basic information" S %=2 D YN^DICN S:$D(DTOUT) STOP=1 Q:$D(STOP)  I %=1 W @IOF,! X QAPBAR G EN1
 I $D(%Y),%Y["?" W !!,"Enter Y to edit this information or N to proceed.",! H 2 G REDIT
 I $D(%),%=-1 DO  G:'$D(STOP) REDIT G:$D(STOP) EXIT^QAPUTIL
 .S QLINE=3 X CLEOP1
 .W !,*7,"You have entered ""^"" to interrupt entry of this survey.",!
 .W !!,"If you stop now, you have not entered demographics or questions and the",!,"survey is incomplete.  It is not possible to delete the survey from",!
 .W "this point in this option.  You will have to use the menu option",!,BLDON,"Delete a Survey, Questions and Responses",BLDOFF,".",!
 .;
STOP .W !,"Is this what you really want to do" S %=2 D YN^DICN I %=1!($D(DTOUT)) S STOP=1
 .I $D(%Y),%Y["?" W !!,"Enter Y to stop or N to begin the editing again.",! H 2 G STOP
 D EN^QAPDEM ;do not allow ^ abort-incomplete record would be generated.
 S (X,DINUM)=SURVEY,DIC(0)="QM",(DIC,DIE)="^QA(748.25," K DO,DD D FILE^DICN K DINUM
 G ^QAPADD1
