IBDEI2HA ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41581,1,3,0)
 ;;=3^11422
 ;;^UTILITY(U,$J,358.3,41582,0)
 ;;=11423^^191^2112^10^^^^1
 ;;^UTILITY(U,$J,358.3,41582,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41582,1,2,0)
 ;;=2^Exc Benign Lesion-Scalp,Neck,Hands,Ft,Genita;2.1cm-3.0cm
 ;;^UTILITY(U,$J,358.3,41582,1,3,0)
 ;;=3^11423
 ;;^UTILITY(U,$J,358.3,41583,0)
 ;;=11424^^191^2112^11^^^^1
 ;;^UTILITY(U,$J,358.3,41583,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41583,1,2,0)
 ;;=2^Exc Benign Lesion-Scalp,Neck,Hands,Ft,Genita;3.1cm-4.0cm
 ;;^UTILITY(U,$J,358.3,41583,1,3,0)
 ;;=3^11424
 ;;^UTILITY(U,$J,358.3,41584,0)
 ;;=11426^^191^2112^12^^^^1
 ;;^UTILITY(U,$J,358.3,41584,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41584,1,2,0)
 ;;=2^Exc Benign Lesion-Scalp,Neck,Hands,Ft,Genita;> 4.0cm
 ;;^UTILITY(U,$J,358.3,41584,1,3,0)
 ;;=3^11426
 ;;^UTILITY(U,$J,358.3,41585,0)
 ;;=11600^^191^2113^1^^^^1
 ;;^UTILITY(U,$J,358.3,41585,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41585,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 0.5cm or less
 ;;^UTILITY(U,$J,358.3,41585,1,3,0)
 ;;=3^11600
 ;;^UTILITY(U,$J,358.3,41586,0)
 ;;=11601^^191^2113^2^^^^1
 ;;^UTILITY(U,$J,358.3,41586,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41586,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 0.6cm to 1.0cm
 ;;^UTILITY(U,$J,358.3,41586,1,3,0)
 ;;=3^11601
 ;;^UTILITY(U,$J,358.3,41587,0)
 ;;=11602^^191^2113^3^^^^1
 ;;^UTILITY(U,$J,358.3,41587,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41587,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 1.1cm to 2.0cm
 ;;^UTILITY(U,$J,358.3,41587,1,3,0)
 ;;=3^11602
 ;;^UTILITY(U,$J,358.3,41588,0)
 ;;=11603^^191^2113^4^^^^1
 ;;^UTILITY(U,$J,358.3,41588,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41588,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 2.1cm to 3.0cm
 ;;^UTILITY(U,$J,358.3,41588,1,3,0)
 ;;=3^11603
 ;;^UTILITY(U,$J,358.3,41589,0)
 ;;=11604^^191^2113^5^^^^1
 ;;^UTILITY(U,$J,358.3,41589,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41589,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 3.1cm to 4.0cm
 ;;^UTILITY(U,$J,358.3,41589,1,3,0)
 ;;=3^11604
 ;;^UTILITY(U,$J,358.3,41590,0)
 ;;=11606^^191^2113^6^^^^1
 ;;^UTILITY(U,$J,358.3,41590,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41590,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; over 4.0cm
 ;;^UTILITY(U,$J,358.3,41590,1,3,0)
 ;;=3^11606
 ;;^UTILITY(U,$J,358.3,41591,0)
 ;;=11620^^191^2113^7^^^^1
 ;;^UTILITY(U,$J,358.3,41591,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41591,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 0.5cm or less
 ;;^UTILITY(U,$J,358.3,41591,1,3,0)
 ;;=3^11620
 ;;^UTILITY(U,$J,358.3,41592,0)
 ;;=11621^^191^2113^8^^^^1
 ;;^UTILITY(U,$J,358.3,41592,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41592,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 0.6cm to 1.0cm
 ;;^UTILITY(U,$J,358.3,41592,1,3,0)
 ;;=3^11621
 ;;^UTILITY(U,$J,358.3,41593,0)
 ;;=11622^^191^2113^9^^^^1
 ;;^UTILITY(U,$J,358.3,41593,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41593,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 1.1cm to 2.0cm
 ;;^UTILITY(U,$J,358.3,41593,1,3,0)
 ;;=3^11622
 ;;^UTILITY(U,$J,358.3,41594,0)
 ;;=11623^^191^2113^10^^^^1
 ;;^UTILITY(U,$J,358.3,41594,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41594,1,2,0)
 ;;=2^Excision Malignant Lesions-scalp, neck, hands, feet, genitalia; 2.1cm to 3.0cm
 ;;^UTILITY(U,$J,358.3,41594,1,3,0)
 ;;=3^11623
 ;;^UTILITY(U,$J,358.3,41595,0)
 ;;=11624^^191^2113^11^^^^1
