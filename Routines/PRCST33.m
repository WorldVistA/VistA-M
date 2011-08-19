PRCST33 ; ;10/11/96
 D DE G BEGIN
DE S DIE="^PRCS(410,D0,""IT"",",DIC=DIE,DP=410.02,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^PRCS(410,D0,"IT",DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,1) S:%]"" DE(3)=% S %=$P(%Z,U,2) S:%]"" DE(5)=% S %=$P(%Z,U,3) S:%]"" DE(6)=% S %=$P(%Z,U,6) S:%]"" DE(7)=% S %=$P(%Z,U,7) S:%]"" DE(8)=%
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
BEGIN S DNM="PRCST33",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 I '$D(PRCSTDT) S PRCSTDT=$S($D(^PRCS(410,DA(1),1)):$P(^(0),U,4),1:"")
 Q
2 S DQ=3 ;@1
3 S DW="0;1",DV="MRNJ3,0",DU="",DLB="LINE ITEM NUMBER",DIFLD=.01
 S DE(DW)="C3^PRCST33"
 S Y="1"
 G Y
C3 G C3S:$D(DE(3))[0 K DB S X=DE(3),DIC=DIE
 K ^PRCS(410,DA(1),"IT","B",$E(X,1,30),DA)
 S X=DE(3),DIC=DIE
 K ^PRCS(410,DA(1),"IT","AB",$E(X,1,30),DA)
C3S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRCS(410,DA(1),"IT","B",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 S ^PRCS(410,DA(1),"IT","AB",$E(X,1,30),DA)=""
 Q
X3 K:+X'=X!(X>999)!(X<1)!(X?.E1"."1N.N) X
 Q
 ;
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,D=0 K DE(1) ;1
 S Y="DESCRIPTION^W^^0;1^Q",DG="1",DC="^410.03" D DIEN^DIWE K DE(1) G A
 ;
5 S DW="0;2",DV="RNJ9,2",DU="",DLB="QUANTITY",DIFLD=2
 S DE(DW)="C5^PRCST33"
 G RE
C5 G C5S:$D(DE(5))[0 K DB S X=DE(5),DIC=DIE
 X "S E=0,E(1)="""" S:'$D(^PRCS(410,DA(1),4)) ^(4)="""" F E(0)=1:1 S E=$O(^PRCS(410,DA(1),""IT"",E)) S:E?1N.N&(E'=DA) E(1)=E(1)+($P(^(E,0),U,2)*$P(^(0),U,7)) I E'?1N.N X ^DD(410.02,2,1,1,1.4) K E Q"
C5S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 X "S E=0,E(1)="""" S:'$D(^PRCS(410,DA(1),4)) ^(4)="""" F E(0)=1:1 S E=$O(^PRCS(410,DA(1),""IT"",E)) S:E?1N.N E(1)=E(1)+($P(^(E,0),U,2)*$P(^(0),U,7)) I E'?1N.N X ^DD(410.02,2,1,1,1.4) K E Q"
 Q
X5 K:+X'=X!(X>999999)!(X<.01)!(X?.E1"."3N.N) X
 Q
 ;
6 D:$D(DG)>9 F^DIE17,DE S DQ=6,DW="0;3",DV="RP420.5'",DU="",DLB="UNIT OF PURCHASE",DIFLD=3
 S DU="PRCD(420.5,"
 G RE
X6 Q
7 S DW="0;6",DV="FX",DU="",DLB="STOCK NUMBER",DIFLD=6
 G RE
X7 K:$L(X)>24!($L(X)<1)!(X'?.ANP) X
 I $D(X),X'?.ANP K X
 Q
 ;
8 S DW="0;7",DV="RNJ10,2X",DU="",DLB="EST. ITEM (UNIT) COST",DIFLD=7
 S DE(DW)="C8^PRCST33"
 G RE
C8 G C8S:$D(DE(8))[0 K DB S X=DE(8),DIC=DIE
 X "S E=0,E(1)="""" S:'$D(^PRCS(410,DA(1),4)) ^(4)="""" F E(0)=1:1 S E=$O(^PRCS(410,DA(1),""IT"",E)) S:E?1N.N&(E'=DA) E(1)=E(1)+($P(^(E,0),U,2)*$P(^(0),U,7)) I E'?1N.N X ^DD(410.02,2,1,1,1.4) K E Q"
C8S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 X "S E=0,E(1)="""" S:'$D(^PRCS(410,DA(1),4)) ^(4)="""" F E(0)=1:1 S E=$O(^PRCS(410,DA(1),""IT"",E)) S:E?1N.N E(1)=E(1)+($P(^(E,0),U,2)*$P(^(0),U,7)) I E'?1N.N X ^DD(410.02,2,1,1,1.4) K E Q"
 Q
X8 S:X["$" X=$P(X,"$",2) Q:X?1"N/C"  K:+X'=X&(X'?.N1"."2N)!(X>9999999)!(X<0) X I $D(X) S:X=0 X="N/C"
 Q
 ;
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),$P(^(0),U,12)="" S Y=4
 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),$P(^(0),"^",12)=2 S Y="@2"
 Q
11 D:$D(DG)>9 F^DIE17 G ^PRCST36
