IBDEI0FQ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6949,1,3,0)
 ;;=3^Toxic Epidermal Necrolysis
 ;;^UTILITY(U,$J,358.3,6949,1,4,0)
 ;;=4^L51.2
 ;;^UTILITY(U,$J,358.3,6949,2)
 ;;=^5009206
 ;;^UTILITY(U,$J,358.3,6950,0)
 ;;=B35.0^^46^456^2
 ;;^UTILITY(U,$J,358.3,6950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6950,1,3,0)
 ;;=3^Tinea Barae/Capitis
 ;;^UTILITY(U,$J,358.3,6950,1,4,0)
 ;;=4^B35.0
 ;;^UTILITY(U,$J,358.3,6950,2)
 ;;=^5000604
 ;;^UTILITY(U,$J,358.3,6951,0)
 ;;=B36.3^^46^456^3
 ;;^UTILITY(U,$J,358.3,6951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6951,1,3,0)
 ;;=3^Tinea Blanca
 ;;^UTILITY(U,$J,358.3,6951,1,4,0)
 ;;=4^B36.3
 ;;^UTILITY(U,$J,358.3,6951,2)
 ;;=^266864
 ;;^UTILITY(U,$J,358.3,6952,0)
 ;;=B36.1^^46^456^7
 ;;^UTILITY(U,$J,358.3,6952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6952,1,3,0)
 ;;=3^Tinea Nigra
 ;;^UTILITY(U,$J,358.3,6952,1,4,0)
 ;;=4^B36.1
 ;;^UTILITY(U,$J,358.3,6952,2)
 ;;=^264999
 ;;^UTILITY(U,$J,358.3,6953,0)
 ;;=B36.0^^46^456^10
 ;;^UTILITY(U,$J,358.3,6953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6953,1,3,0)
 ;;=3^Tinea Veriscolor
 ;;^UTILITY(U,$J,358.3,6953,1,4,0)
 ;;=4^B36.0
 ;;^UTILITY(U,$J,358.3,6953,2)
 ;;=^5000608
 ;;^UTILITY(U,$J,358.3,6954,0)
 ;;=L81.8^^46^456^1
 ;;^UTILITY(U,$J,358.3,6954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6954,1,3,0)
 ;;=3^Tattoo Pigmentation
 ;;^UTILITY(U,$J,358.3,6954,1,4,0)
 ;;=4^L81.8
 ;;^UTILITY(U,$J,358.3,6954,2)
 ;;=^5009318
 ;;^UTILITY(U,$J,358.3,6955,0)
 ;;=L80.^^46^457^12
 ;;^UTILITY(U,$J,358.3,6955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6955,1,3,0)
 ;;=3^Vitiligo
 ;;^UTILITY(U,$J,358.3,6955,1,4,0)
 ;;=4^L80.
 ;;^UTILITY(U,$J,358.3,6955,2)
 ;;=^127071
 ;;^UTILITY(U,$J,358.3,6956,0)
 ;;=I83.019^^46^457^7
 ;;^UTILITY(U,$J,358.3,6956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6956,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer Site Unspec
 ;;^UTILITY(U,$J,358.3,6956,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,6956,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,6957,0)
 ;;=I83.029^^46^457^2
 ;;^UTILITY(U,$J,358.3,6957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6957,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer Site Unspec
 ;;^UTILITY(U,$J,358.3,6957,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,6957,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,6958,0)
 ;;=I83.012^^46^457^8
 ;;^UTILITY(U,$J,358.3,6958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6958,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,6958,1,4,0)
 ;;=4^I83.012
 ;;^UTILITY(U,$J,358.3,6958,2)
 ;;=^5007974
 ;;^UTILITY(U,$J,358.3,6959,0)
 ;;=I83.013^^46^457^9
 ;;^UTILITY(U,$J,358.3,6959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6959,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,6959,1,4,0)
 ;;=4^I83.013
 ;;^UTILITY(U,$J,358.3,6959,2)
 ;;=^5007975
 ;;^UTILITY(U,$J,358.3,6960,0)
 ;;=I83.014^^46^457^10
 ;;^UTILITY(U,$J,358.3,6960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6960,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,6960,1,4,0)
 ;;=4^I83.014
 ;;^UTILITY(U,$J,358.3,6960,2)
 ;;=^5007976
 ;;^UTILITY(U,$J,358.3,6961,0)
 ;;=I83.11^^46^457^6
 ;;^UTILITY(U,$J,358.3,6961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6961,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Inflammation
 ;;^UTILITY(U,$J,358.3,6961,1,4,0)
 ;;=4^I83.11
 ;;^UTILITY(U,$J,358.3,6961,2)
 ;;=^5007988
 ;;^UTILITY(U,$J,358.3,6962,0)
 ;;=I83.022^^46^457^3
 ;;^UTILITY(U,$J,358.3,6962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6962,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer of Calf
