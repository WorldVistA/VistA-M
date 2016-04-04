DIFGA ;SFISC/XAK-FILEGRAM TEMPLATES ;3/5/93  1:22 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 S DIC=DI,(DIPT,DC(0))=DA,DC(1)=0 D INIT^DIFGA1,GET^DIFGB,L S L=1,DE="",DJ=0
 K DNP Q
 ;
EN D INIT^DIFGA1 I $D(DIAX) G Q:Y'>0
L D RD I X=U!$D(DTOUT) G Q
 I X="",DL=1 D:DJ ^DIFGB D:$D(DIAXE01)&'(U[X) F1^DIAXMS G:(+$G(DIERR)&'(U[X)) ERR G Q
 I 'DJ,$E(X)="[" D TEM^DIFGB G Q:X=U
 D PR
 I $D(Y(0)),+$P(Y(0),U,2),$P(^DD(+$P(Y(0),U,2),.01,0),U,2)["W" S Y(0)=$P(Y,U,2) I $D(DIAX) S $P(Y(0),U,2)=$P(^(0),U,2)
 D:$D(Y) ST G Q:$D(DIRUT)
 I DINS,DINS<DL S DINS(DINS)=DC,DC=0,DINS=""
 G L
ERR W !!,$C(7),"THE DESTINATION FILE DATA DICTIONARY SHOULD BE MODIFIED PRIOR TO ANY MOVEMENT",!,"OF EXTRACT DATA!"
Q G Q^DIFGA1
 ;
RD ;
 S DU=$P(^DD(DK,0),U) S:DU="FIELD" DU=$O(^(0,"NM",0))_" "_DU
 W !?DL+DL-2 W $S(DJ:" THEN",1:"FIRST")_$S($D(DIAX):" EXTRACT ",1:" SEND ")_DU_": "
 G 1:'DC
 D:'$D(DC(DC)) GET^DIFGB G 1:'DC W $P(DC(DC),U)
 I $L($P(DC(DC),U))>19 S Y=$P(DC(DC),U) D RW^DIR2 G 2
 I DC(DC)]"" W "// "
1 R X:DTIME I '$T S DTOUT=1 Q
2 Q:'DC  S DINS=X?1"^"1.E,X=$S(DINS:$E(X,2,999),X="":$P(DC(DC),U),1:X) S:DC(DC)=""&$L(X) DINS=1 S:DINS DINS=DL
 Q
