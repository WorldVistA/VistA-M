PRCST3 ; GENERATED FROM 'PRCSEN2237B' INPUT TEMPLATE(#607), FILE 410;10/11/96
 D DE G BEGIN
DE S DIE="^PRCS(410,",DIC=DIE,DP=410,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRCS(410,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,2) S:%]"" DE(2)=%
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,1) S:%]"" DE(7)=% S %=$P(%Z,U,3) S:%]"" DE(11)=% S %=$P(%Z,U,4) S:%]"" DE(9)=% S %=$P(%Z,U,5) S:%]"" DE(3)=%
 I $D(^(3)) S %Z=^(3) S %=$P(%Z,U,3) S:%]"" DE(14)=% S %=$P(%Z,U,5) S:%]"" DE(8)=%
 I $D(^(11)) S %Z=^(11) S %=$P(%Z,U,1) S:%]"" DE(5)=%
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
BEGIN S DNM="PRCST3",DQ=1
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIEZ=607,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 I $D(PRCSERR),PRCSERR S Y="@1"
 Q
2 S DW="0;2",DV="RS",DU="",DLB="TRANSACTION TYPE",DIFLD=1
 S DU="C:CEILING;O:OBLIGATION;A:ADJUSTMENT;CA:CANCELLED;"
 S Y="O"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X2 Q
3 S DW="1;5",DV="*P410.2",DU="",DLB="CLASSIFICATION OF REQUEST",DIFLD=8
 S DU="PRCS(410.2,"
 G RE
X3 S DIC("S")="I $D(PRC(""CP"")),$D(^PRCS(410.2,+Y,0)),+$P(^(0),U,2)=+PRC(""CP"")" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 G A
5 S DW="11;1",DV="VX",DU="",DLB="SORT GROUP",DIFLD=49
 S DE(DW)="C5^PRCST3"
 G RE
C5 G C5S:$D(DE(5))[0 K DB S X=DE(5),DIC=DIE
 K ^PRCS(410,"J",$E(X,1,30),DA)
 S X=DE(5),DIC=DIE
 ;
C5S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRCS(410,"J",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 I '$D(DIU(0)),$E($P(X,";",2),1,9)="ENG(6920,",$G(^ENG("VERSION"))>6.4 D ACCX^ENLIB2
 Q
X5 I $D(X),X["ENG(",$D(^ENG("WO",+X,0)) S $P(^ENG("WO",+X,4),U,2)=DA I $D(^ENG("VERSION")),^ENG("VERSION")>6.4 D ACCX^ENLIB2
 Q
 ;
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 G A
7 D:$D(DG)>9 F^DIE17,DE S DQ=7,DW="1;1",DV="D",DU="",DLB="DATE OF REQUEST",DIFLD=5
 S Y="TODAY"
 G Y
X7 S %DT="EX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
8 S DW="3;5",DV="P49'",DU="",DLB="REQUESTING SERVICE",DIFLD=6.3
 S DU="DIC(49,"
 G RE
X8 Q
9 S DW="1;4",DV="RD",DU="",DLB="DATE REQUIRED",DIFLD=7
 G RE
X9 S %DT="EX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S PRCSTDT=X
 Q
11 S DW="1;3",DV="S",DU="",DLB="PRIORITY OF REQUEST",DIFLD=7.5
 S DU="EM:EMERGENCY;SP:SPECIAL;ST:STANDARD;"
 S Y="ST"
 G Y
X11 Q
12 S D=0 K DE(1) ;9
 S Y="SPECIAL REMARKS^W^^0;1^Q",DG="RM",DC="^410.01" D DIEN^DIWE K DE(1) G A
 ;
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),$P(^(0),"^",12)=2 S $P(^PRCS(410,DA,3),U,3)="600000 Supply Fund (sum",Y="@0"
 Q
14 S DW="3;3",DV="RFX",DU="",DLB="COST CENTER",DIFLD=15.5
 S DE(DW)="C14^PRCST3"
 G RE
C14 G C14S:$D(DE(14))[0 K DB S X=DE(14),DIC=DIE
 K ^PRCS(410,"AC",$E(X,1,30),DA)
C14S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRCS(410,"AC",$E(X,1,30),DA)=""
 Q
X14 D CC^PRCSES
 I $D(X),X'?.ANP K X
 Q
 ;
15 S DQ=16 ;@0
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 I $D(^PRCS(410,T1,3)),$P(^(3),U,4)]"" S $P(^PRCS(410,DA,3),U,4)=$P(^PRCS(410,T1,3),U,4)
 Q
17 D:$D(DG)>9 F^DIE17 G ^PRCST31
