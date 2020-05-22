IBDEI1HB ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23650,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,23651,0)
 ;;=F11.21^^105^1181^7
 ;;^UTILITY(U,$J,358.3,23651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23651,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,23651,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,23651,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,23652,0)
 ;;=F11.23^^105^1181^8
 ;;^UTILITY(U,$J,358.3,23652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23652,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,23652,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,23652,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,23653,0)
 ;;=F11.24^^105^1181^10
 ;;^UTILITY(U,$J,358.3,23653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23653,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23653,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,23653,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,23654,0)
 ;;=F11.29^^105^1181^3
 ;;^UTILITY(U,$J,358.3,23654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23654,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,23654,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,23654,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,23655,0)
 ;;=F11.220^^105^1181^2
 ;;^UTILITY(U,$J,358.3,23655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23655,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23655,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,23655,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,23656,0)
 ;;=F11.11^^105^1181^1
 ;;^UTILITY(U,$J,358.3,23656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23656,1,3,0)
 ;;=3^Opioid Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,23656,1,4,0)
 ;;=4^F11.11
 ;;^UTILITY(U,$J,358.3,23656,2)
 ;;=^268246
 ;;^UTILITY(U,$J,358.3,23657,0)
 ;;=F19.10^^105^1182^4
 ;;^UTILITY(U,$J,358.3,23657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23657,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23657,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,23657,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,23658,0)
 ;;=F19.14^^105^1182^1
 ;;^UTILITY(U,$J,358.3,23658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23658,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,23658,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,23658,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,23659,0)
 ;;=F19.182^^105^1182^2
 ;;^UTILITY(U,$J,358.3,23659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23659,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,23659,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,23659,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,23660,0)
 ;;=F19.20^^105^1182^7
 ;;^UTILITY(U,$J,358.3,23660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23660,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23660,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,23660,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,23661,0)
 ;;=F19.21^^105^1182^6
 ;;^UTILITY(U,$J,358.3,23661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23661,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,23661,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,23661,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,23662,0)
 ;;=F19.24^^105^1182^5
 ;;^UTILITY(U,$J,358.3,23662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23662,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
