IBXSC23 ; ;01/20/98
 D DE G BEGIN
DE S DIE="^DPT(",DIC=DIE,DP=2,DL=2,DIEL=0,DU="" K DG,DE,DB Q:$O(^DPT(DA,""))=""
 I $D(^(.22)) S %Z=^(.22) S %=$P(%Z,U,6) S:%]"" DE(4)=%
 I $D(^(.25)) S %Z=^(.25) S %=$P(%Z,U,4) S:%]"" DE(1)=% S %=$P(%Z,U,5) S:%]"" DE(2)=% S %=$P(%Z,U,6) S:%]"" DE(3)=% S %=$P(%Z,U,8) S:%]"" DE(5)=%
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
BEGIN S DNM="IBXSC23",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW=".25;4",DV="FX",DU="",DLB="SPOUSE'S EMP STREET [LINE 3]",DIFLD=.254
 G RE
X1 K:$L(X)>35!($L(X)<3) X I $D(X) S DFN=DA D SE^DGLOCK2
 I $D(X),X'?.ANP K X
 Q
 ;
2 S DW=".25;5",DV="FX",DU="",DLB="SPOUSE'S EMPLOYER'S CITY",DIFLD=.255
 G RE
X2 K:$L(X)>20!($L(X)<2) X I $D(X) S DFN=DA D SE^DGLOCK2
 I $D(X),X'?.ANP K X
 Q
 ;
3 S DW=".25;6",DV="P5'X",DU="",DLB="SPOUSE'S EMPLOYER'S STATE",DIFLD=.256
 S DU="DIC(5,"
 G RE
X3 S DFN=DA D SE^DGLOCK2
 Q
 ;
4 S DW=".22;6",DV="FOX",DU="",DLB="SPOUSE'S EMP ZIP+4",DIFLD=.2206
 S DQ(4,2)="S Y(0)=Y D ZIPOUT^VAFADDR"
 S DE(DW)="C4^IBXSC23"
 G RE
C4 G C4S:$D(DE(4))[0 K DB S X=DE(4),DIC=DIE
 D KILL^DGREGDD1(DA,.257,.25,7,$E(X,1,5))
C4S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 D SET^DGREGDD1(DA,.257,.25,7,$E(X,1,5))
 Q
X4 K:X[""""!($A(X)=45) X I $D(X) S DFN=DA D SE^DGLOCK2 I $D(X) K:$L(X)>15!($L(X)<5) X I $D(X) D ZIPIN^VAFADDR
 I $D(X),X'?.ANP K X
 Q
 ;
5 D:$D(DG)>9 F^DIE17,DE S DQ=5,DW=".25;8",DV="FOX",DU="",DLB="SPOUSE'S EMP PHONE NUMBER",DIFLD=.258
 G RE
X5 K:$L(X)>20!($L(X)<4) X I $D(X) S DFN=DA D SE^DGLOCK2
 I $D(X),X'?.ANP K X
 Q
 ;
6 S DQ=7 ;@42
7 G 1^DIE17
