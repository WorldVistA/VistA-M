IBDEI0TC ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14200,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14200,1,2,0)
 ;;=2^Debr of extensive eczematous 10%
 ;;^UTILITY(U,$J,358.3,14200,1,3,0)
 ;;=3^11000
 ;;^UTILITY(U,$J,358.3,14201,0)
 ;;=11010^^75^872^2
 ;;^UTILITY(U,$J,358.3,14201,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14201,1,2,0)
 ;;=2^Debr Rmvl Foreign Material;Skin,Subq Tissue
 ;;^UTILITY(U,$J,358.3,14201,1,3,0)
 ;;=3^11010
 ;;^UTILITY(U,$J,358.3,14202,0)
 ;;=11011^^75^872^3
 ;;^UTILITY(U,$J,358.3,14202,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14202,1,2,0)
 ;;=2^Debr Rmvl Foreign Material;Skin,Subq Tissue,Muscle
 ;;^UTILITY(U,$J,358.3,14202,1,3,0)
 ;;=3^11011
 ;;^UTILITY(U,$J,358.3,14203,0)
 ;;=11042^^75^872^6
 ;;^UTILITY(U,$J,358.3,14203,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14203,1,2,0)
 ;;=2^Debridement; Skin & Subcutaneous Tissue
 ;;^UTILITY(U,$J,358.3,14203,1,3,0)
 ;;=3^11042
 ;;^UTILITY(U,$J,358.3,14204,0)
 ;;=11043^^75^872^7
 ;;^UTILITY(U,$J,358.3,14204,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14204,1,2,0)
 ;;=2^Debridement; Skin, Subcutaneous Tissue & Muscle 
 ;;^UTILITY(U,$J,358.3,14204,1,3,0)
 ;;=3^11043
 ;;^UTILITY(U,$J,358.3,14205,0)
 ;;=11044^^75^872^8
 ;;^UTILITY(U,$J,358.3,14205,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14205,1,2,0)
 ;;=2^Debridement; Skin, Subcutaneous Tissue, Muscle & Bone
 ;;^UTILITY(U,$J,358.3,14205,1,3,0)
 ;;=3^11044
 ;;^UTILITY(U,$J,358.3,14206,0)
 ;;=11012^^75^872^1^^^^1
 ;;^UTILITY(U,$J,358.3,14206,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14206,1,2,0)
 ;;=2^Debr Rmvl Foreign Material;Muscle,Bone
 ;;^UTILITY(U,$J,358.3,14206,1,3,0)
 ;;=3^11012
 ;;^UTILITY(U,$J,358.3,14207,0)
 ;;=11001^^75^872^5^^^^1
 ;;^UTILITY(U,$J,358.3,14207,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14207,1,2,0)
 ;;=2^Debr of extensive eczematous;ea addl 10%
 ;;^UTILITY(U,$J,358.3,14207,1,3,0)
 ;;=3^11001
 ;;^UTILITY(U,$J,358.3,14208,0)
 ;;=97597^^75^872^11^^^^1
 ;;^UTILITY(U,$J,358.3,14208,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14208,1,2,0)
 ;;=2^Rmvl Devital Tiss <= 20 Sq cm
 ;;^UTILITY(U,$J,358.3,14208,1,3,0)
 ;;=3^97597
 ;;^UTILITY(U,$J,358.3,14209,0)
 ;;=97602^^75^872^10^^^^1
 ;;^UTILITY(U,$J,358.3,14209,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14209,1,2,0)
 ;;=2^Non-Selective Debridement
 ;;^UTILITY(U,$J,358.3,14209,1,3,0)
 ;;=3^97602
 ;;^UTILITY(U,$J,358.3,14210,0)
 ;;=97610^^75^872^9^^^^1
 ;;^UTILITY(U,$J,358.3,14210,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14210,1,2,0)
 ;;=2^Low Freq Non-Thermal US,Wound Assess
 ;;^UTILITY(U,$J,358.3,14210,1,3,0)
 ;;=3^97610
 ;;^UTILITY(U,$J,358.3,14211,0)
 ;;=97598^^75^872^12^^^^1
 ;;^UTILITY(U,$J,358.3,14211,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14211,1,2,0)
 ;;=2^Rmvl Devital Tiss,Ea Addl 20 sq cm
 ;;^UTILITY(U,$J,358.3,14211,1,3,0)
 ;;=3^97598
 ;;^UTILITY(U,$J,358.3,14212,0)
 ;;=11300^^75^873^5
 ;;^UTILITY(U,$J,358.3,14212,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14212,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Trunk,Arms,Legs;0.5cm or less
 ;;^UTILITY(U,$J,358.3,14212,1,3,0)
 ;;=3^11300
 ;;^UTILITY(U,$J,358.3,14213,0)
 ;;=11301^^75^873^6
 ;;^UTILITY(U,$J,358.3,14213,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14213,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Trunk,Arms,Legs;0.6cm-1.0cm
 ;;^UTILITY(U,$J,358.3,14213,1,3,0)
 ;;=3^11301
 ;;^UTILITY(U,$J,358.3,14214,0)
 ;;=11302^^75^873^7
 ;;^UTILITY(U,$J,358.3,14214,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14214,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Trunk,Arms,Legs;1.1cm-2.0cm
 ;;^UTILITY(U,$J,358.3,14214,1,3,0)
 ;;=3^11302
