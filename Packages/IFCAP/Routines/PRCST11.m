PRCST11 ; ;10/27/00
 D DE G BEGIN
DE S DIE="^PRCS(410,",DIC=DIE,DP=410,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRCS(410,DA,""))=""
 I $D(^(2)) S %Z=^(2) S %=$P(%Z,U,8) S:%]"" DE(1)=% S %=$P(%Z,U,9) S:%]"" DE(2)=% S %=$P(%Z,U,10) S:%]"" DE(3)=%
 I $D(^(4)) S %Z=^(4) S %=$P(%Z,U,1) S:%]"" DE(8)=% S %=$P(%Z,U,2) S:%]"" DE(10)=%
 I $D(^(7)) S %Z=^(7) S %=$P(%Z,U,1) S:%]"" DE(16)=% S %=$P(%Z,U,3) S:%]"" DE(18)=% S %=$P(%Z,U,5) S:%]"" DE(20)=%
 I $D(^(9)) S %Z=^(9) S %=$P(%Z,U,1) S:%]"" DE(14)=%
 I $D(^(14)) S %Z=^(14) S %=$P(%Z,U,1) S:%]"" DE(21)=%
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
BEGIN S DNM="PRCST11",DQ=1
1 S DW="2;8",DV="FX",DU="",DLB="VENDOR ZIP CODE",DIFLD=11.7
 G RE
X1 K:$L(X)<5!(X'?5N.ANP)!($L(X)>5&(X'?5N1"-"4N)) X
 I $D(X),X'?.ANP K X
 Q
 ;
2 S DW="2;9",DV="F",DU="",DLB="VENDOR CONTACT",DIFLD=11.8
 G RE
X2 K:$L(X)>30!($L(X)<3)!'(X?.ANP) X
 I $D(X),X'?.ANP K X
 Q
 ;
3 S DW="2;10",DV="F",DU="",DLB="VENDOR PHONE NO.",DIFLD=11.9
 G RE
X3 K:$L(X)>18!($L(X)<3)!'(X?.ANP) X
 I $D(X),X'?.ANP K X
 Q
 ;
