LRAFUNC7 ;SLC/MRH/FHS - FUNCTION CALL  CONVERSION IN MEASUREMENT  A5AFUNC7
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 N I,X
 W !!,"Routine: "_$T(+0),! F I=8:1  S X=$T(LRAFUNC7+I) Q:'$L(X)  I X[";;" W !,X
 W !!
 Q
 ;
CAP(X,Y,Z) ;; convert metric capacity to U.S. capacity and visa versa
 ;; Call by value 
 ;; Mililiters to cubic inches or quarts or ounces
 ;; returns equivilent value with units
 ;; X must contain a positive numeric value
 ;; Y must contain the units of measure of X
 ;; Z must contain the units of measure to convert X to
 ;; eg. S X=$$CAP(12,"CF","ML") will return a value of X (12)
 ;; in mililiters
 ;; Valid units in either uppercase or lowercase are:
 ;;                     kl  = kiloliter
 ;;                     hl  = hectoliter
 ;;                     dal = dekaliter
 ;;                     l   = liters
 ;;                     dl  = deciliter
 ;;                     cl  = centiliter
 ;;                     ml  = mililiter
 ;;                     
 ;;                     cf   = feet
 ;;                     ci  = inch
 ;;                     gal  = gallon
 ;;                     qt   = quart
 ;;                     pt   = pint
 ;;                     c  = cup
 ;;                     oz = ounce
 ;
 N CKY,CKZ
 I '$G(X) Q 0
 I X[".",$L(X)>19 Q 0_" ILLEGAL NUMBER"
 I $L(X)>18 Q 0_" ILLEGAL NUMBER"
 S Y=$$UPCASE(Y),Z=$$UPCASE(Z)
 Q:'$L(Y)!('$L(Z)) 0
 S CKY=U_Y_U
 I "^KL^HL^DAL^L^DL^CL^ML^CF^CI^GAL^QT^PT^C^OZ^"'[CKY Q "ERROR"
 S CKZ=U_Z_U
 I "^KL^HL^DAL^L^DL^CL^ML^CF^CI^GAL^QT^PT^C^OZ^"'[CKZ Q "ERROR"
 ; quit with no conversion
 I Y=Z Q X_" "_Z
 ;
 ; common metric unit = mililiter ML
 I $P("^KL^1^HL^1^DAL^1^L^1^DL^1^CL^1^ML^1^",CKY,2) S X=X*+$P("^KL^1000000^HL^100000^DAL^10000^L^1000^DL^100^CL^10^ML^1",CKY,2)_"M"
 ; common U.S. unit = cubic inches CI
 I $P("^CF^1^CI^1^GAL^1^QT^1^PT^1^C^1^OZ^1",CKY,2) S X=X*+$P("^CF^1728^CI^1^GAL^231^QT^57.75^PT^28.875^C^14.4375^OZ^1.805",CKY,2)_"U"
 ;
 ; X in U.S. (cubic inches) and will convert to metric
 I X["U",$P("^KL^1^HL^1^DAL^1^L^1^DL^1^CL^1^ML^1^",CKZ,2) S X=X*+$P("^KL^.000016387^HL^.00016387^DAL^.0016387^L^.016387^DL^.16387^CL^1.6387^ML^16.387^",CKZ,2) Q $$FORMAT(X)_" "_Z
 ;
 ; X in metric (mililiter) and will convert to U.S.
 I X["M",$P("^CF^1^CI^1^GAL^1^QT^1^PT^1^C^1^OZ^1",CKZ,2) S X=X*+$P("^CF^.00003531^CI^.0610^GAL^.0002642^QT^.0010568^PT^.0021136^C^.0042272^OZ^.033818^",CKZ,2) Q $$FORMAT(X)_" "_Z
 ;
 ; X in metric (mililiter) and will convert to metric
 I X["M",$P("^KL^1^HL^1^DAL^1^L^1^CL^1^DL^1^ML^1",CKZ,2) S X=X*+$P("^KL^1000000^HL^100000^DAL^10000^L^1000^CL^100^CL^10^ML^1",CKZ,2) Q $$FORMAT(X)_" "_Z
 ;
 ; X in U.S. (cubic inches) and will convert to U.S.
 I X["U",$P("^CF^1^CI^1^GAL^1^QT^1^PT^1^C^1^OZ^1",CKZ,2) S X=X*+$P("^CF^.0005787^CI^1^GAL^.004329^QT^.017316^PT^.034632^C^.069264^OZ^.554017",CKZ,2) Q $$FORMAT(X)_" "_Z
 Q "ERROR"
 ;
FORMAT(X) ;
 S X=$S(X>.9:$FN(X,"",3),1:$FN(X,"",4))
 Q $S($P(X,".",2):X,1:$FN(X,"",0))
 ;
UPCASE(X) ;
 Q $TR(X,"zxcvbnmlkjhgfdsaqwertyuiop","ZXCVBNMLKJHGFDSAQWERTYUIOP")
