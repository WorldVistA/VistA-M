PRCHT35 ; ;10/06/97
 D DE G BEGIN
DE S DIE="^PRC(442,",DIC=DIE,DP=442,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRC(442,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,3) S:%]"" DE(6)=% S %=$P(%Z,U,5) S:%]"" DE(13)=%
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,7) S:%]"" DE(1)=%
 I $D(^(23)) S %Z=^(23) S %=$P(%Z,U,2) S:%]"" DE(11)=%
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
BEGIN S DNM="PRCHT35",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW="1;7",DV="R*P420.8'",DU="",DLB="SOURCE CODE",DIFLD=8
 S DU="PRCD(420.8,"
 S X=PRCHN("SC")
 S Y=X
 G Y
X1 S DIC("S")="I "_$S($D(PRCHPUSH):"""13""[$E(^(0))",$D(PRCHNRQ):"""1390""[$E(^(0))",1:"""2456789B""[$E(^(0))") D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S PRCHN("SC")=$S($D(^PRCD(420.8,+X,0)):$P(^(0),U,1),1:"") K DIC("DR")
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 D ^PRCHNPO3
 Q
4 S DQ=5 ;@1
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 I $D(^PRCS(410,+$P(^PRC(442,DA,0),"^",12),0)) S X=$P($P(^(0),U,1),"-",4) I +X=+$P(^PRC(442,DA,0),U,3) W !,"FCP: ",$P(^(0),U,3) S Y="@2"
 Q
6 S DW="0;3",DV="RFX",DU="",DLB="FCP",DIFLD=1
 S DE(DW)="C6^PRCHT35"
 G RE
C6 G C6S:$D(DE(6))[0 K DB S X=DE(6),DIC=DIE
 K ^PRC(442,"E",$P(X," ",1),DA)
 S X=DE(6),DIC=DIE
 S $P(^PRC(442,DA,0),U,19)="",$P(^(17),U,1)=""
C6S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRC(442,"E",$P(X," ",1),DA)=""
 S X=DG(DQ),DIC=DIE
 I $D(^PRC(420,+^PRC(442,DA,0),1,+X,0)) S Z=^(0) S:$P(Z,U,12) $P(^PRC(442,DA,0),U,19)=$P(Z,U,12) S:$P(Z,U,18) $P(^PRC(442,DA,17),U,1)=$E($P(Z,U,18),1,3) K Z
 Q
X6 K:X[""""!($A(X)=45) X I $D(X) K:'$D(PRC("SITE"))!('$D(^PRC(442,DA,1))) X Q:'$D(X)  S:$P(^(1),U,15)]"" PRC("FY")=$P(^(1),U,15) D EN1^PRCHNPO5 Q:'$D(X)  S $P(^PRC(442,DA,0),U,4)=PRC("APP")
 I $D(X),X'?.ANP K X
 Q
 ;
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 G A
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 S PRCHN("SFC")=$P(^PRC(442,DA,0),U,19)
 Q
9 S DQ=10 ;@2
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 I $G(PRC("BBFY"))="" S PRC("BBFY")=$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),$P(^PRC(442,DA,0),U,3))
 Q
11 D:$D(DG)>9 F^DIE17,DE S DQ=11,DW="23;2",DV="D",DU="",DLB="BBFY",DIFLD=26
 S X=PRC("BBFY")
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X11 S %DT="" D ^%DT S X=Y K:Y<1 X
 Q
 ;
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 D EN2^PRCHNPO3
 Q
13 S DW="0;5",DV="RFX",DU="",DLB="COST CENTER",DIFLD=2
 S X=PRCHN("CC")
 S Y=X
 G Y
X13 S Z0=+$P(^PRC(442,DA,0),"^",3) K:'$D(PRC("SITE"))!'Z0 X,Z0 I $D(X) K:'$D(^PRC(420,PRC("SITE"),1,Z0,2,0)) X I $D(X) D EN2^PRCHNPO5
 I $D(X),X'?.ANP K X
 Q
 ;
14 D:$D(DG)>9 F^DIE17 G ^PRCHT36
