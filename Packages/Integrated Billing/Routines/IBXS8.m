IBXS8 ; GENERATED FROM 'IB SCREEN8' INPUT TEMPLATE(#514), FILE 399;11/02/18
 D DE G BEGIN
DE S DIE="^DGCR(399,",DIC=DIE,DP=399,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DGCR(399,DA,""))=""
 I $D(^("DEN")) S %Z=^("DEN") S %=$P(%Z,U,1) S:%]"" DE(48)=% S %=$P(%Z,U,2) S:%]"" DE(49)=% S %=$P(%Z,U,3) S:%]"" DE(50)=% S %=$P(%Z,U,4) S:%]"" DE(52)=%
 I $D(^("U2")) S %Z=^("U2") S %=$P(%Z,U,14) S:%]"" DE(37)=% S %=$P(%Z,U,15) S:%]"" DE(40)=% S %=$P(%Z,U,16) S:%]"" DE(33)=%,DE(34)=%
 I $D(^("U4")) S %Z=^("U4") S %=$P(%Z,U,1) S:%]"" DE(4)=% S %=$P(%Z,U,2) S:%]"" DE(7)=%,DE(61)=% S %=$P(%Z,U,3) S:%]"" DE(9)=% S %=$P(%Z,U,4) S:%]"" DE(24)=% S %=$P(%Z,U,5) S:%]"" DE(25)=% S %=$P(%Z,U,7) S:%]"" DE(15)=%
 I  S %=$P(%Z,U,8) S:%]"" DE(16)=% S %=$P(%Z,U,9) S:%]"" DE(10)=% S %=$P(%Z,U,10) S:%]"" DE(11)=% S %=$P(%Z,U,11) S:%]"" DE(12)=% S %=$P(%Z,U,13) S:%]"" DE(29)=% S %=$P(%Z,U,14) S:%]"" DE(30)=%
 I $D(^("U8")) S %Z=^("U8") S %=$P(%Z,U,1) S:%]"" DE(21)=%,DE(58)=% S %=$P(%Z,U,2) S:%]"" DE(19)=%,DE(55)=% S %=$P(%Z,U,3) S:%]"" DE(20)=%,DE(56)=%
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
X2 I $$FT^IBCEF(IBIFN)=7 S Y="@801"
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 S:IBDR20'["81" Y="@82"
 Q
4 S DW="U4;1",DV="NJ18,2",DU="",DIFLD=260,DLB="COB Non-Covered Charge Amt"
 G RE
X4 S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>999999999999999)!(X<0) X
 Q
 ;
5 S DQ=6 ;@82
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S:IBDR20'["82" Y="@83"
 Q
7 S DW="U4;2",DV="FXJ50",DU="",DIFLD=261,DLB="Claim Number"
 G RE
X7 K:$L(X)>50!($L(X)<1)!($TR(X," ")="")!($E(X)=" ") X
 I $D(X),X'?.ANP K X
 Q
 ;
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 S:IBT=3 Y="@84"
 Q
9 S DW="U4;3",DV="D",DU="",DIFLD=262,DLB="Date of 1st Contact"
 G RE
X9 S %DT="E" D ^%DT S X=Y K:Y<1 X
 Q
 ;
10 S DW="U4;9",DV="F",DU="",DIFLD=268,DLB="Contact Name"
 G RE
X10 K:$L(X)>60!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
11 S DW="U4;10",DV="NJ10,0",DU="",DIFLD=269,DLB="Contact Phone"
 G RE
X11 K:+X'=X!(X>9999999999)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
12 S DW="U4;11",DV="NJ10,0",DU="",DIFLD=269.1,DLB="Contact Phone Extension"
 G RE
X12 K:+X'=X!(X>9999999999)!(X<1)!(X?.E1"."1.N) X
 Q
 ;
13 S DQ=14 ;@83
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 S:IBDR20'["83" Y="@84"
 Q
15 S DW="U4;7",DV="P81'",DU="",DIFLD=266,DLB="Primary Code"
 S DU="ICPT("
 G RE
