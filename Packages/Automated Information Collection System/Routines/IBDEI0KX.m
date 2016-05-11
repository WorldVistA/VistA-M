IBDEI0KX ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9763,1,4,0)
 ;;=4^H10.31
 ;;^UTILITY(U,$J,358.3,9763,2)
 ;;=^5133458
 ;;^UTILITY(U,$J,358.3,9764,0)
 ;;=H10.021^^44^495^120
 ;;^UTILITY(U,$J,358.3,9764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9764,1,3,0)
 ;;=3^Mucopurulent Conjunctivitis,Right Eye NEC
 ;;^UTILITY(U,$J,358.3,9764,1,4,0)
 ;;=4^H10.021
 ;;^UTILITY(U,$J,358.3,9764,2)
 ;;=^5004660
 ;;^UTILITY(U,$J,358.3,9765,0)
 ;;=H10.022^^44^495^119
 ;;^UTILITY(U,$J,358.3,9765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9765,1,3,0)
 ;;=3^Mucopurulent Conjunctivitis,Left Eye NEC
 ;;^UTILITY(U,$J,358.3,9765,1,4,0)
 ;;=4^H10.022
 ;;^UTILITY(U,$J,358.3,9765,2)
 ;;=^5004661
 ;;^UTILITY(U,$J,358.3,9766,0)
 ;;=H10.11^^44^495^11
 ;;^UTILITY(U,$J,358.3,9766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9766,1,3,0)
 ;;=3^Atopic Conjuntivitis,Right Eye,Acute
 ;;^UTILITY(U,$J,358.3,9766,1,4,0)
 ;;=4^H10.11
 ;;^UTILITY(U,$J,358.3,9766,2)
 ;;=^5004665
 ;;^UTILITY(U,$J,358.3,9767,0)
 ;;=H10.12^^44^495^10
 ;;^UTILITY(U,$J,358.3,9767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9767,1,3,0)
 ;;=3^Atopic Conjuntivitis,Left Eye,Acute
 ;;^UTILITY(U,$J,358.3,9767,1,4,0)
 ;;=4^H10.12
 ;;^UTILITY(U,$J,358.3,9767,2)
 ;;=^5004666
 ;;^UTILITY(U,$J,358.3,9768,0)
 ;;=H10.13^^44^495^9
 ;;^UTILITY(U,$J,358.3,9768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9768,1,3,0)
 ;;=3^Atopic Conjuntivitis,Bilateral,Acute
 ;;^UTILITY(U,$J,358.3,9768,1,4,0)
 ;;=4^H10.13
 ;;^UTILITY(U,$J,358.3,9768,2)
 ;;=^5004667
 ;;^UTILITY(U,$J,358.3,9769,0)
 ;;=H10.211^^44^495^159
 ;;^UTILITY(U,$J,358.3,9769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9769,1,3,0)
 ;;=3^Toxic Conjunctivitis,Right Eye,Acute
 ;;^UTILITY(U,$J,358.3,9769,1,4,0)
 ;;=4^H10.211
 ;;^UTILITY(U,$J,358.3,9769,2)
 ;;=^5004668
 ;;^UTILITY(U,$J,358.3,9770,0)
 ;;=H10.212^^44^495^158
 ;;^UTILITY(U,$J,358.3,9770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9770,1,3,0)
 ;;=3^Toxic Conjunctivitis,Left Eye,Acute
 ;;^UTILITY(U,$J,358.3,9770,1,4,0)
 ;;=4^H10.212
 ;;^UTILITY(U,$J,358.3,9770,2)
 ;;=^5004669
 ;;^UTILITY(U,$J,358.3,9771,0)
 ;;=H10.401^^44^495^46
 ;;^UTILITY(U,$J,358.3,9771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9771,1,3,0)
 ;;=3^Conjunctivitis,Right Eye,Chronic
 ;;^UTILITY(U,$J,358.3,9771,1,4,0)
 ;;=4^H10.401
 ;;^UTILITY(U,$J,358.3,9771,2)
 ;;=^5004681
 ;;^UTILITY(U,$J,358.3,9772,0)
 ;;=H10.402^^44^495^45
 ;;^UTILITY(U,$J,358.3,9772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9772,1,3,0)
 ;;=3^Conjunctivitis,Left Eye,Chronic
 ;;^UTILITY(U,$J,358.3,9772,1,4,0)
 ;;=4^H10.402
 ;;^UTILITY(U,$J,358.3,9772,2)
 ;;=^5004682
 ;;^UTILITY(U,$J,358.3,9773,0)
 ;;=H10.411^^44^495^79
 ;;^UTILITY(U,$J,358.3,9773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9773,1,3,0)
 ;;=3^Giant Papillary Conjunctivitis,Right Eye,Chronic
 ;;^UTILITY(U,$J,358.3,9773,1,4,0)
 ;;=4^H10.411
 ;;^UTILITY(U,$J,358.3,9773,2)
 ;;=^5004684
 ;;^UTILITY(U,$J,358.3,9774,0)
 ;;=H10.412^^44^495^78
 ;;^UTILITY(U,$J,358.3,9774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9774,1,3,0)
 ;;=3^Giant Papillary Conjunctivitis,Left Eye,Chronic
 ;;^UTILITY(U,$J,358.3,9774,1,4,0)
 ;;=4^H10.412
 ;;^UTILITY(U,$J,358.3,9774,2)
 ;;=^5004685
 ;;^UTILITY(U,$J,358.3,9775,0)
 ;;=H10.45^^44^495^1
 ;;^UTILITY(U,$J,358.3,9775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9775,1,3,0)
 ;;=3^Allergic Conjunctivitis,Chronic NEC
 ;;^UTILITY(U,$J,358.3,9775,1,4,0)
 ;;=4^H10.45
 ;;^UTILITY(U,$J,358.3,9775,2)
 ;;=^87396
 ;;^UTILITY(U,$J,358.3,9776,0)
 ;;=H10.501^^44^495^21
 ;;^UTILITY(U,$J,358.3,9776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9776,1,3,0)
 ;;=3^Blepharoconjunctivitis,Right Eye,Unspec
