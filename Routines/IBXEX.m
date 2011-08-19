IBXEX ; GENERATED FROM 'IB NEW EXEMPTION' INPUT TEMPLATE(#516), FILE 354.1;10/25/02
 D DE G BEGIN
DE S DIE="^IBA(354.1,",DIC=DIE,DP=354.1,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^IBA(354.1,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,2) S:%]"" DE(2)=% S %=$P(%Z,U,3) S:%]"" DE(3)=% S %=$P(%Z,U,4) S:%]"" DE(4)=% S %=$P(%Z,U,5) S:%]"" DE(5)=% S %=$P(%Z,U,6) S:%]"" DE(6)=% S %=$P(%Z,U,7) S:%]"" DE(7)=% S %=$P(%Z,U,8) S:%]"" DE(9)=%
 I  S %=$P(%Z,U,10) S:%]"" DE(10)=% S %=$P(%Z,U,11) S:%]"" DE(11)=% S %=$P(%Z,U,15) S:%]"" DE(13)=%
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
BEGIN S DNM="IBXEX",DQ=1
 N DIEZTMP,DIEZAR,DIEZRXR,DIIENS,DIXR K DIEFIRE,DIEBADK S DIEZTMP=$$GETTMP^DIKC1("DIEZ")
 M DIEZAR=^DIE(516,"AR") S DICRREC="TRIG^DIE17"
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIIENS=DA_",",DIEZ=516,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 I '$D(DFN)!('$D(IBTYPE))!('$D(IBSTAT))!('$D(IBEXREA)) S Y="@99"
 Q
