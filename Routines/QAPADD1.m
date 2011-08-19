QAPADD1 ;557/THM-CREATE A NEW SURVEY, PART 2 [ 05/19/95  7:22 AM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 ;called by QAPADD
LINES W @IOF,! S QAPHDR="Survey Name: "_SUBJ X QAPBAR S QAPHDR="(Adding Questions)" X QAPBAR
 ;
Q1 S INCMSG="W !,*7,""The increment must be numeric, non-decimal, between 1 and 10."",! H 2"
 K DTOUT,DUOUT,SKIP X CLEOP W !,"Do you want help on question entry" S %=2 D YN^DICN G:$D(DTOUT) EXIT I %=1 K STOP D HELP^QAPUTIL1 I $D(STOP) G EXIT
 I $D(%),%<0 S SKIP=1 G INCR
 I $D(%Y),%Y["?" W !!,"Enter Y to see the help text or N to skip.   " H 2 G Q1
 ;
INCR I '$D(SKIP) S NUM=1 X CLEOP W !,"What increment value do you wish your questions use?   1 // " R X:DTIME S:X="" X=1 I '$T S STOP=1 G EXIT
 I X["?" W !!,"Enter the number to skip between questions.",! X INCMSG
 I X[U!(X["?")!($D(SKIP)) W !!,"If you exit without entering any questions, you will have to use the",!,"'Add/edit Individual Questions' option to add them without benefit",!
 I X[U!(X["?")!($D(SKIP)) W "of automatic question numbering.",!! I X["?" W "Press RETURN  " R ANS:DTIME I '$T S (STOP,QAPOUT)=1 G EXIT
 G:X["?" INCR
 I X[U!($D(SKIP)) W "Is this OK" S %=2 D YN^DICN S:$D(DTOUT) STOP=1 G:%=1!($D(DTOUT))!($D(STOP)) EXIT G:%'=1&($D(SKIP)) LINES G:%'=1 INCR
 I X<1!(X>10) W !! X INCMSG G INCR
 K SKIP I NUM'=X S NUM=X
 I X'?1.2N,X'>0 X INCMSG G INCR ;force non-decimal numbers
 S INCREM=X,DA(1)=SURVEY K STOP,OUT,X
 I '$D(^QA(748.25,DA(1),1,0)) S ^QA(748.25,DA(1),1,0)="^748.26I^0^0"
 ;
INCR1 K DTOUT,DUOUT,STOP,OUT
 F  DO  G:$D(DTOUT)!($D(STOP)) EXIT G:$D(DUOUT)!($D(OUT)) FIN G:$D(STOP) EXIT
 .;
DIS .W @IOF,! S QAPHDR="Survey Name: "_SUBJ X QAPBAR S QAPHDR="Adding Questions" X QAPBAR
 .D REORD
 .X CLEOP W BLDON,"Type ^ to exit",BLDOFF W:$D(LSTNUM) ?45,"Last question number: ",LSTNUM W !!,">> Question number: ",NUM,"//"  R QAPQN:DTIME I '$T S STOP=1 Q
 .I QAPQN="?" D HELPLKE^QAPUTIL1 Q:$D(STOP)  I QAPQN="" G DIS
 .I QAPQN[U S OUT=1 Q
 .I QAPQN="" S QAPQN=NUM
 .S QAPQN=$TR(QAPQN,"cr","CR")
 .I QAPQN'?1.3N,QAPQN'?1.3N1"."1.2N,QAPQN'?1"C",QAPQN'?1"R",+QAPQN'=QAPQN W !!,"Question number entry must be numeric,'R' to resequence",!,"the question numbers, or 'C' to copy a question.",*7 H 2 G DIS
 .I QAPQN?1"R" W "    Resequence question numbers   " H 1 D R1^QAPRSEQ S NUM=LSTNUM+INCREM G DIS
 .I QAPQN?1"C" D EN^QAPQCOPY DO  Q:$D(STOP)  G DIS
 ..I NUM>QAPQN Q
 ..I NUM<QAPQN S NUM=(QAPQN\1)+INCREM Q
 ..I NUM=QAPQN S NUM=NUM+INCREM Q
 .I +QAPQN<1!(+QAPQN>999) W !!,*7,"This number must be between 1 and 999.  " H 2 G DIS
 .S DA=$O(^QA(748.25,"E",DA(1),QAPQN,0)) I DA="" S CHOICE="A"
 .I DA]"" K DIR S DIR("A")="Select option",DIR(0)="S^C:Change;D:Delete",DIR("B")="Change" D ^DIR S CHOICE=Y S:$D(DTOUT) STOP=1 S:$D(DUOUT) OUT=1 I $D(STOP)!($D(OUT)) Q
 .I CHOICE=""!(CHOICE[U) S OUT=1 Q
 .S (DIC,DIE)="^QA(748.25,"_DA(1)_",1," X CLEOP
 .I CHOICE="A" S DIC(0)="QM",DIC("DR")=".015////"_QAPQN_";.055;.05;.02;",X=+$P(^QA(748.25,DA(1),1,0),U,3)+1 K DO,DD D FILE^DICN S DA=+Y G:DA<0 DIS DO
 ..I NUM>QAPQN Q
 ..I NUM<QAPQN S NUM=(QAPQN\1)+INCREM Q
 ..I NUM=QAPQN S NUM=NUM+INCREM Q
 .I CHOICE="C" S DR=".015;.055;.05;.02;" D ^DIE I $D(DTOUT) S STOP=1 Q
 .I CHOICE="C",$P(^QA(748.25,DA(1),1,DA,1),U)'="m" D KANS^QAPUTIL2 S DR=".025///@;.027///@;3///@;1///@;2///@" D ^DIE
 .I CHOICE="A"!(CHOICE="C"),$P(^QA(748.25,DA(1),1,DA,1),U)="m" S DR=".025;I X'=""l"" S Y=""@1"";D KANS^QAPUTIL2;.027;3;1;2;S Y=""@99"";@1;.027///@;3///@;1///@;2///@;.03;@99" D ^DIE
 .I CHOICE="D" DO  Q
Q2 ..W !!,*7,"Are you sure you want to remove this question" S %=2 D YN^DICN
 ..I $D(DTOUT) S STOP=1 Q
 ..I $D(DUOUT) S QUIT=1 Q
 ..I $D(%Y),%Y["?" W !!,"Entering Y will delete this question completely.",! G Q2
 ..I %=1 S DIK="^QA(748.25,"_DA(1)_",1," D ^DIK W !!,">> Question removed <<  " H 2 Q
 ..I %'=1 W !!,">> Nothing deleted <<" H 1
 X CLEOP K DIR
 ;
FIN K DIR S DIR(0)="Y",DIR("A")="Are you finished entering questions for this survey"
 S DIR("?",1)="Enter Y if you are finished or N if you have more questions"
 S DIR("?",2)="to add.  If you answer Yes, any further questions will have"
 S DIR("?",3)="to be put in via the 'Add/Edit Individual Questions' option"
 S DIR("?")="because this option only for new surveys."
 W !!,*7 D ^DIR S:$D(DTOUT) STOP=1 G:$D(DIRUT)!($D(STOP)) EXIT
 I Y=0 G INCR1
 G EN^QAPADD
 ;
EXIT Q  ;kill variables in calling program
 ;
REORD K DANS S LSTNUM="" F I=0:0 S I=$O(^QA(748.25,"E",SURVEY,I)) Q:I=""  F J=0:0 S J=$O(^QA(748.25,"E",SURVEY,I,J)) Q:J=""  S DANS(I,J)=I,DANS(I)=I,LSTNUM=I
 Q
