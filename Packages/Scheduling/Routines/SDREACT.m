SDREACT ;ALB/TMP - REACTIVATE A CLINIC ; 30 APR 85  9:02 am 
 ;;5.3;Scheduling;**63,167,380,568**;Aug 13, 1993;Build 14
 S:'$D(DTIME) DTIME=300 I '$D(DT) D DT^SDUTL
 S DIC="^SC(",DIC(0)="AEMZQ",DIC("A")="Select CLINIC NAME: ",DIC("S")="I $P(^(0),""^"",3)=""C"",'$G(^(""OOS""))"
 D TURNON^DIAUTL(44,".01;8;2502;2503;2505;2506")
 D ^DIC K DIC G:Y<0 END S DA=+Y I $S('$D(^SC(DA,"I")):1,'$P(^("I"),"^",1):1,1:0) W *7,!,"NOT INACTIVE!!" G SDREACT
 S SDX=+^SC(DA,"I"),SDX1=+$P(^("I"),"^",2) G:'SDX1 PREACT
 I SDX1>DT W !,*7,"Clinic is inactive as of " S Y=SDX D DTS^SDUTL W Y S Y=SDX1 D DTS^SDUTL W !,?5,"and is already scheduled to be reactivated as of ",Y G CHG
 W *7,!,"Clinic cannot be reactivated - not inactive" G SDREACT
PREACT N SDRES S SDRES=$$CLNCK^SDUTL2(DA,1)
 I 'SDRES W !,?5,"Clinic MUST be corrected before continuing." G SDREACT
REACT S SDREACT="" S %DT("A")="Enter date clinic is to be reactivated: ",%DT="AEX" D ^%DT G:Y<0 SDREACT
 K %DT S (SD,SDH,SDRE)=Y,(SDINACT,SDIN)=SDX
 I SD'>SDINACT W !,*7,"Reactivate date must be later than inactivate date" G REACT
 G:'$D(^SC(DA,"SL")) SDREACT S SL=^("SL"),X=$P(^("SL"),"^",3),STARTDAY=$S($L(X):X,1:8),SI=$P(^("SL"),"^",6),SDFSW="",X=SD,SDRE1=SDRE D DOW^SDM0 S DOW=Y
 S Y=SD D DTS^SDUTL W !!,"AVAILABILITY DATE: ",Y,"  (" S Y=SD D DT^DIQ W ")" S (SDZQ,SDEL,POP)=0 D EN1^SDB0
 I '$D(SDREACT) W *7,!,"Clinic not reactivated!!!" G END
 F I=0:1:6 F I1=0:0 S I1=$O(^SC(DA,"T"_I,I1)),I2=$S(I1'>0:0,'$D(^(I1,1)):0,^(1)]"":1,1:0) Q:I2  I I1'>0 D CLEAN Q
 K IENS,FDA S IENS=DA_",",FDA(44,IENS,2506)=SDH D FILE^DIE("","FDA")
 S Y=SDH D DTS^SDUTL W !,*7,"Clinic will be reactivated effective ",Y
MORE W !,"Do you want to set up additional availabilities for this clinic now" S %=1 D YN^DICN I '% W !,"ANSWER (Y)ES OR (N)O" G MORE
 G:(%-1)!(%<0) END S SDZQ=1 G EN^SDB
 ;
CHG W !,"Do you want to change the reactivate date" S %=1 D YN^DICN I '% W !,"RESPOND YES (Y) OR NO (N)" G CHG
 G END:(%<0),DEL:(%-1)
