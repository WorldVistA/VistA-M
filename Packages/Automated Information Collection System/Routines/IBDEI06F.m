IBDEI06F ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2407,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,2407,1,4,0)
 ;;=4^I70.222
 ;;^UTILITY(U,$J,358.3,2407,2)
 ;;=^5007584
 ;;^UTILITY(U,$J,358.3,2408,0)
 ;;=I70.223^^19^203^29
 ;;^UTILITY(U,$J,358.3,2408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2408,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,2408,1,4,0)
 ;;=4^I70.223
 ;;^UTILITY(U,$J,358.3,2408,2)
 ;;=^5007585
 ;;^UTILITY(U,$J,358.3,2409,0)
 ;;=I70.231^^19^203^38
 ;;^UTILITY(U,$J,358.3,2409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2409,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Thigh Ulceration
 ;;^UTILITY(U,$J,358.3,2409,1,4,0)
 ;;=4^I70.231
 ;;^UTILITY(U,$J,358.3,2409,2)
 ;;=^5007588
 ;;^UTILITY(U,$J,358.3,2410,0)
 ;;=I70.234^^19^203^39
 ;;^UTILITY(U,$J,358.3,2410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2410,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Heel/Midfoot Ulcer
 ;;^UTILITY(U,$J,358.3,2410,1,4,0)
 ;;=4^I70.234
 ;;^UTILITY(U,$J,358.3,2410,2)
 ;;=^5007591
 ;;^UTILITY(U,$J,358.3,2411,0)
 ;;=I70.239^^19^203^40
 ;;^UTILITY(U,$J,358.3,2411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2411,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,2411,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,2411,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,2412,0)
 ;;=I70.241^^19^203^34
 ;;^UTILITY(U,$J,358.3,2412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2412,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Thigh Ulceration
 ;;^UTILITY(U,$J,358.3,2412,1,4,0)
 ;;=4^I70.241
 ;;^UTILITY(U,$J,358.3,2412,2)
 ;;=^5007595
 ;;^UTILITY(U,$J,358.3,2413,0)
 ;;=I70.249^^19^203^35
 ;;^UTILITY(U,$J,358.3,2413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2413,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,2413,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,2413,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,2414,0)
 ;;=I70.262^^19^203^31
 ;;^UTILITY(U,$J,358.3,2414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2414,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,2414,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,2414,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,2415,0)
 ;;=I70.261^^19^203^41
 ;;^UTILITY(U,$J,358.3,2415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2415,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,2415,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,2415,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,2416,0)
 ;;=I70.263^^19^203^30
 ;;^UTILITY(U,$J,358.3,2416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2416,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Gangrene
 ;;^UTILITY(U,$J,358.3,2416,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,2416,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,2417,0)
 ;;=I70.301^^19^203^50
 ;;^UTILITY(U,$J,358.3,2417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2417,1,3,0)
 ;;=3^Athscl Unspec Type Bypass of Right Leg
 ;;^UTILITY(U,$J,358.3,2417,1,4,0)
 ;;=4^I70.301
 ;;^UTILITY(U,$J,358.3,2417,2)
 ;;=^5007611
 ;;^UTILITY(U,$J,358.3,2418,0)
 ;;=I70.302^^19^203^49
 ;;^UTILITY(U,$J,358.3,2418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2418,1,3,0)
 ;;=3^Athscl Unspec Type Bypass of Left Leg
 ;;^UTILITY(U,$J,358.3,2418,1,4,0)
 ;;=4^I70.302
 ;;^UTILITY(U,$J,358.3,2418,2)
 ;;=^5007612
 ;;^UTILITY(U,$J,358.3,2419,0)
 ;;=I70.303^^19^203^48
 ;;^UTILITY(U,$J,358.3,2419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2419,1,3,0)
 ;;=3^Athscl Unspec Type Bypass of Bilateral Legs
