IBDEI0F1 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6597,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6597,1,2,0)
 ;;=2^11642
 ;;^UTILITY(U,$J,358.3,6597,1,3,0)
 ;;=3^Exc Mal Lesion Face/Mucous,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,6598,0)
 ;;=11643^^45^422^4^^^^1
 ;;^UTILITY(U,$J,358.3,6598,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6598,1,2,0)
 ;;=2^11643
 ;;^UTILITY(U,$J,358.3,6598,1,3,0)
 ;;=3^Exc Mal Lesion Face/Mucous,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,6599,0)
 ;;=11644^^45^422^5^^^^1
 ;;^UTILITY(U,$J,358.3,6599,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6599,1,2,0)
 ;;=2^11644
 ;;^UTILITY(U,$J,358.3,6599,1,3,0)
 ;;=3^Exc Mal Lesion Face/Mucous,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,6600,0)
 ;;=11646^^45^422^6^^^^1
 ;;^UTILITY(U,$J,358.3,6600,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6600,1,2,0)
 ;;=2^11646
 ;;^UTILITY(U,$J,358.3,6600,1,3,0)
 ;;=3^Exc Mal lesion Face/Mucous > 4.0cm
 ;;^UTILITY(U,$J,358.3,6601,0)
 ;;=11305^^45^423^1^^^^1
 ;;^UTILITY(U,$J,358.3,6601,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6601,1,2,0)
 ;;=2^11305
 ;;^UTILITY(U,$J,358.3,6601,1,3,0)
 ;;=3^Shaving Epiderm Scalp/Nk/Trunk: 0.5cm or less
 ;;^UTILITY(U,$J,358.3,6602,0)
 ;;=11306^^45^423^2^^^^1
 ;;^UTILITY(U,$J,358.3,6602,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6602,1,2,0)
 ;;=2^11306
 ;;^UTILITY(U,$J,358.3,6602,1,3,0)
 ;;=3^Shaving Epiderm Scalp/Nk/Trunk: 0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,6603,0)
 ;;=11307^^45^423^3^^^^1
 ;;^UTILITY(U,$J,358.3,6603,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6603,1,2,0)
 ;;=2^11307
 ;;^UTILITY(U,$J,358.3,6603,1,3,0)
 ;;=3^Shaving Epiderm Scalp/Nk/Trunk: 1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,6604,0)
 ;;=11308^^45^423^4^^^^1
 ;;^UTILITY(U,$J,358.3,6604,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6604,1,2,0)
 ;;=2^11308
 ;;^UTILITY(U,$J,358.3,6604,1,3,0)
 ;;=3^Shaving Epiderm Scalp/Nk/Trunk > 2.0cm
 ;;^UTILITY(U,$J,358.3,6605,0)
 ;;=11310^^45^424^1^^^^1
 ;;^UTILITY(U,$J,358.3,6605,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6605,1,2,0)
 ;;=2^11310
 ;;^UTILITY(U,$J,358.3,6605,1,3,0)
 ;;=3^Shaving Epiderm Face/Mucous:0.5cm or less
 ;;^UTILITY(U,$J,358.3,6606,0)
 ;;=11311^^45^424^2^^^^1
 ;;^UTILITY(U,$J,358.3,6606,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6606,1,2,0)
 ;;=2^11311
 ;;^UTILITY(U,$J,358.3,6606,1,3,0)
 ;;=3^Shaving Epiderm Face/Mucous: 0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,6607,0)
 ;;=11312^^45^424^3^^^^1
 ;;^UTILITY(U,$J,358.3,6607,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6607,1,2,0)
 ;;=2^11312
 ;;^UTILITY(U,$J,358.3,6607,1,3,0)
 ;;=3^Shaving Epiderm Face/Mucous: 1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,6608,0)
 ;;=11313^^45^424^4^^^^1
 ;;^UTILITY(U,$J,358.3,6608,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6608,1,2,0)
 ;;=2^11313
 ;;^UTILITY(U,$J,358.3,6608,1,3,0)
 ;;=3^Shaving Epiderm Face/Mucous > 2.0cm
 ;;^UTILITY(U,$J,358.3,6609,0)
 ;;=12011^^45^425^1^^^^1
 ;;^UTILITY(U,$J,358.3,6609,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6609,1,2,0)
 ;;=2^12011
 ;;^UTILITY(U,$J,358.3,6609,1,3,0)
 ;;=3^Simple repair Face/Mucous; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,6610,0)
 ;;=12013^^45^425^2^^^^1
 ;;^UTILITY(U,$J,358.3,6610,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6610,1,2,0)
 ;;=2^12013
 ;;^UTILITY(U,$J,358.3,6610,1,3,0)
 ;;=3^Simple repair Face/Mucous; 2.6 cm to 5.0 cm
 ;;^UTILITY(U,$J,358.3,6611,0)
 ;;=12014^^45^425^3^^^^1
 ;;^UTILITY(U,$J,358.3,6611,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6611,1,2,0)
 ;;=2^12014
 ;;^UTILITY(U,$J,358.3,6611,1,3,0)
 ;;=3^Simple repair Face/Mucous; 5.1 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,6612,0)
 ;;=12015^^45^425^4^^^^1
 ;;^UTILITY(U,$J,358.3,6612,1,0)
 ;;=^358.31IA^3^2
