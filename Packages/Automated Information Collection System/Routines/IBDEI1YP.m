IBDEI1YP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32855,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,32855,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,32855,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,32856,0)
 ;;=G30.1^^146^1585^4
 ;;^UTILITY(U,$J,358.3,32856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32856,1,3,0)
 ;;=3^Alzheimer's Disease with Late Onset
 ;;^UTILITY(U,$J,358.3,32856,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,32856,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,32857,0)
 ;;=B20.^^146^1585^18
 ;;^UTILITY(U,$J,358.3,32857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32857,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,32857,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,32857,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,32858,0)
 ;;=B20.^^146^1585^19
 ;;^UTILITY(U,$J,358.3,32858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32858,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,32858,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,32858,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,32859,0)
 ;;=G10.^^146^1585^20
 ;;^UTILITY(U,$J,358.3,32859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32859,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,32859,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,32859,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,32860,0)
 ;;=G10.^^146^1585^21
 ;;^UTILITY(U,$J,358.3,32860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32860,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,32860,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,32860,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,32861,0)
 ;;=G90.3^^146^1585^25
 ;;^UTILITY(U,$J,358.3,32861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32861,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,32861,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,32861,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,32862,0)
 ;;=G91.2^^146^1585^26
 ;;^UTILITY(U,$J,358.3,32862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32862,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,32862,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,32862,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,32863,0)
 ;;=G91.2^^146^1585^27
 ;;^UTILITY(U,$J,358.3,32863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32863,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavorial Disturbances
 ;;^UTILITY(U,$J,358.3,32863,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,32863,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,32864,0)
 ;;=G30.8^^146^1585^2
 ;;^UTILITY(U,$J,358.3,32864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32864,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,32864,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,32864,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,32865,0)
 ;;=A81.89^^146^1585^6
 ;;^UTILITY(U,$J,358.3,32865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32865,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,32865,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,32865,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,32866,0)
 ;;=F19.97^^146^1585^35
 ;;^UTILITY(U,$J,358.3,32866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32866,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,32866,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,32866,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,32867,0)
 ;;=G20.^^146^1585^28
 ;;^UTILITY(U,$J,358.3,32867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32867,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
