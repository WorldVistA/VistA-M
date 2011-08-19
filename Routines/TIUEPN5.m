TIUEPN5 ; ;10/06/97
 D DE G BEGIN
DE S DIE="^TIU(8925,",DIC=DIE,DP=8925,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^TIU(8925,DA,""))=""
 I $D(^(12)) S %Z=^(12) S %=$P(%Z,U,2) S:%]"" DE(1)=% S %=$P(%Z,U,4) S:%]"" DE(4)=%
 I $D(^(13)) S %Z=^(13) S %=$P(%Z,U,2) S:%]"" DE(7)=%
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
N I X="" G A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) I X?.ANP D SET I 'DDER X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
 K DDER G X
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) I DV'["*" D ^DIC S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V D @("X"_DQ) K YS
Z K DIC("S"),DLAYGO I $D(X),X'=U S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
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
BEGIN S DNM="TIUEPN5",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW="12;2",DV="P200'",DU="",DLB="AUTHOR OF NOTE",DIFLD=1202
 S DE(DW)="C1^TIUEPN5"
 S DU="VA(200,"
 S X=$$PERSNAME^TIULC1($S($D(TIUAUTH):+TIUAUTH,1:+DUZ))
 S Y=X
 G Y
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 K ^TIU(8925,"CA",$E(X,1,30),DA)
 S X=DE(1),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"AAU",+X,+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-$P(^TIU(8925,+DA,13),U)),+DA)
 S X=DE(1),DIC=DIE
 I +$P($G(^TIU(8925,+DA,15)),U) K ^TIU(8925,"AAUP",+X,+$P($G(^TIU(8925,+DA,15)),U),+DA)
 S X=DE(1),DIC=DIE
 D KACLAU^TIUDD01(1202,X)
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^TIU(8925,"CA",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"AAU",+X,+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-$P(^TIU(8925,+DA,13),U)),+DA)=""
 S X=DG(DQ),DIC=DIE
 I +$$AAUP^TIULX(+DA),+$P($G(^TIU(8925,+DA,15)),U) S ^TIU(8925,"AAUP",+X,+$P($G(^TIU(8925,+DA,15)),U),+DA)=""
 S X=DG(DQ),DIC=DIE
 D SACLAU^TIUDD0(1202,X)
 Q
X1 Q
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 G A
3 S DQ=4 ;@2
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="12;4",DV="P200'O",DU="",DLB="EXPECTED SIGNER",DIFLD=1204
 S DQ(4,2)="S Y(0)=Y S:+Y>0&$D(TIUSIG) Y=$S($L($P(^VA(200,+Y,20),U,2)):$P(^(20),U,2),1:$P(^VA(200,+Y,0),U)) S:+Y>0&'$D(TIUSIG) Y=$P(^VA(200,+Y,0),U)"
 S DU="VA(200,"
 S X=$P($G(^TIU(8925,+DA,12)),U,2)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X4 Q
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 S TIUESNR=X
 Q
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 I +$P($G(^TIU(8925,+DA,13)),U,2) S Y="@5"
 Q
7 S DW="13;2",DV="P200'O",DU="",DLB="ENTERED BY",DIFLD=1302
 S DQ(7,2)="S Y(0)=Y S Y=$S(+$G(TIUINI):$$LOWER^TIULS($P($G(^VA(200,+Y(0),0)),U,2)),1:$P($G(^VA(200,+Y(0),0)),U,2))"
 S DE(DW)="C7^TIUEPN5"
 S DU="VA(200,"
 S X=DUZ
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C7 G C7S:$D(DE(7))[0 K DB S X=DE(7),DIC=DIE
 K ^TIU(8925,"TC",$E(X,1,30),DA)
 S X=DE(7),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"ATC",+X,+$P($G(^TIU(8925,+DA,0)),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)
 S X=DE(7),DIC=DIE
 D KACLAU1^TIUDD01(1302,X)
C7S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^TIU(8925,"TC",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ATC",+X,+$P($G(^TIU(8925,+DA,0)),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=DG(DQ),DIC=DIE
 D SACLAU1^TIUDD0(1302,X)
 Q
X7 Q
8 S DQ=9 ;@5
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 I +$P($G(^TIU(8925,+DA,12)),U) S Y="@6"
 Q
10 D:$D(DG)>9 F^DIE17 G ^TIUEPN6
