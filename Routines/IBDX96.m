IBDX96 ; GENERATED FROM 'IBD CREATE FORM TRACKING' INPUT TEMPLATE(#1477), FILE 357.96;05/01/97
 D DE G BEGIN
DE S DIE="^IBD(357.96,",DIC=DIE,DP=357.96,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^IBD(357.96,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,2) S:%]"" DE(1)=% S %=$P(%Z,U,3) S:%]"" DE(2)=% S %=$P(%Z,U,4) S:%]"" DE(3)=% S %=$P(%Z,U,5) S:%]"" DE(4)=% S %=$P(%Z,U,7) S:%]"" DE(5)=% S %=$P(%Z,U,8) S:%]"" DE(6)=%
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
BEGIN S DNM="IBDX96",DQ=1
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIEZ=1477,U="^"
1 S DW="0;2",DV="RP2'",DU="",DLB="PATIENT",DIFLD=.02
 S DE(DW)="C1^IBDX96"
 S DU="DPT("
 S X=DFN
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 K ^IBD(357.96,"C",$E(X,1,30),DA)
 S X=DE(1),DIC=DIE
 K ^IBD(357.96,"APTAP",X,+$P($G(^IBD(357.96,DA,0)),"^",3),DA)
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^IBD(357.96,"C",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 S:$P($G(^IBD(357.96,DA,0)),"^",3) ^IBD(357.96,"APTAP",X,+$P(^IBD(357.96,DA,0),"^",3),DA)=""
 Q
X1 Q
2 D:$D(DG)>9 F^DIE17,DE S DQ=2,DW="0;3",DV="D",DU="",DLB="APPOINTMENT",DIFLD=.03
 S DE(DW)="C2^IBDX96"
 S X=APPT
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C2 G C2S:$D(DE(2))[0 K DB S X=DE(2),DIC=DIE
 K ^IBD(357.96,"APTAP",+$P($G(^IBD(357.96,DA,0)),"^",2),DA)
 S X=DE(2),DIC=DIE
 K ^IBD(357.96,"D",$E(X,1,30),DA)
 S X=DE(2),DIC=DIE
 K ^IBD(357.96,"ADATNA",X,+$P(^IBD(357.96,DA,0),"^",14),DA)
C2S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S:$P($G(^IBD(357.96,DA,0)),"^",2) ^IBD(357.96,"APTAP",+$P(^IBD(357.96,DA,0),"^",2),X,DA)=""
 S X=DG(DQ),DIC=DIE
 S ^IBD(357.96,"D",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 S:$P(^IBD(357.96,DA,0),"^",14)'="" ^IBD(357.96,"ADATNA",X,$P(^(0),"^",14),DA)=""
 Q
X2 Q
3 D:$D(DG)>9 F^DIE17,DE S DQ=3,DW="0;4",DV="P357.95'",DU="",DLB="FORM TYPE",DIFLD=.04
 S DE(DW)="C3^IBDX96"
 S DU="IBD(357.95,"
 S X=$S(INTERNAL:FORMTYPE,1:"")
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C3 G C3S:$D(DE(3))[0 K DB S X=DE(3),DIC=DIE
 K ^IBD(357.96,"A",+X,DA)
 S X=DE(3),DIC=DIE
 K ^IBD(357.96,"AC",$E(X,1,30),DA)
C3S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S:'(+$P($G(^IBD(357.96,DA,0)),"^",6)) ^IBD(357.96,"A",+X,DA)=""
 S X=DG(DQ),DIC=DIE
 S ^IBD(357.96,"AC",$E(X,1,30),DA)=""
 Q
X3 Q
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="0;5",DV="D",DU="",DLB="DATE/TIME PRINTED",DIFLD=.05
 S X=$$NOW^XLFDT
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X4 Q
5 S DW="0;7",DV="RS",DU="",DLB="SOURCE OF FORM ID",DIFLD=.07
 S DU="1:IB;2:PANDAS;3:TELEFORM;4:PEN;5:WORKSTATION;99:OTHER;"
 S X=SOURCE
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X5 Q
6 S DW="0;8",DV="F",DU="",DLB="FORM TYPE ID (EXTERNAL SOURCE)",DIFLD=.08
 S X=$S('INTERNAL:FORMTYPE,1:"")
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X6 Q
7 D:$D(DG)>9 F^DIE17 G ^IBDX961
