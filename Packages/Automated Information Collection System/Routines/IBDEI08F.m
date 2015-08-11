IBDEI08F ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3807,0)
 ;;=173.99^^31^344^40
 ;;^UTILITY(U,$J,358.3,3807,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3807,1,2,0)
 ;;=2^173.99
 ;;^UTILITY(U,$J,358.3,3807,1,5,0)
 ;;=5^Other spec neoplasm skin, site unspec
 ;;^UTILITY(U,$J,358.3,3807,2)
 ;;=^340493
 ;;^UTILITY(U,$J,358.3,3808,0)
 ;;=11000^^32^345^1^^^^1
 ;;^UTILITY(U,$J,358.3,3808,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3808,1,2,0)
 ;;=2^11000
 ;;^UTILITY(U,$J,358.3,3808,1,3,0)
 ;;=3^Debride ext eczematous skin,<10%
 ;;^UTILITY(U,$J,358.3,3809,0)
 ;;=11001^^32^345^2^^^^1
 ;;^UTILITY(U,$J,358.3,3809,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3809,1,2,0)
 ;;=2^11001
 ;;^UTILITY(U,$J,358.3,3809,1,3,0)
 ;;=3^Debride ext eczematous skin,Ea 10%
 ;;^UTILITY(U,$J,358.3,3810,0)
 ;;=11042^^32^345^3^^^^1
 ;;^UTILITY(U,$J,358.3,3810,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3810,1,2,0)
 ;;=2^11042
 ;;^UTILITY(U,$J,358.3,3810,1,3,0)
 ;;=3^Debride Subcut (epi/derm);20sq cm or <
 ;;^UTILITY(U,$J,358.3,3811,0)
 ;;=11045^^32^345^4^^^^1
 ;;^UTILITY(U,$J,358.3,3811,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3811,1,2,0)
 ;;=2^11045
 ;;^UTILITY(U,$J,358.3,3811,1,3,0)
 ;;=3^Debride Subcut (epi/derm);Ea Addl 20sq cm
 ;;^UTILITY(U,$J,358.3,3812,0)
 ;;=17000^^32^346^4^^^^1
 ;;^UTILITY(U,$J,358.3,3812,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3812,1,2,0)
 ;;=2^17000
 ;;^UTILITY(U,$J,358.3,3812,1,3,0)
 ;;=3^Destroy 1st Premalignant Lesion
 ;;^UTILITY(U,$J,358.3,3813,0)
 ;;=17004^^32^346^3^^^^1
 ;;^UTILITY(U,$J,358.3,3813,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3813,1,2,0)
 ;;=2^17004
 ;;^UTILITY(U,$J,358.3,3813,1,3,0)
 ;;=3^Destroy 15+ Premalignant Lesions
 ;;^UTILITY(U,$J,358.3,3814,0)
 ;;=17110^^32^346^1^^^^1
 ;;^UTILITY(U,$J,358.3,3814,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3814,1,2,0)
 ;;=2^17110
 ;;^UTILITY(U,$J,358.3,3814,1,3,0)
 ;;=3^Destroy 1-14 Benign Lesions
 ;;^UTILITY(U,$J,358.3,3815,0)
 ;;=17111^^32^346^2^^^^1
 ;;^UTILITY(U,$J,358.3,3815,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3815,1,2,0)
 ;;=2^17111
 ;;^UTILITY(U,$J,358.3,3815,1,3,0)
 ;;=3^Destroy 15+ Benign Lesions
 ;;^UTILITY(U,$J,358.3,3816,0)
 ;;=17003^^32^346^5^^^^1
 ;;^UTILITY(U,$J,358.3,3816,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3816,1,2,0)
 ;;=2^17003
 ;;^UTILITY(U,$J,358.3,3816,1,3,0)
 ;;=3^Destroy 2-14 Premalignant Lesions
 ;;^UTILITY(U,$J,358.3,3817,0)
 ;;=17260^^32^347^1^^^^1
 ;;^UTILITY(U,$J,358.3,3817,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3817,1,2,0)
 ;;=2^17260
 ;;^UTILITY(U,$J,358.3,3817,1,3,0)
 ;;=3^Dest Mal Lesion Tnk/Arm/Leg,0.5cm or <
 ;;^UTILITY(U,$J,358.3,3818,0)
 ;;=17261^^32^347^2^^^^1
 ;;^UTILITY(U,$J,358.3,3818,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3818,1,2,0)
 ;;=2^17261
 ;;^UTILITY(U,$J,358.3,3818,1,3,0)
 ;;=3^Dest Mal Lesion Tnk/Arm/Leg,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,3819,0)
 ;;=17262^^32^347^3^^^^1
 ;;^UTILITY(U,$J,358.3,3819,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3819,1,2,0)
 ;;=2^17262
 ;;^UTILITY(U,$J,358.3,3819,1,3,0)
 ;;=3^Dest Mal Lesion Tnk/Arm/Leg,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,3820,0)
 ;;=17263^^32^347^4^^^^1
 ;;^UTILITY(U,$J,358.3,3820,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3820,1,2,0)
 ;;=2^17263
 ;;^UTILITY(U,$J,358.3,3820,1,3,0)
 ;;=3^Dest Mal Lesion Tnk/Arm/Leg,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,3821,0)
 ;;=17264^^32^347^5^^^^1
 ;;^UTILITY(U,$J,358.3,3821,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3821,1,2,0)
 ;;=2^17264
 ;;^UTILITY(U,$J,358.3,3821,1,3,0)
 ;;=3^Dest Mal Lesion Tnk/Arm/Leg,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,3822,0)
 ;;=17266^^32^347^6^^^^1
 ;;^UTILITY(U,$J,358.3,3822,1,0)
 ;;=^358.31IA^3^2
