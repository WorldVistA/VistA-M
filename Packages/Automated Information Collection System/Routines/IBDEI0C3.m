IBDEI0C3 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5353,2)
 ;;=^340490
 ;;^UTILITY(U,$J,358.3,5354,0)
 ;;=173.90^^25^324^37
 ;;^UTILITY(U,$J,358.3,5354,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5354,1,2,0)
 ;;=2^173.90
 ;;^UTILITY(U,$J,358.3,5354,1,5,0)
 ;;=5^Malig neoplasm skin, site unspec
 ;;^UTILITY(U,$J,358.3,5354,2)
 ;;=^340605
 ;;^UTILITY(U,$J,358.3,5355,0)
 ;;=173.91^^25^324^38
 ;;^UTILITY(U,$J,358.3,5355,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5355,1,2,0)
 ;;=2^173.91
 ;;^UTILITY(U,$J,358.3,5355,1,5,0)
 ;;=5^BCC of skin, unspecified site
 ;;^UTILITY(U,$J,358.3,5355,2)
 ;;=^340491
 ;;^UTILITY(U,$J,358.3,5356,0)
 ;;=173.92^^25^324^39
 ;;^UTILITY(U,$J,358.3,5356,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5356,1,2,0)
 ;;=2^173.92
 ;;^UTILITY(U,$J,358.3,5356,1,5,0)
 ;;=5^SCC of skin, unspecified site
 ;;^UTILITY(U,$J,358.3,5356,2)
 ;;=^340492
 ;;^UTILITY(U,$J,358.3,5357,0)
 ;;=173.99^^25^324^40
 ;;^UTILITY(U,$J,358.3,5357,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5357,1,2,0)
 ;;=2^173.99
 ;;^UTILITY(U,$J,358.3,5357,1,5,0)
 ;;=5^Other spec neoplasm skin, site unspec
 ;;^UTILITY(U,$J,358.3,5357,2)
 ;;=^340493
 ;;^UTILITY(U,$J,358.3,5358,0)
 ;;=11000^^26^325^1^^^^1
 ;;^UTILITY(U,$J,358.3,5358,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5358,1,2,0)
 ;;=2^11000
 ;;^UTILITY(U,$J,358.3,5358,1,3,0)
 ;;=3^Debride ext eczematous skin,<10%
 ;;^UTILITY(U,$J,358.3,5359,0)
 ;;=11001^^26^325^2^^^^1
 ;;^UTILITY(U,$J,358.3,5359,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5359,1,2,0)
 ;;=2^11001
 ;;^UTILITY(U,$J,358.3,5359,1,3,0)
 ;;=3^Debride ext eczematous skin,Ea 10%
 ;;^UTILITY(U,$J,358.3,5360,0)
 ;;=11042^^26^325^3^^^^1
 ;;^UTILITY(U,$J,358.3,5360,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5360,1,2,0)
 ;;=2^11042
 ;;^UTILITY(U,$J,358.3,5360,1,3,0)
 ;;=3^Debride Subcut (epi/derm);20sq cm or <
 ;;^UTILITY(U,$J,358.3,5361,0)
 ;;=11045^^26^325^4^^^^1
 ;;^UTILITY(U,$J,358.3,5361,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5361,1,2,0)
 ;;=2^11045
 ;;^UTILITY(U,$J,358.3,5361,1,3,0)
 ;;=3^Debride Subcut (epi/derm);Ea Addl 20sq cm
 ;;^UTILITY(U,$J,358.3,5362,0)
 ;;=17000^^26^326^4^^^^1
 ;;^UTILITY(U,$J,358.3,5362,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5362,1,2,0)
 ;;=2^17000
 ;;^UTILITY(U,$J,358.3,5362,1,3,0)
 ;;=3^Destroy 1st Premalignant Lesion
 ;;^UTILITY(U,$J,358.3,5363,0)
 ;;=17004^^26^326^3^^^^1
 ;;^UTILITY(U,$J,358.3,5363,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5363,1,2,0)
 ;;=2^17004
 ;;^UTILITY(U,$J,358.3,5363,1,3,0)
 ;;=3^Destroy 15+ Premalignant Lesions
 ;;^UTILITY(U,$J,358.3,5364,0)
 ;;=17110^^26^326^1^^^^1
 ;;^UTILITY(U,$J,358.3,5364,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5364,1,2,0)
 ;;=2^17110
 ;;^UTILITY(U,$J,358.3,5364,1,3,0)
 ;;=3^Destroy 1-14 Benign Lesions
 ;;^UTILITY(U,$J,358.3,5365,0)
 ;;=17111^^26^326^2^^^^1
 ;;^UTILITY(U,$J,358.3,5365,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5365,1,2,0)
 ;;=2^17111
 ;;^UTILITY(U,$J,358.3,5365,1,3,0)
 ;;=3^Destroy 15+ Benign Lesions
 ;;^UTILITY(U,$J,358.3,5366,0)
 ;;=17003^^26^326^5^^^^1
 ;;^UTILITY(U,$J,358.3,5366,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5366,1,2,0)
 ;;=2^17003
 ;;^UTILITY(U,$J,358.3,5366,1,3,0)
 ;;=3^Destroy 2-14 Premalignant Lesions
 ;;^UTILITY(U,$J,358.3,5367,0)
 ;;=17260^^26^327^1^^^^1
 ;;^UTILITY(U,$J,358.3,5367,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5367,1,2,0)
 ;;=2^17260
 ;;^UTILITY(U,$J,358.3,5367,1,3,0)
 ;;=3^Dest Mal Lesion Tnk/Arm/Leg,0.5cm or <
 ;;^UTILITY(U,$J,358.3,5368,0)
 ;;=17261^^26^327^2^^^^1
 ;;^UTILITY(U,$J,358.3,5368,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5368,1,2,0)
 ;;=2^17261
 ;;^UTILITY(U,$J,358.3,5368,1,3,0)
 ;;=3^Dest Mal Lesion Tnk/Arm/Leg,0.6-1.0cm
