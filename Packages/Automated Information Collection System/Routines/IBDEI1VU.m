IBDEI1VU ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31528,0)
 ;;=G31.9^^138^1429^12
 ;;^UTILITY(U,$J,358.3,31528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31528,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,31528,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,31528,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,31529,0)
 ;;=G23.8^^138^1429^10
 ;;^UTILITY(U,$J,358.3,31529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31529,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia NEC
 ;;^UTILITY(U,$J,358.3,31529,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,31529,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,31530,0)
 ;;=G31.09^^138^1429^22
 ;;^UTILITY(U,$J,358.3,31530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31530,1,3,0)
 ;;=3^Major Frontotemporal Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,31530,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,31530,2)
 ;;=^329916^F02.81
 ;;^UTILITY(U,$J,358.3,31531,0)
 ;;=G30.0^^138^1429^3
 ;;^UTILITY(U,$J,358.3,31531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31531,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,31531,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,31531,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,31532,0)
 ;;=G30.1^^138^1429^4
 ;;^UTILITY(U,$J,358.3,31532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31532,1,3,0)
 ;;=3^Alzheimer's Disease with Late Onset
 ;;^UTILITY(U,$J,358.3,31532,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,31532,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,31533,0)
 ;;=B20.^^138^1429^18
 ;;^UTILITY(U,$J,358.3,31533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31533,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,31533,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,31533,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,31534,0)
 ;;=B20.^^138^1429^19
 ;;^UTILITY(U,$J,358.3,31534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31534,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,31534,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,31534,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,31535,0)
 ;;=G10.^^138^1429^20
 ;;^UTILITY(U,$J,358.3,31535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31535,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,31535,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,31535,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,31536,0)
 ;;=G10.^^138^1429^21
 ;;^UTILITY(U,$J,358.3,31536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31536,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,31536,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,31536,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,31537,0)
 ;;=G90.3^^138^1429^25
 ;;^UTILITY(U,$J,358.3,31537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31537,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,31537,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,31537,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,31538,0)
 ;;=G91.2^^138^1429^26
 ;;^UTILITY(U,$J,358.3,31538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31538,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,31538,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,31538,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,31539,0)
 ;;=G91.2^^138^1429^27
 ;;^UTILITY(U,$J,358.3,31539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31539,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavorial Disturbances
 ;;^UTILITY(U,$J,358.3,31539,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,31539,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,31540,0)
 ;;=G30.8^^138^1429^2
