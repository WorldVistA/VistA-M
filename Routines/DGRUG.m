DGRUG ;ALB/BOK/MLI - RUG-II GROUPER ; 21 OCT 86  11:00
 ;;5.3;Registration;**89,173**;Aug 13, 1993
INPUT W ! S DIC="^DG(45.9,",DIC(0)="AEQMN",DIC("S")="D CLOSEOUT^DGRUG I $S($P(^(0),U,2)<DGLCO:0,'$D(^DG(45.9,+Y,""C"")):1,$D(^DG(45.9,+Y,""C""))&(+^DG(45.9,+Y,""C"")=1!(+^(""C"")=5)):1,1:0)" D ^DIC K DIC G QUIT^DGRUG1:Y'>0
 S DIE="^DG(45.9,",DR="[DGRUG]",(DGPT,DA)=+Y,DGD=$P(^DG(45.9,DA,0),U,7) D ^DIE
 G:'$D(DA) QUIT^DGRUG1
SET W ! K DGFLAG,A,I
 S DGINFO=^DG(45.9,DA,0)
 F I=1:1:21,23:1:28,32:1:35,40:1:62 I $P(DGINFO,U,I)']"" D
 .Q:($P(DGINFO,U,6)=3)&(I=9)
 .W !,"The field ",$P(^DD(45.9,I,0),U,1)," is missing data." S DGFLAG=1,A(I)=I
 F I=49.5:2:57.5 I $P(DGINFO,U,I+13.5-(I-49.5/2))']"" W !,"The field ",$P(^DD(45.9,I,0),U,1)," is missing data." S DGFLAG=1,A(I)=I
 G:$D(DGFLAG) ERR
 I $P(DGINFO,U,2) S DGFY=$S($E($P(DGINFO,U,2),4,5)<10:($E($P(DGINFO,U,2),1,3)_"0000"),1:($E($P(DGINFO,U,2),1,3)+1_"0000"))
 F DGI=1:1:6 D @(DGI_"^DGRUG1") G:$D(DGFLAG) EDIT
 K A,DGFLAG
 N RIEN
 I $D(^DG(45.9,DGPT,"R")),$P(^("R"),U)]"" S RIEN=$P($P(^("R"),U),";") S DGSER=$S($D(^DIC(42,RIEN,0)):$P(^(0),U,3),1:0) I $E(DGSER)'=$P(DGINFO,U,9)&($P($G(^DG(45.9,DGPT,0)),U,6)'=3) S DGFLAG=1,A(9)=9,A(70)=70
 I $D(DGFLAG) W !,*7,"Service of ward must be the same as bedsection" G EDIT
 S E=$P(DGINFO,U,40),E=$S(E<3:1,E=3:2,E=4:3,1:4),T=$P(DGINFO,U,42),T=$S(T<3:1,T=3:2,1:3),J=$P(DGINFO,U,43),J=$S(J<3:1,J<5:2,1:3),DGSUM=E+T+J G CVD^DGRUG1
ERR W !!,"A RUG-II GROUP CAN NOT BE DETERMINED ON THIS PATIENT ",!
ERR1 W !,"Do you wish to edit now" S %=1 D YN^DICN G EDIT:%=1,INCOMP:%=-1!(%=2),HELP:%=0
 Q
EDIT S DIC="^DG(45.9,"_DA,DIC(0)="AEQMZ",DIE="^DG(45.9,"
 F I=0:0 S I=$O(A(I)) Q:I'>0  S DR=I D ^DIE G ERR1:$D(Y) I X=1,(I>47),(I<57),'(I#2),($P(^DG(45.9,DGPT,0),"^",I+1)']""),($P(^DG(45.9,DGPT,0),"^",I+1.5)']"") S $P(^(0),"^",I+1)=0,$P(^(0),"^",I+15-(I-48/2))=0,I=I+1
 K A,DGFLAG,I G SET
EN S DIC="^DG(45.9,",DIC(0)="AEQM" D ^DIC G QUIT^DGRUG1:Y'>0 S (DGPT,DA)=+Y G SET
HELP W !,"There are fields missing data for this patient. The PAI will",!," not be complete until all data is entered. You can",!," complete the PAI at this time by responding 'Y'es.",! G ERR1
INCOMP S DA=DGPT,DIE="^DG(45.9,",DR="80///5" D ^DIE G QUIT^DGRUG1
CLOSEOUT ;FIND LAST CLOSEOUT DATE - FOR USE BY ENTER/EDIT,TRANSMISSION
 S DGLCO=$S($E(DT,4,7)>1200:$E(DT,1,3)_"1001",$E(DT,4,7)<600:$E(DT,1,3)-1_"1001",1:$E(DT,1,3)_"0401")
 Q
