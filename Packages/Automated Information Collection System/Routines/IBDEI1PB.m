IBDEI1PB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28913,0)
 ;;=O99.331^^115^1453^20
 ;;^UTILITY(U,$J,358.3,28913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28913,1,3,0)
 ;;=3^Tobacco complicating pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,28913,1,4,0)
 ;;=4^O99.331
 ;;^UTILITY(U,$J,358.3,28913,2)
 ;;=^5017953
 ;;^UTILITY(U,$J,358.3,28914,0)
 ;;=O99.332^^115^1453^21
 ;;^UTILITY(U,$J,358.3,28914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28914,1,3,0)
 ;;=3^Tobacco complicating pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28914,1,4,0)
 ;;=4^O99.332
 ;;^UTILITY(U,$J,358.3,28914,2)
 ;;=^5017954
 ;;^UTILITY(U,$J,358.3,28915,0)
 ;;=O99.333^^115^1453^22
 ;;^UTILITY(U,$J,358.3,28915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28915,1,3,0)
 ;;=3^Tobacco complicating pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28915,1,4,0)
 ;;=4^O99.333
 ;;^UTILITY(U,$J,358.3,28915,2)
 ;;=^5017955
 ;;^UTILITY(U,$J,358.3,28916,0)
 ;;=O99.335^^115^1453^23
 ;;^UTILITY(U,$J,358.3,28916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28916,1,3,0)
 ;;=3^Tobacco complicating the puerperium
 ;;^UTILITY(U,$J,358.3,28916,1,4,0)
 ;;=4^O99.335
 ;;^UTILITY(U,$J,358.3,28916,2)
 ;;=^5017957
 ;;^UTILITY(U,$J,358.3,28917,0)
 ;;=O99.211^^115^1453^14
 ;;^UTILITY(U,$J,358.3,28917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28917,1,3,0)
 ;;=3^Obesity complicating pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,28917,1,4,0)
 ;;=4^O99.211
 ;;^UTILITY(U,$J,358.3,28917,2)
 ;;=^5017929
 ;;^UTILITY(U,$J,358.3,28918,0)
 ;;=O99.212^^115^1453^15
 ;;^UTILITY(U,$J,358.3,28918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28918,1,3,0)
 ;;=3^Obesity complicating pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28918,1,4,0)
 ;;=4^O99.212
 ;;^UTILITY(U,$J,358.3,28918,2)
 ;;=^5017930
 ;;^UTILITY(U,$J,358.3,28919,0)
 ;;=O99.213^^115^1453^16
 ;;^UTILITY(U,$J,358.3,28919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28919,1,3,0)
 ;;=3^Obesity complicating pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28919,1,4,0)
 ;;=4^O99.213
 ;;^UTILITY(U,$J,358.3,28919,2)
 ;;=^5017931
 ;;^UTILITY(U,$J,358.3,28920,0)
 ;;=O99.215^^115^1453^18
 ;;^UTILITY(U,$J,358.3,28920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28920,1,3,0)
 ;;=3^Obesity complicating the puerperium
 ;;^UTILITY(U,$J,358.3,28920,1,4,0)
 ;;=4^O99.215
 ;;^UTILITY(U,$J,358.3,28920,2)
 ;;=^5017933
 ;;^UTILITY(U,$J,358.3,28921,0)
 ;;=O99.841^^115^1453^2
 ;;^UTILITY(U,$J,358.3,28921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28921,1,3,0)
 ;;=3^Bariatric surgery status comp pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,28921,1,4,0)
 ;;=4^O99.841
 ;;^UTILITY(U,$J,358.3,28921,2)
 ;;=^5018004
 ;;^UTILITY(U,$J,358.3,28922,0)
 ;;=O99.842^^115^1453^3
 ;;^UTILITY(U,$J,358.3,28922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28922,1,3,0)
 ;;=3^Bariatric surgery status comp pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28922,1,4,0)
 ;;=4^O99.842
 ;;^UTILITY(U,$J,358.3,28922,2)
 ;;=^5018005
 ;;^UTILITY(U,$J,358.3,28923,0)
 ;;=O99.843^^115^1453^4
 ;;^UTILITY(U,$J,358.3,28923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28923,1,3,0)
 ;;=3^Bariatric surgery status comp pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28923,1,4,0)
 ;;=4^O99.843
 ;;^UTILITY(U,$J,358.3,28923,2)
 ;;=^5018006
 ;;^UTILITY(U,$J,358.3,28924,0)
 ;;=O99.845^^115^1453^5
 ;;^UTILITY(U,$J,358.3,28924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28924,1,3,0)
 ;;=3^Bariatric surgery status complicating the puerperium
 ;;^UTILITY(U,$J,358.3,28924,1,4,0)
 ;;=4^O99.845
 ;;^UTILITY(U,$J,358.3,28924,2)
 ;;=^5018008
 ;;^UTILITY(U,$J,358.3,28925,0)
 ;;=O99.351^^115^1453^10
