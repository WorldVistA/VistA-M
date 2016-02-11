IBDEI19C ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21028,0)
 ;;=F19.21^^99^1012^5
 ;;^UTILITY(U,$J,358.3,21028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21028,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,21028,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,21028,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,21029,0)
 ;;=F19.24^^99^1012^4
 ;;^UTILITY(U,$J,358.3,21029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21029,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,21029,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,21029,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,21030,0)
 ;;=F13.10^^99^1013^1
 ;;^UTILITY(U,$J,358.3,21030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21030,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,21030,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,21030,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,21031,0)
 ;;=F13.14^^99^1013^7
 ;;^UTILITY(U,$J,358.3,21031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21031,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,21031,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,21031,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,21032,0)
 ;;=F13.182^^99^1013^8
 ;;^UTILITY(U,$J,358.3,21032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21032,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21032,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,21032,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,21033,0)
 ;;=F13.20^^99^1013^2
 ;;^UTILITY(U,$J,358.3,21033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21033,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,21033,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,21033,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,21034,0)
 ;;=F13.21^^99^1013^3
 ;;^UTILITY(U,$J,358.3,21034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21034,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,21034,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,21034,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,21035,0)
 ;;=F13.232^^99^1013^4
 ;;^UTILITY(U,$J,358.3,21035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21035,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,21035,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,21035,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,21036,0)
 ;;=F13.239^^99^1013^5
 ;;^UTILITY(U,$J,358.3,21036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21036,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,21036,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,21036,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,21037,0)
 ;;=F13.24^^99^1013^9
 ;;^UTILITY(U,$J,358.3,21037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21037,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,21037,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,21037,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,21038,0)
 ;;=F13.231^^99^1013^6
 ;;^UTILITY(U,$J,358.3,21038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21038,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,21038,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,21038,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,21039,0)
 ;;=F17.200^^99^1014^1
 ;;^UTILITY(U,$J,358.3,21039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21039,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe
