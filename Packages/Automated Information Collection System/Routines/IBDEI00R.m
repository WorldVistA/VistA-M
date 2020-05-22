IBDEI00R ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1252,1,3,0)
 ;;=3^Pnctr wnd w/o fb of left lower leg, init encntr
 ;;^UTILITY(U,$J,358.3,1252,1,4,0)
 ;;=4^S81.832A
 ;;^UTILITY(U,$J,358.3,1252,2)
 ;;=^5040086
 ;;^UTILITY(U,$J,358.3,1253,0)
 ;;=S01.03XA^^15^110^195
 ;;^UTILITY(U,$J,358.3,1253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1253,1,3,0)
 ;;=3^Pnctr wnd w/o fb of scalp, init encntr
 ;;^UTILITY(U,$J,358.3,1253,1,4,0)
 ;;=4^S01.03XA
 ;;^UTILITY(U,$J,358.3,1253,2)
 ;;=^5020042
 ;;^UTILITY(U,$J,358.3,1254,0)
 ;;=S61.031A^^15^110^193
 ;;^UTILITY(U,$J,358.3,1254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1254,1,3,0)
 ;;=3^Pnctr wnd w/o fb of right thumb w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1254,1,4,0)
 ;;=4^S61.031A
 ;;^UTILITY(U,$J,358.3,1254,2)
 ;;=^5032702
 ;;^UTILITY(U,$J,358.3,1255,0)
 ;;=S61.032A^^15^110^183
 ;;^UTILITY(U,$J,358.3,1255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1255,1,3,0)
 ;;=3^Pnctr wnd w/o fb of left thumb w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,1255,1,4,0)
 ;;=4^S61.032A
 ;;^UTILITY(U,$J,358.3,1255,2)
 ;;=^5032705
 ;;^UTILITY(U,$J,358.3,1256,0)
 ;;=S61.531A^^15^110^194
 ;;^UTILITY(U,$J,358.3,1256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1256,1,3,0)
 ;;=3^Pnctr wnd w/o fb of right wrist, init encntr
 ;;^UTILITY(U,$J,358.3,1256,1,4,0)
 ;;=4^S61.531A
 ;;^UTILITY(U,$J,358.3,1256,2)
 ;;=^5033038
 ;;^UTILITY(U,$J,358.3,1257,0)
 ;;=S61.532A^^15^110^184
 ;;^UTILITY(U,$J,358.3,1257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1257,1,3,0)
 ;;=3^Pnctr wnd w/o fb of left wrist, init encntr
 ;;^UTILITY(U,$J,358.3,1257,1,4,0)
 ;;=4^S61.532A
 ;;^UTILITY(U,$J,358.3,1257,2)
 ;;=^5033041
 ;;^UTILITY(U,$J,358.3,1258,0)
 ;;=S86.891A^^15^110^138
 ;;^UTILITY(U,$J,358.3,1258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1258,1,3,0)
 ;;=3^Musc/Tend Right Lower Leg Level Inj,Init Encntr
 ;;^UTILITY(U,$J,358.3,1258,1,4,0)
 ;;=4^S86.891A
 ;;^UTILITY(U,$J,358.3,1258,2)
 ;;=^5137173
 ;;^UTILITY(U,$J,358.3,1259,0)
 ;;=S86.892A^^15^110^137
 ;;^UTILITY(U,$J,358.3,1259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1259,1,3,0)
 ;;=3^Musc/Tend Left Lower Leg Level Inj,Init Encntr
 ;;^UTILITY(U,$J,358.3,1259,1,4,0)
 ;;=4^S86.892A
 ;;^UTILITY(U,$J,358.3,1259,2)
 ;;=^5137174
 ;;^UTILITY(U,$J,358.3,1260,0)
 ;;=S43.51XA^^15^110^221
 ;;^UTILITY(U,$J,358.3,1260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1260,1,3,0)
 ;;=3^Sprain of right acromioclavicular joint, initial encounter
 ;;^UTILITY(U,$J,358.3,1260,1,4,0)
 ;;=4^S43.51XA
 ;;^UTILITY(U,$J,358.3,1260,2)
 ;;=^5027903
 ;;^UTILITY(U,$J,358.3,1261,0)
 ;;=S43.52XA^^15^110^202
 ;;^UTILITY(U,$J,358.3,1261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1261,1,3,0)
 ;;=3^Sprain of left acromioclavicular joint, initial encounter
 ;;^UTILITY(U,$J,358.3,1261,1,4,0)
 ;;=4^S43.52XA
 ;;^UTILITY(U,$J,358.3,1261,2)
 ;;=^5027906
 ;;^UTILITY(U,$J,358.3,1262,0)
 ;;=S93.401A^^15^110^240
 ;;^UTILITY(U,$J,358.3,1262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1262,1,3,0)
 ;;=3^Sprain of unspecified ligament of right ankle, init encntr
 ;;^UTILITY(U,$J,358.3,1262,1,4,0)
 ;;=4^S93.401A
 ;;^UTILITY(U,$J,358.3,1262,2)
 ;;=^5045774
 ;;^UTILITY(U,$J,358.3,1263,0)
 ;;=S93.402A^^15^110^239
 ;;^UTILITY(U,$J,358.3,1263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1263,1,3,0)
 ;;=3^Sprain of unspecified ligament of left ankle, init encntr
 ;;^UTILITY(U,$J,358.3,1263,1,4,0)
 ;;=4^S93.402A
 ;;^UTILITY(U,$J,358.3,1263,2)
 ;;=^5045777
 ;;^UTILITY(U,$J,358.3,1264,0)
 ;;=S53.401A^^15^110^222
 ;;^UTILITY(U,$J,358.3,1264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1264,1,3,0)
 ;;=3^Sprain of right elbow unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,1264,1,4,0)
 ;;=4^S53.401A
 ;;^UTILITY(U,$J,358.3,1264,2)
 ;;=^5031361
 ;;^UTILITY(U,$J,358.3,1265,0)
 ;;=S53.402A^^15^110^203
 ;;^UTILITY(U,$J,358.3,1265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1265,1,3,0)
 ;;=3^Sprain of left elbow unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,1265,1,4,0)
 ;;=4^S53.402A
 ;;^UTILITY(U,$J,358.3,1265,2)
 ;;=^5031364
 ;;^UTILITY(U,$J,358.3,1266,0)
 ;;=S63.610A^^15^110^225
 ;;^UTILITY(U,$J,358.3,1266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1266,1,3,0)
 ;;=3^Sprain of right index finger unspec, initial encou
 ;;^UTILITY(U,$J,358.3,1266,1,4,0)
 ;;=4^S63.610A
 ;;^UTILITY(U,$J,358.3,1266,2)
 ;;=^5035622
 ;;^UTILITY(U,$J,358.3,1267,0)
 ;;=S63.611A^^15^110^206
 ;;^UTILITY(U,$J,358.3,1267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1267,1,3,0)
 ;;=3^Sprain of left index finger unspec, initial encoun
 ;;^UTILITY(U,$J,358.3,1267,1,4,0)
 ;;=4^S63.611A
 ;;^UTILITY(U,$J,358.3,1267,2)
 ;;=^5035625
 ;;^UTILITY(U,$J,358.3,1268,0)
 ;;=S63.612A^^15^110^228
 ;;^UTILITY(U,$J,358.3,1268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1268,1,3,0)
 ;;=3^Sprain of right middle finger unspec, initial enco
 ;;^UTILITY(U,$J,358.3,1268,1,4,0)
 ;;=4^S63.612A
 ;;^UTILITY(U,$J,358.3,1268,2)
 ;;=^5035628
 ;;^UTILITY(U,$J,358.3,1269,0)
 ;;=S63.613A^^15^110^209
 ;;^UTILITY(U,$J,358.3,1269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1269,1,3,0)
 ;;=3^Sprain of left middle finger unspec, initial encou
 ;;^UTILITY(U,$J,358.3,1269,1,4,0)
 ;;=4^S63.613A
 ;;^UTILITY(U,$J,358.3,1269,2)
 ;;=^5035631
 ;;^UTILITY(U,$J,358.3,1270,0)
 ;;=S63.614A^^15^110^229
 ;;^UTILITY(U,$J,358.3,1270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1270,1,3,0)
 ;;=3^Sprain of right ring finger unspec, initial encoun
 ;;^UTILITY(U,$J,358.3,1270,1,4,0)
 ;;=4^S63.614A
 ;;^UTILITY(U,$J,358.3,1270,2)
 ;;=^5035634
 ;;^UTILITY(U,$J,358.3,1271,0)
 ;;=S63.615A^^15^110^210
 ;;^UTILITY(U,$J,358.3,1271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1271,1,3,0)
 ;;=3^Sprain of left ring finger unspec, initial encount
 ;;^UTILITY(U,$J,358.3,1271,1,4,0)
 ;;=4^S63.615A
 ;;^UTILITY(U,$J,358.3,1271,2)
 ;;=^5035637
 ;;^UTILITY(U,$J,358.3,1272,0)
 ;;=S63.616A^^15^110^227
 ;;^UTILITY(U,$J,358.3,1272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1272,1,3,0)
 ;;=3^Sprain of right little finger unspec, initial enco
 ;;^UTILITY(U,$J,358.3,1272,1,4,0)
 ;;=4^S63.616A
 ;;^UTILITY(U,$J,358.3,1272,2)
 ;;=^5035640
 ;;^UTILITY(U,$J,358.3,1273,0)
 ;;=S63.617A^^15^110^208
 ;;^UTILITY(U,$J,358.3,1273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1273,1,3,0)
 ;;=3^Sprain of left little finger unspec, initial encou
 ;;^UTILITY(U,$J,358.3,1273,1,4,0)
 ;;=4^S63.617A
 ;;^UTILITY(U,$J,358.3,1273,2)
 ;;=^5035643
 ;;^UTILITY(U,$J,358.3,1274,0)
 ;;=S93.601A^^15^110^223
 ;;^UTILITY(U,$J,358.3,1274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1274,1,3,0)
 ;;=3^Sprain of right foot unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,1274,1,4,0)
 ;;=4^S93.601A
 ;;^UTILITY(U,$J,358.3,1274,2)
 ;;=^5045867
 ;;^UTILITY(U,$J,358.3,1275,0)
 ;;=S93.602A^^15^110^204
 ;;^UTILITY(U,$J,358.3,1275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1275,1,3,0)
 ;;=3^Sprain of left foot unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,1275,1,4,0)
 ;;=4^S93.602A
 ;;^UTILITY(U,$J,358.3,1275,2)
 ;;=^5045870
 ;;^UTILITY(U,$J,358.3,1276,0)
 ;;=S63.91XA^^15^110^238
 ;;^UTILITY(U,$J,358.3,1276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1276,1,3,0)
 ;;=3^Sprain of unsp part of right wrist and hand, init encntr
 ;;^UTILITY(U,$J,358.3,1276,1,4,0)
 ;;=4^S63.91XA
 ;;^UTILITY(U,$J,358.3,1276,2)
 ;;=^5136046
 ;;^UTILITY(U,$J,358.3,1277,0)
 ;;=S63.92XA^^15^110^237
 ;;^UTILITY(U,$J,358.3,1277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1277,1,3,0)
 ;;=3^Sprain of unsp part of left wrist and hand, init encntr
 ;;^UTILITY(U,$J,358.3,1277,1,4,0)
 ;;=4^S63.92XA
 ;;^UTILITY(U,$J,358.3,1277,2)
 ;;=^5136047
 ;;^UTILITY(U,$J,358.3,1278,0)
 ;;=S83.401A^^15^110^234
 ;;^UTILITY(U,$J,358.3,1278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1278,1,3,0)
 ;;=3^Sprain of unsp collateral ligament of right knee, init
 ;;^UTILITY(U,$J,358.3,1278,1,4,0)
 ;;=4^S83.401A
 ;;^UTILITY(U,$J,358.3,1278,2)
 ;;=^5043103
 ;;^UTILITY(U,$J,358.3,1279,0)
 ;;=S83.402A^^15^110^233
 ;;^UTILITY(U,$J,358.3,1279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1279,1,3,0)
 ;;=3^Sprain of unsp collateral ligament of left knee, init encntr
 ;;^UTILITY(U,$J,358.3,1279,1,4,0)
 ;;=4^S83.402A
 ;;^UTILITY(U,$J,358.3,1279,2)
 ;;=^5043106
 ;;^UTILITY(U,$J,358.3,1280,0)
 ;;=S83.411A^^15^110^217
 ;;^UTILITY(U,$J,358.3,1280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1280,1,3,0)
 ;;=3^Sprain of medial collateral ligament of right knee, init
 ;;^UTILITY(U,$J,358.3,1280,1,4,0)
 ;;=4^S83.411A
 ;;^UTILITY(U,$J,358.3,1280,2)
 ;;=^5043109
 ;;^UTILITY(U,$J,358.3,1281,0)
 ;;=S83.412A^^15^110^218
 ;;^UTILITY(U,$J,358.3,1281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1281,1,3,0)
 ;;=3^Sprain of medial collateral ligament of left knee, init
 ;;^UTILITY(U,$J,358.3,1281,1,4,0)
 ;;=4^S83.412A
 ;;^UTILITY(U,$J,358.3,1281,2)
 ;;=^5043112
 ;;^UTILITY(U,$J,358.3,1282,0)
 ;;=S83.421A^^15^110^200
 ;;^UTILITY(U,$J,358.3,1282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1282,1,3,0)
 ;;=3^Sprain of lateral collateral ligament of right knee, init
 ;;^UTILITY(U,$J,358.3,1282,1,4,0)
 ;;=4^S83.421A
 ;;^UTILITY(U,$J,358.3,1282,2)
 ;;=^5043118
 ;;^UTILITY(U,$J,358.3,1283,0)
 ;;=S83.422A^^15^110^201
 ;;^UTILITY(U,$J,358.3,1283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1283,1,3,0)
 ;;=3^Sprain of lateral collateral ligament of left knee, init
 ;;^UTILITY(U,$J,358.3,1283,1,4,0)
 ;;=4^S83.422A
 ;;^UTILITY(U,$J,358.3,1283,2)
 ;;=^5043121
 ;;^UTILITY(U,$J,358.3,1284,0)
 ;;=S83.501A^^15^110^236
 ;;^UTILITY(U,$J,358.3,1284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1284,1,3,0)
 ;;=3^Sprain of unsp cruciate ligament of right knee, init encntr
 ;;^UTILITY(U,$J,358.3,1284,1,4,0)
 ;;=4^S83.501A
 ;;^UTILITY(U,$J,358.3,1284,2)
 ;;=^5043127
 ;;^UTILITY(U,$J,358.3,1285,0)
 ;;=S83.502A^^15^110^235
 ;;^UTILITY(U,$J,358.3,1285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1285,1,3,0)
 ;;=3^Sprain of unsp cruciate ligament of left knee, init encntr
 ;;^UTILITY(U,$J,358.3,1285,1,4,0)
 ;;=4^S83.502A
 ;;^UTILITY(U,$J,358.3,1285,2)
 ;;=^5043130
 ;;^UTILITY(U,$J,358.3,1286,0)
 ;;=S83.511A^^15^110^197
 ;;^UTILITY(U,$J,358.3,1286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1286,1,3,0)
 ;;=3^Sprain of anterior cruciate ligament of right knee, init
 ;;^UTILITY(U,$J,358.3,1286,1,4,0)
 ;;=4^S83.511A
 ;;^UTILITY(U,$J,358.3,1286,2)
 ;;=^5043133
 ;;^UTILITY(U,$J,358.3,1287,0)
 ;;=S83.512A^^15^110^198
 ;;^UTILITY(U,$J,358.3,1287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1287,1,3,0)
 ;;=3^Sprain of anterior cruciate ligament of left knee, init
 ;;^UTILITY(U,$J,358.3,1287,1,4,0)
 ;;=4^S83.512A
 ;;^UTILITY(U,$J,358.3,1287,2)
 ;;=^5043136
 ;;^UTILITY(U,$J,358.3,1288,0)
 ;;=S83.521A^^15^110^219
 ;;^UTILITY(U,$J,358.3,1288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1288,1,3,0)
 ;;=3^Sprain of posterior cruciate ligament of right knee, init
 ;;^UTILITY(U,$J,358.3,1288,1,4,0)
 ;;=4^S83.521A
 ;;^UTILITY(U,$J,358.3,1288,2)
 ;;=^5043142
 ;;^UTILITY(U,$J,358.3,1289,0)
 ;;=S83.522A^^15^110^220
 ;;^UTILITY(U,$J,358.3,1289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1289,1,3,0)
 ;;=3^Sprain of posterior cruciate ligament of left knee, init
 ;;^UTILITY(U,$J,358.3,1289,1,4,0)
 ;;=4^S83.522A
 ;;^UTILITY(U,$J,358.3,1289,2)
 ;;=^5043145
 ;;^UTILITY(U,$J,358.3,1290,0)
 ;;=S76.111A^^15^110^244
 ;;^UTILITY(U,$J,358.3,1290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1290,1,3,0)
 ;;=3^Strain of right quadriceps muscle, fascia and tendon, init
 ;;^UTILITY(U,$J,358.3,1290,1,4,0)
 ;;=4^S76.111A
 ;;^UTILITY(U,$J,358.3,1290,2)
 ;;=^5039546
 ;;^UTILITY(U,$J,358.3,1291,0)
 ;;=S76.112A^^15^110^241
 ;;^UTILITY(U,$J,358.3,1291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1291,1,3,0)
 ;;=3^Strain of left quadriceps muscle, fascia and tendon, init
 ;;^UTILITY(U,$J,358.3,1291,1,4,0)
 ;;=4^S76.112A
 ;;^UTILITY(U,$J,358.3,1291,2)
 ;;=^5039549
 ;;^UTILITY(U,$J,358.3,1292,0)
 ;;=S33.5XXA^^15^110^215
 ;;^UTILITY(U,$J,358.3,1292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1292,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, initial encounter
 ;;^UTILITY(U,$J,358.3,1292,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,1292,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,1293,0)
 ;;=S13.9XXA^^15^110^199
 ;;^UTILITY(U,$J,358.3,1293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1293,1,3,0)
 ;;=3^Sprain of joints and ligaments of unsp parts of neck, init
 ;;^UTILITY(U,$J,358.3,1293,1,4,0)
 ;;=4^S13.9XXA
 ;;^UTILITY(U,$J,358.3,1293,2)
 ;;=^5022037
 ;;^UTILITY(U,$J,358.3,1294,0)
 ;;=S43.401A^^15^110^230
 ;;^UTILITY(U,$J,358.3,1294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1294,1,3,0)
 ;;=3^Sprain of right shoulder joint unspec, init encntr
 ;;^UTILITY(U,$J,358.3,1294,1,4,0)
 ;;=4^S43.401A
 ;;^UTILITY(U,$J,358.3,1294,2)
 ;;=^5027864
 ;;^UTILITY(U,$J,358.3,1295,0)
 ;;=S43.402A^^15^110^211
 ;;^UTILITY(U,$J,358.3,1295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1295,1,3,0)
 ;;=3^Sprain of left shoulder joint unspec, initial enco
 ;;^UTILITY(U,$J,358.3,1295,1,4,0)
 ;;=4^S43.402A
 ;;^UTILITY(U,$J,358.3,1295,2)
 ;;=^5027867
 ;;^UTILITY(U,$J,358.3,1296,0)
 ;;=S13.4XXA^^15^110^214
 ;;^UTILITY(U,$J,358.3,1296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1296,1,3,0)
 ;;=3^Sprain of ligaments of cervical spine, initial encounter
 ;;^UTILITY(U,$J,358.3,1296,1,4,0)
 ;;=4^S13.4XXA
 ;;^UTILITY(U,$J,358.3,1296,2)
 ;;=^5022028
 ;;^UTILITY(U,$J,358.3,1297,0)
 ;;=S23.3XXA^^15^110^216
 ;;^UTILITY(U,$J,358.3,1297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1297,1,3,0)
 ;;=3^Sprain of ligaments of thoracic spine, initial encounter
 ;;^UTILITY(U,$J,358.3,1297,1,4,0)
 ;;=4^S23.3XXA
 ;;^UTILITY(U,$J,358.3,1297,2)
 ;;=^5023246
 ;;^UTILITY(U,$J,358.3,1298,0)
 ;;=S63.601A^^15^110^231
 ;;^UTILITY(U,$J,358.3,1298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1298,1,3,0)
 ;;=3^Sprain of right thumb unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,1298,1,4,0)
 ;;=4^S63.601A
 ;;^UTILITY(U,$J,358.3,1298,2)
 ;;=^5035616
 ;;^UTILITY(U,$J,358.3,1299,0)
 ;;=S63.602A^^15^110^212
 ;;^UTILITY(U,$J,358.3,1299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1299,1,3,0)
 ;;=3^Sprain of left thumb unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,1299,1,4,0)
 ;;=4^S63.602A
 ;;^UTILITY(U,$J,358.3,1299,2)
 ;;=^5035619
 ;;^UTILITY(U,$J,358.3,1300,0)
 ;;=S93.501A^^15^110^224
 ;;^UTILITY(U,$J,358.3,1300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1300,1,3,0)
 ;;=3^Sprain of right great toe unspec, initial encounte
 ;;^UTILITY(U,$J,358.3,1300,1,4,0)
 ;;=4^S93.501A
 ;;^UTILITY(U,$J,358.3,1300,2)
 ;;=^5045810
 ;;^UTILITY(U,$J,358.3,1301,0)
 ;;=S93.502A^^15^110^205
 ;;^UTILITY(U,$J,358.3,1301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1301,1,3,0)
 ;;=3^Sprain of left great toe unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,1301,1,4,0)
 ;;=4^S93.502A
 ;;^UTILITY(U,$J,358.3,1301,2)
 ;;=^5045813
 ;;^UTILITY(U,$J,358.3,1302,0)
 ;;=S93.504A^^15^110^226
 ;;^UTILITY(U,$J,358.3,1302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1302,1,3,0)
 ;;=3^Sprain of right lesser toe(s) unspec, initial enco
 ;;^UTILITY(U,$J,358.3,1302,1,4,0)
 ;;=4^S93.504A
 ;;^UTILITY(U,$J,358.3,1302,2)
 ;;=^5045816
 ;;^UTILITY(U,$J,358.3,1303,0)
 ;;=S93.505A^^15^110^207
 ;;^UTILITY(U,$J,358.3,1303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1303,1,3,0)
 ;;=3^Sprain of left lesser toe(s) unspec, initial encou
 ;;^UTILITY(U,$J,358.3,1303,1,4,0)
 ;;=4^S93.505A
 ;;^UTILITY(U,$J,358.3,1303,2)
 ;;=^5045819
 ;;^UTILITY(U,$J,358.3,1304,0)
 ;;=S63.501A^^15^110^232
 ;;^UTILITY(U,$J,358.3,1304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1304,1,3,0)
 ;;=3^Sprain of right wrist unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,1304,1,4,0)
 ;;=4^S63.501A
 ;;^UTILITY(U,$J,358.3,1304,2)
 ;;=^5035583
 ;;^UTILITY(U,$J,358.3,1305,0)
 ;;=S63.502A^^15^110^213
 ;;^UTILITY(U,$J,358.3,1305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1305,1,3,0)
 ;;=3^Sprain of left wrist unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,1305,1,4,0)
 ;;=4^S63.502A
 ;;^UTILITY(U,$J,358.3,1305,2)
 ;;=^5035586
 ;;^UTILITY(U,$J,358.3,1306,0)
 ;;=S39.012A^^15^110^243
 ;;^UTILITY(U,$J,358.3,1306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1306,1,3,0)
 ;;=3^Strain of muscle, fascia and tendon of lower back, init
 ;;^UTILITY(U,$J,358.3,1306,1,4,0)
 ;;=4^S39.012A
 ;;^UTILITY(U,$J,358.3,1306,2)
 ;;=^5026102
 ;;^UTILITY(U,$J,358.3,1307,0)
 ;;=S16.1XXA^^15^110^242
 ;;^UTILITY(U,$J,358.3,1307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1307,1,3,0)
 ;;=3^Strain of muscle, fascia and tendon at neck level, init
 ;;^UTILITY(U,$J,358.3,1307,1,4,0)
 ;;=4^S16.1XXA
 ;;^UTILITY(U,$J,358.3,1307,2)
 ;;=^5022358
 ;;^UTILITY(U,$J,358.3,1308,0)
 ;;=T69.9XXA^^15^110^56
 ;;^UTILITY(U,$J,358.3,1308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1308,1,3,0)
 ;;=3^Effect of reduced temperature, unspecified, init encntr
 ;;^UTILITY(U,$J,358.3,1308,1,4,0)
 ;;=4^T69.9XXA
 ;;^UTILITY(U,$J,358.3,1308,2)
 ;;=^5053978
 ;;^UTILITY(U,$J,358.3,1309,0)
 ;;=T69.8XXA^^15^110^57
 ;;^UTILITY(U,$J,358.3,1309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1309,1,3,0)
 ;;=3^Effects of Reduced Temperature NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,1309,1,4,0)
 ;;=4^T69.8XXA
 ;;^UTILITY(U,$J,358.3,1309,2)
 ;;=^5053975
 ;;^UTILITY(U,$J,358.3,1310,0)
 ;;=L57.8^^15^110^196
 ;;^UTILITY(U,$J,358.3,1310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1310,1,3,0)
 ;;=3^Skin Changes d/t Chr Expsr to Nonionizing Radiation NEC
 ;;^UTILITY(U,$J,358.3,1310,1,4,0)
 ;;=4^L57.8
 ;;^UTILITY(U,$J,358.3,1310,2)
 ;;=^5009226
 ;;^UTILITY(U,$J,358.3,1311,0)
 ;;=S91.001A^^15^110^165
 ;;^UTILITY(U,$J,358.3,1311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1311,1,3,0)
 ;;=3^Open wnd of right ankle unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,1311,1,4,0)
 ;;=4^S91.001A
 ;;^UTILITY(U,$J,358.3,1311,2)
 ;;=^5044129
 ;;^UTILITY(U,$J,358.3,1312,0)
 ;;=S91.002A^^15^110^155
 ;;^UTILITY(U,$J,358.3,1312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1312,1,3,0)
 ;;=3^Open wnd of left ankle unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,1312,1,4,0)
 ;;=4^S91.002A
 ;;^UTILITY(U,$J,358.3,1312,2)
 ;;=^5044132
 ;;^UTILITY(U,$J,358.3,1313,0)
 ;;=S41.101A^^15^110^174
 ;;^UTILITY(U,$J,358.3,1313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1313,1,3,0)
 ;;=3^Open wnd of right upper arm unspec, initial enco
 ;;^UTILITY(U,$J,358.3,1313,1,4,0)
 ;;=4^S41.101A
 ;;^UTILITY(U,$J,358.3,1313,2)
 ;;=^5026330
 ;;^UTILITY(U,$J,358.3,1314,0)
 ;;=S41.102A^^15^110^164
 ;;^UTILITY(U,$J,358.3,1314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1314,1,3,0)
 ;;=3^Open wnd of left upper arm unspec, initial encou
 ;;^UTILITY(U,$J,358.3,1314,1,4,0)
 ;;=4^S41.102A
 ;;^UTILITY(U,$J,358.3,1314,2)
 ;;=^5026333
 ;;^UTILITY(U,$J,358.3,1315,0)
 ;;=S61.200A^^15^110^169
 ;;^UTILITY(U,$J,358.3,1315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1315,1,3,0)
 ;;=3^Open wnd of right idx fngr w/o damage to nail unspec, init
 ;;^UTILITY(U,$J,358.3,1315,1,4,0)
 ;;=4^S61.200A
 ;;^UTILITY(U,$J,358.3,1315,2)
 ;;=^5032741
 ;;^UTILITY(U,$J,358.3,1316,0)
 ;;=S61.201A^^15^110^159
 ;;^UTILITY(U,$J,358.3,1316,1,0)
 ;;=^358.31IA^4^2
