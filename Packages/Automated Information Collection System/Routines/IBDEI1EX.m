IBDEI1EX ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24016,0)
 ;;=G90.3^^90^1039^25
 ;;^UTILITY(U,$J,358.3,24016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24016,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,24016,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,24016,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,24017,0)
 ;;=G91.2^^90^1039^26
 ;;^UTILITY(U,$J,358.3,24017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24017,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,24017,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,24017,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,24018,0)
 ;;=G91.2^^90^1039^27
 ;;^UTILITY(U,$J,358.3,24018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24018,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavorial Disturbances
 ;;^UTILITY(U,$J,358.3,24018,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,24018,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,24019,0)
 ;;=G30.8^^90^1039^2
 ;;^UTILITY(U,$J,358.3,24019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24019,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,24019,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,24019,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,24020,0)
 ;;=A81.89^^90^1039^6
 ;;^UTILITY(U,$J,358.3,24020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24020,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,24020,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,24020,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,24021,0)
 ;;=F19.97^^90^1039^35
 ;;^UTILITY(U,$J,358.3,24021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24021,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,24021,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,24021,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,24022,0)
 ;;=G20.^^90^1039^28
 ;;^UTILITY(U,$J,358.3,24022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24022,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,24022,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,24022,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,24023,0)
 ;;=G20.^^90^1039^29
 ;;^UTILITY(U,$J,358.3,24023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24023,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,24023,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,24023,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,24024,0)
 ;;=G23.1^^90^1039^34
 ;;^UTILITY(U,$J,358.3,24024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24024,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia Palsy
 ;;^UTILITY(U,$J,358.3,24024,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,24024,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,24025,0)
 ;;=F03.91^^90^1039^15
 ;;^UTILITY(U,$J,358.3,24025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24025,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,24025,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,24025,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,24026,0)
 ;;=F03.90^^90^1039^17
 ;;^UTILITY(U,$J,358.3,24026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24026,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,24026,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,24026,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,24027,0)
 ;;=F06.30^^90^1040^2
 ;;^UTILITY(U,$J,358.3,24027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24027,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition,Unspec
 ;;^UTILITY(U,$J,358.3,24027,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,24027,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,24028,0)
 ;;=F06.31^^90^1040^3
 ;;^UTILITY(U,$J,358.3,24028,1,0)
 ;;=^358.31IA^4^2
