IBDEI0ZX ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16891,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,16891,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,16892,0)
 ;;=L97.829^^70^796^5
 ;;^UTILITY(U,$J,358.3,16892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16892,1,3,0)
 ;;=3^Non-Pressure Chronic Ulcer Left Lower Leg,Severity Unspec
 ;;^UTILITY(U,$J,358.3,16892,1,4,0)
 ;;=4^L97.829
 ;;^UTILITY(U,$J,358.3,16892,2)
 ;;=^5009569
 ;;^UTILITY(U,$J,358.3,16893,0)
 ;;=L97.819^^70^796^6
 ;;^UTILITY(U,$J,358.3,16893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16893,1,3,0)
 ;;=3^Non-Pressure Chronic Ulcer Right Lower Leg,Severity Unspec
 ;;^UTILITY(U,$J,358.3,16893,1,4,0)
 ;;=4^L97.819
 ;;^UTILITY(U,$J,358.3,16893,2)
 ;;=^5009564
 ;;^UTILITY(U,$J,358.3,16894,0)
 ;;=L98.499^^70^796^7
 ;;^UTILITY(U,$J,358.3,16894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16894,1,3,0)
 ;;=3^Non-Pressure Chronic Ulcer of Skin,Severity Unspec
 ;;^UTILITY(U,$J,358.3,16894,1,4,0)
 ;;=4^L98.499
 ;;^UTILITY(U,$J,358.3,16894,2)
 ;;=^5009591
 ;;^UTILITY(U,$J,358.3,16895,0)
 ;;=R11.0^^70^796^3
 ;;^UTILITY(U,$J,358.3,16895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16895,1,3,0)
 ;;=3^Nausea w/o Vomiting
 ;;^UTILITY(U,$J,358.3,16895,1,4,0)
 ;;=4^R11.0
 ;;^UTILITY(U,$J,358.3,16895,2)
 ;;=^5019231
 ;;^UTILITY(U,$J,358.3,16896,0)
 ;;=M19.90^^70^796^12
 ;;^UTILITY(U,$J,358.3,16896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16896,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,16896,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,16896,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,16897,0)
 ;;=E66.3^^70^796^26
 ;;^UTILITY(U,$J,358.3,16897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16897,1,3,0)
 ;;=3^Overweight
 ;;^UTILITY(U,$J,358.3,16897,1,4,0)
 ;;=4^E66.3
 ;;^UTILITY(U,$J,358.3,16897,2)
 ;;=^5002830
 ;;^UTILITY(U,$J,358.3,16898,0)
 ;;=K85.9^^70^797^1
 ;;^UTILITY(U,$J,358.3,16898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16898,1,3,0)
 ;;=3^Pancreatitis, acute, unspec
 ;;^UTILITY(U,$J,358.3,16898,1,4,0)
 ;;=4^K85.9
 ;;^UTILITY(U,$J,358.3,16898,2)
 ;;=^5008887
 ;;^UTILITY(U,$J,358.3,16899,0)
 ;;=G20.^^70^797^2
 ;;^UTILITY(U,$J,358.3,16899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16899,1,3,0)
 ;;=3^Parkinson's disease
 ;;^UTILITY(U,$J,358.3,16899,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,16899,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,16900,0)
 ;;=I30.0^^70^797^3
 ;;^UTILITY(U,$J,358.3,16900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16900,1,3,0)
 ;;=3^Pericarditis,idiopath,acute,nonspec
 ;;^UTILITY(U,$J,358.3,16900,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,16900,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,16901,0)
 ;;=I73.9^^70^797^4
 ;;^UTILITY(U,$J,358.3,16901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16901,1,3,0)
 ;;=3^Peripheral vascular disease, unspec
 ;;^UTILITY(U,$J,358.3,16901,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,16901,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,16902,0)
 ;;=F60.89^^70^797^5
 ;;^UTILITY(U,$J,358.3,16902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16902,1,3,0)
 ;;=3^Personality disorders,oth,spec
 ;;^UTILITY(U,$J,358.3,16902,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,16902,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,16903,0)
 ;;=I80.3^^70^797^7
 ;;^UTILITY(U,$J,358.3,16903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16903,1,3,0)
 ;;=3^Phlebitis & thrombophlbts of low extrmties, unspec
 ;;^UTILITY(U,$J,358.3,16903,1,4,0)
 ;;=4^I80.3
 ;;^UTILITY(U,$J,358.3,16903,2)
 ;;=^5007845
 ;;^UTILITY(U,$J,358.3,16904,0)
 ;;=R09.1^^70^797^9
 ;;^UTILITY(U,$J,358.3,16904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16904,1,3,0)
 ;;=3^Pleurisy
 ;;^UTILITY(U,$J,358.3,16904,1,4,0)
 ;;=4^R09.1
