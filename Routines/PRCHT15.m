PRCHT15 ; ;10/06/97
 D DE G BEGIN
DE S DIE="^PRC(442,",DIC=DIE,DP=442,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRC(442,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,10) S:%]"" DE(16)=%
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,3) S:%]"" DE(5)=% S %=$P(%Z,U,4) S:%]"" DE(10)=% S %=$P(%Z,U,5) S:%]"" DE(12)=% S %=$P(%Z,U,6) S:%]"" DE(13)=% S %=$P(%Z,U,11) S:%]"" DE(1)=% S %=$P(%Z,U,12) S:%]"" DE(8)=%
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
BEGIN S DNM="PRCHT15",DQ=1
1 S DW="1;11",DV="F",DU="",DLB="DELIVERY LOCATION",DIFLD=5.6
 G RE
X1 K:$L(X)>20!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 I X="PATIENT",$P(^PRC(442,DA,0),U,19) I $P(^(0),U,19)!(PRCHN("MP")=2) W *7,!,"  PATIENT DELIVERY not valid for this type of order!" S Y=5.6
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 I X="PATIENT" W "   Direct Delivery to Patient" S Y=5.3
 Q
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 G A
5 S DW="1;3",DV="NJ5,0XO",DU="",DLB="SHIP TO",DIFLD=5.4
 S DQ(5,2)="S Y(0)=Y Q:Y']""""  S Z0=$S($P($G(^PRC(442,D0,23)),U,7)]"""":$P($G(^PRC(442,D0,23)),U,7),1:$E($G(^PRC(442,D0,0)),1,3)) Q:'Z0  S Y=$P($S($D(^PRC(411,Z0,1,Y,0)):^(0),1:""""),U,1) K Z0"
 S X=$G(PRCY)
 S Y=X
 G Y
X5 S Z0=$S($P($G(^PRC(442,D0,23)),U,7)]"":$P($G(^PRC(442,D0,23)),U,7),1:$E($G(^PRC(442,D0,0)),1,3)) K:'Z0 X Q:'Z0  S DIC="^PRC(411,Z0,1,",DIC(0)="QEM" D ^DIC S X=+Y K:Y'>0 X K Z0,DIC
 Q
 ;
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 I $P(^PRC(442,DA,1),U,12)'="" W *7,!,"Delete the Direct Delivery patient name if you wish the 'Ship to' address",!,"to print on the P.O.",!
 Q
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 S:(PRCHN("MP")'=4)&($P(^(1),U,12)="") Y=6
 Q
8 S DW="1;12",DV="P440.2",DU="",DLB="DIRECT DELIVERY PATIENT",DIFLD=5.3
 S DU="PRC(440.2,"
 G RE
X8 Q
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 K DIC("DR")
 Q
10 S DW="1;4",DV="RS",DU="",DLB="VERBAL PURCHASE ORDER (Y/N)",DIFLD=6
 S DU="Y:YES;N:NO;"
 S Y="NO"
 G Y
X10 Q
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 S:X'="Y" Y=6.4
 Q
12 S DW="1;5",DV="RS",DU="",DLB="CONFIRMATION COPY (Y/N)",DIFLD=6.2
 S DU="Y:YES;N:NO;"
 G RE
X12 Q
13 S DW="1;6",DV="S",DU="",DLB="F.O.B. POINT",DIFLD=6.4
 S DU="D:DESTINATION;O:ORIGIN;"
 S Y="DESTINATION"
 G Y
X13 Q
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 S PRCHN("FOB")=X
 Q
15 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=15 G A
16 S DW="0;10",DV="RDX",DU="",DLB="DELIVERY DATE",DIFLD=7
 S Y="TODAY+10"
 G Y
X16 S %DT="EX" D ^%DT S X=Y K:Y<1 X I $D(X) S Z1=$S($D(^PRC(442,DA,1)):$P(^(1),U,15),1:""),Z2=$S('Z1:"Missing P.O. DATE",X<Z1:"DELIVERY DATE before P.O. DATE",1:"") W:Z2'="" *7,"   * ",Z2 K:Z2'="" X K Z1,Z2
 Q
 ;
17 D:$D(DG)>9 F^DIE17 G ^PRCHT16
