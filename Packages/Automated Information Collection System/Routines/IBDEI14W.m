IBDEI14W ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19297,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,19297,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,19297,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,19298,0)
 ;;=I65.22^^84^916^16
 ;;^UTILITY(U,$J,358.3,19298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19298,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,19298,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,19298,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,19299,0)
 ;;=I65.23^^84^916^15
 ;;^UTILITY(U,$J,358.3,19299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19299,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,19299,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,19299,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,19300,0)
 ;;=I65.21^^84^916^17
 ;;^UTILITY(U,$J,358.3,19300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19300,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,19300,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,19300,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,19301,0)
 ;;=I70.219^^84^916^3
 ;;^UTILITY(U,$J,358.3,19301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19301,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,19301,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,19301,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,19302,0)
 ;;=I70.213^^84^916^4
 ;;^UTILITY(U,$J,358.3,19302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19302,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
 ;;^UTILITY(U,$J,358.3,19302,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,19302,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,19303,0)
 ;;=I70.212^^84^916^5
 ;;^UTILITY(U,$J,358.3,19303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19303,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Left Leg
 ;;^UTILITY(U,$J,358.3,19303,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,19303,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,19304,0)
 ;;=I70.211^^84^916^6
 ;;^UTILITY(U,$J,358.3,19304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19304,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Right Leg
 ;;^UTILITY(U,$J,358.3,19304,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,19304,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,19305,0)
 ;;=I70.25^^84^916^2
 ;;^UTILITY(U,$J,358.3,19305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19305,1,3,0)
 ;;=3^Athscl Native Arteries of Extremitis w/ Ulceration
 ;;^UTILITY(U,$J,358.3,19305,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,19305,2)
 ;;=^5007602
 ;;^UTILITY(U,$J,358.3,19306,0)
 ;;=I70.249^^84^916^7
 ;;^UTILITY(U,$J,358.3,19306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19306,1,3,0)
 ;;=3^Athscl Natv Art of Lt Leg w/ Ulceration of Unspec Site
 ;;^UTILITY(U,$J,358.3,19306,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,19306,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,19307,0)
 ;;=I70.239^^84^916^8
 ;;^UTILITY(U,$J,358.3,19307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19307,1,3,0)
 ;;=3^Athscl Natv Art of Rt Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,19307,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,19307,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,19308,0)
 ;;=I70.269^^84^916^9
 ;;^UTILITY(U,$J,358.3,19308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19308,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Unspec Extremity
 ;;^UTILITY(U,$J,358.3,19308,1,4,0)
 ;;=4^I70.269
 ;;^UTILITY(U,$J,358.3,19308,2)
 ;;=^5007607
 ;;^UTILITY(U,$J,358.3,19309,0)
 ;;=I70.263^^84^916^10
 ;;^UTILITY(U,$J,358.3,19309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19309,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Bilateral Legs
