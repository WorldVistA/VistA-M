IBDEI00P ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1123,1,3,0)
 ;;=3^Insect bite (nonvenomous) of left upper arm, init encntr
 ;;^UTILITY(U,$J,358.3,1123,1,4,0)
 ;;=4^S40.862A
 ;;^UTILITY(U,$J,358.3,1123,2)
 ;;=^5026264
 ;;^UTILITY(U,$J,358.3,1124,0)
 ;;=S50.861A^^15^110^110
 ;;^UTILITY(U,$J,358.3,1124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1124,1,3,0)
 ;;=3^Insect bite (nonvenomous) of right forearm, init encntr
 ;;^UTILITY(U,$J,358.3,1124,1,4,0)
 ;;=4^S50.861A
 ;;^UTILITY(U,$J,358.3,1124,2)
 ;;=^5028590
 ;;^UTILITY(U,$J,358.3,1125,0)
 ;;=S50.862A^^15^110^108
 ;;^UTILITY(U,$J,358.3,1125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1125,1,3,0)
 ;;=3^Insect bite (nonvenomous) of left forearm, initial encounter
 ;;^UTILITY(U,$J,358.3,1125,1,4,0)
 ;;=4^S50.862A
 ;;^UTILITY(U,$J,358.3,1125,2)
 ;;=^5028593
 ;;^UTILITY(U,$J,358.3,1126,0)
 ;;=S91.351A^^15^110^148
 ;;^UTILITY(U,$J,358.3,1126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1126,1,3,0)
 ;;=3^Open bite, right foot, initial encounter
 ;;^UTILITY(U,$J,358.3,1126,1,4,0)
 ;;=4^S91.351A
 ;;^UTILITY(U,$J,358.3,1126,2)
 ;;=^5044344
 ;;^UTILITY(U,$J,358.3,1127,0)
 ;;=S91.352A^^15^110^140
 ;;^UTILITY(U,$J,358.3,1127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1127,1,3,0)
 ;;=3^Open bite, left foot, initial encounter
 ;;^UTILITY(U,$J,358.3,1127,1,4,0)
 ;;=4^S91.352A
 ;;^UTILITY(U,$J,358.3,1127,2)
 ;;=^5044347
 ;;^UTILITY(U,$J,358.3,1128,0)
 ;;=S61.451A^^15^110^151
 ;;^UTILITY(U,$J,358.3,1128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1128,1,3,0)
 ;;=3^Open bite, right hand, initial encounter
 ;;^UTILITY(U,$J,358.3,1128,1,4,0)
 ;;=4^S61.451A
 ;;^UTILITY(U,$J,358.3,1128,2)
 ;;=^5033011
 ;;^UTILITY(U,$J,358.3,1129,0)
 ;;=S61.452A^^15^110^143
 ;;^UTILITY(U,$J,358.3,1129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1129,1,3,0)
 ;;=3^Open bite, left hand, initial encounter
 ;;^UTILITY(U,$J,358.3,1129,1,4,0)
 ;;=4^S61.452A
 ;;^UTILITY(U,$J,358.3,1129,2)
 ;;=^5033014
 ;;^UTILITY(U,$J,358.3,1130,0)
 ;;=S81.851A^^15^110^153
 ;;^UTILITY(U,$J,358.3,1130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1130,1,3,0)
 ;;=3^Open bite, right lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,1130,1,4,0)
 ;;=4^S81.851A
 ;;^UTILITY(U,$J,358.3,1130,2)
 ;;=^5040095
 ;;^UTILITY(U,$J,358.3,1131,0)
 ;;=S81.852A^^15^110^145
 ;;^UTILITY(U,$J,358.3,1131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1131,1,3,0)
 ;;=3^Open bite, left lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,1131,1,4,0)
 ;;=4^S81.852A
 ;;^UTILITY(U,$J,358.3,1131,2)
 ;;=^5040098
 ;;^UTILITY(U,$J,358.3,1132,0)
 ;;=S91.151A^^15^110^150
 ;;^UTILITY(U,$J,358.3,1132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1132,1,3,0)
 ;;=3^Open bite, right great toe w/o damage to nail, init encntr
 ;;^UTILITY(U,$J,358.3,1132,1,4,0)
 ;;=4^S91.151A
 ;;^UTILITY(U,$J,358.3,1132,2)
 ;;=^5044243
 ;;^UTILITY(U,$J,358.3,1133,0)
 ;;=S91.152A^^15^110^142
 ;;^UTILITY(U,$J,358.3,1133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1133,1,3,0)
 ;;=3^Open bite, left great toe w/o damage to nail, init encntr
 ;;^UTILITY(U,$J,358.3,1133,1,4,0)
 ;;=4^S91.152A
 ;;^UTILITY(U,$J,358.3,1133,2)
 ;;=^5044246
 ;;^UTILITY(U,$J,358.3,1134,0)
 ;;=S91.154A^^15^110^152
 ;;^UTILITY(U,$J,358.3,1134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1134,1,3,0)
 ;;=3^Open bite, right lesser toe(s) w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1134,1,4,0)
 ;;=4^S91.154A
 ;;^UTILITY(U,$J,358.3,1134,2)
 ;;=^5044252
 ;;^UTILITY(U,$J,358.3,1135,0)
 ;;=S91.155A^^15^110^144
 ;;^UTILITY(U,$J,358.3,1135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1135,1,3,0)
 ;;=3^Open bite, left lesser toe(s) w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1135,1,4,0)
 ;;=4^S91.155A
 ;;^UTILITY(U,$J,358.3,1135,2)
 ;;=^5044255
 ;;^UTILITY(U,$J,358.3,1136,0)
 ;;=S90.425A^^15^110^31
 ;;^UTILITY(U,$J,358.3,1136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1136,1,3,0)
 ;;=3^Blister (nonthermal), left lesser toe(s), initial encounter
 ;;^UTILITY(U,$J,358.3,1136,1,4,0)
 ;;=4^S90.425A
 ;;^UTILITY(U,$J,358.3,1136,2)
 ;;=^5043919
 ;;^UTILITY(U,$J,358.3,1137,0)
 ;;=T23.121A^^15^110^35
 ;;^UTILITY(U,$J,358.3,1137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1137,1,3,0)
 ;;=3^Burn first degree of single r finger except thumb, init
 ;;^UTILITY(U,$J,358.3,1137,1,4,0)
 ;;=4^T23.121A
 ;;^UTILITY(U,$J,358.3,1137,2)
 ;;=^5047671
 ;;^UTILITY(U,$J,358.3,1138,0)
 ;;=T23.122A^^15^110^34
 ;;^UTILITY(U,$J,358.3,1138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1138,1,3,0)
 ;;=3^Burn first degree of single l finger except thumb, init
 ;;^UTILITY(U,$J,358.3,1138,1,4,0)
 ;;=4^T23.122A
 ;;^UTILITY(U,$J,358.3,1138,2)
 ;;=^5047674
 ;;^UTILITY(U,$J,358.3,1139,0)
 ;;=T23.221A^^15^110^39
 ;;^UTILITY(U,$J,358.3,1139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1139,1,3,0)
 ;;=3^Burn second degree of single r finger except thumb, init
 ;;^UTILITY(U,$J,358.3,1139,1,4,0)
 ;;=4^T23.221A
 ;;^UTILITY(U,$J,358.3,1139,2)
 ;;=^5047749
 ;;^UTILITY(U,$J,358.3,1140,0)
 ;;=T23.222A^^15^110^38
 ;;^UTILITY(U,$J,358.3,1140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1140,1,3,0)
 ;;=3^Burn second degree of single l finger except thumb, init
 ;;^UTILITY(U,$J,358.3,1140,1,4,0)
 ;;=4^T23.222A
 ;;^UTILITY(U,$J,358.3,1140,2)
 ;;=^5047752
 ;;^UTILITY(U,$J,358.3,1141,0)
 ;;=T23.321A^^15^110^43
 ;;^UTILITY(U,$J,358.3,1141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1141,1,3,0)
 ;;=3^Burn third degree of single r finger except thumb, init
 ;;^UTILITY(U,$J,358.3,1141,1,4,0)
 ;;=4^T23.321A
 ;;^UTILITY(U,$J,358.3,1141,2)
 ;;=^5047827
 ;;^UTILITY(U,$J,358.3,1142,0)
 ;;=T23.322A^^15^110^42
 ;;^UTILITY(U,$J,358.3,1142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1142,1,3,0)
 ;;=3^Burn third degree of single l finger except thumb, init
 ;;^UTILITY(U,$J,358.3,1142,1,4,0)
 ;;=4^T23.322A
 ;;^UTILITY(U,$J,358.3,1142,2)
 ;;=^5047830
 ;;^UTILITY(U,$J,358.3,1143,0)
 ;;=T23.101A^^15^110^33
 ;;^UTILITY(U,$J,358.3,1143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1143,1,3,0)
 ;;=3^Burn first degree of right hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,1143,1,4,0)
 ;;=4^T23.101A
 ;;^UTILITY(U,$J,358.3,1143,2)
 ;;=^5047656
 ;;^UTILITY(U,$J,358.3,1144,0)
 ;;=T23.102A^^15^110^32
 ;;^UTILITY(U,$J,358.3,1144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1144,1,3,0)
 ;;=3^Burn first degree of left hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,1144,1,4,0)
 ;;=4^T23.102A
 ;;^UTILITY(U,$J,358.3,1144,2)
 ;;=^5047659
 ;;^UTILITY(U,$J,358.3,1145,0)
 ;;=T23.201A^^15^110^37
 ;;^UTILITY(U,$J,358.3,1145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1145,1,3,0)
 ;;=3^Burn second degree of right hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,1145,1,4,0)
 ;;=4^T23.201A
 ;;^UTILITY(U,$J,358.3,1145,2)
 ;;=^5047734
 ;;^UTILITY(U,$J,358.3,1146,0)
 ;;=T23.202A^^15^110^36
 ;;^UTILITY(U,$J,358.3,1146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1146,1,3,0)
 ;;=3^Burn second degree of left hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,1146,1,4,0)
 ;;=4^T23.202A
 ;;^UTILITY(U,$J,358.3,1146,2)
 ;;=^5047737
 ;;^UTILITY(U,$J,358.3,1147,0)
 ;;=T23.301A^^15^110^41
 ;;^UTILITY(U,$J,358.3,1147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1147,1,3,0)
 ;;=3^Burn third degree of right hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,1147,1,4,0)
 ;;=4^T23.301A
 ;;^UTILITY(U,$J,358.3,1147,2)
 ;;=^5047812
 ;;^UTILITY(U,$J,358.3,1148,0)
 ;;=T23.302A^^15^110^40
 ;;^UTILITY(U,$J,358.3,1148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1148,1,3,0)
 ;;=3^Burn third degree of left hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,1148,1,4,0)
 ;;=4^T23.302A
 ;;^UTILITY(U,$J,358.3,1148,2)
 ;;=^5047815
 ;;^UTILITY(U,$J,358.3,1149,0)
 ;;=T79.A11A^^15^110^248
 ;;^UTILITY(U,$J,358.3,1149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1149,1,3,0)
 ;;=3^Traumatic compartment syndrome of right upper extrem, init
 ;;^UTILITY(U,$J,358.3,1149,1,4,0)
 ;;=4^T79.A11A
 ;;^UTILITY(U,$J,358.3,1149,2)
 ;;=^5054326
 ;;^UTILITY(U,$J,358.3,1150,0)
 ;;=T79.A12A^^15^110^247
 ;;^UTILITY(U,$J,358.3,1150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1150,1,3,0)
 ;;=3^Traumatic compartment syndrome of left upper extremity, init
 ;;^UTILITY(U,$J,358.3,1150,1,4,0)
 ;;=4^T79.A12A
 ;;^UTILITY(U,$J,358.3,1150,2)
 ;;=^5054329
 ;;^UTILITY(U,$J,358.3,1151,0)
 ;;=S06.0X9A^^15^110^44
 ;;^UTILITY(U,$J,358.3,1151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1151,1,3,0)
 ;;=3^Concussion w loss of consciousness of unsp duration, init
 ;;^UTILITY(U,$J,358.3,1151,1,4,0)
 ;;=4^S06.0X9A
 ;;^UTILITY(U,$J,358.3,1151,2)
 ;;=^5020693
 ;;^UTILITY(U,$J,358.3,1152,0)
 ;;=S60.152A^^15^110^50
 ;;^UTILITY(U,$J,358.3,1152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1152,1,3,0)
 ;;=3^Contusion of left little finger w damage to nail, init
 ;;^UTILITY(U,$J,358.3,1152,1,4,0)
 ;;=4^S60.152A
 ;;^UTILITY(U,$J,358.3,1152,2)
 ;;=^5135669
 ;;^UTILITY(U,$J,358.3,1153,0)
 ;;=S50.11XA^^15^110^52
 ;;^UTILITY(U,$J,358.3,1153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1153,1,3,0)
 ;;=3^Contusion of right forearm, initial encounter
 ;;^UTILITY(U,$J,358.3,1153,1,4,0)
 ;;=4^S50.11XA
 ;;^UTILITY(U,$J,358.3,1153,2)
 ;;=^5028494
 ;;^UTILITY(U,$J,358.3,1154,0)
 ;;=S50.12XA^^15^110^47
 ;;^UTILITY(U,$J,358.3,1154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1154,1,3,0)
 ;;=3^Contusion of left forearm, initial encounter
 ;;^UTILITY(U,$J,358.3,1154,1,4,0)
 ;;=4^S50.12XA
 ;;^UTILITY(U,$J,358.3,1154,2)
 ;;=^5028497
 ;;^UTILITY(U,$J,358.3,1155,0)
 ;;=S60.221A^^15^110^53
 ;;^UTILITY(U,$J,358.3,1155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1155,1,3,0)
 ;;=3^Contusion of right hand, initial encounter
 ;;^UTILITY(U,$J,358.3,1155,1,4,0)
 ;;=4^S60.221A
 ;;^UTILITY(U,$J,358.3,1155,2)
 ;;=^5032276
 ;;^UTILITY(U,$J,358.3,1156,0)
 ;;=S60.222A^^15^110^48
 ;;^UTILITY(U,$J,358.3,1156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1156,1,3,0)
 ;;=3^Contusion of left hand, initial encounter
 ;;^UTILITY(U,$J,358.3,1156,1,4,0)
 ;;=4^S60.222A
 ;;^UTILITY(U,$J,358.3,1156,2)
 ;;=^5032279
 ;;^UTILITY(U,$J,358.3,1157,0)
 ;;=S80.01XA^^15^110^54
 ;;^UTILITY(U,$J,358.3,1157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1157,1,3,0)
 ;;=3^Contusion of right knee, initial encounter
 ;;^UTILITY(U,$J,358.3,1157,1,4,0)
 ;;=4^S80.01XA
 ;;^UTILITY(U,$J,358.3,1157,2)
 ;;=^5039891
 ;;^UTILITY(U,$J,358.3,1158,0)
 ;;=S80.02XA^^15^110^49
 ;;^UTILITY(U,$J,358.3,1158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1158,1,3,0)
 ;;=3^Contusion of left knee, initial encounter
 ;;^UTILITY(U,$J,358.3,1158,1,4,0)
 ;;=4^S80.02XA
 ;;^UTILITY(U,$J,358.3,1158,2)
 ;;=^5039894
 ;;^UTILITY(U,$J,358.3,1159,0)
 ;;=S80.11XA^^15^110^55
 ;;^UTILITY(U,$J,358.3,1159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1159,1,3,0)
 ;;=3^Contusion of right lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,1159,1,4,0)
 ;;=4^S80.11XA
 ;;^UTILITY(U,$J,358.3,1159,2)
 ;;=^5039900
 ;;^UTILITY(U,$J,358.3,1160,0)
 ;;=S80.12XA^^15^110^51
 ;;^UTILITY(U,$J,358.3,1160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1160,1,3,0)
 ;;=3^Contusion of left lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,1160,1,4,0)
 ;;=4^S80.12XA
 ;;^UTILITY(U,$J,358.3,1160,2)
 ;;=^5039903
 ;;^UTILITY(U,$J,358.3,1161,0)
 ;;=T75.4XXA^^15^110^58
 ;;^UTILITY(U,$J,358.3,1161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1161,1,3,0)
 ;;=3^Electrocution, initial encounter
 ;;^UTILITY(U,$J,358.3,1161,1,4,0)
 ;;=4^T75.4XXA
 ;;^UTILITY(U,$J,358.3,1161,2)
 ;;=^5054203
 ;;^UTILITY(U,$J,358.3,1162,0)
 ;;=T15.91XA^^15^110^61
 ;;^UTILITY(U,$J,358.3,1162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1162,1,3,0)
 ;;=3^FB on Right External Eye,Part Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,1162,1,4,0)
 ;;=4^T15.91XA
 ;;^UTILITY(U,$J,358.3,1162,2)
 ;;=^5046411
 ;;^UTILITY(U,$J,358.3,1163,0)
 ;;=T15.92XA^^15^110^60
 ;;^UTILITY(U,$J,358.3,1163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1163,1,3,0)
 ;;=3^FB on Left External Eye,Part Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,1163,1,4,0)
 ;;=4^T15.92XA
 ;;^UTILITY(U,$J,358.3,1163,2)
 ;;=^5046414
 ;;^UTILITY(U,$J,358.3,1164,0)
 ;;=S82.891A^^15^110^63
 ;;^UTILITY(U,$J,358.3,1164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1164,1,3,0)
 ;;=3^Fx of Right Lower Leg NEC,Init for Clos Fx
 ;;^UTILITY(U,$J,358.3,1164,1,4,0)
 ;;=4^S82.891A
 ;;^UTILITY(U,$J,358.3,1164,2)
 ;;=^5042863
 ;;^UTILITY(U,$J,358.3,1165,0)
 ;;=S82.892A^^15^110^62
 ;;^UTILITY(U,$J,358.3,1165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1165,1,3,0)
 ;;=3^Fx of Left Lower Leg NEC,Init for Clos Fx
 ;;^UTILITY(U,$J,358.3,1165,1,4,0)
 ;;=4^S82.892A
 ;;^UTILITY(U,$J,358.3,1165,2)
 ;;=^5136944
 ;;^UTILITY(U,$J,358.3,1166,0)
 ;;=S62.101A^^15^110^89
 ;;^UTILITY(U,$J,358.3,1166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1166,1,3,0)
 ;;=3^Fx of unsp carpal bone, right wrist, init for clos fx
 ;;^UTILITY(U,$J,358.3,1166,1,4,0)
 ;;=4^S62.101A
 ;;^UTILITY(U,$J,358.3,1166,2)
 ;;=^5033199
 ;;^UTILITY(U,$J,358.3,1167,0)
 ;;=S62.102A^^15^110^88
 ;;^UTILITY(U,$J,358.3,1167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1167,1,3,0)
 ;;=3^Fx of unsp carpal bone, left wrist, init for clos fx
 ;;^UTILITY(U,$J,358.3,1167,1,4,0)
 ;;=4^S62.102A
 ;;^UTILITY(U,$J,358.3,1167,2)
 ;;=^5033206
 ;;^UTILITY(U,$J,358.3,1168,0)
 ;;=S42.001A^^15^110^93
 ;;^UTILITY(U,$J,358.3,1168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1168,1,3,0)
 ;;=3^Fx of unsp part of right clavicle, init for clos fx
 ;;^UTILITY(U,$J,358.3,1168,1,4,0)
 ;;=4^S42.001A
 ;;^UTILITY(U,$J,358.3,1168,2)
 ;;=^5026369
 ;;^UTILITY(U,$J,358.3,1169,0)
 ;;=S42.002A^^15^110^92
 ;;^UTILITY(U,$J,358.3,1169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1169,1,3,0)
 ;;=3^Fx of unsp part of left clavicle, init for clos fx
 ;;^UTILITY(U,$J,358.3,1169,1,4,0)
 ;;=4^S42.002A
 ;;^UTILITY(U,$J,358.3,1169,2)
 ;;=^5026376
 ;;^UTILITY(U,$J,358.3,1170,0)
 ;;=S42.401A^^15^110^82
 ;;^UTILITY(U,$J,358.3,1170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1170,1,3,0)
 ;;=3^Fx of right lower end of humerus unspec, init
 ;;^UTILITY(U,$J,358.3,1170,1,4,0)
 ;;=4^S42.401A
 ;;^UTILITY(U,$J,358.3,1170,2)
 ;;=^5027294
 ;;^UTILITY(U,$J,358.3,1171,0)
 ;;=S42.402A^^15^110^69
 ;;^UTILITY(U,$J,358.3,1171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1171,1,3,0)
 ;;=3^Fx of left lower end of humerus unspec, init for cl
 ;;^UTILITY(U,$J,358.3,1171,1,4,0)
 ;;=4^S42.402A
 ;;^UTILITY(U,$J,358.3,1171,2)
 ;;=^5134713
 ;;^UTILITY(U,$J,358.3,1172,0)
 ;;=S72.91XA^^15^110^77
 ;;^UTILITY(U,$J,358.3,1172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1172,1,3,0)
 ;;=3^Fx of right femur unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,1172,1,4,0)
 ;;=4^S72.91XA
 ;;^UTILITY(U,$J,358.3,1172,2)
 ;;=^5136471
 ;;^UTILITY(U,$J,358.3,1173,0)
 ;;=S72.92XA^^15^110^64
 ;;^UTILITY(U,$J,358.3,1173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1173,1,3,0)
 ;;=3^Fx of left femur unspec, init encntr for closed fx
 ;;^UTILITY(U,$J,358.3,1173,1,4,0)
 ;;=4^S72.92XA
 ;;^UTILITY(U,$J,358.3,1173,2)
 ;;=^5136472
 ;;^UTILITY(U,$J,358.3,1174,0)
 ;;=S82.401A^^15^110^78
 ;;^UTILITY(U,$J,358.3,1174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1174,1,3,0)
 ;;=3^Fx of right fibula shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,1174,1,4,0)
 ;;=4^S82.401A
 ;;^UTILITY(U,$J,358.3,1174,2)
 ;;=^5041677
 ;;^UTILITY(U,$J,358.3,1175,0)
 ;;=S82.402A^^15^110^65
 ;;^UTILITY(U,$J,358.3,1175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1175,1,3,0)
 ;;=3^Fx of left fibula shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,1175,1,4,0)
 ;;=4^S82.402A
 ;;^UTILITY(U,$J,358.3,1175,2)
 ;;=^5041693
 ;;^UTILITY(U,$J,358.3,1176,0)
 ;;=S62.600A^^15^110^101
 ;;^UTILITY(U,$J,358.3,1176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1176,1,3,0)
 ;;=3^Fx of unsp phalanx of right index finger, init
 ;;^UTILITY(U,$J,358.3,1176,1,4,0)
 ;;=4^S62.600A
 ;;^UTILITY(U,$J,358.3,1176,2)
 ;;=^5034382
 ;;^UTILITY(U,$J,358.3,1177,0)
 ;;=S62.601A^^15^110^96
 ;;^UTILITY(U,$J,358.3,1177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1177,1,3,0)
 ;;=3^Fx of unsp phalanx of left index finger, init
 ;;^UTILITY(U,$J,358.3,1177,1,4,0)
 ;;=4^S62.601A
 ;;^UTILITY(U,$J,358.3,1177,2)
 ;;=^5034389
 ;;^UTILITY(U,$J,358.3,1178,0)
 ;;=S62.602A^^15^110^103
 ;;^UTILITY(U,$J,358.3,1178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1178,1,3,0)
 ;;=3^Fx of unsp phalanx of right middle finger, init
 ;;^UTILITY(U,$J,358.3,1178,1,4,0)
 ;;=4^S62.602A
 ;;^UTILITY(U,$J,358.3,1178,2)
 ;;=^5034396
 ;;^UTILITY(U,$J,358.3,1179,0)
 ;;=S62.603A^^15^110^98
 ;;^UTILITY(U,$J,358.3,1179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1179,1,3,0)
 ;;=3^Fx of unsp phalanx of left middle finger, init
 ;;^UTILITY(U,$J,358.3,1179,1,4,0)
 ;;=4^S62.603A
 ;;^UTILITY(U,$J,358.3,1179,2)
 ;;=^5034403
 ;;^UTILITY(U,$J,358.3,1180,0)
 ;;=S62.604A^^15^110^104
 ;;^UTILITY(U,$J,358.3,1180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1180,1,3,0)
 ;;=3^Fx of unsp phalanx of right ring finger, init
 ;;^UTILITY(U,$J,358.3,1180,1,4,0)
 ;;=4^S62.604A
 ;;^UTILITY(U,$J,358.3,1180,2)
 ;;=^5034410
 ;;^UTILITY(U,$J,358.3,1181,0)
 ;;=S62.605A^^15^110^99
 ;;^UTILITY(U,$J,358.3,1181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1181,1,3,0)
 ;;=3^Fx of unsp phalanx of left ring finger, init
 ;;^UTILITY(U,$J,358.3,1181,1,4,0)
 ;;=4^S62.605A
 ;;^UTILITY(U,$J,358.3,1181,2)
 ;;=^5034417
 ;;^UTILITY(U,$J,358.3,1182,0)
 ;;=S62.606A^^15^110^102
 ;;^UTILITY(U,$J,358.3,1182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1182,1,3,0)
 ;;=3^Fx of unsp phalanx of right little finger, init
 ;;^UTILITY(U,$J,358.3,1182,1,4,0)
 ;;=4^S62.606A
 ;;^UTILITY(U,$J,358.3,1182,2)
 ;;=^5034424
 ;;^UTILITY(U,$J,358.3,1183,0)
 ;;=S62.607A^^15^110^97
 ;;^UTILITY(U,$J,358.3,1183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1183,1,3,0)
 ;;=3^Fx of unsp phalanx of left little finger, init
 ;;^UTILITY(U,$J,358.3,1183,1,4,0)
 ;;=4^S62.607A
 ;;^UTILITY(U,$J,358.3,1183,2)
 ;;=^5034431
 ;;^UTILITY(U,$J,358.3,1184,0)
 ;;=S92.901A^^15^110^79
 ;;^UTILITY(U,$J,358.3,1184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1184,1,3,0)
 ;;=3^Fx of right foot unspec, init encntr for closed fra
 ;;^UTILITY(U,$J,358.3,1184,1,4,0)
 ;;=4^S92.901A
 ;;^UTILITY(U,$J,358.3,1184,2)
 ;;=^5045578
 ;;^UTILITY(U,$J,358.3,1185,0)
 ;;=S92.902A^^15^110^66
 ;;^UTILITY(U,$J,358.3,1185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1185,1,3,0)
 ;;=3^Fx of left foot unspec, init encntr for closed fx
 ;;^UTILITY(U,$J,358.3,1185,1,4,0)
 ;;=4^S92.902A
 ;;^UTILITY(U,$J,358.3,1185,2)
 ;;=^5045585
 ;;^UTILITY(U,$J,358.3,1186,0)
 ;;=S42.301A^^15^110^81
 ;;^UTILITY(U,$J,358.3,1186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1186,1,3,0)
 ;;=3^Fx of right humerus shaft humerus unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,1186,1,4,0)
 ;;=4^S42.301A
 ;;^UTILITY(U,$J,358.3,1186,2)
 ;;=^5027031
 ;;^UTILITY(U,$J,358.3,1187,0)
 ;;=S42.302A^^15^110^68
 ;;^UTILITY(U,$J,358.3,1187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1187,1,3,0)
 ;;=3^Fx of left humerus shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,1187,1,4,0)
 ;;=4^S42.302A
 ;;^UTILITY(U,$J,358.3,1187,2)
 ;;=^5027038
