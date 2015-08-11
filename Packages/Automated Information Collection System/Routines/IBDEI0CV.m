IBDEI0CV ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6125,1,4,0)
 ;;=4^338.18
 ;;^UTILITY(U,$J,358.3,6125,1,5,0)
 ;;=5^Postoperative Pain NOS
 ;;^UTILITY(U,$J,358.3,6125,2)
 ;;=^334072
 ;;^UTILITY(U,$J,358.3,6126,0)
 ;;=338.19^^41^495^26
 ;;^UTILITY(U,$J,358.3,6126,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6126,1,4,0)
 ;;=4^338.19
 ;;^UTILITY(U,$J,358.3,6126,1,5,0)
 ;;=5^Other Acute Pain
 ;;^UTILITY(U,$J,358.3,6126,2)
 ;;=^334073
 ;;^UTILITY(U,$J,358.3,6127,0)
 ;;=338.21^^41^495^12
 ;;^UTILITY(U,$J,358.3,6127,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6127,1,4,0)
 ;;=4^338.21
 ;;^UTILITY(U,$J,358.3,6127,1,5,0)
 ;;=5^Chronic Pain due to Trauma
 ;;^UTILITY(U,$J,358.3,6127,2)
 ;;=^334074
 ;;^UTILITY(U,$J,358.3,6128,0)
 ;;=338.22^^41^495^13
 ;;^UTILITY(U,$J,358.3,6128,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6128,1,4,0)
 ;;=4^338.22
 ;;^UTILITY(U,$J,358.3,6128,1,5,0)
 ;;=5^Chronic Post-Thoracotomy Pain
 ;;^UTILITY(U,$J,358.3,6128,2)
 ;;=^334075
 ;;^UTILITY(U,$J,358.3,6129,0)
 ;;=338.28^^41^495^28
 ;;^UTILITY(U,$J,358.3,6129,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6129,1,4,0)
 ;;=4^338.28
 ;;^UTILITY(U,$J,358.3,6129,1,5,0)
 ;;=5^Other Chronic Postop Pain
 ;;^UTILITY(U,$J,358.3,6129,2)
 ;;=^334076
 ;;^UTILITY(U,$J,358.3,6130,0)
 ;;=338.29^^41^495^27
 ;;^UTILITY(U,$J,358.3,6130,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6130,1,4,0)
 ;;=4^338.29
 ;;^UTILITY(U,$J,358.3,6130,1,5,0)
 ;;=5^Other Chronic Pain
 ;;^UTILITY(U,$J,358.3,6130,2)
 ;;=^334077
 ;;^UTILITY(U,$J,358.3,6131,0)
 ;;=338.3^^41^495^8
 ;;^UTILITY(U,$J,358.3,6131,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6131,1,4,0)
 ;;=4^338.3
 ;;^UTILITY(U,$J,358.3,6131,1,5,0)
 ;;=5^Cancer Associated Pain
 ;;^UTILITY(U,$J,358.3,6131,2)
 ;;=^334078
 ;;^UTILITY(U,$J,358.3,6132,0)
 ;;=338.4^^41^495^11
 ;;^UTILITY(U,$J,358.3,6132,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6132,1,4,0)
 ;;=4^338.4
 ;;^UTILITY(U,$J,358.3,6132,1,5,0)
 ;;=5^Chronic Pain Syndrome
 ;;^UTILITY(U,$J,358.3,6132,2)
 ;;=^334079
 ;;^UTILITY(U,$J,358.3,6133,0)
 ;;=780.96^^41^495^17
 ;;^UTILITY(U,$J,358.3,6133,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6133,1,4,0)
 ;;=4^780.96
 ;;^UTILITY(U,$J,358.3,6133,1,5,0)
 ;;=5^Generalized Pain
 ;;^UTILITY(U,$J,358.3,6133,2)
 ;;=^334163
 ;;^UTILITY(U,$J,358.3,6134,0)
 ;;=607.9^^41^495^30
 ;;^UTILITY(U,$J,358.3,6134,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6134,1,4,0)
 ;;=4^607.9
 ;;^UTILITY(U,$J,358.3,6134,1,5,0)
 ;;=5^Penile Pain
 ;;^UTILITY(U,$J,358.3,6134,2)
 ;;=^270442
 ;;^UTILITY(U,$J,358.3,6135,0)
 ;;=608.9^^41^495^32
 ;;^UTILITY(U,$J,358.3,6135,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6135,1,4,0)
 ;;=4^608.9
 ;;^UTILITY(U,$J,358.3,6135,1,5,0)
 ;;=5^Scrotal Pain
 ;;^UTILITY(U,$J,358.3,6135,2)
 ;;=^123856
 ;;^UTILITY(U,$J,358.3,6136,0)
 ;;=V68.1^^41^496^4
 ;;^UTILITY(U,$J,358.3,6136,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6136,1,4,0)
 ;;=4^V68.1
 ;;^UTILITY(U,$J,358.3,6136,1,5,0)
 ;;=5^Rx Refill (Also mark Condition)
 ;;^UTILITY(U,$J,358.3,6136,2)
 ;;=RX Refill (also mark Condition)^295585
 ;;^UTILITY(U,$J,358.3,6137,0)
 ;;=V68.81^^41^496^6
 ;;^UTILITY(U,$J,358.3,6137,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6137,1,4,0)
 ;;=4^V68.81
 ;;^UTILITY(U,$J,358.3,6137,1,5,0)
 ;;=5^Transfer of Care (Also Mark Dx)
 ;;^UTILITY(U,$J,358.3,6137,2)
 ;;=Transfer of Care ^295587
 ;;^UTILITY(U,$J,358.3,6138,0)
 ;;=V58.83^^41^496^5
 ;;^UTILITY(U,$J,358.3,6138,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6138,1,4,0)
 ;;=4^V58.83
 ;;^UTILITY(U,$J,358.3,6138,1,5,0)
 ;;=5^Therapeutic Drug Monitoring
 ;;^UTILITY(U,$J,358.3,6138,2)
 ;;=Encounter for Therapeutic Drug Monitoring^322076
