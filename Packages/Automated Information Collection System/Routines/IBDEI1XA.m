IBDEI1XA ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32194,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,32194,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,32195,0)
 ;;=F19.14^^141^1505^1
 ;;^UTILITY(U,$J,358.3,32195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32195,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,32195,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,32195,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,32196,0)
 ;;=F19.182^^141^1505^2
 ;;^UTILITY(U,$J,358.3,32196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32196,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,32196,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,32196,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,32197,0)
 ;;=F19.20^^141^1505^6
 ;;^UTILITY(U,$J,358.3,32197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32197,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,32197,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,32197,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,32198,0)
 ;;=F19.21^^141^1505^5
 ;;^UTILITY(U,$J,358.3,32198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32198,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,32198,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,32198,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,32199,0)
 ;;=F19.24^^141^1505^4
 ;;^UTILITY(U,$J,358.3,32199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32199,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,32199,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,32199,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,32200,0)
 ;;=F13.10^^141^1506^1
 ;;^UTILITY(U,$J,358.3,32200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32200,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,32200,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,32200,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,32201,0)
 ;;=F13.14^^141^1506^7
 ;;^UTILITY(U,$J,358.3,32201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32201,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,32201,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,32201,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,32202,0)
 ;;=F13.182^^141^1506^8
 ;;^UTILITY(U,$J,358.3,32202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32202,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,32202,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,32202,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,32203,0)
 ;;=F13.20^^141^1506^2
 ;;^UTILITY(U,$J,358.3,32203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32203,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,32203,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,32203,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,32204,0)
 ;;=F13.21^^141^1506^3
 ;;^UTILITY(U,$J,358.3,32204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32204,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,32204,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,32204,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,32205,0)
 ;;=F13.232^^141^1506^4
 ;;^UTILITY(U,$J,358.3,32205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32205,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,32205,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,32205,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,32206,0)
 ;;=F13.239^^141^1506^5
 ;;^UTILITY(U,$J,358.3,32206,1,0)
 ;;=^358.31IA^4^2
