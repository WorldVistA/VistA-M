DIQGU0 ;SFISC/DCL-DATA RETRIVIAL UTILITY PROGRAM ;02:42 PM  24 Aug 1993
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
R(%R) ;
 N %C,%F,%G,%I,%R1,%R2
 S %R1=$P(%R,"(")_"(" I $E(%R1)="^" S %R2=$P($Q(@(%R1_""""")")),"(")_"(" S:$P(%R2,"(")]"" %R1=%R2
 S %R2=$P($E(%R,1,($L(%R)-($E(%R,$L(%R))=")"))),"(",2,99)
 S %C=$L(%R2,","),%F=1 F %I=1:1:%C S %G=$P(%R2,",",%F,%I) Q:%G=""  I ($L(%G,"(")=$L(%G,")")&($L(%G,"""")#2))!(($L(%G,"""")#2)&($E(%G)="""")&($E(%G,$L(%G))="""")) S %G=$$S(%G),$P(%R2,",",%F,%I)=%G,%F=%F+$L(%G,","),%I=%F-1
 Q %R1_%R2
S(%Z) ;
 I $G(%Z)']"" Q ""
 I $E(%Z)'="""",$L(%Z,"E")=2,+$P(%Z,"E")=$P(%Z,"E"),+$P(%Z,"E",2)=$P(%Z,"E",2) Q +%Z
 I +%Z=%Z Q %Z
 I %Z="""""" Q ""
 I $E(%Z)'?1A,"%$+@"'[$E(%Z) Q %Z
 I "+$"[$E(%Z) X "S %Z="_%Z Q $$Q(%Z)
 I $D(@%Z) Q $$Q(@%Z)
 Q %Z
Q(%Z) ;
 S %Z(%Z)="",%Z=$Q(%Z("")) Q $E(%Z,4,$L(%Z)-1)
DDLST(DDN,ATRN,FL) ;
 N X,Y S:$D(^DD(DDN)) ATRN(DDN)="" S FL=+$G(FL)
 D  S X=0 F  S X=$O(^DD(DDN,"SB",X)) Q:X'>0  S ATRN(X)="" D  D DDLST(X,.ATRN,FL)
 .I 'FL S Y="" F  S Y=$O(^DD(DDN,"B",Y)) Q:Y=""  S ATRN(Y,DDN)=$O(^(Y,""))
 .Q
 Q
DDN(ATN,F) ;
 N DNA,DDN,X,Y S X="$$$ NO SUCH ATTRIBUTE $$$"
 Q:$G(ATN)']"" X
 D DDLST(+$G(F),.DNA,1)
 S DDN="" F  S DDN=$O(DNA(DDN)) Q:DDN=""  D  Q:X
 .S Y="" F  S Y=$O(^DD(DDN,"B",Y)) Q:Y=""  I Y=ATN S X=DDN_"^"_$O(^DD(DDN,"B",Y,"")) Q
 .Q
 I '$G(F),$E(X,1,6)="$$$ NO" Q $$DDN(ATN,1)
 Q X
DDLST2(DDN,ATRN,FL) ;
 N X,Y S:$D(^DD(DDN)) ATRN(DDN)="" S FL='$D(FL)
 S X=0 F  S X=$O(^DD(DDN,"SB",X)) Q:X'>0  D
 .I FL S ATRN(X)="",Y=0 F  S Y=$O(^DD(DDN,Y)) Q:Y'>0  S ATRN(Y,DDN)=$P($G(^(Y,0)),"^")
 .D DDLST2(X,.ATRN)
 .Q
 Q
