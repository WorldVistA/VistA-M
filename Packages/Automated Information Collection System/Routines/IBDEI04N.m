IBDEI04N ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5706,1,3,0)
 ;;=3^Angina Pectoris,Oth Forms
 ;;^UTILITY(U,$J,358.3,5706,1,4,0)
 ;;=4^I20.8
 ;;^UTILITY(U,$J,358.3,5706,2)
 ;;=^5007078
 ;;^UTILITY(U,$J,358.3,5707,0)
 ;;=I20.1^^26^388^1
 ;;^UTILITY(U,$J,358.3,5707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5707,1,3,0)
 ;;=3^Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,5707,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,5707,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,5708,0)
 ;;=I25.119^^26^388^5
 ;;^UTILITY(U,$J,358.3,5708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5708,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/ Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,5708,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,5708,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,5709,0)
 ;;=I25.701^^26^388^9
 ;;^UTILITY(U,$J,358.3,5709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5709,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,5709,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,5709,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,5710,0)
 ;;=I25.708^^26^388^10
 ;;^UTILITY(U,$J,358.3,5710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5710,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Oth Angina Pectoris
 ;;^UTILITY(U,$J,358.3,5710,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,5710,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,5711,0)
 ;;=I20.9^^26^388^3
 ;;^UTILITY(U,$J,358.3,5711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5711,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,5711,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,5711,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,5712,0)
 ;;=I25.729^^26^388^4
 ;;^UTILITY(U,$J,358.3,5712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5712,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,5712,1,4,0)
 ;;=4^I25.729
 ;;^UTILITY(U,$J,358.3,5712,2)
 ;;=^5133561
 ;;^UTILITY(U,$J,358.3,5713,0)
 ;;=I25.709^^26^388^11
 ;;^UTILITY(U,$J,358.3,5713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5713,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,5713,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,5713,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,5714,0)
 ;;=I25.10^^26^388^6
 ;;^UTILITY(U,$J,358.3,5714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5714,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,5714,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,5714,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,5715,0)
 ;;=I25.810^^26^388^8
 ;;^UTILITY(U,$J,358.3,5715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5715,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,5715,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,5715,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,5716,0)
 ;;=I65.29^^26^389^18
 ;;^UTILITY(U,$J,358.3,5716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5716,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,5716,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,5716,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,5717,0)
 ;;=I65.22^^26^389^16
 ;;^UTILITY(U,$J,358.3,5717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5717,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,5717,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,5717,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,5718,0)
 ;;=I65.23^^26^389^15
 ;;^UTILITY(U,$J,358.3,5718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5718,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,5718,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,5718,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,5719,0)
 ;;=I65.21^^26^389^17
 ;;^UTILITY(U,$J,358.3,5719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5719,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,5719,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,5719,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,5720,0)
 ;;=I70.219^^26^389^3
 ;;^UTILITY(U,$J,358.3,5720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5720,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,5720,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,5720,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,5721,0)
 ;;=I70.213^^26^389^4
 ;;^UTILITY(U,$J,358.3,5721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5721,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
 ;;^UTILITY(U,$J,358.3,5721,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,5721,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,5722,0)
 ;;=I70.212^^26^389^5
 ;;^UTILITY(U,$J,358.3,5722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5722,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Left Leg
 ;;^UTILITY(U,$J,358.3,5722,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,5722,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,5723,0)
 ;;=I70.211^^26^389^6
 ;;^UTILITY(U,$J,358.3,5723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5723,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Right Leg
 ;;^UTILITY(U,$J,358.3,5723,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,5723,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,5724,0)
 ;;=I70.25^^26^389^2
 ;;^UTILITY(U,$J,358.3,5724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5724,1,3,0)
 ;;=3^Athscl Native Arteries of Extremitis w/ Ulceration
 ;;^UTILITY(U,$J,358.3,5724,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,5724,2)
 ;;=^5007602
 ;;^UTILITY(U,$J,358.3,5725,0)
 ;;=I70.249^^26^389^7
 ;;^UTILITY(U,$J,358.3,5725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5725,1,3,0)
 ;;=3^Athscl Natv Art of Lt Leg w/ Ulceration of Unspec Site
 ;;^UTILITY(U,$J,358.3,5725,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,5725,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,5726,0)
 ;;=I70.239^^26^389^8
 ;;^UTILITY(U,$J,358.3,5726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5726,1,3,0)
 ;;=3^Athscl Natv Art of Rt Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,5726,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,5726,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,5727,0)
 ;;=I70.269^^26^389^9
 ;;^UTILITY(U,$J,358.3,5727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5727,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Unspec Extremity
 ;;^UTILITY(U,$J,358.3,5727,1,4,0)
 ;;=4^I70.269
 ;;^UTILITY(U,$J,358.3,5727,2)
 ;;=^5007607
 ;;^UTILITY(U,$J,358.3,5728,0)
 ;;=I70.263^^26^389^10
 ;;^UTILITY(U,$J,358.3,5728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5728,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Bilateral Legs
 ;;^UTILITY(U,$J,358.3,5728,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,5728,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,5729,0)
 ;;=I70.262^^26^389^11
 ;;^UTILITY(U,$J,358.3,5729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5729,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Left Leg
 ;;^UTILITY(U,$J,358.3,5729,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,5729,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,5730,0)
 ;;=I70.261^^26^389^12
 ;;^UTILITY(U,$J,358.3,5730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5730,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Right Leg
 ;;^UTILITY(U,$J,358.3,5730,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,5730,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,5731,0)
 ;;=I71.2^^26^389^20
 ;;^UTILITY(U,$J,358.3,5731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5731,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,5731,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,5731,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,5732,0)
 ;;=I71.4^^26^389^1
 ;;^UTILITY(U,$J,358.3,5732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5732,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,5732,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,5732,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,5733,0)
 ;;=I73.9^^26^389^19
 ;;^UTILITY(U,$J,358.3,5733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5733,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,5733,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,5733,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,5734,0)
 ;;=I82.891^^26^389^14
 ;;^UTILITY(U,$J,358.3,5734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5734,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Chronic
 ;;^UTILITY(U,$J,358.3,5734,1,4,0)
 ;;=4^I82.891
 ;;^UTILITY(U,$J,358.3,5734,2)
 ;;=^5007939
 ;;^UTILITY(U,$J,358.3,5735,0)
 ;;=I82.890^^26^389^13
 ;;^UTILITY(U,$J,358.3,5735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5735,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Acute
 ;;^UTILITY(U,$J,358.3,5735,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,5735,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,5736,0)
 ;;=E78.0^^26^390^13
 ;;^UTILITY(U,$J,358.3,5736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5736,1,3,0)
 ;;=3^Pure Hypercholesterolemia
 ;;^UTILITY(U,$J,358.3,5736,1,4,0)
 ;;=4^E78.0
 ;;^UTILITY(U,$J,358.3,5736,2)
 ;;=^5002966
 ;;^UTILITY(U,$J,358.3,5737,0)
 ;;=E78.1^^26^390^14
 ;;^UTILITY(U,$J,358.3,5737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5737,1,3,0)
 ;;=3^Pure Hyperglyceridemia
 ;;^UTILITY(U,$J,358.3,5737,1,4,0)
 ;;=4^E78.1
 ;;^UTILITY(U,$J,358.3,5737,2)
 ;;=^101303
 ;;^UTILITY(U,$J,358.3,5738,0)
 ;;=E78.2^^26^390^11
 ;;^UTILITY(U,$J,358.3,5738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5738,1,3,0)
 ;;=3^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,5738,1,4,0)
 ;;=4^E78.2
 ;;^UTILITY(U,$J,358.3,5738,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,5739,0)
 ;;=I10.^^26^390^3
 ;;^UTILITY(U,$J,358.3,5739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5739,1,3,0)
 ;;=3^Essential Primary Hypertension
 ;;^UTILITY(U,$J,358.3,5739,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,5739,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,5740,0)
 ;;=I11.9^^26^390^10
 ;;^UTILITY(U,$J,358.3,5740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5740,1,3,0)
 ;;=3^Hypertensive Heart Disease w/o Heart Failure
 ;;^UTILITY(U,$J,358.3,5740,1,4,0)
 ;;=4^I11.9
 ;;^UTILITY(U,$J,358.3,5740,2)
 ;;=^5007064
