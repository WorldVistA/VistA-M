PRCHT39 ; ;10/06/97
 D DE G BEGIN
DE S DIE="^PRC(442,",DIC=DIE,DP=442,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRC(442,DA,""))=""
 I $D(^(17)) S %Z=^(17) S %=$P(%Z,U,2) S:%]"" DE(1)=% S %=$P(%Z,U,3) S:%]"" DE(2)=% S %=$P(%Z,U,4) S:%]"" DE(5)=% S %=$P(%Z,U,5) S:%]"" DE(8)=% S %=$P(%Z,U,6) S:%]"" DE(9)=% S %=$P(%Z,U,7) S:%]"" DE(10)=% S %=$P(%Z,U,8) S:%]"" DE(11)=%
 I  S %=$P(%Z,U,9) S:%]"" DE(12)=% S %=$P(%Z,U,11) S:%]"" DE(3)=% S %=$P(%Z,U,16) S:%]"" DE(4)=% S %=$P(%Z,U,17) S:%]"" DE(6)=%
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
BEGIN S DNM="PRCHT39",DQ=1
1 S DW="17;2",DV="RF",DU="",DLB="DOCUMENT IDENTIFIER CODE",DIFLD=71
 S X="A0A"
 S Y=X
 G Y
X1 K:$L(X)>3!($L(X)<3)!'(X?.UN) X
 I $D(X),X'?.ANP K X
 Q
 ;
2 S DW="17;3",DV="R*P441.4'",DU="",DLB="ROUTING INDENTIFIER CODE",DIFLD=72
 S DU="PRCD(441.4,"
 G RE
X2 S DIC("S")="I $P(^(0),U,2)=""R""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
3 S DW="17;11",DV="R*P441.4'",DU="",DLB="MEDIA & STATUS CODE",DIFLD=80
 S DU="PRCD(441.4,"
 S X="T"
 S Y=X
 G Y
X3 S DIC("S")="I $P(^(0),U,2)=""M""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
4 S DW="17;16",DV="FX",DU="",DLB="ACTIVITY ADDRESS CODE",DIFLD=72.4
 S X="",Z=$O(^PRC(411,+^PRC(442,DA,0),5,"AC","Y",0)) S:$D(^PRC(411,+^PRC(442,DA,0),5,+Z,0)) X=$P(^(0),U,1)
 S Y=X
 G Y
X4 K:$L(X)>6!($L(X)<6) X I $D(X),'$O(^PRC(411,+^PRC(442,DA,0),5,"B",X,0)) K X
 I $D(X),X'?.ANP K X
 Q
 ;
5 S DW="17;4",DV="*P441.4'",DU="",DLB="DEPT.DESIGNATION (DEMAND CODE)",DIFLD=73
 S DU="PRCD(441.4,"
 S X="" I $D(^PRC(442,DA,17)) S X=$S($E(+^(17),1,2)=11:"R",1:"")
 S Y=X
 G Y
X5 S DIC("S")="I $P(^(0),U,2)=""D""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
6 S DW="17;17",DV="F",DU="",DLB="SPECIAL CODE",DIFLD=73.4
 S X="Y"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X6 K:$L(X)>1!($L(X)<1)!'(X?1"Y") X
 I $D(X),X'?.ANP K X
 Q
 ;
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 W !,"SIGNAL CODE: A"
 Q
8 S DW="17;5",DV="F",DU="",DLB="SIGNAL CODE",DIFLD=74
 S X="A"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X8 K:$L(X)>1!($L(X)<1)!'("ABCDJKLM"[X) X
 I $D(X),X'?.ANP K X
 Q
 ;
9 S DW="17;6",DV="RF",DU="",DLB="FUND CODE",DIFLD=75
 G RE
X9 K:$L(X)>2!($L(X)<2) X
 I $D(X),X'?.ANP K X
 Q
 ;
10 S DW="17;7",DV="F",DU="",DLB="DISTRIBUTION CODE (OPTIONAL)",DIFLD=76
 G RE
X10 K:$L(X)>3!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
11 S DW="17;8",DV="F",DU="",DLB="PROJECT CODE",DIFLD=77
 I $D(^PRC(442,DA,17)) S X=$P(^(17),U,1)
 S Y=X
 G Y
X11 K:$L(X)>3!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
12 S DW="17;9",DV="R*P441.4'",DU="",DLB="PRIORITY CODE",DIFLD=78
 S DU="PRCD(441.4,"
 S:'$D(PRCHN("COM")) PRCHN("COM")="" S Z=$P(^PRC(442,DA,1),U,17),X=$S(PRCHN("COM")=1:10,Z="Y":"03",1:15)
 S Y=X
 G Y
X12 S DIC("S")="I $P(^(0),U,2)=""P""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
13 D:$D(DG)>9 F^DIE17 G ^PRCHT310
