IBDEI2ZD ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47595,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,47595,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,47596,0)
 ;;=R45.86^^185^2408^40
 ;;^UTILITY(U,$J,358.3,47596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47596,1,3,0)
 ;;=3^Emotional Lability
 ;;^UTILITY(U,$J,358.3,47596,1,4,0)
 ;;=4^R45.86
 ;;^UTILITY(U,$J,358.3,47596,2)
 ;;=^5019475
 ;;^UTILITY(U,$J,358.3,47597,0)
 ;;=R44.3^^185^2408^43
 ;;^UTILITY(U,$J,358.3,47597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47597,1,3,0)
 ;;=3^Hallucinations,Unspec
 ;;^UTILITY(U,$J,358.3,47597,1,4,0)
 ;;=4^R44.3
 ;;^UTILITY(U,$J,358.3,47597,2)
 ;;=^5019458
 ;;^UTILITY(U,$J,358.3,47598,0)
 ;;=R46.0^^185^2408^46
 ;;^UTILITY(U,$J,358.3,47598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47598,1,3,0)
 ;;=3^Hygiene,Personal,Very Low Level
 ;;^UTILITY(U,$J,358.3,47598,1,4,0)
 ;;=4^R46.0
 ;;^UTILITY(U,$J,358.3,47598,2)
 ;;=^5019478
 ;;^UTILITY(U,$J,358.3,47599,0)
 ;;=Z91.83^^185^2408^54
 ;;^UTILITY(U,$J,358.3,47599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47599,1,3,0)
 ;;=3^Personal Hx of Wandering
 ;;^UTILITY(U,$J,358.3,47599,1,4,0)
 ;;=4^Z91.83
 ;;^UTILITY(U,$J,358.3,47599,2)
 ;;=^5063627
 ;;^UTILITY(U,$J,358.3,47600,0)
 ;;=A81.9^^185^2408^6
 ;;^UTILITY(U,$J,358.3,47600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47600,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,47600,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,47600,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,47601,0)
 ;;=A81.2^^185^2408^55
 ;;^UTILITY(U,$J,358.3,47601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47601,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,47601,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,47601,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,47602,0)
 ;;=B20.^^185^2408^41
 ;;^UTILITY(U,$J,358.3,47602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47602,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,47602,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,47602,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,47603,0)
 ;;=B20.^^185^2408^42
 ;;^UTILITY(U,$J,358.3,47603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47603,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,47603,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,47603,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,47604,0)
 ;;=G10.^^185^2408^44
 ;;^UTILITY(U,$J,358.3,47604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47604,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,47604,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,47604,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,47605,0)
 ;;=G20.^^185^2408^52
 ;;^UTILITY(U,$J,358.3,47605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47605,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,47605,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,47605,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,47606,0)
 ;;=G20.^^185^2408^53
 ;;^UTILITY(U,$J,358.3,47606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47606,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,47606,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,47606,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,47607,0)
 ;;=G23.1^^185^2408^56
 ;;^UTILITY(U,$J,358.3,47607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47607,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia
