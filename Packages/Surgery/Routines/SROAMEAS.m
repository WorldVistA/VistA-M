SROAMEAS ;BIR/MAM - INPUT TRANSFORMS, HEIGHT & WEIGHT ;06/28/10
 ;;3.0; Surgery ;**38,125,153,166,170,174**;24 Jun 93;Build 8
H Q:'$D(X)  I X'?.N1"C"&(X'?.N1"c"),(+X'=X) K X Q
 I +X=X S X=X+.5\1 I X'>24.9!(X'<86.1) K X Q
 S:X["c" X=+X_"C"
 I X?.N1"C",(X'>62.9!(X'<218.1)) K X
 Q
W Q:'$D(X)  I +X'=X,(X'?.N1"K")&(X'?.N1"k") K X Q
 I +X=X S X=X+.5\1 I X'>49.9!(X'<999.1) K X Q
 S:X["k" X=+X_"K"
 I X?.N1"K",(X'>22.9!(X'<453.1)) K X
 Q
