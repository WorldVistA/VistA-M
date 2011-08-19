PRCST32 ; ;10/11/96
 D DE G BEGIN
DE S DIE="^PRCS(410,",DIC=DIE,DP=410,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRCS(410,DA,""))=""
 I $D(^(2)) S %Z=^(2) S %=$P(%Z,U,10) S:%]"" DE(1)=%
 I $D(^(4)) S %Z=^(4) S %=$P(%Z,U,1) S:%]"" DE(6)=% S %=$P(%Z,U,2) S:%]"" DE(8)=%
 I $D(^(9)) S %Z=^(9) S %=$P(%Z,U,4) S:%]"" DE(12)=%
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
BEGIN S DNM="PRCST32",DQ=1
1 S DW="2;10",DV="F",DU="",DLB="VENDOR PHONE NO.",DIFLD=11.9
 G RE
X1 K:$L(X)>18!($L(X)<3)!'(X?.ANP) X
 I $D(X),X'?.ANP K X
 Q
 ;
2 S DQ=3 ;@1
3 S D=0 K DE(1) ;10
 S DIFLD=10,DGO="^PRCST33",DC="22^410.02AI^IT^",DV="410.02MRNJ3,0",DW="0;1",DOW="LINE ITEM NUMBER",DLB="Select "_DOW S:D DC=DC_D
 G RE:D I $D(DSC(410.02))#2,$P(DSC(410.02),"I $D(^UTILITY(",1)="" X DSC(410.02) S D=$O(^(0)) S:D="" D=-1 G M3
 S D=$S($D(^PRCS(410,DA,"IT",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M3 I D>0 S DC=DC_D I $D(^PRCS(410,DA,"IT",+D,0)) S DE(3)=$P(^(0),U,1)
 G RE
R3 D DE
 S D=$S($D(^PRCS(410,DA,"IT",0)):$P(^(0),U,3,4),1:1) G 3+1
 ;
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 D EX1^PRCSCK,^PRCSCK
 Q
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 I $D(PRCSERR),PRCSERR S Y="@1" K PRCSERR,PRCSF,PRCSI
 Q
6 S DW="4;1",DV="RNJ10,2X",DU="",DLB="COMMITTED (ESTIMATED) COST",DIFLD=20
 S DE(DW)="C6^PRCST32"
 G RE
C6 G C6S:$D(DE(6))[0 K DB S X=DE(6),DIC=DIE
 X "Q:$P(^PRCS(410,DA,4),U,3)'=""""  S $P(^(4),""^"",8)="""" D TRANK^PRCSES"
C6S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 X "Q:$P(^PRCS(410,DA,4),U,3)'=""""  S $P(^(4),""^"",8)=X D TRANS^PRCSES"
 Q
X6 S:X["$" X=$P(X,"$",2) K:+X'=X&(X'?.N1"."2N)!(X>9999999)!(X<0) X I $D(X) W "  $ ",$J(X,0,2)
 Q
 ;
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 G A
8 D:$D(DG)>9 F^DIE17,DE S DQ=8,DW="4;2",DV="RD",DU="",DLB="DATE COMMITTED",DIFLD=21
 S Y="TODAY"
 G Y
X8 S %DT="EX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 I $D(PRCSJP) S Y=48.1
 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 D RB^PRCSCK
 Q
11 S D=0 K DE(1) ;16
 S DIFLD=16,DGO="^PRCST34",DC="3^410.04P^12^",DV="410.04M*P410.4X",DW="0;1",DOW="SUB-CONTROL POINT",DLB="Select "_DOW S:D DC=DC_D
 S DU="PRCS(410.4,"
 G RE:D I $D(DSC(410.04))#2,$P(DSC(410.04),"I $D(^UTILITY(",1)="" X DSC(410.04) S D=$O(^(0)) S:D="" D=-1 G M11
 S D=$S($D(^PRCS(410,DA,12,0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M11 I D>0 S DC=DC_D I $D(^PRCS(410,DA,12,+D,0)) S DE(11)=$P(^(0),U,1)
 G RE
R11 D DE
 S D=$S($D(^PRCS(410,DA,12,0)):$P(^(0),U,3,4),1:1) G 11+1
 ;
12 S DW="9;4",DV="NJ7,2X",DU="",DLB="EST. SHIPPING AND/OR HANDLING",DIFLD=48.1
 G RE
X12 S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>9999.99)!(X<1) X
 Q
 ;
13 D:$D(DG)>9 F^DIE17 G ^PRCST35
