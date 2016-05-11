IBDEI1TA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30778,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia NEC
 ;;^UTILITY(U,$J,358.3,30778,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,30778,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,30779,0)
 ;;=G31.09^^123^1533^22
 ;;^UTILITY(U,$J,358.3,30779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30779,1,3,0)
 ;;=3^Major Frontotemporal Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,30779,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,30779,2)
 ;;=^329916^F02.81
 ;;^UTILITY(U,$J,358.3,30780,0)
 ;;=G30.0^^123^1533^3
 ;;^UTILITY(U,$J,358.3,30780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30780,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,30780,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,30780,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,30781,0)
 ;;=G30.1^^123^1533^4
 ;;^UTILITY(U,$J,358.3,30781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30781,1,3,0)
 ;;=3^Alzheimer's Disease with Late Onset
 ;;^UTILITY(U,$J,358.3,30781,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,30781,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,30782,0)
 ;;=B20.^^123^1533^18
 ;;^UTILITY(U,$J,358.3,30782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30782,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,30782,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,30782,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,30783,0)
 ;;=B20.^^123^1533^19
 ;;^UTILITY(U,$J,358.3,30783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30783,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,30783,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,30783,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,30784,0)
 ;;=G10.^^123^1533^20
 ;;^UTILITY(U,$J,358.3,30784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30784,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,30784,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,30784,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,30785,0)
 ;;=G10.^^123^1533^21
 ;;^UTILITY(U,$J,358.3,30785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30785,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,30785,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,30785,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,30786,0)
 ;;=G90.3^^123^1533^25
 ;;^UTILITY(U,$J,358.3,30786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30786,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,30786,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,30786,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,30787,0)
 ;;=G91.2^^123^1533^26
 ;;^UTILITY(U,$J,358.3,30787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30787,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,30787,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,30787,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,30788,0)
 ;;=G91.2^^123^1533^27
 ;;^UTILITY(U,$J,358.3,30788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30788,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavorial Disturbances
 ;;^UTILITY(U,$J,358.3,30788,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,30788,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,30789,0)
 ;;=G30.8^^123^1533^2
 ;;^UTILITY(U,$J,358.3,30789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30789,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,30789,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,30789,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,30790,0)
 ;;=A81.89^^123^1533^6
 ;;^UTILITY(U,$J,358.3,30790,1,0)
 ;;=^358.31IA^4^2
