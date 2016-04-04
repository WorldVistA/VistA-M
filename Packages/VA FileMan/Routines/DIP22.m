DIP22 ;SFISC/GFT-EDIT PRINT TEMPLATE ;16MAR2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**2,43,97,113,999,1015**
 ;
 S DC(1)=$O(^DIPT(DC(0),"F",DC(1))),DC=0 Q:DC(1)=""   S DC=2,DY=^(DC(1)),Y=2
Y S X=$P(DY,$C(126)),DY=$P(DY,$C(126),2,99) I X="" G DIP22:'$D(DC(2)) Q
 I D9]"" G UP:$P(X,D9)]"" S X=$P(X,D9,2,99)
R I X'>0 G 0:$E(X,2)'=","&'X S:+X D9=D9_+X_",",DRK=-X G M
 I X["," S DA=$P(X,",") I +DA=DA S:DA<0 DA=-DA G Y:'$D(^DD(DRK,DA,0)) S X=$P(X,",",2,99),DC(Y)=$P(^(0),U),%=+X,D=+$P(^(0),U,2) G Y:'$D(^DD(D,.01,0)),W:$P(^(0),U,2)["W" S DRK=D,Y=Y+1,D9=D9_DA_"," G R
 S %=+X,D=DRK_U_% D DCL
 G Y:'$D(^DD(DRK,%,0))
W S X=$P(^(0),U)_$E(X,$L(%)+1,999)
P D  S DC(Y)=X,Y=Y+1 G Y
 .N % F  S %=$F(X,";;") Q:'%  S X=$E(X,1,%-2)_$E(X,%,9999)
0 S:X?1"0".E X=$S($D(^DD(DRK,.001,0)):$$LABEL^DIALOGZ(DRK,.001),1:$$EZBLD^DIALOG(7099))_$E(X,2,999) I P]"" S D=DRK_"^0" D DCL ;**CCO/NI COLUMN HEADING FOR NUMBER FIELD
M S %=$F(X,";Z;""") G P:'% S %=%-$L($P(X,";",1)),X=";"_$P(X,";",2,99) F D=%:0 S D=$F(X,"""",D) I ";"[$E(X,D) S X=$E(X,%,D-2)_$E(X,1,%-5)_$E(X,D,999) G P
 ;
UP S DRK=J(0),%=D9,DA=""
DOWN I X[",",+X=$P(X,","),$P(D9,DA_+X_",")="" S DA=DA_+X_",",%=$P(%,",",2,99),DRK=$S(X'>0:-X,1:+$P(^DD(DRK,+X,0),U,2)),X=$P(X,",",2,99) G DOWN
NUL S D9=DA,DC(Y)="",Y=Y+1,%=$P(%,",",2,99) G NUL:%]"",R
 ;
X ;who comes here??
 S DC(1)=DD D Y F D=2:1 Q:'$D(DC(D))  S X=DC(D) X DICMX I '$D(D) K DD Q
 Q
 ;
HARD ;
 S DM=X,DQI="DIP(",DA="DXS("_DXS_",",S=S_";Z;"""_X_"""",DICOMP=DIL_$E("?",''L)_"TI"
 S DICOMPX="" G JUMP:X?.E1":"
 S DICMX="X DICMX" D EN^DICOMP I '$D(X) G QQ:'$D(FLDS) S X=DM D ^DIM G QQ:'$D(X) S Y="X"
 D FLY G S^DIP2
 ;
JUMP S DICMX="S DIXX=DIXX("_DL_") D M^DIO2" D ^DICOMPW ;DICMX COULD BE INVOKED INSIDE SOME ROUTINE
 I $D(X) S %=Y D OVFL,F S S=U_$P(DP,U,2)_U_$E(1,%["m")_U_S,X=1,P="",DIL(DL)=DIL,DV(DL)=DV,DL(DL)=DK,DK=+DP,DV=DV_-DP_",",Y=0,DL=DL+1,DIL=+% K P G S^DIP2
QQ ;
 W $C(7),"??" G F^DIP2
 ;
FLY ;
 S:'$D(X) X=DM S %=Y["D"
 I % S:S'[";d" S=S_";d" I S'[";R",S'[";L",$G(DDXP)'=2 S S=S_";L18"
 I Y["W",S'[";X" S S=S_";X"
 I Y["m" S:S'[";m" S=S_";m" I Y["w",S'[";w" S S=S_";w"
 D OVFL I P="",Y'["X" S X=X_$S(S[";W":"",%:" S Y=X D DT",1:" W X")_" K DIP"
F S S=X_S S:P]"" S=S_";"_P
DXS F Y=0:0 S Y=$O(X(Y)) Q:Y=""  S DXS(DXS,Y)=X(Y)
 S DXS=$D(X)>1+DXS K DATE,X Q
 ;
OVFL I $L(X)+$L(S)>180!(X[";") S X(9)=X,X="X DXS("_DXS_",9)"
 Q
 ;
DIC I X=$$EZBLD^DIALOG(7099) S Y=X G B:'$D(DIAR),B:DIAR'=4,B:'$D(DC(DC)) ;**CCO/NI 'NUMBER'
 E  D DICW^DIALOGZ(DK),^DIC G E:'$D(DIAR),E:DIAR'=4,E:'$D(DC(DC)),RTN^DIP2:$E(X)="?"
 G E:'DC,E:$P(X,";")=$P(DC(DC),";"),E:$P($P(Y,U,2),";")=$P(DC(DC),";")
Z W !,$C(7),"Because this is an ARCHIVING process:"
 W !!,"You may ADD fields to output or CHANGE PREDEFINED FIELD formats"
 W !,"but NOT change, delete or do calculations on predefined fields.",!
 G 2^DIP2
E I $G(Y)>0 D:$G(S)[";B"  G GF^DIP2
 .N I S I=+$P(Y(0),U,2) I I,$D(^DD(I,0,"IX","B")) Q  ;B is good if multiple has B x-ref
 .I +Y=.01,'$D(^DIC(DK)),$D(^DD(DK,0,"IX","B")) Q
 .S I=$F(S,";B"),S=$E(S,1,I-3)_$E(S,I,999) ;otherwise strip it out
 G UP^DIP2:X="",^DIP21:X?1"[".E&(DE="")
B D  G:'$D(D) DIC S X=$RE(X) D  S X=$RE(X) G:'$D(D) DIC ;from beginning, then end
 .F D="+","#","*","&","!" I $E(X)=D S P=D,X=$E(X,2,999) K D Q
 I X[";" S S=";"_$P(X,";",2,99)_S,X=$P(X,";") G DIC
 I $E(X)="]" S X=$E(X,2,999),DALL(1)=1 G DIC
 G RTN^DIP2
 ;
DCL I $D(^DIPT(DC(0),"DCL",D)) S X=X_$E(^(D),$L(^(D)))
 Q
