IBDEI2FH ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38790,1,3,0)
 ;;=3^Angina Pectoris,Oth Forms
 ;;^UTILITY(U,$J,358.3,38790,1,4,0)
 ;;=4^I20.8
 ;;^UTILITY(U,$J,358.3,38790,2)
 ;;=^5007078
 ;;^UTILITY(U,$J,358.3,38791,0)
 ;;=I20.1^^152^1987^1
 ;;^UTILITY(U,$J,358.3,38791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38791,1,3,0)
 ;;=3^Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,38791,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,38791,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,38792,0)
 ;;=I20.9^^152^1987^3
 ;;^UTILITY(U,$J,358.3,38792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38792,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,38792,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,38792,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,38793,0)
 ;;=I65.29^^152^1988^31
 ;;^UTILITY(U,$J,358.3,38793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38793,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,38793,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,38793,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,38794,0)
 ;;=I65.22^^152^1988^29
 ;;^UTILITY(U,$J,358.3,38794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38794,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,38794,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,38794,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,38795,0)
 ;;=I65.23^^152^1988^28
 ;;^UTILITY(U,$J,358.3,38795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38795,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,38795,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,38795,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,38796,0)
 ;;=I65.21^^152^1988^30
 ;;^UTILITY(U,$J,358.3,38796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38796,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,38796,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,38796,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,38797,0)
 ;;=I70.219^^152^1988^7
 ;;^UTILITY(U,$J,358.3,38797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38797,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,38797,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,38797,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,38798,0)
 ;;=I70.213^^152^1988^8
 ;;^UTILITY(U,$J,358.3,38798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38798,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
 ;;^UTILITY(U,$J,358.3,38798,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,38798,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,38799,0)
 ;;=I70.212^^152^1988^9
 ;;^UTILITY(U,$J,358.3,38799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38799,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Left Leg
 ;;^UTILITY(U,$J,358.3,38799,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,38799,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,38800,0)
 ;;=I70.211^^152^1988^10
 ;;^UTILITY(U,$J,358.3,38800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38800,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Right Leg
 ;;^UTILITY(U,$J,358.3,38800,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,38800,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,38801,0)
 ;;=I70.25^^152^1988^6
 ;;^UTILITY(U,$J,358.3,38801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38801,1,3,0)
 ;;=3^Athscl Native Arteries of Extremitis w/ Ulceration
 ;;^UTILITY(U,$J,358.3,38801,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,38801,2)
 ;;=^5007602
