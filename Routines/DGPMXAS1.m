DGPMXAS1 ; ;06/26/96
 D DE G BEGIN
DE S DIE="^DGPM(",DIC=DIE,DP=405,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DGPM(DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,7) S:%]"" DE(1)=% S %=$P(%Z,U,10) S:%]"" DE(6)=% S %=$P(%Z,U,11) S:%]"" DE(4)=% S %=$P(%Z,U,12) S:%]"" DE(2)=%
 I $D(^("ODS")) S %Z=^("ODS") S %=$P(%Z,U,1) S:%]"" DE(9)=%
 I $D(^("USR")) S %Z=^("USR") S %=$P(%Z,U,3) S:%]"" DE(10)=% S %=$P(%Z,U,4) S:%]"" DE(12)=%
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
BEGIN S DNM="DGPMXAS1",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW="0;7",DV="*P405.4'X",DU="",DLB="ROOM-BED",DIFLD=.07
 S DE(DW)="C1^DGPMXAS1"
 S DU="DG(405.4,"
 S X=$P(DGPMA,"^",7)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 S DGPMDDF=7,DGPMDDT=0 D ^DGPMDDCN
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S DGPMDDF=7,DGPMDDT=1 D ^DGPMDDCN
 Q
X1 Q
2 D:$D(DG)>9 F^DIE17,DE S DQ=2,DW="0;12",DV="R*P43.4'",DU="",DLB="ADMITTING REGULATION",DIFLD=.12
 S DU="DIC(43.4,"
 G RE
X2 S DIC("S")="I '$P(^(0),""^"",4)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 I $S('$D(^DPT(DFN,.3)):1,$P(^(.3),"^",1)'="Y":1,1:0) S Y="@1"
 Q
4 S DW="0;11",DV="S",DU="",DLB="ADMITTED FOR SC CONDITION?",DIFLD=.11
 S DU="1:YES;0:NO;"
 G RE
X4 Q
5 S DQ=6 ;@1
6 S DW="0;10",DV="RFX",DU="",DLB="DIAGNOSIS [SHORT]",DIFLD=.1
 G RE
X6 K:$L(X)>30!($L(X)<3)!(X[";") X
 I $D(X),X'?.ANP K X
 Q
 ;
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 G A
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 D DFN^DGYZODS S:'DGODS Y=102
 Q
9 S DW="ODS;1",DV="S",DU="",DLB="ODS AT ADMISSION",DIFLD=11500.01
 S DU="1:YES;0:NO;"
 S Y="1"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X9 Q
10 S DW="USR;3",DV="RP200'",DU="",DLB="LAST EDITED BY",DIFLD=102
 S DU="VA(200,"
 S X=DUZ
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X10 Q
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 G A
12 S DW="USR;4",DV="RD",DU="",DLB="LAST EDITED ON",DIFLD=103
 S %=$P($H,",",2),X=DT_(%\60#60/100+(%\3600)+(%#60/10000)/100)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X12 S %DT="STX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
13 G 0^DIE17
