PRCHT34 ; ;10/06/97
 D DE G BEGIN
DE S DIE="^PRC(440,",DIC=DIE,DP=440,DL=2,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRC(440,DA,""))=""
 I $D(^(3)) S %Z=^(3) S %=$P(%Z,U,8) S:%]"" DE(2)=% S %=$P(%Z,U,9) S:%]"" DE(5)=% S %=$P(%Z,U,11) S:%]"" DE(14)=% S %=$P(%Z,U,14) S:%]"" DE(17)=%
 I $D(^(7)) S %Z=^(7) S %=$P(%Z,U,3) S:%]"" DE(8)=% S %=$P(%Z,U,4) S:%]"" DE(9)=% S %=$P(%Z,U,7) S:%]"" DE(10)=% S %=$P(%Z,U,8) S:%]"" DE(11)=% S %=$P(%Z,U,9) S:%]"" DE(12)=%
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
BEGIN S DNM="PRCHT34",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 I FLAG S Y=17.3
 Q
2 S DW="3;8",DV="FX",DU="",DLB="TAX ID/SSN",DIFLD=38
 G RE
X2 S X=$TR(X,"-") K:$L(X)>9!($L(X)<9)!(X'?9N) X
 I $D(X),X'?.ANP K X
 Q
 ;
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 I X]"" S Y=39
 Q
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 W !!,"This VENDOR needs a TAX IDENTIFICATION NUMBER or a SOCIAL SECURITY NUMBER.",!,"Please enter one if you have it or get one from the VENDOR.",!
 Q
5 S DW="3;9",DV="S",DU="",DLB="SSN/TAX ID INDICATOR",DIFLD=39
 S DU="S:SOCIAL SECURITY NUMBER;T:TAX IDENTIFICATION NUMBER;"
 G RE
X5 Q
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 I X]"" S Y=17.3
 Q
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 W !!,"Please tell me whether the TAX ID/SSN field is a TAX NUMBER or a SSN NUMBER.",!
 Q
8 S DW="7;3",DV="RFX",DU="",DLB="PAYMENT ADDRESS1",DIFLD=17.3
 G RE
X8 K:$L(X)>23!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
9 S DW="7;4",DV="F",DU="",DLB="PAYMENT ADDRESS2",DIFLD=17.4
 G RE
X9 K:$L(X)>23!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
10 S DW="7;7",DV="RF",DU="",DLB="PAYMENT CITY",DIFLD=17.7
 G RE
X10 K:$L(X)>20!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
11 S DW="7;8",DV="RP5'",DU="",DLB="PAYMENT STATE",DIFLD=17.8
 S DU="DIC(5,"
 G RE
X11 Q
12 S DW="7;9",DV="RFX",DU="",DLB="PAYMENT ZIP CODE",DIFLD=17.9
 G RE
X12 K:$L(X)<5!(X'?5N.E)!($L(X)>10)!($L(X)>5&(X'?5N1"-"4N)) X
 I $D(X),X'?.ANP K X
 Q
 ;
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 I $P(PRCHOV3,U,11)]"" S Y="@10"
 Q
14 S DW="3;11",DV="RS",DU="",DLB="1099 VENDOR INDICATOR",DIFLD=41
 S DU="N:NO;Y:YES;"
 G RE
X14 Q
15 S DQ=16 ;@10
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 I $P(PRCHOV3,U,14)]"" S Y="@11"
 Q
17 S DW="3;14",DV="RS",DU="",DLB="VENDOR TYPE",DIFLD=44
 S DU="A:AGENT CASHIER;C:COMMERCIAL;E:EMPLOYEE;F:FEDERAL GOVERNMENT;G:GSA;I:INDIVIDUALS-OTHER;O:OTHER COUNTRIES;R:COMMERCIAL-RECURRING PMTS;U:UTILITY COMPANIES;V:VETERANS;K:CANTEEN;"
 G RE
X17 Q
18 S DQ=19 ;@11
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 D X19 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X19 I $P(PRCHOV3,U,13)]"" S Y=""
 Q
20 G 1^DIE17
