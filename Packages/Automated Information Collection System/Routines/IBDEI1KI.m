IBDEI1KI ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26593,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,26593,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,26594,0)
 ;;=G10.^^100^1269^20
 ;;^UTILITY(U,$J,358.3,26594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26594,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,26594,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,26594,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,26595,0)
 ;;=G10.^^100^1269^21
 ;;^UTILITY(U,$J,358.3,26595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26595,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,26595,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,26595,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,26596,0)
 ;;=G90.3^^100^1269^25
 ;;^UTILITY(U,$J,358.3,26596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26596,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,26596,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,26596,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,26597,0)
 ;;=G91.2^^100^1269^26
 ;;^UTILITY(U,$J,358.3,26597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26597,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,26597,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,26597,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,26598,0)
 ;;=G91.2^^100^1269^27
 ;;^UTILITY(U,$J,358.3,26598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26598,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavorial Disturbances
 ;;^UTILITY(U,$J,358.3,26598,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,26598,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,26599,0)
 ;;=G30.8^^100^1269^2
 ;;^UTILITY(U,$J,358.3,26599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26599,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,26599,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,26599,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,26600,0)
 ;;=A81.89^^100^1269^6
 ;;^UTILITY(U,$J,358.3,26600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26600,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,26600,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,26600,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,26601,0)
 ;;=F19.97^^100^1269^35
 ;;^UTILITY(U,$J,358.3,26601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26601,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,26601,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,26601,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,26602,0)
 ;;=G20.^^100^1269^28
 ;;^UTILITY(U,$J,358.3,26602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26602,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,26602,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,26602,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,26603,0)
 ;;=G20.^^100^1269^29
 ;;^UTILITY(U,$J,358.3,26603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26603,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,26603,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,26603,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,26604,0)
 ;;=G23.1^^100^1269^34
 ;;^UTILITY(U,$J,358.3,26604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26604,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia Palsy
 ;;^UTILITY(U,$J,358.3,26604,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,26604,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,26605,0)
 ;;=F03.91^^100^1269^15
 ;;^UTILITY(U,$J,358.3,26605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26605,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,26605,1,4,0)
 ;;=4^F03.91
