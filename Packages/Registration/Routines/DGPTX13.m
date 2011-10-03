DGPTX13 ; ;07/14/09
 D DE G BEGIN
DE S DIE="^DPT(D0,.06,",DIC=DIE,DP=2.06,DL=3,DIEL=1,DU="" K DG,DE,DB Q:$O(^DPT(D0,.06,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,1) S:%]"" DE(1)=% S %=$P(%Z,U,2) S:%]"" DE(3)=%
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
N I X="" G NKEY:$D(^DD("KEY","F",DP,DIFLD)),A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) I X?.ANP D SET I 'DDER X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
 K DDER G X
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) G:DV["*" AST^DIED D NOSCR^DIED S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V D @("X"_DQ) K YS
Z K DIC("S"),DLAYGO I $D(X),X'=U D:$G(DE(DW,"INDEX")) SAVEVALS G:'$$KEYCHK UNIQFERR^DIE17 S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
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
SAVEVALS S @DIEZTMP@("V",DP,DIIENS,DIFLD,"O")=$G(DE(DQ)) S:$D(^("F"))[0 ^("F")=$G(DE(DQ))
 I $D(DE(DW,"4/")) S @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")=""
 E  K @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")
 Q
NKEY W:'$D(ZTQUEUED) "??  Required key field" S X="?BAD" G QS
KEYCHK() Q:$G(DE(DW,"KEY"))="" 1 Q @DE(DW,"KEY")
BEGIN S DNM="DGPTX13",DQ=1+D G B
1 S DW="0;1",DV="*P10.2'X#",DU="",DLB="ETHNICITY",DIFLD=.01
 S DE(DW)="C1^DGPTX13",DE(DW,"INDEX")=1
 S DU="DIC(10.2,"
 G RE:'D S DQ=2 G 2
C1 G C1S:$D(DE(1))[0 K DB
 S X=DE(1),DIC=DIE
 K ^DPT(DA(1),.06,"B",$E(X,1,30),DA)
 S X=DE(1),DIC=DIE
 ;
C1S S X="" G:DG(DQ)=X C1F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^DPT(DA(1),.06,"B",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 X ^DD(2.06,.01,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.06,D1,0)):^(0),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=+$O(^DIC(10.3,"C","S",0)) S:X=0 X="" X ^DD(2.06,.01,1,2,1.4)
C1F1 N X,X1,X2 S DIXR=195 D C1X1(U) K X2 M X2=X D C1X1("O") K X1 M X1=X
 K X M X=X2 D
 . N DGFDA,DGMSG,DGD0,DGD1,DGLOOP S DGD0=DA(1),DGD1=DA S DGLOOP=0 F  S DGLOOP=$O(^DPT(DGD0,.06,DGLOOP)) Q:'DGLOOP  I DGLOOP'=DGD1 S DGFDA(2.06,DGLOOP_","_DGD0_",",.01)="@" D FILE^DIE("","DGFDA","DGMSG") K DGFDA,DGMSG
 G C1F2
C1X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",2.06,DIIENS,.01,DION),$P($G(^DPT(DA(1),.06,DA,0)),U,1))
 S X=$G(X(1))
 Q
C1F2 S DIXR=399 D C1X2(U) K X2 M X2=X D C1X2("O") K X1 M X1=X
 D
 . D FC^DGFCPROT(.DA,2.06,.01,"KILL",$H,$G(DUZ),.X,.X1,.X2,$G(XQY0)) Q
 K X M X=X2 D
 . D FC^DGFCPROT(.DA,2.06,.01,"SET",$H,$G(DUZ),.X,.X1,.X2,$G(XQY0)) Q
 G C1F3
C1X2(DION) K X
 S X(1)=$G(@DIEZTMP@("V",2.06,DIIENS,.01,DION),$P($G(^DPT(DA(1),.06,DA,0)),U,1))
 S X=$G(X(1))
 Q
C1F3 Q
X1 S DIC("S")="I '$G(^(.02))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X S:$D(X) DINUM=X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 I $P($G(^DIC(10.3,+$P($G(^DPT(DA(1),.06,DA,0)),"^",2),0)),"^",2)="S" S Y="@61"
 Q
3 D:$D(DG)>9 F^DIE17,DE S DQ=3,DW="0;2",DV="RP10.3'",DU="",DLB="METHOD OF COLLECTION",DIFLD=.02
 S DU="DIC(10.3,"
 G RE
X3 Q
4 S DQ=5 ;@61
5 G 1^DIE17
