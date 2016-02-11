IBDEI29Q ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38095,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,38095,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,38095,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,38096,0)
 ;;=G31.9^^177^1918^12
 ;;^UTILITY(U,$J,358.3,38096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38096,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,38096,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,38096,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,38097,0)
 ;;=G23.8^^177^1918^10
 ;;^UTILITY(U,$J,358.3,38097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38097,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia NEC
 ;;^UTILITY(U,$J,358.3,38097,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,38097,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,38098,0)
 ;;=G31.09^^177^1918^22
 ;;^UTILITY(U,$J,358.3,38098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38098,1,3,0)
 ;;=3^Major Frontotemporal Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,38098,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,38098,2)
 ;;=^329916^F02.81
 ;;^UTILITY(U,$J,358.3,38099,0)
 ;;=G30.0^^177^1918^3
 ;;^UTILITY(U,$J,358.3,38099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38099,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,38099,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,38099,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,38100,0)
 ;;=G30.1^^177^1918^4
 ;;^UTILITY(U,$J,358.3,38100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38100,1,3,0)
 ;;=3^Alzheimer's Disease with Late Onset
 ;;^UTILITY(U,$J,358.3,38100,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,38100,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,38101,0)
 ;;=B20.^^177^1918^18
 ;;^UTILITY(U,$J,358.3,38101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38101,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,38101,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,38101,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,38102,0)
 ;;=B20.^^177^1918^19
 ;;^UTILITY(U,$J,358.3,38102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38102,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,38102,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,38102,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,38103,0)
 ;;=G10.^^177^1918^20
 ;;^UTILITY(U,$J,358.3,38103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38103,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,38103,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,38103,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,38104,0)
 ;;=G10.^^177^1918^21
 ;;^UTILITY(U,$J,358.3,38104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38104,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,38104,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,38104,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,38105,0)
 ;;=G90.3^^177^1918^25
 ;;^UTILITY(U,$J,358.3,38105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38105,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,38105,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,38105,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,38106,0)
 ;;=G91.2^^177^1918^26
 ;;^UTILITY(U,$J,358.3,38106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38106,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,38106,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,38106,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,38107,0)
 ;;=G91.2^^177^1918^27
 ;;^UTILITY(U,$J,358.3,38107,1,0)
 ;;=^358.31IA^4^2