DT R !,"Enter new reactivate date: ",X:DTIME G:"^"[X END S %DT="EX" D ^%DT G:Y<0 DT
 I Y'>SDX W *7,!,"Must be > inactivate date" G DT
 I Y=SDX1 W *7,!,"That is the current reactivate date" G DT
 S SDRE=+Y
 S POP=0 I SDRE>SDX1 S K=SDRE_.9 F I=SDX1-.1:0 S I=$O(^SC(DA,"S",I)) Q:I'>0!(I>K)  F J=0:0 S J=$O(^SC(DA,"S",I,1,J)) Q:J'>0  I $P(^(J,0),"^",9)'["C" S POP=1 Q
 I POP W !,"Valid appointments exist before the new reactivate date ... must reactivate before " S Y=I D DTS^SDUTL W Y G REACT
 K SDN S X=SDRE D NEW
 K SDO S X=SDX1 D DOW^SDM0 S SDO(Y)=X F I=1:1:6 S X1=X,X2=1 D C^%DTC,DOW^SDM0 S SDO(Y)=X
 I SDRE>SDX1 D C1
 F I=0:1:6 I $D(^SC(DA,"T"_I,SDO(I),1)) S ^SC(DA,"T"_I,SDN(I),1)=^SC(DA,"T"_I,SDO(I),1),^(0)=SDN(I) I SDN(I)'=SDO(I) K ^SC(DA,"T"_I,SDO(I))
 K IENS,FDA S IENS=DA_",",FDA(44,IENS,2506)=SDRE D FILE^DIE("","FDA")
 W !,"Clinic will now be reactivated effective " S Y=SDRE D DTS^SDUTL W Y G END
C1 F I=SDX-.1:0 S I=$O(^SC(DA,"ST",I)) Q:I'>0!(I'<SDRE)  K ^(I)
 F I=SDX-.1:0 S I=$O(^SC(DA,"T",I)) Q:I'>0!(I'<SDRE)  K ^(I)
 F I=SDX-.1:0 S I=$O(^SC(DA,"OST",I)) Q:I'>0!(I'<SDRE)  K ^(I)
 Q
DEL S POP=0 F I=SDX1-.1:0 S I=$O(^SC(DA,"S",I)) Q:I'>0  F J=0:0 S J=$O(^SC(DA,"S",I,1,J)) Q:J'>0  I $P(^(J,0),"^",9)'["C" S POP=1 Q
 G:POP END
D1 S %=2 W !,"Do you want to delete the reactivate date" D YN^DICN I '% W !,"RESPOND YES (Y) OR NO (N)" G D1
 G END:(%-1)
 F I=SDX1-.1:0 S I=$O(^SC(DA,"T",I)) Q:I'>0  K ^(I)
 K SDN S X=SDX D NEW
 F I=0:1:6 F J=SDN(I):0 S J=$O(^SC(DA,"T"_I,J)) S:J'>0 ^SC(DA,"T"_I,9999999,1)="",^(0)=9999999 Q:J'>0  K:J'=9999999 ^SC(DA,"T"_I,J) I J=9999999 S ^SC(DA,"T"_I,J,1)="",^(0)=J Q
 F I=SDX1-.1:0 S I=$O(^SC(DA,"OST",I)) Q:I'>0  K ^(I)
 F I=SDX1-.1:0 S I=$O(^SC(DA,"ST",I)) Q:I'>0  K ^(I)
 K IENS,FDA S IENS=DA_",",FDA(44,IENS,2506)="@" D FILE^DIE("","FDA")
 W !,*7,"Reactivation date DELETED!!" G END
 ;
NEW D DOW^SDM0 S SDN(Y)=X F I=1:1:6 S X1=X,X2=1 D C^%DTC,DOW^SDM0 S SDN(Y)=X
 Q
CLEAN F I2=0:0 S I2=$O(^SC(DA,"T"_I,I2)) Q:I2'>0  K ^(I2)
 Q
 ;
END K CNT,D0,DA,DIC,DH,DO,DOW,H1,H2,HSDX,SDX1,SDZQ,SI,I,I1,I2,J,K,LT,M1,M2,NSL,POP,SC,SD,SDH,SDFSW,SDIN,SDINACT,SDN,SDO,SDRE,SDRE1,SDREACT,SDTOP,SI,SL,SLT,STARTDAY,STIME,T1,T2,X,X1,X2,Y Q
