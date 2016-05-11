IBDEI0A8 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4550,2)
 ;;=^5009206
 ;;^UTILITY(U,$J,358.3,4551,0)
 ;;=B35.0^^21^282^2
 ;;^UTILITY(U,$J,358.3,4551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4551,1,3,0)
 ;;=3^Tinea Barae/Capitis
 ;;^UTILITY(U,$J,358.3,4551,1,4,0)
 ;;=4^B35.0
 ;;^UTILITY(U,$J,358.3,4551,2)
 ;;=^5000604
 ;;^UTILITY(U,$J,358.3,4552,0)
 ;;=B36.3^^21^282^3
 ;;^UTILITY(U,$J,358.3,4552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4552,1,3,0)
 ;;=3^Tinea Blanca
 ;;^UTILITY(U,$J,358.3,4552,1,4,0)
 ;;=4^B36.3
 ;;^UTILITY(U,$J,358.3,4552,2)
 ;;=^266864
 ;;^UTILITY(U,$J,358.3,4553,0)
 ;;=B36.1^^21^282^7
 ;;^UTILITY(U,$J,358.3,4553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4553,1,3,0)
 ;;=3^Tinea Nigra
 ;;^UTILITY(U,$J,358.3,4553,1,4,0)
 ;;=4^B36.1
 ;;^UTILITY(U,$J,358.3,4553,2)
 ;;=^264999
 ;;^UTILITY(U,$J,358.3,4554,0)
 ;;=B36.0^^21^282^10
 ;;^UTILITY(U,$J,358.3,4554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4554,1,3,0)
 ;;=3^Tinea Veriscolor
 ;;^UTILITY(U,$J,358.3,4554,1,4,0)
 ;;=4^B36.0
 ;;^UTILITY(U,$J,358.3,4554,2)
 ;;=^5000608
 ;;^UTILITY(U,$J,358.3,4555,0)
 ;;=L81.8^^21^282^1
 ;;^UTILITY(U,$J,358.3,4555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4555,1,3,0)
 ;;=3^Tattoo Pigmentation
 ;;^UTILITY(U,$J,358.3,4555,1,4,0)
 ;;=4^L81.8
 ;;^UTILITY(U,$J,358.3,4555,2)
 ;;=^5009318
 ;;^UTILITY(U,$J,358.3,4556,0)
 ;;=L80.^^21^283^12
 ;;^UTILITY(U,$J,358.3,4556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4556,1,3,0)
 ;;=3^Vitiligo
 ;;^UTILITY(U,$J,358.3,4556,1,4,0)
 ;;=4^L80.
 ;;^UTILITY(U,$J,358.3,4556,2)
 ;;=^127071
 ;;^UTILITY(U,$J,358.3,4557,0)
 ;;=I83.019^^21^283^7
 ;;^UTILITY(U,$J,358.3,4557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4557,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer Site Unspec
 ;;^UTILITY(U,$J,358.3,4557,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,4557,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,4558,0)
 ;;=I83.029^^21^283^2
 ;;^UTILITY(U,$J,358.3,4558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4558,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer Site Unspec
 ;;^UTILITY(U,$J,358.3,4558,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,4558,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,4559,0)
 ;;=I83.012^^21^283^8
 ;;^UTILITY(U,$J,358.3,4559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4559,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,4559,1,4,0)
 ;;=4^I83.012
 ;;^UTILITY(U,$J,358.3,4559,2)
 ;;=^5007974
 ;;^UTILITY(U,$J,358.3,4560,0)
 ;;=I83.013^^21^283^9
 ;;^UTILITY(U,$J,358.3,4560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4560,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,4560,1,4,0)
 ;;=4^I83.013
 ;;^UTILITY(U,$J,358.3,4560,2)
 ;;=^5007975
 ;;^UTILITY(U,$J,358.3,4561,0)
 ;;=I83.014^^21^283^10
 ;;^UTILITY(U,$J,358.3,4561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4561,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,4561,1,4,0)
 ;;=4^I83.014
 ;;^UTILITY(U,$J,358.3,4561,2)
 ;;=^5007976
 ;;^UTILITY(U,$J,358.3,4562,0)
 ;;=I83.11^^21^283^6
 ;;^UTILITY(U,$J,358.3,4562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4562,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Inflammation
 ;;^UTILITY(U,$J,358.3,4562,1,4,0)
 ;;=4^I83.11
 ;;^UTILITY(U,$J,358.3,4562,2)
 ;;=^5007988
 ;;^UTILITY(U,$J,358.3,4563,0)
 ;;=I83.022^^21^283^3
 ;;^UTILITY(U,$J,358.3,4563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4563,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,4563,1,4,0)
 ;;=4^I83.022
 ;;^UTILITY(U,$J,358.3,4563,2)
 ;;=^5007981
