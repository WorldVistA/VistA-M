IBDEI1D2 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21748,1,3,0)
 ;;=3^Hepatitis C,Viral,Chronic
 ;;^UTILITY(U,$J,358.3,21748,1,4,0)
 ;;=4^B18.2
 ;;^UTILITY(U,$J,358.3,21748,2)
 ;;=^5000548
 ;;^UTILITY(U,$J,358.3,21749,0)
 ;;=E05.90^^99^1108^33
 ;;^UTILITY(U,$J,358.3,21749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21749,1,3,0)
 ;;=3^Hyperthyroidism w/o Thyrotoxic Crisis/Storm,Unspec
 ;;^UTILITY(U,$J,358.3,21749,1,4,0)
 ;;=4^E05.90
 ;;^UTILITY(U,$J,358.3,21749,2)
 ;;=^5002492
 ;;^UTILITY(U,$J,358.3,21750,0)
 ;;=E03.9^^99^1108^40
 ;;^UTILITY(U,$J,358.3,21750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21750,1,3,0)
 ;;=3^Hypothyroidism, unspec
 ;;^UTILITY(U,$J,358.3,21750,1,4,0)
 ;;=4^E03.9
 ;;^UTILITY(U,$J,358.3,21750,2)
 ;;=^5002476
 ;;^UTILITY(U,$J,358.3,21751,0)
 ;;=E16.2^^99^1108^35
 ;;^UTILITY(U,$J,358.3,21751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21751,1,3,0)
 ;;=3^Hypoglycemia, unspec
 ;;^UTILITY(U,$J,358.3,21751,1,4,0)
 ;;=4^E16.2
 ;;^UTILITY(U,$J,358.3,21751,2)
 ;;=^5002708
 ;;^UTILITY(U,$J,358.3,21752,0)
 ;;=E78.5^^99^1108^28
 ;;^UTILITY(U,$J,358.3,21752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21752,1,3,0)
 ;;=3^Hyperlipidemia, unspec
 ;;^UTILITY(U,$J,358.3,21752,1,4,0)
 ;;=4^E78.5
 ;;^UTILITY(U,$J,358.3,21752,2)
 ;;=^5002969
 ;;^UTILITY(U,$J,358.3,21753,0)
 ;;=E87.1^^99^1108^34
 ;;^UTILITY(U,$J,358.3,21753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21753,1,3,0)
 ;;=3^Hypo-osmolality and hyponatremia
 ;;^UTILITY(U,$J,358.3,21753,1,4,0)
 ;;=4^E87.1
 ;;^UTILITY(U,$J,358.3,21753,2)
 ;;=^5003019
 ;;^UTILITY(U,$J,358.3,21754,0)
 ;;=E87.5^^99^1108^27
 ;;^UTILITY(U,$J,358.3,21754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21754,1,3,0)
 ;;=3^Hyperkalemia
 ;;^UTILITY(U,$J,358.3,21754,1,4,0)
 ;;=4^E87.5
 ;;^UTILITY(U,$J,358.3,21754,2)
 ;;=^60041
 ;;^UTILITY(U,$J,358.3,21755,0)
 ;;=E87.6^^99^1108^38
 ;;^UTILITY(U,$J,358.3,21755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21755,1,3,0)
 ;;=3^Hypokalemia
 ;;^UTILITY(U,$J,358.3,21755,1,4,0)
 ;;=4^E87.6
 ;;^UTILITY(U,$J,358.3,21755,2)
 ;;=^60610
 ;;^UTILITY(U,$J,358.3,21756,0)
 ;;=G81.91^^99^1108^11
 ;;^UTILITY(U,$J,358.3,21756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21756,1,3,0)
 ;;=3^Hemiplegia affecting rt dominant side, unspec
 ;;^UTILITY(U,$J,358.3,21756,1,4,0)
 ;;=4^G81.91
 ;;^UTILITY(U,$J,358.3,21756,2)
 ;;=^5004121
 ;;^UTILITY(U,$J,358.3,21757,0)
 ;;=G81.92^^99^1108^9
 ;;^UTILITY(U,$J,358.3,21757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21757,1,3,0)
 ;;=3^Hemiplegia affecting lft dominant side, unspec
 ;;^UTILITY(U,$J,358.3,21757,1,4,0)
 ;;=4^G81.92
 ;;^UTILITY(U,$J,358.3,21757,2)
 ;;=^5004122
 ;;^UTILITY(U,$J,358.3,21758,0)
 ;;=G81.93^^99^1108^12
 ;;^UTILITY(U,$J,358.3,21758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21758,1,3,0)
 ;;=3^Hemiplegia affecting rt nondom side, unspec
 ;;^UTILITY(U,$J,358.3,21758,1,4,0)
 ;;=4^G81.93
 ;;^UTILITY(U,$J,358.3,21758,2)
 ;;=^5004123
 ;;^UTILITY(U,$J,358.3,21759,0)
 ;;=G81.94^^99^1108^10
 ;;^UTILITY(U,$J,358.3,21759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21759,1,3,0)
 ;;=3^Hemiplegia affecting lft nondom side, unspec
 ;;^UTILITY(U,$J,358.3,21759,1,4,0)
 ;;=4^G81.94
 ;;^UTILITY(U,$J,358.3,21759,2)
 ;;=^5004124
 ;;^UTILITY(U,$J,358.3,21760,0)
 ;;=H91.90^^99^1108^7
 ;;^UTILITY(U,$J,358.3,21760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21760,1,3,0)
 ;;=3^Hearing loss, unspec ear, unspec
