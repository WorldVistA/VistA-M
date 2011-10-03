RTCR1 ; ;07/15/96
 D DE G BEGIN
DE S DIE="^RT(",DIC=DIE,DP=190,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^RT(DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,6) S:%]"" DE(13)=% S %=$P(%Z,U,12) S:%]"" DE(11)=%
 I $D(^("CL")) S %Z=^("CL") S %=$P(%Z,U,6) S:%]"" DE(1)=% S %=$P(%Z,U,7) S:%]"" DE(2)=% S %=$P(%Z,U,8) S:%]"" DE(3)=% S %=$P(%Z,U,15) S:%]"" DE(4)=%
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
BEGIN S DNM="RTCR1",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW="CL;6",DV="D",DU="",DLB="DATE/TIME CHARGED TO BORROWER",DIFLD=106
 S DE(DW)="C1^RTCR1"
 S X=RTNOW
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 K ^RT("AC",X,DA)
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 X "Q:'$D(^RT(DA,""CL""))!('$D(^(0)))  Q:$P(^(0),""^"",6)=$P(^(""CL""),""^"",5)  S ^RT(""AC"",X,DA)="""""
 Q
X1 Q
2 D:$D(DG)>9 F^DIE17,DE S DQ=2,DW="CL;7",DV="P200'",DU="",DLB="USER THAT CHARGED RECORD",DIFLD=107
 S DU="VA(200,"
 S X=RTDUZ
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X2 Q
3 S DW="CL;8",DV="*P195.3'",DU="",DLB="TYPE OF MOVEMENT",DIFLD=108
 S DU="DIC(195.3,"
 S X=+$O(^DIC(195.3,"AA",+RTAPL,$S('$D(RTRANEW):"INITIAL CREATION",1:"TRANSFER CREATE INITIAL"),0))
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X3 Q
4 S DW="CL;15",DV="S",DU="",DLB="LAST TIME SELECTED BY BARCODE?",DIFLD=115
 S DU="y:YES;n:NO;"
 S X="n"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X4 Q
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 S:'$D(RTSHOW) Y="@999"
 Q
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 W !!,$P($P(RTTY,U),RTSEMI,2)," Creation:"
 Q
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 S L=$L($P($P(RTTY,U),RTSEMI,2))+10 W ! F I=1:1:L W "-"
 Q
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 I $D(RTRANEW) S Y="@5"
 Q
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 I $P(RTTY,U,16)'="y" S Y="@10"
 Q
10 S DQ=11 ;@5
11 S DW="0;12",DV="F",DU="",DLB="CONTENT DESCRIPTOR",DIFLD=12
 G RE
X11 K:$L(X)>20!($L(X)<2) X
 I $D(X),X'?.ANP K X
 Q
 ;
12 S DQ=13 ;@10
13 S DW="0;6",DV="R*P195.9'X",DU="",DLB="HOME LOCATION",DIFLD=6
 S DE(DW)="C13^RTCR1"
 S DU="RTV(195.9,"
 G RE
C13 G C13S:$D(DE(13))[0 K DB S X=DE(13),DIC=DIE
 K ^RT("AH",$E(X,1,30),DA)
 S X=DE(13),DIC=DIE
 ;
C13S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^RT("AH",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 X "Q:'$D(^RT(DA,""CL""))  Q:X=$P(^(""CL""),""^"",5)!('$P(^(""CL""),""^"",6))  S ^RT(""AC"",+$P(^(""CL""),""^"",6),DA)="""""
 Q
X13 S DIC("V")="I $P(Y(0),U,4)=""L""",DIC("S")="I $D(D0),$D(^DIC(195.2,""AF"",Y,+$P(^RT(D0,0),U,3))) D DICS^RTDPA31" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
14 D:$D(DG)>9 F^DIE17 G ^RTCR2
