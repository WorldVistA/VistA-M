IBDEI1C3 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23922,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23922,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; over 4.0cm
 ;;^UTILITY(U,$J,358.3,23922,1,3,0)
 ;;=3^11606
 ;;^UTILITY(U,$J,358.3,23923,0)
 ;;=11620^^142^1487^7^^^^1
 ;;^UTILITY(U,$J,358.3,23923,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23923,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 0.5cm or less
 ;;^UTILITY(U,$J,358.3,23923,1,3,0)
 ;;=3^11620
 ;;^UTILITY(U,$J,358.3,23924,0)
 ;;=11621^^142^1487^8^^^^1
 ;;^UTILITY(U,$J,358.3,23924,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23924,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 0.6cm to 1.0cm
 ;;^UTILITY(U,$J,358.3,23924,1,3,0)
 ;;=3^11621
 ;;^UTILITY(U,$J,358.3,23925,0)
 ;;=11622^^142^1487^9^^^^1
 ;;^UTILITY(U,$J,358.3,23925,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23925,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 1.1cm to 2.0cm
 ;;^UTILITY(U,$J,358.3,23925,1,3,0)
 ;;=3^11622
 ;;^UTILITY(U,$J,358.3,23926,0)
 ;;=11623^^142^1487^10^^^^1
 ;;^UTILITY(U,$J,358.3,23926,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23926,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 2.1cm to 3.0cm
 ;;^UTILITY(U,$J,358.3,23926,1,3,0)
 ;;=3^11623
 ;;^UTILITY(U,$J,358.3,23927,0)
 ;;=11624^^142^1487^11^^^^1
 ;;^UTILITY(U,$J,358.3,23927,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23927,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 3.1cm to 4.0cm
 ;;^UTILITY(U,$J,358.3,23927,1,3,0)
 ;;=3^11624
 ;;^UTILITY(U,$J,358.3,23928,0)
 ;;=11626^^142^1487^12^^^^1
 ;;^UTILITY(U,$J,358.3,23928,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23928,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, gentalia; over 4.0cm
 ;;^UTILITY(U,$J,358.3,23928,1,3,0)
 ;;=3^11626
 ;;^UTILITY(U,$J,358.3,23929,0)
 ;;=12001^^142^1488^1^^^^1
 ;;^UTILITY(U,$J,358.3,23929,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23929,1,2,0)
 ;;=2^Simple Repair of Superficial Wounds of scalp, neck, azillae, external genitalia, trunk, extriemities; 2.5cm or less 
 ;;^UTILITY(U,$J,358.3,23929,1,3,0)
 ;;=3^12001
 ;;^UTILITY(U,$J,358.3,23930,0)
 ;;=12002^^142^1488^2^^^^1
 ;;^UTILITY(U,$J,358.3,23930,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23930,1,2,0)
 ;;=2^Simple Repair of Superficial Wounds of scalp, neck, exillae, external genitalia, trunk, extremities; 2.6cm to 7.5cm 
 ;;^UTILITY(U,$J,358.3,23930,1,3,0)
 ;;=3^12002
 ;;^UTILITY(U,$J,358.3,23931,0)
 ;;=12041^^142^1488^3^^^^1
 ;;^UTILITY(U,$J,358.3,23931,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23931,1,2,0)
 ;;=2^Layer Closure of Wounds of neck, hands, feet, external genitalia; 2.5cm or less
 ;;^UTILITY(U,$J,358.3,23931,1,3,0)
 ;;=3^12041
 ;;^UTILITY(U,$J,358.3,23932,0)
 ;;=12042^^142^1488^4^^^^1
 ;;^UTILITY(U,$J,358.3,23932,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23932,1,2,0)
 ;;=2^Layer Closure of Wounds of neck, hands, feet, external genitalia; 2.6cm to 7.5cm
 ;;^UTILITY(U,$J,358.3,23932,1,3,0)
 ;;=3^12042
 ;;^UTILITY(U,$J,358.3,23933,0)
 ;;=12031^^142^1488^5^^^^1
 ;;^UTILITY(U,$J,358.3,23933,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23933,1,2,0)
 ;;=2^Layer Closure of Wounds of scalp, axillae, trunk, extremities; 2.5cm or less Wounds of
 ;;^UTILITY(U,$J,358.3,23933,1,3,0)
 ;;=3^12031
 ;;^UTILITY(U,$J,358.3,23934,0)
 ;;=12032^^142^1488^6^^^^1
 ;;^UTILITY(U,$J,358.3,23934,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23934,1,2,0)
 ;;=2^Layer Closure of Wounds of scalp, axillae, trunk, extremities; 2.6cm to 7.5cm Wounds of
