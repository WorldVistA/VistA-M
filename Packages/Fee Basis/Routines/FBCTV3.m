FBCTV3 ; ;06/29/07
 D DE G BEGIN
DE S DIE="^FBAAV(",DIC=DIE,DP=161.2,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^FBAAV(DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,17) S:%]"" DE(1)=% S %=$P(%Z,U,18) S:%]"" DE(2)=%
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,1) S:%]"" DE(5)=% S %=$P(%Z,U,10) S:%]"" DE(6)=%,DE(7)=%
 I $D(^("AMS")) S %Z=^("AMS") S %=$P(%Z,U,1) S:%]"" DE(11)=% S %=$P(%Z,U,2) S:%]"" DE(13)=% S %=$P(%Z,U,3) S:%]"" DE(14)=% S %=$P(%Z,U,4) S:%]"" DE(15)=% S %=$P(%Z,U,5) S:%]"" DE(16)=% S %=$P(%Z,U,6) S:%]"" DE(17)=%
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
N I X="" G NKEY:$D(^DD("KEY","F",DP,DIFLD)),A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) I X?.ANP D SET I 'DDER X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
 K DDER G X
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) G:DV["*" AST^DIED D NOSCR^DIED S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V D @("X"_DQ) K YS
Z K DIC("S"),DLAYGO I $D(X),X'=U D:$G(DE(DW,"INDEX")) SAVEVALS G:'$$KEYCHK UNIQFERR^DIE17 S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
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
SAVEVALS S @DIEZTMP@("V",DP,DIIENS,DIFLD,"O")=$G(DE(DQ)) S:$D(^("F"))[0 ^("F")=$G(DE(DQ))
 I $D(DE(DW,"4/")) S @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")=""
 E  K @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")
 Q
NKEY W:'$D(ZTQUEUED) "??  Required key field" S X="?BAD" G QS
KEYCHK() Q:$G(DE(DW,"KEY"))="" 1 Q @DE(DW,"KEY")
BEGIN S DNM="FBCTV3",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW="0;17",DV="F",DU="",DLB="MEDICARE ID NUMBER",DIFLD=22
 S X=$P(Z1,U,17)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X1 Q
2 S DW="0;18",DV="F",DU="",DLB="MAIL ROUTE CODE",DIFLD=5.18
 S X=$P(Z1,U,18)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X2 Q
3 S DQ=4 ;@10
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 S:'$D(Z3) Y="@20"
 Q
5 S DW="1;1",DV="F",DU="",DLB="PHONE NUMBER",DIFLD=14
 S X=$P(Z3,U,1)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X5 Q
6 S DW="1;10",DV="S",DU="",DLB="BUSINESS TYPE (FPDS)",DIFLD=24
 S DU="1:SMALL BUSINESS;2:LARGE BUSINESS;3:OUTSIDE U.S.;4:OTHER ENTITIES;"
 S Y="@"
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X6 Q
7 S DW="1;10",DV="S",DU="",DLB="BUSINESS TYPE (FPDS)",DIFLD=24
 S DU="1:SMALL BUSINESS;2:LARGE BUSINESS;3:OUTSIDE U.S.;4:OTHER ENTITIES;"
 S X=$P(Z3,U,10)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X7 Q
8 S DQ=9 ;@20
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 S:'$D(Z4) Y=""
 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S:$G(FBTMPCK) Y="@30"
 Q
11 S DW="AMS;1",DV="FX",DU="",DLB="AUSTIN NAME FIELD",DIFLD=30.01
 S DE(DW)="C11^FBCTV3"
 S X=$P(Z4,U)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C11 G C11S:$D(DE(11))[0 K DB
 S X=DE(11),DIC=DIE
 K ^FBAAV("D",$E(X,1,30),DA)
C11S S X="" G:DG(DQ)=X C11F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^FBAAV("D",$E(X,1,30),DA)=""
C11F1 Q
X11 Q
12 S DQ=13 ;@30
13 D:$D(DG)>9 F^DIE17,DE S DQ=13,DW="AMS;2",DV="FXO",DU="",DLB="PRICER EXEMPT",DIFLD=30.02
 S DQ(13,2)="S Y(0)=Y D OUTYN^FBAAUTL3"
 S X=$P(Z4,U,2)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X13 Q
14 S DW="AMS;3",DV="FXO",DU="",DLB="1099 VENDOR",DIFLD=30.03
 S DQ(14,2)="S Y(0)=Y D OUTYN^FBAAUTL3"
 S X=$P(Z4,U,3)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X14 Q
15 S DW="AMS;4",DV="S",DU="",DLB="FMS VENDOR TYPE",DIFLD=30.04
 S DU="C:commercial;I:individual;F:federal;"
 S X=$P(Z4,U,4)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X15 Q
16 S DW="AMS;5",DV="S",DU="",DLB="PROVIDER CODE",DIFLD=30.05
 S DU="B:both;V:vendor only;P:provider only;"
 S X=$P(Z4,U,5)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X16 Q
17 S DW="AMS;6",DV="RS",DU="",DLB="TAX ID/SSN FLAG",DIFLD=30.06
 S DU="T:TAX ID NUMBER;S:SSN NUMBER;"
 S X=$P(Z4,U,6)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X17 Q
18 G 0^DIE17
