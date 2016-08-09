IBDEI0DT ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13809,2)
 ;;=^5007117
 ;;^UTILITY(U,$J,358.3,13810,0)
 ;;=I25.2^^61^726^13
 ;;^UTILITY(U,$J,358.3,13810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13810,1,3,0)
 ;;=3^Old Myocardial Infarction
 ;;^UTILITY(U,$J,358.3,13810,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,13810,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,13811,0)
 ;;=I20.8^^61^726^2
 ;;^UTILITY(U,$J,358.3,13811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13811,1,3,0)
 ;;=3^Angina Pectoris,Oth Forms
 ;;^UTILITY(U,$J,358.3,13811,1,4,0)
 ;;=4^I20.8
 ;;^UTILITY(U,$J,358.3,13811,2)
 ;;=^5007078
 ;;^UTILITY(U,$J,358.3,13812,0)
 ;;=I20.1^^61^726^1
 ;;^UTILITY(U,$J,358.3,13812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13812,1,3,0)
 ;;=3^Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,13812,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,13812,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,13813,0)
 ;;=I25.119^^61^726^5
 ;;^UTILITY(U,$J,358.3,13813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13813,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/ Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,13813,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,13813,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,13814,0)
 ;;=I25.701^^61^726^9
 ;;^UTILITY(U,$J,358.3,13814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13814,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,13814,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,13814,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,13815,0)
 ;;=I25.708^^61^726^10
 ;;^UTILITY(U,$J,358.3,13815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13815,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Oth Angina Pectoris
 ;;^UTILITY(U,$J,358.3,13815,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,13815,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,13816,0)
 ;;=I20.9^^61^726^3
 ;;^UTILITY(U,$J,358.3,13816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13816,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,13816,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,13816,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,13817,0)
 ;;=I25.729^^61^726^4
 ;;^UTILITY(U,$J,358.3,13817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13817,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,13817,1,4,0)
 ;;=4^I25.729
 ;;^UTILITY(U,$J,358.3,13817,2)
 ;;=^5133561
 ;;^UTILITY(U,$J,358.3,13818,0)
 ;;=I25.709^^61^726^11
 ;;^UTILITY(U,$J,358.3,13818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13818,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,13818,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,13818,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,13819,0)
 ;;=I25.10^^61^726^6
 ;;^UTILITY(U,$J,358.3,13819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13819,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,13819,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,13819,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,13820,0)
 ;;=I25.810^^61^726^8
 ;;^UTILITY(U,$J,358.3,13820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13820,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,13820,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,13820,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,13821,0)
 ;;=I65.29^^61^727^18
 ;;^UTILITY(U,$J,358.3,13821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13821,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,13821,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,13821,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,13822,0)
 ;;=I65.22^^61^727^16
 ;;^UTILITY(U,$J,358.3,13822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13822,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,13822,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,13822,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,13823,0)
 ;;=I65.23^^61^727^15
 ;;^UTILITY(U,$J,358.3,13823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13823,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,13823,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,13823,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,13824,0)
 ;;=I65.21^^61^727^17
 ;;^UTILITY(U,$J,358.3,13824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13824,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,13824,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,13824,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,13825,0)
 ;;=I70.219^^61^727^3
 ;;^UTILITY(U,$J,358.3,13825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13825,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,13825,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,13825,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,13826,0)
 ;;=I70.213^^61^727^4
 ;;^UTILITY(U,$J,358.3,13826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13826,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
 ;;^UTILITY(U,$J,358.3,13826,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,13826,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,13827,0)
 ;;=I70.212^^61^727^5
 ;;^UTILITY(U,$J,358.3,13827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13827,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Left Leg
 ;;^UTILITY(U,$J,358.3,13827,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,13827,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,13828,0)
 ;;=I70.211^^61^727^6
 ;;^UTILITY(U,$J,358.3,13828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13828,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Right Leg
 ;;^UTILITY(U,$J,358.3,13828,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,13828,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,13829,0)
 ;;=I70.25^^61^727^2
 ;;^UTILITY(U,$J,358.3,13829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13829,1,3,0)
 ;;=3^Athscl Native Arteries of Extremitis w/ Ulceration
 ;;^UTILITY(U,$J,358.3,13829,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,13829,2)
 ;;=^5007602
 ;;^UTILITY(U,$J,358.3,13830,0)
 ;;=I70.249^^61^727^7
 ;;^UTILITY(U,$J,358.3,13830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13830,1,3,0)
 ;;=3^Athscl Natv Art of Lt Leg w/ Ulceration of Unspec Site
 ;;^UTILITY(U,$J,358.3,13830,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,13830,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,13831,0)
 ;;=I70.239^^61^727^8
 ;;^UTILITY(U,$J,358.3,13831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13831,1,3,0)
 ;;=3^Athscl Natv Art of Rt Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,13831,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,13831,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,13832,0)
 ;;=I70.269^^61^727^9
 ;;^UTILITY(U,$J,358.3,13832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13832,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Unspec Extremity
 ;;^UTILITY(U,$J,358.3,13832,1,4,0)
 ;;=4^I70.269
 ;;^UTILITY(U,$J,358.3,13832,2)
 ;;=^5007607
 ;;^UTILITY(U,$J,358.3,13833,0)
 ;;=I70.263^^61^727^10
 ;;^UTILITY(U,$J,358.3,13833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13833,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Bilateral Legs
 ;;^UTILITY(U,$J,358.3,13833,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,13833,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,13834,0)
 ;;=I70.262^^61^727^11
 ;;^UTILITY(U,$J,358.3,13834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13834,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Left Leg
 ;;^UTILITY(U,$J,358.3,13834,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,13834,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,13835,0)
 ;;=I70.261^^61^727^12
 ;;^UTILITY(U,$J,358.3,13835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13835,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Right Leg
 ;;^UTILITY(U,$J,358.3,13835,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,13835,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,13836,0)
 ;;=I71.2^^61^727^20
 ;;^UTILITY(U,$J,358.3,13836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13836,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
