IBDEI081 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3262,0)
 ;;=F12.21^^8^114^5
 ;;^UTILITY(U,$J,358.3,3262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3262,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,3262,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,3262,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,3263,0)
 ;;=F12.288^^8^114^6
 ;;^UTILITY(U,$J,358.3,3263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3263,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,3263,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,3263,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,3264,0)
 ;;=F12.280^^8^114^7
 ;;^UTILITY(U,$J,358.3,3264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3264,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,3264,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,3264,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,3265,0)
 ;;=F16.10^^8^115^1
 ;;^UTILITY(U,$J,358.3,3265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3265,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,3265,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,3265,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,3266,0)
 ;;=F16.20^^8^115^2
 ;;^UTILITY(U,$J,358.3,3266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3266,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,3266,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,3266,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,3267,0)
 ;;=F16.21^^8^115^3
 ;;^UTILITY(U,$J,358.3,3267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3267,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,3267,1,4,0)
 ;;=4^F16.21
 ;;^UTILITY(U,$J,358.3,3267,2)
 ;;=^5003337
 ;;^UTILITY(U,$J,358.3,3268,0)
 ;;=F11.10^^8^116^3
 ;;^UTILITY(U,$J,358.3,3268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3268,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,3268,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,3268,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,3269,0)
 ;;=F11.129^^8^116^2
 ;;^UTILITY(U,$J,358.3,3269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3269,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances;Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,3269,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,3269,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,3270,0)
 ;;=F11.14^^8^116^7
 ;;^UTILITY(U,$J,358.3,3270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3270,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,3270,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,3270,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,3271,0)
 ;;=F11.182^^8^116^9
 ;;^UTILITY(U,$J,358.3,3271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3271,1,3,0)
 ;;=3^Opioid-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,3271,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,3271,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,3272,0)
 ;;=F11.20^^8^116^4
 ;;^UTILITY(U,$J,358.3,3272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3272,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,3272,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,3272,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,3273,0)
 ;;=F11.21^^8^116^5
 ;;^UTILITY(U,$J,358.3,3273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3273,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,3273,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,3273,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,3274,0)
 ;;=F11.23^^8^116^6
 ;;^UTILITY(U,$J,358.3,3274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3274,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,3274,1,4,0)
 ;;=4^F11.23
