IBDEI0HG ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7810,1,3,0)
 ;;=3^Atherosclerosis,Unspec
 ;;^UTILITY(U,$J,358.3,7810,1,4,0)
 ;;=4^I70.90
 ;;^UTILITY(U,$J,358.3,7810,2)
 ;;=^5007784
 ;;^UTILITY(U,$J,358.3,7811,0)
 ;;=I73.9^^55^528^22
 ;;^UTILITY(U,$J,358.3,7811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7811,1,3,0)
 ;;=3^Peripheral vascular disease, unspecified
 ;;^UTILITY(U,$J,358.3,7811,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,7811,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,7812,0)
 ;;=I82.401^^55^528^3
 ;;^UTILITY(U,$J,358.3,7812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7812,1,3,0)
 ;;=3^Ac Embolism/Thombos Unspec Deep Veins,Right Lower Extrm
 ;;^UTILITY(U,$J,358.3,7812,1,4,0)
 ;;=4^I82.401
 ;;^UTILITY(U,$J,358.3,7812,2)
 ;;=^5007854
 ;;^UTILITY(U,$J,358.3,7813,0)
 ;;=I82.402^^55^528^2
 ;;^UTILITY(U,$J,358.3,7813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7813,1,3,0)
 ;;=3^Ac Embolism/Thombos Unspec Deep Veins,Left Lower Extrm
 ;;^UTILITY(U,$J,358.3,7813,1,4,0)
 ;;=4^I82.402
 ;;^UTILITY(U,$J,358.3,7813,2)
 ;;=^5007855
 ;;^UTILITY(U,$J,358.3,7814,0)
 ;;=I82.403^^55^528^1
 ;;^UTILITY(U,$J,358.3,7814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7814,1,3,0)
 ;;=3^Ac Embolism/Thombos Unspec Deep Veins,Bilat Lower Extrm
 ;;^UTILITY(U,$J,358.3,7814,1,4,0)
 ;;=4^I82.403
 ;;^UTILITY(U,$J,358.3,7814,2)
 ;;=^5007856
 ;;^UTILITY(U,$J,358.3,7815,0)
 ;;=R00.2^^55^528^21
 ;;^UTILITY(U,$J,358.3,7815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7815,1,3,0)
 ;;=3^Palpitations
 ;;^UTILITY(U,$J,358.3,7815,1,4,0)
 ;;=4^R00.2
 ;;^UTILITY(U,$J,358.3,7815,2)
 ;;=^5019165
 ;;^UTILITY(U,$J,358.3,7816,0)
 ;;=R01.1^^55^528^9
 ;;^UTILITY(U,$J,358.3,7816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7816,1,3,0)
 ;;=3^Cardiac murmur, unspecified
 ;;^UTILITY(U,$J,358.3,7816,1,4,0)
 ;;=4^R01.1
 ;;^UTILITY(U,$J,358.3,7816,2)
 ;;=^5019169
 ;;^UTILITY(U,$J,358.3,7817,0)
 ;;=R07.9^^55^528^11
 ;;^UTILITY(U,$J,358.3,7817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7817,1,3,0)
 ;;=3^Chest pain, unspecified
 ;;^UTILITY(U,$J,358.3,7817,1,4,0)
 ;;=4^R07.9
 ;;^UTILITY(U,$J,358.3,7817,2)
 ;;=^5019201
 ;;^UTILITY(U,$J,358.3,7818,0)
 ;;=N18.1^^55^529^1
 ;;^UTILITY(U,$J,358.3,7818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7818,1,3,0)
 ;;=3^Chronic kidney disease, stage 1
 ;;^UTILITY(U,$J,358.3,7818,1,4,0)
 ;;=4^N18.1
 ;;^UTILITY(U,$J,358.3,7818,2)
 ;;=^5015602
 ;;^UTILITY(U,$J,358.3,7819,0)
 ;;=N18.2^^55^529^2
 ;;^UTILITY(U,$J,358.3,7819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7819,1,3,0)
 ;;=3^Chronic kidney disease, stage 2 (mild)
 ;;^UTILITY(U,$J,358.3,7819,1,4,0)
 ;;=4^N18.2
 ;;^UTILITY(U,$J,358.3,7819,2)
 ;;=^5015603
 ;;^UTILITY(U,$J,358.3,7820,0)
 ;;=N18.3^^55^529^3
 ;;^UTILITY(U,$J,358.3,7820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7820,1,3,0)
 ;;=3^Chronic kidney disease, stage 3 (moderate)
 ;;^UTILITY(U,$J,358.3,7820,1,4,0)
 ;;=4^N18.3
 ;;^UTILITY(U,$J,358.3,7820,2)
 ;;=^5015604
 ;;^UTILITY(U,$J,358.3,7821,0)
 ;;=N18.4^^55^529^4
 ;;^UTILITY(U,$J,358.3,7821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7821,1,3,0)
 ;;=3^Chronic kidney disease, stage 4 (severe)
 ;;^UTILITY(U,$J,358.3,7821,1,4,0)
 ;;=4^N18.4
 ;;^UTILITY(U,$J,358.3,7821,2)
 ;;=^5015605
 ;;^UTILITY(U,$J,358.3,7822,0)
 ;;=N18.5^^55^529^5
 ;;^UTILITY(U,$J,358.3,7822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7822,1,3,0)
 ;;=3^Chronic kidney disease, stage 5
 ;;^UTILITY(U,$J,358.3,7822,1,4,0)
 ;;=4^N18.5
 ;;^UTILITY(U,$J,358.3,7822,2)
 ;;=^5015606
 ;;^UTILITY(U,$J,358.3,7823,0)
 ;;=N18.6^^55^529^6
 ;;^UTILITY(U,$J,358.3,7823,1,0)
 ;;=^358.31IA^4^2
