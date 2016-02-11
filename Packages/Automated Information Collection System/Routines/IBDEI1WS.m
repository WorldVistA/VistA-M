IBDEI1WS ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31963,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,31963,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,31964,0)
 ;;=G10.^^141^1478^20
 ;;^UTILITY(U,$J,358.3,31964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31964,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,31964,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,31964,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,31965,0)
 ;;=G10.^^141^1478^21
 ;;^UTILITY(U,$J,358.3,31965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31965,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,31965,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,31965,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,31966,0)
 ;;=G90.3^^141^1478^25
 ;;^UTILITY(U,$J,358.3,31966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31966,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,31966,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,31966,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,31967,0)
 ;;=G91.2^^141^1478^26
 ;;^UTILITY(U,$J,358.3,31967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31967,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,31967,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,31967,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,31968,0)
 ;;=G91.2^^141^1478^27
 ;;^UTILITY(U,$J,358.3,31968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31968,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavorial Disturbances
 ;;^UTILITY(U,$J,358.3,31968,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,31968,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,31969,0)
 ;;=G30.8^^141^1478^2
 ;;^UTILITY(U,$J,358.3,31969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31969,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,31969,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,31969,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,31970,0)
 ;;=A81.89^^141^1478^6
 ;;^UTILITY(U,$J,358.3,31970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31970,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,31970,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,31970,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,31971,0)
 ;;=F19.97^^141^1478^35
 ;;^UTILITY(U,$J,358.3,31971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31971,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,31971,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,31971,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,31972,0)
 ;;=G20.^^141^1478^28
 ;;^UTILITY(U,$J,358.3,31972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31972,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,31972,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,31972,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,31973,0)
 ;;=G20.^^141^1478^29
 ;;^UTILITY(U,$J,358.3,31973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31973,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,31973,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,31973,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,31974,0)
 ;;=G23.1^^141^1478^34
 ;;^UTILITY(U,$J,358.3,31974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31974,1,3,0)
 ;;=3^Progressive Supranuclear Palsy
 ;;^UTILITY(U,$J,358.3,31974,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,31974,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,31975,0)
 ;;=F03.91^^141^1478^15
 ;;^UTILITY(U,$J,358.3,31975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31975,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,31975,1,4,0)
 ;;=4^F03.91
