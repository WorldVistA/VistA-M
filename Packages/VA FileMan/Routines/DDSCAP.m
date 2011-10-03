DDSCAP ;SFISC/MKO-INPUT TRANSFORM FOR CAPTIONS ;10:45 AM  6 Mar 1996
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
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
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
