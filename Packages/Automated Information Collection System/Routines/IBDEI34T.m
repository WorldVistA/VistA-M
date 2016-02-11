IBDEI34T ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52562,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,52562,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,52562,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,52563,0)
 ;;=F16.21^^237^2617^3
 ;;^UTILITY(U,$J,358.3,52563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52563,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,52563,1,4,0)
 ;;=4^F16.21
 ;;^UTILITY(U,$J,358.3,52563,2)
 ;;=^5003337
 ;;^UTILITY(U,$J,358.3,52564,0)
 ;;=F11.10^^237^2618^4
 ;;^UTILITY(U,$J,358.3,52564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52564,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,52564,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,52564,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,52565,0)
 ;;=F11.129^^237^2618^3
 ;;^UTILITY(U,$J,358.3,52565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52565,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances;Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,52565,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,52565,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,52566,0)
 ;;=F11.14^^237^2618^8
 ;;^UTILITY(U,$J,358.3,52566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52566,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,52566,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,52566,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,52567,0)
 ;;=F11.182^^237^2618^10
 ;;^UTILITY(U,$J,358.3,52567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52567,1,3,0)
 ;;=3^Opioid-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,52567,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,52567,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,52568,0)
 ;;=F11.20^^237^2618^5
 ;;^UTILITY(U,$J,358.3,52568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52568,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,52568,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,52568,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,52569,0)
 ;;=F11.21^^237^2618^6
 ;;^UTILITY(U,$J,358.3,52569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52569,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,52569,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,52569,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,52570,0)
 ;;=F11.23^^237^2618^7
 ;;^UTILITY(U,$J,358.3,52570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52570,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,52570,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,52570,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,52571,0)
 ;;=F11.24^^237^2618^9
 ;;^UTILITY(U,$J,358.3,52571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52571,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,52571,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,52571,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,52572,0)
 ;;=F11.29^^237^2618^2
 ;;^UTILITY(U,$J,358.3,52572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52572,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,52572,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,52572,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,52573,0)
 ;;=F11.220^^237^2618^1
 ;;^UTILITY(U,$J,358.3,52573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52573,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,52573,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,52573,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,52574,0)
 ;;=F19.10^^237^2619^3
 ;;^UTILITY(U,$J,358.3,52574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52574,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
