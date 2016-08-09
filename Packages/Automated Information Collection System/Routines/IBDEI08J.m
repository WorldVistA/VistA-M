IBDEI08J ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8483,1,3,0)
 ;;=3^Sprain of Lumbar Spine Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,8483,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,8483,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,8484,0)
 ;;=S13.4XXA^^42^511^1
 ;;^UTILITY(U,$J,358.3,8484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8484,1,3,0)
 ;;=3^Sprain of Cervical Spine Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,8484,1,4,0)
 ;;=4^S13.4XXA
 ;;^UTILITY(U,$J,358.3,8484,2)
 ;;=^5022028
 ;;^UTILITY(U,$J,358.3,8485,0)
 ;;=F10.20^^42^512^4
 ;;^UTILITY(U,$J,358.3,8485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8485,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,8485,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,8485,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,8486,0)
 ;;=F11.29^^42^512^46
 ;;^UTILITY(U,$J,358.3,8486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8486,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,8486,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,8486,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,8487,0)
 ;;=F11.288^^42^512^45
 ;;^UTILITY(U,$J,358.3,8487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8487,1,3,0)
 ;;=3^Opioid Dependence w/ Other Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,8487,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,8487,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,8488,0)
 ;;=F11.282^^42^512^44
 ;;^UTILITY(U,$J,358.3,8488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8488,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,8488,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,8488,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,8489,0)
 ;;=F11.281^^42^512^43
 ;;^UTILITY(U,$J,358.3,8489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8489,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,8489,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,8489,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,8490,0)
 ;;=F11.259^^42^512^42
 ;;^UTILITY(U,$J,358.3,8490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8490,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,8490,1,4,0)
 ;;=4^F11.259
 ;;^UTILITY(U,$J,358.3,8490,2)
 ;;=^5003137
 ;;^UTILITY(U,$J,358.3,8491,0)
 ;;=F11.251^^42^512^35
 ;;^UTILITY(U,$J,358.3,8491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8491,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,8491,1,4,0)
 ;;=4^F11.251
 ;;^UTILITY(U,$J,358.3,8491,2)
 ;;=^5003136
 ;;^UTILITY(U,$J,358.3,8492,0)
 ;;=F11.250^^42^512^36
 ;;^UTILITY(U,$J,358.3,8492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8492,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,8492,1,4,0)
 ;;=4^F11.250
 ;;^UTILITY(U,$J,358.3,8492,2)
 ;;=^5003135
 ;;^UTILITY(U,$J,358.3,8493,0)
 ;;=F11.24^^42^512^41
 ;;^UTILITY(U,$J,358.3,8493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8493,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,8493,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,8493,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,8494,0)
 ;;=F11.23^^42^512^47
 ;;^UTILITY(U,$J,358.3,8494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8494,1,3,0)
 ;;=3^Opioid Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,8494,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,8494,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,8495,0)
 ;;=F11.20^^42^512^48
 ;;^UTILITY(U,$J,358.3,8495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8495,1,3,0)
 ;;=3^Opioid Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,8495,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,8495,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,8496,0)
 ;;=F11.229^^42^512^40
 ;;^UTILITY(U,$J,358.3,8496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8496,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,8496,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,8496,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,8497,0)
 ;;=F11.222^^42^512^38
 ;;^UTILITY(U,$J,358.3,8497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8497,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,8497,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,8497,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,8498,0)
 ;;=F11.221^^42^512^37
 ;;^UTILITY(U,$J,358.3,8498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8498,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,8498,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,8498,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,8499,0)
 ;;=F11.220^^42^512^39
 ;;^UTILITY(U,$J,358.3,8499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8499,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,8499,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,8499,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,8500,0)
 ;;=F14.29^^42^512^21
 ;;^UTILITY(U,$J,358.3,8500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8500,1,3,0)
 ;;=3^Cocaine Dependence w/ Unspec Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,8500,1,4,0)
 ;;=4^F14.29
 ;;^UTILITY(U,$J,358.3,8500,2)
 ;;=^5003268
 ;;^UTILITY(U,$J,358.3,8501,0)
 ;;=F14.288^^42^512^20
 ;;^UTILITY(U,$J,358.3,8501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8501,1,3,0)
 ;;=3^Cocaine Dependence w/ Other Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,8501,1,4,0)
 ;;=4^F14.288
 ;;^UTILITY(U,$J,358.3,8501,2)
 ;;=^5003267
 ;;^UTILITY(U,$J,358.3,8502,0)
 ;;=F14.282^^42^512^14
 ;;^UTILITY(U,$J,358.3,8502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8502,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,8502,1,4,0)
 ;;=4^F14.282
 ;;^UTILITY(U,$J,358.3,8502,2)
 ;;=^5003266
 ;;^UTILITY(U,$J,358.3,8503,0)
 ;;=F14.281^^42^512^15
 ;;^UTILITY(U,$J,358.3,8503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8503,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,8503,1,4,0)
 ;;=4^F14.281
 ;;^UTILITY(U,$J,358.3,8503,2)
 ;;=^5003265
 ;;^UTILITY(U,$J,358.3,8504,0)
 ;;=F14.280^^42^512^12
 ;;^UTILITY(U,$J,358.3,8504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8504,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,8504,1,4,0)
 ;;=4^F14.280
 ;;^UTILITY(U,$J,358.3,8504,2)
 ;;=^5003264
 ;;^UTILITY(U,$J,358.3,8505,0)
 ;;=F14.259^^42^512^11
 ;;^UTILITY(U,$J,358.3,8505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8505,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induc Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,8505,1,4,0)
 ;;=4^F14.259
 ;;^UTILITY(U,$J,358.3,8505,2)
 ;;=^5003263
 ;;^UTILITY(U,$J,358.3,8506,0)
 ;;=F14.251^^42^512^10
 ;;^UTILITY(U,$J,358.3,8506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8506,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,8506,1,4,0)
 ;;=4^F14.251
 ;;^UTILITY(U,$J,358.3,8506,2)
 ;;=^5003262
 ;;^UTILITY(U,$J,358.3,8507,0)
 ;;=F14.250^^42^512^9
 ;;^UTILITY(U,$J,358.3,8507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8507,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,8507,1,4,0)
 ;;=4^F14.250
 ;;^UTILITY(U,$J,358.3,8507,2)
 ;;=^5003261
 ;;^UTILITY(U,$J,358.3,8508,0)
 ;;=F14.24^^42^512^13
 ;;^UTILITY(U,$J,358.3,8508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8508,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,8508,1,4,0)
 ;;=4^F14.24
 ;;^UTILITY(U,$J,358.3,8508,2)
 ;;=^5003260
 ;;^UTILITY(U,$J,358.3,8509,0)
 ;;=F14.23^^42^512^22
 ;;^UTILITY(U,$J,358.3,8509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8509,1,3,0)
 ;;=3^Cocaine Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,8509,1,4,0)
 ;;=4^F14.23
