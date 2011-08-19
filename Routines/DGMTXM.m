DGMTXM ; GENERATED FROM 'DGMT ENTER/EDIT MARITAL STATUS' INPUT TEMPLATE(#467), FILE 408.22;06/13/96
 D DE G BEGIN
DE S DIE="^DGMT(408.22,",DIC=DIE,DP=408.22,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DGMT(408.22,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,5) S:%]"" DE(5)=% S %=$P(%Z,U,6) S:%]"" DE(7)=%
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
BEGIN S DNM="DGMTXM",DQ=1
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIEZ=467,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 K DGFIN
 Q
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 I '$D(DFN)!('$D(DGDR)) W !,*7,"Variables DFN and DGDR must be defined!" S Y="@999"
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 S:DGDR'["101" Y="@102"
 Q
4 S DQ=5 ;@101
5 S DW="0;5",DV="RSXR",DU="",DLB="WAS YOUR MARITAL STATUS EITHER MARRIED OR SEPARATED ON DEC 31ST LAST YEAR",DIFLD=.05
 S DE(DW)="C5^DGMTXM"
 S DU="1:YES;0:NO;"
 S X=$S("^2^5^"[(U_$S($D(^DPT(DFN,0)):$P(^(0),U,5),1:"")_U)!($D(DGREL("S"))):"YES",1:"NO")
 S Y=X
 G Y
C5 G C5S:$D(DE(5))[0 K DB S X=DE(5),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X X ^DD(408.22,.05,1,1,79.2) S X=X="" I X S X=DIV S Y(1)=$S($D(^DGMT(408.22,D0,0)):^(0),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X="" X ^DD(408.22,.05,1,1,2.4)
 S X=DE(5),DIC=DIE
 I $D(^DGMT(408.22,DA,0)),$P(^(0),U,5)="" D FUN^DGMTDD2:'$P(^(0),U,8),SP^DGMTDD2
C5S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 X ^DD(408.22,.05,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DGMT(408.22,D0,0)):^(0),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X="" X ^DD(408.22,.05,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 I $D(^DGMT(408.22,DA,0)),$P(^(0),U,5) D FUN^DGMTDD2:'$P(^(0),U,8),SP^DGMTDD2
 Q
X5 D MAR^DGMTDD2:'X
 Q
 ;
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S:'X Y="@102"
 Q
7 D:$D(DG)>9 F^DIE17,DE S DQ=7,DW="0;6",DV="SXR",DU="",DLB="DID YOU LIVE WITH YOUR SPOUSE LAST YEAR",DIFLD=.06
 S DE(DW)="C7^DGMTXM"
 S DU="1:YES;0:NO;"
 G RE
C7 G C7S:$D(DE(7))[0 K DB S X=DE(7),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X X ^DD(408.22,.06,1,1,79.2) S X=X="" I X S X=DIV S Y(1)=$S($D(^DGMT(408.22,D0,0)):^(0),1:"") S X=$P(Y(1),U,7),X=X S DIU=X K Y S X="" X ^DD(408.22,.06,1,1,2.4)
 S X=DE(7),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X X ^DD(408.22,.06,1,2,79.2) S X=X="" I X S X=DIV S Y(1)=$S($D(^DGMT(408.22,D0,0)):^(0),1:"") S X=$P(Y(1),U,10),X=X S DIU=X K Y S X="" X ^DD(408.22,.06,1,2,2.4)
C7S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 X ^DD(408.22,.06,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DGMT(408.22,D0,0)):^(0),1:"") S X=$P(Y(1),U,7),X=X S DIU=X K Y S X="" X ^DD(408.22,.06,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 X ^DD(408.22,.06,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DGMT(408.22,D0,0)):^(0),1:"") S X=$P(Y(1),U,10),X=X S DIU=X K Y S X="" X ^DD(408.22,.06,1,2,1.4)
 Q
X7 D LIV^DGMTDD2
 Q
 ;
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 S:X Y="@102"
 Q
9 D:$D(DG)>9 F^DIE17 G ^DGMTXM1
