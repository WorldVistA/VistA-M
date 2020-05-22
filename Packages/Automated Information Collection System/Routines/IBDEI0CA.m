IBDEI0CA ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30076,1,3,0)
 ;;=3^Skin/Subcutaneous Tissue Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,30076,1,4,0)
 ;;=4^L98.9
 ;;^UTILITY(U,$J,358.3,30076,2)
 ;;=^5009595
 ;;^UTILITY(U,$J,358.3,30077,0)
 ;;=I70.731^^92^1195^81
 ;;^UTILITY(U,$J,358.3,30077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30077,1,3,0)
 ;;=3^Athscl of Bypass Graft of Right Leg w/ Thigh Ulcer
 ;;^UTILITY(U,$J,358.3,30077,1,4,0)
 ;;=4^I70.731
 ;;^UTILITY(U,$J,358.3,30077,2)
 ;;=^5007769
 ;;^UTILITY(U,$J,358.3,30078,0)
 ;;=I70.732^^92^1195^82
 ;;^UTILITY(U,$J,358.3,30078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30078,1,3,0)
 ;;=3^Athscl of Bypass Graft of Right Leg w/ Calf Ulcer
 ;;^UTILITY(U,$J,358.3,30078,1,4,0)
 ;;=4^I70.732
 ;;^UTILITY(U,$J,358.3,30078,2)
 ;;=^5007770
 ;;^UTILITY(U,$J,358.3,30079,0)
 ;;=I70.733^^92^1195^83
 ;;^UTILITY(U,$J,358.3,30079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30079,1,3,0)
 ;;=3^Athscl of Bypass Graft of Right Leg w/ Ankle Ulcer
 ;;^UTILITY(U,$J,358.3,30079,1,4,0)
 ;;=4^I70.733
 ;;^UTILITY(U,$J,358.3,30079,2)
 ;;=^5007771
 ;;^UTILITY(U,$J,358.3,30080,0)
 ;;=I70.734^^92^1195^84
 ;;^UTILITY(U,$J,358.3,30080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30080,1,3,0)
 ;;=3^Athscl of Bypass Graft of Right Leg w/ Heel/Midfoot Ulcer
 ;;^UTILITY(U,$J,358.3,30080,1,4,0)
 ;;=4^I70.734
 ;;^UTILITY(U,$J,358.3,30080,2)
 ;;=^5007772
 ;;^UTILITY(U,$J,358.3,30081,0)
 ;;=I70.735^^92^1195^85
 ;;^UTILITY(U,$J,358.3,30081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30081,1,3,0)
 ;;=3^Athscl of Bypass Graft of Right Leg w/ Oth Part Foot Ulcer
 ;;^UTILITY(U,$J,358.3,30081,1,4,0)
 ;;=4^I70.735
 ;;^UTILITY(U,$J,358.3,30081,2)
 ;;=^5007773
 ;;^UTILITY(U,$J,358.3,30082,0)
 ;;=I70.741^^92^1195^80
 ;;^UTILITY(U,$J,358.3,30082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30082,1,3,0)
 ;;=3^Athscl of Bypass Graft of Left Leg w/ Thigh Ulcer
 ;;^UTILITY(U,$J,358.3,30082,1,4,0)
 ;;=4^I70.741
 ;;^UTILITY(U,$J,358.3,30082,2)
 ;;=^5133601
 ;;^UTILITY(U,$J,358.3,30083,0)
 ;;=I70.742^^92^1195^77
 ;;^UTILITY(U,$J,358.3,30083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30083,1,3,0)
 ;;=3^Athscl of Bypass Graft of Left Leg w/ Calf Ulcer
 ;;^UTILITY(U,$J,358.3,30083,1,4,0)
 ;;=4^I70.742
 ;;^UTILITY(U,$J,358.3,30083,2)
 ;;=^5133602
 ;;^UTILITY(U,$J,358.3,30084,0)
 ;;=I70.743^^92^1195^76
 ;;^UTILITY(U,$J,358.3,30084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30084,1,3,0)
 ;;=3^Athscl of Bypass Graft of Left Leg w/ Ankle Ulcer
 ;;^UTILITY(U,$J,358.3,30084,1,4,0)
 ;;=4^I70.743
 ;;^UTILITY(U,$J,358.3,30084,2)
 ;;=^5133603
 ;;^UTILITY(U,$J,358.3,30085,0)
 ;;=I70.744^^92^1195^78
 ;;^UTILITY(U,$J,358.3,30085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30085,1,3,0)
 ;;=3^Athscl of Bypass Graft of Left Leg w/ Heel/Midfoot Ulcer
 ;;^UTILITY(U,$J,358.3,30085,1,4,0)
 ;;=4^I70.744
 ;;^UTILITY(U,$J,358.3,30085,2)
 ;;=^5133604
 ;;^UTILITY(U,$J,358.3,30086,0)
 ;;=I70.745^^92^1195^79
 ;;^UTILITY(U,$J,358.3,30086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30086,1,3,0)
 ;;=3^Athscl of Bypass Graft of Left Leg w/ Oth Part Foot Ulcer
 ;;^UTILITY(U,$J,358.3,30086,1,4,0)
 ;;=4^I70.745
 ;;^UTILITY(U,$J,358.3,30086,2)
 ;;=^5133605
 ;;^UTILITY(U,$J,358.3,30087,0)
 ;;=I83.009^^92^1195^327
 ;;^UTILITY(U,$J,358.3,30087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30087,1,3,0)
 ;;=3^Varicose Veins of Lower Extremity w/ Ulcer
 ;;^UTILITY(U,$J,358.3,30087,1,4,0)
 ;;=4^I83.009
 ;;^UTILITY(U,$J,358.3,30087,2)
 ;;=^5007972
 ;;^UTILITY(U,$J,358.3,30088,0)
 ;;=N61.1^^92^1195^1
 ;;^UTILITY(U,$J,358.3,30088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30088,1,3,0)
 ;;=3^Abscess of Breast & Nipple
 ;;^UTILITY(U,$J,358.3,30088,1,4,0)
 ;;=4^N61.1
 ;;^UTILITY(U,$J,358.3,30088,2)
 ;;=^5138937
 ;;^UTILITY(U,$J,358.3,30089,0)
 ;;=L03.213^^92^1195^96
 ;;^UTILITY(U,$J,358.3,30089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30089,1,3,0)
 ;;=3^Cellulitis Periorbital
 ;;^UTILITY(U,$J,358.3,30089,1,4,0)
 ;;=4^L03.213
 ;;^UTILITY(U,$J,358.3,30089,2)
 ;;=^259555
 ;;^UTILITY(U,$J,358.3,30090,0)
 ;;=L90.0^^92^1195^170
 ;;^UTILITY(U,$J,358.3,30090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30090,1,3,0)
 ;;=3^Lichen Sclerosus et Atrophicus
 ;;^UTILITY(U,$J,358.3,30090,1,4,0)
 ;;=4^L90.0
 ;;^UTILITY(U,$J,358.3,30090,2)
 ;;=^70699
 ;;^UTILITY(U,$J,358.3,30091,0)
 ;;=N63.20^^92^1195^172
 ;;^UTILITY(U,$J,358.3,30091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30091,1,3,0)
 ;;=3^Lump,Left Breast,Unspec Quadrant
 ;;^UTILITY(U,$J,358.3,30091,1,4,0)
 ;;=4^N63.20
 ;;^UTILITY(U,$J,358.3,30091,2)
 ;;=^5151524
 ;;^UTILITY(U,$J,358.3,30092,0)
 ;;=N63.10^^92^1195^173
 ;;^UTILITY(U,$J,358.3,30092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30092,1,3,0)
 ;;=3^Lump,Right Breast,Unspec Quadrant
 ;;^UTILITY(U,$J,358.3,30092,1,4,0)
 ;;=4^N63.10
 ;;^UTILITY(U,$J,358.3,30092,2)
 ;;=^5151519
 ;;^UTILITY(U,$J,358.3,30093,0)
 ;;=L97.326^^92^1195^182
 ;;^UTILITY(U,$J,358.3,30093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30093,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Ankle w/ Bone Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30093,1,4,0)
 ;;=4^L97.326
 ;;^UTILITY(U,$J,358.3,30093,2)
 ;;=^5151455
 ;;^UTILITY(U,$J,358.3,30094,0)
 ;;=L97.325^^92^1195^183
 ;;^UTILITY(U,$J,358.3,30094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30094,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Ankle w/ Msl Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30094,1,4,0)
 ;;=4^L97.325
 ;;^UTILITY(U,$J,358.3,30094,2)
 ;;=^5151454
 ;;^UTILITY(U,$J,358.3,30095,0)
 ;;=L97.328^^92^1195^184
 ;;^UTILITY(U,$J,358.3,30095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30095,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Ankle w/ Oth Severity
 ;;^UTILITY(U,$J,358.3,30095,1,4,0)
 ;;=4^L97.328
 ;;^UTILITY(U,$J,358.3,30095,2)
 ;;=^5151456
 ;;^UTILITY(U,$J,358.3,30096,0)
 ;;=L97.226^^92^1195^190
 ;;^UTILITY(U,$J,358.3,30096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30096,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Bone Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30096,1,4,0)
 ;;=4^L97.226
 ;;^UTILITY(U,$J,358.3,30096,2)
 ;;=^5151446
 ;;^UTILITY(U,$J,358.3,30097,0)
 ;;=L97.225^^92^1195^191
 ;;^UTILITY(U,$J,358.3,30097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30097,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Msl Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30097,1,4,0)
 ;;=4^L97.225
 ;;^UTILITY(U,$J,358.3,30097,2)
 ;;=^5151445
 ;;^UTILITY(U,$J,358.3,30098,0)
 ;;=L97.228^^92^1195^192
 ;;^UTILITY(U,$J,358.3,30098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30098,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Oth Severity
 ;;^UTILITY(U,$J,358.3,30098,1,4,0)
 ;;=4^L97.228
 ;;^UTILITY(U,$J,358.3,30098,2)
 ;;=^5151447
 ;;^UTILITY(U,$J,358.3,30099,0)
 ;;=L97.526^^92^1195^198
 ;;^UTILITY(U,$J,358.3,30099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30099,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Foot w/ Bone Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30099,1,4,0)
 ;;=4^L97.526
 ;;^UTILITY(U,$J,358.3,30099,2)
 ;;=^5151473
 ;;^UTILITY(U,$J,358.3,30100,0)
 ;;=L97.525^^92^1195^199
 ;;^UTILITY(U,$J,358.3,30100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30100,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Foot w/ Msl Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30100,1,4,0)
 ;;=4^L97.525
 ;;^UTILITY(U,$J,358.3,30100,2)
 ;;=^5151472
 ;;^UTILITY(U,$J,358.3,30101,0)
 ;;=L97.528^^92^1195^200
 ;;^UTILITY(U,$J,358.3,30101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30101,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Foot w/ Oth Severity
 ;;^UTILITY(U,$J,358.3,30101,1,4,0)
 ;;=4^L97.528
 ;;^UTILITY(U,$J,358.3,30101,2)
 ;;=^5151474
 ;;^UTILITY(U,$J,358.3,30102,0)
 ;;=L97.426^^92^1195^206
 ;;^UTILITY(U,$J,358.3,30102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30102,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Heel/Midft w/ Bone Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30102,1,4,0)
 ;;=4^L97.426
 ;;^UTILITY(U,$J,358.3,30102,2)
 ;;=^5151464
 ;;^UTILITY(U,$J,358.3,30103,0)
 ;;=L97.925^^92^1195^212
 ;;^UTILITY(U,$J,358.3,30103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30103,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Lower Leg w/ Msl Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30103,1,4,0)
 ;;=4^L97.925
 ;;^UTILITY(U,$J,358.3,30103,2)
 ;;=^5151490
 ;;^UTILITY(U,$J,358.3,30104,0)
 ;;=L97.928^^92^1195^213
 ;;^UTILITY(U,$J,358.3,30104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30104,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Lower Leg w/ Oth Severity
 ;;^UTILITY(U,$J,358.3,30104,1,4,0)
 ;;=4^L97.928
 ;;^UTILITY(U,$J,358.3,30104,2)
 ;;=^5151492
 ;;^UTILITY(U,$J,358.3,30105,0)
 ;;=L97.126^^92^1195^219
 ;;^UTILITY(U,$J,358.3,30105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30105,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Bone Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30105,1,4,0)
 ;;=4^L97.126
 ;;^UTILITY(U,$J,358.3,30105,2)
 ;;=^5151437
 ;;^UTILITY(U,$J,358.3,30106,0)
 ;;=L97.125^^92^1195^220
 ;;^UTILITY(U,$J,358.3,30106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30106,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Msl Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30106,1,4,0)
 ;;=4^L97.125
 ;;^UTILITY(U,$J,358.3,30106,2)
 ;;=^5151436
 ;;^UTILITY(U,$J,358.3,30107,0)
 ;;=L97.128^^92^1195^221
 ;;^UTILITY(U,$J,358.3,30107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30107,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Oth Severity
 ;;^UTILITY(U,$J,358.3,30107,1,4,0)
 ;;=4^L97.128
 ;;^UTILITY(U,$J,358.3,30107,2)
 ;;=^5151438
 ;;^UTILITY(U,$J,358.3,30108,0)
 ;;=L97.316^^92^1195^227
 ;;^UTILITY(U,$J,358.3,30108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30108,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Ankle w/ Bone Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30108,1,4,0)
 ;;=4^L97.316
 ;;^UTILITY(U,$J,358.3,30108,2)
 ;;=^5151452
 ;;^UTILITY(U,$J,358.3,30109,0)
 ;;=L97.315^^92^1195^228
 ;;^UTILITY(U,$J,358.3,30109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30109,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Ankle w/ Msl Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30109,1,4,0)
 ;;=4^L97.315
 ;;^UTILITY(U,$J,358.3,30109,2)
 ;;=^5151451
 ;;^UTILITY(U,$J,358.3,30110,0)
 ;;=L97.318^^92^1195^229
 ;;^UTILITY(U,$J,358.3,30110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30110,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Ankle w/ Oth Severity
 ;;^UTILITY(U,$J,358.3,30110,1,4,0)
 ;;=4^L97.318
 ;;^UTILITY(U,$J,358.3,30110,2)
 ;;=^5151453
 ;;^UTILITY(U,$J,358.3,30111,0)
 ;;=L97.216^^92^1195^235
 ;;^UTILITY(U,$J,358.3,30111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30111,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Bone Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30111,1,4,0)
 ;;=4^L97.216
 ;;^UTILITY(U,$J,358.3,30111,2)
 ;;=^5151443
 ;;^UTILITY(U,$J,358.3,30112,0)
 ;;=L97.215^^92^1195^236
 ;;^UTILITY(U,$J,358.3,30112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30112,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Msl Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30112,1,4,0)
 ;;=4^L97.215
 ;;^UTILITY(U,$J,358.3,30112,2)
 ;;=^5151442
 ;;^UTILITY(U,$J,358.3,30113,0)
 ;;=L97.218^^92^1195^237
 ;;^UTILITY(U,$J,358.3,30113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30113,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Oth Severity
 ;;^UTILITY(U,$J,358.3,30113,1,4,0)
 ;;=4^L97.218
 ;;^UTILITY(U,$J,358.3,30113,2)
 ;;=^5151444
 ;;^UTILITY(U,$J,358.3,30114,0)
 ;;=L97.516^^92^1195^243
 ;;^UTILITY(U,$J,358.3,30114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30114,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Foot w/ Bone Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30114,1,4,0)
 ;;=4^L97.516
 ;;^UTILITY(U,$J,358.3,30114,2)
 ;;=^5151470
 ;;^UTILITY(U,$J,358.3,30115,0)
 ;;=L97.515^^92^1195^244
 ;;^UTILITY(U,$J,358.3,30115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30115,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Foot w/ Msl Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30115,1,4,0)
 ;;=4^L97.515
 ;;^UTILITY(U,$J,358.3,30115,2)
 ;;=^5151469
 ;;^UTILITY(U,$J,358.3,30116,0)
 ;;=L97.518^^92^1195^245
 ;;^UTILITY(U,$J,358.3,30116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30116,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Foot w/ Oth Severity
 ;;^UTILITY(U,$J,358.3,30116,1,4,0)
 ;;=4^L97.518
 ;;^UTILITY(U,$J,358.3,30116,2)
 ;;=^5151471
 ;;^UTILITY(U,$J,358.3,30117,0)
 ;;=L97.416^^92^1195^251
 ;;^UTILITY(U,$J,358.3,30117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30117,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Heel/Midft w/ Bone Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30117,1,4,0)
 ;;=4^L97.416
 ;;^UTILITY(U,$J,358.3,30117,2)
 ;;=^5151461
 ;;^UTILITY(U,$J,358.3,30118,0)
 ;;=L97.415^^92^1195^252
 ;;^UTILITY(U,$J,358.3,30118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30118,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Heel/Midft w/ Msl Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30118,1,4,0)
 ;;=4^L97.415
 ;;^UTILITY(U,$J,358.3,30118,2)
 ;;=^5151460
 ;;^UTILITY(U,$J,358.3,30119,0)
 ;;=L97.418^^92^1195^253
 ;;^UTILITY(U,$J,358.3,30119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30119,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Hell/Midft w/ Oth Severity
 ;;^UTILITY(U,$J,358.3,30119,1,4,0)
 ;;=4^L97.418
 ;;^UTILITY(U,$J,358.3,30119,2)
 ;;=^5151462
 ;;^UTILITY(U,$J,358.3,30120,0)
 ;;=L97.916^^92^1195^259
 ;;^UTILITY(U,$J,358.3,30120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30120,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Lower Leg w/ Bone Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30120,1,4,0)
 ;;=4^L97.916
 ;;^UTILITY(U,$J,358.3,30120,2)
 ;;=^5151488
 ;;^UTILITY(U,$J,358.3,30121,0)
 ;;=L97.915^^92^1195^260
 ;;^UTILITY(U,$J,358.3,30121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30121,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Lower Leg w/ Msl Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30121,1,4,0)
 ;;=4^L97.915
 ;;^UTILITY(U,$J,358.3,30121,2)
 ;;=^5151487
 ;;^UTILITY(U,$J,358.3,30122,0)
 ;;=L97.918^^92^1195^261
 ;;^UTILITY(U,$J,358.3,30122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30122,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Lower Leg w/ Oth Severity
 ;;^UTILITY(U,$J,358.3,30122,1,4,0)
 ;;=4^L97.918
 ;;^UTILITY(U,$J,358.3,30122,2)
 ;;=^5151489
 ;;^UTILITY(U,$J,358.3,30123,0)
 ;;=L97.116^^92^1195^267
 ;;^UTILITY(U,$J,358.3,30123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30123,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Bone Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30123,1,4,0)
 ;;=4^L97.116
 ;;^UTILITY(U,$J,358.3,30123,2)
 ;;=^5151434
 ;;^UTILITY(U,$J,358.3,30124,0)
 ;;=L97.115^^92^1195^268
 ;;^UTILITY(U,$J,358.3,30124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30124,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Msl Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,30124,1,4,0)
 ;;=4^L97.115
 ;;^UTILITY(U,$J,358.3,30124,2)
 ;;=^5151433
 ;;^UTILITY(U,$J,358.3,30125,0)
 ;;=L89.306^^92^1195^276
 ;;^UTILITY(U,$J,358.3,30125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30125,1,3,0)
 ;;=3^Pressure Induced Deep Tissue Damage,Unspec Buttock
 ;;^UTILITY(U,$J,358.3,30125,1,4,0)
 ;;=4^L89.306
 ;;^UTILITY(U,$J,358.3,30125,2)
 ;;=^5158088
 ;;^UTILITY(U,$J,358.3,30126,0)
 ;;=L89.46^^92^1195^275
 ;;^UTILITY(U,$J,358.3,30126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30126,1,3,0)
 ;;=3^Pressure Induced Deep Tissue Damage,Contig Site:Back/Buttock/Hip
 ;;^UTILITY(U,$J,358.3,30126,1,4,0)
 ;;=4^L89.46
 ;;^UTILITY(U,$J,358.3,30126,2)
 ;;=^5158091
 ;;^UTILITY(U,$J,358.3,30127,0)
 ;;=L02.818^^92^1195^128
 ;;^UTILITY(U,$J,358.3,30127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30127,1,3,0)
 ;;=3^Cutaneous Abscess of Other Sites
 ;;^UTILITY(U,$J,358.3,30127,1,4,0)
 ;;=4^L02.818
 ;;^UTILITY(U,$J,358.3,30127,2)
 ;;=^5009011
 ;;^UTILITY(U,$J,358.3,30128,0)
 ;;=H65.03^^92^1196^3
 ;;^UTILITY(U,$J,358.3,30128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30128,1,3,0)
 ;;=3^Acute Serous Otitis Media,Bilateral
 ;;^UTILITY(U,$J,358.3,30128,1,4,0)
 ;;=4^H65.03
 ;;^UTILITY(U,$J,358.3,30128,2)
 ;;=^5006572
 ;;^UTILITY(U,$J,358.3,30129,0)
 ;;=H65.01^^92^1196^5
 ;;^UTILITY(U,$J,358.3,30129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30129,1,3,0)
 ;;=3^Acute Serous Otitis Media,Right Ear
 ;;^UTILITY(U,$J,358.3,30129,1,4,0)
 ;;=4^H65.01
 ;;^UTILITY(U,$J,358.3,30129,2)
 ;;=^5006570
 ;;^UTILITY(U,$J,358.3,30130,0)
 ;;=H65.23^^92^1196^15
 ;;^UTILITY(U,$J,358.3,30130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30130,1,3,0)
 ;;=3^Chronic Serous Otitis Media,Bilateral
 ;;^UTILITY(U,$J,358.3,30130,1,4,0)
 ;;=4^H65.23
 ;;^UTILITY(U,$J,358.3,30130,2)
 ;;=^5006596
 ;;^UTILITY(U,$J,358.3,30131,0)
 ;;=H65.22^^92^1196^16
 ;;^UTILITY(U,$J,358.3,30131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30131,1,3,0)
 ;;=3^Chronic Serous Otitis Media,Left Ear
 ;;^UTILITY(U,$J,358.3,30131,1,4,0)
 ;;=4^H65.22
 ;;^UTILITY(U,$J,358.3,30131,2)
 ;;=^5006595
 ;;^UTILITY(U,$J,358.3,30132,0)
 ;;=H65.21^^92^1196^17
 ;;^UTILITY(U,$J,358.3,30132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30132,1,3,0)
 ;;=3^Chronic Serous Otitis Media,Right Ear
 ;;^UTILITY(U,$J,358.3,30132,1,4,0)
 ;;=4^H65.21
 ;;^UTILITY(U,$J,358.3,30132,2)
 ;;=^5006594
 ;;^UTILITY(U,$J,358.3,30133,0)
 ;;=H66.012^^92^1196^6
 ;;^UTILITY(U,$J,358.3,30133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30133,1,3,0)
 ;;=3^Acute Suppr Otitis Media w/ Spon Rupt Ear Drum,Left Ear
 ;;^UTILITY(U,$J,358.3,30133,1,4,0)
 ;;=4^H66.012
 ;;^UTILITY(U,$J,358.3,30133,2)
 ;;=^5133534
 ;;^UTILITY(U,$J,358.3,30134,0)
 ;;=H66.011^^92^1196^7
 ;;^UTILITY(U,$J,358.3,30134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30134,1,3,0)
 ;;=3^Acute Suppr Otitis Media w/ Spon Rupt Ear Drum,Right Ear
 ;;^UTILITY(U,$J,358.3,30134,1,4,0)
 ;;=4^H66.011
 ;;^UTILITY(U,$J,358.3,30134,2)
 ;;=^5006621
 ;;^UTILITY(U,$J,358.3,30135,0)
 ;;=H66.91^^92^1196^36
 ;;^UTILITY(U,$J,358.3,30135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30135,1,3,0)
 ;;=3^Otitis Media,Unspec,Right Ear
 ;;^UTILITY(U,$J,358.3,30135,1,4,0)
 ;;=4^H66.91
 ;;^UTILITY(U,$J,358.3,30135,2)
 ;;=^5006640
 ;;^UTILITY(U,$J,358.3,30136,0)
 ;;=H66.92^^92^1196^35
 ;;^UTILITY(U,$J,358.3,30136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30136,1,3,0)
 ;;=3^Otitis Media,Unspec,Left Ear
 ;;^UTILITY(U,$J,358.3,30136,1,4,0)
 ;;=4^H66.92
 ;;^UTILITY(U,$J,358.3,30136,2)
 ;;=^5006641
 ;;^UTILITY(U,$J,358.3,30137,0)
 ;;=H66.93^^92^1196^34
 ;;^UTILITY(U,$J,358.3,30137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30137,1,3,0)
 ;;=3^Otitis Media,Unspec,Bilateral
 ;;^UTILITY(U,$J,358.3,30137,1,4,0)
 ;;=4^H66.93
 ;;^UTILITY(U,$J,358.3,30137,2)
 ;;=^5006642
 ;;^UTILITY(U,$J,358.3,30138,0)
 ;;=H81.10^^92^1196^37
 ;;^UTILITY(U,$J,358.3,30138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30138,1,3,0)
 ;;=3^Paroxysmal Veritgo,Benign,Unspec Ear
 ;;^UTILITY(U,$J,358.3,30138,1,4,0)
 ;;=4^H81.10
 ;;^UTILITY(U,$J,358.3,30138,2)
 ;;=^5006864
 ;;^UTILITY(U,$J,358.3,30139,0)
 ;;=H93.13^^92^1196^41
 ;;^UTILITY(U,$J,358.3,30139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30139,1,3,0)
 ;;=3^Tinnitus,Bilateral
 ;;^UTILITY(U,$J,358.3,30139,1,4,0)
 ;;=4^H93.13
 ;;^UTILITY(U,$J,358.3,30139,2)
 ;;=^5006966
