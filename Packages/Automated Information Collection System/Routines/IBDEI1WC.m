IBDEI1WC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31758,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,31758,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,31759,0)
 ;;=F11.20^^138^1455^5
 ;;^UTILITY(U,$J,358.3,31759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31759,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,31759,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,31759,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,31760,0)
 ;;=F11.21^^138^1455^6
 ;;^UTILITY(U,$J,358.3,31760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31760,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,31760,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,31760,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,31761,0)
 ;;=F11.23^^138^1455^7
 ;;^UTILITY(U,$J,358.3,31761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31761,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,31761,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,31761,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,31762,0)
 ;;=F11.24^^138^1455^9
 ;;^UTILITY(U,$J,358.3,31762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31762,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31762,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,31762,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,31763,0)
 ;;=F11.29^^138^1455^2
 ;;^UTILITY(U,$J,358.3,31763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31763,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,31763,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,31763,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,31764,0)
 ;;=F11.220^^138^1455^1
 ;;^UTILITY(U,$J,358.3,31764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31764,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,31764,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,31764,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,31765,0)
 ;;=F19.10^^138^1456^3
 ;;^UTILITY(U,$J,358.3,31765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31765,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,31765,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,31765,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,31766,0)
 ;;=F19.14^^138^1456^1
 ;;^UTILITY(U,$J,358.3,31766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31766,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,31766,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,31766,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,31767,0)
 ;;=F19.182^^138^1456^2
 ;;^UTILITY(U,$J,358.3,31767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31767,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,31767,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,31767,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,31768,0)
 ;;=F19.20^^138^1456^6
 ;;^UTILITY(U,$J,358.3,31768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31768,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,31768,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,31768,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,31769,0)
 ;;=F19.21^^138^1456^5
 ;;^UTILITY(U,$J,358.3,31769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31769,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,31769,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,31769,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,31770,0)
 ;;=F19.24^^138^1456^4
 ;;^UTILITY(U,$J,358.3,31770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31770,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,31770,1,4,0)
 ;;=4^F19.24
