IBDEI34U ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52574,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,52574,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,52575,0)
 ;;=F19.14^^237^2619^1
 ;;^UTILITY(U,$J,358.3,52575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52575,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,52575,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,52575,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,52576,0)
 ;;=F19.182^^237^2619^2
 ;;^UTILITY(U,$J,358.3,52576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52576,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,52576,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,52576,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,52577,0)
 ;;=F19.20^^237^2619^6
 ;;^UTILITY(U,$J,358.3,52577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52577,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,52577,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,52577,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,52578,0)
 ;;=F19.21^^237^2619^5
 ;;^UTILITY(U,$J,358.3,52578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52578,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,52578,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,52578,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,52579,0)
 ;;=F19.24^^237^2619^4
 ;;^UTILITY(U,$J,358.3,52579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52579,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,52579,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,52579,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,52580,0)
 ;;=F13.10^^237^2620^1
 ;;^UTILITY(U,$J,358.3,52580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52580,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,52580,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,52580,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,52581,0)
 ;;=F13.14^^237^2620^7
 ;;^UTILITY(U,$J,358.3,52581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52581,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,52581,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,52581,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,52582,0)
 ;;=F13.182^^237^2620^8
 ;;^UTILITY(U,$J,358.3,52582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52582,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,52582,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,52582,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,52583,0)
 ;;=F13.20^^237^2620^2
 ;;^UTILITY(U,$J,358.3,52583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52583,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,52583,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,52583,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,52584,0)
 ;;=F13.21^^237^2620^3
 ;;^UTILITY(U,$J,358.3,52584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52584,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,52584,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,52584,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,52585,0)
 ;;=F13.232^^237^2620^4
 ;;^UTILITY(U,$J,358.3,52585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52585,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,52585,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,52585,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,52586,0)
 ;;=F13.239^^237^2620^5
 ;;^UTILITY(U,$J,358.3,52586,1,0)
 ;;=^358.31IA^4^2
