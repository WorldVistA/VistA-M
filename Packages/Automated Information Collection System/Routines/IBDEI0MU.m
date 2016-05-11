IBDEI0MU ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10655,0)
 ;;=G10.^^47^518^44
 ;;^UTILITY(U,$J,358.3,10655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10655,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10655,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,10655,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,10656,0)
 ;;=G20.^^47^518^50
 ;;^UTILITY(U,$J,358.3,10656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10656,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10656,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,10656,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,10657,0)
 ;;=G20.^^47^518^51
 ;;^UTILITY(U,$J,358.3,10657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10657,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10657,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,10657,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,10658,0)
 ;;=G23.1^^47^518^54
 ;;^UTILITY(U,$J,358.3,10658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10658,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia
 ;;^UTILITY(U,$J,358.3,10658,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,10658,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,10659,0)
 ;;=G30.8^^47^518^1
 ;;^UTILITY(U,$J,358.3,10659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10659,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,10659,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,10659,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,10660,0)
 ;;=G90.3^^47^518^47
 ;;^UTILITY(U,$J,358.3,10660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10660,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,10660,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,10660,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,10661,0)
 ;;=G91.2^^47^518^48
 ;;^UTILITY(U,$J,358.3,10661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10661,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10661,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,10661,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,10662,0)
 ;;=G91.2^^47^518^49
 ;;^UTILITY(U,$J,358.3,10662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10662,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10662,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,10662,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,10663,0)
 ;;=F43.21^^47^519^1
 ;;^UTILITY(U,$J,358.3,10663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10663,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,10663,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,10663,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,10664,0)
 ;;=F43.23^^47^519^2
 ;;^UTILITY(U,$J,358.3,10664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10664,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,10664,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,10664,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,10665,0)
 ;;=F10.10^^47^519^3
 ;;^UTILITY(U,$J,358.3,10665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10665,1,3,0)
 ;;=3^Alcohol Abuse Uncomplicated
 ;;^UTILITY(U,$J,358.3,10665,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,10665,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,10666,0)
 ;;=F10.20^^47^519^4
 ;;^UTILITY(U,$J,358.3,10666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10666,1,3,0)
 ;;=3^Alcohol Dependence Uncomplicated
 ;;^UTILITY(U,$J,358.3,10666,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,10666,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,10667,0)
 ;;=F31.81^^47^519^8
 ;;^UTILITY(U,$J,358.3,10667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10667,1,3,0)
 ;;=3^Bipolar II Disorder
