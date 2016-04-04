DICATT1 ;SFISC/GFT,XAK-NODE AND PIECE, SUBFILE ;21APR2008
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1032**
 ;
 I DA=.001 S W=" " G 2
 S (DG,W)=$P(O,U,4) G M:W="" S T=0,DP=DA,Y=$P(W,";"),N=$P(W,";",2) D MX S L=L-T D MAX I T+3<$G(^DD("STRING_LIMIT"),255) S W=DG G ^DICATT2
 D TOO G NO^DICATT2
M K DE,DG W !,"WILL "_F_" FIELD BE MULTIPLE" S %=2 D YN^DICN I % S V=%=1 G BACK:%<0,SUB
 W !,"FOR A GIVEN ENTRY, WILL THERE BE MORE THAN 1 "_F,!," ON FILE AT ONCE?" G M
E ;
 S V=0,DE(3)=$S($D(^(3)):^(3),1:""),T=0,DP=E,N=$P($P(DE,U,4),";",2) D MX S L=T
SUB S:$P(DIZ,"^")["K" V=1 S T=0 F Y=0:1 Q:'$D(^DD(A,"GL",Y+1))
 D MAX:'V I T>245!$D(^DD(A,"GL",Y,0))!V S Y=$S(+Y=Y:Y+1,1:$C($A(Y)+1))
 G SB:DUZ(0)'="@"
 W !!,"SUBSCRIPT: ",Y,"// " R X:DTIME S:'$T X=U,DTOUT=1 S:X="" X=Y
 I X'?.ANP W !?5,$C(7),"Control Characters are not allowed." G SUB
 I +X'=X G BACK:X[U,DICATT1^DIQQQ:X["?" I X?1P.E!(X[",")!(X[":")!(X[S)!(X[Q)!(X["=") G SUB
 I Y'=X S Y=X D MAX I T+5>$G(^DD("STRING_LIMIT"),255) D TOO G SUB
SB S W=Y,X=0 G V:V,U:$D(^DD(A,"GL",W,0))
PIECE S Y=1,P=0
PC S X=$O(^DD(A,"GL",W,X)) I X'="" S P=$P(X,",",2),Y=$S(Y>P:Y,1:P+1) G PC
 S X=-1 I P S Y="E"_Y_","_(L+Y-1)
 E  F Y=1:1 Q:'$D(^(Y))
 S P=Y I DUZ(0)="@" W !,"^-PIECE POSITION: ",Y,"// " R P:DTIME S:'$T DTOUT=1 G CHECK^DICATT:$D(DTOUT) S:P="" P=Y
 G PQ:P["?" I P?1"E"1N.N1","1N.N S N=$P(P,",",2)-$E(P,2,9)+1 G USED:N'<L W $C(7),!,"CAN'T BE <",L G PIECE
 I P>0,P<100,P\1=P G USED
 S W="" I X'[U W $C(7),"??" G SUB
BACK G CHECK^DICATT:$D(DTOUT),TYPE^DICATT2
 ;
PQ W "  TYPE A NUMBER FROM 1 TO 99"
 I Y=1 W !?9,"OR AN $EXTRACT RANGE (E.G., ""E2,4"")"
 E  W !?15,"CURRENTLY ASSIGNED:",! S Y="" F P=0:0 S Y=$O(^DD(A,"GL",W,Y)) Q:Y=""  S P=$O(^(Y,0)) I $D(^DD(A,P,0)) W ?11,$S(Y:"PIECE ",1:"")_Y,?22,"FIELD #"_P_", '"_$P(^(0),U,1)_"'",!
 G PIECE
 ;
USED S W=W_S_P,X=P G DE:'$D(^(X))
U W !,$C(7),X_" ALREADY USED FOR "_$P(^DD(A,$O(^(X,0)),0),U,1) G SUB
 ;
MAX S N=0 F T=L:0 S N=$O(^DD(A,"GL",Y,N)) Q:N=""  S DP=$O(^(N,0)) D MX
 S N=-1 Q
MX I N?1"E".E S T=T+$P(N,",",2)-$E(N,2,9)+1
 Q:'N  S P=$P(^DD(A,DP,0),U,2),W=$S(P["J":$P(P,"J",2),P["P":9,P["N":14,P["D":7,1:0) G W:W
 I P["S" F P=1:1 S X=$L($P($P($P(^(0),U,3),";",P),":",1)) S:X>W W=X G W:'X
 S W=$P(^(0),"$L(X)>",2),W='W*30+W
W S T=T+W+1 Q
 ;
V I $D(^DD(A,"GL",W)) W $C(7),!?9,"CAN'T STORE A "_$S($P(DIZ,U)["K":"MUMPS",1:"MULTIPLE")_" FIELD IN AN ALREADY-USED SUBSCRIPT!" G SUB
 I $P(Z,U)'["K" S W=W_S_0 S:$P(DIZ,U)["K" W=$P(W,";")_";E1,245"
DE I $D(DE) S ^DD(A,DA,0)=F_U_$P(DE,U,2,3)_U_W_U_$P(DE,U,5,99),DIK="^DD(A,",DA(1)=A,^(3)=DE(3),^("DT")=DT D IX1^DIK G N^DICATT
2 S:$P(Z,U)["K" V=0,W=W_";E1,245",M="This is Standard MUMPS code." G ^DICATT2
 ;
TOO W $C(7),!," TOO MUCH TO STORE AT THAT SUBSCRIPT!"
