IBDEI07V ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10538,1,2,0)
 ;;=2^Trim Skin Lesion, Single Lesion
 ;;^UTILITY(U,$J,358.3,10538,1,3,0)
 ;;=3^11055
 ;;^UTILITY(U,$J,358.3,10539,0)
 ;;=11056^^84^643^2^^^^1
 ;;^UTILITY(U,$J,358.3,10539,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10539,1,2,0)
 ;;=2^Trim Skin Lesion,2-4 Lesions
 ;;^UTILITY(U,$J,358.3,10539,1,3,0)
 ;;=3^11056
 ;;^UTILITY(U,$J,358.3,10540,0)
 ;;=11057^^84^643^3^^^^1
 ;;^UTILITY(U,$J,358.3,10540,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10540,1,2,0)
 ;;=2^Trim Skin Lesions, Over 4
 ;;^UTILITY(U,$J,358.3,10540,1,3,0)
 ;;=3^11057
 ;;^UTILITY(U,$J,358.3,10541,0)
 ;;=17000^^84^644^1^^^^1
 ;;^UTILITY(U,$J,358.3,10541,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10541,1,2,0)
 ;;=2^Destruction, all benign or premalignant lesions other than skin tags or cutaneous vascular proliferative lesion; 1st lesion
 ;;^UTILITY(U,$J,358.3,10541,1,3,0)
 ;;=3^17000
 ;;^UTILITY(U,$J,358.3,10542,0)
 ;;=17003^^84^644^2^^^^1
 ;;^UTILITY(U,$J,358.3,10542,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10542,1,2,0)
 ;;=2^Destruction, all benign or premalignant lesions other than skin tags or cutaneous vascular proliferative lesions; 2nd-14th lesion, each
 ;;^UTILITY(U,$J,358.3,10542,1,3,0)
 ;;=3^17003
 ;;^UTILITY(U,$J,358.3,10543,0)
 ;;=17004^^84^644^3^^^^1
 ;;^UTILITY(U,$J,358.3,10543,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10543,1,2,0)
 ;;=2^Destruction, all benign or premalignant lesions other than skin tags or cutaneous vascular proliferative lesions; 15 or more lesions
 ;;^UTILITY(U,$J,358.3,10543,1,3,0)
 ;;=3^17004
 ;;^UTILITY(U,$J,358.3,10544,0)
 ;;=17110^^84^644^4^^^^1
 ;;^UTILITY(U,$J,358.3,10544,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10544,1,2,0)
 ;;=2^Destruction, of flat warts, molluscum contagiosum, or milia; up to 14 lesions
 ;;^UTILITY(U,$J,358.3,10544,1,3,0)
 ;;=3^17110
 ;;^UTILITY(U,$J,358.3,10545,0)
 ;;=17111^^84^644^5^^^^1
 ;;^UTILITY(U,$J,358.3,10545,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10545,1,2,0)
 ;;=2^Destruction, of flat warts, molluscum contagiosum, or milia; 15 or more lesions
 ;;^UTILITY(U,$J,358.3,10545,1,3,0)
 ;;=3^17111
 ;;^UTILITY(U,$J,358.3,10546,0)
 ;;=17250^^84^644^6^^^^1
 ;;^UTILITY(U,$J,358.3,10546,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10546,1,2,0)
 ;;=2^Chemical cauterization of granulation tissue
 ;;^UTILITY(U,$J,358.3,10546,1,3,0)
 ;;=3^17250
 ;;^UTILITY(U,$J,358.3,10547,0)
 ;;=11400^^84^645^1^^^^1
 ;;^UTILITY(U,$J,358.3,10547,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10547,1,2,0)
 ;;=2^Excision Benign Lesion-trunk,  legs; 0.5 cm or less 
 ;;^UTILITY(U,$J,358.3,10547,1,3,0)
 ;;=3^11400
 ;;^UTILITY(U,$J,358.3,10548,0)
 ;;=11401^^84^645^2^^^^1
 ;;^UTILITY(U,$J,358.3,10548,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10548,1,2,0)
 ;;=2^Excision Benign Lesion-trunk,  legs; 0.6cm to 1.0cm
 ;;^UTILITY(U,$J,358.3,10548,1,3,0)
 ;;=3^11401
 ;;^UTILITY(U,$J,358.3,10549,0)
 ;;=11402^^84^645^3^^^^1
 ;;^UTILITY(U,$J,358.3,10549,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10549,1,2,0)
 ;;=2^Excision Benign Lesion-trunk,  legs; 1.1cm to 2.0cm
 ;;^UTILITY(U,$J,358.3,10549,1,3,0)
 ;;=3^11402
 ;;^UTILITY(U,$J,358.3,10550,0)
 ;;=11403^^84^645^4^^^^1
 ;;^UTILITY(U,$J,358.3,10550,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10550,1,2,0)
 ;;=2^Excision Benign Lesion-trunk,  legs; 2.1cm to 3.0cm
 ;;^UTILITY(U,$J,358.3,10550,1,3,0)
 ;;=3^11403
 ;;^UTILITY(U,$J,358.3,10551,0)
 ;;=11404^^84^645^5^^^^1
 ;;^UTILITY(U,$J,358.3,10551,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10551,1,2,0)
 ;;=2^Excision Benign Lesion-trunk,  legs; 3.1cm to 4.0cm
 ;;^UTILITY(U,$J,358.3,10551,1,3,0)
 ;;=3^11404
 ;;^UTILITY(U,$J,358.3,10552,0)
 ;;=11406^^84^645^6^^^^1
 ;;^UTILITY(U,$J,358.3,10552,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10552,1,2,0)
 ;;=2^Excision Benign Lesion-trunk,  legs; over 4.0cm
 ;;^UTILITY(U,$J,358.3,10552,1,3,0)
 ;;=3^11406
 ;;^UTILITY(U,$J,358.3,10553,0)
 ;;=11420^^84^645^7^^^^1
 ;;^UTILITY(U,$J,358.3,10553,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10553,1,2,0)
 ;;=2^Excisiofeet, genitalia; 0.5cm or less
 ;;^UTILITY(U,$J,358.3,10553,1,3,0)
 ;;=3^11420
 ;;^UTILITY(U,$J,358.3,10554,0)
 ;;=11421^^84^645^8^^^^1
 ;;^UTILITY(U,$J,358.3,10554,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10554,1,2,0)
 ;;=2^Excision Benign Lesion-scalp, neck, hands, feet, genitalia; 0.6cm to 1.0cm
 ;;^UTILITY(U,$J,358.3,10554,1,3,0)
 ;;=3^11421
 ;;^UTILITY(U,$J,358.3,10555,0)
 ;;=11422^^84^645^9^^^^1
 ;;^UTILITY(U,$J,358.3,10555,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10555,1,2,0)
 ;;=2^Excision Benign Lesion-scalp, neck, hands, feet, genitalia; 1.1cm to 2.0cm
 ;;^UTILITY(U,$J,358.3,10555,1,3,0)
 ;;=3^11422
 ;;^UTILITY(U,$J,358.3,10556,0)
 ;;=11423^^84^645^10^^^^1
 ;;^UTILITY(U,$J,358.3,10556,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10556,1,2,0)
 ;;=2^Excision Benign Lesion-scalp, neck, hands, feet, genitalia; 2.1cm to 4.0cm
 ;;^UTILITY(U,$J,358.3,10556,1,3,0)
 ;;=3^11423
 ;;^UTILITY(U,$J,358.3,10557,0)
 ;;=11424^^84^645^11^^^^1
 ;;^UTILITY(U,$J,358.3,10557,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10557,1,2,0)
 ;;=2^Excision Benign Lesion-scalp, neck, hands,feet, genitalia; 3.1cm to 4.0cm 
 ;;^UTILITY(U,$J,358.3,10557,1,3,0)
 ;;=3^11424
 ;;^UTILITY(U,$J,358.3,10558,0)
 ;;=11426^^84^645^12^^^^1
 ;;^UTILITY(U,$J,358.3,10558,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10558,1,2,0)
 ;;=2^Excision Benign Lesion-scalp, neck, hands, feet, genitalia; over 4.0cm
 ;;^UTILITY(U,$J,358.3,10558,1,3,0)
 ;;=3^11426
 ;;^UTILITY(U,$J,358.3,10559,0)
 ;;=11600^^84^646^1^^^^1
 ;;^UTILITY(U,$J,358.3,10559,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10559,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 0.5cm or less
 ;;^UTILITY(U,$J,358.3,10559,1,3,0)
 ;;=3^11600
 ;;^UTILITY(U,$J,358.3,10560,0)
 ;;=11601^^84^646^2^^^^1
 ;;^UTILITY(U,$J,358.3,10560,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10560,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 0.6cm to 1.0cm
 ;;^UTILITY(U,$J,358.3,10560,1,3,0)
 ;;=3^11601
 ;;^UTILITY(U,$J,358.3,10561,0)
 ;;=11602^^84^646^3^^^^1
 ;;^UTILITY(U,$J,358.3,10561,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10561,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 1.1cm to 2.0cm
 ;;^UTILITY(U,$J,358.3,10561,1,3,0)
 ;;=3^11602
 ;;^UTILITY(U,$J,358.3,10562,0)
 ;;=11603^^84^646^4^^^^1
 ;;^UTILITY(U,$J,358.3,10562,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10562,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 2.1cm to 3.0cm
 ;;^UTILITY(U,$J,358.3,10562,1,3,0)
 ;;=3^11603
 ;;^UTILITY(U,$J,358.3,10563,0)
 ;;=11604^^84^646^5^^^^1
 ;;^UTILITY(U,$J,358.3,10563,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10563,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 3.1cm to 4.0cm
 ;;^UTILITY(U,$J,358.3,10563,1,3,0)
 ;;=3^11604
 ;;^UTILITY(U,$J,358.3,10564,0)
 ;;=11606^^84^646^6^^^^1
 ;;^UTILITY(U,$J,358.3,10564,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10564,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; over 4.0cm
 ;;^UTILITY(U,$J,358.3,10564,1,3,0)
 ;;=3^11606
 ;;^UTILITY(U,$J,358.3,10565,0)
 ;;=11620^^84^646^7^^^^1
 ;;^UTILITY(U,$J,358.3,10565,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10565,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 0.5cm or less
 ;;^UTILITY(U,$J,358.3,10565,1,3,0)
 ;;=3^11620
 ;;^UTILITY(U,$J,358.3,10566,0)
 ;;=11621^^84^646^8^^^^1
 ;;^UTILITY(U,$J,358.3,10566,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10566,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 0.6cm to 1.0cm
 ;;^UTILITY(U,$J,358.3,10566,1,3,0)
 ;;=3^11621
 ;;^UTILITY(U,$J,358.3,10567,0)
 ;;=11622^^84^646^9^^^^1
 ;;^UTILITY(U,$J,358.3,10567,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10567,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 1.1cm to 2.0cm
 ;;^UTILITY(U,$J,358.3,10567,1,3,0)
 ;;=3^11622
 ;;^UTILITY(U,$J,358.3,10568,0)
 ;;=11623^^84^646^10^^^^1
 ;;^UTILITY(U,$J,358.3,10568,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10568,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 2.1cm to 3.0cm
 ;;^UTILITY(U,$J,358.3,10568,1,3,0)
 ;;=3^11623
 ;;^UTILITY(U,$J,358.3,10569,0)
 ;;=11624^^84^646^11^^^^1
 ;;^UTILITY(U,$J,358.3,10569,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10569,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 3.1cm to 4.0cm
 ;;^UTILITY(U,$J,358.3,10569,1,3,0)
 ;;=3^11624
 ;;^UTILITY(U,$J,358.3,10570,0)
 ;;=11626^^84^646^12^^^^1
 ;;^UTILITY(U,$J,358.3,10570,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10570,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, gentalia; over 4.0cm
 ;;^UTILITY(U,$J,358.3,10570,1,3,0)
 ;;=3^11626
 ;;^UTILITY(U,$J,358.3,10571,0)
 ;;=12001^^84^647^1^^^^1
 ;;^UTILITY(U,$J,358.3,10571,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10571,1,2,0)
 ;;=2^Simple Repair of Superficial Wounds of scalp, neck, azillae, external genitalia, trunk, extriemities; 2.5cm or less 
 ;;^UTILITY(U,$J,358.3,10571,1,3,0)
 ;;=3^12001
 ;;^UTILITY(U,$J,358.3,10572,0)
 ;;=12002^^84^647^2^^^^1
 ;;^UTILITY(U,$J,358.3,10572,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10572,1,2,0)
 ;;=2^Simple Repair of Superficial Wounds of scalp, neck, exillae, external genitalia, trunk, extremities; 2.6cm to 7.5cm 
 ;;^UTILITY(U,$J,358.3,10572,1,3,0)
 ;;=3^12002
 ;;^UTILITY(U,$J,358.3,10573,0)
 ;;=12041^^84^647^3^^^^1
 ;;^UTILITY(U,$J,358.3,10573,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10573,1,2,0)
 ;;=2^Layer Closure of Wounds of neck, hands, feet, external genitalia; 2.5cm or less
 ;;^UTILITY(U,$J,358.3,10573,1,3,0)
 ;;=3^12041
 ;;^UTILITY(U,$J,358.3,10574,0)
 ;;=12042^^84^647^4^^^^1
 ;;^UTILITY(U,$J,358.3,10574,1,0)
 ;;=^358.31IA^3^2
