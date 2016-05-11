IBDEI1S0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30184,1,3,0)
 ;;=3^Follicular lymphoma grade I, unspecified site
 ;;^UTILITY(U,$J,358.3,30184,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,30184,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,30185,0)
 ;;=C82.90^^118^1502^36
 ;;^UTILITY(U,$J,358.3,30185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30185,1,3,0)
 ;;=3^Follicular lymphoma, unspecified, unspecified site
 ;;^UTILITY(U,$J,358.3,30185,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,30185,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,30186,0)
 ;;=C82.99^^118^1502^35
 ;;^UTILITY(U,$J,358.3,30186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30186,1,3,0)
 ;;=3^Follicular lymphoma, unsp, extranodal and solid organ sites
 ;;^UTILITY(U,$J,358.3,30186,1,4,0)
 ;;=4^C82.99
 ;;^UTILITY(U,$J,358.3,30186,2)
 ;;=^5001550
 ;;^UTILITY(U,$J,358.3,30187,0)
 ;;=C84.00^^118^1502^60
 ;;^UTILITY(U,$J,358.3,30187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30187,1,3,0)
 ;;=3^Mycosis fungoides, unspecified site
 ;;^UTILITY(U,$J,358.3,30187,1,4,0)
 ;;=4^C84.00
 ;;^UTILITY(U,$J,358.3,30187,2)
 ;;=^5001621
 ;;^UTILITY(U,$J,358.3,30188,0)
 ;;=C84.09^^118^1502^59
 ;;^UTILITY(U,$J,358.3,30188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30188,1,3,0)
 ;;=3^Mycosis fungoides, extranodal and solid organ sites
 ;;^UTILITY(U,$J,358.3,30188,1,4,0)
 ;;=4^C84.09
 ;;^UTILITY(U,$J,358.3,30188,2)
 ;;=^5001630
 ;;^UTILITY(U,$J,358.3,30189,0)
 ;;=C84.60^^118^1502^8
 ;;^UTILITY(U,$J,358.3,30189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30189,1,3,0)
 ;;=3^Anaplastic large cell lymphoma, ALK-positive, unsp site
 ;;^UTILITY(U,$J,358.3,30189,1,4,0)
 ;;=4^C84.60
 ;;^UTILITY(U,$J,358.3,30189,2)
 ;;=^5001651
 ;;^UTILITY(U,$J,358.3,30190,0)
 ;;=C84.69^^118^1502^10
 ;;^UTILITY(U,$J,358.3,30190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30190,1,3,0)
 ;;=3^Anaplstc lg cell lymph, ALK-pos, extrnod and solid org sites
 ;;^UTILITY(U,$J,358.3,30190,1,4,0)
 ;;=4^C84.69
 ;;^UTILITY(U,$J,358.3,30190,2)
 ;;=^5001660
 ;;^UTILITY(U,$J,358.3,30191,0)
 ;;=C84.70^^118^1502^7
 ;;^UTILITY(U,$J,358.3,30191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30191,1,3,0)
 ;;=3^Anaplastic large cell lymphoma, ALK-negative, unsp site
 ;;^UTILITY(U,$J,358.3,30191,1,4,0)
 ;;=4^C84.70
 ;;^UTILITY(U,$J,358.3,30191,2)
 ;;=^5001661
 ;;^UTILITY(U,$J,358.3,30192,0)
 ;;=C84.79^^118^1502^9
 ;;^UTILITY(U,$J,358.3,30192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30192,1,3,0)
 ;;=3^Anaplstc lg cell lymph, ALK-neg, extrnod and solid org sites
 ;;^UTILITY(U,$J,358.3,30192,1,4,0)
 ;;=4^C84.79
 ;;^UTILITY(U,$J,358.3,30192,2)
 ;;=^5001670
 ;;^UTILITY(U,$J,358.3,30193,0)
 ;;=C91.40^^118^1502^37
 ;;^UTILITY(U,$J,358.3,30193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30193,1,3,0)
 ;;=3^Hairy cell leukemia not having achieved remission
 ;;^UTILITY(U,$J,358.3,30193,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,30193,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,30194,0)
 ;;=C91.41^^118^1502^39
 ;;^UTILITY(U,$J,358.3,30194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30194,1,3,0)
 ;;=3^Hairy cell leukemia, in remission
 ;;^UTILITY(U,$J,358.3,30194,1,4,0)
 ;;=4^C91.41
 ;;^UTILITY(U,$J,358.3,30194,2)
 ;;=^5001772
 ;;^UTILITY(U,$J,358.3,30195,0)
 ;;=C91.42^^118^1502^38
 ;;^UTILITY(U,$J,358.3,30195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30195,1,3,0)
 ;;=3^Hairy cell leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,30195,1,4,0)
 ;;=4^C91.42
 ;;^UTILITY(U,$J,358.3,30195,2)
 ;;=^5001773
 ;;^UTILITY(U,$J,358.3,30196,0)
 ;;=C96.4^^118^1502^71
 ;;^UTILITY(U,$J,358.3,30196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30196,1,3,0)
 ;;=3^Sarcoma of dendritic cells (accessory cells)
