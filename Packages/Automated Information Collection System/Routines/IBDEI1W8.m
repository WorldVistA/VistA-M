IBDEI1W8 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31709,0)
 ;;=G47.09^^138^1450^11
 ;;^UTILITY(U,$J,358.3,31709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31709,1,3,0)
 ;;=3^Insomnia Disorder NEC
 ;;^UTILITY(U,$J,358.3,31709,1,4,0)
 ;;=4^G47.09
 ;;^UTILITY(U,$J,358.3,31709,2)
 ;;=^5003970
 ;;^UTILITY(U,$J,358.3,31710,0)
 ;;=G47.00^^138^1450^10
 ;;^UTILITY(U,$J,358.3,31710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31710,1,3,0)
 ;;=3^Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,31710,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,31710,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,31711,0)
 ;;=G47.10^^138^1450^9
 ;;^UTILITY(U,$J,358.3,31711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31711,1,3,0)
 ;;=3^Hypersomnolence Disorder/Unspec Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,31711,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,31711,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,31712,0)
 ;;=G47.419^^138^1450^12
 ;;^UTILITY(U,$J,358.3,31712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31712,1,3,0)
 ;;=3^Narcolepsy
 ;;^UTILITY(U,$J,358.3,31712,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,31712,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,31713,0)
 ;;=G47.33^^138^1450^16
 ;;^UTILITY(U,$J,358.3,31713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31713,1,3,0)
 ;;=3^Obstructive Sleep Apnea Hypopnea
 ;;^UTILITY(U,$J,358.3,31713,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,31713,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,31714,0)
 ;;=G47.31^^138^1450^1
 ;;^UTILITY(U,$J,358.3,31714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31714,1,3,0)
 ;;=3^Central Sleep Apnea
 ;;^UTILITY(U,$J,358.3,31714,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,31714,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,31715,0)
 ;;=G47.21^^138^1450^3
 ;;^UTILITY(U,$J,358.3,31715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31715,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Delayed Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,31715,1,4,0)
 ;;=4^G47.21
 ;;^UTILITY(U,$J,358.3,31715,2)
 ;;=^332769
 ;;^UTILITY(U,$J,358.3,31716,0)
 ;;=G47.22^^138^1450^2
 ;;^UTILITY(U,$J,358.3,31716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31716,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,31716,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,31716,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,31717,0)
 ;;=G47.23^^138^1450^4
 ;;^UTILITY(U,$J,358.3,31717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31717,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,31717,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,31717,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,31718,0)
 ;;=G47.24^^138^1450^5
 ;;^UTILITY(U,$J,358.3,31718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31718,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,31718,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,31718,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,31719,0)
 ;;=G47.26^^138^1450^6
 ;;^UTILITY(U,$J,358.3,31719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31719,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Shift Work Type
 ;;^UTILITY(U,$J,358.3,31719,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,31719,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,31720,0)
 ;;=G47.20^^138^1450^7
 ;;^UTILITY(U,$J,358.3,31720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31720,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Unspec Type
 ;;^UTILITY(U,$J,358.3,31720,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,31720,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,31721,0)
 ;;=F51.3^^138^1450^14
 ;;^UTILITY(U,$J,358.3,31721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31721,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleepwalking Type
