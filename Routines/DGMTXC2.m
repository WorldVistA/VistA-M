DGMTXC2 ; ;12/20/02
 D DE G BEGIN
DE S DIE="^DGMT(408.31,",DIC=DIE,DP=408.31,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DGMT(408.31,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,7) S:%]"" DE(10)=% S %=$P(%Z,U,13) S:%]"" DE(1)=% S %=$P(%Z,U,16) S:%]"" DE(7)=% S %=$P(%Z,U,20) S:%]"" DE(12)=% S %=$P(%Z,U,21) S:%]"" DE(13)=% S %=$P(%Z,U,22) S:%]"" DE(14)=% S %=$P(%Z,U,27) S:%]"" DE(4)=%
 I $D(^(2)) S %Z=^(2) S %=$P(%Z,U,1) S:%]"" DE(15)=% S %=$P(%Z,U,4) S:%]"" DE(16)=% S %=$P(%Z,U,9) S:%]"" DE(17)=%
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
N I X="" G NKEY:$D(^DD("KEY","F",DP,DIFLD)),A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) I X?.ANP D SET I 'DDER X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
 K DDER G X
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) G:DV["*" AST^DIED D NOSCR^DIED S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V D @("X"_DQ) K YS
Z K DIC("S"),DLAYGO I $D(X),X'=U D:$G(DE(DW,"INDEX")) SAVEVALS G:'$$KEYCHK UNIQFERR^DIE17 S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
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
SAVEVALS S @DIEZTMP@("V",DP,DIIENS,DIFLD,"O")=$G(DE(DQ)) S:$D(^("F"))[0 ^("F")=$G(DE(DQ))
 I $D(DE(DW,"4/")) S @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")=""
 E  K @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")
 Q
NKEY W:'$D(ZTQUEUED) "??  Required key field" S X="?BAD" G QS
KEYCHK() Q:$G(DE(DW,"KEY"))="" 1 Q @DE(DW,"KEY")
BEGIN S DNM="DGMTXC2",DQ=1
1 S DW="0;13",DV="NJ8,2",DU="",DLB="THRESHOLD B",DIFLD=.13
 S X=DGTHB
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X1 Q
2 S DQ=3 ;@50
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 I '$D(DGTHG) S Y="@55"
 Q
4 S DW="0;27",DV="NJ8,2",DU="",DLB="GMT THRESHOLD",DIFLD=.27
 S X=DGTHG
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X4 Q
5 S DQ=6 ;@55
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S:'$P(^DGMT(408.31,DA,0),U,16)&('$D(DGMTPAR("PREV"))) Y="@60"
 Q
7 S DW="0;16",DV="S",DU="",DLB="PREVIOUS YEARS THRESHOLD",DIFLD=.16
 S DE(DW)="C7^DGMTXC2"
 S DU="1:YES;"
 S X=$S($D(DGMTPAR("PREV")):1,1:"@")
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C7 G C7S:$D(DE(7))[0 K DB
 S X=DE(7),DIC=DIE
 K ^DGMT(408.31,"AP",X,$P(^DGMT(408.31,DA,0),U),DA)
C7S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 S ^DGMT(408.31,"AP",X,$P(^DGMT(408.31,DA,0),U),DA)=""
 Q
X7 Q
8 S DQ=9 ;@60
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 S:DGMTDT'<DT Y="@998"
 Q
10 D:$D(DG)>9 F^DIE17,DE S DQ=10,DW="0;7",DV="DXR",DU="",DLB="DATE/TIME COMPLETED",DIFLD=.07
 S DE(DW)="C10^DGMTXC2"
 G RE
C10 G C10S:$D(DE(10))[0 K DB
 S X=DE(10),DIC=DIE
 K ^DGMT(408.31,"AG",$E(X,1,30),DA)
C10S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 S ^DGMT(408.31,"AG",$E(X,1,30),DA)=""
 Q
X10 S %DT="ETX",%DT(0)="-NOW" D ^%DT S X=Y K:Y<1 X I $D(X) D COM^DGMTDD
 Q
 ;
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 I $P(^DGMT(408.31,DA,0),U,3)'=6 S Y="@998"
 Q
12 D:$D(DG)>9 F^DIE17,DE S DQ=12,DW="0;20",DV="S",DU="",DLB="HARDSHIP?",DIFLD=.2
 S DE(DW)="C12^DGMTXC2"
 S DU="1:YES;0:NO;"
 S Y="@"
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C12 G C12S:$D(DE(12))[0 K DB
 S X=DE(12),DIC=DIE
 K ^DGMT(408.31,"AE",$E(X,1,30),DA)
 S X=DE(12),DIC=DIE
 S:'$P(^DGMT(408.31,DA,0),U,20) $P(^DGMT(408.31,DA,0),U,21,22)="^"
C12S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 S ^DGMT(408.31,"AE",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 S:'X $P(^DGMT(408.31,DA,0),U,21,22)="^"
 Q
X12 Q
13 D:$D(DG)>9 F^DIE17,DE S DQ=13,DW="0;21",DV="RD",DU="",DLB="HARDSHIP REVIEW DATE",DIFLD=.21
 S Y="@"
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X13 Q
14 S DW="0;22",DV="RP200'",DU="",DLB="APPROVED BY",DIFLD=.22
 S DU="VA(200,"
 S Y="@"
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X14 Q
15 S DW="2;1",DV="D",DU="",DLB="HARDSHIP EFFECTIVE DATE",DIFLD=2.01
 S Y="@"
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X15 Q
16 S DW="2;4",DV="F",DU="",DLB="SITE GRANTING HARDSHIP",DIFLD=2.04
 S Y="@"
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X16 Q
17 S DW="2;9",DV="F",DU="",DLB="HARDSHIP REASON",DIFLD=2.09
 S Y="@"
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X17 Q
18 S DQ=19 ;@998
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 D X19 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X19 S DGFIN=""
 Q
20 S DQ=21 ;@999
21 G 0^DIE17