X15 Q
16 S DW="U4;8",DV="P81'",DU="",DIFLD=267,DLB="Secondary Code"
 S DU="ICPT("
 G RE
X16 Q
17 S DQ=18 ;@84
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 S:IBDR20'["84" Y="@85"
 Q
19 S DW="U8;2",DV="*P353.3'",DU="",DIFLD=285,DLB="Report Type"
 S DU="IBE(353.3,"
 G RE
X19 S DIC("S")="I $$RTYPOK^IBCEU(X,DA)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
20 S DW="U8;3",DV="S",DU="",DIFLD=286,DLB="Transmission Method"
 S DU="AA:Available on Request at Provider Site;BM:By Mail;EL:Electronically Only;EM:E-Mail;FT:File Transfer;FX:By Fax;"
 G RE
X20 Q
21 S DW="U8;1",DV="F",DU="",DIFLD=284,DLB="Attachment Control #"
 G RE
X21 K:$L(X)>30!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
22 S DQ=23 ;@85
23 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=23 D X23 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X23 S:IBDR20'["85" Y="@86"
 Q
24 S DW="U4;4",DV="DX",DU="",DIFLD=263,DLB="Disability Start Date"
 G RE
X24 S %DT="E" D ^%DT S X=Y K:DT<X X I $D(X),$P($G(^DGCR(399,DA,"U4")),U,5)'="",X>$P($G(^DGCR(399,DA,"U4")),U,5) K X
 Q
 ;
25 S DW="U4;5",DV="DX",DU="",DIFLD=264,DLB="Disability End Date"
 G RE
X25 S %DT="E" D ^%DT S X=Y K:DT<X X I $D(X),X<$P($G(^DGCR(399,DA,"U4")),U,4) K X
 Q
 ;
26 S DQ=27 ;@86
27 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=27 D X27 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X27 S:IBDR20'["86" Y="@87"
 Q
28 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=28 D X28 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X28 S:$P($G(^DGCR(399,DA,0)),U,19)=3 Y="@87"
 Q
29 S DW="U4;13",DV="DX",DU="",DIFLD=282,DLB="Assumed Care Date"
 G RE
X29 S %DT="E" D ^%DT S X=Y K:DT<X X I $D(X),$P($G(^DGCR(399,DA,"U4")),U,14)'="",X>$P($G(^DGCR(399,DA,"U4")),U,14) K X
 Q
 ;
30 S DW="U4;14",DV="DX",DU="",DIFLD=283,DLB="Relinquished Care Date"
 G RE
X30 S %DT="E" D ^%DT S X=Y K:DT<X X I $D(X),X<$P($G(^DGCR(399,DA,"U4")),U,13) K X
 Q
 ;
31 S DQ=32 ;@87
32 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=32 D X32 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X32 S:IBDR20'["87" Y="@88"
 Q
