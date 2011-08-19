PRCHT31 ; ;10/06/97
 D DE G BEGIN
DE S DIE="^PRC(442,",DIC=DIE,DP=442,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRC(442,DA,""))=""
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,8) S:%]"" DE(4)=% S %=$P(%Z,U,15) S:%]"" DE(6)=% S %=$P(%Z,U,17) S:%]"" DE(7)=%
 I $D(^(7)) S %Z=^(7) S %=$P(%Z,U,3) S:%]"" DE(2)=%
 I $D(^(12)) S %Z=^(12) S %=$P(%Z,U,6) S:%]"" DE(5)=%
 I $D(^(23)) S %Z=^(23) S %=$P(%Z,U,8) S:%]"" DE(1)=%
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
BEGIN S DNM="PRCHT31",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW="23;8",DV="R*P440.5'X",DU="",DLB="PURCHASE CARD NUMBER",DIFLD=46
 S DE(DW)="C1^PRCHT31"
 S DU="PRC(440.5,"
 S X=$G(PRCHXXX)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 K ^PRC(442,"AM",$E(X,1,30),DA)
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRC(442,"AM",$E(X,1,30),DA)=""
 Q
X1 Q
2 D:$D(DG)>9 F^DIE17,DE S DQ=2,DW="7;3",DV="S",DU="",DLB="ESTIMATED ORDER?",DIFLD=.08
 S DU="Y:YES;N:NO;"
 S X="Y"
 S Y=X
 G Y
X2 Q
3 S D=0 K DE(1) ;9.2
 S DIFLD=9.2,DGO="^PRCHT32",DC="4^442.06AI^5^",DV="442.06RFX",DW="0;1",DOW="PROMPT PAYMENT PERCENT",DLB="Select "_DOW S:D DC=DC_D
 I $D(DSC(442.06))#2,$P(DSC(442.06),"I $D(^UTILITY(",1)="" X DSC(442.06) S D=$O(^(0)) S:D="" D=-1 G M3
 S D=$S($D(^PRC(442,DA,5,0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M3 I D>0 S DC=DC_D I $D(^PRC(442,DA,5,+D,0)) S DE(3)=$P(^(0),U,1)
 S X="NET"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
R3 D DE
 G A
 ;
4 S DW="1;8",DV="F",DU="",DLB="PROPOSAL",DIFLD=8.2
 S X="N/A"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X4 K:$L(X)>45!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
5 S DW="12;6",DV="FXO",DU="",DLB="INVOICE ADDRESS",DIFLD=.04
 S DQ(5,2)="S Y(0)=Y Q:Y=""""  S Z0=$S($P($G(^PRC(442,D0,23)),U,7)]"""":$P($G(^PRC(442,D0,23)),U,7),1:+^PRC(442,D0,0)) Q:'Z0  S Y=$P($S($D(^PRC(411,Z0,4,Y,0)):^(0),1:""""),U,1) K Z0"
 S X="FMS"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X5 S Z0=$S($P($G(^PRC(442,D0,23)),U,7)]"":$P($G(^PRC(442,D0,23)),U,7),1:+^PRC(442,D0,0)) K:'Z0 X Q:'Z0  S DIC="^PRC(411,Z0,4,",DIC(0)="QEMO" D ^DIC S X=+Y K:Y'>0 X K Z0,DIC
 I $D(X),X'?.ANP K X
 Q
 ;
6 S DW="1;15",DV="RDX",DU="",DLB="P.O. DATE",DIFLD=.1
 S DE(DW)="C6^PRCHT31"
 S Y="TODAY"
 G Y
C6 G C6S:$D(DE(6))[0 K DB S X=DE(6),DIC=DIE
 K ^PRC(442,"AB",$E(X,1,30),DA)
C6S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRC(442,"AB",$E(X,1,30),DA)=""
 Q
X6 S %DT="EX" D ^%DT S X=Y K:Y<1 X I $D(X) D EN1^PRCHNPO6
 Q
 ;
7 D:$D(DG)>9 F^DIE17,DE S DQ=7,DW="1;17",DV="S",DU="",DLB="EMERGENCY ORDER?",DIFLD=.2
 S DU="Y:YES;N:NO;"
 S X="N"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X7 Q
8 D:$D(DG)>9 F^DIE17 G ^PRCHT33
