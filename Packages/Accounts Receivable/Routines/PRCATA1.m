PRCATA1 ; ;01/18/23
 D DE G BEGIN
DE S DIE="^PRCA(430,D0,2,",DIC=DIE,DP=430.01,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^PRCA(430,D0,2,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,1) S:%]"" DE(1)=% S %=$P(%Z,U,2) S:%]"" DE(4)=% S %=$P(%Z,U,4) S:%]"" DE(2)=% S %=$P(%Z,U,8) S:%]"" DE(3)=%
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
BEGIN S DNM="PRCATA1",DQ=1+D G B
1 S DW="0;1",DV="MRFX#",DU="",DIFLD=.01,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C1^PRCATA1"
 G RE:'D S DQ=2 G 2
C1 G C1S:$D(DE(1))[0 K DB
 S X=DE(1),DIC=DIE
 K ^PRCA(430,DA(1),2,"B",$E(X,1,30),DA)
C1S S X="" G:DG(DQ)=X C1F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^PRCA(430,DA(1),2,"B",$E(X,1,30),DA)=""
C1F1 Q
X1 K:X'?2N X I $D(X) S DINUM=$S(+X<70:"3"_X,1:"2"_X)
 I $D(X),X'?.ANP K X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S DQ=2,DW="0;4",DV="FX",DU="",DIFLD=3,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C2^PRCATA1"
 G RE
C2 G C2S:$D(DE(2))[0 K DB
 S X=DE(2),DIC=DIE
 ;
C2S S X="" G:DG(DQ)=X C2F1 K DB
 S X=DG(DQ),DIC=DIE
 S Z0=$P(^PRCA(430,DA(1),2,DA,0),U,4) S:$E(Z0,3)?1N Z0=$E(Z0,1,2)_" "_$E(Z0,4,7) S $P(^PRCA(430,DA(1),0),U,18)=Z0 K Z0
C2F1 Q
X2 K:X[""""!($A(X)=45) X I $D(X) D EN1^PRCHPAT
 I $D(X),X'?.ANP K X
 Q
 ;
3 D:$D(DG)>9 F^DIE17,DE S DQ=3,DW="0;8",DV="RNJ12,2",DU="",DIFLD=7,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C3^PRCATA1"
 G RE
C3 G C3S:$D(DE(3))[0 K DB
 S X=DE(3),DIC=DIE
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^PRCA(430,D0,2,D1,0)):^(0),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y X ^DD(430.01,7,1,1,2.1) X ^DD(430.01,7,1,1,2.4)
C3S S X="" G:DG(DQ)=X C3F1 K DB
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^PRCA(430,D0,2,D1,0)):^(0),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=DIU+DIV X ^DD(430.01,7,1,1,1.4)
C3F1 Q
X3 S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>999999999.99)!(X<0) X
 Q
 ;
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="0;2",DV="RNJ9,2",DU="",DIFLD=1,DLB="CURRENT PRIN. BAL. FOR THIS FISCAL YEAR"
 G RE
X4 S:X["$" X=$P(X,"$",2) K:X'?."-".N.1".".2N!(X>999999.99)!(X<-9999.99) X
 Q
 ;
5 G 1^DIE17
