IBDEI02Z ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,634,0)
 ;;=G30.0^^6^76^2
 ;;^UTILITY(U,$J,358.3,634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,634,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,634,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,634,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,635,0)
 ;;=G30.1^^6^76^3
 ;;^UTILITY(U,$J,358.3,635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,635,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,635,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,635,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,636,0)
 ;;=G30.9^^6^76^4
 ;;^UTILITY(U,$J,358.3,636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,636,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,636,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,636,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,637,0)
 ;;=G10.^^6^76^19
 ;;^UTILITY(U,$J,358.3,637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,637,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,637,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,637,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,638,0)
 ;;=G10.^^6^76^20
 ;;^UTILITY(U,$J,358.3,638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,638,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,638,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,638,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,639,0)
 ;;=G90.3^^6^76^21
 ;;^UTILITY(U,$J,358.3,639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,639,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,639,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,639,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,640,0)
 ;;=G91.2^^6^76^22
 ;;^UTILITY(U,$J,358.3,640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,640,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,640,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,640,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,641,0)
 ;;=G91.2^^6^76^23
 ;;^UTILITY(U,$J,358.3,641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,641,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,641,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,641,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,642,0)
 ;;=G30.8^^6^76^5
 ;;^UTILITY(U,$J,358.3,642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,642,1,3,0)
 ;;=3^Alzheimer's Diseases NEC
 ;;^UTILITY(U,$J,358.3,642,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,642,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,643,0)
 ;;=G31.09^^6^76^16
 ;;^UTILITY(U,$J,358.3,643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,643,1,3,0)
 ;;=3^Frontotemporal Dementia NEC
 ;;^UTILITY(U,$J,358.3,643,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,643,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,644,0)
 ;;=G20.^^6^76^24
 ;;^UTILITY(U,$J,358.3,644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,644,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,644,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,644,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,645,0)
 ;;=G20.^^6^76^25
 ;;^UTILITY(U,$J,358.3,645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,645,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,645,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,645,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,646,0)
 ;;=G31.01^^6^76^26
 ;;^UTILITY(U,$J,358.3,646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,646,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,646,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,646,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,647,0)
 ;;=G23.1^^6^76^28
