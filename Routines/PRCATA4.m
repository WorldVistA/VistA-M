PRCATA4 ; ;05/28/97
 D DE G BEGIN
DE S DIE="^PRCA(430,",DIC=DIE,DP=430,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRCA(430,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,8) S:%]"" DE(10)=% S %=$P(%Z,U,10) S:%]"" DE(7)=%
 I $D(^(6)) S %Z=^(6) S %=$P(%Z,U,1) S:%]"" DE(4)=% S %=$P(%Z,U,2) S:%]"" DE(5)=% S %=$P(%Z,U,3) S:%]"" DE(6)=% S %=$P(%Z,U,7) S:%]"" DE(2)=%
 I $D(^(7)) S %Z=^(7) S %=$P(%Z,U,3) S:%]"" DE(1)=%
 I $D(^(100)) S %Z=^(100) S %=$P(%Z,U,2) S:%]"" DE(8)=%
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
BEGIN S DNM="PRCATA4",DQ=1
1 S DW="7;3",DV="NJ8,2",DU="",DLB="ADMINISTRATIVE COST BALANCE",DIFLD=73
 G RE
X1 S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>99999.99)!(X<0) X
 Q
 ;
2 S DW="6;7",DV="D",DU="",DLB="LAST INT/ADM CHARGE DATE",DIFLD=67
 G RE
X2 S %DT="E" D ^%DT S X=Y K:Y<1 X
 Q
 ;
3 S DQ=4 ;@7
4 S DW="6;1",DV="D",DU="",DLB="LETTER1",DIFLD=61
 G RE
X4 S %DT="ET" D ^%DT S X=Y K:Y<1 X
 Q
 ;
5 S DW="6;2",DV="D",DU="",DLB="LETTER2",DIFLD=62
 G RE
X5 S %DT="ET" D ^%DT S X=Y K:Y<1 X
 Q
 ;
6 S DW="6;3",DV="D",DU="",DLB="LETTER3",DIFLD=63
 G RE
X6 S %DT="ET" D ^%DT S X=Y K:Y<1 X
 Q
 ;
7 S DW="0;10",DV="RDX",DU="",DLB="DATE BILL PREPARED",DIFLD=10
 G RE
X7 S %DT="E" D ^%DT S X=Y K:Y<1!(X>DT) X
 Q
 ;
8 S DW="100;2",DV="RP49'",DU="",DLB="SERVICE",DIFLD=101
 S DU="DIC(49,"
 G RE
X8 Q
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 S PRCAOLD=""
 Q
10 S DW="0;8",DV="R*P430.3'X",DU="",DLB="CURRENT STATUS",DIFLD=8
 S DE(DW)="C10^PRCATA4"
 S DU="PRCA(430.3,"
 G RE
C10 G C10S:$D(DE(10))[0 K DB S X=DE(10),DIC=DIE
 K ^PRCA(430,"AC",$E(X,1,30),DA)
 S X=DE(10),DIC=DIE
 I $P(^PRCA(430,DA,0),"^",9) K ^PRCA(430,"AS",$P(^PRCA(430,DA,0),"^",9),X,DA)
 S X=DE(10),DIC=DIE
 ;
 S X=DE(10),DIC=DIE
 ;
 S X=DE(10),DIC=DIE
 I $P(^PRCA(430,DA,0),U,14) K ^PRCA(430,"ASDT",X,$P($P(^PRCA(430,DA,0),U,14),"."),DA)
C10S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRCA(430,"AC",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 I $P(^PRCA(430,DA,0),"^",9) S ^PRCA(430,"AS",$P(^PRCA(430,DA,0),"^",9),X,DA)=""
 S X=DG(DQ),DIC=DIE
 X ^DD(430,8,1,3,1.3) I X S X=DIV S Y(1)=$S($D(^PRCA(430,D0,6)):^(6),1:"") S X=$P(Y(1),U,21),X=X S DIU=X K Y S X=DIV D NOW^%DTC S X=% X ^DD(430,8,1,3,1.4)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^PRCA(430,D0,0)):^(0),1:"") S X=$P(Y(1),U,14),X=X S DIU=X K Y S X=DIV S X=DT X ^DD(430,8,1,4,1.4)
 S X=DG(DQ),DIC=DIE
 I $P(^PRCA(430,DA,0),U,14) S ^PRCA(430,"ASDT",X,$P($P(^PRCA(430,DA,0),U,14),"."),DA)=""
 Q
X10 D CKSTAT^PRCAUT3
 Q
 ;
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 S $P(^PRCA(430,D0,0),U,12)=$S($D(PRCA("SITE")):PRCA("SITE"),1:"")
 Q
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 K PRCAOLD
 Q
13 G 0^DIE17
