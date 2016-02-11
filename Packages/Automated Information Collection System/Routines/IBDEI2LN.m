IBDEI2LN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,43631,0)
 ;;=I25.709^^200^2214^11
 ;;^UTILITY(U,$J,358.3,43631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43631,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,43631,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,43631,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,43632,0)
 ;;=I25.10^^200^2214^6
 ;;^UTILITY(U,$J,358.3,43632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43632,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,43632,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,43632,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,43633,0)
 ;;=I25.810^^200^2214^8
 ;;^UTILITY(U,$J,358.3,43633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43633,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,43633,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,43633,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,43634,0)
 ;;=I65.29^^200^2215^18
 ;;^UTILITY(U,$J,358.3,43634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43634,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,43634,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,43634,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,43635,0)
 ;;=I65.22^^200^2215^16
 ;;^UTILITY(U,$J,358.3,43635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43635,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,43635,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,43635,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,43636,0)
 ;;=I65.23^^200^2215^15
 ;;^UTILITY(U,$J,358.3,43636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43636,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,43636,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,43636,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,43637,0)
 ;;=I65.21^^200^2215^17
 ;;^UTILITY(U,$J,358.3,43637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43637,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,43637,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,43637,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,43638,0)
 ;;=I70.219^^200^2215^3
 ;;^UTILITY(U,$J,358.3,43638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43638,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,43638,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,43638,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,43639,0)
 ;;=I70.213^^200^2215^4
 ;;^UTILITY(U,$J,358.3,43639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43639,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
 ;;^UTILITY(U,$J,358.3,43639,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,43639,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,43640,0)
 ;;=I70.212^^200^2215^5
 ;;^UTILITY(U,$J,358.3,43640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43640,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Left Leg
 ;;^UTILITY(U,$J,358.3,43640,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,43640,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,43641,0)
 ;;=I70.211^^200^2215^6
 ;;^UTILITY(U,$J,358.3,43641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43641,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Right Leg
 ;;^UTILITY(U,$J,358.3,43641,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,43641,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,43642,0)
 ;;=I70.25^^200^2215^2
 ;;^UTILITY(U,$J,358.3,43642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43642,1,3,0)
 ;;=3^Athscl Native Arteries of Extremitis w/ Ulceration
 ;;^UTILITY(U,$J,358.3,43642,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,43642,2)
 ;;=^5007602
 ;;^UTILITY(U,$J,358.3,43643,0)
 ;;=I70.249^^200^2215^7
