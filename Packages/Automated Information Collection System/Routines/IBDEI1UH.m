IBDEI1UH ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31329,1,3,0)
 ;;=3^11402
 ;;^UTILITY(U,$J,358.3,31330,0)
 ;;=11403^^125^1584^4^^^^1
 ;;^UTILITY(U,$J,358.3,31330,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31330,1,2,0)
 ;;=2^Exc Benign Lesion-Trunk,Legs;2.1cm-3.0cm
 ;;^UTILITY(U,$J,358.3,31330,1,3,0)
 ;;=3^11403
 ;;^UTILITY(U,$J,358.3,31331,0)
 ;;=11404^^125^1584^5^^^^1
 ;;^UTILITY(U,$J,358.3,31331,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31331,1,2,0)
 ;;=2^Exc Benign Lesion-Trunk,Legs;3.1cm-4.0cm
 ;;^UTILITY(U,$J,358.3,31331,1,3,0)
 ;;=3^11404
 ;;^UTILITY(U,$J,358.3,31332,0)
 ;;=11406^^125^1584^6^^^^1
 ;;^UTILITY(U,$J,358.3,31332,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31332,1,2,0)
 ;;=2^Exc Benign Lesion-Trunk,Legs;> 4.0cm
 ;;^UTILITY(U,$J,358.3,31332,1,3,0)
 ;;=3^11406
 ;;^UTILITY(U,$J,358.3,31333,0)
 ;;=11420^^125^1584^7^^^^1
 ;;^UTILITY(U,$J,358.3,31333,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31333,1,2,0)
 ;;=2^Exc Benign Lesion-Scalp,Neck,Hands,Ft,Genita;0.5cm or less
 ;;^UTILITY(U,$J,358.3,31333,1,3,0)
 ;;=3^11420
 ;;^UTILITY(U,$J,358.3,31334,0)
 ;;=11421^^125^1584^8^^^^1
 ;;^UTILITY(U,$J,358.3,31334,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31334,1,2,0)
 ;;=2^Exc Benign Lesion-Scalp,Neck,Hands,Ft,Genita;0.6cm-1.0cm
 ;;^UTILITY(U,$J,358.3,31334,1,3,0)
 ;;=3^11421
 ;;^UTILITY(U,$J,358.3,31335,0)
 ;;=11422^^125^1584^9^^^^1
 ;;^UTILITY(U,$J,358.3,31335,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31335,1,2,0)
 ;;=2^Exc Benign Lesion-Scalp,Neck,Hands,Ft,Genita;1.1cm-2.0cm
 ;;^UTILITY(U,$J,358.3,31335,1,3,0)
 ;;=3^11422
 ;;^UTILITY(U,$J,358.3,31336,0)
 ;;=11423^^125^1584^10^^^^1
 ;;^UTILITY(U,$J,358.3,31336,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31336,1,2,0)
 ;;=2^Exc Benign Lesion-Scalp,Neck,Hands,Ft,Genita;2.1cm-3.0cm
 ;;^UTILITY(U,$J,358.3,31336,1,3,0)
 ;;=3^11423
 ;;^UTILITY(U,$J,358.3,31337,0)
 ;;=11424^^125^1584^11^^^^1
 ;;^UTILITY(U,$J,358.3,31337,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31337,1,2,0)
 ;;=2^Exc Benign Lesion-Scalp,Neck,Hands,Ft,Genita;3.1cm-4.0cm
 ;;^UTILITY(U,$J,358.3,31337,1,3,0)
 ;;=3^11424
 ;;^UTILITY(U,$J,358.3,31338,0)
 ;;=11426^^125^1584^12^^^^1
 ;;^UTILITY(U,$J,358.3,31338,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31338,1,2,0)
 ;;=2^Exc Benign Lesion-Scalp,Neck,Hands,Ft,Genita;> 4.0cm
 ;;^UTILITY(U,$J,358.3,31338,1,3,0)
 ;;=3^11426
 ;;^UTILITY(U,$J,358.3,31339,0)
 ;;=11600^^125^1585^1^^^^1
 ;;^UTILITY(U,$J,358.3,31339,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31339,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 0.5cm or less
 ;;^UTILITY(U,$J,358.3,31339,1,3,0)
 ;;=3^11600
 ;;^UTILITY(U,$J,358.3,31340,0)
 ;;=11601^^125^1585^2^^^^1
 ;;^UTILITY(U,$J,358.3,31340,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31340,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 0.6cm to 1.0cm
 ;;^UTILITY(U,$J,358.3,31340,1,3,0)
 ;;=3^11601
 ;;^UTILITY(U,$J,358.3,31341,0)
 ;;=11602^^125^1585^3^^^^1
 ;;^UTILITY(U,$J,358.3,31341,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31341,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 1.1cm to 2.0cm
 ;;^UTILITY(U,$J,358.3,31341,1,3,0)
 ;;=3^11602
 ;;^UTILITY(U,$J,358.3,31342,0)
 ;;=11603^^125^1585^4^^^^1
 ;;^UTILITY(U,$J,358.3,31342,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31342,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 2.1cm to 3.0cm
 ;;^UTILITY(U,$J,358.3,31342,1,3,0)
 ;;=3^11603
 ;;^UTILITY(U,$J,358.3,31343,0)
 ;;=11604^^125^1585^5^^^^1
 ;;^UTILITY(U,$J,358.3,31343,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31343,1,2,0)
 ;;=2^Excision Malignant Lesions-trunk, arms or legs; 3.1cm to 4.0cm
