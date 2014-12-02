IBDEI0B4 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5212,0)
 ;;=17280^^40^439^1^^^^1
 ;;^UTILITY(U,$J,358.3,5212,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5212,1,2,0)
 ;;=2^17280
 ;;^UTILITY(U,$J,358.3,5212,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,0.5cm or less
 ;;^UTILITY(U,$J,358.3,5213,0)
 ;;=17281^^40^439^2^^^^1
 ;;^UTILITY(U,$J,358.3,5213,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5213,1,2,0)
 ;;=2^17281
 ;;^UTILITY(U,$J,358.3,5213,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5214,0)
 ;;=17282^^40^439^3^^^^1
 ;;^UTILITY(U,$J,358.3,5214,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5214,1,2,0)
 ;;=2^17282
 ;;^UTILITY(U,$J,358.3,5214,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5215,0)
 ;;=17283^^40^439^4^^^^1
 ;;^UTILITY(U,$J,358.3,5215,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5215,1,2,0)
 ;;=2^17283
 ;;^UTILITY(U,$J,358.3,5215,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5216,0)
 ;;=17284^^40^439^5^^^^1
 ;;^UTILITY(U,$J,358.3,5216,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5216,1,2,0)
 ;;=2^17284
 ;;^UTILITY(U,$J,358.3,5216,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5217,0)
 ;;=17286^^40^439^6^^^^1
 ;;^UTILITY(U,$J,358.3,5217,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5217,1,2,0)
 ;;=2^17286
 ;;^UTILITY(U,$J,358.3,5217,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous > 4.0cm
 ;;^UTILITY(U,$J,358.3,5218,0)
 ;;=11420^^40^440^1^^^^1
 ;;^UTILITY(U,$J,358.3,5218,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5218,1,2,0)
 ;;=2^11420
 ;;^UTILITY(U,$J,358.3,5218,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,0.5cm or less
 ;;^UTILITY(U,$J,358.3,5219,0)
 ;;=11421^^40^440^2^^^^1
 ;;^UTILITY(U,$J,358.3,5219,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5219,1,2,0)
 ;;=2^11421
 ;;^UTILITY(U,$J,358.3,5219,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5220,0)
 ;;=11422^^40^440^3^^^^1
 ;;^UTILITY(U,$J,358.3,5220,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5220,1,2,0)
 ;;=2^11422
 ;;^UTILITY(U,$J,358.3,5220,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5221,0)
 ;;=11423^^40^440^4^^^^1
 ;;^UTILITY(U,$J,358.3,5221,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5221,1,2,0)
 ;;=2^11423
 ;;^UTILITY(U,$J,358.3,5221,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5222,0)
 ;;=11424^^40^440^5^^^^1
 ;;^UTILITY(U,$J,358.3,5222,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5222,1,2,0)
 ;;=2^11424
 ;;^UTILITY(U,$J,358.3,5222,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5223,0)
 ;;=11426^^40^440^6^^^^1
 ;;^UTILITY(U,$J,358.3,5223,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5223,1,2,0)
 ;;=2^11426
 ;;^UTILITY(U,$J,358.3,5223,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen > 4.0cm
 ;;^UTILITY(U,$J,358.3,5224,0)
 ;;=11440^^40^441^1^^^^1
 ;;^UTILITY(U,$J,358.3,5224,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5224,1,2,0)
 ;;=2^11440
 ;;^UTILITY(U,$J,358.3,5224,1,3,0)
 ;;=3^Exc Ben Lesion Face/Mucous,0.5cm or less
 ;;^UTILITY(U,$J,358.3,5225,0)
 ;;=11441^^40^441^2^^^^1
 ;;^UTILITY(U,$J,358.3,5225,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5225,1,2,0)
 ;;=2^11441
 ;;^UTILITY(U,$J,358.3,5225,1,3,0)
 ;;=3^Exc Ben Lesion Face/Mucous,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5226,0)
 ;;=11442^^40^441^3^^^^1
 ;;^UTILITY(U,$J,358.3,5226,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5226,1,2,0)
 ;;=2^11442
 ;;^UTILITY(U,$J,358.3,5226,1,3,0)
 ;;=3^Exc Ben Lesion Face/Mucous,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5227,0)
 ;;=11443^^40^441^4^^^^1
