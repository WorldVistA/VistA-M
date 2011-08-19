ECMXP ; GENERATED FROM 'EC CREATE PATIENT ENTRY' INPUT TEMPLATE(#1503), FILE 721;08/18/09
 D DE G BEGIN
DE S DIE="^ECH(",DIC=DIE,DP=721,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^ECH(DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,2) S:%]"" DE(1)=% S %=$P(%Z,U,3) S:%]"" DE(2)=% S %=$P(%Z,U,4) S:%]"" DE(3)=% S %=$P(%Z,U,5) S:%]"" DE(4)=% S %=$P(%Z,U,6) S:%]"" DE(5)=% S %=$P(%Z,U,7) S:%]"" DE(6)=% S %=$P(%Z,U,8) S:%]"" DE(7)=%
 I  S %=$P(%Z,U,9) S:%]"" DE(8)=% S %=$P(%Z,U,10) S:%]"" DE(9)=% S %=$P(%Z,U,11) S:%]"" DE(10)=% S %=$P(%Z,U,12) S:%]"" DE(11)=% S %=$P(%Z,U,13) S:%]"" DE(12)=% S %=$P(%Z,U,15) S:%]"" DE(13)=% S %=$P(%Z,U,17) S:%]"" DE(14)=%
 I $D(^("P")) S %Z=^("P") S %=$P(%Z,U,1) S:%]"" DE(15)=% S %=$P(%Z,U,2) S:%]"" DE(16)=%
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
BEGIN S DNM="ECMXP",DQ=1
 N DIEZTMP,DIEZAR,DIEZRXR,DIIENS,DIXR K DIEFIRE,DIEBADK S DIEZTMP=$$GETTMP^DIKC1("DIEZ")
 M DIEZAR=^DIE(1503,"AR") S DICRREC="TRIG^DIE17"
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIIENS=DA_",",DIEZ=1503,U="^"
1 S DW="0;2",DV="RP2'",DU="",DLB="PATIENT",DIFLD=1
 S DE(DW)="C1^ECMXP"
 S DU="DPT("
 S X=$G(ECPTR("DFN"))
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C1 G C1S:$D(DE(1))[0 K DB
 S X=DE(1),DIC=DIE
 D KAPAT^ECDUTL
 S X=DE(1),DIC=DIE
 D KADTP^ECDUTL
C1S S X="" G:DG(DQ)=X C1F1 K DB
 S X=DG(DQ),DIC=DIE
 D APAT^ECDUTL
 S X=DG(DQ),DIC=DIE
 D ADTP^ECDUTL
C1F1 Q
X1 Q
2 D:$D(DG)>9 F^DIE17,DE S DQ=2,DW="0;3",DV="RD",DU="",DLB="DATE/TIME OF PROCEDURE",DIFLD=2
 S DE(DW)="C2^ECMXP"
 S X=$G(ECPRR("PROCDT"))
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C2 G C2S:$D(DE(2))[0 K DB
 S X=DE(2),DIC=DIE
 D KILLADT^ECDUTL
 S X=DE(2),DIC=DIE
 K ^ECH("AC",$E(X,1,30),DA)
 S X=DE(2),DIC=DIE
 X "Q:$P(^ECH(DA,0),U,4)']""""  K ^ECH(""AC1"",$P(^(0),U,4),X,DA)"
 S X=DE(2),DIC=DIE
 D KAPAT1^ECDUTL
C2S S X="" G:DG(DQ)=X C2F1 K DB
 S X=DG(DQ),DIC=DIE
 D ADT^ECDUTL
 S X=DG(DQ),DIC=DIE
 S ^ECH("AC",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 X "Q:$P(^ECH(DA,0),U,4)']""""  S ^ECH(""AC1"",$P(^(0),U,4),X,DA)="""""
 S X=DG(DQ),DIC=DIE
 D APAT1^ECDUTL
C2F1 Q
X2 Q
3 D:$D(DG)>9 F^DIE17,DE S DQ=3,DW="0;4",DV="R*P4'",DU="",DLB="LOCATION",DIFLD=3
 S DE(DW)="C3^ECMXP"
 S DU="DIC(4,"
 S X=$G(ECL)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C3 G C3S:$D(DE(3))[0 K DB
 S X=DE(3),DIC=DIE
 X "Q:$P(^ECH(DA,0),U,3)']""""  K ^ECH(""AC1"",X,$P(^(0),U,3),DA)"
 S X=DE(3),DIC=DIE
 D KADTL^ECDUTL
C3S S X="" G:DG(DQ)=X C3F1 K DB
 S X=DG(DQ),DIC=DIE
 X "Q:$P(^ECH(DA,0),U,3)']""""  S ^ECH(""AC1"",X,$P(^(0),U,3),DA)="""""
 S X=DG(DQ),DIC=DIE
 D ADTL^ECDUTL
C3F1 Q
X3 Q
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="0;5",DV="RP49'",DU="",DLB="SERVICE",DIFLD=4
 S DU="DIC(49,"
 S X=$P($G(^ECD(+$P($G(ECDSSU),"^"),0)),"^",2)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X4 Q
5 S DW="0;6",DV="RP723'",DU="",DLB="SECTION",DIFLD=5
 S DU="ECC(723,"
 S X=$P($G(^ECD(+$P($G(ECDSSU),"^"),0)),"^",3)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X5 Q
6 S DW="0;7",DV="RP724'",DU="",DLB="DSS UNIT",DIFLD=6
 S DE(DW)="C6^ECMXP"
 S DU="ECD("
 S X=$P($G(ECDSSU),"^")
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C6 G C6S:$D(DE(6))[0 K DB
 S X=DE(6),DIC=DIE
 D KADTU^ECDUTL
C6S S X="" G:DG(DQ)=X C6F1 K DB
 S X=DG(DQ),DIC=DIE
 D ADTU^ECDUTL
C6F1 Q
X6 Q
7 D:$D(DG)>9 F^DIE17,DE S DQ=7,DW="0;8",DV="P726'",DU="",DLB="CATEGORY",DIFLD=7
 S DU="EC(726,"
 S X=+$P($G(ECCAT),"^")
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X7 Q
8 S DW="0;9",DV="RV",DU="",DLB="PROCEDURE",DIFLD=8
 S X=$G(ECPRR("PROC"))
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X8 Q
9 S DW="0;10",DV="RNJ4,0",DU="",DLB="VOLUME",DIFLD=9
 S X=$G(ECPRR("VOL"))
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X9 Q
10 S DW="0;11",DV="RP200'",DU="",DLB="*PROVIDER",DIFLD=10
 S DU="VA(200,"
 S X=$P($G(ECU(1)),"^")
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X10 Q
11 S DW="0;12",DV="RP723'",DU="",DLB="ORDERING SECTION",DIFLD=11
 S DU="ECC(723,"
 S X=$G(ECPTR("ORDSEC"))
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X11 Q
12 S DW="0;13",DV="RP200'",DU="",DLB="ENTERED/EDITED BY",DIFLD=13
 S DU="VA(200,"
 S X=$G(DUZ)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X12 Q
13 S DW="0;15",DV="P200'",DU="",DLB="*PROVIDER #2",DIFLD=15
 S DU="VA(200,"
 S X=$P($G(ECU(2)),"^")
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X13 Q
14 S DW="0;17",DV="P200'",DU="",DLB="*PROVIDER #3",DIFLD=17
 S DU="VA(200,"
 S X=$P($G(ECU(3)),"^")
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X14 Q
15 S DW="P;1",DV="P81'",DU="",DLB="PCE CPT CODE",DIFLD=19
 S DU="ICPT("
 S X=$G(ECPRR("PCEPR"))
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X15 Q
16 S DW="P;2",DV="R*P80'X",DU="",DLB="PRIMARY ICD-9 CODE",DIFLD=20
 S DU="ICD9("
 S X=$G(ECPTR("DX"))
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X16 Q
17 D:$D(DG)>9 F^DIE17 G ^ECMXP1
