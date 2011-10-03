RTCR ; GENERATED FROM 'RT NEW RECORD' INPUT TEMPLATE(#877), FILE 190;07/15/96
 D DE G BEGIN
DE S DIE="^RT(",DIC=DIE,DP=190,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^RT(DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,3) S:%]"" DE(2)=% S %=$P(%Z,U,5) S:%]"" DE(3)=% S %=$P(%Z,U,6) S:%]"" DE(4)=% S %=$P(%Z,U,7) S:%]"" DE(5)=% S %=$P(%Z,U,12) S:%]"" DE(6)=%
 I $D(^("CL")) S %Z=^("CL") S %=$P(%Z,U,5) S:%]"" DE(7)=%
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
BEGIN S DNM="RTCR",DQ=1
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIEZ=877,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 S RTSEMI=$C(59) D DUZ^RTPSET
 Q
2 S DW="0;3",DV="RP195.2'I",DU="",DLB="TYPE OF RECORD",DIFLD=3
 S DE(DW)="C2^RTCR"
 S DU="DIC(195.2,"
 S X=+RTTY
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
C2 G C2S:$D(DE(2))[0 K DB S X=DE(2),DIC=DIE
 ;
 S X=DE(2),DIC=DIE
 K ^RT("AT",X,$P(^RT(DA,0),U),DA)
C2S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^RT(D0,0)):^(0),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y X ^DD(190,3,1,1,1.1) X ^DD(190,3,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 S ^RT("AT",X,$P(^RT(DA,0),U),DA)=""
 Q
X2 Q
3 D:$D(DG)>9 F^DIE17,DE S DQ=3,DW="0;5",DV="*P190'I",DU="",DLB="PARENT RECORD",DIFLD=5
 S DE(DW)="C3^RTCR"
 S DU="RT("
 S X=RTPAR
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
C3 G C3S:$D(DE(3))[0 K DB S X=DE(3),DIC=DIE
 K ^RT("P",$E(X,1,30),DA)
C3S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^RT("P",$E(X,1,30),DA)=""
 Q
X3 Q
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="0;6",DV="R*P195.9'X",DU="",DLB="HOME LOCATION",DIFLD=6
 S DE(DW)="C4^RTCR"
 S DU="RTV(195.9,"
 S X=$P(RTINIT,U,2)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
C4 G C4S:$D(DE(4))[0 K DB S X=DE(4),DIC=DIE
 K ^RT("AH",$E(X,1,30),DA)
 S X=DE(4),DIC=DIE
 ;
C4S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^RT("AH",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 X "Q:'$D(^RT(DA,""CL""))  Q:X=$P(^(""CL""),""^"",5)!('$P(^(""CL""),""^"",6))  S ^RT(""AC"",+$P(^(""CL""),""^"",6),DA)="""""
 Q
X4 Q
5 D:$D(DG)>9 F^DIE17,DE S DQ=5,DW="0;7",DV="RNJ2,0I",DU="",DLB="VOLUME NUMBER",DIFLD=7
 S X=RTVOL
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X5 Q
6 S DW="0;12",DV="F",DU="",DLB="CONTENT DESCRIPTOR",DIFLD=12
 S X=$S($D(RTACCN):RTACCN,1:"")
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
X6 Q
7 S DW="CL;5",DV="R*P195.9X",DU="",DLB="CURRENT BORROWER/FILE ROOM",DIFLD=105
 S DE(DW)="C7^RTCR"
 S DU="RTV(195.9,"
 S X=$P(RTINIT,U,5)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z
C7 G C7S:$D(DE(7))[0 K DB S X=DE(7),DIC=DIE
 K ^RT("ABOR",$E(X,1,30),DA)
 S X=DE(7),DIC=DIE
 ;
C7S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^RT("ABOR",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 X "Q:'$D(^RT(DA,""CL""))!('$D(^(0)))  Q:X=$P(^(0),""^"",6)!('$P(^(""CL""),""^"",6))  S ^RT(""AC"",+$P(^(""CL""),""^"",6),DA)="""""
 Q
X7 Q
8 D:$D(DG)>9 F^DIE17 G ^RTCR1
