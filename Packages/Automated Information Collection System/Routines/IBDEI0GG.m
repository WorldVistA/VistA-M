IBDEI0GG ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20838,1,4,0)
 ;;=4^Z01.810
 ;;^UTILITY(U,$J,358.3,20838,2)
 ;;=^5062625
 ;;^UTILITY(U,$J,358.3,20839,0)
 ;;=Z01.811^^58^825^16
 ;;^UTILITY(U,$J,358.3,20839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20839,1,3,0)
 ;;=3^Respiratory Preprocedural Exam
 ;;^UTILITY(U,$J,358.3,20839,1,4,0)
 ;;=4^Z01.811
 ;;^UTILITY(U,$J,358.3,20839,2)
 ;;=^5062626
 ;;^UTILITY(U,$J,358.3,20840,0)
 ;;=Z01.812^^58^825^13
 ;;^UTILITY(U,$J,358.3,20840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20840,1,3,0)
 ;;=3^Lab Preprocedural Exam
 ;;^UTILITY(U,$J,358.3,20840,1,4,0)
 ;;=4^Z01.812
 ;;^UTILITY(U,$J,358.3,20840,2)
 ;;=^5062627
 ;;^UTILITY(U,$J,358.3,20841,0)
 ;;=Z01.818^^58^825^15
 ;;^UTILITY(U,$J,358.3,20841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20841,1,3,0)
 ;;=3^Preprocedural Exam NEC
 ;;^UTILITY(U,$J,358.3,20841,1,4,0)
 ;;=4^Z01.818
 ;;^UTILITY(U,$J,358.3,20841,2)
 ;;=^5062628
 ;;^UTILITY(U,$J,358.3,20842,0)
 ;;=Z71.0^^58^825^9
 ;;^UTILITY(U,$J,358.3,20842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20842,1,3,0)
 ;;=3^Hlth Service to Consult on Behalf of Another
 ;;^UTILITY(U,$J,358.3,20842,1,4,0)
 ;;=4^Z71.0
 ;;^UTILITY(U,$J,358.3,20842,2)
 ;;=^5063242
 ;;^UTILITY(U,$J,358.3,20843,0)
 ;;=Z59.8^^58^825^10
 ;;^UTILITY(U,$J,358.3,20843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20843,1,3,0)
 ;;=3^Housing/Economic Circumstance Problems
 ;;^UTILITY(U,$J,358.3,20843,1,4,0)
 ;;=4^Z59.8
 ;;^UTILITY(U,$J,358.3,20843,2)
 ;;=^5063137
 ;;^UTILITY(U,$J,358.3,20844,0)
 ;;=I20.0^^58^826^14
 ;;^UTILITY(U,$J,358.3,20844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20844,1,3,0)
 ;;=3^Unstable Angina
 ;;^UTILITY(U,$J,358.3,20844,1,4,0)
 ;;=4^I20.0
 ;;^UTILITY(U,$J,358.3,20844,2)
 ;;=^5007076
 ;;^UTILITY(U,$J,358.3,20845,0)
 ;;=I25.110^^58^826^7
 ;;^UTILITY(U,$J,358.3,20845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20845,1,3,0)
 ;;=3^Athscl Hrt Dis of Native Cor Art w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,20845,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,20845,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,20846,0)
 ;;=I25.700^^58^826^12
 ;;^UTILITY(U,$J,358.3,20846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20846,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unstable Angina Pectoris
 ;;^UTILITY(U,$J,358.3,20846,1,4,0)
 ;;=4^I25.700
 ;;^UTILITY(U,$J,358.3,20846,2)
 ;;=^5007117
 ;;^UTILITY(U,$J,358.3,20847,0)
 ;;=I25.2^^58^826^13
 ;;^UTILITY(U,$J,358.3,20847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20847,1,3,0)
 ;;=3^Old Myocardial Infarction
 ;;^UTILITY(U,$J,358.3,20847,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,20847,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,20848,0)
 ;;=I20.8^^58^826^2
 ;;^UTILITY(U,$J,358.3,20848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20848,1,3,0)
 ;;=3^Angina Pectoris,Oth Forms
 ;;^UTILITY(U,$J,358.3,20848,1,4,0)
 ;;=4^I20.8
 ;;^UTILITY(U,$J,358.3,20848,2)
 ;;=^5007078
 ;;^UTILITY(U,$J,358.3,20849,0)
 ;;=I20.1^^58^826^1
 ;;^UTILITY(U,$J,358.3,20849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20849,1,3,0)
 ;;=3^Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,20849,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,20849,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,20850,0)
 ;;=I25.119^^58^826^5
 ;;^UTILITY(U,$J,358.3,20850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20850,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/ Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,20850,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,20850,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,20851,0)
 ;;=I25.701^^58^826^9
 ;;^UTILITY(U,$J,358.3,20851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20851,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,20851,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,20851,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,20852,0)
 ;;=I25.708^^58^826^10
 ;;^UTILITY(U,$J,358.3,20852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20852,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Oth Angina Pectoris
 ;;^UTILITY(U,$J,358.3,20852,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,20852,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,20853,0)
 ;;=I20.9^^58^826^3
 ;;^UTILITY(U,$J,358.3,20853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20853,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,20853,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,20853,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,20854,0)
 ;;=I25.729^^58^826^4
 ;;^UTILITY(U,$J,358.3,20854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20854,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,20854,1,4,0)
 ;;=4^I25.729
 ;;^UTILITY(U,$J,358.3,20854,2)
 ;;=^5133561
 ;;^UTILITY(U,$J,358.3,20855,0)
 ;;=I25.709^^58^826^11
 ;;^UTILITY(U,$J,358.3,20855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20855,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,20855,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,20855,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,20856,0)
 ;;=I25.10^^58^826^6
 ;;^UTILITY(U,$J,358.3,20856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20856,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,20856,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,20856,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,20857,0)
 ;;=I25.810^^58^826^8
 ;;^UTILITY(U,$J,358.3,20857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20857,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,20857,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,20857,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,20858,0)
 ;;=I65.29^^58^827^18
 ;;^UTILITY(U,$J,358.3,20858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20858,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,20858,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,20858,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,20859,0)
 ;;=I65.22^^58^827^16
 ;;^UTILITY(U,$J,358.3,20859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20859,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,20859,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,20859,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,20860,0)
 ;;=I65.23^^58^827^15
 ;;^UTILITY(U,$J,358.3,20860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20860,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,20860,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,20860,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,20861,0)
 ;;=I65.21^^58^827^17
 ;;^UTILITY(U,$J,358.3,20861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20861,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,20861,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,20861,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,20862,0)
 ;;=I70.219^^58^827^3
 ;;^UTILITY(U,$J,358.3,20862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20862,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,20862,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,20862,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,20863,0)
 ;;=I70.213^^58^827^4
 ;;^UTILITY(U,$J,358.3,20863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20863,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
 ;;^UTILITY(U,$J,358.3,20863,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,20863,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,20864,0)
 ;;=I70.212^^58^827^5
 ;;^UTILITY(U,$J,358.3,20864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20864,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Left Leg
 ;;^UTILITY(U,$J,358.3,20864,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,20864,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,20865,0)
 ;;=I70.211^^58^827^6
 ;;^UTILITY(U,$J,358.3,20865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20865,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Right Leg
 ;;^UTILITY(U,$J,358.3,20865,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,20865,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,20866,0)
 ;;=I70.25^^58^827^2
 ;;^UTILITY(U,$J,358.3,20866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20866,1,3,0)
 ;;=3^Athscl Native Arteries of Extremitis w/ Ulceration
 ;;^UTILITY(U,$J,358.3,20866,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,20866,2)
 ;;=^5007602
 ;;^UTILITY(U,$J,358.3,20867,0)
 ;;=I70.249^^58^827^7
 ;;^UTILITY(U,$J,358.3,20867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20867,1,3,0)
 ;;=3^Athscl Natv Art of Lt Leg w/ Ulceration of Unspec Site
 ;;^UTILITY(U,$J,358.3,20867,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,20867,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,20868,0)
 ;;=I70.239^^58^827^8
 ;;^UTILITY(U,$J,358.3,20868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20868,1,3,0)
 ;;=3^Athscl Natv Art of Rt Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,20868,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,20868,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,20869,0)
 ;;=I70.269^^58^827^9
 ;;^UTILITY(U,$J,358.3,20869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20869,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Unspec Extremity
 ;;^UTILITY(U,$J,358.3,20869,1,4,0)
 ;;=4^I70.269
 ;;^UTILITY(U,$J,358.3,20869,2)
 ;;=^5007607
 ;;^UTILITY(U,$J,358.3,20870,0)
 ;;=I70.263^^58^827^10
 ;;^UTILITY(U,$J,358.3,20870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20870,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Bilateral Legs
 ;;^UTILITY(U,$J,358.3,20870,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,20870,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,20871,0)
 ;;=I70.262^^58^827^11
 ;;^UTILITY(U,$J,358.3,20871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20871,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Left Leg
 ;;^UTILITY(U,$J,358.3,20871,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,20871,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,20872,0)
 ;;=I70.261^^58^827^12
 ;;^UTILITY(U,$J,358.3,20872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20872,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Right Leg
 ;;^UTILITY(U,$J,358.3,20872,1,4,0)
 ;;=4^I70.261
