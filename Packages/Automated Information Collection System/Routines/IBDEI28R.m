IBDEI28R ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38025,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,38025,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,38025,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,38026,0)
 ;;=G90.3^^145^1832^25
 ;;^UTILITY(U,$J,358.3,38026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38026,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,38026,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,38026,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,38027,0)
 ;;=G91.2^^145^1832^26
 ;;^UTILITY(U,$J,358.3,38027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38027,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,38027,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,38027,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,38028,0)
 ;;=G91.2^^145^1832^27
 ;;^UTILITY(U,$J,358.3,38028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38028,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavorial Disturbances
 ;;^UTILITY(U,$J,358.3,38028,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,38028,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,38029,0)
 ;;=G30.8^^145^1832^2
 ;;^UTILITY(U,$J,358.3,38029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38029,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,38029,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,38029,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,38030,0)
 ;;=A81.89^^145^1832^6
 ;;^UTILITY(U,$J,358.3,38030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38030,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,38030,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,38030,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,38031,0)
 ;;=F19.97^^145^1832^35
 ;;^UTILITY(U,$J,358.3,38031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38031,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,38031,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,38031,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,38032,0)
 ;;=G20.^^145^1832^28
 ;;^UTILITY(U,$J,358.3,38032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38032,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,38032,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,38032,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,38033,0)
 ;;=G20.^^145^1832^29
 ;;^UTILITY(U,$J,358.3,38033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38033,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,38033,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,38033,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,38034,0)
 ;;=G23.1^^145^1832^34
 ;;^UTILITY(U,$J,358.3,38034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38034,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia Palsy
 ;;^UTILITY(U,$J,358.3,38034,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,38034,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,38035,0)
 ;;=F03.91^^145^1832^15
 ;;^UTILITY(U,$J,358.3,38035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38035,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,38035,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,38035,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,38036,0)
 ;;=F03.90^^145^1832^17
 ;;^UTILITY(U,$J,358.3,38036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38036,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,38036,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,38036,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,38037,0)
 ;;=F06.30^^145^1833^2
 ;;^UTILITY(U,$J,358.3,38037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38037,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition,Unspec
