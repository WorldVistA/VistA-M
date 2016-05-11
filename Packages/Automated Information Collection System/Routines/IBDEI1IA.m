IBDEI1IA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25551,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25551,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,25551,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,25552,0)
 ;;=F11.122^^95^1169^16
 ;;^UTILITY(U,$J,358.3,25552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25552,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25552,1,4,0)
 ;;=4^F11.122
 ;;^UTILITY(U,$J,358.3,25552,2)
 ;;=^5003117
 ;;^UTILITY(U,$J,358.3,25553,0)
 ;;=F11.222^^95^1169^17
 ;;^UTILITY(U,$J,358.3,25553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25553,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25553,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,25553,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,25554,0)
 ;;=F11.922^^95^1169^18
 ;;^UTILITY(U,$J,358.3,25554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25554,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25554,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,25554,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,25555,0)
 ;;=F11.99^^95^1169^22
 ;;^UTILITY(U,$J,358.3,25555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25555,1,3,0)
 ;;=3^Opioid Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25555,1,4,0)
 ;;=4^F11.99
 ;;^UTILITY(U,$J,358.3,25555,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,25556,0)
 ;;=F19.10^^95^1170^3
 ;;^UTILITY(U,$J,358.3,25556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25556,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,25556,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,25556,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,25557,0)
 ;;=F19.14^^95^1170^1
 ;;^UTILITY(U,$J,358.3,25557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25557,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,25557,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,25557,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,25558,0)
 ;;=F19.182^^95^1170^2
 ;;^UTILITY(U,$J,358.3,25558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25558,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,25558,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,25558,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,25559,0)
 ;;=F19.20^^95^1170^6
 ;;^UTILITY(U,$J,358.3,25559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25559,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,25559,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,25559,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,25560,0)
 ;;=F19.21^^95^1170^5
 ;;^UTILITY(U,$J,358.3,25560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25560,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,25560,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,25560,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,25561,0)
 ;;=F19.24^^95^1170^4
 ;;^UTILITY(U,$J,358.3,25561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25561,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,25561,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,25561,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,25562,0)
 ;;=F13.10^^95^1171^1
 ;;^UTILITY(U,$J,358.3,25562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25562,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25562,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,25562,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,25563,0)
 ;;=F13.14^^95^1171^7
 ;;^UTILITY(U,$J,358.3,25563,1,0)
 ;;=^358.31IA^4^2
