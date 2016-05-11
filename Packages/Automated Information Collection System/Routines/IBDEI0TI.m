IBDEI0TI ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13836,2)
 ;;=^5008826
 ;;^UTILITY(U,$J,358.3,13837,0)
 ;;=K75.3^^53^596^13
 ;;^UTILITY(U,$J,358.3,13837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13837,1,3,0)
 ;;=3^Granulomatous Hepatitis NEC
 ;;^UTILITY(U,$J,358.3,13837,1,4,0)
 ;;=4^K75.3
 ;;^UTILITY(U,$J,358.3,13837,2)
 ;;=^5008827
 ;;^UTILITY(U,$J,358.3,13838,0)
 ;;=K76.6^^53^596^22
 ;;^UTILITY(U,$J,358.3,13838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13838,1,3,0)
 ;;=3^Portal Hypertension
 ;;^UTILITY(U,$J,358.3,13838,1,4,0)
 ;;=4^K76.6
 ;;^UTILITY(U,$J,358.3,13838,2)
 ;;=^5008834
 ;;^UTILITY(U,$J,358.3,13839,0)
 ;;=F20.3^^53^597^25
 ;;^UTILITY(U,$J,358.3,13839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13839,1,3,0)
 ;;=3^Undifferentiated/Atypical Schizophrenia
 ;;^UTILITY(U,$J,358.3,13839,1,4,0)
 ;;=4^F20.3
 ;;^UTILITY(U,$J,358.3,13839,2)
 ;;=^5003472
 ;;^UTILITY(U,$J,358.3,13840,0)
 ;;=F20.9^^53^597^21
 ;;^UTILITY(U,$J,358.3,13840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13840,1,3,0)
 ;;=3^Schizophrenia,Unspec
 ;;^UTILITY(U,$J,358.3,13840,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,13840,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,13841,0)
 ;;=F31.9^^53^597^6
 ;;^UTILITY(U,$J,358.3,13841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13841,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,13841,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,13841,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,13842,0)
 ;;=F31.72^^53^597^7
 ;;^UTILITY(U,$J,358.3,13842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13842,1,3,0)
 ;;=3^Bipolr Disorder,Full Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,13842,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,13842,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,13843,0)
 ;;=F31.71^^53^597^5
 ;;^UTILITY(U,$J,358.3,13843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13843,1,3,0)
 ;;=3^Bipolar Disorder,Part Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,13843,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,13843,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,13844,0)
 ;;=F31.70^^53^597^4
 ;;^UTILITY(U,$J,358.3,13844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13844,1,3,0)
 ;;=3^Bipolar Disorder,In Remis,Most Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,13844,1,4,0)
 ;;=4^F31.70
 ;;^UTILITY(U,$J,358.3,13844,2)
 ;;=^5003510
 ;;^UTILITY(U,$J,358.3,13845,0)
 ;;=F29.^^53^597^19
 ;;^UTILITY(U,$J,358.3,13845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13845,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,13845,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,13845,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,13846,0)
 ;;=F28.^^53^597^20
 ;;^UTILITY(U,$J,358.3,13846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13846,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond NEC
 ;;^UTILITY(U,$J,358.3,13846,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,13846,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,13847,0)
 ;;=F41.9^^53^597^3
 ;;^UTILITY(U,$J,358.3,13847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13847,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,13847,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,13847,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,13848,0)
 ;;=F42.^^53^597^13
 ;;^UTILITY(U,$J,358.3,13848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13848,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,13848,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,13848,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,13849,0)
 ;;=F45.0^^53^597^23
 ;;^UTILITY(U,$J,358.3,13849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13849,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,13849,1,4,0)
 ;;=4^F45.0
