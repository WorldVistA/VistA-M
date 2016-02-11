IBDEI0JK ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8811,1,4,0)
 ;;=4^J21.8
 ;;^UTILITY(U,$J,358.3,8811,2)
 ;;=^5008198
 ;;^UTILITY(U,$J,358.3,8812,0)
 ;;=J44.9^^55^546^11
 ;;^UTILITY(U,$J,358.3,8812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8812,1,3,0)
 ;;=3^Chronic obstructive pulmonary disease, unspecified
 ;;^UTILITY(U,$J,358.3,8812,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,8812,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,8813,0)
 ;;=J44.1^^55^546^10
 ;;^UTILITY(U,$J,358.3,8813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8813,1,3,0)
 ;;=3^Chronic obstructive pulmonary disease w (acute) exacerbation
 ;;^UTILITY(U,$J,358.3,8813,1,4,0)
 ;;=4^J44.1
 ;;^UTILITY(U,$J,358.3,8813,2)
 ;;=^5008240
 ;;^UTILITY(U,$J,358.3,8814,0)
 ;;=J42.^^55^546^8
 ;;^UTILITY(U,$J,358.3,8814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8814,1,3,0)
 ;;=3^Chronic Bronchitis,Unspec
 ;;^UTILITY(U,$J,358.3,8814,1,4,0)
 ;;=4^J42.
 ;;^UTILITY(U,$J,358.3,8814,2)
 ;;=^5008234
 ;;^UTILITY(U,$J,358.3,8815,0)
 ;;=J43.9^^55^546^13
 ;;^UTILITY(U,$J,358.3,8815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8815,1,3,0)
 ;;=3^Emphysema, unspecified
 ;;^UTILITY(U,$J,358.3,8815,1,4,0)
 ;;=4^J43.9
 ;;^UTILITY(U,$J,358.3,8815,2)
 ;;=^5008238
 ;;^UTILITY(U,$J,358.3,8816,0)
 ;;=J44.0^^55^546^9
 ;;^UTILITY(U,$J,358.3,8816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8816,1,3,0)
 ;;=3^Chronic obstructive pulmon disease w acute lower resp infct
 ;;^UTILITY(U,$J,358.3,8816,1,4,0)
 ;;=4^J44.0
 ;;^UTILITY(U,$J,358.3,8816,2)
 ;;=^5008239
 ;;^UTILITY(U,$J,358.3,8817,0)
 ;;=J45.990^^55^546^14
 ;;^UTILITY(U,$J,358.3,8817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8817,1,3,0)
 ;;=3^Exercise induced bronchospasm
 ;;^UTILITY(U,$J,358.3,8817,1,4,0)
 ;;=4^J45.990
 ;;^UTILITY(U,$J,358.3,8817,2)
 ;;=^329926
 ;;^UTILITY(U,$J,358.3,8818,0)
 ;;=J45.991^^55^546^12
 ;;^UTILITY(U,$J,358.3,8818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8818,1,3,0)
 ;;=3^Cough variant asthma
 ;;^UTILITY(U,$J,358.3,8818,1,4,0)
 ;;=4^J45.991
 ;;^UTILITY(U,$J,358.3,8818,2)
 ;;=^329927
 ;;^UTILITY(U,$J,358.3,8819,0)
 ;;=J45.909^^55^546^5
 ;;^UTILITY(U,$J,358.3,8819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8819,1,3,0)
 ;;=3^Asthma,Uncomplicated
 ;;^UTILITY(U,$J,358.3,8819,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,8819,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,8820,0)
 ;;=J45.902^^55^546^4
 ;;^UTILITY(U,$J,358.3,8820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8820,1,3,0)
 ;;=3^Asthma w/ Status Asthmaticus,Unspec
 ;;^UTILITY(U,$J,358.3,8820,1,4,0)
 ;;=4^J45.902
 ;;^UTILITY(U,$J,358.3,8820,2)
 ;;=^5008255
 ;;^UTILITY(U,$J,358.3,8821,0)
 ;;=J45.901^^55^546^3
 ;;^UTILITY(U,$J,358.3,8821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8821,1,3,0)
 ;;=3^Asthma w/ Acute Exacerbation,Unspec
 ;;^UTILITY(U,$J,358.3,8821,1,4,0)
 ;;=4^J45.901
 ;;^UTILITY(U,$J,358.3,8821,2)
 ;;=^5008254
 ;;^UTILITY(U,$J,358.3,8822,0)
 ;;=J47.9^^55^546^7
 ;;^UTILITY(U,$J,358.3,8822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8822,1,3,0)
 ;;=3^Bronchiectasis, uncomplicated
 ;;^UTILITY(U,$J,358.3,8822,1,4,0)
 ;;=4^J47.9
 ;;^UTILITY(U,$J,358.3,8822,2)
 ;;=^5008260
 ;;^UTILITY(U,$J,358.3,8823,0)
 ;;=J47.1^^55^546^6
 ;;^UTILITY(U,$J,358.3,8823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8823,1,3,0)
 ;;=3^Bronchiectasis with (acute) exacerbation
 ;;^UTILITY(U,$J,358.3,8823,1,4,0)
 ;;=4^J47.1
 ;;^UTILITY(U,$J,358.3,8823,2)
 ;;=^5008259
 ;;^UTILITY(U,$J,358.3,8824,0)
 ;;=K11.20^^55^547^6
 ;;^UTILITY(U,$J,358.3,8824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8824,1,3,0)
 ;;=3^Sialoadenitis, unspecified
 ;;^UTILITY(U,$J,358.3,8824,1,4,0)
 ;;=4^K11.20
