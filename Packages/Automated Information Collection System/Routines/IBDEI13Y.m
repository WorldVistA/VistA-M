IBDEI13Y ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17976,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,17976,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,17977,0)
 ;;=A81.2^^61^795^27
 ;;^UTILITY(U,$J,358.3,17977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17977,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,17977,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,17977,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,17978,0)
 ;;=B20.^^61^795^17
 ;;^UTILITY(U,$J,358.3,17978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17978,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,17978,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,17978,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,17979,0)
 ;;=B20.^^61^795^18
 ;;^UTILITY(U,$J,358.3,17979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17979,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,17979,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,17979,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,17980,0)
 ;;=F10.27^^61^795^1
 ;;^UTILITY(U,$J,358.3,17980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17980,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,17980,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,17980,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,17981,0)
 ;;=F19.97^^61^795^29
 ;;^UTILITY(U,$J,358.3,17981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17981,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,17981,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,17981,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,17982,0)
 ;;=F03.90^^61^795^15
 ;;^UTILITY(U,$J,358.3,17982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17982,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,17982,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,17982,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,17983,0)
 ;;=G30.0^^61^795^2
 ;;^UTILITY(U,$J,358.3,17983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17983,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,17983,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,17983,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,17984,0)
 ;;=G30.1^^61^795^3
 ;;^UTILITY(U,$J,358.3,17984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17984,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,17984,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,17984,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,17985,0)
 ;;=G30.9^^61^795^4
 ;;^UTILITY(U,$J,358.3,17985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17985,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,17985,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,17985,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,17986,0)
 ;;=G10.^^61^795^19
 ;;^UTILITY(U,$J,358.3,17986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17986,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,17986,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,17986,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,17987,0)
 ;;=G10.^^61^795^20
 ;;^UTILITY(U,$J,358.3,17987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17987,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,17987,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,17987,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,17988,0)
 ;;=G90.3^^61^795^21
 ;;^UTILITY(U,$J,358.3,17988,1,0)
 ;;=^358.31IA^4^2
