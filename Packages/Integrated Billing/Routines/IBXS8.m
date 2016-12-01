IBXS8 ; GENERATED FROM 'IB SCREEN8' INPUT TEMPLATE(#514), FILE 399;09/02/16
 D DE G BEGIN
DE S DIE="^DGCR(399,",DIC=DIE,DP=399,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DGCR(399,DA,""))=""
 I $D(^("U2")) S %Z=^("U2") S %=$P(%Z,U,14) S:%]"" DE(36)=% S %=$P(%Z,U,15) S:%]"" DE(39)=% S %=$P(%Z,U,16) S:%]"" DE(32)=%,DE(33)=%
 I $D(^("U4")) S %Z=^("U4") S %=$P(%Z,U,1) S:%]"" DE(3)=% S %=$P(%Z,U,2) S:%]"" DE(6)=% S %=$P(%Z,U,3) S:%]"" DE(8)=% S %=$P(%Z,U,4) S:%]"" DE(23)=% S %=$P(%Z,U,5) S:%]"" DE(24)=% S %=$P(%Z,U,7) S:%]"" DE(14)=% S %=$P(%Z,U,8) S:%]"" DE(15)=%
 I  S %=$P(%Z,U,9) S:%]"" DE(9)=% S %=$P(%Z,U,10) S:%]"" DE(10)=% S %=$P(%Z,U,11) S:%]"" DE(11)=% S %=$P(%Z,U,13) S:%]"" DE(28)=% S %=$P(%Z,U,14) S:%]"" DE(29)=%
 I $D(^("U8")) S %Z=^("U8") S %=$P(%Z,U,1) S:%]"" DE(20)=% S %=$P(%Z,U,2) S:%]"" DE(18)=% S %=$P(%Z,U,3) S:%]"" DE(19)=%
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
BEGIN S DNM="IBXS8",DQ=1
 N DIEZTMP,DIEZAR,DIEZRXR,DIIENS,DIXR K DIEFIRE,DIEBADK S DIEZTMP=$$GETTMP^DIKC1("DIEZ")
 M DIEZAR=^DIE(514,"AR") S DICRREC="TRIG^DIE17"
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIIENS=DA_",",DIEZ=514,U="^"
1 S DQ=2 ;@81
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S:IBDR20'["81" Y="@82"
 Q
3 S DW="U4;1",DV="NJ18,2",DU="",DIFLD=260,DLB="COB Non-Covered Charge Amt"
 G RE
X3 S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>999999999999999)!(X<0) X
 Q
 ;
4 S DQ=5 ;@82
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 S:IBDR20'["82" Y="@83"
 Q
6 S DW="U4;2",DV="FX",DU="",DIFLD=261,DLB="Claim Number"
 G RE
X6 K:$L(X)>30!($L(X)<1)!($TR(X," ")="")!($E(X)=" ") X
 I $D(X),X'?.ANP K X
 Q
 ;
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 S:IBT=3 Y="@84"
 Q
8 S DW="U4;3",DV="D",DU="",DIFLD=262,DLB="Date of 1st Contact"
 G RE
X8 S %DT="E" D ^%DT S X=Y K:Y<1 X
 Q
 ;
9 S DW="U4;9",DV="F",DU="",DIFLD=268,DLB="Contact Name"
 G RE
X9 K:$L(X)>60!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
10 S DW="U4;10",DV="NJ10,0",DU="",DIFLD=269,DLB="Contact Phone"
 G RE
X10 K:+X'=X!(X>9999999999)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
11 S DW="U4;11",DV="NJ10,0",DU="",DIFLD=269.1,DLB="Contact Phone Extension"
 G RE
X11 K:+X'=X!(X>9999999999)!(X<1)!(X?.E1"."1.N) X
 Q
 ;
12 S DQ=13 ;@83
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 S:IBDR20'["83" Y="@84"
 Q
14 S DW="U4;7",DV="P81'",DU="",DIFLD=266,DLB="Primary Code"
 S DU="ICPT("
 G RE
X14 Q
15 S DW="U4;8",DV="P81'",DU="",DIFLD=267,DLB="Secondary Code"
 S DU="ICPT("
 G RE
