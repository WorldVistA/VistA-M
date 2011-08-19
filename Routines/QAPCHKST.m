QAPCHKST ;557/THM-CHECK IF SURVEY CAN BE RELEASED [ 05/04/95  9:53 AM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;called by input transform of STATUS in file 748 and QAPCOPY
 ;
 Q:$P(^QA(748,DA,0),U,4)="r"&('$D(QAPCOPY))
 S QLINE=7 X CLEOP1 W !,"Please wait while this survey is checked for missing critical data    " H 1
 K NOPEN,CANCEL W !
 I $P(^QA(748,DA,0),U,3)="" W *7,!,"Last date for usage is missing" S NOPEN=1
 I $O(^QA(748,DA,1,0))="" W !,"Demographic data is missing" S NOPEN=1
 I $O(^QA(748,DA,1,0))="",$P(^QA(748,DA,0),U,8)="y" W " and demographics are mandatory" S CANCEL=1
 I $O(^QA(748,DA,1,0))="",$P(^QA(748,DA,0),U,8)'="y" W " (but demographics are not mandatory)" S NOPEN=1
 I $P(^QA(748,DA,0),U,6)="" W !,"Survey title is missing" S CANCEL=1
 I $O(^QA(748,DA,4,0))="" W !,"Survey instructions are missing" S CANCEL=1
 I '$D(^QA(748.25,DA,0))!($O(^QA(748.25,DA,1,0))="") W !,"There are no questions for this survey" S CANCEL=1
 I $O(^QA(748.25,DA,0))]""  F QNUM=0:0 S QNUM=$O(^QA(748.25,DA,1,QNUM)) Q:QNUM=""!(+QNUM=0)  DO
 .S QAPXX=^QA(748.25,DA,1,QNUM,0),QAPQN=$P(QAPXX,U,2)
 .I $P(QAPXX,U,3)="","^w^y^t^"'[$G(^QA(748.25,DA,1,QNUM,1)) W !,"The answer type on question ",QAPQN," is not (a)lpha ,(n)umeric or (L)ikert" S CANCEL=1
 .I $P(QAPXX,U,2)="" W !,"There is no question number for IFN ",QNUM S CANCEL=1
 .I $D(^QA(748.25,DA,1,QNUM,1)),$P(^(1),U,1)="m",$P(QAPXX,U,3)'="l",$O(^QA(748.25,DA,1,QNUM,3,1))="" W !,"Question ",QAPQN," is multiple choice and has no answers" S CANCEL=1
 .I $O(^QA(748.25,DA,1,QNUM,2,0))="" W !,"Question ",QAPQN," has no question text" S CANCEL=1
 Q:$D(QAPCOPY)  ;quit if copying a survey
REL I $D(NOPEN),'$D(CANCEL) W *7,!!,"Perhaps this survey should not be released",!,"until this data is supplied.",!
 ;
 I $D(NOPEN),'$D(CANCEL) W !,"Do you want to release anyway" S %=2 D YN^DICN I %<0!(%=2) K X S STOP=1 Q
 I $D(%Y),%Y="?" X CLEOP1 W !,"Answer Y release the survey or N to leave it as is.  " H 3 X CLEOP1 G REL
 I $D(%Y),%Y["??"  X CLEOP1 W !,"If you answer Y, the survey will be released regardless of",!,"what non-critical information is missing.  N will leave it as is.",!!,"Press RETURN  " R ANS:DTIME S:'$T DTOUT=1 I '$D(DTOUT) X CLEOP1 G REL
 I $D(DTOUT) S STOP=1 Q
 I $D(CANCEL) W !!,*7,"This survey is missing important data and cannot be released",!,"until it is supplied.",!! K X H 3
 I $D(%),%=0 W !!,*7,"You must specifically answer Y or N.  " H 2 X CLEOP1 G REL
 I '$D(CANCEL) W !!,"Survey released.  ",! H 2
 K %,YY,NOPEN,ANS,CANCEL,QAPXX
 Q
