PRCHT312 ; ;10/06/97
 D DE G BEGIN
DE S DIE="^PRC(442,D0,2,",DIC=DIE,DP=442.01,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^PRC(442,D0,2,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,6) S:%]"" DE(1)=% S %=$P(%Z,U,15) S:%]"" DE(8)=%
 I $D(^(2)) S %Z=^(2) S %=$P(%Z,U,2) S:%]"" DE(14)=% S %=$P(%Z,U,3) S:%]"" DE(4)=%
 I $D(^(4)) S %Z=^(4) S %=$P(%Z,U,11) S:%]"" DE(9)=% S %=$P(%Z,U,12) S:%]"" DE(11)=% S %=$P(%Z,U,13) S:%]"" DE(12)=%
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
BEGIN S DNM="PRCHT312",DQ=1
1 S DW="0;6",DV="FX",DU="",DLB="VENDOR STOCK NUMBER",DIFLD=9
 G RE
X1 K:$L(X)>30!($L(X)<1) X I $D(X) D EN12^PRCHNPO5
 I $D(X),X'?.ANP K X
 Q
 ;
2 S DQ=3 ;@7
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 I PRCHN("SC")'=9 S Y="@3"
 Q
4 S DW="2;3",DV="RP441.2'X",DU="",DLB="FEDERAL SUPPLY CLASSIFICATION",DIFLD=8
 S DU="PRC(441.2,"
 G RE
X4 D EN10^PRCHNPO7
 Q
 ;
5 S DQ=6 ;@3
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S PRCHN("COM")="" I $D(^PRC(442,DA(1),2,DA,2)),$D(^PRC(441.2,+$P(^(2),U,3),0)) S PRCHN("COM")=$P(^(0),U,4),PRCHSTN=$P(PRCHPONO,"-"),PRCHFCP=+$P(^PRC(442,DA(1),0),U,3)
 Q
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 S:$E($P($G(^PRC(420,PRCHSTN,1,PRCHFCP,0)),U,18),1,2)=11 Y=41 S:($E($P($G(^(0)),U,18),1,2)'=11)&(PRCHN("SC")=9) Y="@4" S:(((PRCHN("COM")'=1)&($E($P($G(^(0)),U,18),1,2)'=11))&(PRCHN("SC")'=9)) Y=4
 Q
8 S DW="0;15",DV="FX",DU="",DLB="NATIONAL DRUG CODE",DIFLD=9.3
 G RE
X8 K:$L(X)>14!($L(X)<11)!'(X?1.6N1"-"1.4N1"-"1.2N) X I $D(X) D EN12^PRCHNPO7
 I $D(X),X'?.ANP K X
 Q
 ;
9 S DW="4;11",DV="RS",DU="",DLB="DRUG TYPE CODE",DIFLD=40
 S DU="A:NARCOTIC;L:CONTROLLED SUBSTANCE;D:OTHER DRUGS;"
 S X="D"
 S Y=X
 G Y
X9 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S Y=$S(PRCHN("SC")'=9:4,1:"@4")
 Q
11 S DW="4;12",DV="RS",DU="",DLB="FOOD GROUP",DIFLD=41
 S DU="1:Meat, Fish, Poultry, Eggs & Convenience Entrees;2:Milk, Milk Products;3:Fruits, Vegetables;4:Bread, Flour, Cereal, etc.;5:Commercial Nutritional Products, Tube feedings & supplements;6:Miscellaneous, Foods;"
 S Z=$S($D(^PRC(441,+$P(^PRC(442,DA(1),2,DA,0),U,5),3)):^(3),1:""),X=$P(Z,U,7) K Z
 S Y=X
 G Y
X11 Q
12 S DW="4;13",DV="F",DU="",DLB="DIETETIC CONVERSION FACTOR",DIFLD=42
 G RE
X12 K:$L(X)>5!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 S Y=$S(PRCHN("SC")'=9:4,1:"@4")
 Q
14 S DW="2;2",DV="FX",DU="",DLB="CONTRACT/BOA #",DIFLD=4
 S DE(DW)="C14^PRCHT312"
 G RE
C14 G C14S:$D(DE(14))[0 K DB S X=DE(14),DIC=DIE
 K ^PRC(442,DA(1),2,"AC",$E(X,1,30),DA)
C14S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRC(442,DA(1),2,"AC",$E(X,1,30),DA)=""
 Q
X14 D EN8^PRCHNPO5
 I $D(X),X'?.ANP K X
 Q
 ;
15 S DQ=16 ;@4
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 S Y=$S((PRCHN("SC")=0)!(PRCHN("SC")=3):30,PRCHN("SC")=1:35,1:"@5")
 Q
17 D:$D(DG)>9 F^DIE17 G ^PRCHT313
