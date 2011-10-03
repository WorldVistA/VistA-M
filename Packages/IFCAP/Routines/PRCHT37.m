PRCHT37 ; ;10/06/97
 D DE G BEGIN
DE S DIE="^PRC(442,",DIC=DIE,DP=442,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRC(442,DA,""))=""
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,10) S:%]"" DE(6)=%
 I $D(^(23)) S %Z=^(23) S %=$P(%Z,U,1) S:%]"" DE(1)=%,DE(4)=% S %=$P(%Z,U,22) S:%]"" DE(9)=%
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
BEGIN S DNM="PRCHT37",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW="23;1",DV="RFX",DU="",DLB="EST. SHIPPING BOC",DIFLD=13.05
 S X=PRCHSBOC
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X1 Q
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S Y="@99"
 Q
3 S DQ=4 ;@98
4 S DW="23;1",DV="RFX",DU="",DLB="EST. SHIPPING BOC",DIFLD=13.05
 G RE
X4 S Z0=$P(^PRC(442,D0,0),"^",5) K:'Z0 X,Z0 I $D(X) K:'$D(^PRCD(420.1,Z0,0)) X,Z0 I $D(X) D EN88^PRCHNPO7
 I $D(X),X'?.ANP K X
 Q
 ;
5 S DQ=6 ;@99
6 S DW="1;10",DV="R*P200'",DU="",DLB="PA/PPM/AUTHORIZED BUYER",DIFLD=16
 S DU="VA(200,"
 S X=$S($D(PRCHDUZ):PRCHDUZ,1:"")
 S Y=X
 G Y
X6 S DIC("S")="I $D(^(400)),$P(^(400),U,1)>1 Q:$D(PRCHNRQ)  I $P(^(400),U,1)>2" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 S PRCHDUZ1=X I $P(^PRC(442,DA,0),U,2)=25,'$D(^PRC(440.5,"H",X)) W *7,!,"This user is not a purchase card user." S Y=16
 Q
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 I $P(^PRC(442,DA,0),U,2)'=25 S Y="@25"
 Q
9 S DW="23;22",DV="P200'",DU="",DLB="PURCHASE CARD HOLDER",DIFLD=61
 S DE(DW)="C9^PRCHT37"
 S DU="VA(200,"
 S X=PRCHDUZ1
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C9 G C9S:$D(DE(9))[0 K DB S X=DE(9),DIC=DIE
 K ^PRC(442,"MCH",X_"~",DA)
C9S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRC(442,"MCH",X_"~",DA)=""
 Q
X9 Q
10 S DQ=11 ;@25
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 K PRCHDUZ,PRCHDUZ1
 Q
12 D:$D(DG)>9 F^DIE17,DE S DQ=12,D=0 K DE(1) ;40
 S DIFLD=40,DGO="^PRCHT38",DC="51^442.01IA^2^",DV="442.01MRNJ2,0X",DW="0;1",DOW="LINE ITEM NUMBER",DLB="Select "_DOW S:D DC=DC_D
 G RE:D I $D(DSC(442.01))#2,$P(DSC(442.01),"I $D(^UTILITY(",1)="" X DSC(442.01) S D=$O(^(0)) S:D="" D=-1 G M12
 S D=$S($D(^PRC(442,DA,2,0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M12 I D>0 S DC=DC_D I $D(^PRC(442,DA,2,+D,0)) S DE(12)=$P(^(0),U,1)
 G RE
R12 D DE
 S D=$S($D(^PRC(442,DA,2,0)):$P(^(0),U,3,4),1:1) G 12+1
 ;
13 S D=0 K DE(1) ;20
 S Y="COMMENTS^W^^0;1^Q",DG="4",DC="^442.04" D DIEN^DIWE K DE(1) G A
 ;
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 I PRCHN("SC")'=0 S Y=""
 Q
15 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=15 D X15 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X15 S Z=$O(^PRC(442,DA,2,0)) I $D(^(Z,0)),$D(^PRC(441.2,+$P(^(0),U,13),0)) S PRCHN("COM")=$P(^(0),U,4)
 Q
16 D:$D(DG)>9 F^DIE17 G ^PRCHT39
