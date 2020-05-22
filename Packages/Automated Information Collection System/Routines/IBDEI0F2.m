IBDEI0F2 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6484,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,6484,1,4,0)
 ;;=4^I70.222
 ;;^UTILITY(U,$J,358.3,6484,2)
 ;;=^5007584
 ;;^UTILITY(U,$J,358.3,6485,0)
 ;;=I70.223^^53^417^31
 ;;^UTILITY(U,$J,358.3,6485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6485,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,6485,1,4,0)
 ;;=4^I70.223
 ;;^UTILITY(U,$J,358.3,6485,2)
 ;;=^5007585
 ;;^UTILITY(U,$J,358.3,6486,0)
 ;;=I70.231^^53^417^40
 ;;^UTILITY(U,$J,358.3,6486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6486,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Thigh Ulceration
 ;;^UTILITY(U,$J,358.3,6486,1,4,0)
 ;;=4^I70.231
 ;;^UTILITY(U,$J,358.3,6486,2)
 ;;=^5007588
 ;;^UTILITY(U,$J,358.3,6487,0)
 ;;=I70.234^^53^417^41
 ;;^UTILITY(U,$J,358.3,6487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6487,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Heel/Midfoot Ulcer
 ;;^UTILITY(U,$J,358.3,6487,1,4,0)
 ;;=4^I70.234
 ;;^UTILITY(U,$J,358.3,6487,2)
 ;;=^5007591
 ;;^UTILITY(U,$J,358.3,6488,0)
 ;;=I70.239^^53^417^42
 ;;^UTILITY(U,$J,358.3,6488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6488,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,6488,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,6488,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,6489,0)
 ;;=I70.241^^53^417^36
 ;;^UTILITY(U,$J,358.3,6489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6489,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Thigh Ulceration
 ;;^UTILITY(U,$J,358.3,6489,1,4,0)
 ;;=4^I70.241
 ;;^UTILITY(U,$J,358.3,6489,2)
 ;;=^5007595
 ;;^UTILITY(U,$J,358.3,6490,0)
 ;;=I70.249^^53^417^37
 ;;^UTILITY(U,$J,358.3,6490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6490,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,6490,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,6490,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,6491,0)
 ;;=I70.262^^53^417^33
 ;;^UTILITY(U,$J,358.3,6491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6491,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,6491,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,6491,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,6492,0)
 ;;=I70.261^^53^417^43
 ;;^UTILITY(U,$J,358.3,6492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6492,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,6492,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,6492,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,6493,0)
 ;;=I70.263^^53^417^32
 ;;^UTILITY(U,$J,358.3,6493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6493,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Gangrene
 ;;^UTILITY(U,$J,358.3,6493,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,6493,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,6494,0)
 ;;=I70.301^^53^417^52
 ;;^UTILITY(U,$J,358.3,6494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6494,1,3,0)
 ;;=3^Athscl Unspec Type Bypass of Right Leg
 ;;^UTILITY(U,$J,358.3,6494,1,4,0)
 ;;=4^I70.301
 ;;^UTILITY(U,$J,358.3,6494,2)
 ;;=^5007611
 ;;^UTILITY(U,$J,358.3,6495,0)
 ;;=I70.302^^53^417^51
 ;;^UTILITY(U,$J,358.3,6495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6495,1,3,0)
 ;;=3^Athscl Unspec Type Bypass of Left Leg
 ;;^UTILITY(U,$J,358.3,6495,1,4,0)
 ;;=4^I70.302
 ;;^UTILITY(U,$J,358.3,6495,2)
 ;;=^5007612
