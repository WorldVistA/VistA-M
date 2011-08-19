DGRPXIS1 ; ;06/26/96
 D DE G BEGIN
DE S DIE="^DGMT(408.21,",DIC=DIE,DP=408.21,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DGMT(408.21,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,14) S:%]"" DE(1)=% S %=$P(%Z,U,15) S:%]"" DE(4)=% S %=$P(%Z,U,16) S:%]"" DE(7)=% S %=$P(%Z,U,17) S:%]"" DE(10)=%
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
BEGIN S DNM="DGRPXIS1",DQ=1
1 S DW="0;14",DV="NJ9,2X",DU="",DLB="TOTAL INCOME FROM EMPLOYMENT",DIFLD=.14
 S DE(DW)="C1^DGRPXIS1"
 G RE
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 I $D(^DGMT(408.21,DA,0)),$P(^(0),U,14)="" D EMP^DGMTDD3
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 D EMP^DGMTDD3
 Q
X1 S:X["$" X=$P(X,"$",2) X:X["*" "S X=X*12 W ""  "",X" K:X'?.N.1".".2N!(X>9999999)!(X<0) X
 Q
 ;
2 S DQ=3 ;@908
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 S:DGDR'[908 Y="@909"
 Q
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="0;15",DV="NJ8,2X",DU="",DLB="INTEREST, DIVIDEND, OR ANNUITY",DIFLD=.15
 G RE
X4 S:X["$" X=$P(X,"$",2) X:X["*" "S X=X*12 W ""  "",X" K:X'?.N.1".".2N!(X>9999999)!(X<0) X
 Q
 ;
5 S DQ=6 ;@909
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S:DGDR'[909 Y="@910"
 Q
7 S DW="0;16",DV="NJ8,2X",DU="",DLB="WORKERS COMP. OR BLACK LUNG",DIFLD=.16
 G RE
X7 S:X["$" X=$P(X,"$",2) X:X["*" "S X=X*12 W ""  "",X" K:X'?.N.1".".2N!(X>9999999)!(X<0) X
 Q
 ;
8 S DQ=9 ;@910
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 S:DGDR'[910 Y="@998"
 Q
10 S DW="0;17",DV="NJ9,2X",DU="",DLB="ALL OTHER INCOME",DIFLD=.17
 G RE
X10 S:X["$" X=$P(X,"$",2) X:X["*" "S X=X*12 W ""  "",X" K:X'?.N.1".".2N!(X>9999999)!(X<0) X
 Q
 ;
11 S DQ=12 ;@998
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 S DGFIN=""
 Q
13 S DQ=14 ;@999
14 G 0^DIE17
