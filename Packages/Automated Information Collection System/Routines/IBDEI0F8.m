IBDEI0F8 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6985,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6985,1,4,0)
 ;;=4^338.19
 ;;^UTILITY(U,$J,358.3,6985,1,5,0)
 ;;=5^Other Acute Pain
 ;;^UTILITY(U,$J,358.3,6985,2)
 ;;=^334073
 ;;^UTILITY(U,$J,358.3,6986,0)
 ;;=338.21^^31^416^12
 ;;^UTILITY(U,$J,358.3,6986,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6986,1,4,0)
 ;;=4^338.21
 ;;^UTILITY(U,$J,358.3,6986,1,5,0)
 ;;=5^Chronic Pain due to Trauma
 ;;^UTILITY(U,$J,358.3,6986,2)
 ;;=^334074
 ;;^UTILITY(U,$J,358.3,6987,0)
 ;;=338.22^^31^416^13
 ;;^UTILITY(U,$J,358.3,6987,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6987,1,4,0)
 ;;=4^338.22
 ;;^UTILITY(U,$J,358.3,6987,1,5,0)
 ;;=5^Chronic Post-Thoracotomy Pain
 ;;^UTILITY(U,$J,358.3,6987,2)
 ;;=^334075
 ;;^UTILITY(U,$J,358.3,6988,0)
 ;;=338.28^^31^416^28
 ;;^UTILITY(U,$J,358.3,6988,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6988,1,4,0)
 ;;=4^338.28
 ;;^UTILITY(U,$J,358.3,6988,1,5,0)
 ;;=5^Other Chronic Postop Pain
 ;;^UTILITY(U,$J,358.3,6988,2)
 ;;=^334076
 ;;^UTILITY(U,$J,358.3,6989,0)
 ;;=338.29^^31^416^27
 ;;^UTILITY(U,$J,358.3,6989,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6989,1,4,0)
 ;;=4^338.29
 ;;^UTILITY(U,$J,358.3,6989,1,5,0)
 ;;=5^Other Chronic Pain
 ;;^UTILITY(U,$J,358.3,6989,2)
 ;;=^334077
 ;;^UTILITY(U,$J,358.3,6990,0)
 ;;=338.3^^31^416^8
 ;;^UTILITY(U,$J,358.3,6990,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6990,1,4,0)
 ;;=4^338.3
 ;;^UTILITY(U,$J,358.3,6990,1,5,0)
 ;;=5^Cancer Associated Pain
 ;;^UTILITY(U,$J,358.3,6990,2)
 ;;=^334078
 ;;^UTILITY(U,$J,358.3,6991,0)
 ;;=338.4^^31^416^11
 ;;^UTILITY(U,$J,358.3,6991,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6991,1,4,0)
 ;;=4^338.4
 ;;^UTILITY(U,$J,358.3,6991,1,5,0)
 ;;=5^Chronic Pain Syndrome
 ;;^UTILITY(U,$J,358.3,6991,2)
 ;;=^334079
 ;;^UTILITY(U,$J,358.3,6992,0)
 ;;=780.96^^31^416^17
 ;;^UTILITY(U,$J,358.3,6992,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6992,1,4,0)
 ;;=4^780.96
 ;;^UTILITY(U,$J,358.3,6992,1,5,0)
 ;;=5^Generalized Pain
 ;;^UTILITY(U,$J,358.3,6992,2)
 ;;=^334163
 ;;^UTILITY(U,$J,358.3,6993,0)
 ;;=607.9^^31^416^30
 ;;^UTILITY(U,$J,358.3,6993,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6993,1,4,0)
 ;;=4^607.9
 ;;^UTILITY(U,$J,358.3,6993,1,5,0)
 ;;=5^Penile Pain
 ;;^UTILITY(U,$J,358.3,6993,2)
 ;;=^270442
 ;;^UTILITY(U,$J,358.3,6994,0)
 ;;=608.9^^31^416^32
 ;;^UTILITY(U,$J,358.3,6994,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6994,1,4,0)
 ;;=4^608.9
 ;;^UTILITY(U,$J,358.3,6994,1,5,0)
 ;;=5^Scrotal Pain
 ;;^UTILITY(U,$J,358.3,6994,2)
 ;;=^123856
 ;;^UTILITY(U,$J,358.3,6995,0)
 ;;=V68.1^^31^417^7
 ;;^UTILITY(U,$J,358.3,6995,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6995,1,4,0)
 ;;=4^V68.1
 ;;^UTILITY(U,$J,358.3,6995,1,5,0)
 ;;=5^Rx Refill (Also mark Condition)
 ;;^UTILITY(U,$J,358.3,6995,2)
 ;;=RX Refill (also mark Condition)^295585
 ;;^UTILITY(U,$J,358.3,6996,0)
 ;;=V68.81^^31^417^6
 ;;^UTILITY(U,$J,358.3,6996,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6996,1,4,0)
 ;;=4^V68.81
 ;;^UTILITY(U,$J,358.3,6996,1,5,0)
 ;;=5^Referral w/o Exam or Treatment
 ;;^UTILITY(U,$J,358.3,6996,2)
 ;;=Transfer of Care ^295587
 ;;^UTILITY(U,$J,358.3,6997,0)
 ;;=V58.83^^31^417^4
 ;;^UTILITY(U,$J,358.3,6997,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6997,1,4,0)
 ;;=4^V58.83
 ;;^UTILITY(U,$J,358.3,6997,1,5,0)
 ;;=5^Encounter for Therapeutic Drug Monitoring
 ;;^UTILITY(U,$J,358.3,6997,2)
 ;;=Encounter for Therapeutic Drug Monitoring^322076
 ;;^UTILITY(U,$J,358.3,6998,0)
 ;;=V68.09^^31^417^5
 ;;^UTILITY(U,$J,358.3,6998,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6998,1,4,0)
 ;;=4^V68.09
 ;;^UTILITY(U,$J,358.3,6998,1,5,0)
 ;;=5^Forms Completion (Also include Condition
