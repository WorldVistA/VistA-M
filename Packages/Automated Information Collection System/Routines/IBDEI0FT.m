IBDEI0FT ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6989,1,4,0)
 ;;=4^D04.0
 ;;^UTILITY(U,$J,358.3,6989,2)
 ;;=^267725
 ;;^UTILITY(U,$J,358.3,6990,0)
 ;;=D04.11^^46^459^13
 ;;^UTILITY(U,$J,358.3,6990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6990,1,3,0)
 ;;=3^Carcinoma in Situ Skin Right Eyelid
 ;;^UTILITY(U,$J,358.3,6990,1,4,0)
 ;;=4^D04.11
 ;;^UTILITY(U,$J,358.3,6990,2)
 ;;=^5001910
 ;;^UTILITY(U,$J,358.3,6991,0)
 ;;=D04.12^^46^459^7
 ;;^UTILITY(U,$J,358.3,6991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6991,1,3,0)
 ;;=3^Carcinoma in Situ Skin Left Eyelid
 ;;^UTILITY(U,$J,358.3,6991,1,4,0)
 ;;=4^D04.12
 ;;^UTILITY(U,$J,358.3,6991,2)
 ;;=^5001911
 ;;^UTILITY(U,$J,358.3,6992,0)
 ;;=D04.21^^46^459^12
 ;;^UTILITY(U,$J,358.3,6992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6992,1,3,0)
 ;;=3^Carcinoma in Situ Skin Right Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,6992,1,4,0)
 ;;=4^D04.21
 ;;^UTILITY(U,$J,358.3,6992,2)
 ;;=^5001913
 ;;^UTILITY(U,$J,358.3,6993,0)
 ;;=D04.22^^46^459^6
 ;;^UTILITY(U,$J,358.3,6993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6993,1,3,0)
 ;;=3^Carcinoma in Situ Skin Left Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,6993,1,4,0)
 ;;=4^D04.22
 ;;^UTILITY(U,$J,358.3,6993,2)
 ;;=^5001914
 ;;^UTILITY(U,$J,358.3,6994,0)
 ;;=D04.30^^46^459^5
 ;;^UTILITY(U,$J,358.3,6994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6994,1,3,0)
 ;;=3^Carcinoma in Situ Skin Face,Unspec
 ;;^UTILITY(U,$J,358.3,6994,1,4,0)
 ;;=4^D04.30
 ;;^UTILITY(U,$J,358.3,6994,2)
 ;;=^5001915
 ;;^UTILITY(U,$J,358.3,6995,0)
 ;;=D04.39^^46^459^4
 ;;^UTILITY(U,$J,358.3,6995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6995,1,3,0)
 ;;=3^Carcinoma in Situ Skin Face NEC
 ;;^UTILITY(U,$J,358.3,6995,1,4,0)
 ;;=4^D04.39
 ;;^UTILITY(U,$J,358.3,6995,2)
 ;;=^5001916
 ;;^UTILITY(U,$J,358.3,6996,0)
 ;;=D04.4^^46^459^16
 ;;^UTILITY(U,$J,358.3,6996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6996,1,3,0)
 ;;=3^Carcinoma in Situ Skin Scalp/Neck
 ;;^UTILITY(U,$J,358.3,6996,1,4,0)
 ;;=4^D04.4
 ;;^UTILITY(U,$J,358.3,6996,2)
 ;;=^267729
 ;;^UTILITY(U,$J,358.3,6997,0)
 ;;=D04.5^^46^459^17
 ;;^UTILITY(U,$J,358.3,6997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6997,1,3,0)
 ;;=3^Carcinoma in Situ Skin Trunk
 ;;^UTILITY(U,$J,358.3,6997,1,4,0)
 ;;=4^D04.5
 ;;^UTILITY(U,$J,358.3,6997,2)
 ;;=^5001917
 ;;^UTILITY(U,$J,358.3,6998,0)
 ;;=D04.61^^46^459^15
 ;;^UTILITY(U,$J,358.3,6998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6998,1,3,0)
 ;;=3^Carcinoma in Situ Skin Right Upper Limb
 ;;^UTILITY(U,$J,358.3,6998,1,4,0)
 ;;=4^D04.61
 ;;^UTILITY(U,$J,358.3,6998,2)
 ;;=^5001919
 ;;^UTILITY(U,$J,358.3,6999,0)
 ;;=D04.62^^46^459^9
 ;;^UTILITY(U,$J,358.3,6999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6999,1,3,0)
 ;;=3^Carcinoma in Situ Skin Left Upper Limb
 ;;^UTILITY(U,$J,358.3,6999,1,4,0)
 ;;=4^D04.62
 ;;^UTILITY(U,$J,358.3,6999,2)
 ;;=^5001920
 ;;^UTILITY(U,$J,358.3,7000,0)
 ;;=D04.71^^46^459^14
 ;;^UTILITY(U,$J,358.3,7000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7000,1,3,0)
 ;;=3^Carcinoma in Situ Skin Right Lower Limb
 ;;^UTILITY(U,$J,358.3,7000,1,4,0)
 ;;=4^D04.71
 ;;^UTILITY(U,$J,358.3,7000,2)
 ;;=^5001922
 ;;^UTILITY(U,$J,358.3,7001,0)
 ;;=D04.72^^46^459^8
 ;;^UTILITY(U,$J,358.3,7001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7001,1,3,0)
 ;;=3^Carcinoma in Situ Skin Left Lower Limb
 ;;^UTILITY(U,$J,358.3,7001,1,4,0)
 ;;=4^D04.72
 ;;^UTILITY(U,$J,358.3,7001,2)
 ;;=^5001923
 ;;^UTILITY(U,$J,358.3,7002,0)
 ;;=D04.8^^46^459^11
 ;;^UTILITY(U,$J,358.3,7002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7002,1,3,0)
 ;;=3^Carcinoma in Situ Skin Other Sites
