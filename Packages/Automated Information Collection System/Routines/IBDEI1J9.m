IBDEI1J9 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25623,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25623,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,25623,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,25624,0)
 ;;=F18.20^^124^1253^2
 ;;^UTILITY(U,$J,358.3,25624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25624,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,25624,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,25624,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,25625,0)
 ;;=F18.21^^124^1253^3
 ;;^UTILITY(U,$J,358.3,25625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25625,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,25625,1,4,0)
 ;;=4^F18.21
 ;;^UTILITY(U,$J,358.3,25625,2)
 ;;=^5003393
 ;;^UTILITY(U,$J,358.3,25626,0)
 ;;=F18.14^^124^1253^4
 ;;^UTILITY(U,$J,358.3,25626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25626,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25626,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,25626,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,25627,0)
 ;;=F18.24^^124^1253^5
 ;;^UTILITY(U,$J,358.3,25627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25627,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25627,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,25627,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,25628,0)
 ;;=F11.10^^124^1254^4
 ;;^UTILITY(U,$J,358.3,25628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25628,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25628,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,25628,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,25629,0)
 ;;=F11.129^^124^1254^3
 ;;^UTILITY(U,$J,358.3,25629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25629,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances;Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25629,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,25629,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,25630,0)
 ;;=F11.14^^124^1254^8
 ;;^UTILITY(U,$J,358.3,25630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25630,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25630,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,25630,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,25631,0)
 ;;=F11.182^^124^1254^10
 ;;^UTILITY(U,$J,358.3,25631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25631,1,3,0)
 ;;=3^Opioid-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25631,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,25631,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,25632,0)
 ;;=F11.20^^124^1254^5
 ;;^UTILITY(U,$J,358.3,25632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25632,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,25632,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,25632,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,25633,0)
 ;;=F11.21^^124^1254^6
 ;;^UTILITY(U,$J,358.3,25633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25633,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,25633,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,25633,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,25634,0)
 ;;=F11.23^^124^1254^7
 ;;^UTILITY(U,$J,358.3,25634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25634,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,25634,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,25634,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,25635,0)
 ;;=F11.24^^124^1254^9
 ;;^UTILITY(U,$J,358.3,25635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25635,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Moderate-Severe Use Disorder
