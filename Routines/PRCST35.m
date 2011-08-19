PRCST35 ; ;10/11/96
 D DE G BEGIN
DE S DIE="^PRCS(410,",DIC=DIE,DP=410,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRCS(410,DA,""))=""
 I $D(^(7)) S %Z=^(7) S %=$P(%Z,U,1) S:%]"" DE(3)=% S %=$P(%Z,U,3) S:%]"" DE(5)=% S %=$P(%Z,U,5) S:%]"" DE(7)=%
 I $D(^(9)) S %Z=^(9) S %=$P(%Z,U,1) S:%]"" DE(1)=%
 I $D(^(14)) S %Z=^(14) S %=$P(%Z,U,1) S:%]"" DE(8)=%
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
BEGIN S DNM="PRCST35",DQ=1
1 S DW="9;1",DV="FX",DU="",DLB="DELIVER TO/LOCATION",DIFLD=46
 G RE
X1 K:$L(X)>30!($L(X)<3)!(X'?.ANP) X
 I $D(X),X'?.ANP K X
 Q
 ;
2 S D=0 K DE(1) ;45
 S Y="JUSTIFICATION^W^^0;1^Q",DG="8",DC="^410.06" D DIEN^DIWE K DE(1) G A
 ;
3 S DW="7;1",DV="P200'X",DU="",DLB="REQUESTOR",DIFLD=40
 S DE(DW)="C3^PRCST35"
 S DU="VA(200,"
 G RE
C3 G C3S:$D(DE(3))[0 K DB S X=DE(3),DIC=DIE
 S $P(^PRCS(410,DA,7),"^",2)=""
C3S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 I $D(^VA(200,X,20)),$P(^(20),"^",3)'="" S $P(^PRCS(410,DA,7),"^",2)=$P(^VA(200,X,20),"^",3)
 Q
X3 I $D(^PRC(411,PRC("SITE"),8,X)) K X Q
 Q
 ;
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),$P(^(0),"^",11)="Y" S Y=68
 Q
5 D:$D(DG)>9 F^DIE17,DE S DQ=5,DW="7;3",DV="P200'",DU="",DLB="APPROVING OFFICIAL",DIFLD=42
 S DE(DW)="C5^PRCST35"
 S DU="VA(200,"
 G RE
C5 G C5S:$D(DE(5))[0 K DB S X=DE(5),DIC=DIE
 S $P(^PRCS(410,DA,7),"^",4)=""
C5S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 I $D(^VA(200,X,20)),$P(^(20),"^",3)'="" S $P(^PRCS(410,DA,7),"^",4)=$P(^VA(200,X,20),"^",3)
 Q
X5 Q
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 G A
7 D:$D(DG)>9 F^DIE17,DE S DQ=7,DW="7;5",DV="D",DU="",DLB="DATE SIGNED (APPROVED)",DIFLD=44
 S Y="TODAY"
 G Y
X7 S %DT="EX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
8 S DW="14;1",DV="P200'",DU="",DLB="ORIGINATOR OF REQUEST",DIFLD=68
 S DU="VA(200,"
 G RE
X8 Q
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 K PRCSJP,PRCSTDT
 Q
10 S D=0 K DE(1) ;60
 S Y="COMMENTS^W^^0;1^Q",DG="CO",DC="^410.05" D DIEN^DIWE K DE(1) G A
 ;
11 G 0^DIE17
