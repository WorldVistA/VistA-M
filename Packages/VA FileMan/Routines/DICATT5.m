DICATT5 ;SFISC/XAK-POINTERS ;12:04 PM  25 Jan 2000
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**26**
 ;
7 K DIC S Y="",%=$P(O,U,3),DIC(0)="EFQIZ"
 S:$P(O,U,2)["P"&$L(%) Y=$S($D(@("^"_%_"0)")):$P(^(0),U),1:"")
 W !,"POINT TO WHICH FILE: " W:Y]"" Y_"// " R X:DTIME S:'$T DTOUT=1 G CHECK^DICATT:X=U!'$T I Y]"",X="" S X=Y,DIC(0)=DIC(0)_"O"
 S DIC=1,DIC("S")="I Y'=1.1 S DIFILE=+Y,DIAC=""RD"" D ^DIAC I %"
 D ^DIC K DIC,DIFILE,DIAC G:Y<0 7:X["?",T S X=^(0,"GL"),DE=Y G 77
T K DIC G CHECK^DICATT:$D(DTOUT),NO^DICATT2
77 S DIFILE=+Y,DIAC="LAYGO" D ^DIAC S %=0 S:'DIAC!($P($G(^DD(DIFILE,0,"DI")),U,2)["Y") %=2 K DIFILE,DIAC
P I % W !,$C(7) D A W !,"WILL NOT " D B
 E  S %=1+$S($P(O,U,2)["'":1,$P(O,U,2)']"":1,1:0) W !,"SHOULD " D A W ! D B,YN^DICN G T:%<1
 S Z="P"_+DE_$E("'",%=2)_X,C="Q",L=9,E=X G H:DUZ(0)'="@" D S G T:X=U,H
S ;
 S D=$S($D(^DD(A,DA,12.1)):^(12.1),1:""),%=2-(D]""),P=$S($D(^(12)):^(12),1:""),I=$S($D(^(12.2)):^(12.2),1:"")
 W !,"SHOULD '"_$P(DE,U,2)_"' ENTRIES BE SCREENED" D YN^DICN S:%<0 X=U Q:X=U  I '% W !?5,"Answer YES if there is a condition which should prohibit",!?5,"selection of some entries." G S
 I %=2 K ^(12.1),^(12),^(12.2) Q
 G M ;W !,"ENTER A TRUTH-VALUED EXPRESSION WHICH MUST BE TRUE OF ANY ENTRY POINTED TO:",!?4 I I]"" W I_"// " W:$X>35 !?4
 R X:DTIME S:'$T DTOUT=1 G T:X=U!'$T S:X="" X=I I X="" G M:DUZ(0)="@",S
 K DG,K S ^(12.2)=X,K=100,DQI="Y(",DG(K)=K,K(1,1)=K,(DLV,DLV0)=K,J(K)=+DE,I(K)=E,K=0 D EN^DICOMP
 G S:'$D(X) I $D(X)>1!(X[" ^DIC") W $C(7),!,"TOO COMPLICATED!" G S
 S I=0 I 'DBOOL W $C(7),!?8,"WARNING-- THIS DOESN'T LOOK LIKE A TRUTH-VALUED EXPRESSION"
D0 S I=$F(X,E_"D0",I) I I S X=$E(X,1,I-3)_"Y"_$E(X,I,999) G D0
Q S I=$F(X,"""",I) I I S X=$E(X,1,I-1)_""""_$E(X,I,999),I=I+1 G Q
 S (D,X)="S DIC(""S"")="""_X_" I X""" G E:DUZ(0)'="@"
M W !,"MUMPS CODE THAT WILL SET 'DIC(""S"")': " W:D]"" D S Y=D D:D]"" RW^DIR2 G S:X="@" I D']"" R X:DTIME S:'$T DTOUT=1 Q:X=U!'$T
 I X="" S X=D G S:X=""
 I X?."?" D HELP^DICATT4 G M
 D ^DIM:'$T I '$D(X) S X="" G S
 I X'["DIC(""S"")" W $C(7),!,?8,"WARNING - Screen Does Not Contain DIC(""S"")"
E W !,"EXPLANATION OF SCREEN: " W:P]"" P_"// " R %:DTIME S:'$T %=U,DTOUT=1 S:%="" %=P G S:%=U I %?.P W !?5,$C(7),"An explanation must be entered." G E
 I $D(^DD(A,DA,12.1)) S:X'=^(12.1) M(1)=0
 S ^DD(A,DA,12)=%,^(12.1)=X,Z="*"_Z S:Z?1"*P".E C=X_" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X" Q
H S DIZ=Z G ^DICATT1
 ;
A W "'ADDING A NEW "_$P(DE,U,2)_" FILE ENTRY' (""LAYGO"")" Q
B W "BE ALLOWED WHEN ANSWERING THE "_F_"' QUESTION" Q
 Q
