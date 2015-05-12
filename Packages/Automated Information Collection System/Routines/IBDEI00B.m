IBDEI00B ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,73,0)
 ;;=L03.116^^1^1^40
 ;;^UTILITY(U,$J,358.3,73,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,73,1,3,0)
 ;;=3^Cellulitis of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,73,1,4,0)
 ;;=4^L03.116
 ;;^UTILITY(U,$J,358.3,73,2)
 ;;=^5133645
 ;;^UTILITY(U,$J,358.3,74,0)
 ;;=L03.114^^1^1^41
 ;;^UTILITY(U,$J,358.3,74,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,74,1,3,0)
 ;;=3^Cellulitis of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,74,1,4,0)
 ;;=4^L03.114
 ;;^UTILITY(U,$J,358.3,74,2)
 ;;=^5009034
 ;;^UTILITY(U,$J,358.3,75,0)
 ;;=L03.111^^1^1^42
 ;;^UTILITY(U,$J,358.3,75,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,75,1,3,0)
 ;;=3^Cellulitis of Right Axilla
 ;;^UTILITY(U,$J,358.3,75,1,4,0)
 ;;=4^L03.111
 ;;^UTILITY(U,$J,358.3,75,2)
 ;;=^5009031
 ;;^UTILITY(U,$J,358.3,76,0)
 ;;=L03.115^^1^1^43
 ;;^UTILITY(U,$J,358.3,76,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,76,1,3,0)
 ;;=3^Cellulitis of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,76,1,4,0)
 ;;=4^L03.115
 ;;^UTILITY(U,$J,358.3,76,2)
 ;;=^5009035
 ;;^UTILITY(U,$J,358.3,77,0)
 ;;=L03.113^^1^1^44
 ;;^UTILITY(U,$J,358.3,77,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,77,1,3,0)
 ;;=3^Cellulitis of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,77,1,4,0)
 ;;=4^L03.113
 ;;^UTILITY(U,$J,358.3,77,2)
 ;;=^5009033
 ;;^UTILITY(U,$J,358.3,78,0)
 ;;=I63.131^^1^1^47
 ;;^UTILITY(U,$J,358.3,78,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,78,1,3,0)
 ;;=3^Cerebral Infarction d/t Right Carotid Artery Embolism
 ;;^UTILITY(U,$J,358.3,78,1,4,0)
 ;;=4^I63.131
 ;;^UTILITY(U,$J,358.3,78,2)
 ;;=^5007308
 ;;^UTILITY(U,$J,358.3,79,0)
 ;;=I63.132^^1^1^45
 ;;^UTILITY(U,$J,358.3,79,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,79,1,3,0)
 ;;=3^Cerebral Infarction d/t Left Carotid Artery Embolism
 ;;^UTILITY(U,$J,358.3,79,1,4,0)
 ;;=4^I63.132
 ;;^UTILITY(U,$J,358.3,79,2)
 ;;=^5007309
 ;;^UTILITY(U,$J,358.3,80,0)
 ;;=I63.231^^1^1^48
 ;;^UTILITY(U,$J,358.3,80,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,80,1,3,0)
 ;;=3^Cerebral Infarction d/t Right Carotid Artery Occlusion/Stenosis
 ;;^UTILITY(U,$J,358.3,80,1,4,0)
 ;;=4^I63.231
 ;;^UTILITY(U,$J,358.3,80,2)
 ;;=^5007316
 ;;^UTILITY(U,$J,358.3,81,0)
 ;;=I63.232^^1^1^46
 ;;^UTILITY(U,$J,358.3,81,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,81,1,3,0)
 ;;=3^Cerebral Infarction d/t Left Carotid Artery Occlusion/Stenosis
 ;;^UTILITY(U,$J,358.3,81,1,4,0)
 ;;=4^I63.232
 ;;^UTILITY(U,$J,358.3,81,2)
 ;;=^5007317
 ;;^UTILITY(U,$J,358.3,82,0)
 ;;=N18.9^^1^1^50
 ;;^UTILITY(U,$J,358.3,82,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,82,1,3,0)
 ;;=3^Chronic Kidney Disease,Unspec
 ;;^UTILITY(U,$J,358.3,82,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,82,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,83,0)
 ;;=K55.1^^1^1^53
 ;;^UTILITY(U,$J,358.3,83,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,83,1,3,0)
 ;;=3^Chronic Vascular Intestinal Disorders
 ;;^UTILITY(U,$J,358.3,83,1,4,0)
 ;;=4^K55.1
 ;;^UTILITY(U,$J,358.3,83,2)
 ;;=^5008706
 ;;^UTILITY(U,$J,358.3,84,0)
 ;;=I74.3^^1^1^99
 ;;^UTILITY(U,$J,358.3,84,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,84,1,3,0)
 ;;=3^Embolism/Thrombosis of Lower Extremity Arteries
 ;;^UTILITY(U,$J,358.3,84,1,4,0)
 ;;=4^I74.3
 ;;^UTILITY(U,$J,358.3,84,2)
 ;;=^5007802
 ;;^UTILITY(U,$J,358.3,85,0)
 ;;=I74.2^^1^1^111
 ;;^UTILITY(U,$J,358.3,85,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,85,1,3,0)
 ;;=3^Embolism/Thrombosis of Upper Extremity Arteries
 ;;^UTILITY(U,$J,358.3,85,1,4,0)
 ;;=4^I74.2
 ;;^UTILITY(U,$J,358.3,85,2)
 ;;=^5007801
 ;;^UTILITY(U,$J,358.3,86,0)
 ;;=N28.0^^1^1^112
 ;;^UTILITY(U,$J,358.3,86,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,86,1,3,0)
 ;;=3^Ischemia/Infarction of Kidney
 ;;^UTILITY(U,$J,358.3,86,1,4,0)
 ;;=4^N28.0
 ;;^UTILITY(U,$J,358.3,86,2)
 ;;=^5015626
 ;;^UTILITY(U,$J,358.3,87,0)
 ;;=S91.322A^^1^1^113
 ;;^UTILITY(U,$J,358.3,87,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,87,1,3,0)
 ;;=3^Laceration w/ FB Left Foot,Init Encntr
 ;;^UTILITY(U,$J,358.3,87,1,4,0)
 ;;=4^S91.322A
 ;;^UTILITY(U,$J,358.3,87,2)
 ;;=^5137527
 ;;^UTILITY(U,$J,358.3,88,0)
 ;;=S71.022A^^1^1^114
 ;;^UTILITY(U,$J,358.3,88,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,88,1,3,0)
 ;;=3^Laceration w/ FB Left Hip,Init Encntr
 ;;^UTILITY(U,$J,358.3,88,1,4,0)
 ;;=4^S71.022A
 ;;^UTILITY(U,$J,358.3,88,2)
 ;;=^5136178
 ;;^UTILITY(U,$J,358.3,89,0)
 ;;=S71.122A^^1^1^115
 ;;^UTILITY(U,$J,358.3,89,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,89,1,3,0)
 ;;=3^Laceration w/ FB Left Thigh,Init Encntr
 ;;^UTILITY(U,$J,358.3,89,1,4,0)
 ;;=4^S71.122A
 ;;^UTILITY(U,$J,358.3,89,2)
 ;;=^5136193
 ;;^UTILITY(U,$J,358.3,90,0)
 ;;=S91.321A^^1^1^116
 ;;^UTILITY(U,$J,358.3,90,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,90,1,3,0)
 ;;=3^Laceration w/ FB Right Foot,Init Encntr
 ;;^UTILITY(U,$J,358.3,90,1,4,0)
 ;;=4^S91.321A
 ;;^UTILITY(U,$J,358.3,90,2)
 ;;=^5044329
 ;;^UTILITY(U,$J,358.3,91,0)
 ;;=S71.021A^^1^1^117
 ;;^UTILITY(U,$J,358.3,91,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,91,1,3,0)
 ;;=3^Laceration w/ FB Right Hip,Init Encntr
 ;;^UTILITY(U,$J,358.3,91,1,4,0)
 ;;=4^S71.021A
 ;;^UTILITY(U,$J,358.3,91,2)
 ;;=^5036984
 ;;^UTILITY(U,$J,358.3,92,0)
 ;;=S71.121A^^1^1^118
 ;;^UTILITY(U,$J,358.3,92,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,92,1,3,0)
 ;;=3^Laceration w/ FB Right Thigh,Init Encntr
 ;;^UTILITY(U,$J,358.3,92,1,4,0)
 ;;=4^S71.121A
 ;;^UTILITY(U,$J,358.3,92,2)
 ;;=^5037023
 ;;^UTILITY(U,$J,358.3,93,0)
 ;;=I89.0^^1^1^119
 ;;^UTILITY(U,$J,358.3,93,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,93,1,3,0)
 ;;=3^Lymphedema NEC
 ;;^UTILITY(U,$J,358.3,93,1,4,0)
 ;;=4^I89.0
 ;;^UTILITY(U,$J,358.3,93,2)
 ;;=^5008073
 ;;^UTILITY(U,$J,358.3,94,0)
 ;;=L98.429^^1^1^120
 ;;^UTILITY(U,$J,358.3,94,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,94,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Back w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,94,1,4,0)
 ;;=4^L98.429
 ;;^UTILITY(U,$J,358.3,94,2)
 ;;=^5009586
 ;;^UTILITY(U,$J,358.3,95,0)
 ;;=L98.419^^1^1^121
 ;;^UTILITY(U,$J,358.3,95,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,95,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Buttock w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,95,1,4,0)
 ;;=4^L98.419
 ;;^UTILITY(U,$J,358.3,95,2)
 ;;=^5009581
 ;;^UTILITY(U,$J,358.3,96,0)
 ;;=L97.229^^1^1^122
 ;;^UTILITY(U,$J,358.3,96,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,96,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,96,1,4,0)
 ;;=4^L97.229
 ;;^UTILITY(U,$J,358.3,96,2)
 ;;=^5009509
 ;;^UTILITY(U,$J,358.3,97,0)
 ;;=L97.429^^1^1^124
 ;;^UTILITY(U,$J,358.3,97,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,97,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Heel/Midfoot w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,97,1,4,0)
 ;;=4^L97.429
 ;;^UTILITY(U,$J,358.3,97,2)
 ;;=^5009539
 ;;^UTILITY(U,$J,358.3,98,0)
 ;;=L97.129^^1^1^125
 ;;^UTILITY(U,$J,358.3,98,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,98,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,98,1,4,0)
 ;;=4^L97.129
 ;;^UTILITY(U,$J,358.3,98,2)
 ;;=^5009494
 ;;^UTILITY(U,$J,358.3,99,0)
 ;;=L97.529^^1^1^123
 ;;^UTILITY(U,$J,358.3,99,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,99,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Foot w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,99,1,4,0)
 ;;=4^L97.529
 ;;^UTILITY(U,$J,358.3,99,2)
 ;;=^5009554
 ;;^UTILITY(U,$J,358.3,100,0)
 ;;=L97.219^^1^1^126
 ;;^UTILITY(U,$J,358.3,100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,100,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,100,1,4,0)
 ;;=4^L97.219
 ;;^UTILITY(U,$J,358.3,100,2)
 ;;=^5009504
 ;;^UTILITY(U,$J,358.3,101,0)
 ;;=L97.419^^1^1^128
 ;;^UTILITY(U,$J,358.3,101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,101,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Heel/Midfoot w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,101,1,4,0)
 ;;=4^L97.419
 ;;^UTILITY(U,$J,358.3,101,2)
 ;;=^5009534
 ;;^UTILITY(U,$J,358.3,102,0)
 ;;=L97.119^^1^1^129
 ;;^UTILITY(U,$J,358.3,102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,102,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,102,1,4,0)
 ;;=4^L97.119
 ;;^UTILITY(U,$J,358.3,102,2)
 ;;=^5009489
 ;;^UTILITY(U,$J,358.3,103,0)
 ;;=L98.499^^1^1^130
 ;;^UTILITY(U,$J,358.3,103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,103,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Skin w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,103,1,4,0)
 ;;=4^L98.499
 ;;^UTILITY(U,$J,358.3,103,2)
 ;;=^5009591
 ;;^UTILITY(U,$J,358.3,104,0)
 ;;=L97.519^^1^1^127
 ;;^UTILITY(U,$J,358.3,104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,104,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Foot w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,104,1,4,0)
 ;;=4^L97.519
 ;;^UTILITY(U,$J,358.3,104,2)
 ;;=^5009549
 ;;^UTILITY(U,$J,358.3,105,0)
 ;;=I65.22^^1^1^131
 ;;^UTILITY(U,$J,358.3,105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,105,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,105,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,105,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,106,0)
 ;;=I65.21^^1^1^132
 ;;^UTILITY(U,$J,358.3,106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,106,1,3,0)
 ;;=3^Occlusion/Stenosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,106,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,106,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,107,0)
 ;;=I67.89^^1^1^49
 ;;^UTILITY(U,$J,358.3,107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,107,1,3,0)
 ;;=3^Cerebrovascular Disease NEC
 ;;^UTILITY(U,$J,358.3,107,1,4,0)
 ;;=4^I67.89
 ;;^UTILITY(U,$J,358.3,107,2)
 ;;=^5007388
 ;;^UTILITY(U,$J,358.3,108,0)
 ;;=M86.672^^1^1^51
 ;;^UTILITY(U,$J,358.3,108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,108,1,3,0)
 ;;=3^Chronic Osteomyelitis of Left Ankle/Foot
 ;;^UTILITY(U,$J,358.3,108,1,4,0)
 ;;=4^M86.672
 ;;^UTILITY(U,$J,358.3,108,2)
 ;;=^5014642
 ;;^UTILITY(U,$J,358.3,109,0)
 ;;=M86.671^^1^1^52
