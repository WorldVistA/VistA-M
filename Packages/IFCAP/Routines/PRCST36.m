PRCST36 ; ;10/11/96
 D DE G BEGIN
DE S DIE="^PRCS(410,D0,""IT"",",DIC=DIE,DP=410.02,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^PRCS(410,D0,"IT",DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,4) S:%]"" DE(1)=% S %=$P(%Z,U,11) S:%]"" DE(4)=%
 K %Z Q
 ;
W W !?DL+DL-2,DLB_": "
 Q
O D W W Y W:$X>45 !?9
 I $L(Y)>19,'DV,DV'["I",(DV["F"!(DV["K")) G RW^DIR2
 W:Y]"" "// " I 'DV,DV["I",$D(DE(DQ))#2 S X="" W "  (No Editing)" Q
TR R X:DTIME E  S (DTOUT,X)=U W $C(7)
 Q
A K DQ(DQ) S DQ=DQ+1
B G @DQ
RE G PR:$D(DE(DQ)) D W,TR
N I X="" G A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) I X?.ANP D SET I 'DDER X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
 K DDER G X
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) I DV'["*" D ^DIC S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V D @("X"_DQ) K YS
Z K DIC("S"),DLAYGO I $D(X),X'=U S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
X W:'$D(ZTQUEUED) $C(7),"??" I $D(DB(DQ)) G Z^DIE17
 S X="?BAD"
QS S DZ=X D D,QQ^DIEQ G B
D S D=DIFLD,DQ(DQ)=DLB_U_DV_U_DU_U_DW_U_$P($T(@("X"_DQ))," ",2,99) Q
Y I '$D(DE(DQ)) D O G RD:"@"'[X,A:DV'["R"&(X="@"),X:X="@" S X=Y G N
PR S DG=DV,Y=DE(DQ),X=DU I $D(DQ(DQ,2)) X DQ(DQ,2) G RP
R I DG["P",@("$D(^"_X_"0))") S X=+$P(^(0),U,2) G RP:'$D(^(Y,0)) S Y=$P(^(0),U),X=$P(^DD(X,.01,0),U,3),DG=$P(^(0),U,2) G R
 I DG["V",+Y,$P(Y,";",2)["(",$D(@(U_$P(Y,";",2)_"0)")) S X=+$P(^(0),U,2) G RP:'$D(^(+Y,0)) S Y=$P(^(0),U) I $D(^DD(+X,.01,0)) S DG=$P(^(0),U,2),X=$P(^(0),U,3) G R
 X:DG["D" ^DD("DD") I DG["S" S %=$P($P(";"_X,";"_Y_":",2),";") S:%]"" Y=%
RP D O I X="" S X=DE(DQ) G A:'DV,A:DC<2,N^DIE17
I I DV'["I",DV'["#" G RD
 D E^DIE0 G RD:$D(X),PR
 Q
SET N DIR S DIR(0)="SV"_$E("o",$D(DB(DQ)))_U_DU,DIR("V")=1
 I $D(DB(DQ)),'$D(DIQUIET) N DIQUIET S DIQUIET=1
 D ^DIR I 'DDER S %=Y(0),X=Y
 Q
BEGIN S DNM="PRCST36",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW="0;4",DV="RFX",DU="",DLB="BOC",DIFLD=4
 S DE(DW)="C1^PRCST36"
 S X="" S:$D(PRCS("SUB")) X=PRCS("SUB")
 S Y=X
 G Y
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 K ^PRCS(410,"AD",$E(X,1,30),DA(1))
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRCS(410,"AD",$E(X,1,30),DA(1))=""
 Q
X1 K:X[""""!($A(X)=45) X I $D(X) D SUB^PRCSES
 I $D(X),X'?.ANP K X
 Q
 ;
2 S DQ=3 ;@2
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 I $D(^PRC(411,PRC("SITE"),0)),$P(^(0),U,18)'="Y" S Y="@3"
 Q
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="0;11",DV="P420.9'",DU="",DLB="INTERMEDIATE PRODUCT CODE",DIFLD=10
 S DU="PRCD(420.9,"
 G RE
X4 Q
5 S DQ=6 ;@3
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 D 2^PRCSCK
 Q
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 I $D(PRCSERR),PRCSERR S Y=PRCSERR K PRCSERR
 Q
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 D QRB^PRCSCK
 Q
9 S D=0 K DE(1) ;12
 S DIFLD=12,DGO="^PRCST37",DC="2^410.212I^2^",DV="410.212MNJ2,0",DW="0;1",DOW="DELIVERY SCHEDULE",DLB="Select "_DOW S:D DC=DC_D
 G RE:D I $D(DSC(410.212))#2,$P(DSC(410.212),"I $D(^UTILITY(",1)="" X DSC(410.212) S D=$O(^(0)) S:D="" D=-1 G M9
 S D=$S($D(^PRCS(410,D0,"IT",DA,2,0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M9 I D>0 S DC=DC_D I $D(^PRCS(410,D0,"IT",DA,2,+D,0)) S DE(9)=$P(^(0),U,1)
 G RE
R9 D DE
 S D=$S($D(^PRCS(410,D0,"IT",DA,2,0)):$P(^(0),U,3,4),1:1) G 9+1
 ;
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 K PRCSMDP
 Q
11 G 1^DIE17
