IBDEI2PC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,45346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45346,1,3,0)
 ;;=3^Sprain of Lumbar Spine Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,45346,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,45346,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,45347,0)
 ;;=F10.20^^200^2242^4
 ;;^UTILITY(U,$J,358.3,45347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45347,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,45347,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,45347,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,45348,0)
 ;;=F11.29^^200^2242^46
 ;;^UTILITY(U,$J,358.3,45348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45348,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,45348,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,45348,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,45349,0)
 ;;=F11.288^^200^2242^45
 ;;^UTILITY(U,$J,358.3,45349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45349,1,3,0)
 ;;=3^Opioid Dependence w/ Other Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,45349,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,45349,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,45350,0)
 ;;=F11.282^^200^2242^44
 ;;^UTILITY(U,$J,358.3,45350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45350,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,45350,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,45350,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,45351,0)
 ;;=F11.281^^200^2242^43
 ;;^UTILITY(U,$J,358.3,45351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45351,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,45351,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,45351,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,45352,0)
 ;;=F11.259^^200^2242^42
 ;;^UTILITY(U,$J,358.3,45352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45352,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,45352,1,4,0)
 ;;=4^F11.259
 ;;^UTILITY(U,$J,358.3,45352,2)
 ;;=^5003137
 ;;^UTILITY(U,$J,358.3,45353,0)
 ;;=F11.251^^200^2242^35
 ;;^UTILITY(U,$J,358.3,45353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45353,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,45353,1,4,0)
 ;;=4^F11.251
 ;;^UTILITY(U,$J,358.3,45353,2)
 ;;=^5003136
 ;;^UTILITY(U,$J,358.3,45354,0)
 ;;=F11.250^^200^2242^36
 ;;^UTILITY(U,$J,358.3,45354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45354,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,45354,1,4,0)
 ;;=4^F11.250
 ;;^UTILITY(U,$J,358.3,45354,2)
 ;;=^5003135
 ;;^UTILITY(U,$J,358.3,45355,0)
 ;;=F11.24^^200^2242^41
 ;;^UTILITY(U,$J,358.3,45355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45355,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,45355,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,45355,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,45356,0)
 ;;=F11.23^^200^2242^47
 ;;^UTILITY(U,$J,358.3,45356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45356,1,3,0)
 ;;=3^Opioid Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,45356,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,45356,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,45357,0)
 ;;=F11.20^^200^2242^48
 ;;^UTILITY(U,$J,358.3,45357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45357,1,3,0)
 ;;=3^Opioid Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,45357,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,45357,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,45358,0)
 ;;=F11.229^^200^2242^40
 ;;^UTILITY(U,$J,358.3,45358,1,0)
 ;;=^358.31IA^4^2
