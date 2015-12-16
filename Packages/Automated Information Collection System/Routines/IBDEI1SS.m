IBDEI1SS ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31706,0)
 ;;=F93.0^^180^1963^17
 ;;^UTILITY(U,$J,358.3,31706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31706,1,3,0)
 ;;=3^Separation anxiety disorder of childhood
 ;;^UTILITY(U,$J,358.3,31706,1,4,0)
 ;;=4^F93.0
 ;;^UTILITY(U,$J,358.3,31706,2)
 ;;=^5003702
 ;;^UTILITY(U,$J,358.3,31707,0)
 ;;=F43.22^^180^1963^2
 ;;^UTILITY(U,$J,358.3,31707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31707,1,3,0)
 ;;=3^Adjustment disorder with anxiety
 ;;^UTILITY(U,$J,358.3,31707,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,31707,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,31708,0)
 ;;=F43.23^^180^1963^5
 ;;^UTILITY(U,$J,358.3,31708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31708,1,3,0)
 ;;=3^Adjustment disorder with mixed anxiety and depressed mood
 ;;^UTILITY(U,$J,358.3,31708,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,31708,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,31709,0)
 ;;=F43.24^^180^1963^4
 ;;^UTILITY(U,$J,358.3,31709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31709,1,3,0)
 ;;=3^Adjustment disorder with disturbance of conduct
 ;;^UTILITY(U,$J,358.3,31709,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,31709,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,31710,0)
 ;;=F43.25^^180^1963^1
 ;;^UTILITY(U,$J,358.3,31710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31710,1,3,0)
 ;;=3^Adjustment disorder w mixed disturb of emotions and conduct
 ;;^UTILITY(U,$J,358.3,31710,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,31710,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,31711,0)
 ;;=F43.10^^180^1963^15
 ;;^UTILITY(U,$J,358.3,31711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31711,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspecified
 ;;^UTILITY(U,$J,358.3,31711,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,31711,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,31712,0)
 ;;=F43.12^^180^1963^14
 ;;^UTILITY(U,$J,358.3,31712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31712,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,31712,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,31712,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,31713,0)
 ;;=F43.8^^180^1963^16
 ;;^UTILITY(U,$J,358.3,31713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31713,1,3,0)
 ;;=3^Reactions to severe stress NEC
 ;;^UTILITY(U,$J,358.3,31713,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,31713,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,31714,0)
 ;;=F43.20^^180^1963^6
 ;;^UTILITY(U,$J,358.3,31714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31714,1,3,0)
 ;;=3^Adjustment disorder, unspecified
 ;;^UTILITY(U,$J,358.3,31714,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,31714,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,31715,0)
 ;;=F07.0^^180^1963^13
 ;;^UTILITY(U,$J,358.3,31715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31715,1,3,0)
 ;;=3^Personality change due to known physiological condition
 ;;^UTILITY(U,$J,358.3,31715,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,31715,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,31716,0)
 ;;=F32.9^^180^1963^12
 ;;^UTILITY(U,$J,358.3,31716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31716,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,31716,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,31716,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,31717,0)
 ;;=F98.5^^180^1964^1
 ;;^UTILITY(U,$J,358.3,31717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31717,1,3,0)
 ;;=3^Adult onset fluency disorder
 ;;^UTILITY(U,$J,358.3,31717,1,4,0)
 ;;=4^F98.5
 ;;^UTILITY(U,$J,358.3,31717,2)
 ;;=^5003717
 ;;^UTILITY(U,$J,358.3,31718,0)
 ;;=R47.01^^180^1964^2
 ;;^UTILITY(U,$J,358.3,31718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31718,1,3,0)
 ;;=3^Aphasia
