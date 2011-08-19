PRCATB ; GENERATED FROM 'PRCA BATCH PAYMENT' INPUT TEMPLATE(#828), FILE 433;05/27/98
 D DE G BEGIN
DE S DIE="^PRCA(433,",DIC=DIE,DP=433,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRCA(433,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,2) S:%]"" DE(1)=% S %=$P(%Z,U,6) S:%]"" DE(2)=% S %=$P(%Z,U,8) S:%]"" DE(3)=% S %=$P(%Z,U,9) S:%]"" DE(9)=%
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,1) S:%]"" DE(4)=% S %=$P(%Z,U,2) S:%]"" DE(5)=% S %=$P(%Z,U,3) S:%]"" DE(6)=% S %=$P(%Z,U,5) S:%]"" DE(7)=%
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
BEGIN S DNM="PRCATB",DQ=1
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIEZ=828,U="^"
1 S DW="0;2",DV="RP430'X",DU="",DLB="BILL NUMBER",DIFLD=.03
 S DE(DW)="C1^PRCATB"
 S DU="PRCA(430,"
 S X=PRCABN
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 K ^PRCA(433,"C",$E(X,1,30),DA)
 S X=DE(1),DIC=DIE
 ;
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRCA(433,"C",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S Y(1)=$S($D(^PRCA(433,D0,1)):^(1),1:"") S X=$P(Y(1),U,9)="" I X S X=DIV S Y(1)=$S($D(^PRCA(433,D0,1)):^(1),1:"") S X=$P(Y(1),U,9),X=X S DIU=X K Y S X=DIV D NOW^%DTC S X=% X ^DD(433,.03,1,2,1.4)
 Q
X1 Q
2 D:$D(DG)>9 F^DIE17,DE S DQ=2,DW="0;6",DV="NJ3,0",DU="",DLB="SEGMENT",DIFLD=6
 S X=$S($D(PRCA("SEG")):PRCA("SEG"),1:"")
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X2 K:+X'=X!(X>500)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
3 S DW="0;8",DV="F",DU="",DLB="APPROPRIATION SYMBOL",DIFLD=8
 S X=$S($D(PRCAPPR):PRCAPPR,1:"")
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X3 K:$L(X)>10!($L(X)<7) X
 I $D(X),X'?.ANP K X
 Q
 ;
4 S DW="1;1",DV="RDX",DU="",DLB="TRANSACTION DATE",DIFLD=11
 S X=$S($D(PRCADT):PRCADT,1:DT)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X4 S %DT(0)=-DT,%DT="" D ^%DT S X=Y K:Y<1 X K %DT
 Q
 ;
5 S DW="1;2",DV="RP430.3'X",DU="",DLB="TRANSACTION TYPE",DIFLD=12
 S DE(DW)="C5^PRCATB"
 S DU="PRCA(430.3,"
 S X=2
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C5 G C5S:$D(DE(5))[0 K DB S X=DE(5),DIC=DIE
 K ^PRCA(433,"AW",X,DA)
 S X=DE(5),DIC=DIE
 I $P($G(^PRCA(433,DA,1)),U,9) K ^PRCA(433,"AT",X,+$P($P(^PRCA(433,DA,1),U,9),"."),DA)
 S X=DE(5),DIC=DIE
 ;
C5S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 I X>7,X<12 S ^PRCA(433,"AW",X,DA)=""
 S X=DG(DQ),DIC=DIE
 I $P($G(^PRCA(433,DA,1)),U,9) S ^PRCA(433,"AT",X,+$P($P(^PRCA(433,DA,1),U,9),"."),DA)=""
 S X=DG(DQ),DIC=DIE
 I X=2 D AEOB^RCRCUTL
 Q
X5 Q
6 D:$D(DG)>9 F^DIE17,DE S DQ=6,DW="1;3",DV="FX",DU="",DLB="RECEIPT #",DIFLD=13
 S DE(DW)="C6^PRCATB"
 S X=$G(PRCARN)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C6 G C6S:$D(DE(6))[0 K DB S X=DE(6),DIC=DIE
 K ^PRCA(433,"AF",$E(X,1,30),DA)
C6S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRCA(433,"AF",$E(X,1,30),DA)=""
 Q
X6 Q
7 D:$D(DG)>9 F^DIE17,DE S DQ=7,DW="1;5",DV="RNJ9,2X",DU="",DLB="TRANS. AMOUNT",DIFLD=15
 S X=$G(PRCA("PAYMT"))
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X7 Q
8 S D=0 K DE(1) ;41
 S DE(1,0)="/^S X=$G(PRCACOM)"
 S Y="COMMENTS^W^^0;1^Q",DG="7",DC="^433.041" D DIEN^DIWE K DE(1) G A
 ;
9 S DW="0;9",DV="P200'",DU="",DLB="PROCESSED BY",DIFLD=42
 S DU="VA(200,"
 S X=$G(PRCAPER)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X9 Q
10 G 0^DIE17
