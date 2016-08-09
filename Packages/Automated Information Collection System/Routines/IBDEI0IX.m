IBDEI0IX ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19075,0)
 ;;=I20.8^^86^980^2
 ;;^UTILITY(U,$J,358.3,19075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19075,1,3,0)
 ;;=3^Angina Pectoris,Oth Forms
 ;;^UTILITY(U,$J,358.3,19075,1,4,0)
 ;;=4^I20.8
 ;;^UTILITY(U,$J,358.3,19075,2)
 ;;=^5007078
 ;;^UTILITY(U,$J,358.3,19076,0)
 ;;=I20.1^^86^980^1
 ;;^UTILITY(U,$J,358.3,19076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19076,1,3,0)
 ;;=3^Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,19076,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,19076,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,19077,0)
 ;;=I25.119^^86^980^5
 ;;^UTILITY(U,$J,358.3,19077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19077,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/ Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,19077,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,19077,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,19078,0)
 ;;=I25.701^^86^980^9
 ;;^UTILITY(U,$J,358.3,19078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19078,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,19078,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,19078,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,19079,0)
 ;;=I25.708^^86^980^10
 ;;^UTILITY(U,$J,358.3,19079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19079,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Oth Angina Pectoris
 ;;^UTILITY(U,$J,358.3,19079,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,19079,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,19080,0)
 ;;=I20.9^^86^980^3
 ;;^UTILITY(U,$J,358.3,19080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19080,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,19080,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,19080,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,19081,0)
 ;;=I25.729^^86^980^4
 ;;^UTILITY(U,$J,358.3,19081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19081,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,19081,1,4,0)
 ;;=4^I25.729
 ;;^UTILITY(U,$J,358.3,19081,2)
 ;;=^5133561
 ;;^UTILITY(U,$J,358.3,19082,0)
 ;;=I25.709^^86^980^11
 ;;^UTILITY(U,$J,358.3,19082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19082,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,19082,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,19082,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,19083,0)
 ;;=I25.10^^86^980^6
 ;;^UTILITY(U,$J,358.3,19083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19083,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,19083,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,19083,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,19084,0)
 ;;=I25.810^^86^980^8
 ;;^UTILITY(U,$J,358.3,19084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19084,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,19084,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,19084,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,19085,0)
 ;;=I65.29^^86^981^18
 ;;^UTILITY(U,$J,358.3,19085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19085,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,19085,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,19085,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,19086,0)
 ;;=I65.22^^86^981^16
 ;;^UTILITY(U,$J,358.3,19086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19086,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,19086,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,19086,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,19087,0)
 ;;=I65.23^^86^981^15
 ;;^UTILITY(U,$J,358.3,19087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19087,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,19087,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,19087,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,19088,0)
 ;;=I65.21^^86^981^17
 ;;^UTILITY(U,$J,358.3,19088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19088,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,19088,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,19088,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,19089,0)
 ;;=I70.219^^86^981^3
 ;;^UTILITY(U,$J,358.3,19089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19089,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,19089,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,19089,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,19090,0)
 ;;=I70.213^^86^981^4
 ;;^UTILITY(U,$J,358.3,19090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19090,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
 ;;^UTILITY(U,$J,358.3,19090,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,19090,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,19091,0)
 ;;=I70.212^^86^981^5
 ;;^UTILITY(U,$J,358.3,19091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19091,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Left Leg
 ;;^UTILITY(U,$J,358.3,19091,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,19091,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,19092,0)
 ;;=I70.211^^86^981^6
 ;;^UTILITY(U,$J,358.3,19092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19092,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Right Leg
 ;;^UTILITY(U,$J,358.3,19092,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,19092,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,19093,0)
 ;;=I70.25^^86^981^2
 ;;^UTILITY(U,$J,358.3,19093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19093,1,3,0)
 ;;=3^Athscl Native Arteries of Extremitis w/ Ulceration
 ;;^UTILITY(U,$J,358.3,19093,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,19093,2)
 ;;=^5007602
 ;;^UTILITY(U,$J,358.3,19094,0)
 ;;=I70.249^^86^981^7
 ;;^UTILITY(U,$J,358.3,19094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19094,1,3,0)
 ;;=3^Athscl Natv Art of Lt Leg w/ Ulceration of Unspec Site
 ;;^UTILITY(U,$J,358.3,19094,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,19094,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,19095,0)
 ;;=I70.239^^86^981^8
 ;;^UTILITY(U,$J,358.3,19095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19095,1,3,0)
 ;;=3^Athscl Natv Art of Rt Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,19095,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,19095,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,19096,0)
 ;;=I70.269^^86^981^9
 ;;^UTILITY(U,$J,358.3,19096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19096,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Unspec Extremity
 ;;^UTILITY(U,$J,358.3,19096,1,4,0)
 ;;=4^I70.269
 ;;^UTILITY(U,$J,358.3,19096,2)
 ;;=^5007607
 ;;^UTILITY(U,$J,358.3,19097,0)
 ;;=I70.263^^86^981^10
 ;;^UTILITY(U,$J,358.3,19097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19097,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Bilateral Legs
 ;;^UTILITY(U,$J,358.3,19097,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,19097,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,19098,0)
 ;;=I70.262^^86^981^11
 ;;^UTILITY(U,$J,358.3,19098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19098,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Left Leg
 ;;^UTILITY(U,$J,358.3,19098,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,19098,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,19099,0)
 ;;=I70.261^^86^981^12
 ;;^UTILITY(U,$J,358.3,19099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19099,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Right Leg
 ;;^UTILITY(U,$J,358.3,19099,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,19099,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,19100,0)
 ;;=I71.2^^86^981^20
 ;;^UTILITY(U,$J,358.3,19100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19100,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,19100,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,19100,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,19101,0)
 ;;=I71.4^^86^981^1
 ;;^UTILITY(U,$J,358.3,19101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19101,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
