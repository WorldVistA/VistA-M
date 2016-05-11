IBDEI0WU ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15408,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,15409,0)
 ;;=B20.^^58^662^18
 ;;^UTILITY(U,$J,358.3,15409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15409,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,15409,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,15409,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,15410,0)
 ;;=B20.^^58^662^19
 ;;^UTILITY(U,$J,358.3,15410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15410,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,15410,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,15410,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,15411,0)
 ;;=G10.^^58^662^20
 ;;^UTILITY(U,$J,358.3,15411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15411,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,15411,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,15411,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,15412,0)
 ;;=G10.^^58^662^21
 ;;^UTILITY(U,$J,358.3,15412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15412,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,15412,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,15412,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,15413,0)
 ;;=G90.3^^58^662^25
 ;;^UTILITY(U,$J,358.3,15413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15413,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,15413,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,15413,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,15414,0)
 ;;=G91.2^^58^662^26
 ;;^UTILITY(U,$J,358.3,15414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15414,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,15414,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,15414,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,15415,0)
 ;;=G91.2^^58^662^27
 ;;^UTILITY(U,$J,358.3,15415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15415,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavorial Disturbances
 ;;^UTILITY(U,$J,358.3,15415,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,15415,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,15416,0)
 ;;=G30.8^^58^662^2
 ;;^UTILITY(U,$J,358.3,15416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15416,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,15416,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,15416,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,15417,0)
 ;;=A81.89^^58^662^6
 ;;^UTILITY(U,$J,358.3,15417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15417,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,15417,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,15417,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,15418,0)
 ;;=F19.97^^58^662^35
 ;;^UTILITY(U,$J,358.3,15418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15418,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,15418,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,15418,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,15419,0)
 ;;=G20.^^58^662^28
 ;;^UTILITY(U,$J,358.3,15419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15419,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,15419,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,15419,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,15420,0)
 ;;=G20.^^58^662^29
 ;;^UTILITY(U,$J,358.3,15420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15420,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,15420,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,15420,2)
 ;;=^5003770^F02.80
