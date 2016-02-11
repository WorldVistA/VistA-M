IBDEI134 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18112,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,18112,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,18113,0)
 ;;=I25.810^^94^902^8
 ;;^UTILITY(U,$J,358.3,18113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18113,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,18113,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,18113,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,18114,0)
 ;;=I65.29^^94^903^18
 ;;^UTILITY(U,$J,358.3,18114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18114,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,18114,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,18114,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,18115,0)
 ;;=I65.22^^94^903^16
 ;;^UTILITY(U,$J,358.3,18115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18115,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,18115,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,18115,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,18116,0)
 ;;=I65.23^^94^903^15
 ;;^UTILITY(U,$J,358.3,18116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18116,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,18116,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,18116,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,18117,0)
 ;;=I65.21^^94^903^17
 ;;^UTILITY(U,$J,358.3,18117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18117,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,18117,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,18117,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,18118,0)
 ;;=I70.219^^94^903^3
 ;;^UTILITY(U,$J,358.3,18118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18118,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,18118,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,18118,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,18119,0)
 ;;=I70.213^^94^903^4
 ;;^UTILITY(U,$J,358.3,18119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18119,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
 ;;^UTILITY(U,$J,358.3,18119,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,18119,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,18120,0)
 ;;=I70.212^^94^903^5
 ;;^UTILITY(U,$J,358.3,18120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18120,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Left Leg
 ;;^UTILITY(U,$J,358.3,18120,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,18120,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,18121,0)
 ;;=I70.211^^94^903^6
 ;;^UTILITY(U,$J,358.3,18121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18121,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Right Leg
 ;;^UTILITY(U,$J,358.3,18121,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,18121,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,18122,0)
 ;;=I70.25^^94^903^2
 ;;^UTILITY(U,$J,358.3,18122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18122,1,3,0)
 ;;=3^Athscl Native Arteries of Extremitis w/ Ulceration
 ;;^UTILITY(U,$J,358.3,18122,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,18122,2)
 ;;=^5007602
 ;;^UTILITY(U,$J,358.3,18123,0)
 ;;=I70.249^^94^903^7
 ;;^UTILITY(U,$J,358.3,18123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18123,1,3,0)
 ;;=3^Athscl Natv Art of Lt Leg w/ Ulceration of Unspec Site
 ;;^UTILITY(U,$J,358.3,18123,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,18123,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,18124,0)
 ;;=I70.239^^94^903^8
 ;;^UTILITY(U,$J,358.3,18124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18124,1,3,0)
 ;;=3^Athscl Natv Art of Rt Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,18124,1,4,0)
 ;;=4^I70.239
