IBDEI2Q2 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,45670,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,45670,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,45670,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,45671,0)
 ;;=A81.89^^200^2248^7
 ;;^UTILITY(U,$J,358.3,45671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45671,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,45671,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,45671,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,45672,0)
 ;;=A81.2^^200^2248^27
 ;;^UTILITY(U,$J,358.3,45672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45672,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,45672,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,45672,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,45673,0)
 ;;=B20.^^200^2248^17
 ;;^UTILITY(U,$J,358.3,45673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45673,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,45673,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,45673,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,45674,0)
 ;;=B20.^^200^2248^18
 ;;^UTILITY(U,$J,358.3,45674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45674,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,45674,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,45674,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,45675,0)
 ;;=F10.27^^200^2248^1
 ;;^UTILITY(U,$J,358.3,45675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45675,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,45675,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,45675,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,45676,0)
 ;;=F19.97^^200^2248^29
 ;;^UTILITY(U,$J,358.3,45676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45676,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,45676,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,45676,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,45677,0)
 ;;=F03.90^^200^2248^15
 ;;^UTILITY(U,$J,358.3,45677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45677,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,45677,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,45677,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,45678,0)
 ;;=G30.0^^200^2248^2
 ;;^UTILITY(U,$J,358.3,45678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45678,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,45678,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,45678,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,45679,0)
 ;;=G30.1^^200^2248^3
 ;;^UTILITY(U,$J,358.3,45679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45679,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,45679,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,45679,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,45680,0)
 ;;=G30.9^^200^2248^4
 ;;^UTILITY(U,$J,358.3,45680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45680,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,45680,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,45680,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,45681,0)
 ;;=G10.^^200^2248^19
 ;;^UTILITY(U,$J,358.3,45681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45681,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,45681,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,45681,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,45682,0)
 ;;=G10.^^200^2248^20
 ;;^UTILITY(U,$J,358.3,45682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45682,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,45682,1,4,0)
 ;;=4^G10.
