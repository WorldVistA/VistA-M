QAPUTIL1 ;557/THM-SURVEY GENERATOR UTILITIES, PART 2 [ 06/01/95  10:32 AM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
HELP ;Help on question entry for creators
 X:$D(CLEOP) CLEOP
 W !,"This area allows you to enter individual questions to this newly",!,"created survey.",!!
 W "You will be asked to give an ",BLDON,"increment",BLDOFF," or a number to skip",!,"between each question.  It may be any non-decimal number up",!,"to 99.",!!
 W "You will be asked to give a ",BLDON,"question number",BLDOFF," for each question.  The",!,"system will use these numbers in all displays of question data.",!!
 W "A default starting question number will be supplied and will always",!
 W "be  your  increment, but you may  override it if you wish.  From",!
 W "then on, the number displayed will be the  first number  entered",!
 W "plus your designated increment.",!!
 W !!,"Press RETURN   " R ANS:DTIME I '$T S STOP=1 Q
 X:$D(CLEOP) CLEOP
 Q
 ;
HELPLK ;display survey questions on user ??
 W ! K ANSX,STOP,FND X:$D(CLEOP) CLEOP S QAPOUT=0,CNT=0,QAPQN=""
 W ?2,"Question",!?2,"number",?13,"Q u e s t i o n   t e x t",!?2,"-------",?13,"--------------------------------------------------------------",!!
 S SQUEST=$O(DANS(0)),CNTPG=0
 F I=0:0 S I=$O(DANS(I)) Q:I=""!(QAPOUT=1)!($D(FND))!(CNT=QNUMANS)  F J=0:0 S J=$O(DANS(I,J))  Q:J=""!(QAPOUT=1)!($D(FND))!(CNT=QNUMANS)  DO 
 .S CNT=CNT+1
 .W ?5,I,?13,$S($G(^QA(748.25,SURVEY,1,J,2,1,0))]"":$E(^(0),1,55),1:"No text"),! S CNTPG=CNTPG+1 ;# displayed this page
SEL .S QAPOUT=0
 .I $O(DANS(I))=""!((CNT#10)=0)!(J=QNUMANS) DO
 ..S QLINE=8 W !,"Select a question from ",SQUEST," to ",I,", enter '^' or RETURN to go back",!,"to the previous prompt:  " R ANSX:DTIME S:'$T STOP=1 S:ANSX[U QAPOUT=1 Q:$D(STOP)
 ..X:ANSX=""&($D(CLEOP1)) CLEOP1 S:ANSX="" CNTPG=0 Q:ANSX[U!(ANSX="")
 ..I ANSX'=U,ANSX'="",ANSX'?1.3N,ANSX'?1.3N1"."1.3N S ANSX="ZZ",(CNT,CNTPG)=0
 ..D:'$D(DANS(+ANSX))  S:'$D(DANS(+ANSX)) QAPNOANS=1 Q:$D(QAPNOANS)  I $D(DANS(+ANSX)) S QAPQN=DANS(+ANSX),FND=1 Q
 ...X:$D(CLEOP1) CLEOP1 W *7,"You must select ",SQUEST," to ",I," enter '^' or RETURN",!,"to go back to the previous prompt.  " H 2 X CLEOP1
 ...S I=(CNT-CNTPG),I=I-CNTPG,CNT=CNT-(CNTPG),CNTPG=0
 ...S:I<10 I=0 S:CNT<10 CNT=0
 . I $D(QAPNOANS) K QAPNOANS Q
 .I $D(ANSX) I ANSX[U S QAPOUT=1 Q
 K FND,CNT,SQUEST S QAPOUT=0
 Q
 ;
HELPLKE ;display questions - creator edit
 W ! K ANSX,STOP,FND X:$D(CLEOP) CLEOP S QAPOUT=0,CNT=0,QAPQN=""
 W ?2,"Question",!?2,"number",?13,"Q u e s t i o n   t e x t",!?2,"-------",?13,"--------------------------------------------------------------",!!
 S SQUEST=$O(DANS(0)),CNTPG=0
 I SQUEST="" W !!?10,"This survey does not yet have questions.",! H 2 Q
 F I=0:0 S I=$O(DANS(I)) Q:I=""!(QAPOUT=1)!($D(FND))  F J=0:0 S J=$O(DANS(I,J)) Q:J=""!(QAPOUT=1)!($D(FND))  DO
 .S CNT=CNT+1
 .W ?5,I,?13,$S($G(^QA(748.25,SURVEY,1,J,2,1,0))]"":$E(^(0),1,55),1:"No text"),! S CNTPG=CNTPG+1
SELA .S QAPOUT=0
 .I $O(^QA(748.25,"E",SURVEY,I))=""!((CNT#10)=0) DO
 ..S QLINE=8 W !,"Select a question from ",SQUEST," to ",I,", enter '^' or RETURN to go back",!,"to the previous prompt:  " R ANSX:DTIME S:'$T (STOP,QAPOUT)=1 Q:$D(STOP)
 ..I ANSX'=U,ANSX'="",ANSX'?1.3N,ANSX'?1.3N1"."1.3N S ANSX="ZZ",(CNT,CNTPG)=0
 ..X:ANSX=""&($D(CLEOP1)) CLEOP1 S:ANSX="" CNTPG=0 Q:ANSX[U!(ANSX="")
 ..D:'$D(DANS(+ANSX))  S:'$D(DANS(+ANSX)) QAPNOANS=1 Q:$D(QAPNOANS)  I $D(DANS(+ANSX)) S QAPQN=DANS(+ANSX),FND=1 Q
 ...X:$D(CLEOP1) CLEOP1 W *7,"You may select only from ",SQUEST," to ",I," enter '^' or RETURN",!,"to go back to the previous prompt.  " H 3 X CLEOP1
 ...S I=(CNT-CNTPG),CNT=CNT-(CNTPG),CNTPG=0
 ...S:I<10 I=0 S:CNT<0 CNT=10
 . I $D(QAPNOANS) K QAPNOANS Q
 .I $D(ANSX) I ANSX[U S QAPOUT=1 Q
 K FND,CNT,SQUEST S QAPOUT=0
 Q
