IBDEI0BL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4949,1,4,0)
 ;;=4^19001
 ;;^UTILITY(U,$J,358.3,4950,0)
 ;;=26011^^39^330^9
 ;;^UTILITY(U,$J,358.3,4950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4950,1,2,0)
 ;;=2^Drain abscess finger,complic
 ;;^UTILITY(U,$J,358.3,4950,1,4,0)
 ;;=4^26011
 ;;^UTILITY(U,$J,358.3,4951,0)
 ;;=26020^^39^330^13
 ;;^UTILITY(U,$J,358.3,4951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4951,1,2,0)
 ;;=2^Drain tendon sheath,Ea Hand
 ;;^UTILITY(U,$J,358.3,4951,1,4,0)
 ;;=4^26020
 ;;^UTILITY(U,$J,358.3,4952,0)
 ;;=10120^^39^330^24
 ;;^UTILITY(U,$J,358.3,4952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4952,1,2,0)
 ;;=2^Removal,foreign body,simple
 ;;^UTILITY(U,$J,358.3,4952,1,4,0)
 ;;=4^10120
 ;;^UTILITY(U,$J,358.3,4953,0)
 ;;=10121^^39^330^23
 ;;^UTILITY(U,$J,358.3,4953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4953,1,2,0)
 ;;=2^Removal,foreign body,complex
 ;;^UTILITY(U,$J,358.3,4953,1,4,0)
 ;;=4^10121
 ;;^UTILITY(U,$J,358.3,4954,0)
 ;;=26010^^39^330^10^^^^1
 ;;^UTILITY(U,$J,358.3,4954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4954,1,2,0)
 ;;=2^Drain abscess finger,simple
 ;;^UTILITY(U,$J,358.3,4954,1,4,0)
 ;;=4^26010
 ;;^UTILITY(U,$J,358.3,4955,0)
 ;;=10180^^39^330^18^^^^1
 ;;^UTILITY(U,$J,358.3,4955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4955,1,2,0)
 ;;=2^I&D complex postop wound
 ;;^UTILITY(U,$J,358.3,4955,1,4,0)
 ;;=4^10180
 ;;^UTILITY(U,$J,358.3,4956,0)
 ;;=20600^^39^330^6^^^^1
 ;;^UTILITY(U,$J,358.3,4956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4956,1,2,0)
 ;;=2^Aspir/inject bursa/small joint w/o US
 ;;^UTILITY(U,$J,358.3,4956,1,4,0)
 ;;=4^20600
 ;;^UTILITY(U,$J,358.3,4957,0)
 ;;=20605^^39^330^2^^^^1
 ;;^UTILITY(U,$J,358.3,4957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4957,1,2,0)
 ;;=2^Aspir/inject bursa/intmed joint w/o US
 ;;^UTILITY(U,$J,358.3,4957,1,4,0)
 ;;=4^20605
 ;;^UTILITY(U,$J,358.3,4958,0)
 ;;=20610^^39^330^4^^^^1
 ;;^UTILITY(U,$J,358.3,4958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4958,1,2,0)
 ;;=2^Aspir/inject bursa/large joint w/o US
 ;;^UTILITY(U,$J,358.3,4958,1,4,0)
 ;;=4^20610
 ;;^UTILITY(U,$J,358.3,4959,0)
 ;;=10080^^39^330^11^^^^1
 ;;^UTILITY(U,$J,358.3,4959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4959,1,2,0)
 ;;=2^Drain pilonidal cyst, simple
 ;;^UTILITY(U,$J,358.3,4959,1,4,0)
 ;;=4^10080
 ;;^UTILITY(U,$J,358.3,4960,0)
 ;;=10081^^39^330^12^^^^1
 ;;^UTILITY(U,$J,358.3,4960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4960,1,2,0)
 ;;=2^Drain pilonidal cyst,complex
 ;;^UTILITY(U,$J,358.3,4960,1,4,0)
 ;;=4^10081
 ;;^UTILITY(U,$J,358.3,4961,0)
 ;;=10021^^39^330^15^^^^1
 ;;^UTILITY(U,$J,358.3,4961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4961,1,2,0)
 ;;=2^FNA w/o Image Guidance
 ;;^UTILITY(U,$J,358.3,4961,1,4,0)
 ;;=4^10021
 ;;^UTILITY(U,$J,358.3,4962,0)
 ;;=10022^^39^330^14^^^^1
 ;;^UTILITY(U,$J,358.3,4962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4962,1,2,0)
 ;;=2^FNA w/ Image Guidance
 ;;^UTILITY(U,$J,358.3,4962,1,4,0)
 ;;=4^10022
 ;;^UTILITY(U,$J,358.3,4963,0)
 ;;=19020^^39^330^21^^^^1
 ;;^UTILITY(U,$J,358.3,4963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4963,1,2,0)
 ;;=2^Mastotomy w/Explor/Drainage of Abscess Deep
 ;;^UTILITY(U,$J,358.3,4963,1,4,0)
 ;;=4^19020
 ;;^UTILITY(U,$J,358.3,4964,0)
 ;;=10030^^39^330^20^^^^1
 ;;^UTILITY(U,$J,358.3,4964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4964,1,2,0)
 ;;=2^Image Guided Collect Cath Absc/Cyst
 ;;^UTILITY(U,$J,358.3,4964,1,4,0)
 ;;=4^10030
 ;;^UTILITY(U,$J,358.3,4965,0)
 ;;=20606^^39^330^1^^^^1
 ;;^UTILITY(U,$J,358.3,4965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4965,1,2,0)
 ;;=2^Aspir/inject bursa/intmed joint w/ US
