LRAFUNC6 ;SLC/MRH/FHS - FUNCTION CALLS  CONVERSION IN MEASUREMENT  A5AFUNC6
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;
 N I,X
 W !!,"Routine: "_$T(+0),! F I=8:1  S X=$T(LRAFUNC6+I) Q:'$L(X)  I X[";;" W !,X
 W !!
 Q
 ;
LENGTH(X,Y,Z) ;; convert metric length to U.S. length and visa versa
 ;; Call by value 
 ;; returns equivilent value with out units
 ;; X must contain a positive numeric value
 ;; Y must contain the units of measure of X
 ;; Z must contain the units of measure to convert X to
 ;; eg. S X=$$LENGTH(12,"IN","CM") will return a value of X (12)
 ;; in centimeters
 ;; Valid units are in either uppercase or lowercase are:
 ;;                     km = kilometers
 ;;                     m  = meters
 ;;                     cm = centimeters
 ;;                     mm = millimeters
 ;;                     mi = miles
 ;;                     yd = yards
 ;;                     ft = feet
 ;;                     in = inches
 N CKY,CKZ
 I '$G(X) Q 0
 I X[".",$L(X)>19 Q 0_" ILLEGAL NUMBER"
 I $L(X)>18 Q 0_" ILLEGAL NUMBER"
 S Y=$$UPCASE(Y),Z=$$UPCASE(Z)
 Q:'$L(Y)!('$L(Z)) 0
 S CKY=U_Y_U
 I "^KM^M^CM^MM^MI^YD^FT^IN^"'[CKY Q "ERROR"
 S CKZ=U_Z_U
 I "^KM^M^CM^MM^MI^YD^FT^IN^"'[CKZ Q "ERROR"
 ; quit with no conversion
 I Y=Z Q X_" "_Z
 ;
 ; -***- common metric unit is centimeters CM -***-
 I $P("^KM^1^M^1^CM^1^MM^1",CKY,2) S X=X*+$P("^KM^100000^M^100^CM^1^MM^.1",CKY,2)_"M"
 ;
 ; -***- common U.S. unit is inches IN -***-
 I $P("^MI^1^YD^1^FT^1^IN^1",CKY,2) S X=X*$P("^MI^63360^YD^36^FT^12^IN^1",CKY,2)_"U"
 ;
 ; X in metric (cm) and will convert to metric
 I X["M",$P("^KM^1^M^1^CM^1^MM^1",CKZ,2) S X=X*$P("^KM^.001^M^.01^CM^1^MM^10^",CKZ,2) Q $$FORMAT(X)_" "_Z
 ;
 ; X in U.S. and will convert to U.S.
 I X["U",$P("^MI^1^YD^1^FT^1^IN^1",CKZ,2) S X=X*$P("^MI^.0000158^YD^.027778^FT^.083338^IN^1",CKZ,2) Q $$FORMAT(X)_" "_Z
 ;
 ; X in U.S. and will convert to metric
 I X["U",$P("^KM^1^M^1^CM^1^MM^1",CKZ,2) S X=X*$P("^KM^.0000254^M^.0254^CM^2.540^MM^25.4",CKZ,2) Q $$FORMAT(X)_" "_Z
 ;
 ; X in metric (cm) and will convert to U.S.
 I X["M",$P("^MI^1^YD^1^FT^1^IN^1",CKZ,2) S X=X*$P("^MI^.0000062^YD^.010936^FT^.032808^IN^.393696",CKZ,2) Q $$FORMAT(X)_" "_Z
 ;
 ;;
FORMAT(X) ;
 S X=$S(X>.9:$FN(X,"",3),1:$FN(X,"",4))
 Q $S($P(X,".",2):X,1:$FN(X,"",0))
 ;
UPCASE(X) ;
 Q $TR(X,"zxcvbnmlkjhgfdsaqwertyuiop","ZXCVBNMLKJHGFDSAQWERTYUIOP")
