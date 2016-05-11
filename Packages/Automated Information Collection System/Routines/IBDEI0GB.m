IBDEI0GB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7541,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,7541,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,7541,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,7542,0)
 ;;=F11.259^^30^410^42
 ;;^UTILITY(U,$J,358.3,7542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7542,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,7542,1,4,0)
 ;;=4^F11.259
 ;;^UTILITY(U,$J,358.3,7542,2)
 ;;=^5003137
 ;;^UTILITY(U,$J,358.3,7543,0)
 ;;=F11.251^^30^410^35
 ;;^UTILITY(U,$J,358.3,7543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7543,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,7543,1,4,0)
 ;;=4^F11.251
 ;;^UTILITY(U,$J,358.3,7543,2)
 ;;=^5003136
 ;;^UTILITY(U,$J,358.3,7544,0)
 ;;=F11.250^^30^410^36
 ;;^UTILITY(U,$J,358.3,7544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7544,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,7544,1,4,0)
 ;;=4^F11.250
 ;;^UTILITY(U,$J,358.3,7544,2)
 ;;=^5003135
 ;;^UTILITY(U,$J,358.3,7545,0)
 ;;=F11.24^^30^410^41
 ;;^UTILITY(U,$J,358.3,7545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7545,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,7545,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,7545,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,7546,0)
 ;;=F11.23^^30^410^47
 ;;^UTILITY(U,$J,358.3,7546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7546,1,3,0)
 ;;=3^Opioid Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,7546,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,7546,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,7547,0)
 ;;=F11.20^^30^410^48
 ;;^UTILITY(U,$J,358.3,7547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7547,1,3,0)
 ;;=3^Opioid Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7547,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,7547,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,7548,0)
 ;;=F11.229^^30^410^40
 ;;^UTILITY(U,$J,358.3,7548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7548,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,7548,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,7548,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,7549,0)
 ;;=F11.222^^30^410^38
 ;;^UTILITY(U,$J,358.3,7549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7549,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,7549,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,7549,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,7550,0)
 ;;=F11.221^^30^410^37
 ;;^UTILITY(U,$J,358.3,7550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7550,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,7550,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,7550,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,7551,0)
 ;;=F11.220^^30^410^39
 ;;^UTILITY(U,$J,358.3,7551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7551,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7551,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,7551,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,7552,0)
 ;;=F14.29^^30^410^21
 ;;^UTILITY(U,$J,358.3,7552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7552,1,3,0)
 ;;=3^Cocaine Dependence w/ Unspec Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,7552,1,4,0)
 ;;=4^F14.29
 ;;^UTILITY(U,$J,358.3,7552,2)
 ;;=^5003268
 ;;^UTILITY(U,$J,358.3,7553,0)
 ;;=F14.288^^30^410^20
 ;;^UTILITY(U,$J,358.3,7553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7553,1,3,0)
 ;;=3^Cocaine Dependence w/ Other Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,7553,1,4,0)
 ;;=4^F14.288
