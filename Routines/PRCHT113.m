PRCHT113 ; ;10/06/97
 D DE G BEGIN
DE S DIE="^PRC(442,D0,2,",DIC=DIE,DP=442.01,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^PRC(442,D0,2,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,15) S:%]"" DE(3)=%
 I $D(^(2)) S %Z=^(2) S %=$P(%Z,U,2) S:%]"" DE(8)=% S %=$P(%Z,U,3) S:%]"" DE(1)=%
 I $D(^(4)) S %Z=^(4) S %=$P(%Z,U,11) S:%]"" DE(4)=% S %=$P(%Z,U,12) S:%]"" DE(6)=% S %=$P(%Z,U,13) S:%]"" DE(7)=%
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
BEGIN S DNM="PRCHT113",DQ=1
1 S DW="2;3",DV="RP441.2'X",DU="",DLB="FEDERAL SUPPLY CLASSIFICATION",DIFLD=8
 S DU="PRC(441.2,"
 G RE
X1 D EN10^PRCHNPO7
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S PRCHFCP=+$P(^PRC(442,DA(1),0),U,3),PRCHN("COM")=$S($D(^PRC(441.2,+X,0)):$P(^(0),U,4),1:"") S:$E($P($G(^PRC(420,PRCHSTN,1,PRCHFCP,0)),U,18),1,2)=11 Y=41 S:(PRCHN("COM")'=1)&($E($P($G(^(0)),U,18),1,2)'=11) Y=4
 Q
3 S DW="0;15",DV="FX",DU="",DLB="NATIONAL DRUG CODE",DIFLD=9.3
 G RE
X3 K:$L(X)>14!($L(X)<11)!'(X?1.6N1"-"1.4N1"-"1.2N) X I $D(X) D EN12^PRCHNPO7
 I $D(X),X'?.ANP K X
 Q
 ;
4 S DW="4;11",DV="RS",DU="",DLB="DRUG TYPE CODE",DIFLD=40
 S DU="A:NARCOTIC;L:CONTROLLED SUBSTANCE;D:OTHER DRUGS;"
 S X="D"
 S Y=X
 G Y
X4 Q
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 S Y=4
 Q
6 S DW="4;12",DV="RS",DU="",DLB="FOOD GROUP",DIFLD=41
 S DU="1:Meat, Fish, Poultry, Eggs & Convenience Entrees;2:Milk, Milk Products;3:Fruits, Vegetables;4:Bread, Flour, Cereal, etc.;5:Commercial Nutritional Products, Tube feedings & supplements;6:Miscellaneous, Foods;"
 S Z=$S($D(^PRC(441,+$P(^PRC(442,DA(1),2,DA,0),U,5),3)):^(3),1:""),X=$P(Z,U,7)
 S Y=X
 G Y
X6 Q
7 S DW="4;13",DV="F",DU="",DLB="DIETETIC CONVERSION FACTOR",DIFLD=42
 G RE
X7 K:$L(X)>5!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
8 S DW="2;2",DV="FX",DU="",DLB="CONTRACT/BOA #",DIFLD=4
 S DE(DW)="C8^PRCHT113"
 G RE
C8 G C8S:$D(DE(8))[0 K DB S X=DE(8),DIC=DIE
 K ^PRC(442,DA(1),2,"AC",$E(X,1,30),DA)
C8S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRC(442,DA(1),2,"AC",$E(X,1,30),DA)=""
 Q
X8 D EN8^PRCHNPO5
 I $D(X),X'?.ANP K X
 Q
 ;
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 S PRCHIDA=+$P(^PRC(442,DA(1),2,DA,0),U,5)
 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 I PRCHN("SFC")=2 S ACCT=$$ACCT^PRCPUX1($E($$NSN^PRCPUX1(PRCHIDA),1,4)) S PRCHBOCC=$S(ACCT=1:2697,ACCT=2:2698,ACCT=3:2699,ACCT=6:2699,ACCT=8:2696,1:2699)
 Q
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 I '$G(PRCHBOCC) S Y="@87"
 Q
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 G A
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 S PRCHBOCC=$P($G(^PRCD(420.2,PRCHBOCC,0)),U)
 Q
14 D:$D(DG)>9 F^DIE17 G ^PRCHT114
