IBDEI04R ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1701,1,3,0)
 ;;=3^Emphysema, unspecified
 ;;^UTILITY(U,$J,358.3,1701,1,4,0)
 ;;=4^J43.9
 ;;^UTILITY(U,$J,358.3,1701,2)
 ;;=^5008238
 ;;^UTILITY(U,$J,358.3,1702,0)
 ;;=J44.0^^3^47^9
 ;;^UTILITY(U,$J,358.3,1702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1702,1,3,0)
 ;;=3^Chronic obstructive pulmon disease w acute lower resp infct
 ;;^UTILITY(U,$J,358.3,1702,1,4,0)
 ;;=4^J44.0
 ;;^UTILITY(U,$J,358.3,1702,2)
 ;;=^5008239
 ;;^UTILITY(U,$J,358.3,1703,0)
 ;;=J45.990^^3^47^14
 ;;^UTILITY(U,$J,358.3,1703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1703,1,3,0)
 ;;=3^Exercise induced bronchospasm
 ;;^UTILITY(U,$J,358.3,1703,1,4,0)
 ;;=4^J45.990
 ;;^UTILITY(U,$J,358.3,1703,2)
 ;;=^329926
 ;;^UTILITY(U,$J,358.3,1704,0)
 ;;=J45.991^^3^47^12
 ;;^UTILITY(U,$J,358.3,1704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1704,1,3,0)
 ;;=3^Cough variant asthma
 ;;^UTILITY(U,$J,358.3,1704,1,4,0)
 ;;=4^J45.991
 ;;^UTILITY(U,$J,358.3,1704,2)
 ;;=^329927
 ;;^UTILITY(U,$J,358.3,1705,0)
 ;;=J45.909^^3^47^5
 ;;^UTILITY(U,$J,358.3,1705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1705,1,3,0)
 ;;=3^Asthma,Uncomplicated
 ;;^UTILITY(U,$J,358.3,1705,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,1705,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,1706,0)
 ;;=J45.902^^3^47^4
 ;;^UTILITY(U,$J,358.3,1706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1706,1,3,0)
 ;;=3^Asthma w/ Status Asthmaticus,Unspec
 ;;^UTILITY(U,$J,358.3,1706,1,4,0)
 ;;=4^J45.902
 ;;^UTILITY(U,$J,358.3,1706,2)
 ;;=^5008255
 ;;^UTILITY(U,$J,358.3,1707,0)
 ;;=J45.901^^3^47^3
 ;;^UTILITY(U,$J,358.3,1707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1707,1,3,0)
 ;;=3^Asthma w/ Acute Exacerbation,Unspec
 ;;^UTILITY(U,$J,358.3,1707,1,4,0)
 ;;=4^J45.901
 ;;^UTILITY(U,$J,358.3,1707,2)
 ;;=^5008254
 ;;^UTILITY(U,$J,358.3,1708,0)
 ;;=J47.9^^3^47^7
 ;;^UTILITY(U,$J,358.3,1708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1708,1,3,0)
 ;;=3^Bronchiectasis, uncomplicated
 ;;^UTILITY(U,$J,358.3,1708,1,4,0)
 ;;=4^J47.9
 ;;^UTILITY(U,$J,358.3,1708,2)
 ;;=^5008260
 ;;^UTILITY(U,$J,358.3,1709,0)
 ;;=J47.1^^3^47^6
 ;;^UTILITY(U,$J,358.3,1709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1709,1,3,0)
 ;;=3^Bronchiectasis with (acute) exacerbation
 ;;^UTILITY(U,$J,358.3,1709,1,4,0)
 ;;=4^J47.1
 ;;^UTILITY(U,$J,358.3,1709,2)
 ;;=^5008259
 ;;^UTILITY(U,$J,358.3,1710,0)
 ;;=K11.20^^3^48^6
 ;;^UTILITY(U,$J,358.3,1710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1710,1,3,0)
 ;;=3^Sialoadenitis, unspecified
 ;;^UTILITY(U,$J,358.3,1710,1,4,0)
 ;;=4^K11.20
 ;;^UTILITY(U,$J,358.3,1710,2)
 ;;=^5008473
 ;;^UTILITY(U,$J,358.3,1711,0)
 ;;=K12.2^^3^48^1
 ;;^UTILITY(U,$J,358.3,1711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1711,1,3,0)
 ;;=3^Cellulitis and abscess of mouth
 ;;^UTILITY(U,$J,358.3,1711,1,4,0)
 ;;=4^K12.2
 ;;^UTILITY(U,$J,358.3,1711,2)
 ;;=^5008485
 ;;^UTILITY(U,$J,358.3,1712,0)
 ;;=K12.30^^3^48^4
 ;;^UTILITY(U,$J,358.3,1712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1712,1,3,0)
 ;;=3^Oral mucositis (ulcerative), unspecified
 ;;^UTILITY(U,$J,358.3,1712,1,4,0)
 ;;=4^K12.30
 ;;^UTILITY(U,$J,358.3,1712,2)
 ;;=^5008486
 ;;^UTILITY(U,$J,358.3,1713,0)
 ;;=K12.0^^3^48^5
 ;;^UTILITY(U,$J,358.3,1713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1713,1,3,0)
 ;;=3^Recurrent oral aphthae
 ;;^UTILITY(U,$J,358.3,1713,1,4,0)
 ;;=4^K12.0
 ;;^UTILITY(U,$J,358.3,1713,2)
 ;;=^5008483
 ;;^UTILITY(U,$J,358.3,1714,0)
 ;;=K13.70^^3^48^3
 ;;^UTILITY(U,$J,358.3,1714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1714,1,3,0)
 ;;=3^Oral Mucosa Lesions,Unspec
