DVBHCE6 ; ;07/06/22
 D DE G BEGIN
DE S DIE="^DPT(D0,""E"",",DIC=DIE,DP=2.0361,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^DPT(D0,"E",DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,1) S:%]"" DE(1)=%
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
T G M^DIE17:DV,^DIE3:DV["V",X:X'?.ANP
 I DV["t" D  G UNIQ ;EXTENSIBLE DATA TYPES ;p21
 .X $S($D(DB(DQ)):$$VALEXTS^DIETLIBF(DP,DIFLD),1:$$VALEXT^DIETLIBF(DP,DIFLD)) K DIPA
 I DV["S" D SET^DIED G V:'DDER K DDER G X ;p22
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
 I DG["t" X $$OUTPUT^DIETLIBF(DP,DIFLD) K DIPA G RP ;p21
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
BEGIN S DNM="DVBHCE6",DQ=1+D G B
1 S DW="0;1",DV="M*P8'X#",DU="",DIFLD=.01,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C1^DVBHCE6"
 S DU="DIC(8,"
 G RE:'D S DQ=2 G 2
C1 G C1S:$D(DE(1))[0 K DB
 S X=DE(1),DIC=DIE
 K ^DPT(DA(1),"E","B",$E(X,1,30),DA)
 S X=DE(1),DIC=DIE
 K ^DPT("AEL",DA(1),+X) I X=$$FIND1^DIC(8,"","B","COLLATERAL OF VET") D ARCHALL^DGRP1152U(DA(1))
 S X=DE(1),DIC=DIE
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DPT(D0,"E",D1,0)):^(0),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" S DIH=$G(^DPT(DIV(0),"E",DIV(1),0)),DIV=X S $P(^(0),U,3)=DIV,DIH=2.0361,DIG=.03 D ^DICR
 S X=DE(1),DIC=DIE
 X "S DFN=DA(1) D EN^DGMTR K DGREQF"
 S X=DE(1),DIC=DIE
 D AUTOUPD^DGENA2(DA(1))
C1S S X="" G:DG(DQ)=X C1F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^DPT(DA(1),"E","B",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 S ^DPT("AEL",DA(1),+X)=""
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DPT(D0,"E",D1,0)):^(0),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y X ^DD(2.0361,.01,1,3,1.1) X ^DD(2.0361,.01,1,3,1.4)
 S X=DG(DQ),DIC=DIE
 X "S DFN=DA(1) D EN^DGMTR K DGREQF"
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA(1))
C1F1 Q
X1 S DIC("S")="I '$P(^(0),U,7),$S($P(^(0),U,8):1,'$D(^DPT(D0,.36)):0,1:Y=+^(.36)),$$ELGCHK^DGRPTU(D0),$$HUDCK^DGLOCK1(Y)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X I $D(X) S DINUM=X
 Q
 ;
2 G 1^DIE17
