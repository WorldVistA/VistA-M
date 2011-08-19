RTCM ; GENERATED FROM 'RT MOVEMENT' INPUT TEMPLATE(#884), FILE 190.3;07/15/96
 D DE G BEGIN
DE S DIE="^RTV(190.3,",DIC=DIE,DP=190.3,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^RTV(190.3,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,2) S:%]"" DE(1)=% S %=$P(%Z,U,3) S:%]"" DE(2)=% S %=$P(%Z,U,4) S:%]"" DE(3)=% S %=$P(%Z,U,5) S:%]"" DE(4)=% S %=$P(%Z,U,6) S:%]"" DE(5)=% S %=$P(%Z,U,7) S:%]"" DE(6)=% S %=$P(%Z,U,8) S:%]"" DE(7)=%
 I  S %=$P(%Z,U,14) S:%]"" DE(8)=% S %=$P(%Z,U,15) S:%]"" DE(9)=%
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
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) D SET I 'DDER X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
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
SET I X'?.ANP S DDER=1 Q 
 N DIR S DIR(0)="SMV^"_DU,DIR("V")=1
 I $D(DB(DQ)),'$D(DIQUIET) N DIQUIET S DIQUIET=1
 D ^DIR I 'DDER S %=Y(0),X=Y
 Q
BEGIN S DNM="RTCM",DQ=1
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIEZ=884,U="^"
1 S DW="0;2",DV="DI",DU="",DLB="DATE/TIME RECORD WAS REQUESTED",DIFLD=2
 S X=$P(RTM,U,2)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X1 Q
2 S DW="0;3",DV="P200'I",DU="",DLB="USER THAT REQUESTED RECORD",DIFLD=3
 S DU="VA(200,"
 S X=$P(RTM,U,3)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X2 Q
3 S DW="0;4",DV="DI",DU="",DLB="DATE/TIME RECORD WAS NEEDED",DIFLD=4
 S X=$P(RTM,U,4)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X3 Q
4 S DW="0;5",DV="R*P195.9IX",DU="",DLB="BORROWER",DIFLD=5
 S DU="RTV(195.9,"
 S X=$P(RTM,U,5)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X4 Q
5 S DW="0;6",DV="DI",DU="",DLB="DATE/TIME CHARGED TO BORROWER",DIFLD=6
 S DE(DW)="C5^RTCM"
 S X=$P(RTM,U,6)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
C5 G C5S:$D(DE(5))[0 K DB S X=DE(5),DIC=DIE
 K ^RTV(190.3,"C",$E(X,1,30),DA)
C5S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^RTV(190.3,"C",$E(X,1,30),DA)=""
 Q
X5 Q
6 D:$D(DG)>9 F^DIE17,DE S DQ=6,DW="0;7",DV="P200'I",DU="",DLB="USER THAT CHARGED RECORD",DIFLD=7
 S DU="VA(200,"
 S X=$P(RTM,U,7)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X6 Q
7 S DW="0;8",DV="R*P195.3'I",DU="",DLB="TYPE OF MOVEMENT",DIFLD=8
 S DU="DIC(195.3,"
 S X=$P(RTM,U,8)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X7 Q
8 S DW="0;14",DV="*P195.9IX",DU="",DLB="ASSOCIATED BORROWER",DIFLD=14
 S DU="RTV(195.9,"
 S X=$P(RTM,U,14)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X8 Q
9 S DW="0;15",DV="S",DU="",DLB="SELECTION BY BARCODE?",DIFLD=15
 S DU="y:YES;n:NO;"
 S X=$P(RTM,U,15)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X9 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 S I(0,0)=D0 S Y(1)=$S($D(^RTV(190.3,D0,0)):^(0),1:"") S X=$P(Y(1),U,1),X=X S D(0)=+X S X=$S(D(0)>0:D(0),1:"")
 S DGO="^RTCM1",DC="^190^RT(" G DIEZ^DIE0
R10 D DE G A
 ;
11 G 0^DIE17
