IBDEI34F ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,49850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49850,1,3,0)
 ;;=3^Angina Pectoris,Oth Forms
 ;;^UTILITY(U,$J,358.3,49850,1,4,0)
 ;;=4^I20.8
 ;;^UTILITY(U,$J,358.3,49850,2)
 ;;=^5007078
 ;;^UTILITY(U,$J,358.3,49851,0)
 ;;=I20.1^^193^2484^1
 ;;^UTILITY(U,$J,358.3,49851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49851,1,3,0)
 ;;=3^Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,49851,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,49851,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,49852,0)
 ;;=I20.9^^193^2484^3
 ;;^UTILITY(U,$J,358.3,49852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49852,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,49852,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,49852,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,49853,0)
 ;;=I65.29^^193^2485^31
 ;;^UTILITY(U,$J,358.3,49853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49853,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,49853,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,49853,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,49854,0)
 ;;=I65.22^^193^2485^29
 ;;^UTILITY(U,$J,358.3,49854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49854,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,49854,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,49854,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,49855,0)
 ;;=I65.23^^193^2485^28
 ;;^UTILITY(U,$J,358.3,49855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49855,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,49855,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,49855,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,49856,0)
 ;;=I65.21^^193^2485^30
 ;;^UTILITY(U,$J,358.3,49856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49856,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,49856,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,49856,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,49857,0)
 ;;=I70.219^^193^2485^7
 ;;^UTILITY(U,$J,358.3,49857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49857,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,49857,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,49857,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,49858,0)
 ;;=I70.213^^193^2485^8
 ;;^UTILITY(U,$J,358.3,49858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49858,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
 ;;^UTILITY(U,$J,358.3,49858,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,49858,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,49859,0)
 ;;=I70.212^^193^2485^9
 ;;^UTILITY(U,$J,358.3,49859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49859,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Left Leg
 ;;^UTILITY(U,$J,358.3,49859,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,49859,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,49860,0)
 ;;=I70.211^^193^2485^10
 ;;^UTILITY(U,$J,358.3,49860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49860,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Right Leg
 ;;^UTILITY(U,$J,358.3,49860,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,49860,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,49861,0)
 ;;=I70.25^^193^2485^6
 ;;^UTILITY(U,$J,358.3,49861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49861,1,3,0)
 ;;=3^Athscl Native Arteries of Extremitis w/ Ulceration
 ;;^UTILITY(U,$J,358.3,49861,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,49861,2)
 ;;=^5007602
