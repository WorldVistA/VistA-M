DIU0 ;SFISC/XAK-EDIT/DELETE A FILE ;12NOV2008
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**82,116,76,160**
 ;
DIPZ ;
 D PZ,DIEZ Q
PZ ;Recompile PRINT Template routines
 S DIU2=$G(J(0)) N DIC,C,F,I,J,M,O,Q,S,T,V,W,Y
 F DIU0=0:0 S DIU0=$O(^DIPT("AF",DI,DA,DIU0)) Q:DIU0'>0  K ^(DIU0),^DIPT(DIU0,"ROU") S DMAX=^DD("ROU"),X=^DIPT(DIU0,"ROUOLD"),Y=DIU0,DIU1=DI D EN^DIPZ S DI=DIU1
 S J(0)=DIU2 D DT Q
 ;
IN(DI,DA) ;Recompile INput Templates containing Field DA, File DI
 N J,I D IJ^DIUTL(DI)
DIEZ N DL,DH,DQ,DIE,DIC,DNM,DR,M,T,F,Q,Y
 F DIU0=0:0 S DIU0=$O(^DIE("AF",DI,DA,DIU0)) Q:DIU0'>0  D
 . S X=$G(^DIE(DIU0,"ROUOLD"))
 . I X'?1(1A,1"%").7AN D  I X'?1(1A,1"%").7AN D UNC^DIEZ(DIU0) Q
 .. S X=$P($G(^DIE(DIU0,"ROU")),U,2)
 . K ^DIE("AF",DI,DA,DIU0),^DIE(DIU0,"ROU")
 . S DMAX=^DD("ROU"),Y=DIU0,DIU1=DI
 . D EN^DIEZ S DI=DIU1
DT I $D(^DD(DI,DA)) S:$P($G(^DIC(J(0),"%A")),U,2)-DT ^DD(DI,DA,"DT")=DT
 K DIU0,DIU1,DIU2 W ! Q
 ;
EN ;
 I DIU,DIU(0)["S" G SUB
 I DIU,$D(^DIC(DIU,0,"GL")) S DIU=^("GL")
 G Q:"(,"'[$E($RE(DIU))!DIU S DIK="^DIC(",DG=$G(@(DIU_"0)")),(A,DA)=+$P(DG,U,2) G Q:'A
 N DIKLGLBL I DIU(0)["D" S DIKLGLBL=$$CREF^DILF(DIU)
 D ^DIK G 61
6 ;
 N DIKLGLBL
 S DA=DI,%=$$SCREEN^DIBT("^D SCREENQ^DICATT") Q:%=U  G SCROLL:'%
 G ^DIU20
 ;
SCROLL S DR=".01:10;"_$P(20,U,$S($D(^DIC(200,0)):^(0)["NEW PERSON",$D(^DIC(3,0)):^(0)["USER"!(^(0)["EMPLOY"),1:0))
 S DIE=1,(A,DA)=DI,DIER=1 D  K DIER G N^DIU2:$D(DA)
 .N A D ^DIE
61 ; delete a FILE!
 S DQ(A)=0 K ^DIA(A) I $G(DIKLGLBL)]"" K @DIKLGLBL
63 W:DIU(0)["E" !?3,"Deleting the DATA DICTIONARY..." D KDD^DICATT4
 Q:DIU(0)["S"  G Q:DIU(0)'["T"
 F DIK="^DIE(","^DIPT(","^DIBT(" K @(DIK_"""F""_A)") W:DIU(0)["E" !?3,"Deleting the "_$P(^(0),U)_"S..." S DA=.9 F  S DA=$O(@(DIK_"DA)")) Q:DA'>0  I $D(^(DA,0)) S %=$P(^(0),U,4) I %=""!'$D(^DD(+%)) W:DIU(0)["E" "." D ^DIK
 D FORM^DDSDEL(A,DIU(0)["E")
Q K A,DA,DG,DIK,DQ Q
 ;
SUB G Q:'$D(^DD(DIU,0,"UP")) S DA(1)=^("UP"),DQ(DIU)=0
 I DIU(0)'["D" S A=DA(1) D 63 S A=DIU G SE
 S D0=DIU,S=";",Q=""""
 F I=1:1 Q:'$D(^DD(DIU,0,"UP"))  S A=^("UP"),%=$O(^DD(A,"SB",DIU,0)) Q:%=""  Q:'$D(^DD(A,%,0))#2  S %(I)=$P($P(^(0),U,4),S),DIU=A S:+%(I)'=%(I) %(I)=Q_%(I)_Q I I=1 S (O,M)=^(0)
 S DICL=I-2 F I=1:1:DICL+1 S I(I)=%(DICL-I+2)
 S I(0)=^DIC(DIU,0,"GL") K %
 D
 . N DIU0TOP,DIU0SFIL S DIU0TOP=A,DIU0SFIL=D0
 . N A,DA,D0,DICL,DIU,DQ,I,O,M,S,Q
 . D INDEX^DIKC(DIU0TOP,"","","","KiRW"_DIU0SFIL)
 D 63 S A=D0 D EN^DICATT4
SE S DIK="^DD("_DA(1)_",",DA=$O(^DD(DA(1),"SB",A,0)) D ^DIK:DA
 K D0,DICL,E,I,M,O,Q,S,T,X,Y G Q
