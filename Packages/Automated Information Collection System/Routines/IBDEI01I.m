IBDEI01I ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,204,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,204,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,205,0)
 ;;=G31.09^^3^27^22
 ;;^UTILITY(U,$J,358.3,205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,205,1,3,0)
 ;;=3^Major Frontotemporal Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,205,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,205,2)
 ;;=^329916^F02.81
 ;;^UTILITY(U,$J,358.3,206,0)
 ;;=G30.0^^3^27^3
 ;;^UTILITY(U,$J,358.3,206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,206,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,206,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,206,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,207,0)
 ;;=G30.1^^3^27^4
 ;;^UTILITY(U,$J,358.3,207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,207,1,3,0)
 ;;=3^Alzheimer's Disease with Late Onset
 ;;^UTILITY(U,$J,358.3,207,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,207,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,208,0)
 ;;=B20.^^3^27^18
 ;;^UTILITY(U,$J,358.3,208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,208,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,208,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,208,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,209,0)
 ;;=B20.^^3^27^19
 ;;^UTILITY(U,$J,358.3,209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,209,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,209,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,209,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,210,0)
 ;;=G10.^^3^27^20
 ;;^UTILITY(U,$J,358.3,210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,210,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,210,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,210,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,211,0)
 ;;=G10.^^3^27^21
 ;;^UTILITY(U,$J,358.3,211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,211,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,211,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,211,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,212,0)
 ;;=G90.3^^3^27^25
 ;;^UTILITY(U,$J,358.3,212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,212,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,212,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,212,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,213,0)
 ;;=G91.2^^3^27^26
 ;;^UTILITY(U,$J,358.3,213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,213,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,213,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,213,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,214,0)
 ;;=G91.2^^3^27^27
 ;;^UTILITY(U,$J,358.3,214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,214,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavorial Disturbances
 ;;^UTILITY(U,$J,358.3,214,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,214,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,215,0)
 ;;=G30.8^^3^27^2
 ;;^UTILITY(U,$J,358.3,215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,215,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,215,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,215,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,216,0)
 ;;=A81.89^^3^27^6
 ;;^UTILITY(U,$J,358.3,216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,216,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,216,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,216,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,217,0)
 ;;=F19.97^^3^27^35
 ;;^UTILITY(U,$J,358.3,217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,217,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