2 S DW="0;2",DV="RP354'I",DU="",DLB="PATIENT",DIFLD=.02
 S DE(DW)="C2^IBXEX"
 S DU="IBA(354,"
 S X=DFN
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C2 G C2S:$D(DE(2))[0 K DB
 S X=DE(2),DIC=DIE
 K ^IBA(354.1,"AP",$E(X,1,30),DA)
 S X=DE(2),DIC=DIE
 K ^IBA(354.1,"AIVDT",+$P(^IBA(354.1,DA,0),"^",3),+X,-($P(^(0),U)),DA)
 S X=DE(2),DIC=DIE
 K ^IBA(354.1,"C",$E(X,1,30),DA)
 S X=DE(2),DIC=DIE
 K ^IBA(354.1,"APIDT",+X,+$P(^IBA(354.1,DA,0),U,3),-($P(^(0),U)),DA)
 S X=DE(2),DIC=DIE
 K ^IBA(354.1,"ACAN",X,-$P(^IBA(354.1,DA,0),"^",14),DA)
C2S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 S ^IBA(354.1,"AP",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 N IBX S IBX=^IBA(354.1,DA,0) I $P(IBX,U,2),$P(IBX,U,3),$P(IBX,U,4)'="",$P(IBX,U,10) S ^IBA(354.1,"AIVDT",+$P(IBX,U,3),+$P(IBX,U,2),-($P(IBX,U)),DA)=""
 S X=DG(DQ),DIC=DIE
 S ^IBA(354.1,"C",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 I $P(^IBA(354.1,DA,0),U,3),+^(0) S ^IBA(354.1,"APIDT",X,+$P(^(0),U,3),-($P(^(0),U)),DA)=""
 S X=DG(DQ),DIC=DIE
 I $P(^IBA(354.1,DA,0),"^",14) S ^IBA(354.1,"ACAN",X,-$P(^(0),"^",14),DA)=""
 Q
X2 Q
3 D:$D(DG)>9 F^DIE17,DE S DQ=3,DW="0;3",DV="RSI",DU="",DLB="TYPE",DIFLD=.03
 S DE(DW)="C3^IBXEX"
 S DU="1:COPAY INCOME EXEMPTION;"
 S X=IBTYPE
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C3 G C3S:$D(DE(3))[0 K DB
 S X=DE(3),DIC=DIE
 K ^IBA(354.1,"AIVDT",+X,+$P(^IBA(354.1,DA,0),U,2),-($P(^(0),U)),DA)
 S X=DE(3),DIC=DIE
 K ^IBA(354.1,"APIDT",+$P(^IBA(354.1,DA,0),U,2),+X,-($P(^(0),U)),DA)
 S X=DE(3),DIC=DIE
 K ^IBA(354.1,"ACY",+X,+$P(^IBA(354.1,DA,0),U,2),+$E($P(^(0),U),1,3),DA)
C3S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 N IBX S IBX=^IBA(354.1,DA,0) I $P(IBX,U,2),$P(IBX,U,3),$P(IBX,U,4)'="",$P(IBX,U,10) S ^IBA(354.1,"AIVDT",+$P(IBX,U,3),+$P(IBX,U,2),-($P(IBX,U)),DA)=""
 S X=DG(DQ),DIC=DIE
 I $P(^IBA(354.1,DA,0),U,2),+^(0) S ^IBA(354.1,"APIDT",+$P(^(0),U,2),+X,-($P(^(0),U)),DA)=""
 S X=DG(DQ),DIC=DIE
 I $P(^IBA(354.1,DA,0),U,2),+^(0) S ^IBA(354.1,"ACY",+X,+$P(^(0),U,2),+$E($P(^(0),U),1,3),DA)=""
 Q
X3 Q
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="0;4",DV="RSI",DU="",DLB="STATUS",DIFLD=.04
 S DE(DW)="C4^IBXEX"
 S DU="1:EXEMPT;0:NON-EXEMPT;"
 S X=IBSTAT
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C4 G C4S:$D(DE(4))[0 K DB
 S X=DE(4),DIC=DIE
 K ^IBA(354.1,"AS",$E(X,1,30),DA)
C4S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 S ^IBA(354.1,"AS",$E(X,1,30),DA)=""
 Q
X4 Q
5 D:$D(DG)>9 F^DIE17,DE S DQ=5,DW="0;5",DV="RP354.2'I",DU="",DLB="EXEMPTION REASON",DIFLD=.05
 S DE(DW)="C5^IBXEX"
 S DU="IBE(354.2,"
 S X=IBEXREA
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C5 G C5S:$D(DE(5))[0 K DB
 S X=DE(5),DIC=DIE
 K ^IBA(354.1,"AR",$E(X,1,30),DA)
C5S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 S ^IBA(354.1,"AR",$E(X,1,30),DA)=""
 Q
X5 Q
6 D:$D(DG)>9 F^DIE17,DE S DQ=6,DW="0;6",DV="S",DU="",DLB="HOW ADDED",DIFLD=.06
 S DU="1:SYSTEM;2:MANUAL;"
 S X=IBHOW
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X6 Q
7 S DW="0;7",DV="P200'I",DU="",DLB="USER ADDING ENTRY",DIFLD=.07
 S DU="VA(200,"
 S X=$S(DUZ:DUZ,1:.5)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X7 Q
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 G A
9 S DW="0;8",DV="RDI",DU="",DLB="DATE/TIME ADDED",DIFLD=.08
 S %=$P($H,",",2),X=DT_(%\60#60/100+(%\3600)+(%#60/10000)/100)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X9 S %DT="STXR" D ^%DT S X=Y K:Y<1 X
 Q
 ;
10 S DW="0;10",DV="R*S",DU="",DLB="ACTIVE",DIFLD=.1
 S DE(DW)="C10^IBXEX"
 S DU="1:ACTIVE;0:INACTIVE;"
 S Y="1"
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C10 G C10S:$D(DE(10))[0 K DB
 S X=DE(10),DIC=DIE
 K ^IBA(354.1,"AA",$E(X,1,30),DA)
 S X=DE(10),DIC=DIE
 N IBX S IBX=^IBA(354.1,DA,0) K ^IBA(354.1,"AIVDT",+$P(IBX,U,3),+$P(IBX,U,2),-($P(IBX,U)),DA)
 S X=DE(10),DIC=DIE
 K ^IBA(354.1,"ACY",+$P(^IBA(354.1,DA,0),U,3),+$P(^(0),U,2),+$E($P(^(0),U),1,3),DA)
C10S S X="" Q:DG(DQ)=X  K DB
 D ^IBXEX1
 Q
X10 Q
11 D:$D(DG)>9 F^DIE17,DE S DQ=11,DW="0;11",DV="FO",DU="",DLB="ELECTRONIC SIGNATURE",DIFLD=.11
 S DQ(11,2)="S Y(0)=Y S Y(0)=Y S Y=""<Hidden>"""
 S X=$G(IBASIG)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X11 Q
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 I '$D(IBPRIOR) S Y="@99"
 Q
13 S DW="0;15",DV="D",DU="",DLB="PRIOR YEAR THRESHOLDS",DIFLD=.15
 S DE(DW)="C13^IBXEX"
 S X=IBPRIOR
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C13 G C13S:$D(DE(13))[0 K DB
 D ^IBXEX2
C13S S X="" Q:DG(DQ)=X  K DB
 D ^IBXEX3
 Q
X13 Q
14 S DQ=15 ;@99
15 G 0^DIE17
