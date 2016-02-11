IBDEI07E ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2887,0)
 ;;=A81.2^^28^243^53
 ;;^UTILITY(U,$J,358.3,2887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2887,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,2887,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,2887,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,2888,0)
 ;;=B20.^^28^243^41
 ;;^UTILITY(U,$J,358.3,2888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2888,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,2888,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,2888,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,2889,0)
 ;;=B20.^^28^243^42
 ;;^UTILITY(U,$J,358.3,2889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2889,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,2889,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,2889,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,2890,0)
 ;;=G10.^^28^243^44
 ;;^UTILITY(U,$J,358.3,2890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2890,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,2890,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,2890,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,2891,0)
 ;;=G20.^^28^243^50
 ;;^UTILITY(U,$J,358.3,2891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2891,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,2891,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,2891,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,2892,0)
 ;;=G20.^^28^243^51
 ;;^UTILITY(U,$J,358.3,2892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2892,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,2892,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,2892,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,2893,0)
 ;;=G23.1^^28^243^54
 ;;^UTILITY(U,$J,358.3,2893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2893,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia
 ;;^UTILITY(U,$J,358.3,2893,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,2893,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,2894,0)
 ;;=G30.8^^28^243^1
 ;;^UTILITY(U,$J,358.3,2894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2894,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,2894,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,2894,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,2895,0)
 ;;=G90.3^^28^243^47
 ;;^UTILITY(U,$J,358.3,2895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2895,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,2895,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,2895,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,2896,0)
 ;;=G91.2^^28^243^48
 ;;^UTILITY(U,$J,358.3,2896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2896,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,2896,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,2896,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,2897,0)
 ;;=G91.2^^28^243^49
 ;;^UTILITY(U,$J,358.3,2897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2897,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,2897,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,2897,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,2898,0)
 ;;=F43.21^^28^244^1
 ;;^UTILITY(U,$J,358.3,2898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2898,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,2898,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,2898,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,2899,0)
 ;;=F43.23^^28^244^2
 ;;^UTILITY(U,$J,358.3,2899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2899,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
