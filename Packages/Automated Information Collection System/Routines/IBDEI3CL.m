IBDEI3CL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,56244,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,56245,0)
 ;;=F19.97^^256^2795^29
 ;;^UTILITY(U,$J,358.3,56245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56245,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,56245,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,56245,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,56246,0)
 ;;=F03.90^^256^2795^15
 ;;^UTILITY(U,$J,358.3,56246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56246,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,56246,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,56246,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,56247,0)
 ;;=G30.0^^256^2795^2
 ;;^UTILITY(U,$J,358.3,56247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56247,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,56247,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,56247,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,56248,0)
 ;;=G30.1^^256^2795^3
 ;;^UTILITY(U,$J,358.3,56248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56248,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,56248,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,56248,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,56249,0)
 ;;=G30.9^^256^2795^4
 ;;^UTILITY(U,$J,358.3,56249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56249,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,56249,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,56249,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,56250,0)
 ;;=G10.^^256^2795^19
 ;;^UTILITY(U,$J,358.3,56250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56250,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,56250,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,56250,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,56251,0)
 ;;=G10.^^256^2795^20
 ;;^UTILITY(U,$J,358.3,56251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56251,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,56251,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,56251,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,56252,0)
 ;;=G90.3^^256^2795^21
 ;;^UTILITY(U,$J,358.3,56252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56252,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,56252,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,56252,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,56253,0)
 ;;=G91.2^^256^2795^22
 ;;^UTILITY(U,$J,358.3,56253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56253,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,56253,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,56253,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,56254,0)
 ;;=G91.2^^256^2795^23
 ;;^UTILITY(U,$J,358.3,56254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56254,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,56254,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,56254,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,56255,0)
 ;;=G30.8^^256^2795^5
 ;;^UTILITY(U,$J,358.3,56255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56255,1,3,0)
 ;;=3^Alzheimer's Diseases NEC
 ;;^UTILITY(U,$J,358.3,56255,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,56255,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,56256,0)
 ;;=G31.09^^256^2795^16
 ;;^UTILITY(U,$J,358.3,56256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56256,1,3,0)
 ;;=3^Frontotemporal Dementia NEC
 ;;^UTILITY(U,$J,358.3,56256,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,56256,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,56257,0)
 ;;=G20.^^256^2795^24
 ;;^UTILITY(U,$J,358.3,56257,1,0)
 ;;=^358.31IA^4^2
