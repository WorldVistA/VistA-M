IBDXI51 ; ;05/01/97
 D DE G BEGIN
DE S DIE="^IBE(357.5,",DIC=DIE,DP=357.5,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^IBE(357.5,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,10) S:%]"" DE(2)=% S %=$P(%Z,U,11) S:%]"" DE(1)=% S %=$P(%Z,U,12) S:%]"" DE(3)=% S %=$P(%Z,U,13) S:%]"" DE(4)=% S %=$P(%Z,U,14) S:%]"" DE(5)=%
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
BEGIN S DNM="IBDXI51",DQ=1
1 S DW="0;11",DV="NJ3,0XOR",DU="",DLB="WHAT BLOCK ROW SHOULD THE TEXT START AT?",DIFLD=.11
 S DQ(1,2)="S Y(0)=Y S:Y=+Y Y=Y+1"
 G RE
X1 S:+X=X X=X-1 K:+X'=X!(X>200)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
2 S DW="0;10",DV="NJ3,0XOR",DU="",DLB="WHAT BLOCK COLUMN SHOULD THE TEXT START AT?",DIFLD=.1
 S DQ(2,2)="S:Y=+Y Y=Y+1"
 G RE
X2 S:+X=X X=X-1 K:+X'=X!(X>200)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
3 S DW="0;12",DV="NJ3,0R",DU="",DLB="HOW MANY LINES OF THE FORM SHOULD BE ALLOCATED FOR THE TEXT?",DIFLD=.12
 G RE
X3 K:+X'=X!(X>200)!(X<1)!(X?.E1"."1N.N) X
 Q
 ;
4 S DW="0;13",DV="SR",DU="",DLB="HOW SHOULD THE TEXT LINES BE SPACED?",DIFLD=.13
 S DU="1:SINGLE SPACED;2:DOUBLE SPACED;3:SINGLE, BUT DOUBLE IF BLANK;"
 G RE
X4 Q
5 S DW="0;14",DV="NJ3,0R",DU="",DLB="HOW MANY CHARACTERS ACROSS SHOULD THE TEXT LINES BE?",DIFLD=.14
 G RE
X5 K:+X'=X!(X>200)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S Y="@99"
 Q
7 S DQ=8 ;@5
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 D FULL^VALM1
 Q
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 D HELP3^IBDFU5
 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S (IBY,IBX)=1
 Q
11 S D=0 K DE(1) ;2
 S DIFLD=2,DGO="^IBDXI52",DC="8^357.52I^2^",DV="357.52MF",DW="0;1",DOW="SUBFIELD LABEL",DLB="Select "_DOW S:D DC=DC_D
 G RE:D I $D(DSC(357.52))#2,$P(DSC(357.52),"I $D(^UTILITY(",1)="" X DSC(357.52) S D=$O(^(0)) S:D="" D=-1 G M11
 S D=$S($D(^IBE(357.5,DA,2,0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M11 I D>0 S DC=DC_D I $D(^IBE(357.5,DA,2,+D,0)) S DE(11)=$P(^(0),U,1)
 G RE
R11 D DE
 S D=$S($D(^IBE(357.5,DA,2,0)):$P(^(0),U,3,4),1:1) G 11+1
 ;
12 S DQ=13 ;@99
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 S IBDELETE=0
 Q
14 G 0^DIE17
