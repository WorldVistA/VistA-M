IBDEI0QA ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12035,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,12035,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,12035,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,12036,0)
 ;;=B20.^^68^695^17
 ;;^UTILITY(U,$J,358.3,12036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12036,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,12036,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,12036,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,12037,0)
 ;;=B20.^^68^695^18
 ;;^UTILITY(U,$J,358.3,12037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12037,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,12037,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,12037,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,12038,0)
 ;;=F10.27^^68^695^1
 ;;^UTILITY(U,$J,358.3,12038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12038,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,12038,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,12038,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,12039,0)
 ;;=F19.97^^68^695^29
 ;;^UTILITY(U,$J,358.3,12039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12039,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,12039,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,12039,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,12040,0)
 ;;=F03.90^^68^695^15
 ;;^UTILITY(U,$J,358.3,12040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12040,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,12040,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,12040,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,12041,0)
 ;;=G30.0^^68^695^2
 ;;^UTILITY(U,$J,358.3,12041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12041,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,12041,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,12041,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,12042,0)
 ;;=G30.1^^68^695^3
 ;;^UTILITY(U,$J,358.3,12042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12042,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,12042,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,12042,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,12043,0)
 ;;=G30.9^^68^695^4
 ;;^UTILITY(U,$J,358.3,12043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12043,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,12043,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,12043,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,12044,0)
 ;;=G10.^^68^695^19
 ;;^UTILITY(U,$J,358.3,12044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12044,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,12044,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,12044,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,12045,0)
 ;;=G10.^^68^695^20
 ;;^UTILITY(U,$J,358.3,12045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12045,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,12045,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,12045,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,12046,0)
 ;;=G90.3^^68^695^21
 ;;^UTILITY(U,$J,358.3,12046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12046,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,12046,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,12046,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,12047,0)
 ;;=G91.2^^68^695^22
 ;;^UTILITY(U,$J,358.3,12047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12047,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
