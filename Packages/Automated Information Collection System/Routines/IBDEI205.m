IBDEI205 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33525,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,33525,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,33525,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,33526,0)
 ;;=F16.21^^148^1660^3
 ;;^UTILITY(U,$J,358.3,33526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33526,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,33526,1,4,0)
 ;;=4^F16.21
 ;;^UTILITY(U,$J,358.3,33526,2)
 ;;=^5003337
 ;;^UTILITY(U,$J,358.3,33527,0)
 ;;=F11.10^^148^1661^4
 ;;^UTILITY(U,$J,358.3,33527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33527,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,33527,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,33527,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,33528,0)
 ;;=F11.129^^148^1661^3
 ;;^UTILITY(U,$J,358.3,33528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33528,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances;Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,33528,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,33528,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,33529,0)
 ;;=F11.14^^148^1661^8
 ;;^UTILITY(U,$J,358.3,33529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33529,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,33529,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,33529,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,33530,0)
 ;;=F11.182^^148^1661^10
 ;;^UTILITY(U,$J,358.3,33530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33530,1,3,0)
 ;;=3^Opioid-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,33530,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,33530,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,33531,0)
 ;;=F11.20^^148^1661^5
 ;;^UTILITY(U,$J,358.3,33531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33531,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,33531,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,33531,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,33532,0)
 ;;=F11.21^^148^1661^6
 ;;^UTILITY(U,$J,358.3,33532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33532,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,33532,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,33532,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,33533,0)
 ;;=F11.23^^148^1661^7
 ;;^UTILITY(U,$J,358.3,33533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33533,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,33533,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,33533,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,33534,0)
 ;;=F11.24^^148^1661^9
 ;;^UTILITY(U,$J,358.3,33534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33534,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,33534,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,33534,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,33535,0)
 ;;=F11.29^^148^1661^2
 ;;^UTILITY(U,$J,358.3,33535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33535,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,33535,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,33535,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,33536,0)
 ;;=F11.220^^148^1661^1
 ;;^UTILITY(U,$J,358.3,33536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33536,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,33536,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,33536,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,33537,0)
 ;;=F19.10^^148^1662^3
 ;;^UTILITY(U,$J,358.3,33537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33537,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
