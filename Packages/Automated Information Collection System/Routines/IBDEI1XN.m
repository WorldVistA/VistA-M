IBDEI1XN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32356,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,32356,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,32357,0)
 ;;=B20.^^143^1521^19
 ;;^UTILITY(U,$J,358.3,32357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32357,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,32357,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,32357,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,32358,0)
 ;;=G10.^^143^1521^20
 ;;^UTILITY(U,$J,358.3,32358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32358,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,32358,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,32358,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,32359,0)
 ;;=G10.^^143^1521^21
 ;;^UTILITY(U,$J,358.3,32359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32359,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,32359,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,32359,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,32360,0)
 ;;=G90.3^^143^1521^25
 ;;^UTILITY(U,$J,358.3,32360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32360,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,32360,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,32360,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,32361,0)
 ;;=G91.2^^143^1521^26
 ;;^UTILITY(U,$J,358.3,32361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32361,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,32361,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,32361,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,32362,0)
 ;;=G91.2^^143^1521^27
 ;;^UTILITY(U,$J,358.3,32362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32362,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavorial Disturbances
 ;;^UTILITY(U,$J,358.3,32362,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,32362,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,32363,0)
 ;;=G30.8^^143^1521^2
 ;;^UTILITY(U,$J,358.3,32363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32363,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,32363,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,32363,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,32364,0)
 ;;=A81.89^^143^1521^6
 ;;^UTILITY(U,$J,358.3,32364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32364,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,32364,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,32364,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,32365,0)
 ;;=F19.97^^143^1521^35
 ;;^UTILITY(U,$J,358.3,32365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32365,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,32365,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,32365,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,32366,0)
 ;;=G20.^^143^1521^28
 ;;^UTILITY(U,$J,358.3,32366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32366,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,32366,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,32366,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,32367,0)
 ;;=G20.^^143^1521^29
 ;;^UTILITY(U,$J,358.3,32367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32367,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,32367,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,32367,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,32368,0)
 ;;=G23.1^^143^1521^34
 ;;^UTILITY(U,$J,358.3,32368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32368,1,3,0)
 ;;=3^Progressive Supranuclear Palsy
 ;;^UTILITY(U,$J,358.3,32368,1,4,0)
 ;;=4^G23.1
