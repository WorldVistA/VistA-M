IBXSAH5 ; ;03/14/19
 D DE G BEGIN
DE S DIE="^DGCR(399,",DIC=DIE,DP=399,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DGCR(399,DA,""))=""
 I $D(^("M2")) S %Z=^("M2") S %=$P(%Z,U,3) S:%]"" DE(1)=% S %=$P(%Z,U,5) S:%]"" DE(7)=% S %=$P(%Z,U,6) S:%]"" DE(11)=%,DE(15)=%
 I $D(^("TX")) S %Z=^("TX") S %=$P(%Z,U,8) S:%]"" DE(22)=% S %=$P(%Z,U,9) S:%]"" DE(28)=%
 K %Z Q
 ;
W W !?DL+DL-2,DLB_": "
 Q
O D W W Y W:$X>45 !?9
 I $L(Y)>19,'DV,DV'["I",(DV["F"!(DV["K")) G RW^DIR2
 W:Y]"" "// " I 'DV,DV["I",$D(DE(DQ))#2 K X S X("FIELD")=DIFLD,X("FILE")=DP W "  ("_$$EZBLD^DIALOG(710,.X)_")" K X S X="" Q  ;**
TR Q:DV["K"&(DUZ(0)'="@")  R X:DTIME E  S (DTOUT,X)=U W $C(7)
 Q
A K DQ(DQ) S DQ=DQ+1
B G @DQ
RE G A:DV["K"&(DUZ(0)'["@"),PR:$D(DE(DQ)) D W,TR
N I X="" G NKEY:$D(^DD("KEY","F",DP,DIFLD)),A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" I X?.ANP D SET^DIED I 'DDER G V
 K DDER G X
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) G:DV["*" AST^DIED D NOSCR^DIED S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V D @("X"_DQ) K YS
UNIQ I DV["U",$D(X),DIFLD=.01 K % M %=@(DIE_"""B"",X)") K %(DA) K:$O(%(0)) X
Z K DIC("S"),DLAYGO I $D(X),X'=U D:$G(DE(DW,"INDEX")) SAVEVALS G:'$$KEYCHK UNIQFERR^DIE17 S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
X W:'$D(ZTQUEUED) $C(7),"??" I $D(DB(DQ)) G Z^DIE17
 S X="?BAD"
QS S DZ=X D D,QQ^DIEQ G B
D S D=DIFLD,DQ(DQ)=DLB_U_DV_U_DU_U_DW_U_$P($T(@("X"_DQ))," ",2,99) Q
Y I '$D(DE(DQ)) D O G RD:"@"'[X,A:DV'["R"&(X="@"),X:X="@" S X=Y G N
PR S DG=DV,Y=DE(DQ),X=DU I $D(DQ(DQ,2)) X DQ(DQ,2) G RP
R I DG["P",@("$D(^"_X_"0))") S X=+$P(^(0),U,2) G RP:'$D(^(Y,0)) S Y=$P(^(0),U),X=$P(^DD(X,.01,0),U,3),DG=$P(^(0),U,2) G R
 I DG["V",+Y,$P(Y,";",2)["(",$D(@(U_$P(Y,";",2)_"0)")) S X=+$P(^(0),U,2) G RP:'$D(^(+Y,0)) S Y=$P(^(0),U) I $D(^DD(+X,.01,0)) S DG=$P(^(0),U,2),X=$P(^(0),U,3) G R
 X:DG["D" ^DD("DD") I DG["S" S %=$P($P(";"_X,";"_Y_":",2),";") I %]"" S Y=$S($G(DUZ("LANG"))'>1:%,'DIFLD:%,1:$$SET^DIQ(DP,DIFLD,Y))
RP D O I X="" S X=DE(DQ) G A:'DV,A:DC<2,N^DIE17
I I DV'["I",DV'["#" G RD
 D E^DIE0 G RD:$D(X),PR
 Q
SAVEVALS S @DIEZTMP@("V",DP,DIIENS,DIFLD,"O")=$G(DE(DQ)) S:$D(^("F"))[0 ^("F")=$G(DE(DQ))
 I $D(DE(DW,"4/")) S @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")=""
 E  K @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")
 Q
NKEY W:'$D(ZTQUEUED) "??  Required key field" S X="?BAD" G QS
KEYCHK() Q:$G(DE(DW,"KEY"))="" 1 Q @DE(DW,"KEY")
BEGIN S DNM="IBXSAH5",DQ=1
1 S DW="M2;3",DV="*P355.98'",DU="",DIFLD=142,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C1^IBXSAH5"
 S DU="IBA(355.98,"
 S Y="@"
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C1 G C1S:$D(DE(1))[0 K DB
 S X=DE(1),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"M2")),DIV=X S $P(^("M2"),U,4)=DIV,DIH=399,DIG=143 D ^DICR
C1S S X="" G:DG(DQ)=X C1F1 K DB
 S X=DG(DQ),DIC=DIE
 X ^DD(399,142,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X=DIV S X=$$ACIDD^IBCU(DA,2,X) X ^DD(399,142,1,1,1.4)
C1F1 Q
X1 Q
2 S DQ=3 ;@1082
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 I '$G(DIPA("I3")) S Y="@109"
 Q
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 K DIPA("BRANCH") S DIPA("BRANCH")=$$ACINTEL^IBCSC10(DIPA("I3"),"@109")
 Q
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 S:DIPA("BRANCH")]"" Y=DIPA("BRANCH") K DIPA("BRANCH")
 Q
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S DIPA("OLDALTT2")=$P($G(^DGCR(399,DA,"M2")),U,5)
 Q
7 D:$D(DG)>9 F^DIE17,DE S DQ=7,DW="M2;5",DV="*P355.98'",DU="",DIFLD=144,DLB="Tertiary Payer - Alt Prof Prim Payer ID Type"
 S DE(DW)="C7^IBXSAH5"
 S DU="IBA(355.98,"
 G RE
C7 G C7S:$D(DE(7))[0 K DB
 S X=DE(7),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"M2")),DIV=X S $P(^("M2"),U,6)=DIV,DIH=399,DIG=145 D ^DICR
C7S S X="" G:DG(DQ)=X C7F1 K DB
 S X=DG(DQ),DIC=DIE
 X ^DD(399,144,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X=DIV S X=$$ACIDD^IBCU(DA,3,X) X ^DD(399,144,1,1,1.4)
C7F1 Q
X7 S DIC("S")="I $$ACIDS^IBCU(DA,3,+Y)" D ^DIC K DIC S DIC=$G(DIE),X=+Y K:Y<0 X
 Q
 ;
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 I X="",$G(DIPA("OLDALTT3"))="" S Y="@1083"
 Q
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 I $P($G(^DGCR(399,DA,"M2")),U,5)="" S Y="@1083"
 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S DIPA("OLDALTI3")=$P($G(^DGCR(399,DA,"M2")),U,6)
 Q
11 D:$D(DG)>9 F^DIE17,DE S DQ=11,DW="M2;6",DV="FX",DU="",DIFLD=145,DLB="Tertiary Payer - Alt Prof Prim Payer ID"
 G RE
X11 K:$L(X)>30!($L(X)<1)!($$UP^XLFSTR(X)["PRNT") X
 I $D(X),X'?.ANP K X
 Q
 ;
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 I X="",$G(DIPA("OLDALTI3"))="" S Y="@10831"
 Q
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 S Y="@1083"
 Q
14 S DQ=15 ;@10831
15 S DW="M2;6",DV="FX",DU="",DIFLD=145,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S Y="@"
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X15 Q
16 S DQ=17 ;@1083
17 S DQ=18 ;@109
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 S:IBDR20'["109" Y="@1010"
 Q
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 D X19 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X19 I $$TEST^IBCEF84(DA) S Y="@1090"
 Q
20 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=20 D X20 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X20 I '$P($G(^DGCR(399,DA,"TX")),U,8),'$$TXMT^IBCEF4(DA) S Y="@1092"
 Q
21 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=21 D X21 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X21 I $$REQMRA^IBEFUNC(DA) S Y="@10911"
 Q
22 S DW="TX;8",DV="*S",DU="",DIFLD=27,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="0:NO FORCED PRINT;1:FORCE LOCAL PRINT;2:*FORCE CLEARINGHOUSE PRINT;"
 S Y="NO FORCED PRINT"
 G Y
X22 Q
23 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=23 D X23 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X23 S Y="@1092"
 Q
24 S DQ=25 ;@1090
25 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=25 D X25 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X25 D MESSAGE^IBCEF84
 Q
26 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=26 D X26 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X26 S Y="@1092"
 Q
27 S DQ=28 ;@10911
28 S DW="TX;9",DV="S",DU="",DIFLD=28,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="0:NO FORCED PRINT;1:MEDICARE SECONDARY FORCE LOCAL PRINT;"
 S Y="NO FORCED PRINT"
 G Y
X28 Q
29 S DQ=30 ;@1092
30 S DQ=31 ;@1010
31 G 0^DIE17
