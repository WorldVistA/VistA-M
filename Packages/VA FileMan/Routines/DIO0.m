DIO0 ;SFISC/GFT,TKW-BUILD SORT AND SUB-HDR ;2014-12-10  4:44 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**2,144,999,1003,1004,1005**
 ;
 S Z=Z+1,DE=$P(DN,",",Z)_"=$O("_DI_$P(DN,",",1,Z)_")),DN="_(Z+1)
 I Z=1,$G(DPP(DJK,"PTRIX"))]"" D
DIOO1 . S DE="DIOO1=$O("_DPP(DJK,"PTRIX")_"DIOO1)),DN=1.5,DD00=0"
 . S DY(1.5)="S DD00=$O("_DPP(DJK,"PTRIX")_"DIOO1,DD00)),DN=2 S:'DD00 DN=1"
 . I DPP(DJK,"PTRIX")?.E1"""B""," S DY(1.5)=DY(1.5)_" S:DD00&($G(^(+DD00))!('($D(^(+DD00))=1))) DN=1"
 . Q
 I DPQ,Z=1,$D(DPP(DJK,"IX")),$O(DPP(DJK,0)) D
 .S DXIX=$P(DPP(DJK),U) Q:'DXIX  S DXIX(DXIX)=U_$P(DPP(DJK,"IX"),U,2)_$S($D(DPP(DJK,"PTRIX")):"DD00,D0",1:DN)
 .S W=0,%(1)="" F %=0:0 S W=$O(DPP(DJK,W)) Q:'W  S %=%+1,%(1)=%(1)_",D"_%
 .S DXIX(DXIX)=DXIX(DXIX)_%(1)
 .K %,W Q
 I Z<$G(DPP(0)) S Y=$P($G(DPP(Z+1,"F")),U) I Y]""!($G(DPP(Z+1,"T"))]"") S:+$P(Y,"E")'=Y Y=""""_Y_"""" S DE=DE_","_$P(DN,",",Z+1)_"="_Y
 I 'DPQ,$D(DPP(Z)) D H
 I DPQ,Z=DD S DE=DE_" S:D0 DISTP=DISTP+1 D:'(DISTP#100) CSTP"_$P("^DIO2",1,$D(DIBTPGM))_" Q:'DN "
 S X=DE_" I "_$P(DN,",",Z)_$S(DD=Z:"'>0",1:"=""""")
 S Y="" D
 .I Z=1,$D(DPP(DJK,"T")),$D(DPP(DJK,"IX")) S Y=$P(DPP(DJK,"T"),U)
 .I $G(DPP(0)),Z<(DPP(0)+1) S Y=$P($G(DPP(Z,"T")),U)
 .I Y]"",Y'="@",Y'="z" S X=X_"!("_$$AFT^DIOC($P(DN,",",Z),Y)_")"
 .Q
