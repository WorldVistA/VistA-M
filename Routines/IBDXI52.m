IBDXI52 ; ;05/01/97
 D DE G BEGIN
DE S DIE="^IBE(357.5,D0,2,",DIC=DIE,DP=357.52,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^IBE(357.5,D0,2,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,1) S:%]"" DE(1)=% S %=$P(%Z,U,3) S:%]"" DE(4)=% S %=$P(%Z,U,4) S:%]"" DE(8)=% S %=$P(%Z,U,5) S:%]"" DE(6)=% S %=$P(%Z,U,9) S:%]"" DE(12)=%,DE(17)=%
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
BEGIN S DNM="IBDXI52",DQ=1+D G B
1 S DW="0;1",DV="MF",DU="",DLB="SUBFIELD LABEL",DIFLD=.01
 S DE(DW)="C1^IBDXI52"
 G RE:'D S DQ=2 G 2
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 K ^IBE(357.5,DA(1),2,"B",$E(X,1,30),DA)
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^IBE(357.5,DA(1),2,"B",$E(X,1,30),DA)=""
 Q
X1 K:$L(X)>150!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S:X="" Y="@99" S IBW=$L(X)
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 D RESET^VALM4:VALMCC,REFRESH^VALM
 Q
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="0;3",DV="FX",DU="",DLB="HOW SHOULD THE LABEL APPEAR? CHOOSE FROM {U,B,R,I}",DIFLD=.03
 G RE
X4 S X=$$UPPER^VALM1(X) K:$L(X)>4!("UBRI"'[$E(X,1))!("UBRI"'[$E(X,2))!("UBRI"'[$E(X,3))!("UBRI"'[$E(X,4)) X
 I $D(X),X'?.ANP K X
 Q
 ;
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 I X["I" S Y="@7",IBW=0
 Q
6 S DW="0;5",DV="NJ3,0XO",DU="",DLB="STARTING ROW FOR LABEL",DIFLD=.05
 S DQ(6,2)="S Y(0)=Y S:Y=+Y Y=Y+1"
 S X=+IBY
 S Y=X
 G Y
X6 S:+X=X X=X-1 K:+X'=X!(X>200)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 S IBY=X+1
 Q
8 S DW="0;4",DV="NJ3,0XO",DU="",DLB="STARTING COLUMN FOR LABEL",DIFLD=.04
 S DQ(8,2)="S Y(0)=Y S:Y=+Y Y=Y+1"
 S X=+IBX
 S Y=X
 G Y
X8 S:+X=X X=X-1 K:+X'=X!(X>200)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 S IBX=X+2+IBW
 Q
10 S DQ=11 ;@7
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 I $G(IBMF) S Y="@8"
 Q
12 S DW="0;9",DV="NJ1,0X",DU="",DLB="DATA",DIFLD=.09
 S X=1
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X12 Q
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 S IBP=1
 Q
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 S Y="@9"
 Q
15 S DQ=16 ;@8
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 D HELP1^IBDFU5
 Q
17 S DW="0;9",DV="NJ1,0X",DU="",DLB="Select Subfield's Data",DIFLD=.09
 G RE
X17 K:'$$OKPIECE^IBDFU5(+$P($G(^IBE(357.5,D0,0)),U,3),X) X
 Q
 ;
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 I 'X S Y="@10"
 Q
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 D X19 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X19 S IBP=X
 Q
20 S DQ=21 ;@9
21 D:$D(DG)>9 F^DIE17 G ^IBDXI53
