APSPT051 ; ;07/16/96
 D DE G BEGIN
DE S DIE="^APSPQA(32.4,",DIC=DIE,DP=9009032.4,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^APSPQA(32.4,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,11) S:%]"" DE(1)=% S %=$P(%Z,U,12) S:%]"" DE(3)=% S %=$P(%Z,U,13) S:%]"" DE(5)=%
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
BEGIN S DNM="APSPT051",DQ=1
1 S DW="0;11",DV="*P200'",DU="",DLB="PROVIDER CONTACTED",DIFLD=.11
 S DU="VA(200,"
 G RE
X1 S DIC("S")="S X(1)=$G(^(""PS"")) I +X(1),$S('$P(X(1),""^"",4):1,1:$P(X(1),""^"",4)'<DT)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
2 S DQ=3 ;@3
3 S DW="0;12",DV="S",DU="",DLB="RECOMMENDATION ACCEPTED",DIFLD=.12
 S DU="0:NO;1:YES;"
 G RE
X3 Q
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 I X=1 S Y="@4"
 Q
5 S DW="0;13",DV="S",DU="",DLB="AGREE WITH PROVIDER",DIFLD=.13
 S DU="0:YES;1:NO;"
 G RE
X5 Q
6 S DQ=7 ;@4
7 S D=0 K DE(1) ;1300
 S Y="REASON FOR INTERVENTION^WL^^0;1^Q",DG="13",DC="^9009032.413" D DIEN^DIWE K DE(1) G A
 ;
8 S D=0 K DE(1) ;1400
 S Y="ACTION TAKEN^WL^^0;1^Q",DG="14",DC="^9009032.414" D DIEN^DIWE K DE(1) G A
 ;
9 S D=0 K DE(1) ;1500
 S Y="CLINICAL IMPACT^WL^^0;1^Q",DG="15",DC="^9009032.415" D DIEN^DIWE K DE(1) G A
 ;
10 S D=0 K DE(1) ;1600
 S Y="FINANCIAL IMPACT^WL^^0;1^Q",DG="16",DC="^9009032.416" D DIEN^DIWE K DE(1) G A
 ;
11 G 0^DIE17
