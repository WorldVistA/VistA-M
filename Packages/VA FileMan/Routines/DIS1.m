DIS1 ;SFISC/GFT-BUILD DIS-ARRAY ; 16 DEC 2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**6,77,97,113,144,1046**
 ;
 K DIS0 I $D(DL)#2 S DIS0=DL
 S DL(0)="" W ! G 1:$D(DE)>1!$D(DJ) I DL=1 S DL(0)=DL(1),DL=0 K DL(1)
 E  F P=2:1 S Y=$P(DL(1),U,P) Q:Y=""  S Y=U_Y_U,X=2 D 2
 F X=1:1 Q:'$D(DL(X))  F Y=X+1:1 Q:'$D(DL(Y))  I DL(X)=DL(Y)!(DL(Y)?.P) S DL=DL-1 K DL(Y) F P=Y:1:DL S DL(P)=DL(P+1) K DL(P+1)
1 D ENT G ^DIS2:'$D(DIAR),DIS^DIS2
 ;
ENT S DK(0)=DK,Z="D0," F DQ=0:1:DL K R,M D  S X=0,DQ(0)=DQ,R=-1 D MAKE S %=0 F  S R=$O(R(R)) Q:R=""  I R(R)<2 S DIS(R)=DIS(R)_" K D"
 . N I S I="" F  S I=$O(DI(I)) Q:'I  K DI(I)
 . Q
 S R=-1 Q
 ;
2 I X'>DL Q:DL(X)'[Y  S X=X+1 G 2
 S DL(0)=U_$P(Y,U,2)_DL(0),P=P-1
22 S X=X-1,DQ=$F(DL(X),Y),DL(X)=$E(DL(X),1,DQ-$L(Y))_$E(DL(X),DQ,999) G 22:X>1 Q
 ;
C S Y=Y_$S(DV="'":" I 'X",1:" I "_$$XFORM("X")_DV) D SD
MAKE S DC=DI,DQ=+DQ,X=X+1,Y=$P(DL(DQ),U,X+1) Q:Y=""
 S S=+Y,DN=$E("'",Y["'"),Y=DC(S),D=0,DL=0 I $D(DJ(DQ,S)) S D=$P(DJ(DQ,S),U,2),DL=+DJ(DQ,S) I $D(DI(DL)) S DC=DI(DL)
 S DQ=DQ(DL),Z=$P(Z,",",1,D+D+1)_",",DU=$P($P(Y,U),",",DL+1,99),O=DK(DL),DV=DN_$P(Y,U,2) I DV?1"''".E S DV=$E(DV,3,999)
LEV S DL=DL+1,DN=$S($D(DE(+DQ,X,DL)):DE(+DQ,X,DL),1:1)
 S:$G(DI(DL-1))]"" DI(DL)=DI(DL-1)
 I DU<0 G X:$D(DY(-DU)) S Y=DA(-DU) G C
 S N=$P(^DD(O,+DU,0),U,4),DE=$P(N,";",1),Y=$P(N,";",2) I Y="" S Y="D"_D G M
 I $P(^(0),U,2)["C" S Y=$P(^(0),U,5,99) G C
 S:+DE'=DE DE=""""_DE_""""
 S Z=Z_DE,E="$G("_DC_Z_"))" I Y S Y="$P("_E_",U,"_Y_")" G M
 I Y'=0 S Y=$E(Y,2,99) S:$P(Y,",",2)=+Y Y=+Y S Y="$E("_E_","_Y_")" G M
 F Y=65:1 S M=DQ_$C(Y) Q:'$D(DIS(M))
 S D=D+1,Y="S D"_D_"=+$O("_DC_Z_",0)) X DIS("""_M_""") I $T" D SD
 I $D(DIAR) S DIAR(DIARF,DQ)="X DIS("""_M_"A"")"
 S DQ=M,DIS(DQ)="F  X DIS("""_DQ_"A"") X:D"_D_"'>0 ""IF "_(DN=3)_""" Q:"_$E("'",DN>1)_"$T  S D"_D_"=$O("_DC_Z_",D"_D_")) Q:D"_D_"'>0"
WP S DQ=DQ_"A",DQ(DL)=DQ I DU'["," S DIS(DQ)="I "_$$XFORM("$G(^(D"_D_",0))")_DV G MAKE
 S O=+$P(^(0),U,2),DK(DL)=O,Z=Z_",D"_D_","
N S DU=$P(DU,",",2,99) G LEV
 ;
M D  S Y=Y_DV D SD G MAKE
VARPOINT .I $P(^DD(O,+DU,0),U,2)["V" S Y="N DIERR I "_$$XFORM("$$EXTERNAL^DIDU("_O_","_+DU_","""","_Y_")") Q
OUTX .I $D(^(2)),$P(^(0),U,2)'["D",DV'["=" S M=0,Y="S Y="_Y_" "_$$OVFL(^(2))_" I "_$$XFORM("Y") Q  ;**GFT 144
SET .I $D(DIS(U,S)) S Y="S Y="_Y_" I $S(Y="""":"""",$D(DIS(U,"_S_",Y)):DIS(U,"_S_",Y),1:"""")" Q
 .S M=Y,Y="I "_$$XFORM(Y)
 ;
XFORM(Y) I '$D(DIS("XFORM",S)) Q Y
 Q $P(DIS("XFORM",S),";")_Y_$P(DIS("XFORM",S),";",2)
 ;
SD I $D(R(DQ)),R(DQ)>1 S Y="K D "_Y_" S:$T D=1"
 I '$D(DIS(DQ)) S DIS(DQ)=Y Q
 I $L($G(DL(DQ)))*8+$L(DIS(DQ))+$L(Y)>180 S Y=$$OVFL(Y)_" I $T" I $L(Y)+$L(DIS(DQ))>235 S DIS(DQ)=$$OVFL(DIS(DQ))_" I "
 S DIS(DQ)=DIS(DQ)_" "_Y Q
 ;
OVFL(Y) N I,%
 F I=1:1 S %=DQ_"@"_I Q:'$D(DIS(%))
 S DIS(%)=Y Q "X DIS("""_%_""")"
 ;
X S D=DY(-DU),O=+D,DC=U_$P(D,U,2) F %=66:1 S M=DQ_$C(%) Q:'$D(DIS(M))
 I $P(D,U,3) S M=DQ_U_$P(D,U,3),Y="S DIXX="""_M_""" "_$P("X ""I 0"" ^I 1 ",U,DN=3+1)_$P(D,U,4,99)_" I $T",R(M)=DN
 E  S Y=$P(D,U,4,99)_" S D0=D(0) X DIS("""_M_""") S D0=I(0,0) I $T"
 D SD S DQ=M,DI(DL)=DC,DK(DL)=+D,DQ(DL)=DQ,D=0,Z="D0," G N
