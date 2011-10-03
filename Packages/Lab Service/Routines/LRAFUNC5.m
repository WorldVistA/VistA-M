LRAFUNC5 ;SLC/MRH/FHS - FUNCTION CALLS  CONVERSION IN MEASURMENTS  A5AFUNC5
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;
 N I,X
 W !!,"Routine: "_$T(+0),! F I=8:1  S X=$T(LRAFUNC5+I) Q:'$L(X)  I X[";;" W !,X
 W !!
 Q
 ;;
WEIGHT(X,Y,Z) ;; convert metric mass to approx. U.S. weights and visa versa
 ;; Call by value 
 ;; returns equivilent value with out units
 ;; X must contain a positive numeric value
 ;; Y must contain the units of measure of X
 ;; Z must contain the units of measure to convert X to
 ;; eg. S X=$$WEIGHT(12,"LB","GM") will return a value of X (12)
 ;; pounds in grams
 ;; Valid units in either lowercase or uppercase 
 ;;             are     t  = metric tons
 ;;                     kg = kilograms
 ;;                     g = grams
 ;;                     mg = milligram
 ;;                     tn = tons
 ;;                     lb = pounds
 ;;                     oz = ounces
 ;;                     gr = grain
 N CKY,CKZ
 I '$G(X) Q 0
 I X[".",$L(X)>19 Q 0_" ILLEGAL NUMBER"
 I $L(X)>18 Q 0_" ILLEGAL NUMBER"
 S Y=$$UPCASE(Y),Z=$$UPCASE(Z)
 Q:'$L(Y)!('$L(Z)) 0
 S CKY=U_Y_U
 I "^T^KG^G^MG^TN^LB^OZ^GR^"'[CKY Q "ERROR"
 S CKZ=U_Z_U
 I "^T^KG^G^MG^TN^LB^OZ^GR^"'[CKZ Q "ERROR"
 ; quit with no conversion
 I Y=Z Q X_" "_Z
 ; common metric unit is kilograms KG
 I $P("^T^1^KG^1^G^1^MG^1",CKY,2) S X=X*$P("^T^1000^KG^1^G^.001^MG^.000001",CKY,2) S X=X_"M"
 ; common english unit is pound LB
 I $P("^TN^1^LB^1^OZ^1^GR^1",CKY,2) S X=X*$P("^TN^2000^LB^1^OZ^.0625^GR^.0001302083",CKY,2) S X=X_"U"
 ; the result of the above 2 IF statments will result in X being
 ; converted to kilograms or pounds depending on the value of Y
 ;
 ; X in metric and will convert to metric X in KG
 I X["M",$P("^T^1^KG^1^G^1^MG^1",CKZ,2) S X=X*$P("^T^.00001^KG^1^G^1000^MG^10000",CKZ,2) Q $$FORMAT(X)_" "_Z
 ;
 ; X in U.S. and will convert to U.S. X in LB
 I X["U",$P("^TN^1^LB^1^OZ^1^GR^1",CKZ,2) S X=X*$P("^TN^.0005^LB^1^OZ^16^GR^7680",CKZ,2) Q $$FORMAT(X)_" "_Z
 ;
 ; X in U.S. and will convert to metric X in LB
 I X["U",$P("^T^1^KG^1^G^1^MG^1",CKZ,2) S X=X*$P("^T^.000454^KG^.454^G^454^MG^454000",CKZ,2) Q $$FORMAT(X)_" "_Z
 ;
 ; X in metric and will convert to U.S. X in KG
 I X["M",$P("^TN^1^LB^1^OZ^1^GR^1",CKZ,2) S X=X*$P("^TN^.00062^LB^2.2046^OZ^35.2736^GR^154300",CKZ,2) Q $$FORMAT(X)_" "_Z
 ;
 ;;
FORMAT(X) ;
 S X=$S(X>.9:$FN(X,"",3),1:$FN(X,"",4))
 Q $S($P(X,".",2):X,1:$FN(X,"",0))
 ;
UPCASE(X) ;
 Q $TR(X,"zxcvbnmlkjhgfdsaqwertyuiop","ZXCVBNMLKJHGFDSAQWERTYUIOP")
