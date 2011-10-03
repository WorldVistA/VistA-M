IBDX961 ; ;05/01/97
 D DE G BEGIN
DE S DIE="^IBD(357.96,",DIC=DIE,DP=357.96,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^IBD(357.96,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,9) S:%]"" DE(1)=% S %=$P(%Z,U,10) S:%]"" DE(2)=% S %=$P(%Z,U,11) S:%]"" DE(3)=% S %=$P(%Z,U,14) S:%]"" DE(5)=%
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
BEGIN S DNM="IBDX961",DQ=1
1 S DW="0;9",DV="F",DU="",DLB="EXTERNAL PRINTED FORM ID",DIFLD=.09
 S DE(DW)="C1^IBDX961"
 S X=EXID
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 K ^IBD(357.96,"AEXT",$E(X,1,30),DA)
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^IBD(357.96,"AEXT",$E(X,1,30),DA)=""
 Q
X1 Q
2 D:$D(DG)>9 F^DIE17,DE S DQ=2,DW="0;10",DV="P44'",DU="",DLB="CLINIC",DIFLD=.1
 S DU="SC("
 S X=$G(CLIN)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X2 Q
3 S DW="0;11",DV="S",DU="",DLB="PROCESSING STATUS",DIFLD=.11
 S DU="1:PRINTED;2:SCANNED;3:SCANNED TO PCE;4:SCANNED W/PCE ERROR;5:DATA ENTRY;6:DATA ENTRY TO PCE;7:DATA ENTRY W/PCE ERROR;11:PENDING PAGES;12:ERROR DETECTED,NOT TRANSMITTED;20:AVAILABLE FOR DATA ENTRY;"
 S Y="1"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X3 Q
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 I $G(^DPT(DFN,"S",APPT,0)) S Y="@99"
 Q
5 S DW="0;14",DV="S",DU="",DLB="NO APPOINTMENT ENTRY",DIFLD=.14
 S DE(DW)="C5^IBDX961"
 S DU="0:APPOINTMENT EXISTS;1:NO APPOINTMENT ENTRY;"
 S Y="1"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C5 G C5S:$D(DE(5))[0 K DB S X=DE(5),DIC=DIE
 K ^IBD(357.96,"AN",$E(X,1,30),DA)
 S X=DE(5),DIC=DIE
 K ^IBD(357.96,"ADATNA",+$P(^IBD(357.96,DA,0),"^",3),X,DA)
C5S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^IBD(357.96,"AN",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 S:+$P(^IBD(357.96,DA,0),"^",3)'="" ^IBD(357.96,"ADATNA",$P(^IBD(357.96,DA,0),"^",3),X,DA)=""
 Q
X5 Q
6 S DQ=7 ;@99
7 G 0^DIE17
