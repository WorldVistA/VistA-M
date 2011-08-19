PRCHT19 ; ;10/06/97
 D DE G BEGIN
DE S DIE="^PRC(442,D0,2,",DIC=DIE,DP=442.01,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^PRC(442,D0,2,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,1) S:%]"" DE(1)=% S %=$P(%Z,U,2) S:%]"" DE(6)=% S %=$P(%Z,U,5) S:%]"" DE(2)=%
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
BEGIN S DNM="PRCHT19",DQ=1+D G B
1 S DW="0;1",DV="MRNJ2,0X",DU="",DLB="LINE ITEM NUMBER",DIFLD=.01
 S DE(DW)="C1^PRCHT19"
 G RE:'D S DQ=2 G 2
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA S Y(1)=$S($D(^PRC(442,D0,0)):^(0),1:"") S X=$P(Y(1),U,14) S DIU=X K Y X ^DD(442.01,.01,1,1,2.1) X ^DD(442.01,.01,1,1,2.4)
 S X=DE(1),DIC=DIE
 K ^PRC(442,DA(1),2,"B",$E(X,1,30),DA)
 S X=DE(1),DIC=DIE
 K ^PRC(442,DA(1),2,"C",X,DA)
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA S Y(1)=$S($D(^PRC(442,D0,0)):^(0),1:"") S X=$P(Y(1),U,14) S DIU=X K Y X ^DD(442.01,.01,1,1,1.1) X ^DD(442.01,.01,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 S ^PRC(442,DA(1),2,"B",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 I ('$D(^PRC(442,DA(1),2,DA,2)))!($P(^(0),"^",2)>$S($D(^(2)):$P(^(2),"^",8),1:0)) S ^PRC(442,DA(1),2,"C",X,DA)=""
 Q
X1 K:+X'=X!(X>999)!(X<1)!(X?.E1"."1N.N) X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S DQ=2,DW="0;5",DV="*P441'X",DU="",DLB="ITEM MASTER FILE NO.",DIFLD=1.5
 S DE(DW)="C2^PRCHT19"
 S DU="PRC(441,"
 G RE
C2 G C2S:$D(DE(2))[0 K DB S X=DE(2),DIC=DIE
 X "Q:'$D(PRC(""SITE""))!($P(^PRC(442,DA(1),0),U,3)="""")!($P(^(1),U,1)="""")  S PRCHCCP=$P($P(^(0),U,3),"" "",1),PRCHCPD=+$P(^(1),U,15),PRCHCI=X,PRCHCPO=DA(1) D EN4^PRCHCRD"
 S X=DE(2),DIC=DIE
 K ^PRC(442,DA(1),2,"AE",$E(X,1,30),DA)
C2S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 X "Q:'$D(PRC(""SITE""))!($P(^PRC(442,DA(1),0),U,3)="""")!($P(^(1),U,1)="""")  S PRCHCCP=$P($P(^(0),U,3),"" "",1),PRCHCV=$P(^(1),U,1),PRCHCPD=+$P(^(1),U,15),PRCHCI=X,PRCHCPO=DA(1) D EN3^PRCHCRD"
 S X=DG(DQ),DIC=DIE
 S ^PRC(442,DA(1),2,"AE",$E(X,1,30),DA)=""
 Q
X2 S DIC("S")="I 1",DIC(0)=DIC(0)_"O" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X I $D(X) D EN5^PRCHNPO5
 Q
 ;
3 D:$D(DG)>9 F^DIE17,DE S DQ=3,D=0 K DE(1) ;1
 S Y="DESCRIPTION^W^^0;1^Q",DG="1",DC="^442.05" D DIEN^DIWE K DE(1) G A
 ;
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 S (PRCHQUAN,Z)="" I $D(^PRC(442,DA(1),1)) S Z=$S($D(^PRC(441,+$P(^PRC(442,DA(1),2,DA,0),U,5),2,+^PRC(442,DA(1),1),0)):^(0),1:"")
 Q
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 I Z'="" W:$P(Z,U,12)'="" !,"    Minimum Order Qty.: ",$P(Z,U,12) W:$P(Z,U,9) !,"    Maximum Order Qty.: ",$P(Z,U,9) W:$P(Z,U,11) !,"    Required Order Multiple: ",$P(Z,U,11) S PRCHQUAN=Z K Z
 Q
6 S DW="0;2",DV="RNJ9,2",DU="",DLB="QUANTITY",DIFLD=2
 S DE(DW)="C6^PRCHT19"
 S X=$S($P(PRCHQUAN,U,12)'="":$P(PRCHQUAN,U,12),$P(PRCHQUAN,U,11)'="":$P(PRCHQUAN,U,11),1:"")
 S Y=X
 G Y
C6 G C6S:$D(DE(6))[0 K DB S X=DE(6),DIC=DIE
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^PRC(442,D0,2,D1,2)):^(2),1:"") S X=$P(Y(1),U,1) S DIU=X K Y S X=DIV S X="" X ^DD(442.01,2,1,1,2.4)
C6S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 X ^DD(442.01,2,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^PRC(442,D0,2,D1,2)):^(2),1:"") S X=$P(Y(1),U,1) S DIU=X K Y X ^DD(442.01,2,1,1,1.1) X ^DD(442.01,2,1,1,1.4)
 Q
X6 K:+X'=X!(X>999999)!(X<.01)!(X?.E1"."3N.N) X
 Q
 ;
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 I $P(PRCHQUAN,U,12)'="" I X<$P(PRCHQUAN,U,12) W !,"QUANTITY is less than Minimum Order Quantity.",$C(7) S Y=2
 Q
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 I $P(PRCHQUAN,U,9)'="" I X>$P(PRCHQUAN,U,9) W !,"QUANTITY is more than Maximum Order Quantity.",$C(7) S Y=2
 Q
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 I $P(PRCHQUAN,U,11)'="" I X#$P(PRCHQUAN,U,11)'=0 W !,"QUANTITY is not a Required Order Multiple value.",$C(7) S Y=2
 Q
10 D:$D(DG)>9 F^DIE17 G ^PRCHT112
