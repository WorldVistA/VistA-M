RACTOE ; GENERATED FROM 'RA ORDER EXAM' INPUT TEMPLATE(#1087), FILE 75.1;01/03/19
 D DE G BEGIN
DE S DIE="^RAO(75.1,",DIC=DIE,DP=75.1,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^RAO(75.1,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,2) S:%]"" DE(2)=% S %=$P(%Z,U,3) S:%]"" DE(25)=% S %=$P(%Z,U,4) S:%]"" DE(41)=% S %=$P(%Z,U,5) S:%]"" DE(82)=% S %=$P(%Z,U,8) S:%]"" DE(11)=% S %=$P(%Z,U,9) S:%]"" DE(47)=% S %=$P(%Z,U,12) S:%]"" DE(52)=%
 I  S %=$P(%Z,U,13) S:%]"" DE(65)=% S %=$P(%Z,U,14) S:%]"" DE(40)=% S %=$P(%Z,U,17) S:%]"" DE(68)=% S %=$P(%Z,U,18) S:%]"" DE(83)=% S %=$P(%Z,U,21) S:%]"" DE(72)=%,DE(75)=%,DE(79)=% S %=$P(%Z,U,22) S:%]"" DE(49)=%
 I $D(^(.1)) S %Z=^(.1) S %=$P(%Z,U,1) S:%]"" DE(27)=%
 I $D(^("R")) S %Z=^("R") S %=$P(%Z,U,1) S:%]"" DE(44)=%
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
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" I X?.ANP D SET^DIED I 'DDER G V
 K DDER G X
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
BEGIN S DNM="RACTOE",DQ=1
 N DIEZTMP,DIEZAR,DIEZRXR,DIIENS,DIXR K DIEFIRE,DIEBADK S DIEZTMP=$$GETTMP^DIKC1("DIEZ")
 M DIEZAR=^DIE(1087,"AR") S DICRREC="TRIG^DIE17"
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIIENS=DA_",",DIEZ=1087,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 I '$D(RACAT)!('$D(RADFN))!('$D(RADIV))!('$D(RALIFN))!('$D(RAPIFN)) W !?3,$C(7),"Variables RACAT,RADFN,RADIV,RALIFN and RAPIFN must be defined!" S Y="@999"
 Q
2 S DW="0;2",DV="*P71'XR",DU="",DIFLD=2,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C2^RACTOE",DE(DW,"INDEX")=1
 S DU="RAMIS(71,"
 S X=$S($D(^RAMIS(71,RAPRI,0)):$P(^(0),U),1:"")
 S Y=X
 G Y
C2 G C2S:$D(DE(2))[0 K DB
C2S S X="" G:DG(DQ)=X C2F1 K DB
C2F1 S DIEZRXR(75.1,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1425 S DIEZRXR(75.1,DIXR)=""
 Q
X2 S DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X D:$D(X) ORDPRC^RAUTL2
 Q
 ;
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 S RAPRI=X
 Q
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 S RAIMAG=$$ITYPE^RASITE(+RAPRI)
 Q
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 S Y=$S('$D(^RA(79,+RADIV,.1)):"@2",$P(^(.1),"^",7)="Y"&($P(^RAMIS(71,RAPRI,0),"^",6)="B"):"@1",1:"@2")
 Q
6 S DQ=7 ;@1
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 W !?3,$C(7),"A 'detailed' procedure or a 'series' of procedures is required!" S Y=""
 Q
8 S DQ=9 ;@2
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 I $O(^RAMIS(71,RAPRI,3,0)) D EN2^RAPRI
 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 I $P(^RAMIS(71,RAPRI,0),"^",11)'="y" S Y="@3"
 Q
11 D:$D(DG)>9 F^DIE17,DE S DQ=11,DW="0;8",DV="*P200'XR",DU="",DIFLD=8,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="VA(200,"
 G RE
X11 S DIC("S")="I $S('$D(^(""RA"")):1,'$P(^(""RA""),U,3):1,DT'>$P(^(""RA""),U,3):1,1:0),$D(^VA(200,""ARC"",""S"",+Y))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
12 S DQ=13 ;@3
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 I '$D(RAMOD) S Y="@7"
 Q
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 S RAI=""
 Q
15 S DQ=16 ;@5
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 S RAI=$O(RAMOD(0)) I 'RAI S Y="@7"
 Q
17 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=17 D X17 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X17 S RAMODPRO=+$O(^RAMIS(71.2,"B",$G(RAMOD(RAI)),0))
 Q
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 S:'$D(^RAMIS(71.2,"AB",+$$ITYPE^RASITE(RAPRI),RAMODPRO)) Y="@8"
 Q
19 S D=0 K DE(1) ;125
 S DIFLD=125,DGO="^RACTOE1",DC="1^75.1125PA^M^",DV="75.1125M*P71.2'X",DW="0;1",DOW=$$LABEL^DIALOGZ(DP,DIFLD),DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 S DU="RAMIS(71.2,"
 G RE:D I $D(DSC(75.1125))#2,$P(DSC(75.1125),"I $D(^UTILITY(",1)="" X DSC(75.1125) S D=$O(^(0)) S:D="" D=-1 G M19
 S D=$S($D(^RAO(75.1,DA,"M",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M19 I D>0 S DC=DC_D I $D(^RAO(75.1,DA,"M",+D,0)) S DE(19)=$P(^(0),U,1)
 S X=RAMOD(RAI)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
R19 D DE
 G A
 ;
20 S DQ=21 ;@8
21 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=21 D X21 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X21 K RAMOD(RAI) S Y="@5"
 Q
22 S DQ=23 ;@7
23 S D=0 K DE(1) ;125
 S DIFLD=125,DGO="^RACTOE2",DC="1^75.1125PA^M^",DV="75.1125M*P71.2'X",DW="0;1",DOW=$$LABEL^DIALOGZ(DP,DIFLD),DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 S DU="RAMIS(71.2,"
 G RE:D I $D(DSC(75.1125))#2,$P(DSC(75.1125),"I $D(^UTILITY(",1)="" X DSC(75.1125) S D=$O(^(0)) S:D="" D=-1 G M23
 S D=$S($D(^RAO(75.1,DA,"M",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M23 I D>0 S DC=DC_D I $D(^RAO(75.1,DA,"M",+D,0)) S DE(23)=$P(^(0),U,1)
 G RE
R23 D DE
 S D=$S($D(^RAO(75.1,DA,"M",0)):$P(^(0),U,3,4),1:1) G 23+1
 ;
24 S DQ=25 ;@9
25 S DW="0;3",DV="P79.2'",DU="",DIFLD=3,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="RA(79.2,"
 S X=$P(RAIMAG,U)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X25 Q
26 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=26 D X26 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X26 S RACOMENT="reason for study (RAREAST) is required with patch 75" K RACOMENT
 Q
27 S DW=".1;1",DV="RF",DU="",DIFLD=1.1,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S X=RAREAST
 S Y=X
 G Y
X27 K:$L(X)>64!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
28 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=28 D X28 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X28 S RACOMENT="Clinical History is not longer required with patch 75." K RACOMENT
 Q
29 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=29 D X29 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X29 I $D(^RA(79,+RADIV,"HIS")) W !!?3,$C(7),^("HIS"),!
 Q
30 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=30 D X30 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X30 I $O(^TMP($J,"RAWP",0)) S ^RAO(75.1,DA,"H",0)=^(0) F RAI=1:1 Q:'$D(^TMP($J,"RAWP",RAI,0))  S ^RAO(75.1,DA,"H",RAI,0)=^(0)
 Q
31 S DQ=32 ;@10
32 S D=0 K DE(1) ;400
 S Y="^W^^0;1^Q" S $P(Y,U)=$$LABEL^DIALOGZ(DP,400) S DG="H",DC="^75.11" D DIEN^DIWE K DE(1) G A
 ;
33 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=33 D X33 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X33 I $D(DIRUT) S Y="@999"
 Q
34 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=34 D X34 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X34 S:+$O(^RAO(75.1,DA,"H",0))=0 Y="@15"
 Q
35 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=35 D X35 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X35 S RAWPFLAG=$$VALWP^RAUTL5("^RAO(75.1,"_DA_",""H"",")
 Q
36 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=36 D X36 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X36 I 'RAWPFLAG W !!?3,$C(7),"Text must be at least two (2) alphanumeric characters in length.",! S Y="@10"
 Q
37 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=37 D X37 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X37 I $P($G(^RAO(75.1,DA,"H",0)),U,3)>350 W ?3,$C(7),"Clinical History cannot exceed 350 lines!" S Y="@10"
 Q
38 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=38 D X38 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X38 I $O(^RAO(75.1,DA,"H",0)) D UPDT^RAUTL3("^RAO(75.1,"_DA_",""H"",")
 Q
39 S DQ=40 ;@15
40 S DW="0;14",DV="R*P200'X",DU="",DIFLD=14,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="VA(200,"
 S X=RAPIFN
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X40 Q
41 S DW="0;4",DV="SX",DU="",DIFLD=4,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="I:INPATIENT;O:OUTPATIENT;C:CONTRACT;S:SHARING;E:EMPLOYEE;R:RESEARCH;"
 S X=RACAT
 S Y=X
 G Y
X41 Q
42 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=42 D X42 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X42 S Y=$E(X),Y=$S(Y="R":"@30",(Y'="")&("CS"[Y):"@40",1:"@50")
 Q
43 S DQ=44 ;@30
44 S DW="R;1",DV="FR",DU="",DIFLD=9.5,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S X=$S($D(RARSH):RARSH,1:"")
 S Y=X
 G Y
X44 K:$L(X)>40!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
45 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=45 D X45 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X45 S Y="@50"
 Q
46 S DQ=47 ;@40
47 S DW="0;9",DV="*P34'R",DU="",DIFLD=9,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="DIC(34,"
 S X=$S($D(RASHA):RASHA,1:"")
 S Y=X
 G Y
X47 S DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
48 S DQ=49 ;@50
49 S DW="0;22",DV="P44'",DU="",DIFLD=22,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="SC("
 S X=RALIFN
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X49 Q
50 S DQ=51 ;@100
51 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=51 D X51 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X51 W !,"IS PATIENT SCHEDULED FOR PRE-OP" S %=2 D YN^DICN S:%<0 Y="@999" S:%=2 Y="@120" I '% W !!,"Enter 'YES' if patient is scheduled for pre-op, or 'NO' if not.",! S Y="@100"
 Q
52 S DW="0;12",DV="D",DU="",DIFLD=12,DLB="PRE-OP SCHEDULED DATE (TIME optional)"
 S X="TODAY"
 S Y=X
 G Y
X52 S %DT="ETX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
53 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=53 D X53 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X53 S:$D(RAEXMUL) RAPREOP1=X
 Q
54 S DQ=55 ;@120
55 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=55 D X55 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X55 S:RASEX="M" Y="@130"
 Q
56 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=56 D X56 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X56 S RACOM="the following sets the value of Y based on SEX" K RACOM
 Q
57 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=57 D X57 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X57 S:RASEX'="F" Y=$$ASKSEX^RAUTL8()
 Q
58 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=58 D X58 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X58 S RASEX="F"
 Q
59 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=59 D X59 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X59 W:$D(RAOPT("ADDEXAM")) !,"PREGNANT AT TIME OF ORDER ENTRY: ",$S($G(RAPREG)="y":"YES",$G(RAPREG)="n":"NO",$G(RAPREG)="u":"UNKNOWN",1:"")
 Q
60 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=60 D X60 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X60 S:$D(RAOPT("ADDEXAM")) Y="@1301"
 Q
61 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=61 D X61 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X61 S:($$PTAGE^RAUTL8(RADFN,"")<12)!($$PTAGE^RAUTL8(RADFN,"")>55) Y="@130"
 Q
62 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=62 D X62 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X62 S RAPAOE=$$PAOE^RAUTL8()
 Q
63 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=63 D X63 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X63 S:'$G(RAPAOE) Y="@999"
 Q
64 S DQ=65 ;@1301
65 S DW="0;13",DV="RS",DU="",DIFLD=13,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="y:YES;n:NO;u:UNKNOWN;"
 S X=$G(RAPREG)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X65 Q
66 S DQ=67 ;@130
67 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=67 D X67 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X67 I '$D(RAVSTFLG)!('$D(RAVLEDTI)) S Y="@135"
 Q
68 S DW="0;17",DV="D",DU="",DIFLD=17,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S X=9999999.9999-RAVLEDTI
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X68 S %DT="TXR" D ^%DT S X=Y K:Y<1 X
 Q
 ;
69 S DQ=70 ;@135
70 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=70 D X70 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X70 S:($D(RAWHEN)#2)&($G(RADR1)) Y="@145"
 Q
71 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=71 D X71 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X71 S:$D(RAWHEN)#2 Y="@140"
 Q
72 S DW="0;21",DV="DR",DU="",DIFLD=21,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C72^RACTOE",DE(DW,"INDEX")=1
 G RE
C72 G C72S:$D(DE(72))[0 K DB
C72S S X="" G:DG(DQ)=X C72F1 K DB
C72F1 N X,X1,X2 S DIXR=1510 D C72X1(U) K X2 M X2=X D C72X1("O") K X1 M X1=X
 I $G(X(1))]"" D
 . K ^RAO(75.1,"BDD",$E(X,1,30),DA)
 K X M X=X2 I $G(X(1))]"" D
 . S ^RAO(75.1,"BDD",$E(X,1,30),DA)=""
 G C72F2
C72X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",75.1,DIIENS,21,DION),$P($G(^RAO(75.1,DA,0)),U,21))
 S X=$G(X(1))
 Q
C72F2 S DIEZRXR(75.1,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1425 S DIEZRXR(75.1,DIXR)=""
 Q
X72 S %DT="ETX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
73 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=73 D X73 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X73 S Y="@150"
 Q
74 S DQ=75 ;@140
75 D:$D(DG)>9 F^DIE17,DE S DQ=75,DW="0;21",DV="DR",DU="",DIFLD=21,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C75^RACTOE",DE(DW,"INDEX")=1
 S X=RAWHEN
 S Y=X
 G Y
C75 G C75S:$D(DE(75))[0 K DB
C75S S X="" G:DG(DQ)=X C75F1 K DB
C75F1 N X,X1,X2 S DIXR=1510 D C75X1(U) K X2 M X2=X D C75X1("O") K X1 M X1=X
 I $G(X(1))]"" D
 . K ^RAO(75.1,"BDD",$E(X,1,30),DA)
 K X M X=X2 I $G(X(1))]"" D
 . S ^RAO(75.1,"BDD",$E(X,1,30),DA)=""
 G C75F2
C75X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",75.1,DIIENS,21,DION),$P($G(^RAO(75.1,DA,0)),U,21))
 S X=$G(X(1))
 Q
C75F2 S DIEZRXR(75.1,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1425 S DIEZRXR(75.1,DIXR)=""
 Q
X75 S %DT="ETX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
76 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=76 D X76 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X76 S Y="@150"
 Q
77 S DQ=78 ;@145
78 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=78 G A
79 D:$D(DG)>9 F^DIE17,DE S DQ=79,DW="0;21",DV="DR",DU="",DIFLD=21,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C79^RACTOE",DE(DW,"INDEX")=1
 S X=RAWHEN
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C79 G C79S:$D(DE(79))[0 K DB
C79S S X="" G:DG(DQ)=X C79F1 K DB
C79F1 N X,X1,X2 S DIXR=1510 D C79X1(U) K X2 M X2=X D C79X1("O") K X1 M X1=X
 I $G(X(1))]"" D
 . K ^RAO(75.1,"BDD",$E(X,1,30),DA)
 K X M X=X2 I $G(X(1))]"" D
 . S ^RAO(75.1,"BDD",$E(X,1,30),DA)=""
 G C79F2
C79X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",75.1,DIIENS,21,DION),$P($G(^RAO(75.1,DA,0)),U,21))
 S X=$G(X(1))
 Q
C79F2 S DIEZRXR(75.1,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1425 S DIEZRXR(75.1,DIXR)=""
 Q
X79 S %DT="TX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
80 S DQ=81 ;@150
81 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=81 D X81 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X81 S:$D(RAEXMUL)#2 RAWHEN=$$FMTE^XLFDT(X,1)
 Q
82 D:$D(DG)>9 F^DIE17,DE S DQ=82,DW="0;5",DV="SX",DU="",DIFLD=5,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C82^RACTOE",DE(DW,"INDEX")=1
 S DU="1:DISCONTINUED;2:COMPLETE;3:HOLD;5:PENDING;6:ACTIVE;8:SCHEDULED;11:UNRELEASED;"
 S X=$S($D(RAPKG):5,$$ORVR^RAORDU()=2.5:11,1:5)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C82 G C82S:$D(DE(82))[0 K DB
 S X=DE(82),DIC=DIE
 ;
C82S S X="" G:DG(DQ)=X C82F1 K DB
 S X=DG(DQ),DIC=DIE
 D:$$ORVR^RAORDU()=2.5&((X=1)!(X=3)) CH^RADD2(DA,X)
C82F1 S DIEZRXR(75.1,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1426 S DIEZRXR(75.1,DIXR)=""
 Q
X82 Q
83 D:$D(DG)>9 F^DIE17,DE S DQ=83,DW="0;18",DV="D",DU="",DIFLD=18,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C83^RACTOE"
 S X="NOW"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C83 G C83S:$D(DE(83))[0 K DB
 D ^RACTOE3
C83S S X="" G:DG(DQ)=X C83F1 K DB
 D ^RACTOE4
C83F1 Q
X83 S %DT="TXR" D ^%DT S X=Y K:Y<1 X
 Q
 ;
84 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=84 D X84 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X84 S Y=$S('$D(^RA(79,+RADIV,.1)):"@160",$P(^(.1),"^",19)="y":"@155",1:"@160")
 Q
85 S DQ=86 ;@155
86 D:$D(DG)>9 F^DIE17,DE S DQ=86,D=0 K DE(1) ;75
 S DIFLD=75,DGO="^RACTOE5",DC="4^75.12DA^T^",DV="75.12D",DW="0;1",DOW=$$LABEL^DIALOGZ(DP,DIFLD),DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 I $D(DSC(75.12))#2,$P(DSC(75.12),"I $D(^UTILITY(",1)="" X DSC(75.12) S D=$O(^(0)) S:D="" D=-1 G M86
 S D=$S($D(^RAO(75.1,DA,"T",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M86 I D>0 S DC=DC_D I $D(^RAO(75.1,DA,"T",+D,0)) S DE(86)=$P(^(0),U,1)
 S X="""NOW"""
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
R86 D DE
 G A
 ;
87 S DQ=88 ;@160
88 D:$D(DG)>9 F^DIE17 G ^RACTOE6
