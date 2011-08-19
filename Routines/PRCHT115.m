PRCHT115 ; ;10/06/97
 D DE G BEGIN
DE S DIE="^PRC(442.8,",DIC=DIE,DP=442.8,DL=3,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRC(442.8,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,2) S:%]"" DE(1)=% S %=$P(%Z,U,3) S:%]"" DE(2)=% S %=$P(%Z,U,4) S:%]"" DE(3)=% S %=$P(%Z,U,5) S:%]"" DE(6)=%
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
BEGIN S DNM="PRCHT115",DQ=1
1 S DW="0;2",DV="RFX",DU="",DLB="ITEM",DIFLD=1
 S DE(DW)="C1^PRCHT115"
 S X=PRCHLINO
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 I $P(^PRC(442.8,DA,0),U,1)]"" K ^PRC(442.8,"AC",$P(^(0),U,1),X,DA)
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 I $P(^PRC(442.8,DA,0),U,1)]"" S ^PRC(442.8,"AC",$P(^(0),U,1),X,DA)=""
 Q
X1 K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>5!($L(X)<1)!'(X?1N.N) X I $D(X) S Z=$O(^PRC(442,"B",$P(^PRC(442.8,DA,0),U,1),0)) K:'$O(^PRC(442,+Z,2,"B",X,0)) X K Z
 I $D(X),X'?.ANP K X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S DQ=2,DW="0;3",DV="RD",DU="",DLB="DELIVERY DATE",DIFLD=2
 S DE(DW)="C2^PRCHT115"
 G RE
C2 G C2S:$D(DE(2))[0 K DB S X=DE(2),DIC=DIE
 I $P(^PRC(442.8,DA,0),U,1)]"" K ^PRC(442.8,"AF",$E($P(^(0),U,1),1,30),X,DA)
C2S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 I $P(^PRC(442.8,DA,0),U,1)]"" S ^PRC(442.8,"AF",$E($P(^(0),U,1),1,30),X,DA)=""
 Q
X2 S %DT="EX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
3 D:$D(DG)>9 F^DIE17,DE S DQ=3,DW="0;4",DV="RP410.8",DU="",DLB="LOCATION FOR DELIVERY",DIFLD=3
 S DU="PRCS(410.8,"
 G RE
X3 Q
4 S DQ=5 ;@6
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 S DIE("NO^")=""
 Q
6 S DW="0;5",DV="RNJ9,2",DU="",DLB="QTY TO BE DELIVERED",DIFLD=4
 G RE
X6 K:+X'=X!(X>999999.99)!(X<0)!(X?.E1"."3N.N) X
 Q
 ;
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 K DIE("NO^")
 Q
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 S PRCHTOT=0,PRCHSCN="" F I=0:0 S PRCHSCN=$O(^PRC(442.8,"B",PRCHPONO,PRCHSCN)) Q:PRCHSCN=""  I $P(^PRC(442.8,PRCHSCN,0),U,2)=PRCHDA S PRCHTOT=PRCHTOT+$P(^(0),U,5)
 Q
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 I PRCHTOT>$P(^PRC(442,PRCHDA1,2,PRCHDA,0),U,2) W *7,!,"Total quantity for the delivery schedules exceeds the purchase order quantity" S Y="@6"
 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 I PRCHTOT<$P(^PRC(442,PRCHDA1,2,PRCHDA,0),U,2) W !,"Total quantity on delivery schedules is less than purchase order quantity",!
 Q
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 S DA(1)=PRCHDA1,DA=PRCHDA K PRCHDA,PRCHDA1,PRCHTOT,PRCHSCN S:X>0 Y=""
 Q
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 W *7,!,"Delivery Schedule DELETED",!
 Q
13 D:$D(DG)>9 F^DIE17 G ^PRCHT116
