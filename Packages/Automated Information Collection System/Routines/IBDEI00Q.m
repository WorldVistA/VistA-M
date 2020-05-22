IBDEI00Q ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1188,0)
 ;;=S92.301A^^15^110^91
 ;;^UTILITY(U,$J,358.3,1188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1188,1,3,0)
 ;;=3^Fx of unsp metatarsal bone(s), right foot, init
 ;;^UTILITY(U,$J,358.3,1188,1,4,0)
 ;;=4^S92.301A
 ;;^UTILITY(U,$J,358.3,1188,2)
 ;;=^5045046
 ;;^UTILITY(U,$J,358.3,1189,0)
 ;;=S92.302A^^15^110^90
 ;;^UTILITY(U,$J,358.3,1189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1189,1,3,0)
 ;;=3^Fx of unsp metatarsal bone(s), left foot, init
 ;;^UTILITY(U,$J,358.3,1189,1,4,0)
 ;;=4^S92.302A
 ;;^UTILITY(U,$J,358.3,1189,2)
 ;;=^5045053
 ;;^UTILITY(U,$J,358.3,1190,0)
 ;;=S82.001A^^15^110^83
 ;;^UTILITY(U,$J,358.3,1190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1190,1,3,0)
 ;;=3^Fx of right patella unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,1190,1,4,0)
 ;;=4^S82.001A
 ;;^UTILITY(U,$J,358.3,1190,2)
 ;;=^5040104
 ;;^UTILITY(U,$J,358.3,1191,0)
 ;;=S82.002A^^15^110^70
 ;;^UTILITY(U,$J,358.3,1191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1191,1,3,0)
 ;;=3^Fx of left patella unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,1191,1,4,0)
 ;;=4^S82.002A
 ;;^UTILITY(U,$J,358.3,1191,2)
 ;;=^5040120
 ;;^UTILITY(U,$J,358.3,1192,0)
 ;;=S52.91XA^^15^110^80
 ;;^UTILITY(U,$J,358.3,1192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1192,1,3,0)
 ;;=3^Fx of right forearm unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,1192,1,4,0)
 ;;=4^S52.91XA
 ;;^UTILITY(U,$J,358.3,1192,2)
 ;;=^5031158
 ;;^UTILITY(U,$J,358.3,1193,0)
 ;;=S52.92XA^^15^110^67
 ;;^UTILITY(U,$J,358.3,1193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1193,1,3,0)
 ;;=3^Fx of left forearm unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,1193,1,4,0)
 ;;=4^S52.92XA
 ;;^UTILITY(U,$J,358.3,1193,2)
 ;;=^5031174
 ;;^UTILITY(U,$J,358.3,1194,0)
 ;;=S22.31XA^^15^110^76
 ;;^UTILITY(U,$J,358.3,1194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1194,1,3,0)
 ;;=3^Fx of one rib, right side, init for clos fx
 ;;^UTILITY(U,$J,358.3,1194,1,4,0)
 ;;=4^S22.31XA
 ;;^UTILITY(U,$J,358.3,1194,2)
 ;;=^5023105
 ;;^UTILITY(U,$J,358.3,1195,0)
 ;;=S22.32XA^^15^110^75
 ;;^UTILITY(U,$J,358.3,1195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1195,1,3,0)
 ;;=3^Fx of one rib, left side, init for clos fx
 ;;^UTILITY(U,$J,358.3,1195,1,4,0)
 ;;=4^S22.32XA
 ;;^UTILITY(U,$J,358.3,1195,2)
 ;;=^5023111
 ;;^UTILITY(U,$J,358.3,1196,0)
 ;;=S42.91XA^^15^110^84
 ;;^UTILITY(U,$J,358.3,1196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1196,1,3,0)
 ;;=3^Fx of right shoulder girdle, part unsp, init
 ;;^UTILITY(U,$J,358.3,1196,1,4,0)
 ;;=4^S42.91XA
 ;;^UTILITY(U,$J,358.3,1196,2)
 ;;=^5027643
 ;;^UTILITY(U,$J,358.3,1197,0)
 ;;=S42.92XA^^15^110^71
 ;;^UTILITY(U,$J,358.3,1197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1197,1,3,0)
 ;;=3^Fx of left shoulder girdle, part unsp, init
 ;;^UTILITY(U,$J,358.3,1197,1,4,0)
 ;;=4^S42.92XA
 ;;^UTILITY(U,$J,358.3,1197,2)
 ;;=^5027650
 ;;^UTILITY(U,$J,358.3,1198,0)
 ;;=S42.101A^^15^110^95
 ;;^UTILITY(U,$J,358.3,1198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1198,1,3,0)
 ;;=3^Fx of unsp part of scapula, right shoulder, init
 ;;^UTILITY(U,$J,358.3,1198,1,4,0)
 ;;=4^S42.101A
 ;;^UTILITY(U,$J,358.3,1198,2)
 ;;=^5026530
 ;;^UTILITY(U,$J,358.3,1199,0)
 ;;=S42.102A^^15^110^94
 ;;^UTILITY(U,$J,358.3,1199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1199,1,3,0)
 ;;=3^Fx of unsp part of scapula, left shoulder, init
 ;;^UTILITY(U,$J,358.3,1199,1,4,0)
 ;;=4^S42.102A
 ;;^UTILITY(U,$J,358.3,1199,2)
 ;;=^5026537
 ;;^UTILITY(U,$J,358.3,1200,0)
 ;;=S92.201A^^15^110^107
 ;;^UTILITY(U,$J,358.3,1200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1200,1,3,0)
 ;;=3^Fx of unsp tarsal bone(s) of right foot, init
 ;;^UTILITY(U,$J,358.3,1200,1,4,0)
 ;;=4^S92.201A
 ;;^UTILITY(U,$J,358.3,1200,2)
 ;;=^5044822
 ;;^UTILITY(U,$J,358.3,1201,0)
 ;;=S92.202A^^15^110^106
 ;;^UTILITY(U,$J,358.3,1201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1201,1,3,0)
 ;;=3^Fx of unsp tarsal bone(s) of left foot, init
 ;;^UTILITY(U,$J,358.3,1201,1,4,0)
 ;;=4^S92.202A
 ;;^UTILITY(U,$J,358.3,1201,2)
 ;;=^5044829
 ;;^UTILITY(U,$J,358.3,1202,0)
 ;;=S62.501A^^15^110^105
 ;;^UTILITY(U,$J,358.3,1202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1202,1,3,0)
 ;;=3^Fx of unsp phalanx of right thumb, init for clos fx
 ;;^UTILITY(U,$J,358.3,1202,1,4,0)
 ;;=4^S62.501A
 ;;^UTILITY(U,$J,358.3,1202,2)
 ;;=^5034284
 ;;^UTILITY(U,$J,358.3,1203,0)
 ;;=S62.502A^^15^110^100
 ;;^UTILITY(U,$J,358.3,1203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1203,1,3,0)
 ;;=3^Fx of unsp phalanx of left thumb, init for clos fx
 ;;^UTILITY(U,$J,358.3,1203,1,4,0)
 ;;=4^S62.502A
 ;;^UTILITY(U,$J,358.3,1203,2)
 ;;=^5034291
 ;;^UTILITY(U,$J,358.3,1204,0)
 ;;=S82.201A^^15^110^85
 ;;^UTILITY(U,$J,358.3,1204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1204,1,3,0)
 ;;=3^Fx of right tibia shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,1204,1,4,0)
 ;;=4^S82.201A
 ;;^UTILITY(U,$J,358.3,1204,2)
 ;;=^5041102
 ;;^UTILITY(U,$J,358.3,1205,0)
 ;;=S82.202A^^15^110^72
 ;;^UTILITY(U,$J,358.3,1205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1205,1,3,0)
 ;;=3^Fx of left tibia shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,1205,1,4,0)
 ;;=4^S82.202A
 ;;^UTILITY(U,$J,358.3,1205,2)
 ;;=^5041118
 ;;^UTILITY(U,$J,358.3,1206,0)
 ;;=S92.911A^^15^110^86
 ;;^UTILITY(U,$J,358.3,1206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1206,1,3,0)
 ;;=3^Fx of right toe(s) unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,1206,1,4,0)
 ;;=4^S92.911A
 ;;^UTILITY(U,$J,358.3,1206,2)
 ;;=^5045592
 ;;^UTILITY(U,$J,358.3,1207,0)
 ;;=S92.912A^^15^110^73
 ;;^UTILITY(U,$J,358.3,1207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1207,1,3,0)
 ;;=3^Fx of left toe(s) unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,1207,1,4,0)
 ;;=4^S92.912A
 ;;^UTILITY(U,$J,358.3,1207,2)
 ;;=^5045599
 ;;^UTILITY(U,$J,358.3,1208,0)
 ;;=S52.201A^^15^110^87
 ;;^UTILITY(U,$J,358.3,1208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1208,1,3,0)
 ;;=3^Fx of right ulna shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,1208,1,4,0)
 ;;=4^S52.201A
 ;;^UTILITY(U,$J,358.3,1208,2)
 ;;=^5029260
 ;;^UTILITY(U,$J,358.3,1209,0)
 ;;=S52.202A^^15^110^74
 ;;^UTILITY(U,$J,358.3,1209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1209,1,3,0)
 ;;=3^Fx of left ulna shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,1209,1,4,0)
 ;;=4^S52.202A
 ;;^UTILITY(U,$J,358.3,1209,2)
 ;;=^5029276
 ;;^UTILITY(U,$J,358.3,1210,0)
 ;;=T59.91XA^^15^110^245
 ;;^UTILITY(U,$J,358.3,1210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1210,1,3,0)
 ;;=3^Toxic effect of unsp gases, fumes and vapors, acc, init
 ;;^UTILITY(U,$J,358.3,1210,1,4,0)
 ;;=4^T59.91XA
 ;;^UTILITY(U,$J,358.3,1210,2)
 ;;=^5053042
 ;;^UTILITY(U,$J,358.3,1211,0)
 ;;=S41.111A^^15^110^135
 ;;^UTILITY(U,$J,358.3,1211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1211,1,3,0)
 ;;=3^Laceration w/o fb of right upper arm, init encntr
 ;;^UTILITY(U,$J,358.3,1211,1,4,0)
 ;;=4^S41.111A
 ;;^UTILITY(U,$J,358.3,1211,2)
 ;;=^5026336
 ;;^UTILITY(U,$J,358.3,1212,0)
 ;;=S41.112A^^15^110^123
 ;;^UTILITY(U,$J,358.3,1212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1212,1,3,0)
 ;;=3^Laceration w/o fb of left upper arm, init encntr
 ;;^UTILITY(U,$J,358.3,1212,1,4,0)
 ;;=4^S41.112A
 ;;^UTILITY(U,$J,358.3,1212,2)
 ;;=^5026339
 ;;^UTILITY(U,$J,358.3,1213,0)
 ;;=S61.210A^^15^110^128
 ;;^UTILITY(U,$J,358.3,1213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1213,1,3,0)
 ;;=3^Laceration w/o fb of right indx fngr w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1213,1,4,0)
 ;;=4^S61.210A
 ;;^UTILITY(U,$J,358.3,1213,2)
 ;;=^5032771
 ;;^UTILITY(U,$J,358.3,1214,0)
 ;;=S61.211A^^15^110^116
 ;;^UTILITY(U,$J,358.3,1214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1214,1,3,0)
 ;;=3^Laceration w/o fb of left indx fngr w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1214,1,4,0)
 ;;=4^S61.211A
 ;;^UTILITY(U,$J,358.3,1214,2)
 ;;=^5032774
 ;;^UTILITY(U,$J,358.3,1215,0)
 ;;=S61.212A^^15^110^132
 ;;^UTILITY(U,$J,358.3,1215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1215,1,3,0)
 ;;=3^Laceration w/o fb of right mid finger w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1215,1,4,0)
 ;;=4^S61.212A
 ;;^UTILITY(U,$J,358.3,1215,2)
 ;;=^5032777
 ;;^UTILITY(U,$J,358.3,1216,0)
 ;;=S61.213A^^15^110^120
 ;;^UTILITY(U,$J,358.3,1216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1216,1,3,0)
 ;;=3^Laceration w/o fb of left mid finger w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1216,1,4,0)
 ;;=4^S61.213A
 ;;^UTILITY(U,$J,358.3,1216,2)
 ;;=^5032780
 ;;^UTILITY(U,$J,358.3,1217,0)
 ;;=S61.214A^^15^110^133
 ;;^UTILITY(U,$J,358.3,1217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1217,1,3,0)
 ;;=3^Laceration w/o fb of right rng fngr w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1217,1,4,0)
 ;;=4^S61.214A
 ;;^UTILITY(U,$J,358.3,1217,2)
 ;;=^5032783
 ;;^UTILITY(U,$J,358.3,1218,0)
 ;;=S61.215A^^15^110^121
 ;;^UTILITY(U,$J,358.3,1218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1218,1,3,0)
 ;;=3^Laceration w/o fb of left rng fngr w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1218,1,4,0)
 ;;=4^S61.215A
 ;;^UTILITY(U,$J,358.3,1218,2)
 ;;=^5032786
 ;;^UTILITY(U,$J,358.3,1219,0)
 ;;=S61.216A^^15^110^130
 ;;^UTILITY(U,$J,358.3,1219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1219,1,3,0)
 ;;=3^Laceration w/o fb of right litttle finger w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1219,1,4,0)
 ;;=4^S61.216A
 ;;^UTILITY(U,$J,358.3,1219,2)
 ;;=^5032789
 ;;^UTILITY(U,$J,358.3,1220,0)
 ;;=S61.217A^^15^110^118
 ;;^UTILITY(U,$J,358.3,1220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1220,1,3,0)
 ;;=3^Laceration w/o fb of left little finger w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1220,1,4,0)
 ;;=4^S61.217A
 ;;^UTILITY(U,$J,358.3,1220,2)
 ;;=^5032792
 ;;^UTILITY(U,$J,358.3,1221,0)
 ;;=S91.311A^^15^110^124
 ;;^UTILITY(U,$J,358.3,1221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1221,1,3,0)
 ;;=3^Laceration w/o fb of right foot, init encntr
 ;;^UTILITY(U,$J,358.3,1221,1,4,0)
 ;;=4^S91.311A
 ;;^UTILITY(U,$J,358.3,1221,2)
 ;;=^5044320
 ;;^UTILITY(U,$J,358.3,1222,0)
 ;;=S91.312A^^15^110^112
 ;;^UTILITY(U,$J,358.3,1222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1222,1,3,0)
 ;;=3^Laceration w/o fb of left foot, init encntr
 ;;^UTILITY(U,$J,358.3,1222,1,4,0)
 ;;=4^S91.312A
 ;;^UTILITY(U,$J,358.3,1222,2)
 ;;=^5044323
 ;;^UTILITY(U,$J,358.3,1223,0)
 ;;=S51.811A^^15^110^125
 ;;^UTILITY(U,$J,358.3,1223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1223,1,3,0)
 ;;=3^Laceration w/o fb of right forearm, init encntr
 ;;^UTILITY(U,$J,358.3,1223,1,4,0)
 ;;=4^S51.811A
 ;;^UTILITY(U,$J,358.3,1223,2)
 ;;=^5028665
 ;;^UTILITY(U,$J,358.3,1224,0)
 ;;=S51.812A^^15^110^113
 ;;^UTILITY(U,$J,358.3,1224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1224,1,3,0)
 ;;=3^Laceration w/o fb of left forearm, init encntr
 ;;^UTILITY(U,$J,358.3,1224,1,4,0)
 ;;=4^S51.812A
 ;;^UTILITY(U,$J,358.3,1224,2)
 ;;=^5028668
 ;;^UTILITY(U,$J,358.3,1225,0)
 ;;=S61.411A^^15^110^127
 ;;^UTILITY(U,$J,358.3,1225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1225,1,3,0)
 ;;=3^Laceration w/o fb of right hand, init encntr
 ;;^UTILITY(U,$J,358.3,1225,1,4,0)
 ;;=4^S61.411A
 ;;^UTILITY(U,$J,358.3,1225,2)
 ;;=^5032987
 ;;^UTILITY(U,$J,358.3,1226,0)
 ;;=S61.412A^^15^110^115
 ;;^UTILITY(U,$J,358.3,1226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1226,1,3,0)
 ;;=3^Laceration w/o fb of left hand, init encntr
 ;;^UTILITY(U,$J,358.3,1226,1,4,0)
 ;;=4^S61.412A
 ;;^UTILITY(U,$J,358.3,1226,2)
 ;;=^5032990
 ;;^UTILITY(U,$J,358.3,1227,0)
 ;;=S81.811A^^15^110^131
 ;;^UTILITY(U,$J,358.3,1227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1227,1,3,0)
 ;;=3^Laceration w/o fb of right lower leg, init encntr
 ;;^UTILITY(U,$J,358.3,1227,1,4,0)
 ;;=4^S81.811A
 ;;^UTILITY(U,$J,358.3,1227,2)
 ;;=^5040071
 ;;^UTILITY(U,$J,358.3,1228,0)
 ;;=S81.812A^^15^110^119
 ;;^UTILITY(U,$J,358.3,1228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1228,1,3,0)
 ;;=3^Laceration w/o fb of left lower leg, init encntr
 ;;^UTILITY(U,$J,358.3,1228,1,4,0)
 ;;=4^S81.812A
 ;;^UTILITY(U,$J,358.3,1228,2)
 ;;=^5040074
 ;;^UTILITY(U,$J,358.3,1229,0)
 ;;=S01.01XA^^15^110^136
 ;;^UTILITY(U,$J,358.3,1229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1229,1,3,0)
 ;;=3^Laceration w/o fb of scalp, initial encounter
 ;;^UTILITY(U,$J,358.3,1229,1,4,0)
 ;;=4^S01.01XA
 ;;^UTILITY(U,$J,358.3,1229,2)
 ;;=^5020036
 ;;^UTILITY(U,$J,358.3,1230,0)
 ;;=S61.011A^^15^110^134
 ;;^UTILITY(U,$J,358.3,1230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1230,1,3,0)
 ;;=3^Laceration w/o fb of right thumb w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1230,1,4,0)
 ;;=4^S61.011A
 ;;^UTILITY(U,$J,358.3,1230,2)
 ;;=^5032690
 ;;^UTILITY(U,$J,358.3,1231,0)
 ;;=S61.012A^^15^110^122
 ;;^UTILITY(U,$J,358.3,1231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1231,1,3,0)
 ;;=3^Laceration w/o fb of left thumb w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1231,1,4,0)
 ;;=4^S61.012A
 ;;^UTILITY(U,$J,358.3,1231,2)
 ;;=^5032693
 ;;^UTILITY(U,$J,358.3,1232,0)
 ;;=S91.111A^^15^110^126
 ;;^UTILITY(U,$J,358.3,1232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1232,1,3,0)
 ;;=3^Laceration w/o fb of right great toe w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1232,1,4,0)
 ;;=4^S91.111A
 ;;^UTILITY(U,$J,358.3,1232,2)
 ;;=^5044183
 ;;^UTILITY(U,$J,358.3,1233,0)
 ;;=S91.112A^^15^110^114
 ;;^UTILITY(U,$J,358.3,1233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1233,1,3,0)
 ;;=3^Laceration w/o fb of left great toe w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1233,1,4,0)
 ;;=4^S91.112A
 ;;^UTILITY(U,$J,358.3,1233,2)
 ;;=^5044186
 ;;^UTILITY(U,$J,358.3,1234,0)
 ;;=S91.114A^^15^110^129
 ;;^UTILITY(U,$J,358.3,1234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1234,1,3,0)
 ;;=3^Laceration w/o fb of right lesser toe(s) w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1234,1,4,0)
 ;;=4^S91.114A
 ;;^UTILITY(U,$J,358.3,1234,2)
 ;;=^5044192
 ;;^UTILITY(U,$J,358.3,1235,0)
 ;;=S91.115A^^15^110^117
 ;;^UTILITY(U,$J,358.3,1235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1235,1,3,0)
 ;;=3^Laceration w/o fb of left lesser toe(s) w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1235,1,4,0)
 ;;=4^S91.115A
 ;;^UTILITY(U,$J,358.3,1235,2)
 ;;=^5044195
 ;;^UTILITY(U,$J,358.3,1236,0)
 ;;=T73.3XXA^^15^110^59
 ;;^UTILITY(U,$J,358.3,1236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1236,1,3,0)
 ;;=3^Exhaustion due to excessive exertion, initial encounter
 ;;^UTILITY(U,$J,358.3,1236,1,4,0)
 ;;=4^T73.3XXA
 ;;^UTILITY(U,$J,358.3,1236,2)
 ;;=^5054131
 ;;^UTILITY(U,$J,358.3,1237,0)
 ;;=S61.230A^^15^110^188
 ;;^UTILITY(U,$J,358.3,1237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1237,1,3,0)
 ;;=3^Pnctr wnd w/o fb of right indx fngr w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1237,1,4,0)
 ;;=4^S61.230A
 ;;^UTILITY(U,$J,358.3,1237,2)
 ;;=^5032816
 ;;^UTILITY(U,$J,358.3,1238,0)
 ;;=S61.231A^^15^110^178
 ;;^UTILITY(U,$J,358.3,1238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1238,1,3,0)
 ;;=3^Pnctr wnd w/o fb of left indx fngr w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1238,1,4,0)
 ;;=4^S61.231A
 ;;^UTILITY(U,$J,358.3,1238,2)
 ;;=^5032819
 ;;^UTILITY(U,$J,358.3,1239,0)
 ;;=S61.232A^^15^110^191
 ;;^UTILITY(U,$J,358.3,1239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1239,1,3,0)
 ;;=3^Pnctr wnd w/o fb of right mid finger w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1239,1,4,0)
 ;;=4^S61.232A
 ;;^UTILITY(U,$J,358.3,1239,2)
 ;;=^5032822
 ;;^UTILITY(U,$J,358.3,1240,0)
 ;;=S61.233A^^15^110^181
 ;;^UTILITY(U,$J,358.3,1240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1240,1,3,0)
 ;;=3^Pnctr wnd w/o fb of left mid finger w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1240,1,4,0)
 ;;=4^S61.233A
 ;;^UTILITY(U,$J,358.3,1240,2)
 ;;=^5032825
 ;;^UTILITY(U,$J,358.3,1241,0)
 ;;=S61.234A^^15^110^192
 ;;^UTILITY(U,$J,358.3,1241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1241,1,3,0)
 ;;=3^Pnctr wnd w/o fb of right rng fngr w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1241,1,4,0)
 ;;=4^S61.234A
 ;;^UTILITY(U,$J,358.3,1241,2)
 ;;=^5032828
 ;;^UTILITY(U,$J,358.3,1242,0)
 ;;=S61.235A^^15^110^182
 ;;^UTILITY(U,$J,358.3,1242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1242,1,3,0)
 ;;=3^Pnctr wnd w/o fb of left rng fngr w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1242,1,4,0)
 ;;=4^S61.235A
 ;;^UTILITY(U,$J,358.3,1242,2)
 ;;=^5032831
 ;;^UTILITY(U,$J,358.3,1243,0)
 ;;=S61.236A^^15^110^189
 ;;^UTILITY(U,$J,358.3,1243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1243,1,3,0)
 ;;=3^Pnctr wnd w/o fb of right little finger w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1243,1,4,0)
 ;;=4^S61.236A
 ;;^UTILITY(U,$J,358.3,1243,2)
 ;;=^5032834
 ;;^UTILITY(U,$J,358.3,1244,0)
 ;;=S61.237A^^15^110^179
 ;;^UTILITY(U,$J,358.3,1244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1244,1,3,0)
 ;;=3^Pnctr wnd w/o fb of left little finger w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1244,1,4,0)
 ;;=4^S61.237A
 ;;^UTILITY(U,$J,358.3,1244,2)
 ;;=^5032837
 ;;^UTILITY(U,$J,358.3,1245,0)
 ;;=S91.331A^^15^110^185
 ;;^UTILITY(U,$J,358.3,1245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1245,1,3,0)
 ;;=3^Pnctr wnd w/o fb of right foot, init encntr
 ;;^UTILITY(U,$J,358.3,1245,1,4,0)
 ;;=4^S91.331A
 ;;^UTILITY(U,$J,358.3,1245,2)
 ;;=^5044332
 ;;^UTILITY(U,$J,358.3,1246,0)
 ;;=S91.332A^^15^110^175
 ;;^UTILITY(U,$J,358.3,1246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1246,1,3,0)
 ;;=3^Pnctr wnd w/o fb of left foot, init encntr
 ;;^UTILITY(U,$J,358.3,1246,1,4,0)
 ;;=4^S91.332A
 ;;^UTILITY(U,$J,358.3,1246,2)
 ;;=^5044335
 ;;^UTILITY(U,$J,358.3,1247,0)
 ;;=S51.831A^^15^110^186
 ;;^UTILITY(U,$J,358.3,1247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1247,1,3,0)
 ;;=3^Pnctr wnd w/o fb of right forearm, init
 ;;^UTILITY(U,$J,358.3,1247,1,4,0)
 ;;=4^S51.831A
 ;;^UTILITY(U,$J,358.3,1247,2)
 ;;=^5028677
 ;;^UTILITY(U,$J,358.3,1248,0)
 ;;=S51.832A^^15^110^176
 ;;^UTILITY(U,$J,358.3,1248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1248,1,3,0)
 ;;=3^Pnctr wnd w/o fb of left forearm, init encntr
 ;;^UTILITY(U,$J,358.3,1248,1,4,0)
 ;;=4^S51.832A
 ;;^UTILITY(U,$J,358.3,1248,2)
 ;;=^5028680
 ;;^UTILITY(U,$J,358.3,1249,0)
 ;;=S61.431A^^15^110^187
 ;;^UTILITY(U,$J,358.3,1249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1249,1,3,0)
 ;;=3^Pnctr wnd w/o fb of right hand, init encntr
 ;;^UTILITY(U,$J,358.3,1249,1,4,0)
 ;;=4^S61.431A
 ;;^UTILITY(U,$J,358.3,1249,2)
 ;;=^5032999
 ;;^UTILITY(U,$J,358.3,1250,0)
 ;;=S61.432A^^15^110^177
 ;;^UTILITY(U,$J,358.3,1250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1250,1,3,0)
 ;;=3^Pnctr wnd w/o fb of left hand, init encntr
 ;;^UTILITY(U,$J,358.3,1250,1,4,0)
 ;;=4^S61.432A
 ;;^UTILITY(U,$J,358.3,1250,2)
 ;;=^5033002
 ;;^UTILITY(U,$J,358.3,1251,0)
 ;;=S81.831A^^15^110^190
 ;;^UTILITY(U,$J,358.3,1251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1251,1,3,0)
 ;;=3^Pnctr wnd w/o fb of right lower leg, init
 ;;^UTILITY(U,$J,358.3,1251,1,4,0)
 ;;=4^S81.831A
 ;;^UTILITY(U,$J,358.3,1251,2)
 ;;=^5040083
 ;;^UTILITY(U,$J,358.3,1252,0)
 ;;=S81.832A^^15^110^180
 ;;^UTILITY(U,$J,358.3,1252,1,0)
 ;;=^358.31IA^4^2
