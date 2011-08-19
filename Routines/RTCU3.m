RTCU3 ; ;07/15/96
 D DE G BEGIN
DE S DIE="^RTV(190.1,",DIC=DIE,DP=190.1,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^RTV(190.1,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,2) S:%]"" DE(6)=% S %=$P(%Z,U,3) S:%]"" DE(7)=% S %=$P(%Z,U,6) S:%]"" DE(8)=% S %=$P(%Z,U,7) S:%]"" DE(9)=% S %=$P(%Z,U,8) S:%]"" DE(10)=% S %=$P(%Z,U,10) S:%]"" DE(11)=%
 I $D(^("COMMENT")) S %Z=^("COMMENT") S %=$P(%Z,U,1) S:%]"" DE(1)=%,DE(4)=%
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
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) D SET I 'DDER X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
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
SET I X'?.ANP S DDER=1 Q 
 N DIR S DIR(0)="SMV^"_DU,DIR("V")=1
 I $D(DB(DQ)),'$D(DIQUIET) N DIQUIET S DIQUIET=1
 D ^DIR I 'DDER S %=Y(0),X=Y
 Q
BEGIN S DNM="RTCU3",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW="COMMENT;1",DV="F",DU="",DLB="COMMENT",DIFLD=75
 S X=$S($D(RTCOM):RTCOM,1:"")
 S Y=X
 G Y
X1 K:$L(X)>50!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S Y="@60"
 Q
3 S DQ=4 ;@55
4 S DW="COMMENT;1",DV="F",DU="",DLB="COMMENT",DIFLD=75
 S X=$S($D(RTCOM):RTCOM,1:"")
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X4 K:$L(X)>50!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
5 S DQ=6 ;@60
6 S DW="0;2",DV="RD",DU="",DLB="DATE/TIME REQUESTED",DIFLD=2
 S DE(DW)="C6^RTCU3"
 S X=RTNOW
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
C6 G C6S:$D(DE(6))[0 K DB S X=DE(6),DIC=DIE
 K ^RTV(190.1,"AD",$E(X,1,30),DA)
C6S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^RTV(190.1,"AD",$E(X,1,30),DA)=""
 Q
X6 Q
7 D:$D(DG)>9 F^DIE17,DE S DQ=7,DW="0;3",DV="P200'",DU="",DLB="USER REQUESTING RECORD",DIFLD=3
 S DU="VA(200,"
 S X=RTDUZ
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X7 Q
8 S DW="0;6",DV="S",DU="",DLB="REQUEST STATUS",DIFLD=6
 S DU="c:CHARGED;x:CANCELLED;r:REQUESTED;n:NOT FILLABLE;"
 S X="r"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X8 Q
9 S DW="0;7",DV="D",DU="",DLB="DATE/TIME CURRENT STATUS",DIFLD=7
 S X=RTNOW
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X9 Q
10 S DW="0;8",DV="P200'",DU="",DLB="USER RESPONSIBLE FOR STATUS",DIFLD=8
 S DU="VA(200,"
 S X=RTDUZ
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X10 Q
11 S DW="0;10",DV="P194.2'",DU="",DLB="PULL LIST",DIFLD=10
 S DE(DW)="C11^RTCU3"
 S DU="RTV(194.2,"
 S X=$S($D(RTPULL):RTPULL,1:"")
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
C11 G C11S:$D(DE(11))[0 K DB S X=DE(11),DIC=DIE
 K ^RTV(190.1,"AP",$E(X,1,30),DA)
 S X=DE(11),DIC=DIE
 K ^RTV(190.1,"AP1",X,+^RTV(190.1,DA,0),DA)
C11S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^RTV(190.1,"AP",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 S ^RTV(190.1,"AP1",X,+^RTV(190.1,DA,0),DA)=""
 Q
X11 Q
12 D:$D(DG)>9 F^DIE17 G ^RTCU4
