DIO3 ;SFISC/GFT-TTLS, SUBTTLS ;09:49 AM  27 Aug 1999
 ;;22.0;VA FileMan;**2**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
SUB ;
 N TYPE,V
 W:'$D(DNP)&$X ! K X I $D(^UTILITY($J,"SV",A+1)) F Y="S","N","Q","H","L" S C=Y_"(V)" F V=0:0 S V=$O(@C) Q:V=""  I $D(^UTILITY($J,"SV",A+1,V,Y)) S @C=^(Y),^(Y)=$S(Y="H":-99999999,Y="L":99999999,1:0)
 S %X="" F  S %X=$O(^UTILITY($J,"T",%X)) Q:%X=""  D
 .S Z=^(%X),V=$P(Z,U,2) Q:$D(V(V))
 .S V(V)="",TYPE=$P(Z,U,4)
U .F I=1:1:6 S DE=$P($T(@I),";",4),Y=DE_"(V)" I $D(@Y)#2 S Y=@Y,C=$P(Z,U,5) D @I
 .I '$D(DNP),$D(X)>9 W ?%X F I=1:1:Z W "-"
 S Z=A I $D(A(A)) F DE="S","N" S I=DE_"(V)" F V=0:0 S V=$O(@I) Q:V=""  S Y=@I I '$D(DNP)!Y S:'$D(V(V)) ^(DE)=$G(^UTILITY($J,"SV",A,V,DE))+Y S @I=0,Z=0 X A(A)
 S X=-1 G K:$D(X)<9!Z F I=0:0 S I=$O(X(I)),X=X+1 Q:I=""
 I X+$Y>IOSL X ^UTILITY($J,1)
 F I=0:0 S I=$O(X(I)),X=-1 Q:I=""  W:$X ! W $P("SUB",U,A>0),$P($T(@I),";",3)," " F %=0:0 S X=$O(X(I,X)) Q:X=""  W ?X,X(I,X)
 W !
K K Z,X,V,C Q
 ;
1 ;;TOTAL;S
 I $P(Z,U,6)]"" X $P(Z,U,6,99) S S(V)=Y
 S ^(DE)=$S($S(A:$D(^UTILITY($J,"SV",A,V,DE)),1:$D(^DOSV(0,IO(0),0,V,DE))):^(DE),1:0)+Y
 Q:TYPE["D"  Q:TYPE["F"&(Y=0)
O I C]""!$P(Z,U,3) S @("Y=$J(Y,+Z"_C_")")
 S X(I,%X)=Y Q
2 ;;COUNT;N
 S ^(DE)=$S($S(A:$D(^UTILITY($J,"SV",A,V,DE)),1:$D(^DOSV(0,IO(0),0,V,DE))):^(DE),1:0)+Y
 S C=$P(",0",U,C]"") G O
3 ;;MEAN;N
 Q:TYPE["D"!'Y!$L($P(Z,U,6))!'$D(S(V))  Q:TYPE["F"!A&(S(V)=0)  S Y=$J(S(V)/Y,0,2) G O
4 ;;MINIMUM;L
 S ^(DE)=$S('$D(^(DE)):Y,^(DE)>Y:Y,1:^(DE)),L(V)=99999999 G M
5 ;;MAXIMUM;H
 S ^(DE)=$S('$D(^(DE)):Y,^(DE)<Y:Y,1:^(DE)),H(V)=-99999999
M Q:Y[9999999!(N(V)<2)  D D:TYPE["D" G O
6 ;;DEV.;Q
 Q:TYPE["D"  S ^(DE)=$G(^(DE))+Y,Q(V)=0 Q:N(V)<2  S DE=Y-((S(V)*S(V))/N(V))/(N(V)-1),Y=1+DE/2 Q:DE'>0
L S %=Y,Y=DE/%+%/2 G L:Y<%,O
 ;
DT D D:Y W Y Q
D S Y=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" "_$S(Y#100:$J(Y#100\1,2)_",",1:"")_(Y\10000+1700)_$S(Y#1:"  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),1:"")
 Q
N W !
T Q
