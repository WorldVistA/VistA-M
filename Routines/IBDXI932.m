IBDXI932 ; ;05/01/97
 D DE G BEGIN
DE S DIE="^IBE(357.93,D0,1,",DIC=DIE,DP=357.931,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^IBE(357.93,D0,1,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,2) S:%]"" DE(13)=% S %=$P(%Z,U,3) S:%]"" DE(15)=% S %=$P(%Z,U,4) S:%]"" DE(12)=% S %=$P(%Z,U,5) S:%]"" DE(9)=% S %=$P(%Z,U,8) S:%]"" DE(1)=% S %=$P(%Z,U,9) S:%]"" DE(4)=%,DE(7)=%
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
BEGIN S DNM="IBDXI932",DQ=1
1 S DW="0;8",DV="RFXO",DU="",DLB="ID",DIFLD=.08
 S DQ(1,2)="S Y(0)=Y S Y=Y"
 S X=$G(IBID)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X1 Q
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S DIE("NO^")="BACK"
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 I '$D(IBQUAL) S Y="@4"
 Q
4 S DW="0;9",DV="*P357.98'",DU="",DLB="DATA QUALIFIER",DIFLD=.09
 S DU="IBD(357.98,"
 S X=IBQUAL
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X4 S DIC("S")="I $$DQGOOD^IBDFU9($P($G(^IBE(357.93,DA(1),0)),""^"",6),Y)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 S Y="@5"
 Q
6 S DQ=7 ;@4
7 S DW="0;9",DV="*P357.98'",DU="",DLB="DATA QUALIFIER",DIFLD=.09
 S DU="IBD(357.98,"
 G RE
X7 S DIC("S")="I $$DQGOOD^IBDFU9($P($G(^IBE(357.93,DA(1),0)),""^"",6),Y)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
8 S DQ=9 ;@5
9 S DW="0;5",DV="RF",DU="",DLB="CHOICE LABEL",DIFLD=.05
 S X=$G(IBLABEL)
 S Y=X
 G Y
X9 K:$L(X)>120!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S IBLEN=$L(X)
 Q
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 D RESET^VALM4:VALMCC,REFRESH^VALM
 Q
12 S DW="0;4",DV="FX",DU="",DLB="HOW SHOULD THE LABEL APPEAR? CHOOSE FROM {U,B,R}",DIFLD=.04
 G RE
X12 S X=$$UPPER^VALM1(X) K:$L(X)>3!("UBR"'[$E(X,1))!("UBR"'[$E(X,2))!("UBR"'[$E(X,3)) X
 I $D(X),X'?.ANP K X
 Q
 ;
13 S DW="0;2",DV="RNJ3,0XO",DU="",DLB="STARTING COLUMN FOR LABEL",DIFLD=.02
 S DQ(13,2)="S Y(0)=Y S Y=+Y+1"
 S X=IBX+1
 S Y=X
 G Y
X13 S:+X=X X=X-1 K:+X'=X!(X>200)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 S IBX=X+IBLEN+2 I (X<$$MINX^IBDFU1B)!((IBX-3)>$$MAXX^IBDFU1B) D WARNING^IBDFU1B("input field")
 Q
15 S DW="0;3",DV="RNJ3,0XO",DU="",DLB="STARTING ROW FOR LABEL",DIFLD=.03
 S DQ(15,2)="S Y(0)=Y S Y=+Y+1"
 S X=IBY+1
 S Y=X
 G Y
X15 S:+X=X X=X-1 K:+X'=X!(X>200)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 S IBY=X+1 I (X<$$MINY^IBDFU1B)!(X>$$MAXY^IBDFU1B) D WARNING^IBDFU1B("input field")
 Q
17 D:$D(DG)>9 F^DIE17 G ^IBDXI933
