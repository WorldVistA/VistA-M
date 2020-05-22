IBDEI2KN ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41043,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,41043,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,41044,0)
 ;;=G30.9^^152^2020^4
 ;;^UTILITY(U,$J,358.3,41044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41044,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,41044,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,41044,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,41045,0)
 ;;=G10.^^152^2020^19
 ;;^UTILITY(U,$J,358.3,41045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41045,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,41045,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,41045,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,41046,0)
 ;;=G10.^^152^2020^20
 ;;^UTILITY(U,$J,358.3,41046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41046,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,41046,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,41046,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,41047,0)
 ;;=G90.3^^152^2020^21
 ;;^UTILITY(U,$J,358.3,41047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41047,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,41047,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,41047,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,41048,0)
 ;;=G91.2^^152^2020^22
 ;;^UTILITY(U,$J,358.3,41048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41048,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,41048,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,41048,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,41049,0)
 ;;=G91.2^^152^2020^23
 ;;^UTILITY(U,$J,358.3,41049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41049,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,41049,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,41049,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,41050,0)
 ;;=G30.8^^152^2020^5
 ;;^UTILITY(U,$J,358.3,41050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41050,1,3,0)
 ;;=3^Alzheimer's Diseases NEC
 ;;^UTILITY(U,$J,358.3,41050,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,41050,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,41051,0)
 ;;=G31.09^^152^2020^16
 ;;^UTILITY(U,$J,358.3,41051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41051,1,3,0)
 ;;=3^Frontotemporal Dementia NEC
 ;;^UTILITY(U,$J,358.3,41051,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,41051,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,41052,0)
 ;;=G20.^^152^2020^24
 ;;^UTILITY(U,$J,358.3,41052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41052,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,41052,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,41052,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,41053,0)
 ;;=G20.^^152^2020^25
 ;;^UTILITY(U,$J,358.3,41053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41053,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,41053,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,41053,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,41054,0)
 ;;=G31.01^^152^2020^26
 ;;^UTILITY(U,$J,358.3,41054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41054,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,41054,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,41054,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,41055,0)
 ;;=G23.1^^152^2020^28
 ;;^UTILITY(U,$J,358.3,41055,1,0)
 ;;=^358.31IA^4^2
