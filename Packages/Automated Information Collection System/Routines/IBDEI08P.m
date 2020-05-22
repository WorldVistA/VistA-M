IBDEI08P ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21294,1,4,0)
 ;;=4^Z71.0
 ;;^UTILITY(U,$J,358.3,21294,2)
 ;;=^5063242
 ;;^UTILITY(U,$J,358.3,21295,0)
 ;;=Z59.8^^73^926^10
 ;;^UTILITY(U,$J,358.3,21295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21295,1,3,0)
 ;;=3^Housing/Economic Circumstance Problems
 ;;^UTILITY(U,$J,358.3,21295,1,4,0)
 ;;=4^Z59.8
 ;;^UTILITY(U,$J,358.3,21295,2)
 ;;=^5063137
 ;;^UTILITY(U,$J,358.3,21296,0)
 ;;=I20.0^^73^927^5
 ;;^UTILITY(U,$J,358.3,21296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21296,1,3,0)
 ;;=3^Unstable Angina
 ;;^UTILITY(U,$J,358.3,21296,1,4,0)
 ;;=4^I20.0
 ;;^UTILITY(U,$J,358.3,21296,2)
 ;;=^5007076
 ;;^UTILITY(U,$J,358.3,21297,0)
 ;;=I25.2^^73^927^4
 ;;^UTILITY(U,$J,358.3,21297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21297,1,3,0)
 ;;=3^Old Myocardial Infarction
 ;;^UTILITY(U,$J,358.3,21297,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,21297,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,21298,0)
 ;;=I20.8^^73^927^2
 ;;^UTILITY(U,$J,358.3,21298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21298,1,3,0)
 ;;=3^Angina Pectoris,Oth Forms
 ;;^UTILITY(U,$J,358.3,21298,1,4,0)
 ;;=4^I20.8
 ;;^UTILITY(U,$J,358.3,21298,2)
 ;;=^5007078
 ;;^UTILITY(U,$J,358.3,21299,0)
 ;;=I20.1^^73^927^1
 ;;^UTILITY(U,$J,358.3,21299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21299,1,3,0)
 ;;=3^Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,21299,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,21299,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,21300,0)
 ;;=I20.9^^73^927^3
 ;;^UTILITY(U,$J,358.3,21300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21300,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,21300,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,21300,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,21301,0)
 ;;=I65.29^^73^928^31
 ;;^UTILITY(U,$J,358.3,21301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21301,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,21301,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,21301,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,21302,0)
 ;;=I65.22^^73^928^29
 ;;^UTILITY(U,$J,358.3,21302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21302,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,21302,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,21302,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,21303,0)
 ;;=I65.23^^73^928^28
 ;;^UTILITY(U,$J,358.3,21303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21303,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,21303,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,21303,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,21304,0)
 ;;=I65.21^^73^928^30
 ;;^UTILITY(U,$J,358.3,21304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21304,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,21304,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,21304,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,21305,0)
 ;;=I70.219^^73^928^7
 ;;^UTILITY(U,$J,358.3,21305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21305,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,21305,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,21305,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,21306,0)
 ;;=I70.213^^73^928^8
 ;;^UTILITY(U,$J,358.3,21306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21306,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
 ;;^UTILITY(U,$J,358.3,21306,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,21306,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,21307,0)
 ;;=I70.212^^73^928^9
 ;;^UTILITY(U,$J,358.3,21307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21307,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Left Leg
 ;;^UTILITY(U,$J,358.3,21307,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,21307,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,21308,0)
 ;;=I70.211^^73^928^10
 ;;^UTILITY(U,$J,358.3,21308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21308,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Right Leg
 ;;^UTILITY(U,$J,358.3,21308,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,21308,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,21309,0)
 ;;=I70.25^^73^928^6
 ;;^UTILITY(U,$J,358.3,21309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21309,1,3,0)
 ;;=3^Athscl Native Arteries of Extremitis w/ Ulceration
 ;;^UTILITY(U,$J,358.3,21309,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,21309,2)
 ;;=^5007602
 ;;^UTILITY(U,$J,358.3,21310,0)
 ;;=I70.249^^73^928^11
 ;;^UTILITY(U,$J,358.3,21310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21310,1,3,0)
 ;;=3^Athscl Natv Art of Lt Leg w/ Ulceration of Unspec Site
 ;;^UTILITY(U,$J,358.3,21310,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,21310,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,21311,0)
 ;;=I70.239^^73^928^12
 ;;^UTILITY(U,$J,358.3,21311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21311,1,3,0)
 ;;=3^Athscl Natv Art of Rt Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,21311,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,21311,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,21312,0)
 ;;=I70.269^^73^928^13
 ;;^UTILITY(U,$J,358.3,21312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21312,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Unspec Extremity
 ;;^UTILITY(U,$J,358.3,21312,1,4,0)
 ;;=4^I70.269
 ;;^UTILITY(U,$J,358.3,21312,2)
 ;;=^5007607
 ;;^UTILITY(U,$J,358.3,21313,0)
 ;;=I70.263^^73^928^14
 ;;^UTILITY(U,$J,358.3,21313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21313,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Bilateral Legs
 ;;^UTILITY(U,$J,358.3,21313,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,21313,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,21314,0)
 ;;=I70.262^^73^928^15
 ;;^UTILITY(U,$J,358.3,21314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21314,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Left Leg
 ;;^UTILITY(U,$J,358.3,21314,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,21314,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,21315,0)
 ;;=I70.261^^73^928^16
 ;;^UTILITY(U,$J,358.3,21315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21315,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Right Leg
 ;;^UTILITY(U,$J,358.3,21315,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,21315,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,21316,0)
 ;;=I71.2^^73^928^34
 ;;^UTILITY(U,$J,358.3,21316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21316,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,21316,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,21316,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,21317,0)
 ;;=I71.4^^73^928^1
 ;;^UTILITY(U,$J,358.3,21317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21317,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,21317,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,21317,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,21318,0)
 ;;=I73.9^^73^928^32
 ;;^UTILITY(U,$J,358.3,21318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21318,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,21318,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,21318,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,21319,0)
 ;;=I82.891^^73^928^23
 ;;^UTILITY(U,$J,358.3,21319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21319,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Chronic
 ;;^UTILITY(U,$J,358.3,21319,1,4,0)
 ;;=4^I82.891
 ;;^UTILITY(U,$J,358.3,21319,2)
 ;;=^5007939
 ;;^UTILITY(U,$J,358.3,21320,0)
 ;;=I82.890^^73^928^22
 ;;^UTILITY(U,$J,358.3,21320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21320,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Acute
 ;;^UTILITY(U,$J,358.3,21320,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,21320,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,21321,0)
 ;;=I25.729^^73^928^2
 ;;^UTILITY(U,$J,358.3,21321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21321,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,21321,1,4,0)
 ;;=4^I25.729
 ;;^UTILITY(U,$J,358.3,21321,2)
 ;;=^5133561
 ;;^UTILITY(U,$J,358.3,21322,0)
 ;;=I25.119^^73^928^3
 ;;^UTILITY(U,$J,358.3,21322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21322,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/ Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,21322,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,21322,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,21323,0)
 ;;=I25.10^^73^928^4
 ;;^UTILITY(U,$J,358.3,21323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21323,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,21323,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,21323,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,21324,0)
 ;;=I25.110^^73^928^5
 ;;^UTILITY(U,$J,358.3,21324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21324,1,3,0)
 ;;=3^Athscl Hrt Dis of Native Cor Art w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,21324,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,21324,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,21325,0)
 ;;=I25.810^^73^928^17
 ;;^UTILITY(U,$J,358.3,21325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21325,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,21325,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,21325,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,21326,0)
 ;;=I25.701^^73^928^18
 ;;^UTILITY(U,$J,358.3,21326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21326,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,21326,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,21326,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,21327,0)
 ;;=I25.708^^73^928^19
 ;;^UTILITY(U,$J,358.3,21327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21327,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Oth Angina Pectoris
 ;;^UTILITY(U,$J,358.3,21327,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,21327,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,21328,0)
 ;;=I25.709^^73^928^20
 ;;^UTILITY(U,$J,358.3,21328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21328,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,21328,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,21328,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,21329,0)
 ;;=I25.700^^73^928^21
 ;;^UTILITY(U,$J,358.3,21329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21329,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unstable Angina Pectoris
 ;;^UTILITY(U,$J,358.3,21329,1,4,0)
 ;;=4^I25.700
 ;;^UTILITY(U,$J,358.3,21329,2)
 ;;=^5007117
 ;;^UTILITY(U,$J,358.3,21330,0)
 ;;=I82.469^^73^928^24
 ;;^UTILITY(U,$J,358.3,21330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21330,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Calf Muscle Vein,Acute
 ;;^UTILITY(U,$J,358.3,21330,1,4,0)
 ;;=4^I82.469
 ;;^UTILITY(U,$J,358.3,21330,2)
 ;;=^5158066
 ;;^UTILITY(U,$J,358.3,21331,0)
 ;;=I82.569^^73^928^25
 ;;^UTILITY(U,$J,358.3,21331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21331,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Calf Muscle Vein,Chronic
 ;;^UTILITY(U,$J,358.3,21331,1,4,0)
 ;;=4^I82.569
 ;;^UTILITY(U,$J,358.3,21331,2)
 ;;=^5158074
 ;;^UTILITY(U,$J,358.3,21332,0)
 ;;=I80.259^^73^928^33
 ;;^UTILITY(U,$J,358.3,21332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21332,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis,Unspec Calf Muscle Vein
 ;;^UTILITY(U,$J,358.3,21332,1,4,0)
 ;;=4^I80.259
 ;;^UTILITY(U,$J,358.3,21332,2)
 ;;=^5158058
 ;;^UTILITY(U,$J,358.3,21333,0)
 ;;=I82.409^^73^928^26
 ;;^UTILITY(U,$J,358.3,21333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21333,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Deep Vein,LE Unspec Acute
 ;;^UTILITY(U,$J,358.3,21333,1,4,0)
 ;;=4^I82.409
 ;;^UTILITY(U,$J,358.3,21333,2)
 ;;=^5133625
 ;;^UTILITY(U,$J,358.3,21334,0)
 ;;=I82.509^^73^928^27
 ;;^UTILITY(U,$J,358.3,21334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21334,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Deep Vein,LE Unspec Chronic
 ;;^UTILITY(U,$J,358.3,21334,1,4,0)
 ;;=4^I82.509
 ;;^UTILITY(U,$J,358.3,21334,2)
 ;;=^5133628
 ;;^UTILITY(U,$J,358.3,21335,0)
 ;;=E78.1^^73^929^23
 ;;^UTILITY(U,$J,358.3,21335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21335,1,3,0)
 ;;=3^Pure Hyperglyceridemia
 ;;^UTILITY(U,$J,358.3,21335,1,4,0)
 ;;=4^E78.1
 ;;^UTILITY(U,$J,358.3,21335,2)
 ;;=^101303
 ;;^UTILITY(U,$J,358.3,21336,0)
 ;;=E78.2^^73^929^21
 ;;^UTILITY(U,$J,358.3,21336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21336,1,3,0)
 ;;=3^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,21336,1,4,0)
 ;;=4^E78.2
 ;;^UTILITY(U,$J,358.3,21336,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,21337,0)
 ;;=I10.^^73^929^9
 ;;^UTILITY(U,$J,358.3,21337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21337,1,3,0)
 ;;=3^Essential Primary Hypertension
 ;;^UTILITY(U,$J,358.3,21337,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,21337,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,21338,0)
 ;;=I11.9^^73^929^19
 ;;^UTILITY(U,$J,358.3,21338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21338,1,3,0)
 ;;=3^Hypertensive Heart Disease w/o Heart Failure
 ;;^UTILITY(U,$J,358.3,21338,1,4,0)
 ;;=4^I11.9
 ;;^UTILITY(U,$J,358.3,21338,2)
 ;;=^5007064
 ;;^UTILITY(U,$J,358.3,21339,0)
 ;;=I11.0^^73^929^18
 ;;^UTILITY(U,$J,358.3,21339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21339,1,3,0)
 ;;=3^Hypertensive Heart Disease w/ Heart Failure
 ;;^UTILITY(U,$J,358.3,21339,1,4,0)
 ;;=4^I11.0
 ;;^UTILITY(U,$J,358.3,21339,2)
 ;;=^5007063
 ;;^UTILITY(U,$J,358.3,21340,0)
 ;;=I12.0^^73^929^15
 ;;^UTILITY(U,$J,358.3,21340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21340,1,3,0)
 ;;=3^Hypertensive Chr Kidney Disease w/ ESRD
 ;;^UTILITY(U,$J,358.3,21340,1,4,0)
 ;;=4^I12.0
 ;;^UTILITY(U,$J,358.3,21340,2)
 ;;=^5007065
 ;;^UTILITY(U,$J,358.3,21341,0)
 ;;=I13.10^^73^929^13
 ;;^UTILITY(U,$J,358.3,21341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21341,1,3,0)
 ;;=3^HTN Hrt & Chr Kdny Dis w/o Hrt Fail w/ Stg 1-4 Chr Kdny
 ;;^UTILITY(U,$J,358.3,21341,1,4,0)
 ;;=4^I13.10
 ;;^UTILITY(U,$J,358.3,21341,2)
 ;;=^5007068
 ;;^UTILITY(U,$J,358.3,21342,0)
 ;;=I13.0^^73^929^11
 ;;^UTILITY(U,$J,358.3,21342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21342,1,3,0)
 ;;=3^HTN Hrt & Chr Kdny Dis w/ Hrt Fail w/ Stg 1-4 Chr Kdny
 ;;^UTILITY(U,$J,358.3,21342,1,4,0)
 ;;=4^I13.0
 ;;^UTILITY(U,$J,358.3,21342,2)
 ;;=^5007067
 ;;^UTILITY(U,$J,358.3,21343,0)
 ;;=I13.11^^73^929^14
 ;;^UTILITY(U,$J,358.3,21343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21343,1,3,0)
 ;;=3^HTN Hrt & Chr Kdny Dis w/o Hrt Fail w/ Stg 5 Chr Kdny
 ;;^UTILITY(U,$J,358.3,21343,1,4,0)
 ;;=4^I13.11
 ;;^UTILITY(U,$J,358.3,21343,2)
 ;;=^5007069
 ;;^UTILITY(U,$J,358.3,21344,0)
 ;;=I13.2^^73^929^12
 ;;^UTILITY(U,$J,358.3,21344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21344,1,3,0)
 ;;=3^HTN Hrt & Chr Kdny Dis w/ Hrt Fail w/ Stg 5 Chr Kdny
 ;;^UTILITY(U,$J,358.3,21344,1,4,0)
 ;;=4^I13.2
 ;;^UTILITY(U,$J,358.3,21344,2)
 ;;=^5007070
 ;;^UTILITY(U,$J,358.3,21345,0)
 ;;=I48.91^^73^929^6
 ;;^UTILITY(U,$J,358.3,21345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21345,1,3,0)
 ;;=3^Atrial Fibrillation,Unspec
 ;;^UTILITY(U,$J,358.3,21345,1,4,0)
 ;;=4^I48.91
 ;;^UTILITY(U,$J,358.3,21345,2)
 ;;=^5007229
 ;;^UTILITY(U,$J,358.3,21346,0)
 ;;=I48.92^^73^929^7
 ;;^UTILITY(U,$J,358.3,21346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21346,1,3,0)
 ;;=3^Atrial Flutter,Unspec
 ;;^UTILITY(U,$J,358.3,21346,1,4,0)
 ;;=4^I48.92
 ;;^UTILITY(U,$J,358.3,21346,2)
 ;;=^5007230
 ;;^UTILITY(U,$J,358.3,21347,0)
 ;;=I16.1^^73^929^17
 ;;^UTILITY(U,$J,358.3,21347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21347,1,3,0)
 ;;=3^Hypertensive Emergency
 ;;^UTILITY(U,$J,358.3,21347,1,4,0)
 ;;=4^I16.1
 ;;^UTILITY(U,$J,358.3,21347,2)
 ;;=^8204721
 ;;^UTILITY(U,$J,358.3,21348,0)
 ;;=I16.0^^73^929^20
 ;;^UTILITY(U,$J,358.3,21348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21348,1,3,0)
 ;;=3^Hypertensive Urgency
 ;;^UTILITY(U,$J,358.3,21348,1,4,0)
 ;;=4^I16.0
 ;;^UTILITY(U,$J,358.3,21348,2)
 ;;=^8133013
 ;;^UTILITY(U,$J,358.3,21349,0)
 ;;=I16.9^^73^929^16
 ;;^UTILITY(U,$J,358.3,21349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21349,1,3,0)
 ;;=3^Hypertensive Crisis,Unspec
 ;;^UTILITY(U,$J,358.3,21349,1,4,0)
 ;;=4^I16.9
 ;;^UTILITY(U,$J,358.3,21349,2)
 ;;=^5138600
 ;;^UTILITY(U,$J,358.3,21350,0)
 ;;=E78.01^^73^929^10
 ;;^UTILITY(U,$J,358.3,21350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21350,1,3,0)
 ;;=3^Familial Hypercholesterolemia
 ;;^UTILITY(U,$J,358.3,21350,1,4,0)
 ;;=4^E78.01
 ;;^UTILITY(U,$J,358.3,21350,2)
 ;;=^7570555
 ;;^UTILITY(U,$J,358.3,21351,0)
 ;;=E78.00^^73^929^22
 ;;^UTILITY(U,$J,358.3,21351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21351,1,3,0)
 ;;=3^Pure Hypercholesterolemia,Unspec
 ;;^UTILITY(U,$J,358.3,21351,1,4,0)
 ;;=4^E78.00
 ;;^UTILITY(U,$J,358.3,21351,2)
 ;;=^5138435
 ;;^UTILITY(U,$J,358.3,21352,0)
 ;;=I47.2^^73^929^24
 ;;^UTILITY(U,$J,358.3,21352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21352,1,3,0)
 ;;=3^Ventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,21352,1,4,0)
 ;;=4^I47.2
 ;;^UTILITY(U,$J,358.3,21352,2)
 ;;=^125976
 ;;^UTILITY(U,$J,358.3,21353,0)
 ;;=I42.6^^73^929^1
 ;;^UTILITY(U,$J,358.3,21353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21353,1,3,0)
 ;;=3^Alcoholic Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,21353,1,4,0)
 ;;=4^I42.6
 ;;^UTILITY(U,$J,358.3,21353,2)
 ;;=^5007197
 ;;^UTILITY(U,$J,358.3,21354,0)
 ;;=I51.7^^73^929^8
 ;;^UTILITY(U,$J,358.3,21354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21354,1,3,0)
 ;;=3^Cardiomegaly
 ;;^UTILITY(U,$J,358.3,21354,1,4,0)
 ;;=4^I51.7
 ;;^UTILITY(U,$J,358.3,21354,2)
 ;;=^5007257
 ;;^UTILITY(U,$J,358.3,21355,0)
 ;;=I48.20^^73^929^2
 ;;^UTILITY(U,$J,358.3,21355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21355,1,3,0)
 ;;=3^Atrial Fibrillation,Chronic,Unspec
 ;;^UTILITY(U,$J,358.3,21355,1,4,0)
 ;;=4^I48.20
 ;;^UTILITY(U,$J,358.3,21355,2)
 ;;=^5158048
 ;;^UTILITY(U,$J,358.3,21356,0)
 ;;=I48.11^^73^929^3
 ;;^UTILITY(U,$J,358.3,21356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21356,1,3,0)
 ;;=3^Atrial Fibrillation,Longstanding Persistent
 ;;^UTILITY(U,$J,358.3,21356,1,4,0)
 ;;=4^I48.11
 ;;^UTILITY(U,$J,358.3,21356,2)
 ;;=^5158046
 ;;^UTILITY(U,$J,358.3,21357,0)
 ;;=I48.19^^73^929^4
 ;;^UTILITY(U,$J,358.3,21357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21357,1,3,0)
 ;;=3^Atrial Fibrillation,Other Persistent
 ;;^UTILITY(U,$J,358.3,21357,1,4,0)
 ;;=4^I48.19
 ;;^UTILITY(U,$J,358.3,21357,2)
 ;;=^5158047
 ;;^UTILITY(U,$J,358.3,21358,0)
 ;;=I48.21^^73^929^5
 ;;^UTILITY(U,$J,358.3,21358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21358,1,3,0)
 ;;=3^Atrial Fibrillation,Permanent
 ;;^UTILITY(U,$J,358.3,21358,1,4,0)
 ;;=4^I48.21
 ;;^UTILITY(U,$J,358.3,21358,2)
 ;;=^304710
 ;;^UTILITY(U,$J,358.3,21359,0)
 ;;=B07.9^^73^930^328
 ;;^UTILITY(U,$J,358.3,21359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21359,1,3,0)
 ;;=3^Viral Wart,Unspec
 ;;^UTILITY(U,$J,358.3,21359,1,4,0)
 ;;=4^B07.9
 ;;^UTILITY(U,$J,358.3,21359,2)
 ;;=^5000519
 ;;^UTILITY(U,$J,358.3,21360,0)
 ;;=A63.0^^73^930^35
 ;;^UTILITY(U,$J,358.3,21360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21360,1,3,0)
 ;;=3^Anogenital (Venereal) Warts
 ;;^UTILITY(U,$J,358.3,21360,1,4,0)
 ;;=4^A63.0
 ;;^UTILITY(U,$J,358.3,21360,2)
 ;;=^5000360
 ;;^UTILITY(U,$J,358.3,21361,0)
 ;;=B35.0^^73^930^319
 ;;^UTILITY(U,$J,358.3,21361,1,0)
 ;;=^358.31IA^4^2
