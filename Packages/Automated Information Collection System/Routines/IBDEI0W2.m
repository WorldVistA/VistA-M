IBDEI0W2 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42122,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,42122,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,42122,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,42123,0)
 ;;=I65.29^^127^1842^18
 ;;^UTILITY(U,$J,358.3,42123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42123,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,42123,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,42123,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,42124,0)
 ;;=I65.22^^127^1842^16
 ;;^UTILITY(U,$J,358.3,42124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42124,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,42124,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,42124,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,42125,0)
 ;;=I65.23^^127^1842^15
 ;;^UTILITY(U,$J,358.3,42125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42125,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,42125,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,42125,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,42126,0)
 ;;=I65.21^^127^1842^17
 ;;^UTILITY(U,$J,358.3,42126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42126,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,42126,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,42126,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,42127,0)
 ;;=I70.219^^127^1842^3
 ;;^UTILITY(U,$J,358.3,42127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42127,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,42127,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,42127,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,42128,0)
 ;;=I70.213^^127^1842^4
 ;;^UTILITY(U,$J,358.3,42128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42128,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
 ;;^UTILITY(U,$J,358.3,42128,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,42128,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,42129,0)
 ;;=I70.212^^127^1842^5
 ;;^UTILITY(U,$J,358.3,42129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42129,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Left Leg
 ;;^UTILITY(U,$J,358.3,42129,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,42129,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,42130,0)
 ;;=I70.211^^127^1842^6
 ;;^UTILITY(U,$J,358.3,42130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42130,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Right Leg
 ;;^UTILITY(U,$J,358.3,42130,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,42130,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,42131,0)
 ;;=I70.25^^127^1842^2
 ;;^UTILITY(U,$J,358.3,42131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42131,1,3,0)
 ;;=3^Athscl Native Arteries of Extremitis w/ Ulceration
 ;;^UTILITY(U,$J,358.3,42131,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,42131,2)
 ;;=^5007602
 ;;^UTILITY(U,$J,358.3,42132,0)
 ;;=I70.249^^127^1842^7
 ;;^UTILITY(U,$J,358.3,42132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42132,1,3,0)
 ;;=3^Athscl Natv Art of Lt Leg w/ Ulceration of Unspec Site
 ;;^UTILITY(U,$J,358.3,42132,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,42132,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,42133,0)
 ;;=I70.239^^127^1842^8
 ;;^UTILITY(U,$J,358.3,42133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42133,1,3,0)
 ;;=3^Athscl Natv Art of Rt Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,42133,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,42133,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,42134,0)
 ;;=I70.269^^127^1842^9
 ;;^UTILITY(U,$J,358.3,42134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42134,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Unspec Extremity
 ;;^UTILITY(U,$J,358.3,42134,1,4,0)
 ;;=4^I70.269
 ;;^UTILITY(U,$J,358.3,42134,2)
 ;;=^5007607
 ;;^UTILITY(U,$J,358.3,42135,0)
 ;;=I70.263^^127^1842^10
 ;;^UTILITY(U,$J,358.3,42135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42135,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Bilateral Legs
 ;;^UTILITY(U,$J,358.3,42135,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,42135,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,42136,0)
 ;;=I70.262^^127^1842^11
 ;;^UTILITY(U,$J,358.3,42136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42136,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Left Leg
 ;;^UTILITY(U,$J,358.3,42136,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,42136,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,42137,0)
 ;;=I70.261^^127^1842^12
 ;;^UTILITY(U,$J,358.3,42137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42137,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Right Leg
 ;;^UTILITY(U,$J,358.3,42137,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,42137,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,42138,0)
 ;;=I71.2^^127^1842^20
 ;;^UTILITY(U,$J,358.3,42138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42138,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,42138,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,42138,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,42139,0)
 ;;=I71.4^^127^1842^1
 ;;^UTILITY(U,$J,358.3,42139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42139,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,42139,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,42139,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,42140,0)
 ;;=I73.9^^127^1842^19
 ;;^UTILITY(U,$J,358.3,42140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42140,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,42140,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,42140,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,42141,0)
 ;;=I82.891^^127^1842^14
 ;;^UTILITY(U,$J,358.3,42141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42141,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Chronic
 ;;^UTILITY(U,$J,358.3,42141,1,4,0)
 ;;=4^I82.891
 ;;^UTILITY(U,$J,358.3,42141,2)
 ;;=^5007939
 ;;^UTILITY(U,$J,358.3,42142,0)
 ;;=I82.890^^127^1842^13
 ;;^UTILITY(U,$J,358.3,42142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42142,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Acute
 ;;^UTILITY(U,$J,358.3,42142,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,42142,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,42143,0)
 ;;=E78.0^^127^1843^12
 ;;^UTILITY(U,$J,358.3,42143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42143,1,3,0)
 ;;=3^Pure Hypercholesterolemia
 ;;^UTILITY(U,$J,358.3,42143,1,4,0)
 ;;=4^E78.0
 ;;^UTILITY(U,$J,358.3,42143,2)
 ;;=^5002966
 ;;^UTILITY(U,$J,358.3,42144,0)
 ;;=E78.1^^127^1843^13
 ;;^UTILITY(U,$J,358.3,42144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42144,1,3,0)
 ;;=3^Pure Hyperglyceridemia
 ;;^UTILITY(U,$J,358.3,42144,1,4,0)
 ;;=4^E78.1
 ;;^UTILITY(U,$J,358.3,42144,2)
 ;;=^101303
 ;;^UTILITY(U,$J,358.3,42145,0)
 ;;=E78.2^^127^1843^11
 ;;^UTILITY(U,$J,358.3,42145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42145,1,3,0)
 ;;=3^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,42145,1,4,0)
 ;;=4^E78.2
 ;;^UTILITY(U,$J,358.3,42145,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,42146,0)
 ;;=I10.^^127^1843^3
 ;;^UTILITY(U,$J,358.3,42146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42146,1,3,0)
 ;;=3^Essential Primary Hypertension
 ;;^UTILITY(U,$J,358.3,42146,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,42146,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,42147,0)
 ;;=I11.9^^127^1843^10
 ;;^UTILITY(U,$J,358.3,42147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42147,1,3,0)
 ;;=3^Hypertensive Heart Disease w/o Heart Failure
 ;;^UTILITY(U,$J,358.3,42147,1,4,0)
 ;;=4^I11.9
 ;;^UTILITY(U,$J,358.3,42147,2)
 ;;=^5007064
 ;;^UTILITY(U,$J,358.3,42148,0)
 ;;=I11.0^^127^1843^9
 ;;^UTILITY(U,$J,358.3,42148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42148,1,3,0)
 ;;=3^Hypertensive Heart Disease w/ Heart Failure
 ;;^UTILITY(U,$J,358.3,42148,1,4,0)
 ;;=4^I11.0
 ;;^UTILITY(U,$J,358.3,42148,2)
 ;;=^5007063
 ;;^UTILITY(U,$J,358.3,42149,0)
 ;;=I12.0^^127^1843^8
 ;;^UTILITY(U,$J,358.3,42149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42149,1,3,0)
 ;;=3^Hypertensive Chr Kidney Disease w/ ESRD
 ;;^UTILITY(U,$J,358.3,42149,1,4,0)
 ;;=4^I12.0
 ;;^UTILITY(U,$J,358.3,42149,2)
 ;;=^5007065
 ;;^UTILITY(U,$J,358.3,42150,0)
 ;;=I13.10^^127^1843^6
 ;;^UTILITY(U,$J,358.3,42150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42150,1,3,0)
 ;;=3^HTN Hrt & Chr Kdny Dis w/o Hrt Fail w/ Stg 1-4 Chr Kdny
 ;;^UTILITY(U,$J,358.3,42150,1,4,0)
 ;;=4^I13.10
 ;;^UTILITY(U,$J,358.3,42150,2)
 ;;=^5007068
 ;;^UTILITY(U,$J,358.3,42151,0)
 ;;=I13.0^^127^1843^4
 ;;^UTILITY(U,$J,358.3,42151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42151,1,3,0)
 ;;=3^HTN Hrt & Chr Kdny Dis w/ Hrt Fail w/ Stg 1-4 Chr Kdny
 ;;^UTILITY(U,$J,358.3,42151,1,4,0)
 ;;=4^I13.0
 ;;^UTILITY(U,$J,358.3,42151,2)
 ;;=^5007067
 ;;^UTILITY(U,$J,358.3,42152,0)
 ;;=I13.11^^127^1843^7
 ;;^UTILITY(U,$J,358.3,42152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42152,1,3,0)
 ;;=3^HTN Hrt & Chr Kdny Dis w/o Hrt Fail w/ Stg 5 Chr Kdny
 ;;^UTILITY(U,$J,358.3,42152,1,4,0)
 ;;=4^I13.11
 ;;^UTILITY(U,$J,358.3,42152,2)
 ;;=^5007069
 ;;^UTILITY(U,$J,358.3,42153,0)
 ;;=I13.2^^127^1843^5
 ;;^UTILITY(U,$J,358.3,42153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42153,1,3,0)
 ;;=3^HTN Hrt & Chr Kdny Dis w/ Hrt Fail w/ Stg 5 Chr Kdny
 ;;^UTILITY(U,$J,358.3,42153,1,4,0)
 ;;=4^I13.2
 ;;^UTILITY(U,$J,358.3,42153,2)
 ;;=^5007070
 ;;^UTILITY(U,$J,358.3,42154,0)
 ;;=I48.91^^127^1843^1
 ;;^UTILITY(U,$J,358.3,42154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42154,1,3,0)
 ;;=3^Atrial Fibrillation,Unspec
 ;;^UTILITY(U,$J,358.3,42154,1,4,0)
 ;;=4^I48.91
 ;;^UTILITY(U,$J,358.3,42154,2)
 ;;=^5007229
 ;;^UTILITY(U,$J,358.3,42155,0)
 ;;=I48.92^^127^1843^2
 ;;^UTILITY(U,$J,358.3,42155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42155,1,3,0)
 ;;=3^Atrial Flutter,Unspec
 ;;^UTILITY(U,$J,358.3,42155,1,4,0)
 ;;=4^I48.92
 ;;^UTILITY(U,$J,358.3,42155,2)
 ;;=^5007230
 ;;^UTILITY(U,$J,358.3,42156,0)
 ;;=B07.9^^127^1844^288
