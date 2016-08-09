IBDEI0X5 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33343,0)
 ;;=F11.20^^119^1578^48
 ;;^UTILITY(U,$J,358.3,33343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33343,1,3,0)
 ;;=3^Opioid Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,33343,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,33343,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,33344,0)
 ;;=F11.229^^119^1578^40
 ;;^UTILITY(U,$J,358.3,33344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33344,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,33344,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,33344,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,33345,0)
 ;;=F11.222^^119^1578^38
 ;;^UTILITY(U,$J,358.3,33345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33345,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,33345,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,33345,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,33346,0)
 ;;=F11.221^^119^1578^37
 ;;^UTILITY(U,$J,358.3,33346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33346,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,33346,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,33346,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,33347,0)
 ;;=F11.220^^119^1578^39
 ;;^UTILITY(U,$J,358.3,33347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33347,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,33347,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,33347,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,33348,0)
 ;;=F14.29^^119^1578^21
 ;;^UTILITY(U,$J,358.3,33348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33348,1,3,0)
 ;;=3^Cocaine Dependence w/ Unspec Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,33348,1,4,0)
 ;;=4^F14.29
 ;;^UTILITY(U,$J,358.3,33348,2)
 ;;=^5003268
 ;;^UTILITY(U,$J,358.3,33349,0)
 ;;=F14.288^^119^1578^20
 ;;^UTILITY(U,$J,358.3,33349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33349,1,3,0)
 ;;=3^Cocaine Dependence w/ Other Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,33349,1,4,0)
 ;;=4^F14.288
 ;;^UTILITY(U,$J,358.3,33349,2)
 ;;=^5003267
 ;;^UTILITY(U,$J,358.3,33350,0)
 ;;=F14.282^^119^1578^14
 ;;^UTILITY(U,$J,358.3,33350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33350,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,33350,1,4,0)
 ;;=4^F14.282
 ;;^UTILITY(U,$J,358.3,33350,2)
 ;;=^5003266
 ;;^UTILITY(U,$J,358.3,33351,0)
 ;;=F14.281^^119^1578^15
 ;;^UTILITY(U,$J,358.3,33351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33351,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,33351,1,4,0)
 ;;=4^F14.281
 ;;^UTILITY(U,$J,358.3,33351,2)
 ;;=^5003265
 ;;^UTILITY(U,$J,358.3,33352,0)
 ;;=F14.280^^119^1578^12
 ;;^UTILITY(U,$J,358.3,33352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33352,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,33352,1,4,0)
 ;;=4^F14.280
 ;;^UTILITY(U,$J,358.3,33352,2)
 ;;=^5003264
 ;;^UTILITY(U,$J,358.3,33353,0)
 ;;=F14.259^^119^1578^11
 ;;^UTILITY(U,$J,358.3,33353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33353,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induc Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,33353,1,4,0)
 ;;=4^F14.259
 ;;^UTILITY(U,$J,358.3,33353,2)
 ;;=^5003263
 ;;^UTILITY(U,$J,358.3,33354,0)
 ;;=F14.251^^119^1578^10
 ;;^UTILITY(U,$J,358.3,33354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33354,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,33354,1,4,0)
 ;;=4^F14.251
 ;;^UTILITY(U,$J,358.3,33354,2)
 ;;=^5003262
 ;;^UTILITY(U,$J,358.3,33355,0)
 ;;=F14.250^^119^1578^9
 ;;^UTILITY(U,$J,358.3,33355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33355,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,33355,1,4,0)
 ;;=4^F14.250
 ;;^UTILITY(U,$J,358.3,33355,2)
 ;;=^5003261
 ;;^UTILITY(U,$J,358.3,33356,0)
 ;;=F14.24^^119^1578^13
 ;;^UTILITY(U,$J,358.3,33356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33356,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,33356,1,4,0)
 ;;=4^F14.24
 ;;^UTILITY(U,$J,358.3,33356,2)
 ;;=^5003260
 ;;^UTILITY(U,$J,358.3,33357,0)
 ;;=F14.23^^119^1578^22
 ;;^UTILITY(U,$J,358.3,33357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33357,1,3,0)
 ;;=3^Cocaine Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,33357,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,33357,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,33358,0)
 ;;=F14.229^^119^1578^19
 ;;^UTILITY(U,$J,358.3,33358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33358,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,33358,1,4,0)
 ;;=4^F14.229
 ;;^UTILITY(U,$J,358.3,33358,2)
 ;;=^5003258
 ;;^UTILITY(U,$J,358.3,33359,0)
 ;;=F14.222^^119^1578^17
 ;;^UTILITY(U,$J,358.3,33359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33359,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,33359,1,4,0)
 ;;=4^F14.222
 ;;^UTILITY(U,$J,358.3,33359,2)
 ;;=^5003257
 ;;^UTILITY(U,$J,358.3,33360,0)
 ;;=F14.221^^119^1578^16
 ;;^UTILITY(U,$J,358.3,33360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33360,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,33360,1,4,0)
 ;;=4^F14.221
 ;;^UTILITY(U,$J,358.3,33360,2)
 ;;=^5003256
 ;;^UTILITY(U,$J,358.3,33361,0)
 ;;=F14.220^^119^1578^18
 ;;^UTILITY(U,$J,358.3,33361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33361,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,33361,1,4,0)
 ;;=4^F14.220
 ;;^UTILITY(U,$J,358.3,33361,2)
 ;;=^5003255
 ;;^UTILITY(U,$J,358.3,33362,0)
 ;;=F14.20^^119^1578^23
 ;;^UTILITY(U,$J,358.3,33362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33362,1,3,0)
 ;;=3^Cocaine Dependence,Uncompicated
 ;;^UTILITY(U,$J,358.3,33362,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,33362,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,33363,0)
 ;;=F10.120^^119^1578^1
 ;;^UTILITY(U,$J,358.3,33363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33363,1,3,0)
 ;;=3^Alcohol Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,33363,1,4,0)
 ;;=4^F10.120
 ;;^UTILITY(U,$J,358.3,33363,2)
 ;;=^5003069
 ;;^UTILITY(U,$J,358.3,33364,0)
 ;;=F10.10^^119^1578^2
 ;;^UTILITY(U,$J,358.3,33364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33364,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,33364,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,33364,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,33365,0)
 ;;=F17.201^^119^1578^28
 ;;^UTILITY(U,$J,358.3,33365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33365,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,33365,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,33365,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,33366,0)
 ;;=F17.210^^119^1578^27
 ;;^UTILITY(U,$J,358.3,33366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33366,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,33366,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,33366,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,33367,0)
 ;;=F17.291^^119^1578^29
 ;;^UTILITY(U,$J,358.3,33367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33367,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,33367,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,33367,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,33368,0)
 ;;=F17.290^^119^1578^30
 ;;^UTILITY(U,$J,358.3,33368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33368,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,33368,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,33368,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,33369,0)
 ;;=F17.221^^119^1578^24
 ;;^UTILITY(U,$J,358.3,33369,1,0)
 ;;=^358.31IA^4^2
