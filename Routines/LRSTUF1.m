LRSTUF1 ;DALOI/CJS - MASS DATA ENTRY INTO FILE 63.04 ;5/13/03 1300
 ;;5.2;LAB SERVICE;**153,286**;Sep 27, 1994
 K ^TMP("LR",$J,"VTO"),M,LRSB,^TMP("LR",$J,"TMP")
 S DIC=68,DIC(0)="AEZMOQ" D ^DIC Q:Y<1  S LRAA=+Y
 S X=$$SELPL^LRVERA(DUZ(2))
 I X<1 Q
 I X'=DUZ(2) N LRDUZ S LRDUZ(2)=X
 I $P(LRPARAM,U,14),$P($G(^LRO(68,LRAA,0)),U,16) D ^LRCAPV Q:$G(LREND)
DAT D ADATE^LRWU Q:Y<1
TEST S DIC="^LAB(60,",DIC("A")="Select ORDERED TEST: ",DIC(0)="AEZOQ"
 D ^DIC Q:Y<1
 S LRTEST=+Y,^TMP("LR",$J,"VTO",+Y)=$P($P(Y(0),U,5),";",2)
 ;
 K ^TMP("LR",$J,"T"),LRORD,LRTSTS
 D ^LREXPD
 K A
 S (A1,I)=0 F  S I=$O(^TMP("LR",$J,"T",I)) Q:I<1  S X=^(I),A(+$P($P(X,"^",12),",",2))=I,A1=A1+1 S:$P(X,U,17) M($P($P(X,U,5),";",2))=I
 S LRTESTSV=LRTEST,LRFFLG="" I A1=1 S LRFLD=+$O(A(0)) G L2
 I A1<1 W !,"No way to put data in for that test." Q
 S I=0
 F  S I=$O(A(I)) Q:I<1  W !,I,?5," ",$P(^DD(63.04,I,0),"^")
 ;
L1 S DIC("A")="Enter the field to edit: ",DIC(0)="AE",DIC("S")="I $D(A(+Y))",DIC="^DD(63.04," D ^DIC K DIC G LREND:Y=-1 S LRFLD=+Y
L2 W !,"1  Automatically enter your entry.",!,"2  Prompt with your entry.",!,"3  Just Prompt."
 R !,"Choice: ",X:DTIME Q:X=""!(X["^")  I +X'=X!(X>3)!(X<1)!(X?.E1"."1N.N) W !,"Enter a number between 1 and 3." G L2
L3 S LRA=X K LRSTUFF,DIC I X<3 W !,"What do you want entered?: " R LRSTUFF:DTIME I LRSTUFF="?" W !,"    What you enter will go through the input transform to be stored in the",!,"    field you have specified." G L3
 W !,"I will ",$S(X=1:"automatically stuff ",1:"prompt "),$P(^DD(63.04,LRFLD,0),U) W:$D(LRSTUFF) !,"with ",LRSTUFF W !,"   ...OK" S %=1 D YN^DICN G TEST:%=-1,L3:%'=1
 S DR=LRFLD_$S(X=1:"///"_LRSTUFF,X=2:"//"_LRSTUFF,1:"")_";S LRVX=X;.03///N;S LRNOW=X;.04////"_DUZ,^TMP("LR",$J,"VTO",A(LRFLD))=LRFLD
 K LRAC W !,"Enter the accessions you wish to edit."
 W !,"Enter a string of numbers separated with , . ^ or space,",!,"or a range of numbers, e.g. 50-75.  You may enter more than one line."
LOOP R !,"Enter your selection(s) > ",X:DTIME I X="?" W !,"Enter a string of numbers separated with , . ^ or space,",!,"or a range of numbers, e.g. 50-75.  You may enter more than one line." G LOOP
 S D=$S(X[",":",",X[".":".",X["^":"^",1:" ") F I=1:1 S LRAC=$P(X,D,I) D:LRAC["-" RANGE^LRSTUF2 Q:LRAC=""  S LRAC(+LRAC)=""
 G LOOP:'(X=""!(X="^"))
 I $O(LRAC(0))>0 W !,"Editing the following:" S LRAC=0 F  S LRAC=$O(LRAC(LRAC)) Q:LRAC<1  I $D(^LRO(68,LRAA,1,LRAD,1,LRAC,0)) S LRDFN=+^(0),LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) D PT^LRX W !,"Acc #: ",LRAC,?15,PNM,?45,SSN
 K ^TMP("LR",$J,"T"),A,LRTSTS,LRORD
 S X=DUZ D DUZ^LRX
 R !,"If everything is OK, enter your initials: ",LRINI:DTIME I LRINI'=LRUSI!'$L(LRUSI) W !,"NOT APPROVED" G LREND
 S LRTN=1,LRSS="CH",LROUTINE=$P(^LAB(69.9,1,3),U,2) S I=0 F  S I=$O(M(I)) Q:I<1  S ^TMP("LR",$J,"TMP",LRSS,I)=1
 S %DT="T",X="N",LRTEC=LRUSI D ^%DT S LRNOW=+Y,LREND=0,LRAN=0
 F  S LRAN=$O(LRAC(LRAN)) Q:LRAN<1  D LRSTUFF^LRSTUF2 Q:LREND
 G LREND
LREND Q
