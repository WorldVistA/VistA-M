IBDEI0TJ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13148,0)
 ;;=F01.50^^83^806^38
 ;;^UTILITY(U,$J,358.3,13148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13148,1,3,0)
 ;;=3^Dementia,Vascular w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,13148,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,13148,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,13149,0)
 ;;=R42.^^83^806^39
 ;;^UTILITY(U,$J,358.3,13149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13149,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,13149,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,13149,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,13150,0)
 ;;=R45.86^^83^806^40
 ;;^UTILITY(U,$J,358.3,13150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13150,1,3,0)
 ;;=3^Emotional Lability
 ;;^UTILITY(U,$J,358.3,13150,1,4,0)
 ;;=4^R45.86
 ;;^UTILITY(U,$J,358.3,13150,2)
 ;;=^5019475
 ;;^UTILITY(U,$J,358.3,13151,0)
 ;;=R44.3^^83^806^43
 ;;^UTILITY(U,$J,358.3,13151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13151,1,3,0)
 ;;=3^Hallucinations,Unspec
 ;;^UTILITY(U,$J,358.3,13151,1,4,0)
 ;;=4^R44.3
 ;;^UTILITY(U,$J,358.3,13151,2)
 ;;=^5019458
 ;;^UTILITY(U,$J,358.3,13152,0)
 ;;=R46.0^^83^806^46
 ;;^UTILITY(U,$J,358.3,13152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13152,1,3,0)
 ;;=3^Hygiene,Personal,Very Low Level
 ;;^UTILITY(U,$J,358.3,13152,1,4,0)
 ;;=4^R46.0
 ;;^UTILITY(U,$J,358.3,13152,2)
 ;;=^5019478
 ;;^UTILITY(U,$J,358.3,13153,0)
 ;;=Z91.83^^83^806^54
 ;;^UTILITY(U,$J,358.3,13153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13153,1,3,0)
 ;;=3^Personal Hx of Wandering
 ;;^UTILITY(U,$J,358.3,13153,1,4,0)
 ;;=4^Z91.83
 ;;^UTILITY(U,$J,358.3,13153,2)
 ;;=^5063627
 ;;^UTILITY(U,$J,358.3,13154,0)
 ;;=A81.9^^83^806^6
 ;;^UTILITY(U,$J,358.3,13154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13154,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,13154,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,13154,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,13155,0)
 ;;=A81.2^^83^806^55
 ;;^UTILITY(U,$J,358.3,13155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13155,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,13155,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,13155,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,13156,0)
 ;;=B20.^^83^806^41
 ;;^UTILITY(U,$J,358.3,13156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13156,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,13156,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,13156,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,13157,0)
 ;;=B20.^^83^806^42
 ;;^UTILITY(U,$J,358.3,13157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13157,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,13157,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,13157,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,13158,0)
 ;;=G10.^^83^806^44
 ;;^UTILITY(U,$J,358.3,13158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13158,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,13158,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,13158,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,13159,0)
 ;;=G20.^^83^806^52
 ;;^UTILITY(U,$J,358.3,13159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13159,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,13159,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,13159,2)
 ;;=^5003770^F02.81
