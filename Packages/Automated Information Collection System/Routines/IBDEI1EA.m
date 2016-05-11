IBDEI1EA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23693,0)
 ;;=F03.90^^87^1001^15
 ;;^UTILITY(U,$J,358.3,23693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23693,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,23693,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,23693,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,23694,0)
 ;;=G30.0^^87^1001^2
 ;;^UTILITY(U,$J,358.3,23694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23694,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,23694,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,23694,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,23695,0)
 ;;=G30.1^^87^1001^3
 ;;^UTILITY(U,$J,358.3,23695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23695,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,23695,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,23695,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,23696,0)
 ;;=G30.9^^87^1001^4
 ;;^UTILITY(U,$J,358.3,23696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23696,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,23696,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,23696,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,23697,0)
 ;;=G10.^^87^1001^19
 ;;^UTILITY(U,$J,358.3,23697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23697,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,23697,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,23697,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,23698,0)
 ;;=G10.^^87^1001^20
 ;;^UTILITY(U,$J,358.3,23698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23698,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,23698,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,23698,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,23699,0)
 ;;=G90.3^^87^1001^21
 ;;^UTILITY(U,$J,358.3,23699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23699,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,23699,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,23699,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,23700,0)
 ;;=G91.2^^87^1001^22
 ;;^UTILITY(U,$J,358.3,23700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23700,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,23700,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,23700,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,23701,0)
 ;;=G91.2^^87^1001^23
 ;;^UTILITY(U,$J,358.3,23701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23701,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,23701,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,23701,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,23702,0)
 ;;=G30.8^^87^1001^5
 ;;^UTILITY(U,$J,358.3,23702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23702,1,3,0)
 ;;=3^Alzheimer's Diseases NEC
 ;;^UTILITY(U,$J,358.3,23702,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,23702,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,23703,0)
 ;;=G31.09^^87^1001^16
 ;;^UTILITY(U,$J,358.3,23703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23703,1,3,0)
 ;;=3^Frontotemporal Dementia NEC
 ;;^UTILITY(U,$J,358.3,23703,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,23703,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,23704,0)
 ;;=G20.^^87^1001^24
 ;;^UTILITY(U,$J,358.3,23704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23704,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,23704,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,23704,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,23705,0)
 ;;=G20.^^87^1001^25
 ;;^UTILITY(U,$J,358.3,23705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23705,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
