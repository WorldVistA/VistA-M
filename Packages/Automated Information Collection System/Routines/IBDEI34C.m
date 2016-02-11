IBDEI34C ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52344,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,52344,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,52345,0)
 ;;=G10.^^237^2592^21
 ;;^UTILITY(U,$J,358.3,52345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52345,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,52345,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,52345,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,52346,0)
 ;;=G90.3^^237^2592^25
 ;;^UTILITY(U,$J,358.3,52346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52346,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,52346,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,52346,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,52347,0)
 ;;=G91.2^^237^2592^26
 ;;^UTILITY(U,$J,358.3,52347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52347,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,52347,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,52347,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,52348,0)
 ;;=G91.2^^237^2592^27
 ;;^UTILITY(U,$J,358.3,52348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52348,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavorial Disturbances
 ;;^UTILITY(U,$J,358.3,52348,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,52348,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,52349,0)
 ;;=G30.8^^237^2592^2
 ;;^UTILITY(U,$J,358.3,52349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52349,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,52349,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,52349,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,52350,0)
 ;;=A81.89^^237^2592^6
 ;;^UTILITY(U,$J,358.3,52350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52350,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,52350,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,52350,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,52351,0)
 ;;=F19.97^^237^2592^35
 ;;^UTILITY(U,$J,358.3,52351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52351,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,52351,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,52351,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,52352,0)
 ;;=G20.^^237^2592^28
 ;;^UTILITY(U,$J,358.3,52352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52352,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,52352,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,52352,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,52353,0)
 ;;=G20.^^237^2592^29
 ;;^UTILITY(U,$J,358.3,52353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52353,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,52353,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,52353,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,52354,0)
 ;;=G23.1^^237^2592^34
 ;;^UTILITY(U,$J,358.3,52354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52354,1,3,0)
 ;;=3^Progressive Supranuclear Palsy
 ;;^UTILITY(U,$J,358.3,52354,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,52354,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,52355,0)
 ;;=F03.91^^237^2592^15
 ;;^UTILITY(U,$J,358.3,52355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52355,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,52355,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,52355,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,52356,0)
 ;;=F03.90^^237^2592^17
 ;;^UTILITY(U,$J,358.3,52356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52356,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,52356,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,52356,2)
 ;;=^5003050
