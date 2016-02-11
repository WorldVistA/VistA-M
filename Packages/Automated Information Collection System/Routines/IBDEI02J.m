IBDEI02J ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,419,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,419,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,420,0)
 ;;=F11.21^^3^53^6
 ;;^UTILITY(U,$J,358.3,420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,420,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,420,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,420,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,421,0)
 ;;=F11.23^^3^53^7
 ;;^UTILITY(U,$J,358.3,421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,421,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,421,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,421,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,422,0)
 ;;=F11.24^^3^53^9
 ;;^UTILITY(U,$J,358.3,422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,422,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,422,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,422,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,423,0)
 ;;=F11.29^^3^53^2
 ;;^UTILITY(U,$J,358.3,423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,423,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,423,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,423,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,424,0)
 ;;=F11.220^^3^53^1
 ;;^UTILITY(U,$J,358.3,424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,424,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,424,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,424,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,425,0)
 ;;=F19.10^^3^54^3
 ;;^UTILITY(U,$J,358.3,425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,425,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,425,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,425,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,426,0)
 ;;=F19.14^^3^54^1
 ;;^UTILITY(U,$J,358.3,426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,426,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,426,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,426,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,427,0)
 ;;=F19.182^^3^54^2
 ;;^UTILITY(U,$J,358.3,427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,427,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,427,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,427,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,428,0)
 ;;=F19.20^^3^54^6
 ;;^UTILITY(U,$J,358.3,428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,428,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,428,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,428,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,429,0)
 ;;=F19.21^^3^54^5
 ;;^UTILITY(U,$J,358.3,429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,429,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,429,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,429,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,430,0)
 ;;=F19.24^^3^54^4
 ;;^UTILITY(U,$J,358.3,430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,430,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,430,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,430,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,431,0)
 ;;=F13.10^^3^55^1
 ;;^UTILITY(U,$J,358.3,431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,431,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,431,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,431,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,432,0)
 ;;=F13.14^^3^55^7
 ;;^UTILITY(U,$J,358.3,432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,432,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
