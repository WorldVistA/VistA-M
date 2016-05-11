IBDEI0MT ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10642,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,10642,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,10642,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,10643,0)
 ;;=F03.91^^47^518^18
 ;;^UTILITY(U,$J,358.3,10643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10643,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,10643,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,10643,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,10644,0)
 ;;=F01.51^^47^518^37
 ;;^UTILITY(U,$J,358.3,10644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10644,1,3,0)
 ;;=3^Dementia,Vascular w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,10644,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,10644,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,10645,0)
 ;;=F01.50^^47^518^38
 ;;^UTILITY(U,$J,358.3,10645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10645,1,3,0)
 ;;=3^Dementia,Vascular w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,10645,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,10645,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,10646,0)
 ;;=R42.^^47^518^39
 ;;^UTILITY(U,$J,358.3,10646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10646,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,10646,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,10646,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,10647,0)
 ;;=R45.86^^47^518^40
 ;;^UTILITY(U,$J,358.3,10647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10647,1,3,0)
 ;;=3^Emotional Lability
 ;;^UTILITY(U,$J,358.3,10647,1,4,0)
 ;;=4^R45.86
 ;;^UTILITY(U,$J,358.3,10647,2)
 ;;=^5019475
 ;;^UTILITY(U,$J,358.3,10648,0)
 ;;=R44.3^^47^518^43
 ;;^UTILITY(U,$J,358.3,10648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10648,1,3,0)
 ;;=3^Hallucinations,Unspec
 ;;^UTILITY(U,$J,358.3,10648,1,4,0)
 ;;=4^R44.3
 ;;^UTILITY(U,$J,358.3,10648,2)
 ;;=^5019458
 ;;^UTILITY(U,$J,358.3,10649,0)
 ;;=R46.0^^47^518^46
 ;;^UTILITY(U,$J,358.3,10649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10649,1,3,0)
 ;;=3^Hygiene,Personal,Very Low Level
 ;;^UTILITY(U,$J,358.3,10649,1,4,0)
 ;;=4^R46.0
 ;;^UTILITY(U,$J,358.3,10649,2)
 ;;=^5019478
 ;;^UTILITY(U,$J,358.3,10650,0)
 ;;=Z91.83^^47^518^52
 ;;^UTILITY(U,$J,358.3,10650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10650,1,3,0)
 ;;=3^Personal Hx of Wandering
 ;;^UTILITY(U,$J,358.3,10650,1,4,0)
 ;;=4^Z91.83
 ;;^UTILITY(U,$J,358.3,10650,2)
 ;;=^5063627
 ;;^UTILITY(U,$J,358.3,10651,0)
 ;;=A81.9^^47^518^6
 ;;^UTILITY(U,$J,358.3,10651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10651,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,10651,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,10651,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,10652,0)
 ;;=A81.2^^47^518^53
 ;;^UTILITY(U,$J,358.3,10652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10652,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,10652,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,10652,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,10653,0)
 ;;=B20.^^47^518^41
 ;;^UTILITY(U,$J,358.3,10653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10653,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,10653,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,10653,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,10654,0)
 ;;=B20.^^47^518^42
 ;;^UTILITY(U,$J,358.3,10654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10654,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10654,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,10654,2)
 ;;=^5000555^F02.80
