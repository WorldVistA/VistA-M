IBDEI0R0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12671,0)
 ;;=I65.29^^53^580^18
 ;;^UTILITY(U,$J,358.3,12671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12671,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,12671,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,12671,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,12672,0)
 ;;=I65.22^^53^580^16
 ;;^UTILITY(U,$J,358.3,12672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12672,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,12672,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,12672,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,12673,0)
 ;;=I65.23^^53^580^15
 ;;^UTILITY(U,$J,358.3,12673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12673,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,12673,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,12673,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,12674,0)
 ;;=I65.21^^53^580^17
 ;;^UTILITY(U,$J,358.3,12674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12674,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,12674,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,12674,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,12675,0)
 ;;=I70.219^^53^580^3
 ;;^UTILITY(U,$J,358.3,12675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12675,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,12675,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,12675,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,12676,0)
 ;;=I70.213^^53^580^4
 ;;^UTILITY(U,$J,358.3,12676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12676,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
 ;;^UTILITY(U,$J,358.3,12676,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,12676,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,12677,0)
 ;;=I70.212^^53^580^5
 ;;^UTILITY(U,$J,358.3,12677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12677,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Left Leg
 ;;^UTILITY(U,$J,358.3,12677,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,12677,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,12678,0)
 ;;=I70.211^^53^580^6
 ;;^UTILITY(U,$J,358.3,12678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12678,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Right Leg
 ;;^UTILITY(U,$J,358.3,12678,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,12678,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,12679,0)
 ;;=I70.25^^53^580^2
 ;;^UTILITY(U,$J,358.3,12679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12679,1,3,0)
 ;;=3^Athscl Native Arteries of Extremitis w/ Ulceration
 ;;^UTILITY(U,$J,358.3,12679,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,12679,2)
 ;;=^5007602
 ;;^UTILITY(U,$J,358.3,12680,0)
 ;;=I70.249^^53^580^7
 ;;^UTILITY(U,$J,358.3,12680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12680,1,3,0)
 ;;=3^Athscl Natv Art of Lt Leg w/ Ulceration of Unspec Site
 ;;^UTILITY(U,$J,358.3,12680,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,12680,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,12681,0)
 ;;=I70.239^^53^580^8
 ;;^UTILITY(U,$J,358.3,12681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12681,1,3,0)
 ;;=3^Athscl Natv Art of Rt Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,12681,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,12681,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,12682,0)
 ;;=I70.269^^53^580^9
 ;;^UTILITY(U,$J,358.3,12682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12682,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Unspec Extremity
 ;;^UTILITY(U,$J,358.3,12682,1,4,0)
 ;;=4^I70.269
 ;;^UTILITY(U,$J,358.3,12682,2)
 ;;=^5007607
 ;;^UTILITY(U,$J,358.3,12683,0)
 ;;=I70.263^^53^580^10
