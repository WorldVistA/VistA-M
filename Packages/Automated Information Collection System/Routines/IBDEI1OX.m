IBDEI1OX ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28743,1,3,0)
 ;;=3^Threatened abortion
 ;;^UTILITY(U,$J,358.3,28743,1,4,0)
 ;;=4^O20.0
 ;;^UTILITY(U,$J,358.3,28743,2)
 ;;=^1287
 ;;^UTILITY(U,$J,358.3,28744,0)
 ;;=O44.01^^115^1448^20
 ;;^UTILITY(U,$J,358.3,28744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28744,1,3,0)
 ;;=3^Placenta previa specified as w/o hemorrhage, first trimester
 ;;^UTILITY(U,$J,358.3,28744,1,4,0)
 ;;=4^O44.01
 ;;^UTILITY(U,$J,358.3,28744,2)
 ;;=^5017437
 ;;^UTILITY(U,$J,358.3,28745,0)
 ;;=O44.02^^115^1448^19
 ;;^UTILITY(U,$J,358.3,28745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28745,1,3,0)
 ;;=3^Placenta previa specified as w/o hemor, second trimester
 ;;^UTILITY(U,$J,358.3,28745,1,4,0)
 ;;=4^O44.02
 ;;^UTILITY(U,$J,358.3,28745,2)
 ;;=^5017438
 ;;^UTILITY(U,$J,358.3,28746,0)
 ;;=O44.03^^115^1448^21
 ;;^UTILITY(U,$J,358.3,28746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28746,1,3,0)
 ;;=3^Placenta previa specified as w/o hemorrhage, third trimester
 ;;^UTILITY(U,$J,358.3,28746,1,4,0)
 ;;=4^O44.03
 ;;^UTILITY(U,$J,358.3,28746,2)
 ;;=^5017439
 ;;^UTILITY(U,$J,358.3,28747,0)
 ;;=O44.11^^115^1448^22
 ;;^UTILITY(U,$J,358.3,28747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28747,1,3,0)
 ;;=3^Placenta previa with hemorrhage, first trimester
 ;;^UTILITY(U,$J,358.3,28747,1,4,0)
 ;;=4^O44.11
 ;;^UTILITY(U,$J,358.3,28747,2)
 ;;=^5017441
 ;;^UTILITY(U,$J,358.3,28748,0)
 ;;=O44.12^^115^1448^23
 ;;^UTILITY(U,$J,358.3,28748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28748,1,3,0)
 ;;=3^Placenta previa with hemorrhage, second trimester
 ;;^UTILITY(U,$J,358.3,28748,1,4,0)
 ;;=4^O44.12
 ;;^UTILITY(U,$J,358.3,28748,2)
 ;;=^5017442
 ;;^UTILITY(U,$J,358.3,28749,0)
 ;;=O44.13^^115^1448^24
 ;;^UTILITY(U,$J,358.3,28749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28749,1,3,0)
 ;;=3^Placenta previa with hemorrhage, third trimester
 ;;^UTILITY(U,$J,358.3,28749,1,4,0)
 ;;=4^O44.13
 ;;^UTILITY(U,$J,358.3,28749,2)
 ;;=^5017443
 ;;^UTILITY(U,$J,358.3,28750,0)
 ;;=O45.8X1^^115^1448^37
 ;;^UTILITY(U,$J,358.3,28750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28750,1,3,0)
 ;;=3^Prem separtn of placenta, first trimester NEC
 ;;^UTILITY(U,$J,358.3,28750,1,4,0)
 ;;=4^O45.8X1
 ;;^UTILITY(U,$J,358.3,28750,2)
 ;;=^5017459
 ;;^UTILITY(U,$J,358.3,28751,0)
 ;;=O45.8X2^^115^1448^38
 ;;^UTILITY(U,$J,358.3,28751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28751,1,3,0)
 ;;=3^Prem separtn of placenta, second trimester NEC
 ;;^UTILITY(U,$J,358.3,28751,1,4,0)
 ;;=4^O45.8X2
 ;;^UTILITY(U,$J,358.3,28751,2)
 ;;=^5017460
 ;;^UTILITY(U,$J,358.3,28752,0)
 ;;=O45.8X3^^115^1448^39
 ;;^UTILITY(U,$J,358.3,28752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28752,1,3,0)
 ;;=3^Prem separtn of placenta, third trimester NEC
 ;;^UTILITY(U,$J,358.3,28752,1,4,0)
 ;;=4^O45.8X3
 ;;^UTILITY(U,$J,358.3,28752,2)
 ;;=^5017461
 ;;^UTILITY(U,$J,358.3,28753,0)
 ;;=O45.91^^115^1448^40
 ;;^UTILITY(U,$J,358.3,28753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28753,1,3,0)
 ;;=3^Prem separtn of placenta, unsp, first trimester
 ;;^UTILITY(U,$J,358.3,28753,1,4,0)
 ;;=4^O45.91
 ;;^UTILITY(U,$J,358.3,28753,2)
 ;;=^5017464
 ;;^UTILITY(U,$J,358.3,28754,0)
 ;;=O45.92^^115^1448^41
 ;;^UTILITY(U,$J,358.3,28754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28754,1,3,0)
 ;;=3^Prem separtn of placenta, unsp, second trimester
 ;;^UTILITY(U,$J,358.3,28754,1,4,0)
 ;;=4^O45.92
 ;;^UTILITY(U,$J,358.3,28754,2)
 ;;=^5017465
 ;;^UTILITY(U,$J,358.3,28755,0)
 ;;=O45.93^^115^1448^42
 ;;^UTILITY(U,$J,358.3,28755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28755,1,3,0)
 ;;=3^Prem separtn of placenta, unsp, third trimester
