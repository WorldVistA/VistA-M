IBDEI2A8 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38325,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,38326,0)
 ;;=F11.182^^177^1944^10
 ;;^UTILITY(U,$J,358.3,38326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38326,1,3,0)
 ;;=3^Opioid-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38326,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,38326,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,38327,0)
 ;;=F11.20^^177^1944^5
 ;;^UTILITY(U,$J,358.3,38327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38327,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,38327,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,38327,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,38328,0)
 ;;=F11.21^^177^1944^6
 ;;^UTILITY(U,$J,358.3,38328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38328,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,38328,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,38328,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,38329,0)
 ;;=F11.23^^177^1944^7
 ;;^UTILITY(U,$J,358.3,38329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38329,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,38329,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,38329,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,38330,0)
 ;;=F11.24^^177^1944^9
 ;;^UTILITY(U,$J,358.3,38330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38330,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,38330,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,38330,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,38331,0)
 ;;=F11.29^^177^1944^2
 ;;^UTILITY(U,$J,358.3,38331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38331,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,38331,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,38331,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,38332,0)
 ;;=F11.220^^177^1944^1
 ;;^UTILITY(U,$J,358.3,38332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38332,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38332,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,38332,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,38333,0)
 ;;=F19.10^^177^1945^3
 ;;^UTILITY(U,$J,358.3,38333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38333,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38333,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,38333,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,38334,0)
 ;;=F19.14^^177^1945^1
 ;;^UTILITY(U,$J,358.3,38334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38334,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,38334,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,38334,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,38335,0)
 ;;=F19.182^^177^1945^2
 ;;^UTILITY(U,$J,358.3,38335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38335,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,38335,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,38335,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,38336,0)
 ;;=F19.20^^177^1945^6
 ;;^UTILITY(U,$J,358.3,38336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38336,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38336,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,38336,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,38337,0)
 ;;=F19.21^^177^1945^5
 ;;^UTILITY(U,$J,358.3,38337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38337,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,38337,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,38337,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,38338,0)
 ;;=F19.24^^177^1945^4
