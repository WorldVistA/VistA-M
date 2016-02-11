IBDEI1Z6 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33073,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,33073,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,33073,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,33074,0)
 ;;=F12.288^^146^1609^6
 ;;^UTILITY(U,$J,358.3,33074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33074,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,33074,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,33074,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,33075,0)
 ;;=F12.280^^146^1609^7
 ;;^UTILITY(U,$J,358.3,33075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33075,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,33075,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,33075,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,33076,0)
 ;;=F16.10^^146^1610^1
 ;;^UTILITY(U,$J,358.3,33076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33076,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,33076,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,33076,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,33077,0)
 ;;=F16.20^^146^1610^2
 ;;^UTILITY(U,$J,358.3,33077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33077,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,33077,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,33077,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,33078,0)
 ;;=F16.21^^146^1610^3
 ;;^UTILITY(U,$J,358.3,33078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33078,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,33078,1,4,0)
 ;;=4^F16.21
 ;;^UTILITY(U,$J,358.3,33078,2)
 ;;=^5003337
 ;;^UTILITY(U,$J,358.3,33079,0)
 ;;=F11.10^^146^1611^4
 ;;^UTILITY(U,$J,358.3,33079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33079,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,33079,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,33079,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,33080,0)
 ;;=F11.129^^146^1611^3
 ;;^UTILITY(U,$J,358.3,33080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33080,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances;Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,33080,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,33080,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,33081,0)
 ;;=F11.14^^146^1611^8
 ;;^UTILITY(U,$J,358.3,33081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33081,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,33081,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,33081,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,33082,0)
 ;;=F11.182^^146^1611^10
 ;;^UTILITY(U,$J,358.3,33082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33082,1,3,0)
 ;;=3^Opioid-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,33082,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,33082,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,33083,0)
 ;;=F11.20^^146^1611^5
 ;;^UTILITY(U,$J,358.3,33083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33083,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,33083,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,33083,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,33084,0)
 ;;=F11.21^^146^1611^6
 ;;^UTILITY(U,$J,358.3,33084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33084,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,33084,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,33084,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,33085,0)
 ;;=F11.23^^146^1611^7
 ;;^UTILITY(U,$J,358.3,33085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33085,1,3,0)
 ;;=3^Opioid Withdrawal
