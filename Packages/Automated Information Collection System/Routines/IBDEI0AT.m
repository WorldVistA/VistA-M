IBDEI0AT ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5052,1,5,0)
 ;;=5^Malig neoplasm skin, arm/shoulder
 ;;^UTILITY(U,$J,358.3,5052,2)
 ;;=^340602
 ;;^UTILITY(U,$J,358.3,5053,0)
 ;;=173.61^^39^415^26
 ;;^UTILITY(U,$J,358.3,5053,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5053,1,2,0)
 ;;=2^173.61
 ;;^UTILITY(U,$J,358.3,5053,1,5,0)
 ;;=5^BCC of skin of arm/shoulder
 ;;^UTILITY(U,$J,358.3,5053,2)
 ;;=^340482
 ;;^UTILITY(U,$J,358.3,5054,0)
 ;;=173.62^^39^415^27
 ;;^UTILITY(U,$J,358.3,5054,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5054,1,2,0)
 ;;=2^173.62
 ;;^UTILITY(U,$J,358.3,5054,1,5,0)
 ;;=5^SCC of skin of arm/shoulder
 ;;^UTILITY(U,$J,358.3,5054,2)
 ;;=^340483
 ;;^UTILITY(U,$J,358.3,5055,0)
 ;;=173.69^^39^415^28
 ;;^UTILITY(U,$J,358.3,5055,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5055,1,2,0)
 ;;=2^173.69
 ;;^UTILITY(U,$J,358.3,5055,1,5,0)
 ;;=5^Other spec neoplasm skin, arm/shoulder
 ;;^UTILITY(U,$J,358.3,5055,2)
 ;;=^340484
 ;;^UTILITY(U,$J,358.3,5056,0)
 ;;=173.70^^39^415^29
 ;;^UTILITY(U,$J,358.3,5056,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5056,1,2,0)
 ;;=2^173.70
 ;;^UTILITY(U,$J,358.3,5056,1,5,0)
 ;;=5^Malig neoplasm skin, leg/hip
 ;;^UTILITY(U,$J,358.3,5056,2)
 ;;=^340603
 ;;^UTILITY(U,$J,358.3,5057,0)
 ;;=173.71^^39^415^30
 ;;^UTILITY(U,$J,358.3,5057,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5057,1,2,0)
 ;;=2^173.71
 ;;^UTILITY(U,$J,358.3,5057,1,5,0)
 ;;=5^BCC of skin of leg/hip
 ;;^UTILITY(U,$J,358.3,5057,2)
 ;;=^340485
 ;;^UTILITY(U,$J,358.3,5058,0)
 ;;=173.72^^39^415^31
 ;;^UTILITY(U,$J,358.3,5058,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5058,1,2,0)
 ;;=2^173.72
 ;;^UTILITY(U,$J,358.3,5058,1,5,0)
 ;;=5^SCC of skin of leg/hip
 ;;^UTILITY(U,$J,358.3,5058,2)
 ;;=^340486
 ;;^UTILITY(U,$J,358.3,5059,0)
 ;;=173.79^^39^415^32
 ;;^UTILITY(U,$J,358.3,5059,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5059,1,2,0)
 ;;=2^173.79
 ;;^UTILITY(U,$J,358.3,5059,1,5,0)
 ;;=5^Other spec neoplasm skin, leg/hip
 ;;^UTILITY(U,$J,358.3,5059,2)
 ;;=^340487
 ;;^UTILITY(U,$J,358.3,5060,0)
 ;;=173.80^^39^415^33
 ;;^UTILITY(U,$J,358.3,5060,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5060,1,2,0)
 ;;=2^173.80
 ;;^UTILITY(U,$J,358.3,5060,1,5,0)
 ;;=5^Malig neoplasm skin, other sites NOS
 ;;^UTILITY(U,$J,358.3,5060,2)
 ;;=^340604
 ;;^UTILITY(U,$J,358.3,5061,0)
 ;;=173.81^^39^415^34
 ;;^UTILITY(U,$J,358.3,5061,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5061,1,2,0)
 ;;=2^173.81
 ;;^UTILITY(U,$J,358.3,5061,1,5,0)
 ;;=5^BCC of skin of specified sites
 ;;^UTILITY(U,$J,358.3,5061,2)
 ;;=^340488
 ;;^UTILITY(U,$J,358.3,5062,0)
 ;;=173.82^^39^415^35
 ;;^UTILITY(U,$J,358.3,5062,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5062,1,2,0)
 ;;=2^173.82
 ;;^UTILITY(U,$J,358.3,5062,1,5,0)
 ;;=5^SCC of skin of specified sites
 ;;^UTILITY(U,$J,358.3,5062,2)
 ;;=^340489
 ;;^UTILITY(U,$J,358.3,5063,0)
 ;;=173.89^^39^415^36
 ;;^UTILITY(U,$J,358.3,5063,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5063,1,2,0)
 ;;=2^173.89
 ;;^UTILITY(U,$J,358.3,5063,1,5,0)
 ;;=5^Other spec neoplasm skin, other sites
 ;;^UTILITY(U,$J,358.3,5063,2)
 ;;=^340490
 ;;^UTILITY(U,$J,358.3,5064,0)
 ;;=173.90^^39^415^37
 ;;^UTILITY(U,$J,358.3,5064,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5064,1,2,0)
 ;;=2^173.90
 ;;^UTILITY(U,$J,358.3,5064,1,5,0)
 ;;=5^Malig neoplasm skin, site unspec
 ;;^UTILITY(U,$J,358.3,5064,2)
 ;;=^340605
 ;;^UTILITY(U,$J,358.3,5065,0)
 ;;=173.91^^39^415^38
 ;;^UTILITY(U,$J,358.3,5065,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5065,1,2,0)
 ;;=2^173.91
 ;;^UTILITY(U,$J,358.3,5065,1,5,0)
 ;;=5^BCC of skin, unspecified site
 ;;^UTILITY(U,$J,358.3,5065,2)
 ;;=^340491
