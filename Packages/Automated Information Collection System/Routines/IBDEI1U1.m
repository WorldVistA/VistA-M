IBDEI1U1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31118,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31118,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,31118,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,31119,0)
 ;;=F11.99^^123^1559^22
 ;;^UTILITY(U,$J,358.3,31119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31119,1,3,0)
 ;;=3^Opioid Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31119,1,4,0)
 ;;=4^F11.99
 ;;^UTILITY(U,$J,358.3,31119,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,31120,0)
 ;;=F19.10^^123^1560^3
 ;;^UTILITY(U,$J,358.3,31120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31120,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,31120,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,31120,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,31121,0)
 ;;=F19.14^^123^1560^1
 ;;^UTILITY(U,$J,358.3,31121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31121,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,31121,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,31121,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,31122,0)
 ;;=F19.182^^123^1560^2
 ;;^UTILITY(U,$J,358.3,31122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31122,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,31122,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,31122,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,31123,0)
 ;;=F19.20^^123^1560^6
 ;;^UTILITY(U,$J,358.3,31123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31123,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,31123,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,31123,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,31124,0)
 ;;=F19.21^^123^1560^5
 ;;^UTILITY(U,$J,358.3,31124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31124,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,31124,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,31124,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,31125,0)
 ;;=F19.24^^123^1560^4
 ;;^UTILITY(U,$J,358.3,31125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31125,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,31125,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,31125,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,31126,0)
 ;;=F13.10^^123^1561^1
 ;;^UTILITY(U,$J,358.3,31126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31126,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,31126,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,31126,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,31127,0)
 ;;=F13.14^^123^1561^7
 ;;^UTILITY(U,$J,358.3,31127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31127,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,31127,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,31127,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,31128,0)
 ;;=F13.182^^123^1561^8
 ;;^UTILITY(U,$J,358.3,31128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31128,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31128,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,31128,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,31129,0)
 ;;=F13.20^^123^1561^2
 ;;^UTILITY(U,$J,358.3,31129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31129,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,31129,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,31129,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,31130,0)
 ;;=F13.21^^123^1561^3
