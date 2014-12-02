IBDEI0FT ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7652,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7652,1,4,0)
 ;;=4^338.4
 ;;^UTILITY(U,$J,358.3,7652,1,5,0)
 ;;=5^Chronic Pain Syndrome
 ;;^UTILITY(U,$J,358.3,7652,2)
 ;;=^334079
 ;;^UTILITY(U,$J,358.3,7653,0)
 ;;=780.96^^55^585^17
 ;;^UTILITY(U,$J,358.3,7653,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7653,1,4,0)
 ;;=4^780.96
 ;;^UTILITY(U,$J,358.3,7653,1,5,0)
 ;;=5^Generalized Pain
 ;;^UTILITY(U,$J,358.3,7653,2)
 ;;=^334163
 ;;^UTILITY(U,$J,358.3,7654,0)
 ;;=607.9^^55^585^30
 ;;^UTILITY(U,$J,358.3,7654,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7654,1,4,0)
 ;;=4^607.9
 ;;^UTILITY(U,$J,358.3,7654,1,5,0)
 ;;=5^Penile Pain
 ;;^UTILITY(U,$J,358.3,7654,2)
 ;;=^270442
 ;;^UTILITY(U,$J,358.3,7655,0)
 ;;=608.9^^55^585^32
 ;;^UTILITY(U,$J,358.3,7655,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7655,1,4,0)
 ;;=4^608.9
 ;;^UTILITY(U,$J,358.3,7655,1,5,0)
 ;;=5^Scrotal Pain
 ;;^UTILITY(U,$J,358.3,7655,2)
 ;;=^123856
 ;;^UTILITY(U,$J,358.3,7656,0)
 ;;=V68.1^^55^586^4
 ;;^UTILITY(U,$J,358.3,7656,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7656,1,4,0)
 ;;=4^V68.1
 ;;^UTILITY(U,$J,358.3,7656,1,5,0)
 ;;=5^Rx Refill (Also mark Condition)
 ;;^UTILITY(U,$J,358.3,7656,2)
 ;;=RX Refill (also mark Condition)^295585
 ;;^UTILITY(U,$J,358.3,7657,0)
 ;;=V68.81^^55^586^6
 ;;^UTILITY(U,$J,358.3,7657,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7657,1,4,0)
 ;;=4^V68.81
 ;;^UTILITY(U,$J,358.3,7657,1,5,0)
 ;;=5^Transfer of Care (Also Mark Dx)
 ;;^UTILITY(U,$J,358.3,7657,2)
 ;;=Transfer of Care ^295587
 ;;^UTILITY(U,$J,358.3,7658,0)
 ;;=V58.83^^55^586^5
 ;;^UTILITY(U,$J,358.3,7658,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7658,1,4,0)
 ;;=4^V58.83
 ;;^UTILITY(U,$J,358.3,7658,1,5,0)
 ;;=5^Therapeutic Drug Monitoring
 ;;^UTILITY(U,$J,358.3,7658,2)
 ;;=Encounter for Therapeutic Drug Monitoring^322076
 ;;^UTILITY(U,$J,358.3,7659,0)
 ;;=V65.19^^55^586^3
 ;;^UTILITY(U,$J,358.3,7659,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7659,1,4,0)
 ;;=4^V65.19
 ;;^UTILITY(U,$J,358.3,7659,1,5,0)
 ;;=5^Person Consulting on Behalf of Pt
 ;;^UTILITY(U,$J,358.3,7659,2)
 ;;=^329985
 ;;^UTILITY(U,$J,358.3,7660,0)
 ;;=V60.89^^55^586^1
 ;;^UTILITY(U,$J,358.3,7660,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7660,1,4,0)
 ;;=4^V60.89
 ;;^UTILITY(U,$J,358.3,7660,1,5,0)
 ;;=5^Housing/Economic Circumstances
 ;;^UTILITY(U,$J,358.3,7660,2)
 ;;=^295545
 ;;^UTILITY(U,$J,358.3,7661,0)
 ;;=V68.09^^55^586^2
 ;;^UTILITY(U,$J,358.3,7661,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7661,1,4,0)
 ;;=4^V68.09
 ;;^UTILITY(U,$J,358.3,7661,1,5,0)
 ;;=5^Issue of Medical Certificate
 ;;^UTILITY(U,$J,358.3,7661,2)
 ;;=^335321
 ;;^UTILITY(U,$J,358.3,7662,0)
 ;;=309.0^^55^587^1
 ;;^UTILITY(U,$J,358.3,7662,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7662,1,4,0)
 ;;=4^309.0
 ;;^UTILITY(U,$J,358.3,7662,1,5,0)
 ;;=5^Adjustment Disorder
 ;;^UTILITY(U,$J,358.3,7662,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,7663,0)
 ;;=305.00^^55^587^3
 ;;^UTILITY(U,$J,358.3,7663,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7663,1,4,0)
 ;;=4^305.00
 ;;^UTILITY(U,$J,358.3,7663,1,5,0)
 ;;=5^Alcohol Abuse-Unspec
 ;;^UTILITY(U,$J,358.3,7663,2)
 ;;=^268227
 ;;^UTILITY(U,$J,358.3,7664,0)
 ;;=305.03^^55^587^2
 ;;^UTILITY(U,$J,358.3,7664,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7664,1,4,0)
 ;;=4^305.03
 ;;^UTILITY(U,$J,358.3,7664,1,5,0)
 ;;=5^Alcohol Abuse-In Remission
 ;;^UTILITY(U,$J,358.3,7664,2)
 ;;=^268230
 ;;^UTILITY(U,$J,358.3,7665,0)
 ;;=477.9^^55^587^4
 ;;^UTILITY(U,$J,358.3,7665,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7665,1,4,0)
 ;;=4^477.9
 ;;^UTILITY(U,$J,358.3,7665,1,5,0)
 ;;=5^Allergic Rhinitis NOS
