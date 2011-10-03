RAPAST ;HISC/CAH,FPT,GJC AISC/MJK,RMO-Enter Last Visit Date Before DHCP ;9/12/94  11:14
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
 S DIC(0)="",DIC="^RAMIS(71,",X="OTHER" D ^DIC K DIC I Y<0 W !,*7,"Procedure used as default is not available!" G Q
 S RAPRC=$P(Y,"^",2)
PAT W ! S DIC(0)="AEMQL" D ^RADPA G Q:Y<0 S RADFN=+Y
 I $O(^RADPT(RADFN,"DT",0))>0 W !!,*7,"Patient already has a visit logged in for " S Y=9999999.9999-$O(^(0)) D D^RAUTL W Y,".",! K RADFN G PAT
 S %DT(0)=-DT,%DT("A")="Last Exam Date before DHCP: ",%DT="AETPX" D ^%DT K %DT G PAT:Y<0 S RADTE=$S(Y[".":Y,1:Y_".0001")
 S DA=RADFN,DIE="^RADPT(",DR="[RA LAST PAST VISIT]" D ^DIE K DE,DQ,DIE,DR G PAT
Q K %W,%X,%Y1,D,DI
 K %,%DT,%H,%Y,A,C,D0,D1,D2,DA,DIC,DIE,DR,I,RADFN,RADTE,RADTE99,RAPRC,RAPTFL,X,XQUIT,Y Q
