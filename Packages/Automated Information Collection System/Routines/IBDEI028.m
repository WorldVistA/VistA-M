IBDEI028 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,549,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,550,0)
 ;;=F19.21^^3^54^5
 ;;^UTILITY(U,$J,358.3,550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,550,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,550,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,550,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,551,0)
 ;;=F19.24^^3^54^4
 ;;^UTILITY(U,$J,358.3,551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,551,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,551,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,551,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,552,0)
 ;;=F13.10^^3^55^1
 ;;^UTILITY(U,$J,358.3,552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,552,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,552,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,552,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,553,0)
 ;;=F13.14^^3^55^7
 ;;^UTILITY(U,$J,358.3,553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,553,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,553,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,553,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,554,0)
 ;;=F13.182^^3^55^8
 ;;^UTILITY(U,$J,358.3,554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,554,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,554,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,554,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,555,0)
 ;;=F13.20^^3^55^2
 ;;^UTILITY(U,$J,358.3,555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,555,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,555,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,555,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,556,0)
 ;;=F13.21^^3^55^3
 ;;^UTILITY(U,$J,358.3,556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,556,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,556,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,556,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,557,0)
 ;;=F13.232^^3^55^4
 ;;^UTILITY(U,$J,358.3,557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,557,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,557,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,557,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,558,0)
 ;;=F13.239^^3^55^5
 ;;^UTILITY(U,$J,358.3,558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,558,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,558,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,558,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,559,0)
 ;;=F13.24^^3^55^9
 ;;^UTILITY(U,$J,358.3,559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,559,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,559,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,559,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,560,0)
 ;;=F13.231^^3^55^6
 ;;^UTILITY(U,$J,358.3,560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,560,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,560,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,560,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,561,0)
 ;;=F17.200^^3^56^9
 ;;^UTILITY(U,$J,358.3,561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,561,1,3,0)
 ;;=3^Nicotine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,561,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,561,2)
 ;;=^5003360
