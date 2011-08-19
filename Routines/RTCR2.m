RTCR2 ; ;07/15/96
 D DE G BEGIN
DE S DIE="^RT(",DIC=DIE,DP=190,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^RT(DA,""))=""
 I $D(^("CL")) S %Z=^("CL") S %=$P(%Z,U,5) S:%]"" DE(1)=% S %=$P(%Z,U,14) S:%]"" DE(3)=%
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
BEGIN S DNM="RTCR2",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW="CL;5",DV="R*P195.9X",DU="",DLB="CURRENT BORROWER/FILE ROOM",DIFLD=105
 S DE(DW)="C1^RTCR2"
 S DU="RTV(195.9,"
 G RE
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 K ^RT("ABOR",$E(X,1,30),DA)
 S X=DE(1),DIC=DIE
 ;
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^RT("ABOR",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 X "Q:'$D(^RT(DA,""CL""))!('$D(^(0)))  Q:X=$P(^(0),""^"",6)!('$P(^(""CL""),""^"",6))  S ^RT(""AC"",+$P(^(""CL""),""^"",6),DA)="""""
 Q
X1 D REC^RTDPA31 S DIC("S")="I $D(D0),$P(^RT(D0,0),U,4)=$P(^RTV(195.9,Y,0),U,3) D DICS^RTDPA31" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 I X S:$D(RTB) RTZB=RTB S RTB=X,RTPCE=3 D ATT^RTDPA3 K RTPCE,RTB S:$D(RTZB) RTB=RTZB K RTZB K:Y Y S:$D(Y) Y="@20"
 Q
3 D:$D(DG)>9 F^DIE17,DE S DQ=3,DW="CL;14",DV="*P195.9X",DU="",DLB="ASSOCIATED BORROWER",DIFLD=114
 S DU="RTV(195.9,"
 G RE
X3 D REC^RTDPA31 S DIC("S")="I $D(D0),$P(^RT(D0,0),U,4)=$P(^RTV(195.9,Y,0),U,3) D DICS^RTDPA31" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
4 S DQ=5 ;@20
5 S DQ=6 ;@999
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 K L,RTSEMI,RTDUZ
 Q
7 G 0^DIE17
