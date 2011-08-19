DIO0 ;SFISC/GFT,TKW-BUILD SORT AND SUB-HDR ;28SEP2004
 ;;22.0;VA FileMan;**2,23,138,144**;Mar 30, 1999;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 S C=",",Z=Z+1,DE=$P(DN,C,Z)_"=$O("_DI_$P(DN,C,1,Z)_")),DN="_(Z+1) ;22*138
 I Z=1,$G(DPP(DJK,"PTRIX"))]"" D
DIOO1 . S DE="DIOO1=$O("_DPP(DJK,"PTRIX")_"DIOO1)),DN=1.5,DD00=0"
 . S DY(1.5)="S DD00=$O("_DPP(DJK,"PTRIX")_"DIOO1,DD00)),DN=2 S:'DD00 DN=1"
 . I DPP(DJK,"PTRIX")?.E1"""B""," S DY(1.5)=DY(1.5)_" S:DD00&($G(^(+DD00))!('($D(^(+DD00))=1))) DN=1"
 . Q
 I DPQ,Z=1,$D(DPP(DJK,"IX")),$O(DPP(DJK,0)) D
 .S DXIX=$P(DPP(DJK),U) Q:'DXIX  S DXIX(DXIX)=U_$P(DPP(DJK,"IX"),U,2)_$S($D(DPP(DJK,"PTRIX")):"DD00,D0",1:DN)
 .S W=0,%(1)="" F %=0:0 S W=$O(DPP(DJK,W)) Q:'W  S %=%+1,%(1)=%(1)_C_"D"_%
 .S DXIX(DXIX)=DXIX(DXIX)_%(1)
 .K %,W Q
 I Z<$G(DPP(0)) S Y=$P($G(DPP(Z+1,"F")),U) I Y]""!($G(DPP(Z+1,"T"))]"") S:+$P(Y,"E")'=Y Y=""""_Y_"""" S DE=DE_","_$P(DN,C,Z+1)_"="_Y
 I 'DPQ,$D(DPP(Z)) D H
 I DPQ,Z=DD S DE=DE_" S:D0 DISTP=DISTP+1 D:'(DISTP#100) CSTP"_$P("^DIO2",1,$D(DIBTPGM))_" Q:'DN "
 S X=DE_" I "_$P(DN,C,Z)_$S(DD=Z:"'>0",1:"=""""")
 S Y="" D
 .I Z=1,$D(DPP(DJK,"T")),$D(DPP(DJK,"IX")) S Y=$P(DPP(DJK,"T"),U)
 .I $G(DPP(0)),Z<(DPP(0)+1) S Y=$P($G(DPP(Z,"T")),U)
 .I Y]"",Y'="@",Y'="z" S X=X_"!("_$$AFT^DIOC($P(DN,C,Z),Y)_")"
 .Q
D0 S X=X_" S DN="_$S(Z=DD&($D(DPP(DJK,"PTRIX"))):1.5,1:(Z-1)),Y=Z-1 I Z=1 S X=X_",D0=-1" I $D(DPP(DJK,"PTRIX")) S X=X_" K DD00",$P(DN,C,1)="DD00"
 I 'DPQ,$D(DPP(Y)) S:$P(DPP(Y),U,4)["!" X="DRK=DRK+1,"_X_",DRK=0",DRK=0 D SUB
 S DY(Z)="S "_X
 I $D(DIBTPGM) D
 . S DY(Z)=$S(Z'=1:"DY"_Z,1:"EN")_" Q:'DN  "_DY(Z)_$S(Z=1:" Q",Z=2&($D(DPP(DJK,"PTRIX"))):" G DYP",Z=2:" G EN",1:" G DY"_(Z-1))
 . I $D(DPP(DJK,"PTRIX")),Z=1 S DY(1.5)="DYP Q:'DN  "_DY(1.5)_" G:DN=1 EN"
 . Q
 G DIO0:Z<DD
 F %=1:1 Q:'$D(DPP(%))  K DPP(%,"PTRIX")
 S %=$S($G(DIO("SCR"))=1:"O",$D(DIS)<9:"O",$D(DIS)=11:"SCR",1:"SEARCH")
 S DY(Z+1)="S DN="_Z_" " I DJ["""B"",^" S DY(Z+1)=DY(Z+1)_"I $D("_DI_$P(DN,C,1,Z)_"))'[0,'^(D0) "
 S DY(Z+1)=DY(Z+1)_"D "_%,Y=Z,X=""
 I 'DPQ,$D(DPP(Y)),$P(DPP(Y),U,2)=0 D SUB I  S DY(Z+1)=DY(Z+1)_" S "_$E(X,2,99)
 I A=1 D:$D(DIBTPGM) SETU Q
 S X=C F W=1:1:A-1 S ^DOSV(0,IO(0),"BY",W)=DPP(A(W)),X=X_$P(DN,C,A(W))_C,A(W)="Q"
 S A(W)="S ^DOSV(0,IO(0)"_C_W_X_"V,DE)=Y"
 D:$D(DIBTPGM) SETU Q
 ;
SUB I $P($G(DPP(Y)),U,4)["+" S A(A)=Y,X=X_",A="_A_" D"_$S($D(DIS)<9:"",1:":$D(DIPASS)")_" ^DIO3"_$S($D(DIS)<9:"",1:" K DIPASS"),A=A+1
 Q
 ;
H S DOP=0 I $D(DNP) F W=1:1 G Q:'$D(DPP(W)) I DPP(W)["+" K DNP S DOP=1 Q
 S Y=$P(DN,",",Z),F=$P(DPP(Z),U,5),W=$P(DPP(Z),U,4),X=$P(W,"""",2),V=+$P(DPP(Z),U,2) S:W["-" Y="(-"_Y_")" I F'[""""&'$D(DPQ(+DPP(Z),V+X))&'DOP!(W["@")!(W["'")!$D(DISH) S (Y,V)="" G F:F]"",U
 I F[";TXT" S Y="$E("_Y_",2,$L("_Y_"))"
 S X=$S($D(^DD(+DPP(Z),V,0)):^(0),1:$P(DPP(Z),U,6,9)) I $P(X,U,2)["D" S Y=" S Y="_Y_" D DT"
 E  I $G(DPP(Z,"OUT"))]"" S DPP(Z,"OUT")=" S Y="_Y_" "_DPP(Z,"OUT"),Y=",Y"
 E  I $P(X,U,2)["O"!($P(X,U,4)?.P) S Y=C_Y
 E  D ^DILL
 S V=$P(F,";C",2),V="?"_$S(V:V-1,1:Z*3+5)
F I F[";S" S %=$P(F,";S",2) S:'% %=1 S V=$E("!!!!!!!!!!!!!!!!!!!!!!!!!!!!",1,%)_V,M=M+%
 S F=$P(F,";""",2),%=$S(W["@":"",W["'":"",F]"":$P(F,"""",1,$L(F,"""")-1),Y]"":$P($P(DPP(Z),U,3),"""",1)_": ",1:""),Y=V_$S(%_Y]"":$E(",",V]"")_""""_%_"""",1:"")_Y I Y]"" S Y=" D T"_$G(DPP(Z,"OUT"))_" W "_Y
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
