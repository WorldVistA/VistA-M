IBDEI1LX ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26893,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,26893,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,26893,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,26894,0)
 ;;=I25.708^^132^1306^10
 ;;^UTILITY(U,$J,358.3,26894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26894,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Oth Angina Pectoris
 ;;^UTILITY(U,$J,358.3,26894,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,26894,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,26895,0)
 ;;=I20.9^^132^1306^3
 ;;^UTILITY(U,$J,358.3,26895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26895,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,26895,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,26895,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,26896,0)
 ;;=I25.729^^132^1306^4
 ;;^UTILITY(U,$J,358.3,26896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26896,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,26896,1,4,0)
 ;;=4^I25.729
 ;;^UTILITY(U,$J,358.3,26896,2)
 ;;=^5133561
 ;;^UTILITY(U,$J,358.3,26897,0)
 ;;=I25.709^^132^1306^11
 ;;^UTILITY(U,$J,358.3,26897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26897,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,26897,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,26897,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,26898,0)
 ;;=I25.10^^132^1306^6
 ;;^UTILITY(U,$J,358.3,26898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26898,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,26898,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,26898,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,26899,0)
 ;;=I25.810^^132^1306^8
 ;;^UTILITY(U,$J,358.3,26899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26899,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,26899,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,26899,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,26900,0)
 ;;=I65.29^^132^1307^18
 ;;^UTILITY(U,$J,358.3,26900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26900,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,26900,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,26900,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,26901,0)
 ;;=I65.22^^132^1307^16
 ;;^UTILITY(U,$J,358.3,26901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26901,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,26901,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,26901,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,26902,0)
 ;;=I65.23^^132^1307^15
 ;;^UTILITY(U,$J,358.3,26902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26902,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,26902,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,26902,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,26903,0)
 ;;=I65.21^^132^1307^17
 ;;^UTILITY(U,$J,358.3,26903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26903,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,26903,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,26903,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,26904,0)
 ;;=I70.219^^132^1307^3
 ;;^UTILITY(U,$J,358.3,26904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26904,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,26904,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,26904,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,26905,0)
 ;;=I70.213^^132^1307^4
 ;;^UTILITY(U,$J,358.3,26905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26905,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
