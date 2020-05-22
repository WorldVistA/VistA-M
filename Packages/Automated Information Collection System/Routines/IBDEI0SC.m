IBDEI0SC ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12638,1,3,0)
 ;;=3^Diabetes d/t Underlying Condition w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,12638,1,4,0)
 ;;=4^E08.621
 ;;^UTILITY(U,$J,358.3,12638,2)
 ;;=^5002534
 ;;^UTILITY(U,$J,358.3,12639,0)
 ;;=E09.621^^80^786^85
 ;;^UTILITY(U,$J,358.3,12639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12639,1,3,0)
 ;;=3^Diabetes d/t Drug/Chemical Induced w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,12639,1,4,0)
 ;;=4^E09.621
 ;;^UTILITY(U,$J,358.3,12639,2)
 ;;=^5002576
 ;;^UTILITY(U,$J,358.3,12640,0)
 ;;=I70.231^^80^786^22
 ;;^UTILITY(U,$J,358.3,12640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12640,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Thigh Ulcer
 ;;^UTILITY(U,$J,358.3,12640,1,4,0)
 ;;=4^I70.231
 ;;^UTILITY(U,$J,358.3,12640,2)
 ;;=^5007588
 ;;^UTILITY(U,$J,358.3,12641,0)
 ;;=I70.232^^80^786^23
 ;;^UTILITY(U,$J,358.3,12641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12641,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Calf Ulcer
 ;;^UTILITY(U,$J,358.3,12641,1,4,0)
 ;;=4^I70.232
 ;;^UTILITY(U,$J,358.3,12641,2)
 ;;=^5007589
 ;;^UTILITY(U,$J,358.3,12642,0)
 ;;=I70.233^^80^786^24
 ;;^UTILITY(U,$J,358.3,12642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12642,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Ankle Ulcer
 ;;^UTILITY(U,$J,358.3,12642,1,4,0)
 ;;=4^I70.233
 ;;^UTILITY(U,$J,358.3,12642,2)
 ;;=^5007590
 ;;^UTILITY(U,$J,358.3,12643,0)
 ;;=I70.234^^80^786^25
 ;;^UTILITY(U,$J,358.3,12643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12643,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Heel/Midfoot Ulcer
 ;;^UTILITY(U,$J,358.3,12643,1,4,0)
 ;;=4^I70.234
 ;;^UTILITY(U,$J,358.3,12643,2)
 ;;=^5007591
 ;;^UTILITY(U,$J,358.3,12644,0)
 ;;=I70.235^^80^786^26
 ;;^UTILITY(U,$J,358.3,12644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12644,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,12644,1,4,0)
 ;;=4^I70.235
 ;;^UTILITY(U,$J,358.3,12644,2)
 ;;=^5007592
 ;;^UTILITY(U,$J,358.3,12645,0)
 ;;=I70.238^^80^786^27
 ;;^UTILITY(U,$J,358.3,12645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12645,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Lower Leg Ulcer
 ;;^UTILITY(U,$J,358.3,12645,1,4,0)
 ;;=4^I70.238
 ;;^UTILITY(U,$J,358.3,12645,2)
 ;;=^5007593
 ;;^UTILITY(U,$J,358.3,12646,0)
 ;;=I70.239^^80^786^28
 ;;^UTILITY(U,$J,358.3,12646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12646,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Ulcer,Unspec Site
 ;;^UTILITY(U,$J,358.3,12646,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,12646,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,12647,0)
 ;;=I70.241^^80^786^20
 ;;^UTILITY(U,$J,358.3,12647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12647,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Thigh Ulcer
 ;;^UTILITY(U,$J,358.3,12647,1,4,0)
 ;;=4^I70.241
 ;;^UTILITY(U,$J,358.3,12647,2)
 ;;=^5007595
 ;;^UTILITY(U,$J,358.3,12648,0)
 ;;=I70.242^^80^786^16
 ;;^UTILITY(U,$J,358.3,12648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12648,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Calf Ulcer
 ;;^UTILITY(U,$J,358.3,12648,1,4,0)
 ;;=4^I70.242
 ;;^UTILITY(U,$J,358.3,12648,2)
 ;;=^5007596
 ;;^UTILITY(U,$J,358.3,12649,0)
 ;;=I70.243^^80^786^15
 ;;^UTILITY(U,$J,358.3,12649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12649,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Ankle Ulcer
 ;;^UTILITY(U,$J,358.3,12649,1,4,0)
 ;;=4^I70.243
