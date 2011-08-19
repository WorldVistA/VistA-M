XLFMSMT ;SLC,SF/MH,RWF - Callable functions for conversions in measurement ;04/09/2002  09:02
 ;;8.0;KERNEL;**228**;Jul 10, 1995
 N I,VAL
 W !!,"Routine: "_$T(+0),! F I=8:1  S VAL=$T(+I) Q:'$L(VAL)  I VAL[";;" W !,VAL
 W !!
 Q
 ;;
WEIGHT(VAL,FROM,TO) ;;Convert weight between metric and U.S. weights
 ;; returns equivilent value with units
 ;; VAL must contain a positive numeric value
 ;; FROM must contain the units of measure of VAL
 ;; TO must contain the units of measure to convert VAL to
 ;; eg. W $$WEIGHT(12,"LB","G") ===> 5448 G
 ;; Valid units in either lowercase or uppercase are
 ;;               t  = metric tons         tn = tons
 ;;               kg = kilograms           lb = pounds
 ;;                g = grams               oz = ounces
 ;;               mg = milligram           gr = grain
 N CKY,CKZ
 I '$G(VAL) Q 0
 I '$$VAL(VAL) Q 0_" ILLEGAL NUMBER"
 S FROM=$$UPCASE(FROM),CKY="^"_FROM_"^",TO=$$UPCASE(TO),CKZ="^"_TO_"^"
 Q:'$L(FROM)!('$L(TO)) 0
 I "^T^KG^G^MG^TN^LB^OZ^GR^"'[CKY Q "ERROR"
 I "^T^KG^G^MG^TN^LB^OZ^GR^"'[CKZ Q "ERROR"
 ; quit with no conversion
 G WT^XLFMSMT2
LENGTH(VAL,FROM,TO) ;;Convert length between metric and U.S. length 
 ;; returns equivilent value with units
 ;; VAL must contain a positive numeric value
 ;; FROM must contain the units of measure of VAL
 ;; TO must contain the units of measure to convert VAL to
 ;; eg. W $$LENGTH(12,"IN","CM") ===> 30.480 CM
 ;; Valid units are in either uppercase or lowercase are:
 ;;             km = kilometers        mi = miles
 ;;             m  = meters            yd = yards
 ;;             cm = centimeters       ft = feet
 ;;             mm = millimeters       in = inches
 N CKY,CKZ
 I '$G(VAL) Q 0
 I '$$VAL(VAL) Q 0_" ILLEGAL NUMBER"
 S FROM=$$UPCASE(FROM),CKY="^"_FROM_"^",TO=$$UPCASE(TO),CKZ="^"_TO_"^"
 Q:'$L(FROM)!('$L(TO)) 0
 I "^KM^M^CM^MM^MI^YD^FT^IN^"'[CKY Q "ERROR"
 I "^KM^M^CM^MM^MI^YD^FT^IN^"'[CKZ Q "ERROR"
 ; quit with no conversion
 I FROM=TO Q VAL_" "_TO
 G LN^XLFMSMT2
 ;;
VOLUME(VAL,FROM,TO) ;;Convert volume between metric and U.S. volume
 ;; Mililiters to cubic inches or quarts or ounces
 ;; returns equivilent value with units
 ;; VAL must contain a positive numeric value
 ;; FROM must contain the units of measure of VAL
 ;; TO must contain the units of measure to convert VAL to
 ;; eg. W $$VOLUME(12,"CF","ML") ===> 339800.832 ML
 ;; Valid units in either uppercase or lowercase are:
 ;;           kl  = kiloliter      cf   = feet
 ;;           hl  = hectoliter     ci   = inch
 ;;           dal = dekaliter      gal  = gallon
 ;;           l   = liters         qt   = quart
 ;;           dl  = deciliter      pt   = pint
 ;;           cl  = centiliter     c    = cup
 ;;           ml  = mililiter      oz   = ounce
 ;
 N CKY,CKZ
 I '$G(VAL) Q 0
 I '$$VAL(VAL) Q 0_" ILLEGAL NUMBER"
 S FROM=$$UPCASE(FROM),CKY="^"_FROM_"^",TO=$$UPCASE(TO),CKZ="^"_TO_"^"
 Q:'$L(FROM)!('$L(TO)) 0
 I "^KL^HL^DAL^L^DL^CL^ML^CF^CI^GAL^QT^PT^C^OZ^"'[CKY Q "ERROR"
 I "^KL^HL^DAL^L^DL^CL^ML^CF^CI^GAL^QT^PT^C^OZ^"'[CKZ Q "ERROR"
 ; quit with no conversion
 I FROM=TO Q VAL_" "_TO
 G VOL^XLFMSMT2
 ;;
BSA(%HT,%WT) ;;Return Body Surface Area using Dubois formula
 ;; Dubois formula BSA=.007184*(ht**.725)*(wt**.425)
 ;; %HT is height in centimeters
 ;; %WT is weight in Kilograms
 ;; eg. $$BSA(175,86)=2.02
 ;; or  $$BSA(100,43)=1.00
 I '$$VAL(%HT) Q 0_"ILLEGAL NUMBER"
 I '$$VAL(%WT) Q 0_" ILLEGAL NUMBER"
 ;Q $FN(($$PWR^XLFMTH(%HT,.425)*$$PWR^XLFMTH(%WT,.725)*71.84)/10000,"",2)
 Q $FN(((%HT**.725)*(%WT**.425)*71.84)/10000,"",2)
 ;
TEMP(VAL,FROM,TO) ;;Convert metric temperature to U.S. temperature
 ;; F = fahrenheit        C = celsius
 N CKY,CKZ
 I '$D(VAL) Q 0
 I '$$VAL(VAL) Q 0_" ILLEGAL NUMBER"
 S FROM=$$UPCASE(FROM),CKY="^"_FROM_"^",TO=$$UPCASE(TO),CKZ="^"_TO_"^"
 Q:'$L(FROM)!('$L(TO)) 0
 I "^F^C^"'[CKY Q "ERROR"
 I "^F^C^"'[CKZ Q "ERROR"
 I FROM=TO Q VAL_" "_TO
 I TO="C" Q $$FORMAT^XLFMSMT2((VAL-32)/1.8)_" "_TO
 I TO="F" Q $$FORMAT^XLFMSMT2(1.8*VAL+32)_" "_TO
 Q "ERROR"
VAL(X) ;
 I X[".",$L(X)>19 Q 0
 I $L(X)>18 Q 0
 Q 1
UPCASE(X) ;
 Q $TR(X,"zxcvbnmlkjhgfdsaqwertyuiop","ZXCVBNMLKJHGFDSAQWERTYUIOP")
 ;