4 S DQ=5 ;@1
5 S D=0 K DE(1) ;10
 S DIFLD=10,DGO="^PRCST12",DC="22^410.02AI^IT^",DV="410.02MRNJ3,0",DW="0;1",DOW="LINE ITEM NUMBER",DLB="Select "_DOW S:D DC=DC_D
 G RE:D I $D(DSC(410.02))#2,$P(DSC(410.02),"I $D(^UTILITY(",1)="" X DSC(410.02) S D=$O(^(0)) S:D="" D=-1 G M5
 S D=$S($D(^PRCS(410,DA,"IT",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M5 I D>0 S DC=DC_D I $D(^PRCS(410,DA,"IT",+D,0)) S DE(5)=$P(^(0),U,1)
 G RE
R5 D DE
 S D=$S($D(^PRCS(410,DA,"IT",0)):$P(^(0),U,3,4),1:1) G 5+1
 ;
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 D EX1^PRCSCK,^PRCSCK
 Q
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 I $D(PRCSERR),PRCSERR S Y="@1" K PRCSERR,PRCSF,PRCSI
 Q
8 S DW="4;1",DV="RNJ10,2X",DU="",DLB="COMMITTED (ESTIMATED) COST",DIFLD=20
 S DE(DW)="C8^PRCST11"
 G RE
C8 G C8S:$D(DE(8))[0 K DB
 S X=DE(8),DIC=DIE
 X "Q:$P(^PRCS(410,DA,4),U,3)'=""""  S $P(^(4),""^"",8)="""" D TRANK^PRCSES"
C8S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 X "Q:$P(^PRCS(410,DA,4),U,3)'=""""  S $P(^(4),""^"",8)=X D TRANS^PRCSES"
 Q
X8 S:X["$" X=$P(X,"$",2) K:+X'=X&(X'?.N1"."2N)!(X>9999999)!(X<0) X I $D(X) W "  $ ",$J(X,0,2)
 Q
 ;
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 G A
10 D:$D(DG)>9 F^DIE17,DE S DQ=10,DW="4;2",DV="RD",DU="",DLB="DATE COMMITTED",DIFLD=21
 S Y="TODAY"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X10 S %DT="X" D ^%DT S X=Y K:Y<1 X
 Q
 ;
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 I $D(PRCSJP) S Y=46
 Q
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 D RB^PRCSCK
 Q
13 S D=0 K DE(1) ;16
 S DIFLD=16,DGO="^PRCST13",DC="3^410.04P^12^",DV="410.04M*P410.4X",DW="0;1",DOW="SUB-CONTROL POINT",DLB="Select "_DOW S:D DC=DC_D
 S DU="PRCS(410.4,"
 G RE:D I $D(DSC(410.04))#2,$P(DSC(410.04),"I $D(^UTILITY(",1)="" X DSC(410.04) S D=$O(^(0)) S:D="" D=-1 G M13
 S D=$S($D(^PRCS(410,DA,12,0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M13 I D>0 S DC=DC_D I $D(^PRCS(410,DA,12,+D,0)) S DE(13)=$P(^(0),U,1)
 G RE
R13 D DE
 S D=$S($D(^PRCS(410,DA,12,0)):$P(^(0),U,3,4),1:1) G 13+1
 ;
14 S DW="9;1",DV="FX",DU="",DLB="DELIVER TO/LOCATION",DIFLD=46
 G RE
X14 K:$L(X)>30!($L(X)<3)!(X'?.ANP) X
 I $D(X),X'?.ANP K X
 Q
 ;
15 S D=0 K DE(1) ;45
 S Y="JUSTIFICATION^W^^0;1^Q",DG="8",DC="^410.06" D DIEN^DIWE K DE(1) G A
 ;
16 S DW="7;1",DV="P200'X",DU="",DLB="REQUESTOR",DIFLD=40
 S DE(DW)="C16^PRCST11"
 S DU="VA(200,"
 G RE
C16 G C16S:$D(DE(16))[0 K DB
 S X=DE(16),DIC=DIE
 S $P(^PRCS(410,DA,7),"^",2)=""
C16S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 I $D(^VA(200,X,20)),$P(^(20),"^",3)'="" S $P(^PRCS(410,DA,7),"^",2)=$P(^VA(200,X,20),"^",3)
 Q
X16 I $D(^PRC(411,PRC("SITE"),8,X)) K X Q
 Q
 ;
17 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=17 D X17 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X17 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),$P(^(0),"^",11)="Y" S Y=68
 Q
18 D:$D(DG)>9 F^DIE17,DE S DQ=18,DW="7;3",DV="P200'",DU="",DLB="APPROVING OFFICIAL",DIFLD=42
 S DE(DW)="C18^PRCST11"
 S DU="VA(200,"
 G RE
C18 G C18S:$D(DE(18))[0 K DB
 S X=DE(18),DIC=DIE
 S $P(^PRCS(410,DA,7),"^",4)=""
C18S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 I $D(^VA(200,X,20)),$P(^(20),"^",3)'="" S $P(^PRCS(410,DA,7),"^",4)=$P(^VA(200,X,20),"^",3)
 Q
X18 Q
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 G A
20 D:$D(DG)>9 F^DIE17,DE S DQ=20,DW="7;5",DV="D",DU="",DLB="DATE SIGNED (APPROVED)",DIFLD=44
 S Y="TODAY"
 G Y
X20 S %DT="EX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
21 S DW="14;1",DV="P200'",DU="",DLB="ORIGINATOR OF REQUEST",DIFLD=68
 S DU="VA(200,"
 G RE
X21 Q
22 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=22 D X22 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X22 K PRCSJP,PRCSTDT,PRCSSUB
 Q
23 S D=0 K DE(1) ;60
 S Y="COMMENTS^W^^0;1^Q",DG="CO",DC="^410.05" D DIEN^DIWE K DE(1) G A
 ;
24 G 0^DIE17
