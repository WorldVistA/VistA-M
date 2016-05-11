IBDEI0VG ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14738,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,14738,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,14738,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,14739,0)
 ;;=B20.^^53^613^17
 ;;^UTILITY(U,$J,358.3,14739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14739,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,14739,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,14739,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,14740,0)
 ;;=B20.^^53^613^18
 ;;^UTILITY(U,$J,358.3,14740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14740,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,14740,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,14740,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,14741,0)
 ;;=F10.27^^53^613^1
 ;;^UTILITY(U,$J,358.3,14741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14741,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,14741,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,14741,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,14742,0)
 ;;=F19.97^^53^613^29
 ;;^UTILITY(U,$J,358.3,14742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14742,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,14742,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,14742,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,14743,0)
 ;;=F03.90^^53^613^15
 ;;^UTILITY(U,$J,358.3,14743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14743,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,14743,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,14743,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,14744,0)
 ;;=G30.0^^53^613^2
 ;;^UTILITY(U,$J,358.3,14744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14744,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,14744,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,14744,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,14745,0)
 ;;=G30.1^^53^613^3
 ;;^UTILITY(U,$J,358.3,14745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14745,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,14745,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,14745,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,14746,0)
 ;;=G30.9^^53^613^4
 ;;^UTILITY(U,$J,358.3,14746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14746,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,14746,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,14746,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,14747,0)
 ;;=G10.^^53^613^19
 ;;^UTILITY(U,$J,358.3,14747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14747,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,14747,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,14747,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,14748,0)
 ;;=G10.^^53^613^20
 ;;^UTILITY(U,$J,358.3,14748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14748,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,14748,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,14748,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,14749,0)
 ;;=G90.3^^53^613^21
 ;;^UTILITY(U,$J,358.3,14749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14749,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,14749,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,14749,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,14750,0)
 ;;=G91.2^^53^613^22
 ;;^UTILITY(U,$J,358.3,14750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14750,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
