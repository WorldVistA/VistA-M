IBDEI1L8 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26921,1,4,0)
 ;;=4^F11.121
 ;;^UTILITY(U,$J,358.3,26921,2)
 ;;=^5003116
 ;;^UTILITY(U,$J,358.3,26922,0)
 ;;=F11.221^^100^1295^14
 ;;^UTILITY(U,$J,358.3,26922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26922,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26922,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,26922,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,26923,0)
 ;;=F11.921^^100^1295^15
 ;;^UTILITY(U,$J,358.3,26923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26923,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26923,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,26923,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,26924,0)
 ;;=F11.229^^100^1295^20
 ;;^UTILITY(U,$J,358.3,26924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26924,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26924,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,26924,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,26925,0)
 ;;=F11.929^^100^1295^21
 ;;^UTILITY(U,$J,358.3,26925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26925,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26925,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,26925,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,26926,0)
 ;;=F11.122^^100^1295^16
 ;;^UTILITY(U,$J,358.3,26926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26926,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26926,1,4,0)
 ;;=4^F11.122
 ;;^UTILITY(U,$J,358.3,26926,2)
 ;;=^5003117
 ;;^UTILITY(U,$J,358.3,26927,0)
 ;;=F11.222^^100^1295^17
 ;;^UTILITY(U,$J,358.3,26927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26927,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26927,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,26927,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,26928,0)
 ;;=F11.922^^100^1295^18
 ;;^UTILITY(U,$J,358.3,26928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26928,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26928,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,26928,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,26929,0)
 ;;=F11.99^^100^1295^22
 ;;^UTILITY(U,$J,358.3,26929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26929,1,3,0)
 ;;=3^Opioid Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26929,1,4,0)
 ;;=4^F11.99
 ;;^UTILITY(U,$J,358.3,26929,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,26930,0)
 ;;=F19.10^^100^1296^3
 ;;^UTILITY(U,$J,358.3,26930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26930,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,26930,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,26930,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,26931,0)
 ;;=F19.14^^100^1296^1
 ;;^UTILITY(U,$J,358.3,26931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26931,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,26931,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,26931,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,26932,0)
 ;;=F19.182^^100^1296^2
 ;;^UTILITY(U,$J,358.3,26932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26932,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,26932,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,26932,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,26933,0)
 ;;=F19.20^^100^1296^6
 ;;^UTILITY(U,$J,358.3,26933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26933,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
