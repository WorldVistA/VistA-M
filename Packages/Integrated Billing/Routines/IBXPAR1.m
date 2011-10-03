IBXPAR1 ; ;09/24/03
 D DE G BEGIN
DE S DIE="^IBE(350.9,",DIC=DIE,DP=350.9,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^IBE(350.9,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,9) S:%]"" DE(3)=% S %=$P(%Z,U,11) S:%]"" DE(4)=%
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,7) S:%]"" DE(1)=% S %=$P(%Z,U,9) S:%]"" DE(2)=% S %=$P(%Z,U,26) S:%]"" DE(7)=%
 I $D(^(2)) S %Z=^(2) S %=$P(%Z,U,1) S:%]"" DE(8)=% S %=$P(%Z,U,2) S:%]"" DE(11)=% S %=$P(%Z,U,3) S:%]"" DE(12)=% S %=$P(%Z,U,4) S:%]"" DE(13)=% S %=$P(%Z,U,5) S:%]"" DE(14)=% S %=$P(%Z,U,6) S:%]"" DE(15)=% S %=$P(%Z,U,10) S:%]"" DE(9)=%
 I  S %=$P(%Z,U,12) S:%]"" DE(10)=%
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
BEGIN S DNM="IBXPAR1",DQ=1
1 S DW="1;7",DV="P3.8'",DU="",DLB="BILL CANCELLATION MAILGROUP",DIFLD=1.07
 S DU="XMB(3.8,"
 G RE
X1 Q
2 S DW="1;9",DV="P3.8'",DU="",DLB="BILL DISAPPROVED MAILGROUP",DIFLD=1.09
 S DU="XMB(3.8,"
 G RE
X2 Q
3 S DW="0;9",DV="P3.8'",DU="",DLB="COPAY BACKGROUND ERROR GROUP",DIFLD=.09
 S DU="XMB(3.8,"
 G RE
X3 Q
4 S DW="0;11",DV="P3.8'",DU="",DLB="MEANS TEST BILLING MAIL GROUP",DIFLD=.11
 S DU="XMB(3.8,"
 G RE
X4 Q
5 S DQ=6 ;@5
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S:IBDR'["5" Y="@99"
 Q
7 S DW="1;26",DV="*P353'",DU="",DLB="DEFAULT FORM TYPE",DIFLD=1.26
 S DU="IBE(353,"
 G RE
X7 S DIC("S")="I $P(^IBE(353,Y,0),U,1)[""UB""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
8 S DW="2;1",DV="F",DU="",DLB="AGENT CASHIER MAIL SYMBOL",DIFLD=2.01
 G RE
X8 K:$L(X)>25!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
9 S DW="2;10",DV="RF",DU="",DLB="FACILITY NAME FOR BILLING",DIFLD=2.1
 G RE
X9 K:$L(X)>18!($L(X)<1)!'($TR(X," ")?.A) X
 I $D(X),X'?.ANP K X
 Q
 ;
10 S DW="2;12",DV="S",DU="",DLB="BILLING SITE IS OTHER FACILITY",DIFLD=2.12
 S DU="0:NO;1:YES;"
 G RE
X10 Q
11 S DW="2;2",DV="F",DU="",DLB="AGENT CASHIER STREET ADDRESS",DIFLD=2.02
 G RE
X11 K:$L(X)>25!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
12 S DW="2;3",DV="F",DU="",DLB="AGENT CASHIER CITY",DIFLD=2.03
 G RE
X12 K:$L(X)>15!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
13 S DW="2;4",DV="P5'",DU="",DLB="AGENT CASHIER STATE",DIFLD=2.04
 S DU="DIC(5,"
 G RE
X13 Q
14 S DW="2;5",DV="FX",DU="",DLB="AGENT CASHIER ZIP CODE",DIFLD=2.05
 G RE
X14 S:$E(X,6)="-" X=$TR(X,"-") K:$L(X)>9!($L(X)<5)!'(X?5N!(X?9N)) X
 I $D(X),X'?.ANP K X
 Q
 ;
15 S DW="2;6",DV="F",DU="",DLB="AGENT CASHIER PHONE NUMBER",DIFLD=2.06
 G RE
X15 K:$L(X)>25!($L(X)<4) X
 I $D(X),X'?.ANP K X
 Q
 ;
16 S DQ=17 ;@99
17 G 0^DIE17
