IBDEI29H ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38354,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,38354,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,38354,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,38355,0)
 ;;=F11.929^^145^1858^21
 ;;^UTILITY(U,$J,358.3,38355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38355,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,38355,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,38355,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,38356,0)
 ;;=F11.122^^145^1858^16
 ;;^UTILITY(U,$J,358.3,38356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38356,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38356,1,4,0)
 ;;=4^F11.122
 ;;^UTILITY(U,$J,358.3,38356,2)
 ;;=^5003117
 ;;^UTILITY(U,$J,358.3,38357,0)
 ;;=F11.222^^145^1858^17
 ;;^UTILITY(U,$J,358.3,38357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38357,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,38357,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,38357,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,38358,0)
 ;;=F11.922^^145^1858^18
 ;;^UTILITY(U,$J,358.3,38358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38358,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,38358,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,38358,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,38359,0)
 ;;=F11.99^^145^1858^22
 ;;^UTILITY(U,$J,358.3,38359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38359,1,3,0)
 ;;=3^Opioid Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,38359,1,4,0)
 ;;=4^F11.99
 ;;^UTILITY(U,$J,358.3,38359,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,38360,0)
 ;;=F19.10^^145^1859^3
 ;;^UTILITY(U,$J,358.3,38360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38360,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38360,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,38360,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,38361,0)
 ;;=F19.14^^145^1859^1
 ;;^UTILITY(U,$J,358.3,38361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38361,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,38361,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,38361,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,38362,0)
 ;;=F19.182^^145^1859^2
 ;;^UTILITY(U,$J,358.3,38362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38362,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,38362,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,38362,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,38363,0)
 ;;=F19.20^^145^1859^6
 ;;^UTILITY(U,$J,358.3,38363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38363,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38363,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,38363,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,38364,0)
 ;;=F19.21^^145^1859^5
 ;;^UTILITY(U,$J,358.3,38364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38364,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,38364,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,38364,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,38365,0)
 ;;=F19.24^^145^1859^4
 ;;^UTILITY(U,$J,358.3,38365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38365,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,38365,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,38365,2)
 ;;=^5003441
