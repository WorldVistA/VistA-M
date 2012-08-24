IBXS9 ; GENERATED FROM 'IB SCREEN9' INPUT TEMPLATE(#1755), FILE 399;02/21/12
 D DE G BEGIN
DE S DIE="^DGCR(399,",DIC=DIE,DP=399,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DGCR(399,DA,""))=""
 I $D(^("U5")) S %Z=^("U5") S %=$P(%Z,U,2) S:%]"" DE(2)=% S %=$P(%Z,U,3) S:%]"" DE(3)=% S %=$P(%Z,U,4) S:%]"" DE(4)=% S %=$P(%Z,U,5) S:%]"" DE(5)=% S %=$P(%Z,U,6) S:%]"" DE(6)=%
 I $D(^("U6")) S %Z=^("U6") S %=$P(%Z,U,1) S:%]"" DE(7)=% S %=$P(%Z,U,2) S:%]"" DE(8)=% S %=$P(%Z,U,3) S:%]"" DE(9)=% S %=$P(%Z,U,4) S:%]"" DE(10)=% S %=$P(%Z,U,5) S:%]"" DE(11)=% S %=$P(%Z,U,6) S:%]"" DE(12)=%
 I $D(^("U7")) S %Z=^("U7") S %=$P(%Z,U,1) S:%]"" DE(13)=% S %=$P(%Z,U,2) S:%]"" DE(15)=% S %=$P(%Z,U,3) S:%]"" DE(14)=% S %=$P(%Z,U,4) S:%]"" DE(16)=% S %=$P(%Z,U,5) S:%]"" DE(17)=%
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
BEGIN S DNM="IBXS9",DQ=1
 N DIEZTMP,DIEZAR,DIEZRXR,DIIENS,DIXR K DIEFIRE,DIEBADK S DIEZTMP=$$GETTMP^DIKC1("DIEZ")
 M DIEZAR=^DIE(1755,"AR") S DICRREC="TRIG^DIE17"
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIIENS=DA_",",DIEZ=1755,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 S:IBDR20'["91" Y="@92"
 Q
2 S DW="U5;2",DV="F",DU="",DLB="P/U Address1",DIFLD=271
 G RE
X2 K:$L(X)>40!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
3 S DW="U5;3",DV="F",DU="",DLB="P/U Address 2",DIFLD=272
 G RE
X3 K:$L(X)>30!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
4 S DW="U5;4",DV="F",DU="",DLB="P/U City",DIFLD=273
 G RE
X4 K:$L(X)>30!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
5 S DW="U5;5",DV="P5'",DU="",DLB="P/U State",DIFLD=274
 S DU="DIC(5,"
 G RE
X5 Q
6 S DW="U5;6",DV="F",DU="",DLB="P/U Zip",DIFLD=275
 G RE
X6 K:$L(X)>15!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
7 S DW="U6;1",DV="F",DU="",DLB="D/O Location",DIFLD=276
 G RE
X7 K:$L(X)>60!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
8 S DW="U6;2",DV="F",DU="",DLB="D/O Address1",DIFLD=277
 G RE
X8 K:$L(X)>40!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
9 S DW="U6;3",DV="F",DU="",DLB="D/O Address2",DIFLD=278
 G RE
X9 K:$L(X)>30!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
10 S DW="U6;4",DV="F",DU="",DLB="D/O City",DIFLD=279
 G RE
X10 K:$L(X)>30!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
11 S DW="U6;5",DV="P5'",DU="",DLB="D/O State",DIFLD=280
 S DU="DIC(5,"
 G RE
X11 Q
12 S DW="U6;6",DV="F",DU="",DLB="D/O Zip",DIFLD=281
 G RE
X12 K:$L(X)>15!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
13 S DW="U7;1",DV="NJ4,0",DU="",DLB="Patient Weight",DIFLD=287
 G RE
X13 K:+X'=X!(X>1000)!(X<1)!(X?.E1"."1N.N) X
 Q
 ;
14 S DW="U7;3",DV="NJ5,0",DU="",DLB="Transport Distance",DIFLD=289
 G RE
X14 K:+X'=X!(X>10000)!(X<0)!(X?.E1"."1.N) X
 Q
 ;
15 S DW="U7;2",DV="P353.4'",DU="",DLB="Transport Reason",DIFLD=288
 S DU="IBE(353.4,"
 G RE
X15 Q
16 S DW="U7;4",DV="F",DU="",DLB="R/T Purpose",DIFLD=290
 G RE
X16 K:$L(X)>80!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
17 S DW="U7;5",DV="F",DU="",DLB="Stretcher Purpose",DIFLD=291
 G RE
X17 K:$L(X)>80!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 S Y="@999"
 Q
19 S DQ=20 ;@92
20 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=20 D X20 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X20 S:IBDR20'["92" Y="@999"
 Q
21 S D=0 K DE(1) ;292
 S DIFLD=292,DGO="^IBXS91",DC="1^399.0292PA^U9^",DV="399.0292M*P353.5'",DW="0;1",DOW="Ambulance Condition Indicator",DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 S DU="IBE(353.5,"
 G RE:D I $D(DSC(399.0292))#2,$P(DSC(399.0292),"I $D(^UTILITY(",1)="" X DSC(399.0292) S D=$O(^(0)) S:D="" D=-1 G M21
 S D=$S($D(^DGCR(399,DA,"U9",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M21 I D>0 S DC=DC_D I $D(^DGCR(399,DA,"U9",+D,0)) S DE(21)=$P(^(0),U,1)
 G RE
R21 D DE
 S D=$S($D(^DGCR(399,DA,"U9",0)):$P(^(0),U,3,4),1:1) G 21+1
 ;
22 S DQ=23 ;@999
23 G 0^DIE17
