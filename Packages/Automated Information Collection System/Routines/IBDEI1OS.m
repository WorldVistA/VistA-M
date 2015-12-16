IBDEI1OS ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29933,1,3,0)
 ;;=3^Threatened abortion
 ;;^UTILITY(U,$J,358.3,29933,1,4,0)
 ;;=4^O20.0
 ;;^UTILITY(U,$J,358.3,29933,2)
 ;;=^1287
 ;;^UTILITY(U,$J,358.3,29934,0)
 ;;=O44.01^^178^1909^20
 ;;^UTILITY(U,$J,358.3,29934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29934,1,3,0)
 ;;=3^Placenta previa specified as w/o hemorrhage, first trimester
 ;;^UTILITY(U,$J,358.3,29934,1,4,0)
 ;;=4^O44.01
 ;;^UTILITY(U,$J,358.3,29934,2)
 ;;=^5017437
 ;;^UTILITY(U,$J,358.3,29935,0)
 ;;=O44.02^^178^1909^19
 ;;^UTILITY(U,$J,358.3,29935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29935,1,3,0)
 ;;=3^Placenta previa specified as w/o hemor, second trimester
 ;;^UTILITY(U,$J,358.3,29935,1,4,0)
 ;;=4^O44.02
 ;;^UTILITY(U,$J,358.3,29935,2)
 ;;=^5017438
 ;;^UTILITY(U,$J,358.3,29936,0)
 ;;=O44.03^^178^1909^21
 ;;^UTILITY(U,$J,358.3,29936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29936,1,3,0)
 ;;=3^Placenta previa specified as w/o hemorrhage, third trimester
 ;;^UTILITY(U,$J,358.3,29936,1,4,0)
 ;;=4^O44.03
 ;;^UTILITY(U,$J,358.3,29936,2)
 ;;=^5017439
 ;;^UTILITY(U,$J,358.3,29937,0)
 ;;=O44.11^^178^1909^22
 ;;^UTILITY(U,$J,358.3,29937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29937,1,3,0)
 ;;=3^Placenta previa with hemorrhage, first trimester
 ;;^UTILITY(U,$J,358.3,29937,1,4,0)
 ;;=4^O44.11
 ;;^UTILITY(U,$J,358.3,29937,2)
 ;;=^5017441
 ;;^UTILITY(U,$J,358.3,29938,0)
 ;;=O44.12^^178^1909^23
 ;;^UTILITY(U,$J,358.3,29938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29938,1,3,0)
 ;;=3^Placenta previa with hemorrhage, second trimester
 ;;^UTILITY(U,$J,358.3,29938,1,4,0)
 ;;=4^O44.12
 ;;^UTILITY(U,$J,358.3,29938,2)
 ;;=^5017442
 ;;^UTILITY(U,$J,358.3,29939,0)
 ;;=O44.13^^178^1909^24
 ;;^UTILITY(U,$J,358.3,29939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29939,1,3,0)
 ;;=3^Placenta previa with hemorrhage, third trimester
 ;;^UTILITY(U,$J,358.3,29939,1,4,0)
 ;;=4^O44.13
 ;;^UTILITY(U,$J,358.3,29939,2)
 ;;=^5017443
 ;;^UTILITY(U,$J,358.3,29940,0)
 ;;=O45.8X1^^178^1909^37
 ;;^UTILITY(U,$J,358.3,29940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29940,1,3,0)
 ;;=3^Prem separtn of placenta, first trimester NEC
 ;;^UTILITY(U,$J,358.3,29940,1,4,0)
 ;;=4^O45.8X1
 ;;^UTILITY(U,$J,358.3,29940,2)
 ;;=^5017459
 ;;^UTILITY(U,$J,358.3,29941,0)
 ;;=O45.8X2^^178^1909^38
 ;;^UTILITY(U,$J,358.3,29941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29941,1,3,0)
 ;;=3^Prem separtn of placenta, second trimester NEC
 ;;^UTILITY(U,$J,358.3,29941,1,4,0)
 ;;=4^O45.8X2
 ;;^UTILITY(U,$J,358.3,29941,2)
 ;;=^5017460
 ;;^UTILITY(U,$J,358.3,29942,0)
 ;;=O45.8X3^^178^1909^39
 ;;^UTILITY(U,$J,358.3,29942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29942,1,3,0)
 ;;=3^Prem separtn of placenta, third trimester NEC
 ;;^UTILITY(U,$J,358.3,29942,1,4,0)
 ;;=4^O45.8X3
 ;;^UTILITY(U,$J,358.3,29942,2)
 ;;=^5017461
 ;;^UTILITY(U,$J,358.3,29943,0)
 ;;=O45.91^^178^1909^40
 ;;^UTILITY(U,$J,358.3,29943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29943,1,3,0)
 ;;=3^Prem separtn of placenta, unsp, first trimester
 ;;^UTILITY(U,$J,358.3,29943,1,4,0)
 ;;=4^O45.91
 ;;^UTILITY(U,$J,358.3,29943,2)
 ;;=^5017464
 ;;^UTILITY(U,$J,358.3,29944,0)
 ;;=O45.92^^178^1909^41
 ;;^UTILITY(U,$J,358.3,29944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29944,1,3,0)
 ;;=3^Prem separtn of placenta, unsp, second trimester
 ;;^UTILITY(U,$J,358.3,29944,1,4,0)
 ;;=4^O45.92
 ;;^UTILITY(U,$J,358.3,29944,2)
 ;;=^5017465
 ;;^UTILITY(U,$J,358.3,29945,0)
 ;;=O45.93^^178^1909^42
 ;;^UTILITY(U,$J,358.3,29945,1,0)
 ;;=^358.31IA^4^2
