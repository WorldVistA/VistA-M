IBDEI0TF ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14243,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14243,1,2,0)
 ;;=2^Exc Benign Lesion-Trunk,Legs;2.1cm-3.0cm
 ;;^UTILITY(U,$J,358.3,14243,1,3,0)
 ;;=3^11403
 ;;^UTILITY(U,$J,358.3,14244,0)
 ;;=11404^^75^877^5^^^^1
 ;;^UTILITY(U,$J,358.3,14244,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14244,1,2,0)
 ;;=2^Exc Benign Lesion-Trunk,Legs;3.1cm-4.0cm
 ;;^UTILITY(U,$J,358.3,14244,1,3,0)
 ;;=3^11404
 ;;^UTILITY(U,$J,358.3,14245,0)
 ;;=11406^^75^877^6^^^^1
 ;;^UTILITY(U,$J,358.3,14245,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14245,1,2,0)
 ;;=2^Exc Benign Lesion-Trunk,Legs;> 4.0cm
 ;;^UTILITY(U,$J,358.3,14245,1,3,0)
 ;;=3^11406
 ;;^UTILITY(U,$J,358.3,14246,0)
 ;;=11420^^75^877^7^^^^1
 ;;^UTILITY(U,$J,358.3,14246,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14246,1,2,0)
 ;;=2^Exc Benign Lesion-Scalp,Neck,Hands,Ft,Genita;0.5cm or less
 ;;^UTILITY(U,$J,358.3,14246,1,3,0)
 ;;=3^11420
 ;;^UTILITY(U,$J,358.3,14247,0)
 ;;=11421^^75^877^8^^^^1
 ;;^UTILITY(U,$J,358.3,14247,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14247,1,2,0)
 ;;=2^Exc Benign Lesion-Scalp,Neck,Hands,Ft,Genita;0.6cm-1.0cm
 ;;^UTILITY(U,$J,358.3,14247,1,3,0)
 ;;=3^11421
 ;;^UTILITY(U,$J,358.3,14248,0)
 ;;=11422^^75^877^9^^^^1
 ;;^UTILITY(U,$J,358.3,14248,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14248,1,2,0)
 ;;=2^Exc Benign Lesion-Scalp,Neck,Hands,Ft,Genita;1.1cm-2.0cm
 ;;^UTILITY(U,$J,358.3,14248,1,3,0)
 ;;=3^11422
 ;;^UTILITY(U,$J,358.3,14249,0)
 ;;=11423^^75^877^10^^^^1
 ;;^UTILITY(U,$J,358.3,14249,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14249,1,2,0)
 ;;=2^Exc Benign Lesion-Scalp,Neck,Hands,Ft,Genita;2.1cm-3.0cm
 ;;^UTILITY(U,$J,358.3,14249,1,3,0)
 ;;=3^11423
 ;;^UTILITY(U,$J,358.3,14250,0)
 ;;=11424^^75^877^11^^^^1
 ;;^UTILITY(U,$J,358.3,14250,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14250,1,2,0)
 ;;=2^Exc Benign Lesion-Scalp,Neck,Hands,Ft,Genita;3.1cm-4.0cm
 ;;^UTILITY(U,$J,358.3,14250,1,3,0)
 ;;=3^11424
 ;;^UTILITY(U,$J,358.3,14251,0)
 ;;=11426^^75^877^12^^^^1
 ;;^UTILITY(U,$J,358.3,14251,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14251,1,2,0)
 ;;=2^Exc Benign Lesion-Scalp,Neck,Hands,Ft,Genita;> 4.0cm
 ;;^UTILITY(U,$J,358.3,14251,1,3,0)
 ;;=3^11426
 ;;^UTILITY(U,$J,358.3,14252,0)
 ;;=11600^^75^878^1^^^^1
 ;;^UTILITY(U,$J,358.3,14252,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14252,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 0.5cm or less
 ;;^UTILITY(U,$J,358.3,14252,1,3,0)
 ;;=3^11600
 ;;^UTILITY(U,$J,358.3,14253,0)
 ;;=11601^^75^878^2^^^^1
 ;;^UTILITY(U,$J,358.3,14253,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14253,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 0.6cm to 1.0cm
 ;;^UTILITY(U,$J,358.3,14253,1,3,0)
 ;;=3^11601
 ;;^UTILITY(U,$J,358.3,14254,0)
 ;;=11602^^75^878^3^^^^1
 ;;^UTILITY(U,$J,358.3,14254,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14254,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 1.1cm to 2.0cm
 ;;^UTILITY(U,$J,358.3,14254,1,3,0)
 ;;=3^11602
 ;;^UTILITY(U,$J,358.3,14255,0)
 ;;=11603^^75^878^4^^^^1
 ;;^UTILITY(U,$J,358.3,14255,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14255,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 2.1cm to 3.0cm
 ;;^UTILITY(U,$J,358.3,14255,1,3,0)
 ;;=3^11603
 ;;^UTILITY(U,$J,358.3,14256,0)
 ;;=11604^^75^878^5^^^^1
 ;;^UTILITY(U,$J,358.3,14256,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14256,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 3.1cm to 4.0cm
 ;;^UTILITY(U,$J,358.3,14256,1,3,0)
 ;;=3^11604
 ;;^UTILITY(U,$J,358.3,14257,0)
 ;;=11606^^75^878^6^^^^1
