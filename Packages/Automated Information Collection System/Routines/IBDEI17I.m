IBDEI17I ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20155,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,20155,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,20155,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,20156,0)
 ;;=F19.97^^94^936^29
 ;;^UTILITY(U,$J,358.3,20156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20156,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,20156,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,20156,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,20157,0)
 ;;=F03.90^^94^936^15
 ;;^UTILITY(U,$J,358.3,20157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20157,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,20157,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,20157,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,20158,0)
 ;;=G30.0^^94^936^2
 ;;^UTILITY(U,$J,358.3,20158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20158,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,20158,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,20158,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,20159,0)
 ;;=G30.1^^94^936^3
 ;;^UTILITY(U,$J,358.3,20159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20159,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,20159,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,20159,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,20160,0)
 ;;=G30.9^^94^936^4
 ;;^UTILITY(U,$J,358.3,20160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20160,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,20160,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,20160,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,20161,0)
 ;;=G10.^^94^936^19
 ;;^UTILITY(U,$J,358.3,20161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20161,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,20161,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,20161,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,20162,0)
 ;;=G10.^^94^936^20
 ;;^UTILITY(U,$J,358.3,20162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20162,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,20162,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,20162,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,20163,0)
 ;;=G90.3^^94^936^21
 ;;^UTILITY(U,$J,358.3,20163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20163,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,20163,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,20163,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,20164,0)
 ;;=G91.2^^94^936^22
 ;;^UTILITY(U,$J,358.3,20164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20164,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,20164,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,20164,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,20165,0)
 ;;=G91.2^^94^936^23
 ;;^UTILITY(U,$J,358.3,20165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20165,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,20165,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,20165,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,20166,0)
 ;;=G30.8^^94^936^5
 ;;^UTILITY(U,$J,358.3,20166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20166,1,3,0)
 ;;=3^Alzheimer's Diseases NEC
 ;;^UTILITY(U,$J,358.3,20166,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,20166,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,20167,0)
 ;;=G31.09^^94^936^16
 ;;^UTILITY(U,$J,358.3,20167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20167,1,3,0)
 ;;=3^Frontotemporal Dementia NEC
 ;;^UTILITY(U,$J,358.3,20167,1,4,0)
 ;;=4^G31.09
