DIP2 ;SFISC/GFT-PRINT FLDS OR TEMPLATES ;2/10/94  09:48
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 K ^UTILITY("DIP2",$J),DG,K,DISH,DIL,DXS,A,P,I,J S I(0)=DI,(DE,DINS,DV,DNP)="",(DXS,DL,R)=1,(DIPT,DJ,DCL,DIL)=0,DK=+$P(@(DI_"0)"),U,2),J(0)=DK
EN ;
 ;I $D(DIAR),'$D(DIARP(DIARF)) G DIP2^DIARA:DIAR=1 D DIP2^DIARA
F S (P,S)=""
1 ;G B:DC,B:DE'="",B:'$D(FLDS)
 ;S DC=0,(X,DU)=FLDS
 ;G ^DIP21
B S DU=$P(^DD(DK,0),U) I DL>1 S:DU="FIELD" DU=$O(^(0,"NM",0))_" "_DU I $O(^($O(^DD(DK,0))))'>0,$P(^(.01,0),U,2)["W" S:'DINS&DC DC=DC-2 S Y=.01 D P G N
 K DIC,Y K:$D(DALL)<9 DALL I ('L!($G(DDXP)=4)),$D(FLDS) S X=$P(FLDS,C,R),R=R+1 G LIT
 I DC D ^DIP22:'$D(DC(DC))
2 W !?DL+DL-2,$S(DE]""!($D(DJ)>9):"THEN",1:"FIRST")_$S($G(DDXP)=2:" EXPORT ",1:" PRINT ")_DU_": "
 I DC W DC(DC) D RW G Q^DIP:X=U!($D(DTOUT)) S DINS=X?1"^"1E.E,X=$S(DINS:$E(X,2,999),X="":DC(DC),1:X) S:DC(DC)=""&$L(X) DINS=1 G XPCK
 I $D(DIRPIPE) X DIRPIPE G LIT
 R X:DTIME S:'$T X=U G Q^DIP:X=U
 I X="ALL",DE="",$D(DJ)<2 D  G:$D(DIRUT) Q^DIP D:Y&($G(DDXP)=2) VALALL^DDXP2 G N:Y,F:'$D(X) W !?10,X
 . S DIR(0)="YA",DIR("A")="  Do you mean ALL the fields in the file? ",DIR("B")="NO",DIR("?")="Choose YES for every field in the file; NO for a field starting with 'ALL'",%XX=X
 . D ^DIR S X=%XX K DIR,%XX S:$D(DIRUT) X=U Q
XPCK I $G(DDXP)=2 D VAL1^DDXP2 G:'$D(X) F
LIT I $E(X)="""",$L(X,"""")#2 F A9=3:2:$L(X,Q) Q:$P(X,Q,A9)]""&($E($P(X,Q,A9)'=$C(95)))
 I  I $P($P(X,Q,A9),";")="" K A9 S S=X G S:DINS,S:'$D(DIAR),S:DIAR'=4,S:'$D(DC(DC)),S:DC=0,Z^DIP22
 S DIC="^DD(DK,",DIC(0)=$E("ZE",1,'$D(FLDS)!''L+1)_$E("O",1,DC>0),DIC("W")="S %=$P(^(0),U,2) I % W $S($P(^DD(+%,.01,0),U,2)[""W"":""  (word-processing)"",1:""  (multiple)"")" S:$D(DICS) DIC("S")=DICS
DIC G DIC^DIP22
RTN I DC,X="@" D DC G F
 G DIP2^DIQQ:X?."?",Q^DIP:X=U I $P("NUMBER",X,1)="" W $P("NUMBER",X,2) S S=0_S G S
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
RW I $L(DC(DC))>19 S Y=DC(DC) D RW^DIR2 Q
 W "// " R X:DTIME S:'$T X=U,DTOUT=1 Q
 ;
ER S (X,DU)="[CAPTIONED]" G ^DIP21
