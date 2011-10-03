QAPQCOPY ;557/THM-COPY SURVEY QUESTIONS [ 06/19/95  2:26 PM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 Q  ;enter properly
 ;
EN W "   Copy a question   " H 1
 K DIC,DR,DIE,X,Y
 I $O(^QA(748.25,"E",SURVEY,0))="" W !!,"There are no questions on this survey.",!!,"Press RETURN  " R ANS:DTIME S:'$T STOP=1 G EXIT
 N QAPHDR
 ;
START S QAPOUT=0 W @IOF,! S QAPHDR="Copy Survey Questions" X QAPBAR W !!,"Enter the question number to copy: " R DQUES:DTIME I '$T S STOP=1 G EXIT
 I DQUES["?" D HELPLKE^QAPUTIL1 I QAPQN]"" S DQUES=QAPQN W @IOF,! X QAPBAR
 I DQUES[U!(DQUES="")!(QAPQN="")!(QAPQN[U) S QAPOUT=1 G EXIT
 X CLEOP S DA=$O(^QA(748.25,"E",SURVEY,DQUES,0)) I DA]"" F I=0:0 S I=$O(^QA(748.25,SURVEY,1,DA,2,I)) D:I=""!(+I=0)  Q:I=""!(+I=0)  S X=$P(^QA(748.25,SURVEY,1,DA,2,I,0),U,1) W X,!
 I DQUES?1.3N,DA="" W *7,!!,"There is no question number ",DQUES,! H 2 G START
 I DQUES'?1.3N,DQUES'?1.3N1"."1.2N W !!,*7,"Your entry must be numeric and also an existing question number.  " H 3 G START
 W !! S QLINE=15
 ;
SEL W "Is this correct question" S %=2 D YN^DICN G:%=2 START G:%<0 EXIT
 I $D(%Y),%Y["?" W *7,!!,"Enter Y to proceed, N to go back and reselect",!,"""^"" to exit",!! H 2 X CLEOP1 G SEL
 ;
QAPQN I $D(NUM) S QAPQN=NUM G QAPQN1
 S QLINE=4 X CLEOP1 W *7,!,"You must enter a new number for this ",BLDON,"NEW",BLDOFF," question.",!!,"QUESTION NUMBER: ",*7 R QAPQN:DTIME I '$T S STOP=1 Q
 Q:QAPQN[U  I QAPQN'?1.3N!(QAPQN<0)!(QAPQN>999) W !!,*7,"Entry must be 1-3 numbers (1-999) and must be unique.  Enter ^ to exit.",! H 2 G QAPQN
 I $O(^QA(748.25,"E",SURVEY,QAPQN,0))]"",QAPOUT=0 W !!,*7,"You must enter a different question number.",!,"That one has been used." H 3 G QAPQN
 ;
QAPQN1 S X=$P(^QA(748.25,SURVEY,1,0),U,3)+1,DA(1)=SURVEY,DIC(0)="QM",(DIC,DIE)="^QA(748.25,"_SURVEY_",1," K DO,DD D FILE^DICN
 S XDA=+Y,%X="^QA(748.25,DA(1),1,DA,",%Y="^QA(748.25,DA(1),1,XDA,"
 D %XY^%RCR N DR S DA(1)=SURVEY,DA=XDA,DR=".015////"_QAPQN,(DIC,DIE)="^QA(748.25,"_DA(1)_",1," D ^DIE ;reset name, set new question number
 S $P(^QA(748.25,DA(1),1,DA,0),U,1)=DA ;reset .01 for reindex
 S DIK="^QA(748.25,",DA=SURVEY D IX^DIK W "    Copied " H 1 ;reindex entire record
 ;
EDIT W @IOF,! X QAPBAR S (DIE,DIC)="^QA(748.25,DA(1),1,",DA=XDA,DR=".055;.05" W *7,!!,"Now you may edit the question header and text.",!,"The rest of the question definition will remain",!,"the same unless you change it specifically.",!! D ^DIE
 ;
EXIT Q  ;kill variables in calling program
