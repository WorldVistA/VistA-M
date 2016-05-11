IBDEI22T ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35201,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,35202,0)
 ;;=F19.97^^131^1700^29
 ;;^UTILITY(U,$J,358.3,35202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35202,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,35202,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,35202,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,35203,0)
 ;;=F03.90^^131^1700^15
 ;;^UTILITY(U,$J,358.3,35203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35203,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,35203,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,35203,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,35204,0)
 ;;=G30.0^^131^1700^2
 ;;^UTILITY(U,$J,358.3,35204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35204,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,35204,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,35204,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,35205,0)
 ;;=G30.1^^131^1700^3
 ;;^UTILITY(U,$J,358.3,35205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35205,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,35205,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,35205,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,35206,0)
 ;;=G30.9^^131^1700^4
 ;;^UTILITY(U,$J,358.3,35206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35206,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,35206,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,35206,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,35207,0)
 ;;=G10.^^131^1700^19
 ;;^UTILITY(U,$J,358.3,35207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35207,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,35207,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,35207,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,35208,0)
 ;;=G10.^^131^1700^20
 ;;^UTILITY(U,$J,358.3,35208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35208,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,35208,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,35208,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,35209,0)
 ;;=G90.3^^131^1700^21
 ;;^UTILITY(U,$J,358.3,35209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35209,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,35209,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,35209,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,35210,0)
 ;;=G91.2^^131^1700^22
 ;;^UTILITY(U,$J,358.3,35210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35210,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,35210,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,35210,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,35211,0)
 ;;=G91.2^^131^1700^23
 ;;^UTILITY(U,$J,358.3,35211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35211,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,35211,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,35211,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,35212,0)
 ;;=G30.8^^131^1700^5
 ;;^UTILITY(U,$J,358.3,35212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35212,1,3,0)
 ;;=3^Alzheimer's Diseases NEC
 ;;^UTILITY(U,$J,358.3,35212,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,35212,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,35213,0)
 ;;=G31.09^^131^1700^16
 ;;^UTILITY(U,$J,358.3,35213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35213,1,3,0)
 ;;=3^Frontotemporal Dementia NEC
 ;;^UTILITY(U,$J,358.3,35213,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,35213,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,35214,0)
 ;;=G20.^^131^1700^24
 ;;^UTILITY(U,$J,358.3,35214,1,0)
 ;;=^358.31IA^4^2