D0 S X=X_" S DN="_$S(Z=DD&($D(DPP(DJK,"PTRIX"))):1.5,1:(Z-1)),Y=Z-1 I Z=1 S X=X_",D0=-1" I $D(DPP(DJK,"PTRIX")) S X=X_" K DD00",$P(DN,",")="DD00"
 I 'DPQ,$D(DPP(Y)) S:$P(DPP(Y),U,4)["!" X="DRK=DRK+1,"_X_",DRK=0",DRK=0 D SUB
 S DY(Z)="S "_X
 I $D(DIBTPGM) D
 . S DY(Z)=$S(Z'=1:"DY"_Z,1:"EN")_" Q:'DN  "_DY(Z)_$S(Z=1:" Q",Z=2&($D(DPP(DJK,"PTRIX"))):" G DYP",Z=2:" G EN",1:" G DY"_(Z-1))
 . I $D(DPP(DJK,"PTRIX")),Z=1 S DY(1.5)="DYP Q:'DN  "_DY(1.5)_" G:DN=1 EN"
 . Q
 G DIO0:Z<DD
 F %=1:1 Q:'$D(DPP(%))  K DPP(%,"PTRIX")
 S %=$S($G(DIO("SCR"))=1:"O",$D(DIS)<9:"O",$D(DIS)=11:"SCR",1:"SEARCH")
 S DY(Z+1)="S DN="_Z_" " I DJ["""B"",^" S DY(Z+1)=DY(Z+1)_"I $D("_DI_$P(DN,",",1,Z)_"))'[0,'^(D0) "
 S DY(Z+1)=DY(Z+1)_"D "_%,Y=Z,X=""
 I 'DPQ,$D(DPP(Y)),$P(DPP(Y),U,2)=0 D SUB I  S DY(Z+1)=DY(Z+1)_" S "_$E(X,2,99)
 I A=1 D:$D(DIBTPGM) SETU Q
 S X="," F W=1:1:A-1 S ^DOSV(0,IO(0),"BY",W)=DPP(A(W)),X=X_$P(DN,",",A(W))_",",A(W)="Q"
 S A(W)="S ^DOSV(0,IO(0),"_W_X_"V,DE)=Y"
HD I $G(DIOSTAHD),$G(^UTILITY($J,2))?1"W ".E S ^DOSV(0,IO(0),"HD")=^(2)
 F W=1:1:DPP S X=$$CONVQ^DILIBF($G(DPP(W,"TXT"))) I X]"",$P(DPP(W),U,4)'["+" D  S:X]"" ^("SHD")=$S($D(^DOSV(0,IO(0),"SHD")):^("SHD")_"  BY ",1:"")_X
 .N F,C S C=$F($P(DPP(W),U,5),";""") I C S Y=$P(DPP(W),U,3),F=$F(X,Y) I Y]"",F S C=$E(X,0,F-$L(Y)-1)_$P($E($P(DPP(W),U,5),C,99),"""") S X=$S(C]"":C_$E(X,F,999),1:"")
 D:$D(DIBTPGM) SETU Q
 ;
SUB I $P($G(DPP(Y)),U,4)["+" S A(A)=Y,X=X_",A="_A_" D"_$S($D(DIS)<9:"",1:":$D(DIPASS)")_" ^DIO3"_$S($D(DIS)<9:"",1:" K DIPASS"),A=A+1
 Q
 ;
H S DOP=0 I $D(DNP) F W=1:1 G Q:'$D(DPP(W)) I DPP(W)["+" K DNP S DOP=1 Q
 S Y=$P(DN,",",Z),F=$P(DPP(Z),U,5),W=$P(DPP(Z),U,4),X=$P(W,"""",2),V=+$P(DPP(Z),U,2) S:W["-" Y="(-"_Y_")" I F'[""""&'$D(DPQ(+DPP(Z),V+X))&'DOP!(W["@")!(W["'")!$D(DISH) S (Y,V)="" G F:F]"",U
 I F[";TXT" S Y="$E("_Y_",2,$L("_Y_"))"
EGP I '$D(^DD(+DPP(Z),V,0)) S X=$P(DPP(Z),U,6,9)
 E  D
 .N N,T
 .S X=^(0),N=$P(X,U)
 .S T=$$LABEL^DIALOGZ(+DPP(Z),V),$P(X,U)=T
 .I N=$P(DPP(Z),U,3) S $P(DPP(Z),U,3)=T
DT I $P(X,U,2)["D" S Y=" S Y="_Y_" D:Y<9999999 DT"
 E  I $G(DPP(Z,"OUT"))]"" S DPP(Z,"OUT")=" S Y="_Y_" "_DPP(Z,"OUT"),Y=",Y"
 E  I $P(X,U,2)["O"!($P(X,U,4)?.P) S Y=","_Y
DILL E  D EN^DILL(+DPP(Z),V,1)
 S V=$P(F,";C",2),V="?"_$S(V:V-1,1:Z*3+5)
F I F[";S" S %=$P(F,";S",2) S:'% %=1 S V=$E("!!!!!!!!!!!!!!!!!!!!!!!!!!!!",1,%)_V,M=M+%
 S F=$P(F,";""",2),%=$S(W["@":"",W["'":"",F]"":$P(F,"""",1,$L(F,"""")-1),Y]"":$P($P(DPP(Z),U,3),"""",1)_": ",1:""),Y=V_$S(%_Y]"":$E(",",V]"")_""""_%_"""",1:"")_Y I Y]"" S Y=" I DN D T"_$G(DPP(Z,"OUT"))_" W "_Y ;STOP IF ^
U S W=W'["#" I W,Y="",$D(DPP(Z+1)) G E
 S ^UTILITY($J,"H",Z)="X ^UTILITY($J,1)"_$P(":$Y>"_(DIOSL-M-2-DD+Z)_"!(DC["","")",U,W)_Y,Y="D H:DI<DN ",DE=DE_$S(Z=1:",DI=0",1:" S:DI>"_Z_" DI="_Z)
 S:^UTILITY($J,99,0)'[Y ^(0)=Y_^(0)
E I DOP S DNP=""
Q K DOP Q
 ;
SETU ;PUT DY ARRAY INTO ^UTILITY FOR LATER COMPILATION
 N DN
 F DN=0:0 S DN=$O(DY(DN)) Q:'DN  D
 .S ^TMP("DIBTC",$J,0,DICNT)=$E(" ",'$O(DY(DN)))_DY(DN),DICNT=DICNT+1
 .I '$O(DY(DN)) S ^TMP("DIBTC",$J,0,DICNT)=$S(DN>2:" G DY"_(DN-1),1:" G EN"),DICNT=DICNT+1
 .Q
 Q
