DIP2 ;SFISC/GFT-PRINT FLDS OR TEMPLATES ;2015-01-03  8:48 AM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999,1050**
 ;
 K ^UTILITY("DIP2",$J),DG,K,DISH,DIL,DXS,A,P,I,J S I(0)=DI,(DE,DINS,DV,DNP)="",(DXS,DL,R)=1,(DIPT,DJ,DCL,DIL)=0,DK=+$P(@(DI_"0)"),U,2),J(0)=DK
EN ;
F S (P,S)=""
1 ;
B S DU=$P(^DD(DK,0),U) I DL>1 S:DU="FIELD" DU=$O(^(0,"NM",0))_" "_DU I $O(^($O(^DD(DK,0))))'>0,$P(^(.01,0),U,2)["W" S:'DINS&DC DC=DC-2 S Y=.01 D P G N
 K DIC,Y K:$D(DALL)<9 DALL I ('L!($G(DDXP)=4)),$D(FLDS) S X=$P(FLDS,",",R),R=R+1 G LIT ;**CCO/NI
 I DC D ^DIP22:'$D(DC(DC)) ;DC is non-null if we are editing a Print Template.
2 W !?DL+DL-2 K X S X(1)=$$EZBLD^DIALOG($S(DE]""!($D(DJ)>9):7066,1:7065)),X(2)=DU W $$EZBLD^DIALOG($S($G(DDXP)=2:7064,1:7063),.X) K X ;'FIRST/THEN PRINT/EXPORT'
 I DC D RW(DC(DC)) G Q^DIP:X=U!($D(DTOUT)) S DINS=X?1"^"1E.E,X=$S(DINS:$E(X,2,999),X="":DC(DC),1:X) S:DC(DC)=""&$L(X) DINS=1 G XPCK
 I $D(DIRPIPE) X DIRPIPE G LIT ;XECUTABLE CODE FOR IHS
 I DL=1,DE="",$D(DJ)<9,'$D(DDXP) S Y=$$FIND^DIUCANON(.4,DK) I Y D  G LIT
 . N DIUCANON S DIUCANON=1
 . D RW("["_$P(Y,U,2)_"]")
 R X:DTIME S:'$T X=U G Q^DIP:X=U
 I X="ALL",DE="",$D(DJ)<2 D  G:$D(DIRUT) Q^DIP D:Y&($G(DDXP)=2) VALALL^DDXP2 G N:Y,F:'$D(X) W !?10,X
 . S DIR(0)="YA",DIR("A")=$$EZBLD^DIALOG(7067),DIR("B")="NO",DIR("?")=$$EZBLD^DIALOG(7067.1),%XX=X
 . D ^DIR S X=%XX K DIR,%XX S:$D(DIRUT) X=U Q
XPCK I $G(DDXP)=2 D VAL1^DDXP2 G:'$D(X) F
LIT I $E(X)="""",$L(X,"""")#2 F A9=3:2:$L(X,Q) Q:$P(X,Q,A9)]""&($E($P(X,Q,A9)'=$C(95)))
 I  I $P($P(X,Q,A9),";")="" K A9 S S=X G S:DINS,S:'$D(DIAR),S:DIAR'=4,S:'$D(DC(DC)),S:DC=0,Z^DIP22
 S DIC="^DD(DK,",DIC(0)=$E("ZE",1,'$D(FLDS)!''L+1)_$E("O",1,DC>0),DIC("W")="S %=$P(^(0),U,2) I % W $S($P(^DD(+%,.01,0),U,2)[""W"":""  (word-processing)"",1:""  (multiple)"")" S:$D(DICS) DIC("S")=DICS
DIC G DIC^DIP22
RTN I DC,X="@" D DC G F
NUMBER G DIP2^DIQQ:X?."?",Q^DIP:X=U I $P($$EZBLD^DIALOG(7099),X)="" W $P($$EZBLD^DIALOG(7099),X,2) S S=0_S G S ;**CCO/NI THE WORD 'NUMBER'
 S DIC(0)="EYZ",D="GR" I $D(^DD(DK,D)) D IX^DIC G GF:Y>0 I 'Y F Y=0:0 S Y=$O(Y(Y)) G F:Y="" S X=^DD(DK,Y,0) D Y
 G HARD^DIP22
 ;
GF I $G(DDXP)=2 D VAL2^DDXP2 G:'$D(Y(0)) F
 I $P(Y(0),U,2) D D,DC:DC S X=$P($P(Y(0),U,4),";",1),I(DIL)=$S(+X=X:X,1:Q_X_Q),J(DIL)=DK G 1
 I +Y=.001 S Y=0
 S S=+Y_S I P]"",$D(DCL(DK_U_+Y)) G QQ^DIP22
S I $G(DDXP)=2 D VAL3^DDXP2 G:'$D(S) F
 D DJ G F
 ;
D S DIL(DL)=DIL,DV(DL)=DV,DL(DL)=DK,DK=+$P(^DD(DK,+Y,0),U,2),DL=DL+1,DIL=DIL+1,DV=DV_+Y_C,Y=0 Q
 ;
U S DL=DL-1,DV=DV(DL),DK=DL(DL),DIL=DIL(DL) F %=DIL:0 S %=$O(I(%)) Q:%=""  K I(%),J(%)
 Q
 ;
DC I 'DINS K:DC>1 DC(DC) S DC=DC+1
 Q
 ;
Y S S=Y_S
DJ I $L(DE)+$L(S)>150 S DJ=DJ+1,^UTILITY("DIP2",$J,DJ)=DE,DE=""
 S DE=DE_DV_S_$C(126),S="" D DC:DC
P Q:'$D(P)  I P="" K DNP Q
 I P="*" S DCL=DCL+1
 S DCL(DK_U_+Y)=$S($T:DCL_P,1:P) Q
 ;
N S I=DL S:I=1 DALL=1
NN S Y=.001 I $D(^DD(DK,Y)) S Y=0 D Y S Y=.001
A S Y=$O(^DD(DK,Y)) I Y,$D(^(Y,8)),$D(DICS) X DICS E  G A
 I Y'>0 G UP:I'<DL S Y=$P(DV,C,DL-1) D U G A
 I $P(^(0),U,2) D D G NN
 D Y G A
 ;
UP K DIC I DL>1 D U,DC:DC G F
 I DE="",'DJ,'$D(DHIT),'$D(DIS) G F
 I $D(FLDS)>9 S X=$O(FLDS("")) I X]"" S FLDS=FLDS(X),R=1 K FLDS(X) G F
 G ^DIP3
 ;
RW(Y) ;sets X, and maybe DTOUT
 W Y I $L(Y)>19,'$G(DIUCANON) D RW^DIR2 Q
 W "// " R X:DTIME E  S X=U,DTOUT=1 W $C(7) Q
 S:X="" X=Y Q
 ;
 ;
 ;
ER S (X,DU)="[CAPTIONED]" G ^DIP21 ;WHAT CALLS THIS??
 ;7063= PRINT:
 ;7064= EXPORT:
 ;7065= FIRST
 ;7066= THEN
