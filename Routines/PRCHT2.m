PRCHT2 ; GENERATED FROM 'PRCHPUSH' INPUT TEMPLATE(#749), FILE 442;10/27/00
 D DE G BEGIN
DE S DIE="^PRC(442,",DIC=DIE,DP=442,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRC(442,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,2) S:%]"" DE(2)=% S %=$P(%Z,U,3) S:%]"" DE(11)=%
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,1) S:%]"" DE(6)=% S %=$P(%Z,U,2) S:%]"" DE(15)=% S %=$P(%Z,U,3) S:%]"" DE(19)=% S %=$P(%Z,U,7) S:%]"" DE(9)=% S %=$P(%Z,U,11) S:%]"" DE(17)=% S %=$P(%Z,U,15) S:%]"" DE(3)=% S %=$P(%Z,U,17) S:%]"" DE(4)=%
 I  S %=$P(%Z,U,18) S:%]"" DE(5)=%
 I $D(^(18)) S %Z=^(18) S %=$P(%Z,U,10) S:%]"" DE(8)=%
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
BEGIN S DNM="PRCHT2",DQ=1
 N DIEZTMP,DIEZAR,DIEZRXR,DIIENS,DIXR K DIEFIRE,DIEBADK S DIEZTMP=$$GETTMP^DIKC1("DIEZ")
 M DIEZAR=^DIE(749,"AR") S DICRREC="TRIG^DIE17"
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIIENS=DA_",",DIEZ=749,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 S (PRCHN("SVC"),PRCHN("SC"),PRCHNRQ)="",PRCHN("MP")=5,PRCHN("SFC")=+$P(^PRC(442,DA,0),U,19) I $D(^PRC(442,DA,1)),$D(^PRCD(420.8,+$P(^(1),U,7),0)) S PRCHN("SC")=$P(^(0),U,1)
 Q