PR ;
 S (S,DM,DIFG,DIFGLINK)="" K DIC,Y
 I X="" D UP Q
 I X?1"""".E1"""".E G QQ
 I X="ALL",'DJ W "  Do you mean ALL the fields in the file" S %=2 D YN^DICN S Y=$S(%<0:"",%=1:"ALL",1:%) Q:X[Y  W !?10,X
 S DIC="^DD(DK,",DIC(0)="ZE"_$E("O",DC>0),DIC("W")="W:$P(^(0),U,2) ""  (multiple)"""
 S DIC("S")=$S('$D(DIAX):"I $P(^(0),U,2)'[""C""",1:"") S:$D(DICS) DIC("S")=DIC("S")_" X DICS"
 D ^DIC Q:Y>0  I X?1"?".E K Y Q
 I DC,X="@" D DC K Y Q
 S DIC(0)="EYZ",D="GR" I $D(^DD(DK,D)),'$D(DIAX) D IX^DIC Q:$D(Y)=11
 G:X'?.E1":" QQ
 I $L(X,":")>2 S %=$O(^DD(DK,"B",$P(X,":"),0)) G:'% QQ G:$P(^DD(DK,%,0),U,2)'["C" QQ
 S DM=X,DQI="DIP(",DA="",DICOMP=DIL_$E("?",''L)_"T"
 S (DICOMPX,DICMX)="",DIFG=$S($L(X,":")>2:5,1:1) D ^DICOMPW G:'$D(X) QQ
 S:+DIFG("DICOMP")=DK DM=$P(^DD(DK,+$P(DIFG("DICOMP"),U,2),0),U,1)_":" S:DIFG?1A.E DIFGLINK=DIFG,DIFG=4 Q
ST ;
 I $D(DIAX),Y="ALL" W !,$C(7),"SORRY, THIS FUNCTIONALITY IS NOT SUPPORTED AT THIS TIME." Q
 I Y="ALL" D N S DJ=DJ+1 K DIFGALL Q
 I 'Y,$D(Y)=11 F Y=0:0 S Y=$O(Y(Y)) Q:Y'>0  S X=^DD(DK,Y,0) D Y
 Q:Y'>0
 I $D(DIAX),$D(Y)=11,$P(Y(0),U,2)["m" W !,$C(7),"SORRY, CANNOT EXTRACT THIS TYPE OF COMPUTED FIELD AT THIS TIME." Q
 I DIFG]"" S %=Y,S=U_$P(DP,U,2)_U_S,X=1 D D1 S DK=+DP,Y=0,DIL=+% D Y Q
 I $P(Y(0),U,2) S DM=$P(Y(0),U) D D,Y S X=$P($P(Y(0),U,4),";"),I(DIL)=$S(+X=X:X,1:$C(34)_X_$C(34)),J(DIL)=DK Q
 S Y=+Y D Y
 Q
 ;
D D D1 S DK=+$P(^DD(DK,+Y,0),U,2),DIL=DIL+1,Y=0,DIFG=3 Q
D1 S DJ1(DL)=DJ,DIL(DL)=DIL,DJ=0,C(DL)=C,DL(DL)=DK,DL=DL+1,(C,C(0))=C(0)+1
 Q
 ;
U S DL=DL-1,C=C(DL),DK=DL(DL),DIL=DIL(DL) S:$D(DIAX) (DIAXF,DIAXFILE)=DIAXDL(DL) S DJ=$S(DJ&'DJ1(DL):1,1:DJ1(DL)) K:DL=1 DIAXSB
 I $D(DINS(DL)) S DC=DINS(DL)-1 K DINS(DL)
 F %=DIL:0 S %=$O(I(%)) Q:%'>0  K I(%),J(%),DJ1(%)
 Q
 ;
DC I 'DINS K:DC>1 DC(DC) D DC1 S DC=DC+1
 Q
DC1 Q:(X'="@"!(DC'=2))  S DC=DC+1
 F  Q:'$D(DC(DC))  K DC(DC) S DC=DC+1
 S DC=DC-2 Q
 ;
Y S S=Y_S
DJ I $D(DIAX) D DIAX Q
 I C,'DJ1(DL-1) S:'$D(^UTILITY("DIFG",$J,C-1)) ^(C-1)=DL(DL-1)_U_(DL-1)_U_U_U_U_DT_U
 I '$D(^UTILITY("DIFG",$J,C))#2 S ^(C)=DK_U_DL_U_$S(DL>1:DL(DL-1),1:"")_U_DIFG_U_DM_U_DT_U_DIFGLINK
 S:$D(DIFGALL) $P(^UTILITY("DIFG",$J,C),U,8)=1
 S:S DJ=DJ+1,^(C,DJ)=S S S="" D DC:DC Q
 ;
N S I=DL,DM="ALL",DIFGALL=1 D Y S DM=""
NN S Y=.001 ;I $D(^DD(DK,Y)) D Y
A S Y=$O(^DD(DK,Y)) I $D(^(Y,8)),$D(DICS) X DICS E  G A
 I Y'>0 G UP:I'<DL D U S Y=Y(DL) G A
 I $P(^(0),U,2) G A:$P(^DD(+$P(^(0),U,2),.01,0),U,2)["W" S Y(DL)=Y D D,Y G NN
 G A ;D Y G A
 ;
UP K DIC I DL>1 D U,DC:DC
 Q
 ;
QQ W $C(7)," ??" K Y Q
 ;
DIAX I 'S,$G(DIFG)>2 S DIAXDICA=$S(DIFG=3:Y(0,0),1:DM) D ^DIAXMS I $D(DIAXUP) D UP K DIAXUP,DIAXSB Q
 S DIAXDK(DK)=DIAXF,DIAXDL(DL)=DIAXF
 I C,'$D(^UTILITY("DIFG",$J,C(DL-1))) S ^(C(DL-1))=DL(DL-1)_U_(DL-1)_U_U_U_U_DT_U_U_U_DIAXDL(DL-1)_U_DIAXDK(DL(DL-1)),DIAXE01(DIAXDL(DL-1))=(DL-1)_U_$G(DIAXSB)
 I '$D(^UTILITY("DIFG",$J,C))#2 S ^(C)=DK_U_DL_U_$S(DL>1:DL(DL-1),1:"")_U_DIFG_U_DM_U_DT_U_DIFGLINK_U_U_DIAXF_U_$S(DL>1:DIAXDK(DL(DL-1)),1:DIAXF)_U_$G(DIAXNP(DL-1)),DIAXE01(DIAXF)=DK_U_$G(DIAXSB)
 I S D EN2^DIAXM Q:$D(DIRUT)
 S S="" D DC:DC W ! Q
