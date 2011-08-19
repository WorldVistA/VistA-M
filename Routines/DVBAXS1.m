DVBAXS1 ; ;08/19/96
 D DE G BEGIN
DE S DIE="^DVB(396,",DIC=DIE,DP=396,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DVB(396,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,12) S:%]"" DE(2)=% S %=$P(%Z,U,13) S:%]"" DE(6)=% S %=$P(%Z,U,14) S:%]"" DE(9)=%,DE(13)=% S %=$P(%Z,U,15) S:%]"" DE(17)=%
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,14) S:%]"" DE(1)=% S %=$P(%Z,U,15) S:%]"" DE(12)=%
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
BEGIN S DNM="DVBAXS1",DQ=1
1 S DW="1;14",DV="F",DU="",DLB="EDIT5.5",DIFLD=5.9
 S X=OPER
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X1 Q
2 S DW="0;12",DV="D",DU="",DLB="HOSP SUMMARY COMPLETION DATE",DIFLD=5.8
 G RE
X2 S %DT="EX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 I X=""&(DVBASTAT="C") W *7,!!,"Completed status must have date.",!! S Y="@3"
 Q
4 S DQ=5 ;@4
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 S CODE=$P(^DVB(396,D0,0),U,13) S:CODE="" Y="@6" S:DVBACORR="N"&(CODE'="P") Y="@6"
 Q
6 S DW="0;13",DV="S",DU="",DLB="(21-DAY) CERTIFICATE STATUS",DIFLD=6.5
 S DU="P:PENDING;C:COMPLETED;"
 G RE
X6 Q
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 S DVBASTAT=X S:X="C" Y="@5"
 Q
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 S DVBADT=$P(^DVB(396,D0,0),U,14) S:DVBADT=""&(X="P") Y="@6"
 Q
9 S DW="0;14",DV="D",DU="",DLB="(21-DAY) COMPLETION DATE",DIFLD=6.8
 S Y="@"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X9 S %DT="X" D ^%DT S X=Y K:Y<1 X
 Q
 ;
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S Y="@6"
 Q
11 S DQ=12 ;@5
12 S DW="1;15",DV="F",DU="",DLB="EDIT6.5",DIFLD=6.9
 S X=OPER
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X12 Q
13 S DW="0;14",DV="D",DU="",DLB="(21-DAY) COMPLETION DATE",DIFLD=6.8
 G RE
X13 S %DT="EX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 I X=""&(DVBASTAT="C") W *7,!!,"Completed status must have date.",!! S Y="@5"
 Q
15 S DQ=16 ;@6
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 S CODE=$P(^DVB(396,D0,0),U,15) S:CODE="" Y="@8" S:DVBACORR="N"&(CODE'="P") Y="@8"
 Q
17 S DW="0;15",DV="S",DU="",DLB="STATUS OF OTHER/EXAM",DIFLD=8
 S DU="P:PENDING;C:COMPLETED;"
 G RE
X17 Q
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 S DVBASTAT=X S:X="C" Y="@7"
 Q
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 D X19 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X19 S DVBADT=$S($D(^DVB(396,D0,1)):$P(^(1),U,2),1:"") S:DVBADT=""&(X="P") Y="@8"
 Q
20 D:$D(DG)>9 F^DIE17 G ^DVBAXS2
