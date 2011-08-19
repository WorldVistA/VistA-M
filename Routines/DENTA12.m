DENTA12 ;ISC2/SAW,HAG-TREATMENT DATA SUMMARY REPORT BY SITTINGS ; 12/2/88  7:22 PM ;
 ;VERSION 1.2
A W !!,"Would you like to review the data for all providers" S %=1 D YN^DICN D:%=0 Q^DENTAR11 G A:%=0,EXIT:%<0,SKP:%=1
SEL R !!,"Select DENTAL PROVIDER NAME: ",X:DTIME G EXIT:X=""!(X=U)
 S DIC="^DENT(220.5,",DIC(0)="EQMZ" D ^DIC G SEL:X["?" K DIC I Y>0 S (DENTP,DENTPRV)=$P(Y(0),"^",2) G SKP
 G:X?4N SK:$D(^DENT(221,"C",X))
 W !!,"Provider does not exist." G SEL
SK W !!,"This provider is not in the provider file, but there are entries for him/her",!,"in the Treatment Data file.  Okay to continue" S %=1 D YN^DICN D:%=0 Q G SK:%=0,EXIT:%<0,SEL:%=2 S (DENTP,DENTPRV)=X
SKP W !!,"Would you like to review released data only" S %=2 D YN^DICN D:%=0 Q1 G SKP:%=0,EXIT:%<0 S:%=1 DENTREL=1
 S %ZIS="MQ" K IO("Q") D ^%ZIS G EXIT:IO=""
 I $D(IO("Q")) S ZTRTN="QUE^DENTA12",ZTSAVE("DENT*")="",ZTSAVE("DT")="",ZTSAVE("U")="",ZTSAVE("Z1")="",ZTSAVE("Z2")="",ZTSAVE("Z5")="",ZTSAVE("H*")="" D ^%ZTLOAD K ZTSK,ZTRTN,ZTSAVE G EXIT
QUE U IO S DENTPRV1=$S($D(DENTPRV):DENTPRV,1:""),DENTPRV=$S($D(DENTPRV):DENTPRV-1,1:""),DENTC=0,DENTSD=DENTSD-.0001 S:$L(DENTPRV)<4&(DENTPRV]"") DENTPRV=$E("000"_DENTPRV,$L(DENTPRV),$L(DENTPRV)+3) S DENTPRV2=DENTPRV
 F I=0:0 S DENTSD=$O(^DENT(221,"AC1",DENTSTA,DENTSD)) Q:DENTSD>DENTED!(DENTSD="")  S DENTPRV=DENTPRV2 F J=0:0 S DENTPRV=$O(^DENT(221,"AC1",DENTSTA,DENTSD,DENTPRV)) Q:$S(DENTPRV1="":DENTPRV="",1:DENTPRV'=DENTPRV1)  D RPT
 K DENTCAT,DENTPRV1,DENTF,DENTSD,DENTED,X,Z1,Z2 D ^DENTA16 G CLOSE
RPT S:'$D(^UTILITY($J,"DENTR",DENTPRV)) ^(DENTPRV)="" S DENT="",DENTC(1)=0 F K=0:0 S DENT=$O(^DENT(221,"AC1",DENTSTA,DENTSD,DENTPRV,DENT)) Q:DENT=""  D:$D(^DENT(221,DENT,0)) P1
 S ^UTILITY($J,"DENTR",DENTPRV)=^UTILITY($J,"DENTR",DENTPRV)+DENTC(1) Q
P1 S DENTC=DENTC+1,X=^DENT(221,DENT,0),DENTF=0,DENTC(1)=DENTC(1)+1
 I $P(X,U,27)'=""!($P(X,U,44)'="") D SPOT Q
 D CHK^DENTA15 Q:DENTF  S DENTCAT=$P(X,U,19)
 I $P(X,U,41) S X(2)=$P(X,U,41),^UTILITY($J,"DENTR",DENTPRV,DENT)=$S($D(^UTILITY($J,"DENTR",DENTPRV,DENT)):^(DENT)_U_X(2)_U_1,1:X(2)_U_1)
 I $P(X,U,8) S ^UTILITY($J,"DENTR",DENTPRV,DENT)=$S($D(^UTILITY($J,"DENTR",DENTPRV,DENT)):^(DENT)_U_39_U_1,1:39_U_1)
 I $P(X,U,7)'="" S X(2)=$S($P(X,U,7)="S":"4",1:"5"),^UTILITY($J,"DENTR",DENTPRV,DENT)=$S($D(^UTILITY($J,"DENTR",DENTPRV,DENT)):^(DENT)_U_X(2)_U_1,1:X(2)_U_1)
 F M=9,11:1:18,20,22:1:26,28:1:38,42:1:43 I $P(X,U,M) D P11
 I '$D(^UTILITY($J,"DENTR",DENTPRV,DENT)) S ^(DENT)=""
 Q
P11 S X(2)=$P($T(S),";",M),X(3)=$P(X,U,M),X(3)=0_X(3),X(3)=$E(X(3),($L(X(3))-1),$L(X(3))),^UTILITY($J,"DENTR",DENTPRV,DENT)=$S($D(^UTILITY($J,"DENTR",DENTPRV,DENT)):^(DENT)_U_+X(2)_U_+X(3),1:+X(2)_U_+X(3))
 Q
SPOT S X(1)=$S($P(X,U,44)'="":$P(X,U,44),1:$P(X,U,27)),X(2)=$S(X(1)=1:35,X(1)=2:36,1:37)
 D CHK^DENTA15 Q:DENTF  S DENTCAT=$P(X,U,19)
 S ^UTILITY($J,"DENTR",DENTPRV,DENT)=$S($D(^UTILITY($J,"DENTR",DENTPRV,DENT)):^(DENT)_U_X(2)_U_1,1:X(2)_U_1)
 I $P(X,U,45) S ^UTILITY($J,"DENTR",DENTPRV,DENT)=$S($D(^UTILITY($J,"DENTR",DENTPRV,DENT)):^(DENT)_U_38_U_$P(X,U,45),1:38_U_$P(X,U,45))
 Q
S ;;;04;05;;;;08;;09;15;16;33;10;20;21;22;;23;;11;12;13;14;17;;24;25;26;27;28;29;30;31;18;19;32;;;;34;06
Q W !!,"Press return to continue on and generate a report for this provider.",!,"Enter an 'N' for 'No' if you want to back up and select a different provider.",!,"Enter an uparrow (^) to exit this option altogether." Q
Q1 W !!,"Enter a 'Y' for 'Yes' if you want to include only data that you have previously",!,"released during the timeframe you have just specified in this report."
 W !,"Press return if you want to include all data (released or unreleased) in this",!,"report.  Enter an uparrow (^) to exit this option altogether." Q
CLOSE X ^%ZIS("C")
EXIT K %,DENT,DENTCAT,DENTCAT1,DENTDAT,DENTED,DENTF,DENTP,DENTPRV,DENTPRV1,DENTPRV2,DENTREL,DENTSD,DIC,I,J,K,M,X,Y D:$D(ZTSK) EXIT1^DENTA1 Q
