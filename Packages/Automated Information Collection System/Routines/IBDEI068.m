IBDEI068 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2584,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,2584,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,2585,0)
 ;;=R42.^^18^204^39
 ;;^UTILITY(U,$J,358.3,2585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2585,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,2585,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,2585,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,2586,0)
 ;;=R45.86^^18^204^40
 ;;^UTILITY(U,$J,358.3,2586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2586,1,3,0)
 ;;=3^Emotional Lability
 ;;^UTILITY(U,$J,358.3,2586,1,4,0)
 ;;=4^R45.86
 ;;^UTILITY(U,$J,358.3,2586,2)
 ;;=^5019475
 ;;^UTILITY(U,$J,358.3,2587,0)
 ;;=R44.3^^18^204^43
 ;;^UTILITY(U,$J,358.3,2587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2587,1,3,0)
 ;;=3^Hallucinations,Unspec
 ;;^UTILITY(U,$J,358.3,2587,1,4,0)
 ;;=4^R44.3
 ;;^UTILITY(U,$J,358.3,2587,2)
 ;;=^5019458
 ;;^UTILITY(U,$J,358.3,2588,0)
 ;;=R46.0^^18^204^46
 ;;^UTILITY(U,$J,358.3,2588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2588,1,3,0)
 ;;=3^Hygiene,Personal,Very Low Level
 ;;^UTILITY(U,$J,358.3,2588,1,4,0)
 ;;=4^R46.0
 ;;^UTILITY(U,$J,358.3,2588,2)
 ;;=^5019478
 ;;^UTILITY(U,$J,358.3,2589,0)
 ;;=Z91.83^^18^204^52
 ;;^UTILITY(U,$J,358.3,2589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2589,1,3,0)
 ;;=3^Personal Hx of Wandering
 ;;^UTILITY(U,$J,358.3,2589,1,4,0)
 ;;=4^Z91.83
 ;;^UTILITY(U,$J,358.3,2589,2)
 ;;=^5063627
 ;;^UTILITY(U,$J,358.3,2590,0)
 ;;=A81.9^^18^204^6
 ;;^UTILITY(U,$J,358.3,2590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2590,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,2590,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,2590,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,2591,0)
 ;;=A81.2^^18^204^53
 ;;^UTILITY(U,$J,358.3,2591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2591,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,2591,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,2591,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,2592,0)
 ;;=B20.^^18^204^41
 ;;^UTILITY(U,$J,358.3,2592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2592,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,2592,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,2592,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,2593,0)
 ;;=B20.^^18^204^42
 ;;^UTILITY(U,$J,358.3,2593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2593,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,2593,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,2593,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,2594,0)
 ;;=G10.^^18^204^44
 ;;^UTILITY(U,$J,358.3,2594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2594,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,2594,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,2594,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,2595,0)
 ;;=G20.^^18^204^50
 ;;^UTILITY(U,$J,358.3,2595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2595,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,2595,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,2595,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,2596,0)
 ;;=G20.^^18^204^51
 ;;^UTILITY(U,$J,358.3,2596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2596,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,2596,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,2596,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,2597,0)
 ;;=G23.1^^18^204^54
 ;;^UTILITY(U,$J,358.3,2597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2597,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia
