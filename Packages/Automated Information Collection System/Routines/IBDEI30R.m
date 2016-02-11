IBDEI30R ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,50612,2)
 ;;=^5008255
 ;;^UTILITY(U,$J,358.3,50613,0)
 ;;=J45.909^^219^2457^5
 ;;^UTILITY(U,$J,358.3,50613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50613,1,3,0)
 ;;=3^Asthma,Uncomplicated,Unspec
 ;;^UTILITY(U,$J,358.3,50613,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,50613,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,50614,0)
 ;;=J42.^^219^2457^13
 ;;^UTILITY(U,$J,358.3,50614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50614,1,3,0)
 ;;=3^Chr Bronchitis,Unspec
 ;;^UTILITY(U,$J,358.3,50614,1,4,0)
 ;;=4^J42.
 ;;^UTILITY(U,$J,358.3,50614,2)
 ;;=^5008234
 ;;^UTILITY(U,$J,358.3,50615,0)
 ;;=I95.1^^219^2458^1
 ;;^UTILITY(U,$J,358.3,50615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50615,1,3,0)
 ;;=3^Orthostatic Hypotension
 ;;^UTILITY(U,$J,358.3,50615,1,4,0)
 ;;=4^I95.1
 ;;^UTILITY(U,$J,358.3,50615,2)
 ;;=^60741
 ;;^UTILITY(U,$J,358.3,50616,0)
 ;;=I73.9^^219^2458^2
 ;;^UTILITY(U,$J,358.3,50616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50616,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,50616,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,50616,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,50617,0)
 ;;=I80.13^^219^2458^3
 ;;^UTILITY(U,$J,358.3,50617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50617,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Femoral Vein
 ;;^UTILITY(U,$J,358.3,50617,1,4,0)
 ;;=4^I80.13
 ;;^UTILITY(U,$J,358.3,50617,2)
 ;;=^5007827
 ;;^UTILITY(U,$J,358.3,50618,0)
 ;;=I80.213^^219^2458^4
 ;;^UTILITY(U,$J,358.3,50618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50618,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Iliac Vein
 ;;^UTILITY(U,$J,358.3,50618,1,4,0)
 ;;=4^I80.213
 ;;^UTILITY(U,$J,358.3,50618,2)
 ;;=^5007833
 ;;^UTILITY(U,$J,358.3,50619,0)
 ;;=I80.223^^219^2458^7
 ;;^UTILITY(U,$J,358.3,50619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50619,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Popliteal Vein
 ;;^UTILITY(U,$J,358.3,50619,1,4,0)
 ;;=4^I80.223
 ;;^UTILITY(U,$J,358.3,50619,2)
 ;;=^5007837
 ;;^UTILITY(U,$J,358.3,50620,0)
 ;;=I80.233^^219^2458^8
 ;;^UTILITY(U,$J,358.3,50620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50620,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Tibial Vein
 ;;^UTILITY(U,$J,358.3,50620,1,4,0)
 ;;=4^I80.233
 ;;^UTILITY(U,$J,358.3,50620,2)
 ;;=^5007841
 ;;^UTILITY(U,$J,358.3,50621,0)
 ;;=I80.12^^219^2458^9
 ;;^UTILITY(U,$J,358.3,50621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50621,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Femoral Vein
 ;;^UTILITY(U,$J,358.3,50621,1,4,0)
 ;;=4^I80.12
 ;;^UTILITY(U,$J,358.3,50621,2)
 ;;=^5007826
 ;;^UTILITY(U,$J,358.3,50622,0)
 ;;=I80.212^^219^2458^10
 ;;^UTILITY(U,$J,358.3,50622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50622,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Iliac Vein
 ;;^UTILITY(U,$J,358.3,50622,1,4,0)
 ;;=4^I80.212
 ;;^UTILITY(U,$J,358.3,50622,2)
 ;;=^5007832
 ;;^UTILITY(U,$J,358.3,50623,0)
 ;;=I80.222^^219^2458^13
 ;;^UTILITY(U,$J,358.3,50623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50623,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Popliteal Vein
 ;;^UTILITY(U,$J,358.3,50623,1,4,0)
 ;;=4^I80.222
 ;;^UTILITY(U,$J,358.3,50623,2)
 ;;=^5007836
 ;;^UTILITY(U,$J,358.3,50624,0)
 ;;=I80.232^^219^2458^14
 ;;^UTILITY(U,$J,358.3,50624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50624,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Tibial Vein
 ;;^UTILITY(U,$J,358.3,50624,1,4,0)
 ;;=4^I80.232
 ;;^UTILITY(U,$J,358.3,50624,2)
 ;;=^5007840
 ;;^UTILITY(U,$J,358.3,50625,0)
 ;;=I80.293^^219^2458^5
 ;;^UTILITY(U,$J,358.3,50625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50625,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Lower Extremity Deep Vessels
