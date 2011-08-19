RAOUT ;HISC/CAH,FPT,GJC AISC/TMP,RMO-Outside Film Option ;9/12/94  11:13
 ;;5.0;Radiology/Nuclear Medicine;**31**;Mar 16, 1998
1 ;;Add Films to Registry
 D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
 S DIC(0)="AEMQL" D ^RADPA K DIC G Q1:Y<0 S (RADFN,DA)=+Y,DIE="^RADPT(",DR="[RA OUTSIDE ADD]" D ^DIE K DE,DQ,DIE,DR D Q1 W ! G 1
Q1 K %,%DT,%W,%Y,%Y1,A,C,D,D0,D1,D2,DA,DDER,DDH,DI,RADFN,RAPTFL,X,Y Q
 ;
2 ;;Edit Registry
 D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
 S DIC(0)="AEMQ" D ^RADPA K DIC G Q2:Y<0 S (RADFN,DA)=+Y,DIE="^RADPT(",DR="[RA OUTSIDE EDIT]" D ^DIE K DA,DI,DIE,DQ,DR D Q2 W ! G 2
Q2 K %,%DT,%DUZ,%W,%X,%Y,%Y1,C,D,D0,D1,D2,DA,DDER,DIE,DR,RADFN,X,Y Q
 ;
3 ;;Flag Film to Need 'OK' Before Return
 D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
 S DIC(0)="AEMQ" D ^RADPA K DIC G Q3:Y<0 S (RADFN,DA)=+Y,DIE="^RADPT(",DR="[RA OUTSIDE SUPEROK]" D ^DIE K DA,DI,DIE,DQ,DR D Q3 W ! G 3
Q3 K %,%DT,%DUZ,%W,%X,%Y,%Y1,C,D,D0,D1,D2,DA,DDER,DIE,DR,I,RADFN,X,Y Q
 ;
4 ;;Delinquent Outside Film Report for Outpatients
 S %DT("A")="All Films with 'Needed Back' Dates Less Than: ",%DT="AEX" D ^%DT K %DT Q:Y<0
 S DIC="^RADPT(",L=0,TO=Y,FLDS="[RA OUTSIDE LIST]",BY="[RA OUTSIDE LIST]",DIS(0)="I '$D(^DPT(D0,.1))",FR=2000101 G EN1^DIP
 ;
5 ;;Outside Films Profile
 S DIC(0)="AEMQ" D ^RADPA K DIC G Q5:Y<0 S RALL=1,RADFN=+Y
PROF S ZTRTN="START^RAOUT",ZTSAVE("RADFN")="",ZTSAVE("RALL")="" D ZIS^RAUTL K IOP G Q5:RAPOP
START G Q5:'$D(^DPT(RADFN,0)) S RANME=^(0),RASSN=$$SSN^RAUTL,RANME=$P(RANME,"^")
 U IO S RAPG=0 D HD I '$D(^RADPT(RADFN,"O")) W !!,"No outside films have been registered for this patient." G Q5
 F RAI=0:0 S RAI=$O(^RADPT(RADFN,"O",RAI)) Q:RAI'>0  I $D(^(RAI,0)) S Y=^(0) I RALL!('$P(Y,"^",3))!($P(Y,"^",3)>DT) D PRT
Q5 K C,I,J,POP,RAPG,RAPOP,RAI,RADFN,RALL,RASSN,RANME,X,Y D CLOSE^RAUTL ;Q
 K RAMES Q
PRT W !,"Registered: ",$E(Y,4,5),"/",$E(Y,6,7),"/",$E(Y,2,3),?30,"Returned : ",$S($P(Y,"^",3):$E($P(Y,"^",3),4,5)_"/"_$E($P(Y,"^",3),6,7)_"/"_$E($P(Y,"^",3),2,3),1:"still on file"),?60,"'OK' Needed: ",$S($P(Y,"^",5)="Y":"Yes",1:"No")
 W !,"Source    : ",$P(Y,"^",4) I $D(^RADPT(RADFN,"O",RAI,1)) S X=^(1) D REM
 W !,I
 I ($Y+5)>IOSL,IO=IO(0) R !,"Press RETURN to continue. ",X:DTIME D HD
 Q
REM F J=1:60:240 S Y=$E(X,J,J+60) Q:Y']""  W !,$S(J=1:"Remarks   : ",1:""),?12,Y
 Q
 ;
HD ; Header
 S RAPG=RAPG+1 W:$E(IOST,1,2)="C-" @IOF
 I $E(IOST,1,2)="P-",(RAPG>1) W @IOF
 W "Patient: ",RANME,"  ",RASSN,?55,"Run Date: " S Y=DT D DT^DIO2
 W !!?15,"*****  Outside Films Profile  *****",$S(RALL=0:"   (Films NOT Returned only)",1:"") W ! S I="",$P(I,"-",80)="" W I
 Q
