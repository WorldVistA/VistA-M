IBDEI19B ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21015,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,21015,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,21016,0)
 ;;=F11.14^^99^1011^8
 ;;^UTILITY(U,$J,358.3,21016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21016,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21016,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,21016,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,21017,0)
 ;;=F11.182^^99^1011^10
 ;;^UTILITY(U,$J,358.3,21017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21017,1,3,0)
 ;;=3^Opioid-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21017,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,21017,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,21018,0)
 ;;=F11.20^^99^1011^5
 ;;^UTILITY(U,$J,358.3,21018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21018,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,21018,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,21018,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,21019,0)
 ;;=F11.21^^99^1011^6
 ;;^UTILITY(U,$J,358.3,21019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21019,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,21019,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,21019,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,21020,0)
 ;;=F11.23^^99^1011^7
 ;;^UTILITY(U,$J,358.3,21020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21020,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,21020,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,21020,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,21021,0)
 ;;=F11.24^^99^1011^9
 ;;^UTILITY(U,$J,358.3,21021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21021,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21021,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,21021,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,21022,0)
 ;;=F11.29^^99^1011^2
 ;;^UTILITY(U,$J,358.3,21022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21022,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,21022,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,21022,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,21023,0)
 ;;=F11.220^^99^1011^1
 ;;^UTILITY(U,$J,358.3,21023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21023,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,21023,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,21023,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,21024,0)
 ;;=F19.10^^99^1012^3
 ;;^UTILITY(U,$J,358.3,21024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21024,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,21024,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,21024,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,21025,0)
 ;;=F19.14^^99^1012^1
 ;;^UTILITY(U,$J,358.3,21025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21025,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,21025,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,21025,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,21026,0)
 ;;=F19.182^^99^1012^2
 ;;^UTILITY(U,$J,358.3,21026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21026,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,21026,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,21026,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,21027,0)
 ;;=F19.20^^99^1012^6
 ;;^UTILITY(U,$J,358.3,21027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21027,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,21027,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,21027,2)
 ;;=^5003431
