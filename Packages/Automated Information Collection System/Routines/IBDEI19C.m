IBDEI19C ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21364,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,21364,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,21364,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,21365,0)
 ;;=B20.^^84^949^17
 ;;^UTILITY(U,$J,358.3,21365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21365,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,21365,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,21365,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,21366,0)
 ;;=B20.^^84^949^18
 ;;^UTILITY(U,$J,358.3,21366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21366,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,21366,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,21366,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,21367,0)
 ;;=F10.27^^84^949^1
 ;;^UTILITY(U,$J,358.3,21367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21367,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,21367,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,21367,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,21368,0)
 ;;=F19.97^^84^949^29
 ;;^UTILITY(U,$J,358.3,21368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21368,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,21368,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,21368,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,21369,0)
 ;;=F03.90^^84^949^15
 ;;^UTILITY(U,$J,358.3,21369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21369,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,21369,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,21369,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,21370,0)
 ;;=G30.0^^84^949^2
 ;;^UTILITY(U,$J,358.3,21370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21370,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,21370,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,21370,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,21371,0)
 ;;=G30.1^^84^949^3
 ;;^UTILITY(U,$J,358.3,21371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21371,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,21371,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,21371,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,21372,0)
 ;;=G30.9^^84^949^4
 ;;^UTILITY(U,$J,358.3,21372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21372,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,21372,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,21372,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,21373,0)
 ;;=G10.^^84^949^19
 ;;^UTILITY(U,$J,358.3,21373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21373,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,21373,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,21373,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,21374,0)
 ;;=G10.^^84^949^20
 ;;^UTILITY(U,$J,358.3,21374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21374,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,21374,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,21374,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,21375,0)
 ;;=G90.3^^84^949^21
 ;;^UTILITY(U,$J,358.3,21375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21375,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,21375,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,21375,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,21376,0)
 ;;=G91.2^^84^949^22
 ;;^UTILITY(U,$J,358.3,21376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21376,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
