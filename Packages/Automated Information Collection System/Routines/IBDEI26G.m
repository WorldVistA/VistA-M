IBDEI26G ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36932,2)
 ;;=^5008255
 ;;^UTILITY(U,$J,358.3,36933,0)
 ;;=J45.909^^137^1778^5
 ;;^UTILITY(U,$J,358.3,36933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36933,1,3,0)
 ;;=3^Asthma,Uncomplicated,Unspec
 ;;^UTILITY(U,$J,358.3,36933,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,36933,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,36934,0)
 ;;=J42.^^137^1778^13
 ;;^UTILITY(U,$J,358.3,36934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36934,1,3,0)
 ;;=3^Chr Bronchitis,Unspec
 ;;^UTILITY(U,$J,358.3,36934,1,4,0)
 ;;=4^J42.
 ;;^UTILITY(U,$J,358.3,36934,2)
 ;;=^5008234
 ;;^UTILITY(U,$J,358.3,36935,0)
 ;;=I95.1^^137^1779^1
 ;;^UTILITY(U,$J,358.3,36935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36935,1,3,0)
 ;;=3^Orthostatic Hypotension
 ;;^UTILITY(U,$J,358.3,36935,1,4,0)
 ;;=4^I95.1
 ;;^UTILITY(U,$J,358.3,36935,2)
 ;;=^60741
 ;;^UTILITY(U,$J,358.3,36936,0)
 ;;=I73.9^^137^1779^2
 ;;^UTILITY(U,$J,358.3,36936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36936,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,36936,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,36936,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,36937,0)
 ;;=I80.13^^137^1779^3
 ;;^UTILITY(U,$J,358.3,36937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36937,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Femoral Vein
 ;;^UTILITY(U,$J,358.3,36937,1,4,0)
 ;;=4^I80.13
 ;;^UTILITY(U,$J,358.3,36937,2)
 ;;=^5007827
 ;;^UTILITY(U,$J,358.3,36938,0)
 ;;=I80.213^^137^1779^4
 ;;^UTILITY(U,$J,358.3,36938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36938,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Iliac Vein
 ;;^UTILITY(U,$J,358.3,36938,1,4,0)
 ;;=4^I80.213
 ;;^UTILITY(U,$J,358.3,36938,2)
 ;;=^5007833
 ;;^UTILITY(U,$J,358.3,36939,0)
 ;;=I80.223^^137^1779^7
 ;;^UTILITY(U,$J,358.3,36939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36939,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Popliteal Vein
 ;;^UTILITY(U,$J,358.3,36939,1,4,0)
 ;;=4^I80.223
 ;;^UTILITY(U,$J,358.3,36939,2)
 ;;=^5007837
 ;;^UTILITY(U,$J,358.3,36940,0)
 ;;=I80.233^^137^1779^8
 ;;^UTILITY(U,$J,358.3,36940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36940,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Tibial Vein
 ;;^UTILITY(U,$J,358.3,36940,1,4,0)
 ;;=4^I80.233
 ;;^UTILITY(U,$J,358.3,36940,2)
 ;;=^5007841
 ;;^UTILITY(U,$J,358.3,36941,0)
 ;;=I80.12^^137^1779^9
 ;;^UTILITY(U,$J,358.3,36941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36941,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Femoral Vein
 ;;^UTILITY(U,$J,358.3,36941,1,4,0)
 ;;=4^I80.12
 ;;^UTILITY(U,$J,358.3,36941,2)
 ;;=^5007826
 ;;^UTILITY(U,$J,358.3,36942,0)
 ;;=I80.212^^137^1779^10
 ;;^UTILITY(U,$J,358.3,36942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36942,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Iliac Vein
 ;;^UTILITY(U,$J,358.3,36942,1,4,0)
 ;;=4^I80.212
 ;;^UTILITY(U,$J,358.3,36942,2)
 ;;=^5007832
 ;;^UTILITY(U,$J,358.3,36943,0)
 ;;=I80.222^^137^1779^13
 ;;^UTILITY(U,$J,358.3,36943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36943,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Popliteal Vein
 ;;^UTILITY(U,$J,358.3,36943,1,4,0)
 ;;=4^I80.222
 ;;^UTILITY(U,$J,358.3,36943,2)
 ;;=^5007836
 ;;^UTILITY(U,$J,358.3,36944,0)
 ;;=I80.232^^137^1779^14
 ;;^UTILITY(U,$J,358.3,36944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36944,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Tibial Vein
 ;;^UTILITY(U,$J,358.3,36944,1,4,0)
 ;;=4^I80.232
 ;;^UTILITY(U,$J,358.3,36944,2)
 ;;=^5007840
 ;;^UTILITY(U,$J,358.3,36945,0)
 ;;=I80.293^^137^1779^5
 ;;^UTILITY(U,$J,358.3,36945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36945,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Lower Extremity Deep Vessels
