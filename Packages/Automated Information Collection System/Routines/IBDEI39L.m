IBDEI39L ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52103,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,52103,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,52104,0)
 ;;=G30.9^^193^2517^4
 ;;^UTILITY(U,$J,358.3,52104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52104,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,52104,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,52104,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,52105,0)
 ;;=G10.^^193^2517^19
 ;;^UTILITY(U,$J,358.3,52105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52105,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,52105,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,52105,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,52106,0)
 ;;=G10.^^193^2517^20
 ;;^UTILITY(U,$J,358.3,52106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52106,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,52106,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,52106,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,52107,0)
 ;;=G90.3^^193^2517^21
 ;;^UTILITY(U,$J,358.3,52107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52107,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,52107,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,52107,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,52108,0)
 ;;=G91.2^^193^2517^22
 ;;^UTILITY(U,$J,358.3,52108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52108,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,52108,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,52108,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,52109,0)
 ;;=G91.2^^193^2517^23
 ;;^UTILITY(U,$J,358.3,52109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52109,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,52109,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,52109,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,52110,0)
 ;;=G30.8^^193^2517^5
 ;;^UTILITY(U,$J,358.3,52110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52110,1,3,0)
 ;;=3^Alzheimer's Diseases NEC
 ;;^UTILITY(U,$J,358.3,52110,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,52110,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,52111,0)
 ;;=G31.09^^193^2517^16
 ;;^UTILITY(U,$J,358.3,52111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52111,1,3,0)
 ;;=3^Frontotemporal Dementia NEC
 ;;^UTILITY(U,$J,358.3,52111,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,52111,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,52112,0)
 ;;=G20.^^193^2517^24
 ;;^UTILITY(U,$J,358.3,52112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52112,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,52112,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,52112,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,52113,0)
 ;;=G20.^^193^2517^25
 ;;^UTILITY(U,$J,358.3,52113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52113,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,52113,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,52113,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,52114,0)
 ;;=G31.01^^193^2517^26
 ;;^UTILITY(U,$J,358.3,52114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52114,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,52114,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,52114,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,52115,0)
 ;;=G23.1^^193^2517^28
 ;;^UTILITY(U,$J,358.3,52115,1,0)
 ;;=^358.31IA^4^2
