DGRUG16 ;ALB/BOK/MLI - RUG-II GROUPER ; 21 OCT 86  11:00
 ;;5.3;Registration;**89**;Aug 13, 1993
INPUT W ! S DIC="^DG(45.9,",DIC(0)="AEQMN",DIC("S")="I $S('$D(^DG(45.9,+Y,""C"")):1,$D(^DG(45.9,+Y,""C""))&(+^DG(45.9,+Y,""C"")=1!(+^(""C"")=5)):1,1:0)" D ^DIC K DIC G QUIT^DGRUG1:Y'>0
 S DIE="^DG(45.9,",DR="[DGRUG]",(DGPT,DA)=+Y,DGD=$P(^DG(45.9,DA,0),U,7) D ^DIE
 G:'$D(DA) QUIT^DGRUG1
SET W ! K DGFLAG,A,I S DGINFO=^DG(45.9,DA,0) F I=1:1:20,23:1:28,32:1:35,40:1:57 I $P(DGINFO,U,I)']"" W !,"The field ",$P(^DD(45.9,I,0),U,1)," is missing data." S DGFLAG=1,A(I)=I
 G:$D(DGFLAG) ERR
 I $P(DGINFO,U,14)=2&($P(DGINFO,U,40)<5) W !,*7,"If 'NASAL OR ENTERIC FEEDING' ",!," is marked 'Y'es then question 'EATING' must be marked '5'.",! F I=14,40 S A(I)=I S DGFLAG=1
 G:$D(DGFLAG) EDIT
 I $P(DGINFO,U,2) S DGFY=$S($E($P(DGINFO,U,2),4,5)<10:$E($P(DGINFO,U,2),2,3),1:$E($P(DGINFO,U,2),2,3)+1)
 K DGFLAG,A F I=48:2:56 I $P(DGINFO,U,I)=1&($P(DGINFO,U,I+1)'=0) S A(I)=I,A(I+1)=I+1,DGFLAG=1
 I $D(DGFLAG) W !,*7,"For each of the therapy questions,'DAYS PER WEEK' must be '0' if level is '1'.",! G EDIT
 K DGFLAG,A F I=48:2:56 I $P(DGINFO,U,I)'=1&($P(DGINFO,U,I+1)=0) S A(I)=I,A(I+1)=I+1,DGFLAG=1
 I $D(DGFLAG) W !,*7,"For each of the therapy questions,'DAYS PER WEEK' must be greater than '0'",!,"if level is greater than '1'.",! G EDIT
 ;;changes 4/18/96 cmm
 K A,DGFLAG
 N RIEN
 I $D(^DG(45.9,DGPT,"R")),$P(^("R"),U)]"" S RIEN=$P($P(^("R"),U),";") S DGSER=$S($D(^DIC(42,RIEN,0)):$P(^(0),U,3),1:0) I $E(DGSER)'=$P(DGINFO,U,9) S DGFLAG=1,A(9)=9,A(70)=70
 I $D(DGFLAG) W !,*7,"Service of ward must be the same as bedsection" G EDIT
 S E=$P(DGINFO,U,40),E=$S(E<3:1,E=3:2,E=4:3,1:4),T=$P(DGINFO,U,42),T=$S(T<3:1,T=3:2,1:3),J=$P(DGINFO,U,43),J=$S(J<3:1,J<5:2,1:3),DGSUM=E+T+J
REHAB F E=48:2:56 I $P(DGINFO,U,E)=3&($P(DGINFO,U,E+1)>4) G GROUPR^DGRUG1
 G SPECIAL^DGRUG1
ERR W !!,"A RUG-II GROUP CAN NOT BE DETERMINED ON THIS PATIENT ",!
ERR1 W !,"Do you wish to edit now" S %=1 D YN^DICN G EDIT:%=1,INCOMP:%=-1!(%=2),HELP:%=0
 Q
EDIT S DIC="^DG(45.9,"_DA,DIC(0)="AEQMZ",DIE="^DG(45.9," F I=0:0 S I=$O(A(I)) Q:I'>0  S DR=I D ^DIE G ERR1:$D(Y) I X=1,(I>47),(I<57),'(I#2),$P(^DG(45.9,DGPT,0),"^",I+1)']"" S $P(^(0),"^",I+1)=0,I=I+1
 K A,DGFLAG,I G SET
EN S DIC="^DG(45.9,",DIC(0)="AEQM" D ^DIC G QUIT^DGRUG1:Y'>0 S (DGPT,DA)=+Y G SET
HELP W !,"There are fields missing data for this patient. The PAI will",!," not be complete until all data is entered. You can",!," complete the PAI at this time by responding 'Y'es.",! G ERR1
INCOMP S DA=DGPT,DIE="^DG(45.9,",DR="80///5" D ^DIE G QUIT^DGRUG1
