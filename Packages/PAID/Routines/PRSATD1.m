PRSATD1 ; HISC/REL-Edit/Display Tour of Duty ;8/12/94  10:10
 ;;4.0;PAID;;Sep 21, 1995
EDIT ; Enter/Edit Tour of Duty
 D HDR K DIC
 S DIC="^PRST(457.1,",DIC(0)="AEQLMN",DLAYGO=457.1,DIC("A")="Select TOUR OF DUTY: ",DIC("S")="I +Y>9" D ^DIC K DIC G:Y'>0 EX S TDI=+Y
 S ZN=$G(^PRST(457.1,+Y,1)),DA=+Y,DDSFILE=457.1,DR="[PRSA TD EDIT]" K ZS D ^DDS K DS
 I $D(ZS) S ^PRST(457.1,DA,1)=ZS,TIM=TIM-$P(^(0),"^",3)/60,$P(^(0),"^",6)=$S(TIM>0:TIM,1:0)
 I '$D(^PRST(457.1,DA,1)) S DIK="^PRST(457.1," D ^DIK G EX
 I '$P(^PRST(457.1,DA,0),"^",4) S DDSFILE=457.1,DR="[PRSA TD TL]" D ^DDS K DS
 G EDIT
NAM ; Verify Tour Name format
 S %=X,X=$P(%,"-",1) D ^PRSATIM Q:'$D(X)  S $P(%,"-",1)=X
 S X=$P(%,"-",2),X=$P(X," ",1) D ^PRSATIM Q:'$D(X)
 S X=$P(%,"-",1)_"-"_X I $P(%," ",2,99)'="" S X=X_" "_$P(%," ",2,99)
 K % Q
VAL ; Shuffle segments
 K T,ZS S TIM=0,TWO=$$GET^DDSVAL(DIE,DA,5),DY2=TWO="Y",MEAL=$$GET^DDSVAL(DIE,DA,2)/60
 F K=1:3:19 S X=$P(ZN,"^",K) I X'="" S X=X_"^"_$P(ZN,"^",K+1) G:$P(ZN,"^",K+1)="" E7 D CNV^PRSATIM S Z1=$P(Y,"^",1),Z2=$P(Y,"^",2) D V0 G E3:$D(T(Z1)),E4:TWO'="Y"&(Z2>1440),E5:Z2>2880 S T(Z1)=Z2_"^"_$P(ZN,"^",K,K+2) D V1
 S Z1="" F  S Z1=$O(T(Z1)) Q:Z1=""  G:Z1'<T(Z1) E1 S Y=$O(T(Z1)) I Y,T(Z1)>Y G E2
 S Z1="",K=1 F  S Z1=$O(T(Z1)) Q:Z1=""  S $P(ZS,"^",K)=$P(T(Z1),"^",2),$P(ZS,"^",K+1)=$P(T(Z1),"^",3) S:$P(T(Z1),"^",4)'="" $P(ZS,"^",K+2)=$P(T(Z1),"^",4) S K=K+3
 G:'$D(ZS) E6 G:MEAL>TIM E8 Q
V0 I Z2>Z1 S:DY2=1&($O(T(0))>Z1) DY2=2 I DY2=2 S Z1=Z1+1440,Z2=Z2+1440
 S:Z2'>Z1 Z2=Z2+1440,DY2=2 Q
V1 I $P(ZN,"^",K+2),"RG"'[$P($G(^PRST(457.2,+$P(ZN,"^",K+2),0)),"^",2) Q
 S TIM=TIM+Z2-Z1 Q
E1 S STR="A start time is not less than a stop time." G E10
E2 S STR="End of one segment must not be greater than start of next." G E10
E3 S STR="Duplicate start times encountered." G E10
E4 S STR="Segment of second day encountered; no two-day tour specified." G E10
E5 S STR="Segment of third day encountered." G E10
E6 S STR="At least one time segment must be defined." G E10
E7 S STR="Stop Time not entered for a segment." G E10
E8 S STR="Meal period cannot exceed duty hours." G E10
E10 K ZS S DDSERROR=1,TIM=0 D HLP^DDSUTL(.STR) Q
DISP ; Display Tour of Duty
 D HDR K DIC
 S DIC="^PRST(457.1,",DIC(0)="AEQMN",DIC("A")="Select TOUR OF DUTY: " D ^DIC K DIC G:Y'>0 EX
 S DA=+Y,DDSFILE=457.1,DR="[PRSA TD DISP]" D ^DDS K DS G DISP
HDR ; Header
 W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM",!!?33,"TOUR OF DUTY",!!! Q
EX G KILL^XUSCLEAN
