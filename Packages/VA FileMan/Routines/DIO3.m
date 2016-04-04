DIO3 ;SFISC/GFT-TTLS, SUBTTLS ;2014-12-29  10:21 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**2,999,1005,1047**
 ;
SUB ;
 N TYPE,V ;**CCO/NI This whole subroutine re-written for 'TOTAL', 'SUBTOTAL', 'COUNT', SUBCOUNT', ETC.
 I '$D(DNP) W:$X !
 I 'A F X=1:1:$G(DIONOSUB) W !
 K X
 I $D(^UTILITY($J,"SV",A+1)) F Y="S","N","Q","H","L" S C=Y_"(V)" F V=0:0 S V=$O(@C) Q:V=""  I $D(^UTILITY($J,"SV",A+1,V,Y)) S @C=^(Y),^(Y)=$S(Y="H":-99999999,Y="L":99999999,1:0)
 S %X="" F  S %X=$O(^UTILITY($J,"T",%X)) Q:%X=""  D
 .S Z=^(%X),V=$P(Z,U,2) Q:$D(V(V))
 .S V(V)="",TYPE=$P(Z,U,4)
U .F I=1:1:6 S DE=$P($T(@I),";",4),Y=DE_"(V)" I $D(@Y)#2 S Y=@Y,C=$P(Z,U,5) D @I
 .I '$D(DNP),$D(X)>9 W ?%X F I=1:1:Z W "-"
 S Z=A I $D(A(A)) F DE="S","N" S I=DE_"(V)" F V=0:0 S V=$O(@I) Q:V=""  S Y=@I I '$D(DNP)!Y S:'$D(V(V)) ^(DE)=$G(^UTILITY($J,"SV",A,V,DE))+Y S @I=0,Z=0 X A(A)
 S X=-1 G K:$D(X)<9!Z F I=0:0 S I=$O(X(I)),X=X+1 Q:I=""
 I X+$Y>IOSL X ^UTILITY($J,1)
EGP F I=0:0 S I=$O(X(I)) Q:I=""  W:$X ! D
 .N TITLE
 .S TITLE=$$EZBLD^DIALOG($P($T(@I),";",6))
 .I A>0 S TITLE=$$EZBLD^DIALOG(7098,TITLE)
 .W:'$G(DIONOSUB) TITLE," " S X="" F  S X=$O(X(I,X)) Q:X=""  W ?X,X(I,X)
 W !
K K Z,X,V,C Q
 ;
1 ;;TOTAL;S;;7090
 I $P(Z,U,6)]"" X $P(Z,U,6,99) S S(V)=Y
 S ^(DE)=$S($S(A:$D(^UTILITY($J,"SV",A,V,DE)),1:$D(^DOSV(0,IO(0),0,V,DE))):^(DE),1:0)+Y
 Q:TYPE["D"  Q:TYPE["F"&(Y=0)
O I C]""!$P(Z,U,3) D  Q
 .N F,OUTRANSF
 .S F=$G(^DOSV(0,IO(0),"F",I))
 .S OUTRANSF="Q"
 .I $P($G(^DD(+F,+$P(F,U,2),0)),U,2)["O" S OUTRANSF=$G(^(2))
 .X OUTRANSF
 .S @("Y=$J(Y,+Z"_C_")")
 .S X(I,%X)=Y
2 ;;COUNT;N;;7089
 S ^(DE)=$S($S(A:$D(^UTILITY($J,"SV",A,V,DE)),1:$D(^DOSV(0,IO(0),0,V,DE))):^(DE),1:0)+Y
 S C=$P(",0",U,C]"") G O
3 ;;MEAN;N;;7088
 Q:TYPE["D"!'Y!$L($P(Z,U,6))!'$D(S(V))  Q:TYPE["F"!A&(S(V)=0)  S Y=$J(S(V)/Y,0,2) G O
4 ;;MINIMUM;L;;7087
 S ^(DE)=$S('$D(^(DE)):Y,^(DE)>Y:Y,1:^(DE)),L(V)=99999999 G M
5 ;;MAXIMUM;H;;7086
 S ^(DE)=$S('$D(^(DE)):Y,^(DE)<Y:Y,1:^(DE)),H(V)=-99999999
M Q:Y[9999999!(N(V)<2)  D D:TYPE["D" G O
6 ;;DEV.;Q;;7085
 Q:TYPE["D"  S ^(DE)=$G(^(DE))+Y,Q(V)=0 Q:N(V)<2  S DE=Y-((S(V)*S(V))/N(V))/(N(V)-1),Y=1+DE/2 Q:DE'>0
L S %=Y,Y=DE/%+%/2 G L:Y<%,O
 ;
DT D D:Y W Y Q
D X ^DD("DD") Q  ;**CCO/NI  DATE FORMAT
N W !
T Q
