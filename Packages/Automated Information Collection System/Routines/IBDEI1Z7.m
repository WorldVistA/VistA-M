IBDEI1Z7 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33085,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,33085,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,33086,0)
 ;;=F11.24^^146^1611^9
 ;;^UTILITY(U,$J,358.3,33086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33086,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,33086,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,33086,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,33087,0)
 ;;=F11.29^^146^1611^2
 ;;^UTILITY(U,$J,358.3,33087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33087,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,33087,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,33087,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,33088,0)
 ;;=F11.220^^146^1611^1
 ;;^UTILITY(U,$J,358.3,33088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33088,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,33088,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,33088,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,33089,0)
 ;;=F19.10^^146^1612^3
 ;;^UTILITY(U,$J,358.3,33089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33089,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,33089,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,33089,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,33090,0)
 ;;=F19.14^^146^1612^1
 ;;^UTILITY(U,$J,358.3,33090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33090,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,33090,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,33090,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,33091,0)
 ;;=F19.182^^146^1612^2
 ;;^UTILITY(U,$J,358.3,33091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33091,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,33091,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,33091,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,33092,0)
 ;;=F19.20^^146^1612^6
 ;;^UTILITY(U,$J,358.3,33092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33092,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,33092,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,33092,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,33093,0)
 ;;=F19.21^^146^1612^5
 ;;^UTILITY(U,$J,358.3,33093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33093,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,33093,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,33093,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,33094,0)
 ;;=F19.24^^146^1612^4
 ;;^UTILITY(U,$J,358.3,33094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33094,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,33094,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,33094,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,33095,0)
 ;;=F13.10^^146^1613^1
 ;;^UTILITY(U,$J,358.3,33095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33095,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,33095,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,33095,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,33096,0)
 ;;=F13.14^^146^1613^7
 ;;^UTILITY(U,$J,358.3,33096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33096,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,33096,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,33096,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,33097,0)
 ;;=F13.182^^146^1613^8
 ;;^UTILITY(U,$J,358.3,33097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33097,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
