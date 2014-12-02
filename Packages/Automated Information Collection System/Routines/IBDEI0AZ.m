IBDEI0AZ ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5135,0)
 ;;=173.91^^39^426^38
 ;;^UTILITY(U,$J,358.3,5135,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5135,1,2,0)
 ;;=2^173.91
 ;;^UTILITY(U,$J,358.3,5135,1,5,0)
 ;;=5^BCC of skin, unspecified site
 ;;^UTILITY(U,$J,358.3,5135,2)
 ;;=^340491
 ;;^UTILITY(U,$J,358.3,5136,0)
 ;;=173.92^^39^426^39
 ;;^UTILITY(U,$J,358.3,5136,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5136,1,2,0)
 ;;=2^173.92
 ;;^UTILITY(U,$J,358.3,5136,1,5,0)
 ;;=5^SCC of skin, unspecified site
 ;;^UTILITY(U,$J,358.3,5136,2)
 ;;=^340492
 ;;^UTILITY(U,$J,358.3,5137,0)
 ;;=173.99^^39^426^40
 ;;^UTILITY(U,$J,358.3,5137,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5137,1,2,0)
 ;;=2^173.99
 ;;^UTILITY(U,$J,358.3,5137,1,5,0)
 ;;=5^Other spec neoplasm skin, site unspec
 ;;^UTILITY(U,$J,358.3,5137,2)
 ;;=^340493
 ;;^UTILITY(U,$J,358.3,5138,0)
 ;;=11000^^40^427^1^^^^1
 ;;^UTILITY(U,$J,358.3,5138,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5138,1,2,0)
 ;;=2^11000
 ;;^UTILITY(U,$J,358.3,5138,1,3,0)
 ;;=3^Debride ext eczematous skin,<10%
 ;;^UTILITY(U,$J,358.3,5139,0)
 ;;=11001^^40^427^2^^^^1
 ;;^UTILITY(U,$J,358.3,5139,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5139,1,2,0)
 ;;=2^11001
 ;;^UTILITY(U,$J,358.3,5139,1,3,0)
 ;;=3^Debride ext eczematous skin,Ea 10%
 ;;^UTILITY(U,$J,358.3,5140,0)
 ;;=17000^^40^428^4^^^^1
 ;;^UTILITY(U,$J,358.3,5140,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5140,1,2,0)
 ;;=2^17000
 ;;^UTILITY(U,$J,358.3,5140,1,3,0)
 ;;=3^Destroy 1st Premalignant Lesion
 ;;^UTILITY(U,$J,358.3,5141,0)
 ;;=17004^^40^428^3^^^^1
 ;;^UTILITY(U,$J,358.3,5141,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5141,1,2,0)
 ;;=2^17004
 ;;^UTILITY(U,$J,358.3,5141,1,3,0)
 ;;=3^Destroy 15+ Premalignant Lesions
 ;;^UTILITY(U,$J,358.3,5142,0)
 ;;=17110^^40^428^1^^^^1
 ;;^UTILITY(U,$J,358.3,5142,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5142,1,2,0)
 ;;=2^17110
 ;;^UTILITY(U,$J,358.3,5142,1,3,0)
 ;;=3^Destroy 1-14 Benign Lesions
 ;;^UTILITY(U,$J,358.3,5143,0)
 ;;=17111^^40^428^2^^^^1
 ;;^UTILITY(U,$J,358.3,5143,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5143,1,2,0)
 ;;=2^17111
 ;;^UTILITY(U,$J,358.3,5143,1,3,0)
 ;;=3^Destroy 15+ Benign Lesions
 ;;^UTILITY(U,$J,358.3,5144,0)
 ;;=17003^^40^428^5^^^^1
 ;;^UTILITY(U,$J,358.3,5144,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5144,1,2,0)
 ;;=2^17003
 ;;^UTILITY(U,$J,358.3,5144,1,3,0)
 ;;=3^Destroy 2-14 Premalignant Lesions
 ;;^UTILITY(U,$J,358.3,5145,0)
 ;;=17260^^40^429^1^^^^1
 ;;^UTILITY(U,$J,358.3,5145,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5145,1,2,0)
 ;;=2^17260
 ;;^UTILITY(U,$J,358.3,5145,1,3,0)
 ;;=3^Dest Mal Lesion Tnk/Arm/Leg,0.5cm or less
 ;;^UTILITY(U,$J,358.3,5146,0)
 ;;=17261^^40^429^2^^^^1
 ;;^UTILITY(U,$J,358.3,5146,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5146,1,2,0)
 ;;=2^17261
 ;;^UTILITY(U,$J,358.3,5146,1,3,0)
 ;;=3^Dest Mal Lesion Tnk/Arm/Leg,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5147,0)
 ;;=17262^^40^429^3^^^^1
 ;;^UTILITY(U,$J,358.3,5147,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5147,1,2,0)
 ;;=2^17262
 ;;^UTILITY(U,$J,358.3,5147,1,3,0)
 ;;=3^Dest Mal Lesion Tnk/Arm/Leg,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5148,0)
 ;;=17263^^40^429^4^^^^1
 ;;^UTILITY(U,$J,358.3,5148,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5148,1,2,0)
 ;;=2^17263
 ;;^UTILITY(U,$J,358.3,5148,1,3,0)
 ;;=3^Dest Mal Lesion Tnk/Arm/Leg,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5149,0)
 ;;=17264^^40^429^5^^^^1
 ;;^UTILITY(U,$J,358.3,5149,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5149,1,2,0)
 ;;=2^17264
 ;;^UTILITY(U,$J,358.3,5149,1,3,0)
 ;;=3^Dest Mal Lesion Tnk/Arm/Leg,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5150,0)
 ;;=17266^^40^429^6^^^^1
