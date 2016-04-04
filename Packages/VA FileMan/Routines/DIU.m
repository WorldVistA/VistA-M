DIU ;SFISC/GFT-UTILITY FUNCTIONS ;7NOV2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1021,1023,1044**
 ;
 K DIU
0 S DIC="^DOPT(""DIU"","
 G OPT:$D(^DOPT("DIU",11)) S ^(0)="UTILITY OPTION^1.01" K ^("B")
 F X=1:1:11 S ^DOPT("DIU",X,0)=$P($T(@X),";;",2)
 S DIK=DIC D IXALL^DIK S ^DOPT("DICR",0)="TYPE OF INDEXING^1.01"
 F X=1:1:7 S ^DOPT("DICR",X,0)=$P("REGULAR^KWIC^MNEMONIC^MUMPS^SOUNDEX^TRIGGER^BULLETIN",U,X)
 S DIK="^DOPT(""DICR""," D IXALL^DIK G 0
OPT ;
 S DIC(0)="AEQIZ" S:DUZ(0)'="@" DIC("S")="I Y-5"
 D ^DIC G Q:Y<0 S DI=Y D EN G 0
 ;
EN ;
 I +DI=2 D  G:'$D(DI) Q
 . W ! S Y=$$TYPE^DIKCUTL2 Q:Y=1
 . D:Y=2 MOD^DIKCUTL
 . K DI
 D D^DICRW G Q:Y<0 I '$D(DIC) D DIE^DIB G Q:'$D(DG) S DIC=DG
 S DIU=DIC,DIU(0)="EDT" K DICS
 K DIC,I,J S Y=DI,N=0,DI=+$P($G(@(DIU_"0)")),U,2),J(0)=DI,I(0)=DIU
 I 'DI W $C(7),!,"Missing or incomplete global node "_DIU_"0)",! G Q
DDA S DDA=""
 D @+Y W !!
Q K %,DIUF,DG,DGG,DIC,DIU,DJJ,DIK,DI,DA,I,J,X,Y,DICD,DICDF,DDA,DIFLD,DTOUT,DUOUT,DR Q
 ;
1 ;;VERIFY FIELDS
 G ^DIV
 ;
2 ;;CROSS-REFERENCE A FIELD OR FILE
 S X="CW" D DI Q:Y<.002  G ^DICD
 ;
3 ;;IDENTIFIER
 S X="CW.01" D DIAX Q:'$T  D DI Q:Y<0  G 3^DIU3
 ;
4 ;;RE-INDEX FILE
 G 4^DIU1
 ;
5 ;;INPUT TRANSFORM (SYNTAX)
 S X="W" D DIAX Q:'$T  D DI Q:Y<0  G 5^DIU31
 ;
6 ;;EDIT FILE
 G 6^DIU0
 ;
7 ;;OUTPUT TRANSFORM
 S X="CW" D DI Q:Y<0  G O^DIU31
 ;
8 ;;TEMPLATE EDIT
 G 0^DIBT
 ;
9 ;;UNEDITABLE DATA
 S X="C" D DIAX Q:'$T  D DI Q:Y<0  G 9^DIU31
 ;
10 ;;MANDATORY/REQUIRED FIELD CHECK
 G ^DIVRE
 ;
11 ;;KEY DEFINITION
 G MOD^DIKKUTL
 ;
99 ;;SPECIFIER
 S X="CW",N=0 D DI Q:Y<0  G ^DIU4 ;NOT USED??
 ;
DI ;
 S DIC(0)="ZQEAI"
D ;
 S DIC="^DD("_DI_",",DIC("W")="S %=$P(^(0),U,2) I % W $S($P(^DD(+%,.01,0),U,2)[""W"":""  (word-processing)"",1:""  (multiple)"")"
 S DIC("S")="S %=$P(^(0),U,2) I 1"_$P(",$O(^(1,0))!%","Z",X["R")_$P(",%'[""C""",U,X["C")_$P(",$P(^DD(+%,.01,0),U,2)'[""W""",9,X["W")_$P(",Y-.01",U,X[.01),DA=X
 D ^DIC K DIC("S") I Y>0,$P(Y(0),U,2) S N=N+1,X=$P($P(Y(0),U,4),";",1),DI=$E("""",+X'=X),I(N)=DI_X_DI,(DI,J(N))=+$P(Y(0),U,2),X=DA G DI:$P(^DD(DI,.01,0),U,2)'["W" S Y(0)=^(0),Y=.01_U_$P(Y(0),U)
 Q
DIAX I '$D(^DD(DI,0,"DI"))!($P($G(^("DI")),U)'["Y")!($P($G(^("DI")),U)["Y"&'$P(@(^DIC(DI,0,"GL")_"0)"),U,4))
 W:'$T !!,$C(7),"THIS DATA DICTIONARY CHANGE IS NOT ALLOWED ON AN ARCHIVE FILE!"
 Q
