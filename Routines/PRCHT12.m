PRCHT12 ; ;10/06/97
 D DE G BEGIN
DE S DIE="^PRC(442,",DIC=DIE,DP=442,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRC(442,DA,""))=""
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,1) S:%]"" DE(1)=% S %=$P(%Z,U,7) S:%]"" DE(15)=% S %=$P(%Z,U,19) S:%]"" DE(17)=%
 I $D(^(12)) S %Z=^(12) S %=$P(%Z,U,13) S:%]"" DE(12)=% S %=$P(%Z,U,14) S:%]"" DE(14)=%
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
BEGIN S DNM="PRCHT12",DQ=1
1 S DW="1;1",DV="R*P440X",DU="",DLB="VENDOR",DIFLD=5
 S DE(DW)="C1^PRCHT12"
 S DU="PRC(440,"
 G RE
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 K ^PRC(442,"D",$E(X,1,30),DA)
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRC(442,"D",$E(X,1,30),DA)=""
 Q
X1 D EN3^PRCHNPO5
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 I $P(PRCHNVF,"^",3)=1 S Y="@20"
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 S PRCHOV3=$G(^PRC(440,+^PRC(442,D0,1),3)) S:$P(PRCHOV3,"^",12)="P" Y="@20"
 Q
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 G A
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 S:$P(PRCHOV3,"^",6)="N" Y="@20"
 Q
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S FLAG=0 I $P(PRCHOV3,"^",4)]""!(($P(PRCHOV3,"^",9)]"")&($P(PRCHOV3,"^",8)]"")) S FLAG=1
 Q
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 D EN9^PRCHNPO7
 Q
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 S I(0,0)=D0 S Y(1)=$S($D(^PRC(442,D0,1)):^(1),1:"") S X=$P(Y(1),U,1),X=X S D(0)=+X S X=$S(D(0)>0:D(0),1:"")
 S DGO="^PRCHT13",DC="^440^PRC(440," G DIEZ^DIE0
R8 D DE G A
 ;
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 G A
10 S DQ=11 ;@20
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 I '$D(PRCHEDI) S:$D(^PRC(442,DA,12)) $P(^(12),U,13,14)="^" S Y=8
 Q
12 D:$D(DG)>9 F^DIE17,DE S DQ=12,DW="12;13",DV="S",DU="",DLB="NEED SPECIAL HANDLING?",DIFLD=18.6
 S DU="Y:YES;N:NO;"
 S X="N"
 S Y=X
 G Y
X12 Q
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 I X'="Y" S:$D(^PRC(442,DA,12)) $P(^(12),U,14)="" S Y=8
 Q
14 S DW="12;14",DV="P443.4'",DU="",DLB="TYPE OF SPECIAL HANDLING",DIFLD=18.7
 S DU="PRC(443.4,"
 G RE
X14 Q
15 S DW="1;7",DV="R*P420.8'",DU="",DLB="SOURCE CODE",DIFLD=8
 S DU="PRCD(420.8,"
 S X=PRCHN("SC")
 S Y=X
 G Y
X15 S DIC("S")="I "_$S($D(PRCHPUSH):"""13""[$E(^(0))",$D(PRCHNRQ):"""1390""[$E(^(0))",1:"""2456789B""[$E(^(0))") D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 I "2B"'[X K DIC("DR") D ^PRCHNPO3
 Q
17 S DW="1;19",DV="RP443.8'",DU="",DLB="LOCAL PROCUREMENT REASON CODE",DIFLD=.25
 S DE(DW)="C17^PRCHT12"
 S DU="PRC(443.8,"
 G RE
C17 G C17S:$D(DE(17))[0 K DB S X=DE(17),DIC=DIE
 ;
C17S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^PRC(442,D0,1)):^(1),1:"") S X=$P(Y(1),U,17),X=X S DIU=X K Y X ^DD(442,.25,1,1,1.1) X ^DD(442,.25,1,1,1.4)
 Q
X17 Q
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 K DIC("DR")
 Q
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 D X19 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X19 D ^PRCHNPO3
 Q
20 S DQ=21 ;@1
21 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=21 D X21 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X21 I $D(^PRCS(410,+$P(^PRC(442,DA,0),"^",12),0)) S X=$P($P(^(0),U,1),"-",4) I +X=+$P(^PRC(442,DA,0),U,3) W !,"FCP: ",$P(^(0),U,3) S Y="@2"
 Q
22 D:$D(DG)>9 F^DIE17 G ^PRCHT14
