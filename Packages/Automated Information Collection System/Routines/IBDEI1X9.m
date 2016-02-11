IBDEI1X9 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32182,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,32182,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,32182,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,32183,0)
 ;;=F16.21^^141^1503^3
 ;;^UTILITY(U,$J,358.3,32183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32183,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,32183,1,4,0)
 ;;=4^F16.21
 ;;^UTILITY(U,$J,358.3,32183,2)
 ;;=^5003337
 ;;^UTILITY(U,$J,358.3,32184,0)
 ;;=F11.10^^141^1504^4
 ;;^UTILITY(U,$J,358.3,32184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32184,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,32184,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,32184,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,32185,0)
 ;;=F11.129^^141^1504^3
 ;;^UTILITY(U,$J,358.3,32185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32185,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances;Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,32185,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,32185,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,32186,0)
 ;;=F11.14^^141^1504^8
 ;;^UTILITY(U,$J,358.3,32186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32186,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,32186,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,32186,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,32187,0)
 ;;=F11.182^^141^1504^10
 ;;^UTILITY(U,$J,358.3,32187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32187,1,3,0)
 ;;=3^Opioid-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,32187,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,32187,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,32188,0)
 ;;=F11.20^^141^1504^5
 ;;^UTILITY(U,$J,358.3,32188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32188,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,32188,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,32188,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,32189,0)
 ;;=F11.21^^141^1504^6
 ;;^UTILITY(U,$J,358.3,32189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32189,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,32189,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,32189,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,32190,0)
 ;;=F11.23^^141^1504^7
 ;;^UTILITY(U,$J,358.3,32190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32190,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,32190,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,32190,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,32191,0)
 ;;=F11.24^^141^1504^9
 ;;^UTILITY(U,$J,358.3,32191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32191,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,32191,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,32191,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,32192,0)
 ;;=F11.29^^141^1504^2
 ;;^UTILITY(U,$J,358.3,32192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32192,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,32192,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,32192,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,32193,0)
 ;;=F11.220^^141^1504^1
 ;;^UTILITY(U,$J,358.3,32193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32193,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,32193,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,32193,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,32194,0)
 ;;=F19.10^^141^1505^3
 ;;^UTILITY(U,$J,358.3,32194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32194,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
