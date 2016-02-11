IBDEI3BV ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,55920,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,55920,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,55920,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,55921,0)
 ;;=F11.259^^256^2789^42
 ;;^UTILITY(U,$J,358.3,55921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55921,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,55921,1,4,0)
 ;;=4^F11.259
 ;;^UTILITY(U,$J,358.3,55921,2)
 ;;=^5003137
 ;;^UTILITY(U,$J,358.3,55922,0)
 ;;=F11.251^^256^2789^35
 ;;^UTILITY(U,$J,358.3,55922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55922,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,55922,1,4,0)
 ;;=4^F11.251
 ;;^UTILITY(U,$J,358.3,55922,2)
 ;;=^5003136
 ;;^UTILITY(U,$J,358.3,55923,0)
 ;;=F11.250^^256^2789^36
 ;;^UTILITY(U,$J,358.3,55923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55923,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,55923,1,4,0)
 ;;=4^F11.250
 ;;^UTILITY(U,$J,358.3,55923,2)
 ;;=^5003135
 ;;^UTILITY(U,$J,358.3,55924,0)
 ;;=F11.24^^256^2789^41
 ;;^UTILITY(U,$J,358.3,55924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55924,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,55924,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,55924,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,55925,0)
 ;;=F11.23^^256^2789^47
 ;;^UTILITY(U,$J,358.3,55925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55925,1,3,0)
 ;;=3^Opioid Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,55925,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,55925,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,55926,0)
 ;;=F11.20^^256^2789^48
 ;;^UTILITY(U,$J,358.3,55926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55926,1,3,0)
 ;;=3^Opioid Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,55926,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,55926,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,55927,0)
 ;;=F11.229^^256^2789^40
 ;;^UTILITY(U,$J,358.3,55927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55927,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,55927,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,55927,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,55928,0)
 ;;=F11.222^^256^2789^38
 ;;^UTILITY(U,$J,358.3,55928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55928,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,55928,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,55928,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,55929,0)
 ;;=F11.221^^256^2789^37
 ;;^UTILITY(U,$J,358.3,55929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55929,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,55929,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,55929,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,55930,0)
 ;;=F11.220^^256^2789^39
 ;;^UTILITY(U,$J,358.3,55930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55930,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,55930,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,55930,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,55931,0)
 ;;=F14.29^^256^2789^21
 ;;^UTILITY(U,$J,358.3,55931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55931,1,3,0)
 ;;=3^Cocaine Dependence w/ Unspec Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,55931,1,4,0)
 ;;=4^F14.29
 ;;^UTILITY(U,$J,358.3,55931,2)
 ;;=^5003268
 ;;^UTILITY(U,$J,358.3,55932,0)
 ;;=F14.288^^256^2789^20
 ;;^UTILITY(U,$J,358.3,55932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55932,1,3,0)
 ;;=3^Cocaine Dependence w/ Other Cocaine-Induced Disorder
