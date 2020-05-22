IBDEI1N5 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26207,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,26208,0)
 ;;=A81.00^^107^1231^9
 ;;^UTILITY(U,$J,358.3,26208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26208,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,26208,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,26208,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,26209,0)
 ;;=A81.01^^107^1231^10
 ;;^UTILITY(U,$J,358.3,26209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26209,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,26209,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,26209,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,26210,0)
 ;;=A81.89^^107^1231^7
 ;;^UTILITY(U,$J,358.3,26210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26210,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,26210,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,26210,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,26211,0)
 ;;=A81.2^^107^1231^27
 ;;^UTILITY(U,$J,358.3,26211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26211,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,26211,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,26211,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,26212,0)
 ;;=B20.^^107^1231^17
 ;;^UTILITY(U,$J,358.3,26212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26212,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,26212,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,26212,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,26213,0)
 ;;=B20.^^107^1231^18
 ;;^UTILITY(U,$J,358.3,26213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26213,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,26213,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,26213,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,26214,0)
 ;;=F10.27^^107^1231^1
 ;;^UTILITY(U,$J,358.3,26214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26214,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,26214,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,26214,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,26215,0)
 ;;=F19.97^^107^1231^29
 ;;^UTILITY(U,$J,358.3,26215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26215,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,26215,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,26215,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,26216,0)
 ;;=F03.90^^107^1231^15
 ;;^UTILITY(U,$J,358.3,26216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26216,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,26216,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,26216,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,26217,0)
 ;;=G30.0^^107^1231^2
 ;;^UTILITY(U,$J,358.3,26217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26217,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,26217,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,26217,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,26218,0)
 ;;=G30.1^^107^1231^3
 ;;^UTILITY(U,$J,358.3,26218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26218,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,26218,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,26218,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,26219,0)
 ;;=G30.9^^107^1231^4
 ;;^UTILITY(U,$J,358.3,26219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26219,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
