IBDEI1C2 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23908,1,3,0)
 ;;=3^11403
 ;;^UTILITY(U,$J,358.3,23909,0)
 ;;=11404^^142^1486^5^^^^1
 ;;^UTILITY(U,$J,358.3,23909,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23909,1,2,0)
 ;;=2^Excision Benign Lesion-trunk,  legs; 3.1cm to 4.0cm
 ;;^UTILITY(U,$J,358.3,23909,1,3,0)
 ;;=3^11404
 ;;^UTILITY(U,$J,358.3,23910,0)
 ;;=11406^^142^1486^6^^^^1
 ;;^UTILITY(U,$J,358.3,23910,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23910,1,2,0)
 ;;=2^Excision Benign Lesion-trunk,  legs; over 4.0cm
 ;;^UTILITY(U,$J,358.3,23910,1,3,0)
 ;;=3^11406
 ;;^UTILITY(U,$J,358.3,23911,0)
 ;;=11420^^142^1486^7^^^^1
 ;;^UTILITY(U,$J,358.3,23911,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23911,1,2,0)
 ;;=2^Excisiofeet, genitalia; 0.5cm or less
 ;;^UTILITY(U,$J,358.3,23911,1,3,0)
 ;;=3^11420
 ;;^UTILITY(U,$J,358.3,23912,0)
 ;;=11421^^142^1486^8^^^^1
 ;;^UTILITY(U,$J,358.3,23912,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23912,1,2,0)
 ;;=2^Excision Benign Lesion-scalp, neck, hands, feet, genitalia; 0.6cm to 1.0cm
 ;;^UTILITY(U,$J,358.3,23912,1,3,0)
 ;;=3^11421
 ;;^UTILITY(U,$J,358.3,23913,0)
 ;;=11422^^142^1486^9^^^^1
 ;;^UTILITY(U,$J,358.3,23913,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23913,1,2,0)
 ;;=2^Excision Benign Lesion-scalp, neck, hands, feet, genitalia; 1.1cm to 2.0cm
 ;;^UTILITY(U,$J,358.3,23913,1,3,0)
 ;;=3^11422
 ;;^UTILITY(U,$J,358.3,23914,0)
 ;;=11423^^142^1486^10^^^^1
 ;;^UTILITY(U,$J,358.3,23914,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23914,1,2,0)
 ;;=2^Excision Benign Lesion-scalp, neck, hands, feet, genitalia; 2.1cm to 4.0cm
 ;;^UTILITY(U,$J,358.3,23914,1,3,0)
 ;;=3^11423
 ;;^UTILITY(U,$J,358.3,23915,0)
 ;;=11424^^142^1486^11^^^^1
 ;;^UTILITY(U,$J,358.3,23915,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23915,1,2,0)
 ;;=2^Excision Benign Lesion-scalp, neck, hands,feet, genitalia; 3.1cm to 4.0cm 
 ;;^UTILITY(U,$J,358.3,23915,1,3,0)
 ;;=3^11424
 ;;^UTILITY(U,$J,358.3,23916,0)
 ;;=11426^^142^1486^12^^^^1
 ;;^UTILITY(U,$J,358.3,23916,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23916,1,2,0)
 ;;=2^Excision Benign Lesion-scalp, neck, hands, feet, genitalia; over 4.0cm
 ;;^UTILITY(U,$J,358.3,23916,1,3,0)
 ;;=3^11426
 ;;^UTILITY(U,$J,358.3,23917,0)
 ;;=11600^^142^1487^1^^^^1
 ;;^UTILITY(U,$J,358.3,23917,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23917,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 0.5cm or less
 ;;^UTILITY(U,$J,358.3,23917,1,3,0)
 ;;=3^11600
 ;;^UTILITY(U,$J,358.3,23918,0)
 ;;=11601^^142^1487^2^^^^1
 ;;^UTILITY(U,$J,358.3,23918,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23918,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 0.6cm to 1.0cm
 ;;^UTILITY(U,$J,358.3,23918,1,3,0)
 ;;=3^11601
 ;;^UTILITY(U,$J,358.3,23919,0)
 ;;=11602^^142^1487^3^^^^1
 ;;^UTILITY(U,$J,358.3,23919,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23919,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 1.1cm to 2.0cm
 ;;^UTILITY(U,$J,358.3,23919,1,3,0)
 ;;=3^11602
 ;;^UTILITY(U,$J,358.3,23920,0)
 ;;=11603^^142^1487^4^^^^1
 ;;^UTILITY(U,$J,358.3,23920,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23920,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 2.1cm to 3.0cm
 ;;^UTILITY(U,$J,358.3,23920,1,3,0)
 ;;=3^11603
 ;;^UTILITY(U,$J,358.3,23921,0)
 ;;=11604^^142^1487^5^^^^1
 ;;^UTILITY(U,$J,358.3,23921,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23921,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 3.1cm to 4.0cm
 ;;^UTILITY(U,$J,358.3,23921,1,3,0)
 ;;=3^11604
 ;;^UTILITY(U,$J,358.3,23922,0)
 ;;=11606^^142^1487^6^^^^1
