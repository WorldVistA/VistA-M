SDBT4 ; ;07/08/15
 D DE G BEGIN
DE S DIE="^SC(",DIC=DIE,DP=44,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^SC(DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,11) S:%]"" DE(1)=%
 I $D(^("SL")) S %Z=^("SL") S %=$P(%Z,U,1) S:%]"" DE(5)=% S %=$P(%Z,U,2) S:%]"" DE(7)=% S %=$P(%Z,U,5) S:%]"" DE(2)=% S %=$P(%Z,U,6) S:%]"" DE(9)=% S %=$P(%Z,U,7) S:%]"" DE(3)=%
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
BEGIN S DNM="SDBT4",DQ=1
1 S DW="0;11",DV="F",DU="",DLB="PHYSICAL LOCATION",DIFLD=10
 G RE
X1 K:$L(X)>25!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
2 S DW="SL;5",DV="*P44'",DU="",DLB="PRINCIPAL CLINIC",DIFLD=1916
 S DU="SC("
 G RE
X2 S DIC("S")="I $P(^(0),""^"",3)=""C"",'$G(^(""OOS""))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
3 S DW="SL;7",DV="RNJ4,0",DU="",DLB="OVERBOOKS/DAY MAXIMUM",DIFLD=1918
 G RE
X3 K:+X'=X!(X>9999)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
4 S D=0 K DE(1) ;1910
 S DIFLD=1910,DGO="^SDBT5",DC="1^44.03A^SI^",DV="44.03F",DW="0;1",DOW="SPECIAL INSTRUCTIONS",DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 I $D(DSC(44.03))#2,$P(DSC(44.03),"I $D(^UTILITY(",1)="" X DSC(44.03) S D=$O(^(0)) S:D="" D=-1 G M4
 S D=$S($D(^SC(DA,"SI",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M4 I D>0 S DC=DC_D I $D(^SC(DA,"SI",+D,0)) S DE(4)=$P(^(0),U,1)
 G RE
R4 D DE
 G A
 ;
5 S DW="SL;1",DV="RNJ2,0X",DU="",DLB="LENGTH OF APP'T",DIFLD=1912
 G RE
X5 K:+X'=X!(X>240)!(X<10)!(X?.E1"."1N.N)!($S('(X#10):0,'(X#15):0,1:1)) X I $D(X) S SDLA=X I $D(^SC(DA,"SL")),+$P(^("SL"),U,6) S SDZ0=$P(^("SL"),U,6),SDZ1=60\SDZ0 I X#SDZ1 D LAPPT^SDUTL
 Q
 ;
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 I '$D(SDLA) S SDLA=X
 Q
7 S DW="SL;2",DV="S",DU="",DLB="VARIABLE APP'NTMENT LENGTH",DIFLD=1913
 S DU="V:YES, VARIABLE LENGTH;"
 G RE
X7 Q
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 S:+$O(^SC(DA,"ST",0))>0 Y="@99"
 Q
9 S DW="SL;6",DV="RSX",DU="",DLB="DISPLAY INCREMENTS PER HOUR",DIFLD=1917
 S DU="1:60-MIN ;2:30-MIN ;4:15-MIN ;3:20-MIN ;6:10-MIN ;"
 S Y="4"
 G Y
X9 S ZSI=$S(X=1!(X=2)!(X=3)!(X=4)!(X=6):60/X,1:0),SDLA=$S('$D(^SC(DA,"SL")):0,1:+^("SL")) K:('SDLA)!('ZSI) SDLA,ZSI,X Q:'$D(X)  I SDLA#ZSI>0 X ^DD(44,1917,9.2) Q
 Q
 ;
10 S DQ=11 ;@99
11 G 0^DIE17
