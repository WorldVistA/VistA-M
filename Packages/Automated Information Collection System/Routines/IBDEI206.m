IBDEI206 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33537,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,33537,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,33538,0)
 ;;=F19.14^^148^1662^1
 ;;^UTILITY(U,$J,358.3,33538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33538,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,33538,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,33538,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,33539,0)
 ;;=F19.182^^148^1662^2
 ;;^UTILITY(U,$J,358.3,33539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33539,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,33539,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,33539,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,33540,0)
 ;;=F19.20^^148^1662^6
 ;;^UTILITY(U,$J,358.3,33540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33540,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,33540,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,33540,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,33541,0)
 ;;=F19.21^^148^1662^5
 ;;^UTILITY(U,$J,358.3,33541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33541,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,33541,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,33541,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,33542,0)
 ;;=F19.24^^148^1662^4
 ;;^UTILITY(U,$J,358.3,33542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33542,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,33542,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,33542,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,33543,0)
 ;;=F13.10^^148^1663^1
 ;;^UTILITY(U,$J,358.3,33543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33543,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,33543,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,33543,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,33544,0)
 ;;=F13.14^^148^1663^7
 ;;^UTILITY(U,$J,358.3,33544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33544,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,33544,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,33544,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,33545,0)
 ;;=F13.182^^148^1663^8
 ;;^UTILITY(U,$J,358.3,33545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33545,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,33545,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,33545,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,33546,0)
 ;;=F13.20^^148^1663^2
 ;;^UTILITY(U,$J,358.3,33546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33546,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,33546,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,33546,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,33547,0)
 ;;=F13.21^^148^1663^3
 ;;^UTILITY(U,$J,358.3,33547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33547,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,33547,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,33547,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,33548,0)
 ;;=F13.232^^148^1663^4
 ;;^UTILITY(U,$J,358.3,33548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33548,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,33548,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,33548,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,33549,0)
 ;;=F13.239^^148^1663^5
 ;;^UTILITY(U,$J,358.3,33549,1,0)
 ;;=^358.31IA^4^2
