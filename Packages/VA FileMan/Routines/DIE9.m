DIE9 ;SFISC/GFT-JUMPING, FILING, MULTIPLES ;8:03 AM  13 Aug 1997
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 G:$A(X)-94 X:'$P(DW,";E",2),@("T^"_DNM)
 I $D(DIE("NO^")),DIE("NO^")="OUTOK"'&(X=U) W $C(7),!?3,"Sorry, ""^"" is not allowed!" G B
 S X=$P(X,U,2),DIC(0)="E"
OUT I 0[X S DM=DW D FILE G ABORT:DL=1,R
 I X?1"@".N,$D(^DIE("AF",X,DIEZ)) S DNM=^(DIEZ)
 E  S DIC="^DD("_DP_",",DIC("S")="I $D(^DIE(""AF"","_DP_",Y,DIEZ))" D ^DIC K DIC S DIC=DIE G X:Y<0 S DNM=^DIE("AF",DP,+Y,DIEZ)
 D FILE S Y=DNM,DNM=$P(Y,U,2),DQ=+Y,D=0 D @("DE^"_DNM) G @Y
 ;
F ;
 S DC=$S($D(X)#2:X,1:0) D FILE S X=DC Q
FILE ;
 K DQ Q:$D(DG)<9  S DQ="",DU=-2,DG="$D("_DIE_DA_",DU))"
Y S DQ=$O(DG(DQ)),DW=$P(DQ,";",2) G DE:$P(DQ,";",1)=DU
 I DU'<0 S ^(DU)=DV,DU=-2
 G E1:DQ="" S DU=$P(DQ,";",1),DV="" I @DG S DV=^(DU)
DE I 'DW S DW=$E(DW,2,99),DE=DW-$L(DV)-1,%=$P(DW,",",2)+1,X=$E(DV,%,999),DV=$E(DV,0,DW-1)_$J("",$S(DE>0:DE,1:0))_DG(DQ) S:X'?." " DV=DV_$J("",%-DW-$L(DG(DQ)))_X G Y
PC S $P(DV,U,DW)=DG(DQ) G Y
 ;
IX I $D(DE(DE(DQ)))#2 F DG=1:1 Q:'$D(DE(DQ,DG))  S DIC=DIE,X=DE(DE(DQ)) X DE(DQ,DG,2)
 S X="" I DG(DQ)]"" F DG=1:1 Q:'$D(DE(DQ,DG))  S DIC=DIE,X=DG(DQ) X DE(DQ,DG,1)
K K DE(DQ)
E1 S DQ=$O(DE(" ")) I DQ'="" G IX:$D(DG(DQ)),K
 K DG,DE,DIFLD S DQ=0 Q
 ;
AST S E=DQ(DQ),Y=$F(E," D ^DIC"),%=8
 I 'Y S Y=$F(E," D IX^DIC"),%=10 G V^DIED:'Y
 S %DD=Y+1 X $P($E(E,1,Y-%),U,5,99) G V^DIED:'$D(DIC("S"))
 S DICSS=DIC("S") D ^DIC S X=+Y
 I $P(Y,U,3) S Y=+Y X:$D(@(DIC_Y_",0)")) DICSS I '$T S D=DA,DA=Y,DIK=DIC D ^DIK K DICSS S DA=D,DV=$P(E,U,2),DU=$P(E,U,3) G X^DIED
 K DICSS X:Y>0 $E(E,%DD,999) K %DD G X^DIED:'$D(X),X^DIED:X<0,Z^DIED
1 ;
 D FILE
R D UP G @("R"_DQ_U_DNM)
 ;
UP S DNM=DNM(DL),DQ=DNM(DL,0),%=2 I $D(DIEC(DL)) D DIEC^DIE1 G U
 S DA=DA(1) K DA(1)
DA I $D(DA(%)) S DA(%-1)=DA(%) K DA(%) S %=%+1 G DA
 S:$D(DIEZTMP)#2 DIIENS=$P(DIIENS,",",2,999)
U K DTOUT,DNM(DL) S DL=DL-1 Q
 ;
X W:'$D(ZTQUEUED) $C(7),"??"
B G @(DQ_U_DNM)
 ;
N D DOWN S DA=$P(DC,U,4),D=0,^DISV(DUZ,$E(DIC,1,28))=$E(DIC,29,999)_DA
D1 S @("D"_(DL-1))=DA G @(DGO)
 ;
M S DD=X D DOWN S DO(2)=$P(DC,"^",2),DO=DOW_"^"_DO(2)_"^"_$P(DC,"^",4,5),DIC(0)=$P("QE",U,'$D(DB(DNM(DL,0))))_"LM" I @("'$D("_DIC_"0))") S ^(0)="^"_DO(2)
 E  I DO(2)["I" S %=0,DIC("W")="" D W^DIC1
 K DICR S D="B",DLAYGO=DP\1,X=DD D X^DIC I Y'>0 D UP G @(DQ_U_DNM)
 S DA=+Y,X=$P(Y,U,2),D=$P(Y,U,3) G D1
 ;
DOWN S DL=DL+1,DNM(DL)=DNM,DNM(DL,0)=DQ D FILE
DDA F %=DL+1:-1:1 I $D(DA(%)) S DA(%+1)=DA(%)
 S DA(1)=DA,DIC=DIE_DA_","""_$P(DC,U,3)_"""," Q
 ;
ABORT D E S Y(DM)="" Q
 ;
0 ;
 D FILE
E K DIP,Y,DE,DB,DP,DW,DU,DC,DV,DH,DIL,DNM,DIEZ,DLB
