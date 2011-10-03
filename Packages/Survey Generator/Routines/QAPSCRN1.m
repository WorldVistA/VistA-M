QAPSCRN1 ;557/THM-USER INPUT FOR SURVEYS, PART 2 [ 07/24/96  2:37 PM ]
 ;;2.0;Survey Generator;**5**;Jun 20, 1995
 Q
 ;
EN1 K NEWREC S:'$D(FILEDA) FILEDA=IFN S (DIC,DIE)="^QA(748.3,",DR="3///i;4///@",DA=FILEDA D ^DIE
 K DUOUT,DTOUT,DSTOP,STOP,EDIT
 I SVST'="s"!(+LQUES=0) S:$O(^QA(748.3,FILEDA,2,0))]"" EDIT=1 D ^QAPDEM1 K EDIT G:$D(STOP) QUIT
 I $D(FSTOP),'$D(EDIT) W !!,"Demographics file error - response deleted !",!! H 3 S DA=FILEDA,DIK="^QA(748.3," D ^DIK G QUIT
 ;
KILL I $D(DSTOP),'$D(EDIT) W *7,!!,"Timed out ! - response deleted !",!!,*7 H 3 S:'$D(FILEDA) FILEDA=IFN S DA=FILEDA,DIK="^QA(748.3," D ^DIK G QUIT
 G:$D(FSTOP)!($D(STOP)) SUSPND
 W @IOF,! S QAPHDR=TITLE_" - Data Entry" X QAPBAR W !!
 K DA,STOP S QAPOUT=0 S:'$D(QAPCNT) QAPCNT=0 S:'$D(CQUES) CQUES=0
 F  K WPNEWREC S DISP=$O(^QA(748.25,"E",SURVEY,DISP)) Q:(DISP="")!(QAPOUT=1)!($D(STOP))  F QUES=0:0 S QUES=$O(^QA(748.25,"E",SURVEY,DISP,QUES)) Q:QUES=""  DO
 .D OUT3 D:QAPOUT=1 ABORT S:QAPOUT=0&('$D(RESUME)) CQUES=DISP,QAPCNT=DISP K RESUME Q:QAPOUT=1
 G:$D(STOP) QUIT
 ;
 S QLINE=$Y-1
EDITA X CLEOP1 W !!,"Do you want to edit your answers" S %=2 D YN^DICN D:$D(DTOUT) ABORT G:$D(STOP) QUIT
 I $D(%Y),%Y["?" W !!,"Enter Y to edit the answers or N to continue",!," and complete the survey." H 3 G EDITA
 I %=1 D ^QAPEDI1,^%ZISC W @IOF,! X QAPBAR,CLEOP I $D(DSTOP)!($D(STOP)) G QUIT
 ;
COMPL K % S QLINE=3 X CLEOP1 I QAPOUT=0 W !,BLDON,"(Type ^ to edit answers)",BLDOFF,!!,"Is it Ok to register this survey as complete" S %=2 D YN^DICN D:$D(DTOUT) ABORT G:$D(STOP) QUIT
 I $D(%Y),%Y["?" W !!,"Enter ^ edit your responses",!?6,"N to suspend/abort this response",!,?6,"Y to continue and register your survey as complete.",!!
 I $D(%Y),%Y["?" W "If you declare this survey completed, you will not be",!,"allowed to make any further changes to it.",!
 I $D(%Y),%Y["?" W !!,"Press RETURN  " R ANS:DTIME D:'$T ABORT G:$D(STOP) QUIT G COMPL
 I %=1 S DA=FILEDA,(DIC,DIE)="^QA(748.3,",DR="3////c" D ^DIE W !!,"Survey completed. " H 2 G QUIT
 I %<1 G EDITA
 I %=2 S QAPOUT=0 D ABORT I '$D(STOP) G:QAPOUT=0 COMPL
 ;
QUIT K WPNEWREC G EXIT^QAPUTIL
 ;
OUT3 I $O(^QA(748.25,SURVEY,1,QUES,4,0))]""  F I=0:0 S I=$O(^QA(748.25,SURVEY,1,QUES,4,I)) D:I=""!(+I=0)  Q:I=""!(+I=0)  S X=$P(^QA(748.25,SURVEY,1,QUES,4,I,0),U,1) W X,!
 I $O(^QA(748.25,SURVEY,1,QUES,4,0))]"" W *7,!!,"Press RETURN  " R ANS:DTIME G:'$T SUSPND W @IOF,! X QAPBAR W !!
 W "Question ",DISP,":",!!
 F I=0:0 S I=$O(^QA(748.25,SURVEY,1,QUES,2,I)) Q:I=""!(+I=0)  S X=$P(^QA(748.25,SURVEY,1,QUES,2,I,0),U,1) W X,!
 K X S QAPX=$P(^QA(748.25,SURVEY,1,QUES,1),U) D USINPT^QAPCHX:QAPX="m",QATF^QAPCHX:QAPX="t",QAYN^QAPCHX:QAPX="y",WP^QAPCHX:QAPX="w" Q:QAPOUT
 W @IOF,! X QAPBAR W !!
 Q
 ;
ABORT K DTOUT,DUOUT,STOP,% S:'$D(QAPCNT) QAPCNT=0 S:'$D(CQUES) CQUES=0
 X CLEOP S QAPOUT=0 W !!,*7,"Do you wish to suspend this survey and continue later" S %=1 D YN^DICN G:$D(DTOUT) SUSPND
 I $D(%Y),%Y["?" W !!,"Enter Y to suspend this survey",!?6,"^ to resume answer entry",!?6,"N to possibly abort this entry"
 I $D(%Y),%Y["?" W !!,"If you suspend this survey you may finish it later or",!,"make any changes you wish, then complete the rest of it.",!!
 I $D(%Y),%Y["?" W "If you abort your entry, your answers will be erased.",!,"A ^ will allow you to resume answer entry.",!!,"Press RETURN  " R ANS:DTIME S:'$T DTOUT=1 G:'$T SUSPND G ABORT
 I %<1 S RESUME=1 G ABORT1
 ;
SUSPND S:'$D(QAPCNT) QAPCNT=0 S:'$D(CQUES) CQUES=0 
 I $D(DTOUT)!(%=1) W:$D(DTOUT) !!,"Timed out.. Survey suspended." S (DIC,DIE)="^QA(748.3,",DA=FILEDA,DR="3////s;4////"_QAPCNT_";5////"_CQUES D ^DIE W !!,"Ok, see you later." H 2 S (QAPOUT,STOP)=1 Q
 I %<1,'$D(DTOUT) S RESUME=1 G ABORT1
 ;
ABORT0 K DTOUT,DUOUT,STOP,%,%Y X CLEOP W !!,"Do you want to abort the survey entry" S %=2 D YN^DICN G:$D(DTOUT) SUSPND
 I $D(%Y),%Y["?" W !!,"Enter Y to abort or N to continue.  ",! H 3 G ABORT0
 I %=1 W !!,*7,"If you abort now, all data entered so far will be erased.",!,"You must complete the survey for it to be counted.",!!,"Do you REALLY want to abort this survey" S %=2 D YN^DICN I $D(DUOUT) S QAPOUT=1 Q
 I $D(%Y),%Y["?" W !!,"Enter Y to abort or N to continue.  " H 3 X CLEOP G ABORT0
 I $D(DTOUT) G SUSPND
 I %'=1 S RESUME=1 G ABORT1
 ;
DEL I %=1 S DA=FILEDA,DIK="^QA(748.3," D ^DIK W *7,!!,">> Survey responses deleted! << " S STOP=1 H 3 Q
 ;
ABORT1 X CLEOP S QAPOUT=0 S:'$D(QUES) QUES=+LQUES S QUES=QUES-.001 X CLEOP W !!,"No action taken - Press RETURN to continue " R ANS:DTIME S QAPOUT=0 I '$T D ABORT I $D(STOP) Q
 W @IOF,! X QAPBAR,CLEOP
 Q
