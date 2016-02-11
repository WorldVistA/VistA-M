IBDEI0I1 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8085,0)
 ;;=J35.01^^55^534^50
 ;;^UTILITY(U,$J,358.3,8085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8085,1,3,0)
 ;;=3^Chronic tonsillitis
 ;;^UTILITY(U,$J,358.3,8085,1,4,0)
 ;;=4^J35.01
 ;;^UTILITY(U,$J,358.3,8085,2)
 ;;=^259089
 ;;^UTILITY(U,$J,358.3,8086,0)
 ;;=J35.3^^55^534^82
 ;;^UTILITY(U,$J,358.3,8086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8086,1,3,0)
 ;;=3^Hypertrophy of tonsils with hypertrophy of adenoids
 ;;^UTILITY(U,$J,358.3,8086,1,4,0)
 ;;=4^J35.3
 ;;^UTILITY(U,$J,358.3,8086,2)
 ;;=^5008216
 ;;^UTILITY(U,$J,358.3,8087,0)
 ;;=J35.1^^55^534^81
 ;;^UTILITY(U,$J,358.3,8087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8087,1,3,0)
 ;;=3^Hypertrophy of tonsils
 ;;^UTILITY(U,$J,358.3,8087,1,4,0)
 ;;=4^J35.1
 ;;^UTILITY(U,$J,358.3,8087,2)
 ;;=^5008214
 ;;^UTILITY(U,$J,358.3,8088,0)
 ;;=J35.2^^55^534^80
 ;;^UTILITY(U,$J,358.3,8088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8088,1,3,0)
 ;;=3^Hypertrophy of adenoids
 ;;^UTILITY(U,$J,358.3,8088,1,4,0)
 ;;=4^J35.2
 ;;^UTILITY(U,$J,358.3,8088,2)
 ;;=^5008215
 ;;^UTILITY(U,$J,358.3,8089,0)
 ;;=J35.9^^55^534^40
 ;;^UTILITY(U,$J,358.3,8089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8089,1,3,0)
 ;;=3^Chronic disease of tonsils and adenoids, unspecified
 ;;^UTILITY(U,$J,358.3,8089,1,4,0)
 ;;=4^J35.9
 ;;^UTILITY(U,$J,358.3,8089,2)
 ;;=^5008218
 ;;^UTILITY(U,$J,358.3,8090,0)
 ;;=J36.^^55^534^110
 ;;^UTILITY(U,$J,358.3,8090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8090,1,3,0)
 ;;=3^Peritonsillar abscess
 ;;^UTILITY(U,$J,358.3,8090,1,4,0)
 ;;=4^J36.
 ;;^UTILITY(U,$J,358.3,8090,2)
 ;;=^92333
 ;;^UTILITY(U,$J,358.3,8091,0)
 ;;=J37.0^^55^534^43
 ;;^UTILITY(U,$J,358.3,8091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8091,1,3,0)
 ;;=3^Chronic laryngitis
 ;;^UTILITY(U,$J,358.3,8091,1,4,0)
 ;;=4^J37.0
 ;;^UTILITY(U,$J,358.3,8091,2)
 ;;=^269902
 ;;^UTILITY(U,$J,358.3,8092,0)
 ;;=J30.81^^55^534^20
 ;;^UTILITY(U,$J,358.3,8092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8092,1,3,0)
 ;;=3^Allergic rhinitis due to animal (cat) (dog) hair and dander
 ;;^UTILITY(U,$J,358.3,8092,1,4,0)
 ;;=4^J30.81
 ;;^UTILITY(U,$J,358.3,8092,2)
 ;;=^5008203
 ;;^UTILITY(U,$J,358.3,8093,0)
 ;;=J30.9^^55^534^21
 ;;^UTILITY(U,$J,358.3,8093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8093,1,3,0)
 ;;=3^Allergic rhinitis, unspecified
 ;;^UTILITY(U,$J,358.3,8093,1,4,0)
 ;;=4^J30.9
 ;;^UTILITY(U,$J,358.3,8093,2)
 ;;=^5008205
 ;;^UTILITY(U,$J,358.3,8094,0)
 ;;=J34.81^^55^534^95
 ;;^UTILITY(U,$J,358.3,8094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8094,1,3,0)
 ;;=3^Nasal mucositis (ulcerative)
 ;;^UTILITY(U,$J,358.3,8094,1,4,0)
 ;;=4^J34.81
 ;;^UTILITY(U,$J,358.3,8094,2)
 ;;=^334089
 ;;^UTILITY(U,$J,358.3,8095,0)
 ;;=J34.0^^55^534^1
 ;;^UTILITY(U,$J,358.3,8095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8095,1,3,0)
 ;;=3^Abscess, furuncle and carbuncle of nose
 ;;^UTILITY(U,$J,358.3,8095,1,4,0)
 ;;=4^J34.0
 ;;^UTILITY(U,$J,358.3,8095,2)
 ;;=^5008209
 ;;^UTILITY(U,$J,358.3,8096,0)
 ;;=J34.1^^55^534^56
 ;;^UTILITY(U,$J,358.3,8096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8096,1,3,0)
 ;;=3^Cyst and mucocele of nose and nasal sinus
 ;;^UTILITY(U,$J,358.3,8096,1,4,0)
 ;;=4^J34.1
 ;;^UTILITY(U,$J,358.3,8096,2)
 ;;=^5008210
 ;;^UTILITY(U,$J,358.3,8097,0)
 ;;=J38.00^^55^534^108
 ;;^UTILITY(U,$J,358.3,8097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8097,1,3,0)
 ;;=3^Paralysis of vocal cords and larynx, unspecified
 ;;^UTILITY(U,$J,358.3,8097,1,4,0)
 ;;=4^J38.00
 ;;^UTILITY(U,$J,358.3,8097,2)
 ;;=^5008219
 ;;^UTILITY(U,$J,358.3,8098,0)
 ;;=J38.1^^55^534^111
