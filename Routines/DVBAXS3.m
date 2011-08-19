DVBAXS3 ; ;08/19/96
 D DE G BEGIN
DE S DIE="^DVB(396,",DIC=DIE,DP=396,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DVB(396,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,19) S:%]"" DE(1)=% S %=$P(%Z,U,21) S:%]"" DE(12)=%
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,4) S:%]"" DE(4)=%,DE(8)=% S %=$P(%Z,U,5) S:%]"" DE(15)=% S %=$P(%Z,U,18) S:%]"" DE(7)=%
 I $D(^(2)) S %Z=^(2) S %=$P(%Z,U,1) S:%]"" DE(18)=%
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
BEGIN S DNM="DVBAXS3",DQ=1
1 S DW="0;19",DV="S",DU="",DLB="STATUS OF COMPETENCY REPORT",DIFLD=12
 S DU="P:PENDING;C:COMPLETED;"
 G RE
X1 Q
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S DVBASTAT=X S:X="C" Y="@11"
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 S DVBADT=$S($D(^DVB(396,D0,1)):$P(^(1),U,4),1:"") S:X="P"&(DVBADT="") Y="@12"
 Q
4 S DW="1;4",DV="D",DU="",DLB="COMPETENCY RPT COMPLETION DATE",DIFLD=12.5
 S Y="@"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X4 S %DT="X" D ^%DT S X=Y K:Y<1 X
 Q
 ;
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 S Y="@12"
 Q
6 S DQ=7 ;@11
7 S DW="1;18",DV="F",DU="",DLB="EDIT12",DIFLD=12.7
 S X=OPER
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X7 Q
8 S DW="1;4",DV="D",DU="",DLB="COMPETENCY RPT COMPLETION DATE",DIFLD=12.5
 G RE
X8 S %DT="EX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 I X=""&(DVBASTAT="C") W *7,!!,"Completed status must have date.",!! S Y="@11"
 Q
10 S DQ=11 ;@12
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 S CODE=$P(^DVB(396,D0,0),U,21) S:CODE="" Y="@14" S:DVBACORR="N"&(CODE'="P") Y="@14"
 Q
12 S DW="0;21",DV="S",DU="",DLB="STATUS OF VA FORM 21-2680",DIFLD=14
 S DU="P:PENDING;C:COMPLETED;"
 G RE
X12 Q
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 S DVBASTAT=X S:X="C" Y="@13"
 Q
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 S DVBADT=$S($D(^DVB(396,D0,1)):$P(^(1),U,5),1:"") S:X="P"&(DVBADT="") Y="@14"
 Q
15 S DW="1;5",DV="D",DU="",DLB="FORM 21-2680 COMPLETION DATE",DIFLD=14.5
 S Y="@"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X15 S %DT="X" D ^%DT S X=Y K:Y<1 X
 Q
 ;
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 S Y="@14"
 Q
17 S DQ=18 ;@13
18 S DW="2;1",DV="F",DU="",DLB="EDIT14",DIFLD=14.7
 S X=OPER
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X18 Q
19 D:$D(DG)>9 F^DIE17 G ^DVBAXS4
