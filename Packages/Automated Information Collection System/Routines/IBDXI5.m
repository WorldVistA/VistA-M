IBDXI5 ; GENERATED FROM 'IBDF EDIT DATA FIELD' INPUT TEMPLATE(#522), FILE 357.5;05/01/97
 D DE G BEGIN
DE S DIE="^IBE(357.5,",DIC=DIE,DP=357.5,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^IBE(357.5,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,1) S:%]"" DE(1)=% S %=$P(%Z,U,2) S:%]"" DE(3)=% S %=$P(%Z,U,3) S:%]"" DE(4)=% S %=$P(%Z,U,4) S:%]"" DE(10)=% S %=$P(%Z,U,5) S:%]"" DE(9)=% S %=$P(%Z,U,6) S:%]"" DE(13)=% S %=$P(%Z,U,7) S:%]"" DE(15)=%
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
BEGIN S DNM="IBDXI5",DQ=1
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIEZ=522,U="^"
1 S DW="0;1",DV="RF",DU="",DLB="NAME",DIFLD=.01
 S DE(DW)="C1^IBDXI5"
 G RE
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 K ^IBE(357.5,"B",$E(X,1,30),DA)
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^IBE(357.5,"B",$E(X,1,30),DA)=""
 Q
X1 K:$L(X)>30!($L(X)<3)!'(X'?1P.E) X
 I $D(X),X'?.ANP K X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 I IBOLD S Y="@1"
 Q
3 D:$D(DG)>9 F^DIE17,DE S DQ=3,DW="0;2",DV="RP357.1'",DU="",DLB="BLOCK",DIFLD=.02
 S DE(DW)="C3^IBDXI5"
 S DU="IBE(357.1,"
 S X=$G(IBBLK)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C3 G C3S:$D(DE(3))[0 K DB S X=DE(3),DIC=DIE
 K ^IBE(357.5,"C",$E(X,1,30),DA)
C3S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^IBE(357.5,"C",$E(X,1,30),DA)=""
 Q
X3 Q
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="0;3",DV="*P357.6'",DU="",DLB="TYPE OF DATA",DIFLD=.03
 S DU="IBE(357.6,"
 S X=$G(IBRTN)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X4 Q
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 D DATATYPE^IBDF9B(+$G(IBRTN))
 Q
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 D RESET^VALM4:VALMCC,REFRESH^VALM
 Q
7 S DQ=8 ;@1
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 I '$G(IBLIST) S Y="@2"
 Q
9 S DW="0;5",DV="NJ3,0R",DU="",DLB="WHICH ITEM ON THE LIST SHOULD BE DISPLAYED IN THIS FIELD?",DIFLD=.05
 G RE
X9 K:+X'=X!(X>999)!(X<1)!(X?.E1"."1N.N) X
 Q
 ;
10 S DW="0;4",DV="S",DU="",DLB="IS THIS THE LAST ONE THAT WILL FIT ON THE FORM?",DIFLD=.04
 S DU="1:YES;0:NO;"
 G RE
X10 Q
11 S DQ=12 ;@2
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 I '$G(IBWP) S Y="@5"
 Q
13 S DW="0;6",DV="F",DU="",DLB="WHAT LABEL SHOULD BEGIN THE TEXT (OPTIONAL)",DIFLD=.06
 G RE
X13 K:$L(X)>150!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 S:X="" Y="@4"
 Q
15 S DW="0;7",DV="FX",DU="",DLB="HOW SHOULD THE LABEL APPEAR? CHOOSE FROM {B,U,R}",DIFLD=.07
 G RE
X15 S X=$$UPPER^VALM1(X) K:$L(X)>3!("UBR"'[$E(X,1))!("UBR"'[$E(X,2))!("UBR"'[$E(X,3)) X
 I $D(X),X'?.ANP K X
 Q
 ;
16 S DQ=17 ;@4
17 D:$D(DG)>9 F^DIE17 G ^IBDXI51
