IBDEI0LX ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10004,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,10005,0)
 ;;=I70.25^^68^662^2
 ;;^UTILITY(U,$J,358.3,10005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10005,1,3,0)
 ;;=3^Athscl Native Arteries of Extremitis w/ Ulceration
 ;;^UTILITY(U,$J,358.3,10005,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,10005,2)
 ;;=^5007602
 ;;^UTILITY(U,$J,358.3,10006,0)
 ;;=I70.249^^68^662^7
 ;;^UTILITY(U,$J,358.3,10006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10006,1,3,0)
 ;;=3^Athscl Natv Art of Lt Leg w/ Ulceration of Unspec Site
 ;;^UTILITY(U,$J,358.3,10006,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,10006,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,10007,0)
 ;;=I70.239^^68^662^8
 ;;^UTILITY(U,$J,358.3,10007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10007,1,3,0)
 ;;=3^Athscl Natv Art of Rt Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,10007,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,10007,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,10008,0)
 ;;=I70.269^^68^662^9
 ;;^UTILITY(U,$J,358.3,10008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10008,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Unspec Extremity
 ;;^UTILITY(U,$J,358.3,10008,1,4,0)
 ;;=4^I70.269
 ;;^UTILITY(U,$J,358.3,10008,2)
 ;;=^5007607
 ;;^UTILITY(U,$J,358.3,10009,0)
 ;;=I70.263^^68^662^10
 ;;^UTILITY(U,$J,358.3,10009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10009,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Bilateral Legs
 ;;^UTILITY(U,$J,358.3,10009,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,10009,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,10010,0)
 ;;=I70.262^^68^662^11
 ;;^UTILITY(U,$J,358.3,10010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10010,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Left Leg
 ;;^UTILITY(U,$J,358.3,10010,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,10010,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,10011,0)
 ;;=I70.261^^68^662^12
 ;;^UTILITY(U,$J,358.3,10011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10011,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Right Leg
 ;;^UTILITY(U,$J,358.3,10011,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,10011,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,10012,0)
 ;;=I71.2^^68^662^20
 ;;^UTILITY(U,$J,358.3,10012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10012,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,10012,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,10012,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,10013,0)
 ;;=I71.4^^68^662^1
 ;;^UTILITY(U,$J,358.3,10013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10013,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,10013,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,10013,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,10014,0)
 ;;=I73.9^^68^662^19
 ;;^UTILITY(U,$J,358.3,10014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10014,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,10014,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,10014,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,10015,0)
 ;;=I82.891^^68^662^14
 ;;^UTILITY(U,$J,358.3,10015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10015,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Chronic
 ;;^UTILITY(U,$J,358.3,10015,1,4,0)
 ;;=4^I82.891
 ;;^UTILITY(U,$J,358.3,10015,2)
 ;;=^5007939
 ;;^UTILITY(U,$J,358.3,10016,0)
 ;;=I82.890^^68^662^13
 ;;^UTILITY(U,$J,358.3,10016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10016,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Acute
 ;;^UTILITY(U,$J,358.3,10016,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,10016,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,10017,0)
 ;;=E78.0^^68^663^12
