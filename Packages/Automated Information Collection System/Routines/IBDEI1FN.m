IBDEI1FN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24345,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,24345,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,24346,0)
 ;;=F11.122^^90^1065^16
 ;;^UTILITY(U,$J,358.3,24346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24346,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24346,1,4,0)
 ;;=4^F11.122
 ;;^UTILITY(U,$J,358.3,24346,2)
 ;;=^5003117
 ;;^UTILITY(U,$J,358.3,24347,0)
 ;;=F11.222^^90^1065^17
 ;;^UTILITY(U,$J,358.3,24347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24347,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24347,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,24347,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,24348,0)
 ;;=F11.922^^90^1065^18
 ;;^UTILITY(U,$J,358.3,24348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24348,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24348,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,24348,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,24349,0)
 ;;=F11.99^^90^1065^22
 ;;^UTILITY(U,$J,358.3,24349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24349,1,3,0)
 ;;=3^Opioid Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24349,1,4,0)
 ;;=4^F11.99
 ;;^UTILITY(U,$J,358.3,24349,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,24350,0)
 ;;=F19.10^^90^1066^3
 ;;^UTILITY(U,$J,358.3,24350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24350,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,24350,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,24350,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,24351,0)
 ;;=F19.14^^90^1066^1
 ;;^UTILITY(U,$J,358.3,24351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24351,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,24351,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,24351,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,24352,0)
 ;;=F19.182^^90^1066^2
 ;;^UTILITY(U,$J,358.3,24352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24352,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,24352,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,24352,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,24353,0)
 ;;=F19.20^^90^1066^6
 ;;^UTILITY(U,$J,358.3,24353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24353,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,24353,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,24353,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,24354,0)
 ;;=F19.21^^90^1066^5
 ;;^UTILITY(U,$J,358.3,24354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24354,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,24354,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,24354,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,24355,0)
 ;;=F19.24^^90^1066^4
 ;;^UTILITY(U,$J,358.3,24355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24355,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,24355,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,24355,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,24356,0)
 ;;=F13.10^^90^1067^1
 ;;^UTILITY(U,$J,358.3,24356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24356,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,24356,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,24356,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,24357,0)
 ;;=F13.14^^90^1067^7
 ;;^UTILITY(U,$J,358.3,24357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24357,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
