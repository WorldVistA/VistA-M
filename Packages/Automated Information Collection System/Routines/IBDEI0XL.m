IBDEI0XL ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15751,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,15751,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,15751,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,15752,0)
 ;;=F19.24^^58^689^4
 ;;^UTILITY(U,$J,358.3,15752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15752,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,15752,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,15752,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,15753,0)
 ;;=F13.10^^58^690^1
 ;;^UTILITY(U,$J,358.3,15753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15753,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,15753,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,15753,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,15754,0)
 ;;=F13.14^^58^690^7
 ;;^UTILITY(U,$J,358.3,15754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15754,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,15754,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,15754,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,15755,0)
 ;;=F13.182^^58^690^8
 ;;^UTILITY(U,$J,358.3,15755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15755,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15755,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,15755,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,15756,0)
 ;;=F13.20^^58^690^2
 ;;^UTILITY(U,$J,358.3,15756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15756,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,15756,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,15756,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,15757,0)
 ;;=F13.21^^58^690^3
 ;;^UTILITY(U,$J,358.3,15757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15757,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,15757,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,15757,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,15758,0)
 ;;=F13.232^^58^690^4
 ;;^UTILITY(U,$J,358.3,15758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15758,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,15758,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,15758,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,15759,0)
 ;;=F13.239^^58^690^5
 ;;^UTILITY(U,$J,358.3,15759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15759,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,15759,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,15759,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,15760,0)
 ;;=F13.24^^58^690^9
 ;;^UTILITY(U,$J,358.3,15760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15760,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,15760,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,15760,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,15761,0)
 ;;=F13.231^^58^690^6
 ;;^UTILITY(U,$J,358.3,15761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15761,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,15761,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,15761,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,15762,0)
 ;;=F17.200^^58^691^9
 ;;^UTILITY(U,$J,358.3,15762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15762,1,3,0)
 ;;=3^Nicotine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,15762,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,15762,2)
 ;;=^5003360
