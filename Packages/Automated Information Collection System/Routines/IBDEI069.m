IBDEI069 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2597,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,2597,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,2598,0)
 ;;=G30.8^^18^204^1
 ;;^UTILITY(U,$J,358.3,2598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2598,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,2598,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,2598,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,2599,0)
 ;;=G90.3^^18^204^47
 ;;^UTILITY(U,$J,358.3,2599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2599,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,2599,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,2599,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,2600,0)
 ;;=G91.2^^18^204^48
 ;;^UTILITY(U,$J,358.3,2600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2600,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,2600,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,2600,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,2601,0)
 ;;=G91.2^^18^204^49
 ;;^UTILITY(U,$J,358.3,2601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2601,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,2601,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,2601,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,2602,0)
 ;;=F43.21^^18^205^1
 ;;^UTILITY(U,$J,358.3,2602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2602,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,2602,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,2602,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,2603,0)
 ;;=F43.23^^18^205^2
 ;;^UTILITY(U,$J,358.3,2603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2603,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,2603,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,2603,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,2604,0)
 ;;=F10.10^^18^205^3
 ;;^UTILITY(U,$J,358.3,2604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2604,1,3,0)
 ;;=3^Alcohol Abuse Uncomplicated
 ;;^UTILITY(U,$J,358.3,2604,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,2604,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,2605,0)
 ;;=F10.20^^18^205^4
 ;;^UTILITY(U,$J,358.3,2605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2605,1,3,0)
 ;;=3^Alcohol Dependence Uncomplicated
 ;;^UTILITY(U,$J,358.3,2605,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,2605,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,2606,0)
 ;;=F31.81^^18^205^8
 ;;^UTILITY(U,$J,358.3,2606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2606,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,2606,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,2606,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,2607,0)
 ;;=F34.1^^18^205^9
 ;;^UTILITY(U,$J,358.3,2607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2607,1,3,0)
 ;;=3^Dysthymic Disorder
 ;;^UTILITY(U,$J,358.3,2607,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,2607,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,2608,0)
 ;;=F41.1^^18^205^5
 ;;^UTILITY(U,$J,358.3,2608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2608,1,3,0)
 ;;=3^Anxiety Disorder,Generalized
 ;;^UTILITY(U,$J,358.3,2608,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,2608,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,2609,0)
 ;;=F33.1^^18^205^11
 ;;^UTILITY(U,$J,358.3,2609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2609,1,3,0)
 ;;=3^MDD,Recurrent,Moderate
 ;;^UTILITY(U,$J,358.3,2609,1,4,0)
 ;;=4^F33.1
 ;;^UTILITY(U,$J,358.3,2609,2)
 ;;=^5003530
 ;;^UTILITY(U,$J,358.3,2610,0)
 ;;=F06.8^^18^205^13
 ;;^UTILITY(U,$J,358.3,2610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2610,1,3,0)
 ;;=3^Mental Disorders d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,2610,1,4,0)
 ;;=4^F06.8
