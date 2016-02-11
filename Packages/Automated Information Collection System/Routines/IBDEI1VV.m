IBDEI1VV ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31540,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,31540,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,31540,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,31541,0)
 ;;=A81.89^^138^1429^6
 ;;^UTILITY(U,$J,358.3,31541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31541,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,31541,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,31541,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,31542,0)
 ;;=F19.97^^138^1429^35
 ;;^UTILITY(U,$J,358.3,31542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31542,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,31542,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,31542,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,31543,0)
 ;;=G20.^^138^1429^28
 ;;^UTILITY(U,$J,358.3,31543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31543,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,31543,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,31543,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,31544,0)
 ;;=G20.^^138^1429^29
 ;;^UTILITY(U,$J,358.3,31544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31544,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,31544,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,31544,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,31545,0)
 ;;=G23.1^^138^1429^34
 ;;^UTILITY(U,$J,358.3,31545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31545,1,3,0)
 ;;=3^Progressive Supranuclear Palsy
 ;;^UTILITY(U,$J,358.3,31545,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,31545,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,31546,0)
 ;;=F03.91^^138^1429^15
 ;;^UTILITY(U,$J,358.3,31546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31546,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,31546,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,31546,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,31547,0)
 ;;=F03.90^^138^1429^17
 ;;^UTILITY(U,$J,358.3,31547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31547,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,31547,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,31547,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,31548,0)
 ;;=F06.30^^138^1430^2
 ;;^UTILITY(U,$J,358.3,31548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31548,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition,Unspec
 ;;^UTILITY(U,$J,358.3,31548,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,31548,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,31549,0)
 ;;=F06.31^^138^1430^3
 ;;^UTILITY(U,$J,358.3,31549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31549,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Depressive Features
 ;;^UTILITY(U,$J,358.3,31549,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,31549,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,31550,0)
 ;;=F06.32^^138^1430^4
 ;;^UTILITY(U,$J,358.3,31550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31550,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Major Depressive-Like Episode
 ;;^UTILITY(U,$J,358.3,31550,1,4,0)
 ;;=4^F06.32
 ;;^UTILITY(U,$J,358.3,31550,2)
 ;;=^5003058
 ;;^UTILITY(U,$J,358.3,31551,0)
 ;;=F32.9^^138^1430^14
 ;;^UTILITY(U,$J,358.3,31551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31551,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,31551,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,31551,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,31552,0)
 ;;=F32.0^^138^1430^15
 ;;^UTILITY(U,$J,358.3,31552,1,0)
 ;;=^358.31IA^4^2
