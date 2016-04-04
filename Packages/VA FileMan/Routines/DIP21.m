DIP21 ;SFISC/XAK-PRINT TEMPLATE ;22JULY2014
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999,1050**
 ;
 D D S DIC(0)=$E("E",'$D(FLDS)!''L)_"QZSI"
 S DIC("S")="I $D(^(""F""))"_$S($G(DIAR)=4:",$D(^(1))",$G(DDXP)=2:",$P(^(0),U,8)=7",$G(DDXP)=4:",$P(^(0),U,8)=3",1:"")_" "_DIC("S") S:$G(DDXP)=4 DIC("W")=""
 D IX^DIC K DIC S:(+Y=.01&(DUZ(0)'="@")) DICSS=$$ACC(8) I Y<0 G Q^DIP:$D(DTOUT),^DIP2:L,^DIP2:'$D(FLDS),Q^DIP
 I L,+Y=.01 K DPQ(DK) S DIQ(0)="" D C^DII G:$D(DIRUT) Q^DIP
EDITQ I L,Y'<1,(('$P(^DIPT(+Y,0),U,8))!($G(DDXP)=2&($P(^DIPT(+Y,0),U,8)=7))),'$G(^("CANONIC")) D W:DUZ(0)'="@" I  S %=2 W !,$$EZBLD^DIALOG(8196,$P(Y,U,2)) D YN^DICN G ED^DIP23:%=1 ;'WANT TO EDIT'?
 K:'$D(^DIPT(+Y,"DNP")) DNP S DIPT=+Y,DALL=1,DHD=$S($D(DHD)#2:DHD,$D(^("H")):^("H"),1:""),DC(0)=+Y I $D(^("SUB")),^("SUB") S:'$G(DPP(0)) DISH=1
 D F I $G(^DIPT(+Y,"ROU"))[U,$$ROUEXIST^DILIBF($P(^("ROU"),U,2)) S DIPZ=+Y G PAGE^DIP3:DHD="@"
 Q:$D(DTOUT)  G H^DIP3
F ;
 S DE="",R=0
 F X=0:0 S R=$O(^DIPT(+Y,"DCL",R)) Q:R=""  F D=1:1 Q:D>$L(^(R))  S Z=$E(^(R),D) I Z?1P S DCL(R)=$G(DCL(R))_Z
 F X=0:0 S X=$O(^DIPT(+Y,"DXS",X)),%=-1 Q:X=""  Q:$O(^(X,%))=""  I '$D(DIPZ)!$D(^(9.2))!$D(^(9)) F X=X:0 S %=$O(^(%)) Q:%=""  S DXS(X,%)=^(%)
 Q
XPUT ;
 D XPDIP21^DIQQQ
PUT ;
 D NOW^%DTC S DIPDT=+$J(%,0,4) W !,"STORE "_$S($G(DDXP)=2:"EXPORT",1:"PRINT")_" LOGIC IN TEMPLATE: " R X:DTIME G Q^DIP:X=U!'$T,XPUT:($D(DDXP)&(X="")),OUT:X=""
 D D S DIC(0)="ELZSQ",DIC("S")="I Y'<1,$P(^(0),U,8)'=1,$P(^(0),U,8)'=3 "_DIC("S"),Y=-1,DLAYGO=0 D IX^DIC:X]"" K DIC,DLAYGO G:Y<0 PUT:X'[U,Q^DIP
 S S=$O(^DIPT(+Y,0)),DA=$S('$D(^("ROU")):1,^("ROU")'[U:1,'$D(^("IOM")):1,'$D(^("ROUOLD")):1,1:^("ROUOLD")) S:'DA IOM=^("IOM")
 I S]"" W $C(7),!,"TEMPLATE ALREADY STORED THERE...." D W:DUZ(0)'="@" G PUT:'$T W " OK TO REPLACE" S %=0 D YN^DICN W ! G PUT:%-1 L +^DIPT S %Y="" F %X=0:0 S %Y=$O(^DIPT(+Y,%Y)) Q:%Y=""  K:",%D,ROUOLD,W,"'[(","_%Y_",") ^DIPT(+Y,%Y)
EGP S ^DIPT("F"_J(0),$P(Y,U,2),+Y)=1,^DIPT(+Y,0)=$P(Y,U,2)_U_DIPDT_U_$S(S!(S=""):DUZ(0),1:$P(Y(0),U,3))_U_J(0)_U_DUZ_U_$S(S!(S=""):DUZ(0),1:$P(Y(0),U,6))_U_DT S:$D(DNP) ^("DNP")=1 ;*CCO/NI PLUS NEXT 3 LINES REMEMBER HEADING LANGUAGE
 I DHD]"" S ^("H")=DHD I $G(DUZ("LANG")) S ^("HLANG")=DUZ("LANG")
 S X=$D(^("DCL",0))
 L -^DIPT K DIPDT,%I
 F S=0:0 S X=$O(DCL(X)) Q:X=""  S ^(X)=DCL(X)
 F S=0:0 S S=$O(DXS(S)) Q:S=""  F %=0:0 S %=$O(DXS(S,%)) Q:%=""  S ^DIPT(+Y,"DXS",S,%)=DXS(S,%)
 F S=1:1:DJ S ^DIPT(+Y,"F",S)=^UTILITY("DIP2",$J,S)
 I DE]"" S ^DIPT(+Y,"F",S+1)=DE
 I $G(DDXP)=2 S DDXPFDTM=+Y G Q^DIP
 I $D(DIAR) S DIARP=+Y
SUB I DHD="@" W !,$$EZBLD^DIALOG(8195) S %=1 D YN^DICN G DIP21^DIQQQ:'%,Q^DIP:%<0 I %=1 S ^DIPT(+Y,"SUB")=1 S:'$G(DPP(0)) DISH=1 ;**CCO/NI  SUBHEADERS QUESTION
 I 'DA,$D(^DD("OS",DISYS,"ZS")) S X=DA,DMAX=^DD("ROU") D ENDIP^DIPZ I $D(^DIPT(DIPZ,"H")) S DHD=^("H")
OUT G PAGE^DIP3
 ;
W S %=$P(^(0),U,6) F X=1:1:$L(%) I DUZ(0)[$E(%,X) Q
 Q
D ;
 S X=$P(X,"]"),X=$P(X,"[")_$P(X,"[",2),D="F"_DK S:'$D(^DIPT(D,"CAPTIONED",.01)) ^(.01)=1 I $D(^DIPT("B","WPDI",.001)),'$D(^DIPT(D,"WPDI",.001)) S ^(.001)=1
 K DIC S DIC="^DIPT("
 S DIC("S")="S %=^(0) I $P(%,U,8)'=2!($G(DIAR)=6),$P(%,U,8)'=3!($G(DDXP)=4),$P(%,U,8)'=7!($G(DDXP)=2),$P(%,U,4)=DK!'$L($P(%,U,4))"_$P(" F DW=1:1:$L($P(%,U,3)) I DUZ(0)[$E($P(%,U,3),DW) Q",U,DUZ(0)'="@"&(L!($D(DIASKHD))))
 Q
ACC(ND) ;set xcutable code to check FIELD access (in ND) against DUZ(0)
 N A
 S A="N % I 1 Q:'$D(^("_ND_"))  F %=1:1:$L(^("_ND_")) I DUZ(0)[$E(^("_ND_"),%) Q"
 Q A
