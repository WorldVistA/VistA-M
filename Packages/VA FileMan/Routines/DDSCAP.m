DDSCAP ;SFISC/MKO-INPUT TRANSFORM FOR CAPTIONS ;01:24 PM  14 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
FUNC(X) ;
 Q:$E(X)'="!"
 N E,F,Y
 S F=$E(X,2,999)
 S:$P(F,"(")?.A1.L.A F=$$UPCASE($P(F,"("))_$S(F["(":"("_$P(F,"(",2,999),1:"")
 Q:$P(F,"(")'?1U.7UN X
 Q:$T(@$P(F,"("))="" X
 ;
 D  Q:$G(E) X
 . N X S X="S Y=$$"_F
 . N F D ^DIM
 . S:'$D(X) E=1
 ;
 S @("Y=$$"_F)
 Q Y
 ;
L() ;;Get label of field
 N F1,F2
 S X=""
 S F1=$$GET^DDSVAL(DIE,.DA,4) Q:'F1 X
 S F2=$$GET^DDSVAL(.404,DA(1),1) Q:'F2 X
 S X=$P($G(^DD(F2,F1,0)),U)
 Q X
 ;
T() ;;Get title of field
 N F1,F2
 S X=""
 S F1=$$GET^DDSVAL(DIE,.DA,4) Q:'F1 X
 S F2=$$GET^DDSVAL(.404,DA(1),1) Q:'F2 X
 S X=$G(^DD(F2,F1,.1))
 Q X
 ;
U() ;;Get unique name of field
 Q $$GET^DDSVAL(DIE,.DA,3.1)
 ;
DUP(X1,X) ;;The DUP function
 Q:$G(X1)="" ""
 N %
 S %=X,X="",$P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%)
 Q X
 ;
UPCASE(X) ;Convert X to uppercase
 Q $$UP^DILIBF(X)  ;**
