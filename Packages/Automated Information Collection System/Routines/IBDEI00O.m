IBDEI00O ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1049,1,3,0)
 ;;=3^Burn Tx,Local,1st Degree,Init Tx
 ;;^UTILITY(U,$J,358.3,1050,0)
 ;;=29075^^14^103^7^^^^1
 ;;^UTILITY(U,$J,358.3,1050,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1050,1,2,0)
 ;;=2^29075
 ;;^UTILITY(U,$J,358.3,1050,1,3,0)
 ;;=3^Splinting Arm,Elbow to Finger
 ;;^UTILITY(U,$J,358.3,1051,0)
 ;;=29085^^14^103^8^^^^1
 ;;^UTILITY(U,$J,358.3,1051,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1051,1,2,0)
 ;;=2^29085
 ;;^UTILITY(U,$J,358.3,1051,1,3,0)
 ;;=3^Splinting Arm,Hand & Lower Forearm
 ;;^UTILITY(U,$J,358.3,1052,0)
 ;;=69210^^14^103^5^^^^1
 ;;^UTILITY(U,$J,358.3,1052,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1052,1,2,0)
 ;;=2^69210
 ;;^UTILITY(U,$J,358.3,1052,1,3,0)
 ;;=3^Remove Impacted Ear Wax w/ Instruments,Unilat
 ;;^UTILITY(U,$J,358.3,1053,0)
 ;;=69209^^14^103^6^^^^1
 ;;^UTILITY(U,$J,358.3,1053,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1053,1,2,0)
 ;;=2^69209
 ;;^UTILITY(U,$J,358.3,1053,1,3,0)
 ;;=3^Remove Impacted Ear Wax w/ Lavage,Unilat
 ;;^UTILITY(U,$J,358.3,1054,0)
 ;;=J0800^^14^103^4^^^^1
 ;;^UTILITY(U,$J,358.3,1054,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1054,1,2,0)
 ;;=2^J0800
 ;;^UTILITY(U,$J,358.3,1054,1,3,0)
 ;;=3^Corticotropin,up to 40 Units
 ;;^UTILITY(U,$J,358.3,1055,0)
 ;;=J3420^^14^103^10^^^^1
 ;;^UTILITY(U,$J,358.3,1055,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1055,1,2,0)
 ;;=2^J3420
 ;;^UTILITY(U,$J,358.3,1055,1,3,0)
 ;;=3^Vit B12 Cyanocobalamin,up to 1000 mcg
 ;;^UTILITY(U,$J,358.3,1056,0)
 ;;=10120^^14^104^1^^^^1
 ;;^UTILITY(U,$J,358.3,1056,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1056,1,2,0)
 ;;=2^10120
 ;;^UTILITY(U,$J,358.3,1056,1,3,0)
 ;;=3^Remove FB,SQ Tissue,Simp
 ;;^UTILITY(U,$J,358.3,1057,0)
 ;;=10121^^14^104^2^^^^1
 ;;^UTILITY(U,$J,358.3,1057,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1057,1,2,0)
 ;;=2^10121
 ;;^UTILITY(U,$J,358.3,1057,1,3,0)
 ;;=3^Remove FB,SQ Tissue,Compl
 ;;^UTILITY(U,$J,358.3,1058,0)
 ;;=65205^^14^104^3^^^^1
 ;;^UTILITY(U,$J,358.3,1058,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1058,1,2,0)
 ;;=2^65205
 ;;^UTILITY(U,$J,358.3,1058,1,3,0)
 ;;=3^Remove FB,Conjunc,External Eye
 ;;^UTILITY(U,$J,358.3,1059,0)
 ;;=65210^^14^104^4^^^^1
 ;;^UTILITY(U,$J,358.3,1059,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1059,1,2,0)
 ;;=2^65210
 ;;^UTILITY(U,$J,358.3,1059,1,3,0)
 ;;=3^Remove FB,Conjunc,Embed,External Eye
 ;;^UTILITY(U,$J,358.3,1060,0)
 ;;=65220^^14^104^5^^^^1
 ;;^UTILITY(U,$J,358.3,1060,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1060,1,2,0)
 ;;=2^65220
 ;;^UTILITY(U,$J,358.3,1060,1,3,0)
 ;;=3^Remove FB,Cornea w/o Slit Lamp
 ;;^UTILITY(U,$J,358.3,1061,0)
 ;;=65222^^14^104^6^^^^1
 ;;^UTILITY(U,$J,358.3,1061,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1061,1,2,0)
 ;;=2^65222
 ;;^UTILITY(U,$J,358.3,1061,1,3,0)
 ;;=3^Remove FB,Cornea,w/Slit Lamp
 ;;^UTILITY(U,$J,358.3,1062,0)
 ;;=99395^^14^105^1^^^^1
 ;;^UTILITY(U,$J,358.3,1062,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1062,1,2,0)
 ;;=2^99395
 ;;^UTILITY(U,$J,358.3,1062,1,3,0)
 ;;=3^Preventive Med-Est Pt 18-39
 ;;^UTILITY(U,$J,358.3,1063,0)
 ;;=99396^^14^105^2^^^^1
 ;;^UTILITY(U,$J,358.3,1063,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1063,1,2,0)
 ;;=2^99396
 ;;^UTILITY(U,$J,358.3,1063,1,3,0)
 ;;=3^Preventive Med-Est Pt 40-64
 ;;^UTILITY(U,$J,358.3,1064,0)
 ;;=99397^^14^105^3^^^^1
 ;;^UTILITY(U,$J,358.3,1064,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1064,1,2,0)
 ;;=2^99397
 ;;^UTILITY(U,$J,358.3,1064,1,3,0)
 ;;=3^Preventive Med-Est Pt > 64
 ;;^UTILITY(U,$J,358.3,1065,0)
 ;;=99385^^14^106^1^^^^1
 ;;^UTILITY(U,$J,358.3,1065,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1065,1,2,0)
 ;;=2^99385
 ;;^UTILITY(U,$J,358.3,1065,1,3,0)
 ;;=3^Preventive Med-New Pt 18-39
 ;;^UTILITY(U,$J,358.3,1066,0)
 ;;=99386^^14^106^2^^^^1
 ;;^UTILITY(U,$J,358.3,1066,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1066,1,2,0)
 ;;=2^99386
 ;;^UTILITY(U,$J,358.3,1066,1,3,0)
 ;;=3^Preventive Med-New Pt 40-64
 ;;^UTILITY(U,$J,358.3,1067,0)
 ;;=99387^^14^106^3^^^^1
 ;;^UTILITY(U,$J,358.3,1067,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1067,1,2,0)
 ;;=2^99387
 ;;^UTILITY(U,$J,358.3,1067,1,3,0)
 ;;=3^Preventive Med-New Pt > 64
 ;;^UTILITY(U,$J,358.3,1068,0)
 ;;=3510F^^14^107^10^^^^1
 ;;^UTILITY(U,$J,358.3,1068,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1068,1,2,0)
 ;;=2^3510F
 ;;^UTILITY(U,$J,358.3,1068,1,3,0)
 ;;=3^TB Screening/Results Interpd
 ;;^UTILITY(U,$J,358.3,1069,0)
 ;;=92283^^14^107^4^^^^1
 ;;^UTILITY(U,$J,358.3,1069,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1069,1,2,0)
 ;;=2^92283
 ;;^UTILITY(U,$J,358.3,1069,1,3,0)
 ;;=3^Color Vision Exam
 ;;^UTILITY(U,$J,358.3,1070,0)
 ;;=93000^^14^107^5^^^^1
 ;;^UTILITY(U,$J,358.3,1070,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1070,1,2,0)
 ;;=2^93000
 ;;^UTILITY(U,$J,358.3,1070,1,3,0)
 ;;=3^EKG,Complete
 ;;^UTILITY(U,$J,358.3,1071,0)
 ;;=93005^^14^107^6^^^^1
 ;;^UTILITY(U,$J,358.3,1071,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1071,1,2,0)
 ;;=2^93005
 ;;^UTILITY(U,$J,358.3,1071,1,3,0)
 ;;=3^EKG,Tracing Only
 ;;^UTILITY(U,$J,358.3,1072,0)
 ;;=82948^^14^107^7^^^^1
 ;;^UTILITY(U,$J,358.3,1072,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1072,1,2,0)
 ;;=2^82948
 ;;^UTILITY(U,$J,358.3,1072,1,3,0)
 ;;=3^Fingerstick,Glucose
 ;;^UTILITY(U,$J,358.3,1073,0)
 ;;=82075^^14^107^1^^^^1
 ;;^UTILITY(U,$J,358.3,1073,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1073,1,2,0)
 ;;=2^82075
 ;;^UTILITY(U,$J,358.3,1073,1,3,0)
 ;;=3^Alcohol,Breathalyzer
 ;;^UTILITY(U,$J,358.3,1074,0)
 ;;=94150^^14^107^8^^^^1
 ;;^UTILITY(U,$J,358.3,1074,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1074,1,2,0)
 ;;=2^94150
 ;;^UTILITY(U,$J,358.3,1074,1,3,0)
 ;;=3^PFT Test
 ;;^UTILITY(U,$J,358.3,1075,0)
 ;;=94760^^14^107^9^^^^1
 ;;^UTILITY(U,$J,358.3,1075,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1075,1,2,0)
 ;;=2^94760
 ;;^UTILITY(U,$J,358.3,1075,1,3,0)
 ;;=3^Pulse Oximetry
 ;;^UTILITY(U,$J,358.3,1076,0)
 ;;=36600^^14^107^2^^^^1
 ;;^UTILITY(U,$J,358.3,1076,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1076,1,2,0)
 ;;=2^36600
 ;;^UTILITY(U,$J,358.3,1076,1,3,0)
 ;;=3^Arterial Puncture
 ;;^UTILITY(U,$J,358.3,1077,0)
 ;;=36415^^14^107^11^^^^1
 ;;^UTILITY(U,$J,358.3,1077,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1077,1,2,0)
 ;;=2^36415
 ;;^UTILITY(U,$J,358.3,1077,1,3,0)
 ;;=3^Venipuncture
 ;;^UTILITY(U,$J,358.3,1078,0)
 ;;=93770^^14^107^3^^^^1
 ;;^UTILITY(U,$J,358.3,1078,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1078,1,2,0)
 ;;=2^93770
 ;;^UTILITY(U,$J,358.3,1078,1,3,0)
 ;;=3^BP/Venous Pressure
 ;;^UTILITY(U,$J,358.3,1079,0)
 ;;=99415^^14^108^1^^^^1
 ;;^UTILITY(U,$J,358.3,1079,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1079,1,2,0)
 ;;=2^99415
 ;;^UTILITY(U,$J,358.3,1079,1,3,0)
 ;;=3^Prolong Clin Staff Svc,1st hr
 ;;^UTILITY(U,$J,358.3,1080,0)
 ;;=99416^^14^108^2^^^^1
 ;;^UTILITY(U,$J,358.3,1080,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1080,1,2,0)
 ;;=2^99416
 ;;^UTILITY(U,$J,358.3,1080,1,3,0)
 ;;=3^Prolong Clin Staff Svc,Ea Addl 30min
 ;;^UTILITY(U,$J,358.3,1081,0)
 ;;=90471^^14^109^1^^^^1
 ;;^UTILITY(U,$J,358.3,1081,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1081,1,2,0)
 ;;=2^90471
 ;;^UTILITY(U,$J,358.3,1081,1,3,0)
 ;;=3^Immunization Admin
 ;;^UTILITY(U,$J,358.3,1082,0)
 ;;=90472^^14^109^2^^^^1
 ;;^UTILITY(U,$J,358.3,1082,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1082,1,2,0)
 ;;=2^90472
 ;;^UTILITY(U,$J,358.3,1082,1,3,0)
 ;;=3^Immunization Admin,Ea Addl
 ;;^UTILITY(U,$J,358.3,1083,0)
 ;;=S90.511A^^15^110^16
 ;;^UTILITY(U,$J,358.3,1083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1083,1,3,0)
 ;;=3^Abrasion,Right ankle, initial encounter
 ;;^UTILITY(U,$J,358.3,1083,1,4,0)
 ;;=4^S90.511A
 ;;^UTILITY(U,$J,358.3,1083,2)
 ;;=^5043997
 ;;^UTILITY(U,$J,358.3,1084,0)
 ;;=S90.512A^^15^110^1
 ;;^UTILITY(U,$J,358.3,1084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1084,1,3,0)
 ;;=3^Abrasion,Left ankle, initial encounter
 ;;^UTILITY(U,$J,358.3,1084,1,4,0)
 ;;=4^S90.512A
 ;;^UTILITY(U,$J,358.3,1084,2)
 ;;=^5044000
 ;;^UTILITY(U,$J,358.3,1085,0)
 ;;=S40.811A^^15^110^28
 ;;^UTILITY(U,$J,358.3,1085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1085,1,3,0)
 ;;=3^Abrasion,Right upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,1085,1,4,0)
 ;;=4^S40.811A
 ;;^UTILITY(U,$J,358.3,1085,2)
 ;;=^5026225
 ;;^UTILITY(U,$J,358.3,1086,0)
 ;;=S40.812A^^15^110^13
 ;;^UTILITY(U,$J,358.3,1086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1086,1,3,0)
 ;;=3^Abrasion,Left upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,1086,1,4,0)
 ;;=4^S40.812A
 ;;^UTILITY(U,$J,358.3,1086,2)
 ;;=^5026228
 ;;^UTILITY(U,$J,358.3,1087,0)
 ;;=S05.01XA^^15^110^46
 ;;^UTILITY(U,$J,358.3,1087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1087,1,3,0)
 ;;=3^Conjunctiva/Corneal Abrasion w/o FB,Right Eye,Init Enctr
 ;;^UTILITY(U,$J,358.3,1087,1,4,0)
 ;;=4^S05.01XA
 ;;^UTILITY(U,$J,358.3,1087,2)
 ;;=^5020579
 ;;^UTILITY(U,$J,358.3,1088,0)
 ;;=S05.02XA^^15^110^45
 ;;^UTILITY(U,$J,358.3,1088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1088,1,3,0)
 ;;=3^Conjuctiva/Corneal Abrasion w/o FB,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,1088,1,4,0)
 ;;=4^S05.02XA
 ;;^UTILITY(U,$J,358.3,1088,2)
 ;;=^5020582
 ;;^UTILITY(U,$J,358.3,1089,0)
 ;;=S50.311A^^15^110^17
 ;;^UTILITY(U,$J,358.3,1089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1089,1,3,0)
 ;;=3^Abrasion,Right elbow, initial encounter
 ;;^UTILITY(U,$J,358.3,1089,1,4,0)
 ;;=4^S50.311A
 ;;^UTILITY(U,$J,358.3,1089,2)
 ;;=^5028500
 ;;^UTILITY(U,$J,358.3,1090,0)
 ;;=S50.312A^^15^110^2
 ;;^UTILITY(U,$J,358.3,1090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1090,1,3,0)
 ;;=3^Abrasion,Left elbow, initial encounter
 ;;^UTILITY(U,$J,358.3,1090,1,4,0)
 ;;=4^S50.312A
 ;;^UTILITY(U,$J,358.3,1090,2)
 ;;=^5028503
 ;;^UTILITY(U,$J,358.3,1091,0)
 ;;=S00.81XA^^15^110^15
 ;;^UTILITY(U,$J,358.3,1091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1091,1,3,0)
 ;;=3^Abrasion,Other part of head, initial encounter
 ;;^UTILITY(U,$J,358.3,1091,1,4,0)
 ;;=4^S00.81XA
 ;;^UTILITY(U,$J,358.3,1091,2)
 ;;=^5019988
 ;;^UTILITY(U,$J,358.3,1092,0)
 ;;=S90.811A^^15^110^18
 ;;^UTILITY(U,$J,358.3,1092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1092,1,3,0)
 ;;=3^Abrasion,Right foot, initial encounter
 ;;^UTILITY(U,$J,358.3,1092,1,4,0)
 ;;=4^S90.811A
 ;;^UTILITY(U,$J,358.3,1092,2)
 ;;=^5044051
 ;;^UTILITY(U,$J,358.3,1093,0)
 ;;=S90.812A^^15^110^3
 ;;^UTILITY(U,$J,358.3,1093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1093,1,3,0)
 ;;=3^Abrasion,Left foot, initial encounter
 ;;^UTILITY(U,$J,358.3,1093,1,4,0)
 ;;=4^S90.812A
 ;;^UTILITY(U,$J,358.3,1093,2)
 ;;=^5044054
 ;;^UTILITY(U,$J,358.3,1094,0)
 ;;=S90.411A^^15^110^20
 ;;^UTILITY(U,$J,358.3,1094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1094,1,3,0)
 ;;=3^Abrasion,Right great toe, initial encounter
 ;;^UTILITY(U,$J,358.3,1094,1,4,0)
 ;;=4^S90.411A
 ;;^UTILITY(U,$J,358.3,1094,2)
 ;;=^5043889
 ;;^UTILITY(U,$J,358.3,1095,0)
 ;;=S90.412A^^15^110^5
 ;;^UTILITY(U,$J,358.3,1095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1095,1,3,0)
 ;;=3^Abrasion,Left great toe, initial encounter
 ;;^UTILITY(U,$J,358.3,1095,1,4,0)
 ;;=4^S90.412A
 ;;^UTILITY(U,$J,358.3,1095,2)
 ;;=^5043892
 ;;^UTILITY(U,$J,358.3,1096,0)
 ;;=S90.414A^^15^110^23
 ;;^UTILITY(U,$J,358.3,1096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1096,1,3,0)
 ;;=3^Abrasion,Right lesser toe(s), initial encounter
 ;;^UTILITY(U,$J,358.3,1096,1,4,0)
 ;;=4^S90.414A
 ;;^UTILITY(U,$J,358.3,1096,2)
 ;;=^5043898
 ;;^UTILITY(U,$J,358.3,1097,0)
 ;;=S90.415A^^15^110^8
 ;;^UTILITY(U,$J,358.3,1097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1097,1,3,0)
 ;;=3^Abrasion,Left lesser toe(s), initial encounter
 ;;^UTILITY(U,$J,358.3,1097,1,4,0)
 ;;=4^S90.415A
 ;;^UTILITY(U,$J,358.3,1097,2)
 ;;=^5043901
 ;;^UTILITY(U,$J,358.3,1098,0)
 ;;=S50.811A^^15^110^19
 ;;^UTILITY(U,$J,358.3,1098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1098,1,3,0)
 ;;=3^Abrasion,Right forearm, initial encounter
 ;;^UTILITY(U,$J,358.3,1098,1,4,0)
 ;;=4^S50.811A
 ;;^UTILITY(U,$J,358.3,1098,2)
 ;;=^5028554
 ;;^UTILITY(U,$J,358.3,1099,0)
 ;;=S50.812A^^15^110^4
 ;;^UTILITY(U,$J,358.3,1099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1099,1,3,0)
 ;;=3^Abrasion,Left forearm, initial encounter
 ;;^UTILITY(U,$J,358.3,1099,1,4,0)
 ;;=4^S50.812A
 ;;^UTILITY(U,$J,358.3,1099,2)
 ;;=^5028557
 ;;^UTILITY(U,$J,358.3,1100,0)
 ;;=S60.511A^^15^110^21
 ;;^UTILITY(U,$J,358.3,1100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1100,1,3,0)
 ;;=3^Abrasion,Right hand, initial encounter
 ;;^UTILITY(U,$J,358.3,1100,1,4,0)
 ;;=4^S60.511A
 ;;^UTILITY(U,$J,358.3,1100,2)
 ;;=^5032528
 ;;^UTILITY(U,$J,358.3,1101,0)
 ;;=S60.512A^^15^110^6
 ;;^UTILITY(U,$J,358.3,1101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1101,1,3,0)
 ;;=3^Abrasion,Left hand, initial encounter
 ;;^UTILITY(U,$J,358.3,1101,1,4,0)
 ;;=4^S60.512A
 ;;^UTILITY(U,$J,358.3,1101,2)
 ;;=^5032531
 ;;^UTILITY(U,$J,358.3,1102,0)
 ;;=S80.211A^^15^110^22
 ;;^UTILITY(U,$J,358.3,1102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1102,1,3,0)
 ;;=3^Abrasion,Right knee, initial encounter
 ;;^UTILITY(U,$J,358.3,1102,1,4,0)
 ;;=4^S80.211A
 ;;^UTILITY(U,$J,358.3,1102,2)
 ;;=^5039906
 ;;^UTILITY(U,$J,358.3,1103,0)
 ;;=S80.212A^^15^110^7
 ;;^UTILITY(U,$J,358.3,1103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1103,1,3,0)
 ;;=3^Abrasion,Left knee, initial encounter
 ;;^UTILITY(U,$J,358.3,1103,1,4,0)
 ;;=4^S80.212A
 ;;^UTILITY(U,$J,358.3,1103,2)
 ;;=^5039909
 ;;^UTILITY(U,$J,358.3,1104,0)
 ;;=S80.811A^^15^110^24
 ;;^UTILITY(U,$J,358.3,1104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1104,1,3,0)
 ;;=3^Abrasion,Right lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,1104,1,4,0)
 ;;=4^S80.811A
 ;;^UTILITY(U,$J,358.3,1104,2)
 ;;=^5039960
 ;;^UTILITY(U,$J,358.3,1105,0)
 ;;=S80.812A^^15^110^9
 ;;^UTILITY(U,$J,358.3,1105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1105,1,3,0)
 ;;=3^Abrasion,Left lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,1105,1,4,0)
 ;;=4^S80.812A
 ;;^UTILITY(U,$J,358.3,1105,2)
 ;;=^5039963
 ;;^UTILITY(U,$J,358.3,1106,0)
 ;;=S40.211A^^15^110^25
 ;;^UTILITY(U,$J,358.3,1106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1106,1,3,0)
 ;;=3^Abrasion,Right shoulder, initial encounter
 ;;^UTILITY(U,$J,358.3,1106,1,4,0)
 ;;=4^S40.211A
 ;;^UTILITY(U,$J,358.3,1106,2)
 ;;=^5026171
 ;;^UTILITY(U,$J,358.3,1107,0)
 ;;=S40.212A^^15^110^10
 ;;^UTILITY(U,$J,358.3,1107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1107,1,3,0)
 ;;=3^Abrasion,Left shoulder, initial encounter
 ;;^UTILITY(U,$J,358.3,1107,1,4,0)
 ;;=4^S40.212A
 ;;^UTILITY(U,$J,358.3,1107,2)
 ;;=^5026174
 ;;^UTILITY(U,$J,358.3,1108,0)
 ;;=S70.311A^^15^110^26
 ;;^UTILITY(U,$J,358.3,1108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1108,1,3,0)
 ;;=3^Abrasion,Right thigh, initial encounter
 ;;^UTILITY(U,$J,358.3,1108,1,4,0)
 ;;=4^S70.311A
 ;;^UTILITY(U,$J,358.3,1108,2)
 ;;=^5036903
 ;;^UTILITY(U,$J,358.3,1109,0)
 ;;=S70.312A^^15^110^11
 ;;^UTILITY(U,$J,358.3,1109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1109,1,3,0)
 ;;=3^Abrasion,Left thigh, initial encounter
 ;;^UTILITY(U,$J,358.3,1109,1,4,0)
 ;;=4^S70.312A
 ;;^UTILITY(U,$J,358.3,1109,2)
 ;;=^5036906
 ;;^UTILITY(U,$J,358.3,1110,0)
 ;;=S60.311A^^15^110^27
 ;;^UTILITY(U,$J,358.3,1110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1110,1,3,0)
 ;;=3^Abrasion,Right thumb, initial encounter
 ;;^UTILITY(U,$J,358.3,1110,1,4,0)
 ;;=4^S60.311A
 ;;^UTILITY(U,$J,358.3,1110,2)
 ;;=^5032285
 ;;^UTILITY(U,$J,358.3,1111,0)
 ;;=S60.312A^^15^110^12
 ;;^UTILITY(U,$J,358.3,1111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1111,1,3,0)
 ;;=3^Abrasion,Left thumb, initial encounter
 ;;^UTILITY(U,$J,358.3,1111,1,4,0)
 ;;=4^S60.312A
 ;;^UTILITY(U,$J,358.3,1111,2)
 ;;=^5032288
 ;;^UTILITY(U,$J,358.3,1112,0)
 ;;=S60.811A^^15^110^29
 ;;^UTILITY(U,$J,358.3,1112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1112,1,3,0)
 ;;=3^Abrasion,Right wrist, initial encounter
 ;;^UTILITY(U,$J,358.3,1112,1,4,0)
 ;;=4^S60.811A
 ;;^UTILITY(U,$J,358.3,1112,2)
 ;;=^5032582
 ;;^UTILITY(U,$J,358.3,1113,0)
 ;;=S60.812A^^15^110^14
 ;;^UTILITY(U,$J,358.3,1113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1113,1,3,0)
 ;;=3^Abrasion,Left wrist, initial encounter
 ;;^UTILITY(U,$J,358.3,1113,1,4,0)
 ;;=4^S60.812A
 ;;^UTILITY(U,$J,358.3,1113,2)
 ;;=^5032585
 ;;^UTILITY(U,$J,358.3,1114,0)
 ;;=T78.3XXA^^15^110^30
 ;;^UTILITY(U,$J,358.3,1114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1114,1,3,0)
 ;;=3^Angioneurotic edema, initial encounter
 ;;^UTILITY(U,$J,358.3,1114,1,4,0)
 ;;=4^T78.3XXA
 ;;^UTILITY(U,$J,358.3,1114,2)
 ;;=^5054281
 ;;^UTILITY(U,$J,358.3,1115,0)
 ;;=T63.441A^^15^110^246
 ;;^UTILITY(U,$J,358.3,1115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1115,1,3,0)
 ;;=3^Toxic effect of venom of bees, accidental, init
 ;;^UTILITY(U,$J,358.3,1115,1,4,0)
 ;;=4^T63.441A
 ;;^UTILITY(U,$J,358.3,1115,2)
 ;;=^5053522
 ;;^UTILITY(U,$J,358.3,1116,0)
 ;;=S91.051A^^15^110^147
 ;;^UTILITY(U,$J,358.3,1116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1116,1,3,0)
 ;;=3^Open bite, right ankle, initial encounter
 ;;^UTILITY(U,$J,358.3,1116,1,4,0)
 ;;=4^S91.051A
 ;;^UTILITY(U,$J,358.3,1116,2)
 ;;=^5044159
 ;;^UTILITY(U,$J,358.3,1117,0)
 ;;=S91.052A^^15^110^139
 ;;^UTILITY(U,$J,358.3,1117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1117,1,3,0)
 ;;=3^Open bite, left ankle, initial encounter
 ;;^UTILITY(U,$J,358.3,1117,1,4,0)
 ;;=4^S91.052A
 ;;^UTILITY(U,$J,358.3,1117,2)
 ;;=^5044162
 ;;^UTILITY(U,$J,358.3,1118,0)
 ;;=S41.151A^^15^110^154
 ;;^UTILITY(U,$J,358.3,1118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1118,1,3,0)
 ;;=3^Open bite, right upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,1118,1,4,0)
 ;;=4^S41.151A
 ;;^UTILITY(U,$J,358.3,1118,2)
 ;;=^5026360
 ;;^UTILITY(U,$J,358.3,1119,0)
 ;;=S41.152A^^15^110^146
 ;;^UTILITY(U,$J,358.3,1119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1119,1,3,0)
 ;;=3^Open bite, left upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,1119,1,4,0)
 ;;=4^S41.152A
 ;;^UTILITY(U,$J,358.3,1119,2)
 ;;=^5026363
 ;;^UTILITY(U,$J,358.3,1120,0)
 ;;=S51.851A^^15^110^149
 ;;^UTILITY(U,$J,358.3,1120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1120,1,3,0)
 ;;=3^Open bite, right forearm, initial encounter
 ;;^UTILITY(U,$J,358.3,1120,1,4,0)
 ;;=4^S51.851A
 ;;^UTILITY(U,$J,358.3,1120,2)
 ;;=^5028689
 ;;^UTILITY(U,$J,358.3,1121,0)
 ;;=S51.852A^^15^110^141
 ;;^UTILITY(U,$J,358.3,1121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1121,1,3,0)
 ;;=3^Open bite, left forearm, initial encounter
 ;;^UTILITY(U,$J,358.3,1121,1,4,0)
 ;;=4^S51.852A
 ;;^UTILITY(U,$J,358.3,1121,2)
 ;;=^5028692
 ;;^UTILITY(U,$J,358.3,1122,0)
 ;;=S40.861A^^15^110^111
 ;;^UTILITY(U,$J,358.3,1122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1122,1,3,0)
 ;;=3^Insect bite (nonvenomous) of right upper arm, init encntr
 ;;^UTILITY(U,$J,358.3,1122,1,4,0)
 ;;=4^S40.861A
 ;;^UTILITY(U,$J,358.3,1122,2)
 ;;=^5026261
 ;;^UTILITY(U,$J,358.3,1123,0)
 ;;=S40.862A^^15^110^109
 ;;^UTILITY(U,$J,358.3,1123,1,0)
 ;;=^358.31IA^4^2
