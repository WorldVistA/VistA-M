IBDEI0LW ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9992,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,9992,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,9992,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,9993,0)
 ;;=I25.729^^68^661^4
 ;;^UTILITY(U,$J,358.3,9993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9993,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,9993,1,4,0)
 ;;=4^I25.729
 ;;^UTILITY(U,$J,358.3,9993,2)
 ;;=^5133561
 ;;^UTILITY(U,$J,358.3,9994,0)
 ;;=I25.709^^68^661^11
 ;;^UTILITY(U,$J,358.3,9994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9994,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,9994,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,9994,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,9995,0)
 ;;=I25.10^^68^661^6
 ;;^UTILITY(U,$J,358.3,9995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9995,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,9995,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,9995,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,9996,0)
 ;;=I25.810^^68^661^8
 ;;^UTILITY(U,$J,358.3,9996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9996,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,9996,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,9996,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,9997,0)
 ;;=I65.29^^68^662^18
 ;;^UTILITY(U,$J,358.3,9997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9997,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,9997,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,9997,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,9998,0)
 ;;=I65.22^^68^662^16
 ;;^UTILITY(U,$J,358.3,9998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9998,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,9998,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,9998,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,9999,0)
 ;;=I65.23^^68^662^15
 ;;^UTILITY(U,$J,358.3,9999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9999,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,9999,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,9999,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,10000,0)
 ;;=I65.21^^68^662^17
 ;;^UTILITY(U,$J,358.3,10000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10000,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,10000,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,10000,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,10001,0)
 ;;=I70.219^^68^662^3
 ;;^UTILITY(U,$J,358.3,10001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10001,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,10001,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,10001,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,10002,0)
 ;;=I70.213^^68^662^4
 ;;^UTILITY(U,$J,358.3,10002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10002,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
 ;;^UTILITY(U,$J,358.3,10002,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,10002,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,10003,0)
 ;;=I70.212^^68^662^5
 ;;^UTILITY(U,$J,358.3,10003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10003,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Left Leg
 ;;^UTILITY(U,$J,358.3,10003,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,10003,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,10004,0)
 ;;=I70.211^^68^662^6
 ;;^UTILITY(U,$J,358.3,10004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10004,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Right Leg
 ;;^UTILITY(U,$J,358.3,10004,1,4,0)
 ;;=4^I70.211
