IBDEI0IN ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8732,1,5,0)
 ;;=5^Chronic Pain Syndrome
 ;;^UTILITY(U,$J,358.3,8732,2)
 ;;=^334079
 ;;^UTILITY(U,$J,358.3,8733,0)
 ;;=780.96^^35^489^17
 ;;^UTILITY(U,$J,358.3,8733,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8733,1,4,0)
 ;;=4^780.96
 ;;^UTILITY(U,$J,358.3,8733,1,5,0)
 ;;=5^Generalized Pain
 ;;^UTILITY(U,$J,358.3,8733,2)
 ;;=^334163
 ;;^UTILITY(U,$J,358.3,8734,0)
 ;;=607.9^^35^489^30
 ;;^UTILITY(U,$J,358.3,8734,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8734,1,4,0)
 ;;=4^607.9
 ;;^UTILITY(U,$J,358.3,8734,1,5,0)
 ;;=5^Penile Pain
 ;;^UTILITY(U,$J,358.3,8734,2)
 ;;=^270442
 ;;^UTILITY(U,$J,358.3,8735,0)
 ;;=608.9^^35^489^32
 ;;^UTILITY(U,$J,358.3,8735,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8735,1,4,0)
 ;;=4^608.9
 ;;^UTILITY(U,$J,358.3,8735,1,5,0)
 ;;=5^Scrotal Pain
 ;;^UTILITY(U,$J,358.3,8735,2)
 ;;=^123856
 ;;^UTILITY(U,$J,358.3,8736,0)
 ;;=V68.1^^35^490^4
 ;;^UTILITY(U,$J,358.3,8736,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8736,1,4,0)
 ;;=4^V68.1
 ;;^UTILITY(U,$J,358.3,8736,1,5,0)
 ;;=5^Rx Refill (Also mark Condition)
 ;;^UTILITY(U,$J,358.3,8736,2)
 ;;=RX Refill (also mark Condition)^295585
 ;;^UTILITY(U,$J,358.3,8737,0)
 ;;=V68.81^^35^490^6
 ;;^UTILITY(U,$J,358.3,8737,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8737,1,4,0)
 ;;=4^V68.81
 ;;^UTILITY(U,$J,358.3,8737,1,5,0)
 ;;=5^Transfer of Care (Also Mark Dx)
 ;;^UTILITY(U,$J,358.3,8737,2)
 ;;=Transfer of Care ^295587
 ;;^UTILITY(U,$J,358.3,8738,0)
 ;;=V58.83^^35^490^5
 ;;^UTILITY(U,$J,358.3,8738,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8738,1,4,0)
 ;;=4^V58.83
 ;;^UTILITY(U,$J,358.3,8738,1,5,0)
 ;;=5^Therapeutic Drug Monitoring
 ;;^UTILITY(U,$J,358.3,8738,2)
 ;;=Encounter for Therapeutic Drug Monitoring^322076
 ;;^UTILITY(U,$J,358.3,8739,0)
 ;;=V65.19^^35^490^3
 ;;^UTILITY(U,$J,358.3,8739,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8739,1,4,0)
 ;;=4^V65.19
 ;;^UTILITY(U,$J,358.3,8739,1,5,0)
 ;;=5^Person Consulting on Behalf of Pt
 ;;^UTILITY(U,$J,358.3,8739,2)
 ;;=^329985
 ;;^UTILITY(U,$J,358.3,8740,0)
 ;;=V60.89^^35^490^1
 ;;^UTILITY(U,$J,358.3,8740,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8740,1,4,0)
 ;;=4^V60.89
 ;;^UTILITY(U,$J,358.3,8740,1,5,0)
 ;;=5^Housing/Economic Circumstances
 ;;^UTILITY(U,$J,358.3,8740,2)
 ;;=^295545
 ;;^UTILITY(U,$J,358.3,8741,0)
 ;;=V68.09^^35^490^2
 ;;^UTILITY(U,$J,358.3,8741,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8741,1,4,0)
 ;;=4^V68.09
 ;;^UTILITY(U,$J,358.3,8741,1,5,0)
 ;;=5^Issue of Medical Certificate
 ;;^UTILITY(U,$J,358.3,8741,2)
 ;;=^335321
 ;;^UTILITY(U,$J,358.3,8742,0)
 ;;=309.0^^35^491^1
 ;;^UTILITY(U,$J,358.3,8742,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8742,1,4,0)
 ;;=4^309.0
 ;;^UTILITY(U,$J,358.3,8742,1,5,0)
 ;;=5^Adjustment Disorder
 ;;^UTILITY(U,$J,358.3,8742,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,8743,0)
 ;;=305.00^^35^491^3
 ;;^UTILITY(U,$J,358.3,8743,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8743,1,4,0)
 ;;=4^305.00
 ;;^UTILITY(U,$J,358.3,8743,1,5,0)
 ;;=5^Alcohol Abuse-Unspec
 ;;^UTILITY(U,$J,358.3,8743,2)
 ;;=^268227
 ;;^UTILITY(U,$J,358.3,8744,0)
 ;;=305.03^^35^491^2
 ;;^UTILITY(U,$J,358.3,8744,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8744,1,4,0)
 ;;=4^305.03
 ;;^UTILITY(U,$J,358.3,8744,1,5,0)
 ;;=5^Alcohol Abuse-In Remission
 ;;^UTILITY(U,$J,358.3,8744,2)
 ;;=^268230
 ;;^UTILITY(U,$J,358.3,8745,0)
 ;;=477.9^^35^491^4
 ;;^UTILITY(U,$J,358.3,8745,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8745,1,4,0)
 ;;=4^477.9
 ;;^UTILITY(U,$J,358.3,8745,1,5,0)
 ;;=5^Allergic Rhinitis NOS
 ;;^UTILITY(U,$J,358.3,8745,2)
 ;;=^4955
 ;;^UTILITY(U,$J,358.3,8746,0)
 ;;=285.9^^35^491^5
