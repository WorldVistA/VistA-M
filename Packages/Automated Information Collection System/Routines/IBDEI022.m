IBDEI022 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,190,1,3,0)
 ;;=3^Major Frontotemporal Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,190,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,190,2)
 ;;=^329916^F02.81
 ;;^UTILITY(U,$J,358.3,191,0)
 ;;=G30.0^^3^27^3
 ;;^UTILITY(U,$J,358.3,191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,191,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,191,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,191,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,192,0)
 ;;=G30.1^^3^27^4
 ;;^UTILITY(U,$J,358.3,192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,192,1,3,0)
 ;;=3^Alzheimer's Disease with Late Onset
 ;;^UTILITY(U,$J,358.3,192,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,192,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,193,0)
 ;;=B20.^^3^27^18
 ;;^UTILITY(U,$J,358.3,193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,193,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,193,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,193,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,194,0)
 ;;=B20.^^3^27^19
 ;;^UTILITY(U,$J,358.3,194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,194,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,194,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,194,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,195,0)
 ;;=G10.^^3^27^20
 ;;^UTILITY(U,$J,358.3,195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,195,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,195,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,195,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,196,0)
 ;;=G10.^^3^27^21
 ;;^UTILITY(U,$J,358.3,196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,196,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,196,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,196,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,197,0)
 ;;=G90.3^^3^27^25
 ;;^UTILITY(U,$J,358.3,197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,197,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,197,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,197,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,198,0)
 ;;=G91.2^^3^27^26
 ;;^UTILITY(U,$J,358.3,198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,198,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,198,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,198,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,199,0)
 ;;=G91.2^^3^27^27
 ;;^UTILITY(U,$J,358.3,199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,199,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavorial Disturbances
 ;;^UTILITY(U,$J,358.3,199,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,199,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,200,0)
 ;;=G30.8^^3^27^2
 ;;^UTILITY(U,$J,358.3,200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,200,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,200,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,200,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,201,0)
 ;;=A81.89^^3^27^6
 ;;^UTILITY(U,$J,358.3,201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,201,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,201,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,201,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,202,0)
 ;;=F19.97^^3^27^35
 ;;^UTILITY(U,$J,358.3,202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,202,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,202,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,202,2)
 ;;=^5003465