2 S DW="0;2",DV="R*P442.5'X",DU="",DLB="METHOD OF PROCESSING",DIFLD=.02
 S DE(DW)="C2^PRCHT2"
 S DU="PRCD(442.5,"
 S X=8
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C2 G C2S:$D(DE(2))[0 K DB
 S X=DE(2),DIC=DIE
 K ^PRC(442,"F",$E(X,1,30),DA)
C2S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 S ^PRC(442,"F",$E(X,1,30),DA)=""
 Q
X2 Q
3 D:$D(DG)>9 F^DIE17,DE S DQ=3,DW="1;15",DV="RDX",DU="",DLB="P.O. DATE",DIFLD=.1
 S DE(DW)="C3^PRCHT2"
 G RE
C3 G C3S:$D(DE(3))[0 K DB
 S X=DE(3),DIC=DIE
 K ^PRC(442,"AB",$E(X,1,30),DA)
C3S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 S ^PRC(442,"AB",$E(X,1,30),DA)=""
 Q
X3 S %DT="EX" D ^%DT S X=Y K:Y<1 X I $D(X) D EN1^PRCHNPO6
 Q
 ;
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="1;17",DV="S",DU="",DLB="EMERGENCY ORDER?",DIFLD=.2
 S DU="Y:YES;N:NO;"
 S X="N"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X4 Q
5 S DW="1;18",DV="RS",DU="",DLB="EXPENDABLE/NONEXPENDABLE",DIFLD=.3
 S DU="E:EXPENDABLE;N:NON-EXPENDABLE;"
 S X="E"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X5 Q
6 S DW="1;1",DV="R*P440X",DU="",DLB="VENDOR",DIFLD=5
 S DE(DW)="C6^PRCHT2"
 S DU="PRC(440,"
 G RE
C6 G C6S:$D(DE(6))[0 K DB
 S X=DE(6),DIC=DIE
 K ^PRC(442,"D",$E(X,1,30),DA)
C6S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 S ^PRC(442,"D",$E(X,1,30),DA)=""
 Q
X6 D EN3^PRCHNPO5
 Q
 ;
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 S:PRCHN("SC")'=1 Y=8
 Q
8 D:$D(DG)>9 F^DIE17,DE S DQ=8,DW="18;10",DV="RFX",DU="",DLB="REQUISITION NO.(SUPPLY)",DIFLD=102.4
 S DE(DW)="C8^PRCHT2"
 G RE
C8 G C8S:$D(DE(8))[0 K DB
 S X=DE(8),DIC=DIE
 K ^PRC(442,"K",$E(X,1,30),DA)
C8S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 S ^PRC(442,"K",$E(X,1,30),DA)=""
 Q
X8 K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>10!($L(X)<9)!'((X?3N1"-"3N1"-"2N)!(X?3N1"-"5UN)) X I $D(X) K:+X'=+^PRC(442,DA,0) X
 I $D(X),X'?.ANP K X
 Q
 ;
9 D:$D(DG)>9 F^DIE17,DE S DQ=9,DW="1;7",DV="R*P420.8'",DU="",DLB="SOURCE CODE",DIFLD=8
 S DU="PRCD(420.8,"
 S X=PRCHN("SC")
 S Y=X
 G Y
X9 S DIC("S")="I "_$S($D(PRCHPUSH):"""13""[$E(^(0))",$D(PRCHNRQ):"""1390""[$E(^(0))",1:"""2456789B""[$E(^(0))") D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S PRCHN("SC")=$S($D(^PRCD(420.8,+X,0)):$P(^(0),U,1),1:"") K DIC("DR")
 Q
11 S DW="0;3",DV="RFX",DU="",DLB="FCP",DIFLD=1
 S DE(DW)="C11^PRCHT2"
 G RE
C11 G C11S:$D(DE(11))[0 K DB
 S X=DE(11),DIC=DIE
 K ^PRC(442,"E",$P(X," ",1),DA)
 S X=DE(11),DIC=DIE
 S $P(^PRC(442,DA,0),U,19)="",$P(^(17),U,1)=""
C11S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 S ^PRC(442,"E",$P(X," ",1),DA)=""
 S X=DG(DQ),DIC=DIE
 I $D(^PRC(420,+^PRC(442,DA,0),1,+X,0)) S Z=^(0) S:$P(Z,U,12) $P(^PRC(442,DA,0),U,19)=$P(Z,U,12) S:$P(Z,U,18) $P(^PRC(442,DA,17),U,1)=$E($P(Z,U,18),1,3) K Z
 Q
X11 K:X[""""!($A(X)=45) X I $D(X) K:'$D(PRC("SITE"))!('$D(^PRC(442,DA,1))) X Q:'$D(X)  S:$P(^(1),U,15)]"" PRC("FY")=$P(^(1),U,15) D EN1^PRCHNPO5 Q:'$D(X)  S $P(^PRC(442,DA,0),U,4)=PRC("APP")
 I $D(X),X'?.ANP K X
 Q
 ;
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 G A
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 S PRCHN("SFC")=$P(^PRC(442,DA,0),U,19)
 Q
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 G A
15 D:$D(DG)>9 F^DIE17,DE S DQ=15,DW="1;2",DV="RP49'",DU="",DLB="REQUESTING SERVICE",DIFLD=5.2
 S DU="DIC(49,"
 S X=PRCHN("SVC")
 S Y=X
 G Y
X15 Q
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 G A
17 S DW="1;11",DV="F",DU="",DLB="DELIVERY LOCATION",DIFLD=5.6
 G RE
X17 K:$L(X)>20!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 I X="PATIENT" W *7,"No Patient Deliveries allowed from Federal Sources." S Y=5.6
 Q
19 S DW="1;3",DV="NJ5,0XO",DU="",DLB="SHIP TO",DIFLD=5.4
 S DQ(19,2)="S Y(0)=Y Q:Y']""""  S Z0=$S($P($G(^PRC(442,D0,23)),U,7)]"""":$P($G(^PRC(442,D0,23)),U,7),1:$E($G(^PRC(442,D0,0)),1,3)) Q:'Z0  S Y=$P($S($D(^PRC(411,Z0,1,Y,0)):^(0),1:""""),U,1) K Z0"
 S X=1
 S Y=X
 G Y
X19 S Z0=$S($P($G(^PRC(442,D0,23)),U,7)]"":$P($G(^PRC(442,D0,23)),U,7),1:$E($G(^PRC(442,D0,0)),1,3)) K:'Z0 X Q:'Z0  S DIC="^PRC(411,Z0,1,",DIC(0)="QEM" D ^DIC S X=+Y K:Y'>0 X K Z0,DIC
 Q
 ;
20 D:$D(DG)>9 F^DIE17 G ^PRCHT21
