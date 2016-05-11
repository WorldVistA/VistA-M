IBDEI0IS ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8731,2)
 ;;=^5005089
 ;;^UTILITY(U,$J,358.3,8732,0)
 ;;=H18.602^^41^468^105
 ;;^UTILITY(U,$J,358.3,8732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8732,1,3,0)
 ;;=3^Keratoconus,Left Eye,Unspec
 ;;^UTILITY(U,$J,358.3,8732,1,4,0)
 ;;=4^H18.602
 ;;^UTILITY(U,$J,358.3,8732,2)
 ;;=^5005090
 ;;^UTILITY(U,$J,358.3,8733,0)
 ;;=H10.32^^41^468^42
 ;;^UTILITY(U,$J,358.3,8733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8733,1,3,0)
 ;;=3^Conjunctivitis,Acute,Left Eye,Unspec
 ;;^UTILITY(U,$J,358.3,8733,1,4,0)
 ;;=4^H10.32
 ;;^UTILITY(U,$J,358.3,8733,2)
 ;;=^5133459
 ;;^UTILITY(U,$J,358.3,8734,0)
 ;;=H10.31^^41^468^43
 ;;^UTILITY(U,$J,358.3,8734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8734,1,3,0)
 ;;=3^Conjunctivitis,Acute,Right Eye,Unspec
 ;;^UTILITY(U,$J,358.3,8734,1,4,0)
 ;;=4^H10.31
 ;;^UTILITY(U,$J,358.3,8734,2)
 ;;=^5133458
 ;;^UTILITY(U,$J,358.3,8735,0)
 ;;=H10.021^^41^468^120
 ;;^UTILITY(U,$J,358.3,8735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8735,1,3,0)
 ;;=3^Mucopurulent Conjunctivitis,Right Eye NEC
 ;;^UTILITY(U,$J,358.3,8735,1,4,0)
 ;;=4^H10.021
 ;;^UTILITY(U,$J,358.3,8735,2)
 ;;=^5004660
 ;;^UTILITY(U,$J,358.3,8736,0)
 ;;=H10.022^^41^468^119
 ;;^UTILITY(U,$J,358.3,8736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8736,1,3,0)
 ;;=3^Mucopurulent Conjunctivitis,Left Eye NEC
 ;;^UTILITY(U,$J,358.3,8736,1,4,0)
 ;;=4^H10.022
 ;;^UTILITY(U,$J,358.3,8736,2)
 ;;=^5004661
 ;;^UTILITY(U,$J,358.3,8737,0)
 ;;=H10.11^^41^468^11
 ;;^UTILITY(U,$J,358.3,8737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8737,1,3,0)
 ;;=3^Atopic Conjuntivitis,Right Eye,Acute
 ;;^UTILITY(U,$J,358.3,8737,1,4,0)
 ;;=4^H10.11
 ;;^UTILITY(U,$J,358.3,8737,2)
 ;;=^5004665
 ;;^UTILITY(U,$J,358.3,8738,0)
 ;;=H10.12^^41^468^10
 ;;^UTILITY(U,$J,358.3,8738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8738,1,3,0)
 ;;=3^Atopic Conjuntivitis,Left Eye,Acute
 ;;^UTILITY(U,$J,358.3,8738,1,4,0)
 ;;=4^H10.12
 ;;^UTILITY(U,$J,358.3,8738,2)
 ;;=^5004666
 ;;^UTILITY(U,$J,358.3,8739,0)
 ;;=H10.13^^41^468^9
 ;;^UTILITY(U,$J,358.3,8739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8739,1,3,0)
 ;;=3^Atopic Conjuntivitis,Bilateral,Acute
 ;;^UTILITY(U,$J,358.3,8739,1,4,0)
 ;;=4^H10.13
 ;;^UTILITY(U,$J,358.3,8739,2)
 ;;=^5004667
 ;;^UTILITY(U,$J,358.3,8740,0)
 ;;=H10.211^^41^468^159
 ;;^UTILITY(U,$J,358.3,8740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8740,1,3,0)
 ;;=3^Toxic Conjunctivitis,Right Eye,Acute
 ;;^UTILITY(U,$J,358.3,8740,1,4,0)
 ;;=4^H10.211
 ;;^UTILITY(U,$J,358.3,8740,2)
 ;;=^5004668
 ;;^UTILITY(U,$J,358.3,8741,0)
 ;;=H10.212^^41^468^158
 ;;^UTILITY(U,$J,358.3,8741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8741,1,3,0)
 ;;=3^Toxic Conjunctivitis,Left Eye,Acute
 ;;^UTILITY(U,$J,358.3,8741,1,4,0)
 ;;=4^H10.212
 ;;^UTILITY(U,$J,358.3,8741,2)
 ;;=^5004669
 ;;^UTILITY(U,$J,358.3,8742,0)
 ;;=H10.401^^41^468^46
 ;;^UTILITY(U,$J,358.3,8742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8742,1,3,0)
 ;;=3^Conjunctivitis,Right Eye,Chronic
 ;;^UTILITY(U,$J,358.3,8742,1,4,0)
 ;;=4^H10.401
 ;;^UTILITY(U,$J,358.3,8742,2)
 ;;=^5004681
 ;;^UTILITY(U,$J,358.3,8743,0)
 ;;=H10.402^^41^468^45
 ;;^UTILITY(U,$J,358.3,8743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8743,1,3,0)
 ;;=3^Conjunctivitis,Left Eye,Chronic
 ;;^UTILITY(U,$J,358.3,8743,1,4,0)
 ;;=4^H10.402
 ;;^UTILITY(U,$J,358.3,8743,2)
 ;;=^5004682
 ;;^UTILITY(U,$J,358.3,8744,0)
 ;;=H10.411^^41^468^79
 ;;^UTILITY(U,$J,358.3,8744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8744,1,3,0)
 ;;=3^Giant Papillary Conjunctivitis,Right Eye,Chronic
 ;;^UTILITY(U,$J,358.3,8744,1,4,0)
 ;;=4^H10.411
