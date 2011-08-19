DGCOL ;ALB/MRL - COLLATERAL PATIENT ENTRY-EDIT ; 04 MAY 87
 ;;5.3;Registration;**2,23,32**;Aug 13, 1993
1 K DFN W !! S DGDIR=$S($D(DGDIR):DGDIR,1:1),DIC="^DPT(",DIC(0)="AEQML",DIC("DR")=".03;.09;.02;.3601;1901///^S X=""N"";391///^S X=""COLLATERAL"";.361///^S X=""COLLATERAL OF VET."";.323///^S X=""OTHER NON-VETERANS"";"
 S DLAYGO=2 D ^DIC I Y'>0 S DGDIR=0 K DLAYGO G Q
 S DFN=+Y,DGVET=$S('$D(^DPT(DFN,"VET")):0,^("VET")="Y":1,1:0) I '$P(Y,"^",3),DGVET,'DGDIR G Q
EN S DGDIR=$S($D(DGDIR):DGDIR,1:0) G Q:'$D(DFN),VET:DGVET
 S DGELG=$S('$D(^DPT(DFN,.36)):1,'$D(^DIC(8,+^(.36),0)):1,$P(^(0),"^",9)'=13:0,1:1),DGPS=$S('$D(^DPT(DFN,.32)):1,'$D(^DIC(21,+$P(^(.32),"^",3),0)):1,$P(^(0),"^",1)'["OTHER NON-VET":0,1:1) G:('DGELG!'DGPS) ECPS K DGELG,DGPS D EN^DGRPD
 I $D(DGRPOUT) K DGRPOUT G 1
 S (Y,DA)=DFN,DR="[DGCOLLATERAL]",DGNOCOL=0,DIE="^DPT(" D ^DIE G Q:DGNOCOL!'$D(^DPT(DFN,0)) I '$D(DGCOLV) W !!,"COLLATERAL VETERAN SPONSOR NAME IS UNSPECIFIED!!",*7 G EN
 S DGAD=$S($D(^DPT(DFN,.11)):$P(^(.11),"^",1,12),1:""),DGAD1=$S($D(^DPT(+DGCOLV,.11)):$P(^(.11),"^",1,12),1:""),C=0 W !!,"APPLICANT ADDRESS DATA",?45,"SPONSOR ADDRESS DATA",!,"----------------------",?45,"--------------------"
 S C=0,P=1,X=DGAD D AD S C=0,P=2,X=DGAD1 D AD F I=0:0 S I=$O(AD(I)) Q:'I  W !,$P(AD(I),"^",1),?45,$P(AD(I),"^",2)
 S DGPHON=$S($D(^DPT(DFN,.13)):$P(^(.13),"^",1),1:""),$P(DGPHON,"^",2)=$S($D(^DPT(DGCOLV,.13)):$P(^(.13),"^",1),1:"")
 W !!,"Phone:  ",$S($P(DGPHON,"^",1)]"":$P(DGPHON,"^",1),1:"UNKNOWN"),?45,"Phone:  ",$S($P(DGPHON,"^",2)]"":$P(DGPHON,"^",2),1:"UNKNOWN")
 W !!,"SPONSOR:  ",$P(^DPT(DGCOLV,0),"^",1),", ",$E($P(^(0),"^",9),1,3),"-",$E($P(^(0),"^",9),4,5),"-",$E($P(^(0),"^",9),6,10)
ASK W !!,"DO YOU WISH TO EDIT COLLATERAL INFORMATION" S %=2 D YN^DICN G Q:%=2!(%=-1) I %=0 W !,"ENTER 'Y'ES OR 'N'O" G ASK
H W !!,"SHOULD COLLATERAL PATIENT ADDRESS DATA BE SAME AS SPONSOR'S" S %=2 D YN^DICN I %>0 S DGADED=(%-1) G ED
 G Q:%=-1 W !!,"Y - To stuff in sponsor's address data.",!,"N - To edit collateral address data",!,"^ - To QUIT." G H
ED I DGADED S DR=".3601;.111;S:X']"""" Y=.114;.112;S:X']"""" Y=.114;.113:.115;.1112;.117;.131;",DIE="^DPT(",(DA,Y)=DFN D ^DIE G Q
 S DGADD=$S($D(^DPT(DFN,.11)):^(.11),1:""),DGADD=$P(DGAD1,"^",1,12)_"^"_$P(DGADD,"^",13,999),^DPT(DFN,.11)=DGADD,$P(^DPT(DFN,.13),"^",1)=$P(DGPHON,"^",2) W !!,"Sponsor address data entered..." G Q
AD F I=1:1:5,12,7 I $P(X,"^",I)]"" D
 .S D=$P(X,"^",I),C=C+1
 .S:(I=12)&($L(D)>5) D=$E(D,1,5)_"-"_$E(D,6,20)
 .S $P(AD(C),"^",P)=D S:I=5 $P(AD(C),"^",P)=$S($D(^DIC(5,+D,0)):$P(^(0),"^",1),1:"STATE UNKNOWN") I I=7 S $P(AD(C),"^",P)=$S($D(^DIC(5,+$P(X,"^",5),1,+D,0)):$P(^(0),"^",1),1:"UNKNOWN")
 Q
VET W !!,*7,"Patient is a veteran and therefore should not be classified utilizing this",!,"option.  If this veteran has Other Entitled Eligibilities please insure that "
 W !,"the appropriate APPOINTMENT TYPE is selected at the time you make the",!,"appointment." G Q
ECPS K DGELG,DGPS W !!,*7,"Patient already has an eligibility code or period of service on file and",!,"therefore should not be classified using this option.  If this veteran",!,"has Other Entitled Eligibilities, please insure that the"
 W " appropriate",!,"APPOINTMENT TYPE is selected at the time you make the appointment."
Q K %,Y,DGVET,DIE,DIC,DGCOLV,DR,X,I,DGNOCOL,DA,AD,C,P,D,DGADD,I1,DGAD,DGAD1,DGADED,DGPHON G:DGDIR 1 K DGDIR S:$D(DFN) Y=DFN Q
