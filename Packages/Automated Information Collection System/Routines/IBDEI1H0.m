IBDEI1H0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24969,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,24970,0)
 ;;=F19.20^^93^1121^6
 ;;^UTILITY(U,$J,358.3,24970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24970,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,24970,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,24970,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,24971,0)
 ;;=F19.21^^93^1121^5
 ;;^UTILITY(U,$J,358.3,24971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24971,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,24971,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,24971,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,24972,0)
 ;;=F19.24^^93^1121^4
 ;;^UTILITY(U,$J,358.3,24972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24972,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,24972,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,24972,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,24973,0)
 ;;=F13.10^^93^1122^1
 ;;^UTILITY(U,$J,358.3,24973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24973,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,24973,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,24973,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,24974,0)
 ;;=F13.14^^93^1122^7
 ;;^UTILITY(U,$J,358.3,24974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24974,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,24974,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,24974,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,24975,0)
 ;;=F13.182^^93^1122^8
 ;;^UTILITY(U,$J,358.3,24975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24975,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24975,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,24975,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,24976,0)
 ;;=F13.20^^93^1122^2
 ;;^UTILITY(U,$J,358.3,24976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24976,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,24976,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,24976,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,24977,0)
 ;;=F13.21^^93^1122^3
 ;;^UTILITY(U,$J,358.3,24977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24977,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,24977,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,24977,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,24978,0)
 ;;=F13.232^^93^1122^4
 ;;^UTILITY(U,$J,358.3,24978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24978,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,24978,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,24978,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,24979,0)
 ;;=F13.239^^93^1122^5
 ;;^UTILITY(U,$J,358.3,24979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24979,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,24979,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,24979,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,24980,0)
 ;;=F13.24^^93^1122^9
 ;;^UTILITY(U,$J,358.3,24980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24980,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,24980,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,24980,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,24981,0)
 ;;=F13.231^^93^1122^6
 ;;^UTILITY(U,$J,358.3,24981,1,0)
 ;;=^358.31IA^4^2
