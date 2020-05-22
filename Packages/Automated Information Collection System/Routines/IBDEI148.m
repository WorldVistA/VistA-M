IBDEI148 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17913,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,17913,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,17914,0)
 ;;=F03.90^^88^899^15
 ;;^UTILITY(U,$J,358.3,17914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17914,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,17914,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,17914,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,17915,0)
 ;;=G30.0^^88^899^2
 ;;^UTILITY(U,$J,358.3,17915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17915,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,17915,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,17915,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,17916,0)
 ;;=G30.1^^88^899^3
 ;;^UTILITY(U,$J,358.3,17916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17916,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,17916,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,17916,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,17917,0)
 ;;=G30.9^^88^899^4
 ;;^UTILITY(U,$J,358.3,17917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17917,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,17917,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,17917,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,17918,0)
 ;;=G10.^^88^899^19
 ;;^UTILITY(U,$J,358.3,17918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17918,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,17918,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,17918,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,17919,0)
 ;;=G10.^^88^899^20
 ;;^UTILITY(U,$J,358.3,17919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17919,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,17919,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,17919,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,17920,0)
 ;;=G90.3^^88^899^21
 ;;^UTILITY(U,$J,358.3,17920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17920,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,17920,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,17920,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,17921,0)
 ;;=G91.2^^88^899^22
 ;;^UTILITY(U,$J,358.3,17921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17921,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,17921,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,17921,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,17922,0)
 ;;=G91.2^^88^899^23
 ;;^UTILITY(U,$J,358.3,17922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17922,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,17922,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,17922,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,17923,0)
 ;;=G30.8^^88^899^5
 ;;^UTILITY(U,$J,358.3,17923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17923,1,3,0)
 ;;=3^Alzheimer's Diseases NEC
 ;;^UTILITY(U,$J,358.3,17923,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,17923,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,17924,0)
 ;;=G31.09^^88^899^16
 ;;^UTILITY(U,$J,358.3,17924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17924,1,3,0)
 ;;=3^Frontotemporal Dementia NEC
 ;;^UTILITY(U,$J,358.3,17924,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,17924,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,17925,0)
 ;;=G20.^^88^899^24
 ;;^UTILITY(U,$J,358.3,17925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17925,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
