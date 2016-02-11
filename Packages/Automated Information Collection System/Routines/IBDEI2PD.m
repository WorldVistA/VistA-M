IBDEI2PD ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,45358,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,45358,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,45358,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,45359,0)
 ;;=F11.222^^200^2242^38
 ;;^UTILITY(U,$J,358.3,45359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45359,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,45359,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,45359,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,45360,0)
 ;;=F11.221^^200^2242^37
 ;;^UTILITY(U,$J,358.3,45360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45360,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,45360,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,45360,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,45361,0)
 ;;=F11.220^^200^2242^39
 ;;^UTILITY(U,$J,358.3,45361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45361,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,45361,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,45361,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,45362,0)
 ;;=F14.29^^200^2242^21
 ;;^UTILITY(U,$J,358.3,45362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45362,1,3,0)
 ;;=3^Cocaine Dependence w/ Unspec Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,45362,1,4,0)
 ;;=4^F14.29
 ;;^UTILITY(U,$J,358.3,45362,2)
 ;;=^5003268
 ;;^UTILITY(U,$J,358.3,45363,0)
 ;;=F14.288^^200^2242^20
 ;;^UTILITY(U,$J,358.3,45363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45363,1,3,0)
 ;;=3^Cocaine Dependence w/ Other Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,45363,1,4,0)
 ;;=4^F14.288
 ;;^UTILITY(U,$J,358.3,45363,2)
 ;;=^5003267
 ;;^UTILITY(U,$J,358.3,45364,0)
 ;;=F14.282^^200^2242^14
 ;;^UTILITY(U,$J,358.3,45364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45364,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,45364,1,4,0)
 ;;=4^F14.282
 ;;^UTILITY(U,$J,358.3,45364,2)
 ;;=^5003266
 ;;^UTILITY(U,$J,358.3,45365,0)
 ;;=F14.281^^200^2242^15
 ;;^UTILITY(U,$J,358.3,45365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45365,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,45365,1,4,0)
 ;;=4^F14.281
 ;;^UTILITY(U,$J,358.3,45365,2)
 ;;=^5003265
 ;;^UTILITY(U,$J,358.3,45366,0)
 ;;=F14.280^^200^2242^12
 ;;^UTILITY(U,$J,358.3,45366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45366,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,45366,1,4,0)
 ;;=4^F14.280
 ;;^UTILITY(U,$J,358.3,45366,2)
 ;;=^5003264
 ;;^UTILITY(U,$J,358.3,45367,0)
 ;;=F14.259^^200^2242^11
 ;;^UTILITY(U,$J,358.3,45367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45367,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induc Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,45367,1,4,0)
 ;;=4^F14.259
 ;;^UTILITY(U,$J,358.3,45367,2)
 ;;=^5003263
 ;;^UTILITY(U,$J,358.3,45368,0)
 ;;=F14.251^^200^2242^10
 ;;^UTILITY(U,$J,358.3,45368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45368,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,45368,1,4,0)
 ;;=4^F14.251
 ;;^UTILITY(U,$J,358.3,45368,2)
 ;;=^5003262
 ;;^UTILITY(U,$J,358.3,45369,0)
 ;;=F14.250^^200^2242^9
 ;;^UTILITY(U,$J,358.3,45369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45369,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,45369,1,4,0)
 ;;=4^F14.250
 ;;^UTILITY(U,$J,358.3,45369,2)
 ;;=^5003261
 ;;^UTILITY(U,$J,358.3,45370,0)
 ;;=F14.24^^200^2242^13
 ;;^UTILITY(U,$J,358.3,45370,1,0)
 ;;=^358.31IA^4^2