33 S DW="U2;16",DV="S",DU="",DIFLD=238,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="01:EPSDT/CHAP;02:Phys Handicapped Children Program;03:Special Fed Funding;05:Disability;07:Induced Abortion - Danger to Life;08:Induced Abortion - Rape or Incest;09:2nd Opinion/Surgery;"
 S X=$S($P($G(^DGCR(399,DA,"U2")),U,16)'="":$P($G(^DGCR(399,DA,"U2")),U,16),$$WNRBILL^IBEFUNC(DA):"31",1:"")
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X33 Q
34 S DW="U2;16",DV="S",DU="",DIFLD=238,DLB="Special Program"
 S DU="01:EPSDT/CHAP;02:Phys Handicapped Children Program;03:Special Fed Funding;05:Disability;07:Induced Abortion - Danger to Life;08:Induced Abortion - Rape or Incest;09:2nd Opinion/Surgery;"
 G RE
X34 Q
35 S DQ=36 ;@88
36 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=36 D X36 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X36 S:IBDR20'["88" Y="@89"
 Q
37 S DW="U2;14",DV="S",DU="",DIFLD=236,DLB="Homebound"
 S DU="0:NO;1:YES;"
 G RE
X37 Q
38 S DQ=39 ;@89
39 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=39 D X39 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X39 S:IBDR20'["89" Y="@899"
 Q
40 S DW="U2;15",DV="D",DU="",DIFLD=237,DLB="Date Last Seen"
 G RE
X40 S %DT="EX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
41 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=41 D X41 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X41 S Y="@899"
 Q
42 S DQ=43 ;@801
43 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=43 D X43 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X43 S $Y=3
 Q
44 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=44 D X44 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X44 S:IBDR20'["81" Y="@802"
 Q
45 S D=0 K DE(1) ;96
 S DIFLD=96,DGO="^IBXS81",DC="2^399.096IA^DEN1^",DV="399.096MNJ2,0",DW="0;1",DOW=$$LABEL^DIALOGZ(DP,DIFLD),DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 G RE:D I $D(DSC(399.096))#2,$P(DSC(399.096),"I $D(^UTILITY(",1)="" X DSC(399.096) S D=$O(^(0)) S:D="" D=-1 G M45
 S D=$S($D(^DGCR(399,DA,"DEN1",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M45 I D>0 S DC=DC_D I $D(^DGCR(399,DA,"DEN1",+D,0)) S DE(45)=$P(^(0),U,1)
 G RE
R45 D DE
 S D=$S($D(^DGCR(399,DA,"DEN1",0)):$P(^(0),U,3,4),1:1) G 45+1
 ;
46 S DQ=47 ;@802
47 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=47 D X47 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X47 S:IBDR20'["82" Y="@803"
 Q
48 S DW="DEN;1",DV="D",DU="",DIFLD=92,DLB="Banding Date"
 G RE
X48 S %DT="EX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
49 S DW="DEN;2",DV="NJ15,0",DU="",DIFLD=93,DLB="Treatment Months Count"
 G RE
X49 K:+X'=X!(X>999999999999999)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
50 S DW="DEN;3",DV="NJ15,0",DU="",DIFLD=94,DLB="Treatment Months Remaining Count"
 G RE
X50 K:+X'=X!(X>999999999999999)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
51 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=51 D X51 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X51 I $P($G(^DGCR(399,DA,"DEN")),U,2)'="",$P($G(^("DEN")),U,3)'="" S Y="@803"
 Q
52 S DW="DEN;4",DV="S",DU="",DIFLD=95,DLB="Treatment Indicator"
 S DU="1:YES;"
 G RE
X52 Q
53 S DQ=54 ;@803
54 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=54 D X54 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X54 S:IBDR20'["83" Y="@804"
 Q
55 S DW="U8;2",DV="*P353.3'",DU="",DIFLD=285,DLB="Report Type"
 S DU="IBE(353.3,"
 G RE
X55 S DIC("S")="I $$RTYPOK^IBCEU(X,DA)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
56 S DW="U8;3",DV="S",DU="",DIFLD=286,DLB="Transmission Method"
 S DU="AA:Available on Request at Provider Site;BM:By Mail;EL:Electronically Only;EM:E-Mail;FT:File Transfer;FX:By Fax;"
 G RE
X56 Q
57 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=57 D X57 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X57 S:$P($G(^DGCR(399,DA,"U8")),U,3)="AA" Y="@804"
 Q
58 S DW="U8;1",DV="F",DU="",DIFLD=284,DLB="Attachment Control #"
 G RE
X58 K:$L(X)>30!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
59 S DQ=60 ;@804
60 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=60 D X60 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X60 S:IBDR20'["84" Y="@899"
 Q
61 S DW="U4;2",DV="FXJ50",DU="",DIFLD=261,DLB="Claim Number"
 G RE
X61 K:$L(X)>50!($L(X)<1)!($TR(X," ")="")!($E(X)=" ") X
 I $D(X),X'?.ANP K X
 Q
 ;
62 S DQ=63 ;@899
63 G 0^DIE17