X15 Q
16 S DQ=17 ;@84
17 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=17 D X17 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X17 S:IBDR20'["84" Y="@85"
 Q
18 S DW="U8;2",DV="P353.3'",DU="",DIFLD=285,DLB="Report Type"
 S DU="IBE(353.3,"
 G RE
X18 Q
19 S DW="U8;3",DV="S",DU="",DIFLD=286,DLB="Transmission Method"
 S DU="AA:Available on Request at Provider Site;BM:By Mail;EL:Electronically Only;EM:E-Mail;FT:File Transfer;FX:By Fax;"
 G RE
X19 Q
20 S DW="U8;1",DV="F",DU="",DIFLD=284,DLB="Attachment Control #"
 G RE
X20 K:$L(X)>30!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
21 S DQ=22 ;@85
22 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=22 D X22 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X22 S:IBDR20'["85" Y="@86"
 Q
23 S DW="U4;4",DV="DX",DU="",DIFLD=263,DLB="Disability Start Date"
 G RE
X23 S %DT="E" D ^%DT S X=Y K:DT<X X I $D(X),$P($G(^DGCR(399,DA,"U4")),U,5)'="",X>$P($G(^DGCR(399,DA,"U4")),U,5) K X
 Q
 ;
24 S DW="U4;5",DV="DX",DU="",DIFLD=264,DLB="Disability End Date"
 G RE
X24 S %DT="E" D ^%DT S X=Y K:DT<X X I $D(X),X<$P($G(^DGCR(399,DA,"U4")),U,4) K X
 Q
 ;
25 S DQ=26 ;@86
26 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=26 D X26 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X26 S:IBDR20'["86" Y="@87"
 Q
27 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=27 D X27 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X27 S:$P($G(^DGCR(IBIFN,0)),U,19)=3 Y="@87"
 Q
28 S DW="U4;13",DV="DX",DU="",DIFLD=282,DLB="Assumed Care Date"
 G RE
X28 S %DT="E" D ^%DT S X=Y K:DT<X X I $D(X),$P($G(^DGCR(399,DA,"U4")),U,14)'="",X>$P($G(^DGCR(399,DA,"U4")),U,14) K X
 Q
 ;
29 S DW="U4;14",DV="DX",DU="",DIFLD=283,DLB="Relinquished Care Date"
 G RE
X29 S %DT="E" D ^%DT S X=Y K:DT<X X I $D(X),X<$P($G(^DGCR(399,DA,"U4")),U,13) K X
 Q
 ;
30 S DQ=31 ;@87
31 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=31 D X31 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X31 S:IBDR20'["87" Y="@88"
 Q
32 S DW="U2;16",DV="S",DU="",DIFLD=238,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="01:EPSDT/CHAP;02:Phys Handicapped Children Program;03:Special Fed Funding;05:Disability;07:Induced Abortion - Danger to Life;08:Induced Abortion - Rape or Incest;09:2nd Opinion/Surgery;"
 S X=$S($P($G(^DGCR(399,DA,"U2")),U,16)'="":$P($G(^DGCR(399,DA,"U2")),U,16),$$WNRBILL^IBEFUNC(DA):"31",1:"")
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X32 Q
33 S DW="U2;16",DV="S",DU="",DIFLD=238,DLB="Special Program"
 S DU="01:EPSDT/CHAP;02:Phys Handicapped Children Program;03:Special Fed Funding;05:Disability;07:Induced Abortion - Danger to Life;08:Induced Abortion - Rape or Incest;09:2nd Opinion/Surgery;"
 G RE
X33 Q
34 S DQ=35 ;@88
35 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=35 D X35 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X35 S:IBDR20'["88" Y="@89"
 Q
36 S DW="U2;14",DV="S",DU="",DIFLD=236,DLB="Homebound"
 S DU="0:NO;1:YES;"
 G RE
X36 Q
37 S DQ=38 ;@89
38 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=38 D X38 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X38 S:IBDR20'["89" Y="@899"
 Q
39 S DW="U2;15",DV="D",DU="",DIFLD=237,DLB="Date Last Seen"
 G RE
X39 S %DT="EX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
40 S DQ=41 ;@899
41 G 0^DIE17
