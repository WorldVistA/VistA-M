IBDEI2II ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42585,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,42586,0)
 ;;=F19.97^^159^2024^29
 ;;^UTILITY(U,$J,358.3,42586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42586,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,42586,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,42586,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,42587,0)
 ;;=F03.90^^159^2024^15
 ;;^UTILITY(U,$J,358.3,42587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42587,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,42587,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,42587,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,42588,0)
 ;;=G30.0^^159^2024^2
 ;;^UTILITY(U,$J,358.3,42588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42588,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,42588,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,42588,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,42589,0)
 ;;=G30.1^^159^2024^3
 ;;^UTILITY(U,$J,358.3,42589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42589,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,42589,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,42589,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,42590,0)
 ;;=G30.9^^159^2024^4
 ;;^UTILITY(U,$J,358.3,42590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42590,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,42590,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,42590,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,42591,0)
 ;;=G10.^^159^2024^19
 ;;^UTILITY(U,$J,358.3,42591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42591,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,42591,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,42591,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,42592,0)
 ;;=G10.^^159^2024^20
 ;;^UTILITY(U,$J,358.3,42592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42592,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,42592,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,42592,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,42593,0)
 ;;=G90.3^^159^2024^21
 ;;^UTILITY(U,$J,358.3,42593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42593,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,42593,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,42593,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,42594,0)
 ;;=G91.2^^159^2024^22
 ;;^UTILITY(U,$J,358.3,42594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42594,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,42594,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,42594,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,42595,0)
 ;;=G91.2^^159^2024^23
 ;;^UTILITY(U,$J,358.3,42595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42595,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,42595,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,42595,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,42596,0)
 ;;=G30.8^^159^2024^5
 ;;^UTILITY(U,$J,358.3,42596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42596,1,3,0)
 ;;=3^Alzheimer's Diseases NEC
 ;;^UTILITY(U,$J,358.3,42596,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,42596,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,42597,0)
 ;;=G31.09^^159^2024^16
 ;;^UTILITY(U,$J,358.3,42597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42597,1,3,0)
 ;;=3^Frontotemporal Dementia NEC
 ;;^UTILITY(U,$J,358.3,42597,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,42597,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,42598,0)
 ;;=G20.^^159^2024^24
 ;;^UTILITY(U,$J,358.3,42598,1,0)
 ;;=^358.31IA^4^2
