IBDEI24K ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36035,0)
 ;;=I80.13^^134^1741^3
 ;;^UTILITY(U,$J,358.3,36035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36035,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Femoral Vein
 ;;^UTILITY(U,$J,358.3,36035,1,4,0)
 ;;=4^I80.13
 ;;^UTILITY(U,$J,358.3,36035,2)
 ;;=^5007827
 ;;^UTILITY(U,$J,358.3,36036,0)
 ;;=I80.213^^134^1741^4
 ;;^UTILITY(U,$J,358.3,36036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36036,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Iliac Vein
 ;;^UTILITY(U,$J,358.3,36036,1,4,0)
 ;;=4^I80.213
 ;;^UTILITY(U,$J,358.3,36036,2)
 ;;=^5007833
 ;;^UTILITY(U,$J,358.3,36037,0)
 ;;=I80.223^^134^1741^7
 ;;^UTILITY(U,$J,358.3,36037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36037,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Popliteal Vein
 ;;^UTILITY(U,$J,358.3,36037,1,4,0)
 ;;=4^I80.223
 ;;^UTILITY(U,$J,358.3,36037,2)
 ;;=^5007837
 ;;^UTILITY(U,$J,358.3,36038,0)
 ;;=I80.233^^134^1741^8
 ;;^UTILITY(U,$J,358.3,36038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36038,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Tibial Vein
 ;;^UTILITY(U,$J,358.3,36038,1,4,0)
 ;;=4^I80.233
 ;;^UTILITY(U,$J,358.3,36038,2)
 ;;=^5007841
 ;;^UTILITY(U,$J,358.3,36039,0)
 ;;=I80.12^^134^1741^9
 ;;^UTILITY(U,$J,358.3,36039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36039,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Femoral Vein
 ;;^UTILITY(U,$J,358.3,36039,1,4,0)
 ;;=4^I80.12
 ;;^UTILITY(U,$J,358.3,36039,2)
 ;;=^5007826
 ;;^UTILITY(U,$J,358.3,36040,0)
 ;;=I80.212^^134^1741^10
 ;;^UTILITY(U,$J,358.3,36040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36040,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Iliac Vein
 ;;^UTILITY(U,$J,358.3,36040,1,4,0)
 ;;=4^I80.212
 ;;^UTILITY(U,$J,358.3,36040,2)
 ;;=^5007832
 ;;^UTILITY(U,$J,358.3,36041,0)
 ;;=I80.222^^134^1741^13
 ;;^UTILITY(U,$J,358.3,36041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36041,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Popliteal Vein
 ;;^UTILITY(U,$J,358.3,36041,1,4,0)
 ;;=4^I80.222
 ;;^UTILITY(U,$J,358.3,36041,2)
 ;;=^5007836
 ;;^UTILITY(U,$J,358.3,36042,0)
 ;;=I80.232^^134^1741^14
 ;;^UTILITY(U,$J,358.3,36042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36042,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Tibial Vein
 ;;^UTILITY(U,$J,358.3,36042,1,4,0)
 ;;=4^I80.232
 ;;^UTILITY(U,$J,358.3,36042,2)
 ;;=^5007840
 ;;^UTILITY(U,$J,358.3,36043,0)
 ;;=I80.293^^134^1741^5
 ;;^UTILITY(U,$J,358.3,36043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36043,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Bilateral Lower Extremity Deep Vessels
 ;;^UTILITY(U,$J,358.3,36043,1,4,0)
 ;;=4^I80.293
 ;;^UTILITY(U,$J,358.3,36043,2)
 ;;=^5007844
 ;;^UTILITY(U,$J,358.3,36044,0)
 ;;=I80.292^^134^1741^11
 ;;^UTILITY(U,$J,358.3,36044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36044,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Left Lower Extremity Deep Vessels
 ;;^UTILITY(U,$J,358.3,36044,1,4,0)
 ;;=4^I80.292
 ;;^UTILITY(U,$J,358.3,36044,2)
 ;;=^5133623
 ;;^UTILITY(U,$J,358.3,36045,0)
 ;;=I80.291^^134^1741^17
 ;;^UTILITY(U,$J,358.3,36045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36045,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis Right Lower Extremity Deep Vessels
 ;;^UTILITY(U,$J,358.3,36045,1,4,0)
 ;;=4^I80.291
 ;;^UTILITY(U,$J,358.3,36045,2)
 ;;=^5007843
 ;;^UTILITY(U,$J,358.3,36046,0)
 ;;=I80.8^^134^1741^22
 ;;^UTILITY(U,$J,358.3,36046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36046,1,3,0)
 ;;=3^Phlebitis/Thromophlebitis of Other Sites
 ;;^UTILITY(U,$J,358.3,36046,1,4,0)
 ;;=4^I80.8
 ;;^UTILITY(U,$J,358.3,36046,2)
 ;;=^176957
 ;;^UTILITY(U,$J,358.3,36047,0)
 ;;=I80.11^^134^1741^15
