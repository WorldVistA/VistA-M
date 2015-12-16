IBDEI038 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,969,1,4,0)
 ;;=4^J32.1
 ;;^UTILITY(U,$J,358.3,969,2)
 ;;=^24380
 ;;^UTILITY(U,$J,358.3,970,0)
 ;;=J32.9^^3^35^49
 ;;^UTILITY(U,$J,358.3,970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,970,1,3,0)
 ;;=3^Chronic sinusitis, unspecified
 ;;^UTILITY(U,$J,358.3,970,1,4,0)
 ;;=4^J32.9
 ;;^UTILITY(U,$J,358.3,970,2)
 ;;=^5008207
 ;;^UTILITY(U,$J,358.3,971,0)
 ;;=J35.01^^3^35^50
 ;;^UTILITY(U,$J,358.3,971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,971,1,3,0)
 ;;=3^Chronic tonsillitis
 ;;^UTILITY(U,$J,358.3,971,1,4,0)
 ;;=4^J35.01
 ;;^UTILITY(U,$J,358.3,971,2)
 ;;=^259089
 ;;^UTILITY(U,$J,358.3,972,0)
 ;;=J35.3^^3^35^82
 ;;^UTILITY(U,$J,358.3,972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,972,1,3,0)
 ;;=3^Hypertrophy of tonsils with hypertrophy of adenoids
 ;;^UTILITY(U,$J,358.3,972,1,4,0)
 ;;=4^J35.3
 ;;^UTILITY(U,$J,358.3,972,2)
 ;;=^5008216
 ;;^UTILITY(U,$J,358.3,973,0)
 ;;=J35.1^^3^35^81
 ;;^UTILITY(U,$J,358.3,973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,973,1,3,0)
 ;;=3^Hypertrophy of tonsils
 ;;^UTILITY(U,$J,358.3,973,1,4,0)
 ;;=4^J35.1
 ;;^UTILITY(U,$J,358.3,973,2)
 ;;=^5008214
 ;;^UTILITY(U,$J,358.3,974,0)
 ;;=J35.2^^3^35^80
 ;;^UTILITY(U,$J,358.3,974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,974,1,3,0)
 ;;=3^Hypertrophy of adenoids
 ;;^UTILITY(U,$J,358.3,974,1,4,0)
 ;;=4^J35.2
 ;;^UTILITY(U,$J,358.3,974,2)
 ;;=^5008215
 ;;^UTILITY(U,$J,358.3,975,0)
 ;;=J35.9^^3^35^40
 ;;^UTILITY(U,$J,358.3,975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,975,1,3,0)
 ;;=3^Chronic disease of tonsils and adenoids, unspecified
 ;;^UTILITY(U,$J,358.3,975,1,4,0)
 ;;=4^J35.9
 ;;^UTILITY(U,$J,358.3,975,2)
 ;;=^5008218
 ;;^UTILITY(U,$J,358.3,976,0)
 ;;=J36.^^3^35^110
 ;;^UTILITY(U,$J,358.3,976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,976,1,3,0)
 ;;=3^Peritonsillar abscess
 ;;^UTILITY(U,$J,358.3,976,1,4,0)
 ;;=4^J36.
 ;;^UTILITY(U,$J,358.3,976,2)
 ;;=^92333
 ;;^UTILITY(U,$J,358.3,977,0)
 ;;=J37.0^^3^35^43
 ;;^UTILITY(U,$J,358.3,977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,977,1,3,0)
 ;;=3^Chronic laryngitis
 ;;^UTILITY(U,$J,358.3,977,1,4,0)
 ;;=4^J37.0
 ;;^UTILITY(U,$J,358.3,977,2)
 ;;=^269902
 ;;^UTILITY(U,$J,358.3,978,0)
 ;;=J30.81^^3^35^20
 ;;^UTILITY(U,$J,358.3,978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,978,1,3,0)
 ;;=3^Allergic rhinitis due to animal (cat) (dog) hair and dander
 ;;^UTILITY(U,$J,358.3,978,1,4,0)
 ;;=4^J30.81
 ;;^UTILITY(U,$J,358.3,978,2)
 ;;=^5008203
 ;;^UTILITY(U,$J,358.3,979,0)
 ;;=J30.9^^3^35^21
 ;;^UTILITY(U,$J,358.3,979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,979,1,3,0)
 ;;=3^Allergic rhinitis, unspecified
 ;;^UTILITY(U,$J,358.3,979,1,4,0)
 ;;=4^J30.9
 ;;^UTILITY(U,$J,358.3,979,2)
 ;;=^5008205
 ;;^UTILITY(U,$J,358.3,980,0)
 ;;=J34.81^^3^35^95
 ;;^UTILITY(U,$J,358.3,980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,980,1,3,0)
 ;;=3^Nasal mucositis (ulcerative)
 ;;^UTILITY(U,$J,358.3,980,1,4,0)
 ;;=4^J34.81
 ;;^UTILITY(U,$J,358.3,980,2)
 ;;=^334089
 ;;^UTILITY(U,$J,358.3,981,0)
 ;;=J34.0^^3^35^1
 ;;^UTILITY(U,$J,358.3,981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,981,1,3,0)
 ;;=3^Abscess, furuncle and carbuncle of nose
 ;;^UTILITY(U,$J,358.3,981,1,4,0)
 ;;=4^J34.0
 ;;^UTILITY(U,$J,358.3,981,2)
 ;;=^5008209
 ;;^UTILITY(U,$J,358.3,982,0)
 ;;=J34.1^^3^35^56
 ;;^UTILITY(U,$J,358.3,982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,982,1,3,0)
 ;;=3^Cyst and mucocele of nose and nasal sinus
 ;;^UTILITY(U,$J,358.3,982,1,4,0)
 ;;=4^J34.1
 ;;^UTILITY(U,$J,358.3,982,2)
 ;;=^5008210
 ;;^UTILITY(U,$J,358.3,983,0)
 ;;=J38.00^^3^35^108
 ;;^UTILITY(U,$J,358.3,983,1,0)
 ;;=^358.31IA^4^2
