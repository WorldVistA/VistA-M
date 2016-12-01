IBDEI01E ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1273,1,4,0)
 ;;=4^I80.201
 ;;^UTILITY(U,$J,358.3,1273,2)
 ;;=^5007828
 ;;^UTILITY(U,$J,358.3,1274,0)
 ;;=I80.202^^6^106^28
 ;;^UTILITY(U,$J,358.3,1274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1274,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis Deep Vessels Left Lower Extremity
 ;;^UTILITY(U,$J,358.3,1274,1,4,0)
 ;;=4^I80.202
 ;;^UTILITY(U,$J,358.3,1274,2)
 ;;=^5007829
 ;;^UTILITY(U,$J,358.3,1275,0)
 ;;=I80.203^^6^106^29
 ;;^UTILITY(U,$J,358.3,1275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1275,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis Deep Vessels Bilateral Lower Extremity
 ;;^UTILITY(U,$J,358.3,1275,1,4,0)
 ;;=4^I80.203
 ;;^UTILITY(U,$J,358.3,1275,2)
 ;;=^5007830
 ;;^UTILITY(U,$J,358.3,1276,0)
 ;;=K27.9^^6^106^24
 ;;^UTILITY(U,$J,358.3,1276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1276,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,1276,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,1276,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,1277,0)
 ;;=G89.18^^6^106^36
 ;;^UTILITY(U,$J,358.3,1277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1277,1,3,0)
 ;;=3^Postprocedural Pain,Acute
 ;;^UTILITY(U,$J,358.3,1277,1,4,0)
 ;;=4^G89.18
 ;;^UTILITY(U,$J,358.3,1277,2)
 ;;=^5004154
 ;;^UTILITY(U,$J,358.3,1278,0)
 ;;=G89.29^^6^106^18
 ;;^UTILITY(U,$J,358.3,1278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1278,1,3,0)
 ;;=3^Pain,Chronic,Other
 ;;^UTILITY(U,$J,358.3,1278,1,4,0)
 ;;=4^G89.29
 ;;^UTILITY(U,$J,358.3,1278,2)
 ;;=^5004158
 ;;^UTILITY(U,$J,358.3,1279,0)
 ;;=G89.21^^6^106^17
 ;;^UTILITY(U,$J,358.3,1279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1279,1,3,0)
 ;;=3^Pain,Chronic d/t Trauma
 ;;^UTILITY(U,$J,358.3,1279,1,4,0)
 ;;=4^G89.21
 ;;^UTILITY(U,$J,358.3,1279,2)
 ;;=^5004155
 ;;^UTILITY(U,$J,358.3,1280,0)
 ;;=G89.22^^6^106^19
 ;;^UTILITY(U,$J,358.3,1280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1280,1,3,0)
 ;;=3^Pain,Chronic,Post-Thoracotomy
 ;;^UTILITY(U,$J,358.3,1280,1,4,0)
 ;;=4^G89.22
 ;;^UTILITY(U,$J,358.3,1280,2)
 ;;=^5004156
 ;;^UTILITY(U,$J,358.3,1281,0)
 ;;=G89.28^^6^106^16
 ;;^UTILITY(U,$J,358.3,1281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1281,1,3,0)
 ;;=3^Pain,Chronic Postprocedural Pain
 ;;^UTILITY(U,$J,358.3,1281,1,4,0)
 ;;=4^G89.28
 ;;^UTILITY(U,$J,358.3,1281,2)
 ;;=^5004157
 ;;^UTILITY(U,$J,358.3,1282,0)
 ;;=J31.0^^6^107^15
 ;;^UTILITY(U,$J,358.3,1282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1282,1,3,0)
 ;;=3^Rhinitis,Chronic
 ;;^UTILITY(U,$J,358.3,1282,1,4,0)
 ;;=4^J31.0
 ;;^UTILITY(U,$J,358.3,1282,2)
 ;;=^24434
 ;;^UTILITY(U,$J,358.3,1283,0)
 ;;=M06.9^^6^107^14
 ;;^UTILITY(U,$J,358.3,1283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1283,1,3,0)
 ;;=3^Rheumatoid Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,1283,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,1283,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,1284,0)
 ;;=M54.10^^6^107^1
 ;;^UTILITY(U,$J,358.3,1284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1284,1,3,0)
 ;;=3^Radiculopathy,Site Unspec
 ;;^UTILITY(U,$J,358.3,1284,1,4,0)
 ;;=4^M54.10
 ;;^UTILITY(U,$J,358.3,1284,2)
 ;;=^5012295
 ;;^UTILITY(U,$J,358.3,1285,0)
 ;;=R21.^^6^107^2
 ;;^UTILITY(U,$J,358.3,1285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1285,1,3,0)
 ;;=3^Rash & Oth Nonspecific Skin Eruption
 ;;^UTILITY(U,$J,358.3,1285,1,4,0)
 ;;=4^R21.
 ;;^UTILITY(U,$J,358.3,1285,2)
 ;;=^5019283
 ;;^UTILITY(U,$J,358.3,1286,0)
 ;;=J96.90^^6^107^13
 ;;^UTILITY(U,$J,358.3,1286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1286,1,3,0)
 ;;=3^Resp Failure,Unspec whether w/ Hypoxia or Hypercapnia
 ;;^UTILITY(U,$J,358.3,1286,1,4,0)
 ;;=4^J96.90
 ;;^UTILITY(U,$J,358.3,1286,2)
 ;;=^5008356
 ;;^UTILITY(U,$J,358.3,1287,0)
 ;;=J96.92^^6^107^11
 ;;^UTILITY(U,$J,358.3,1287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1287,1,3,0)
 ;;=3^Resp Failure,Unspec w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,1287,1,4,0)
 ;;=4^J96.92
 ;;^UTILITY(U,$J,358.3,1287,2)
 ;;=^5008358
 ;;^UTILITY(U,$J,358.3,1288,0)
 ;;=J96.91^^6^107^12
 ;;^UTILITY(U,$J,358.3,1288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1288,1,3,0)
 ;;=3^Resp Failure,Unspec w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,1288,1,4,0)
 ;;=4^J96.91
 ;;^UTILITY(U,$J,358.3,1288,2)
 ;;=^5008357
 ;;^UTILITY(U,$J,358.3,1289,0)
 ;;=J96.00^^6^107^7
 ;;^UTILITY(U,$J,358.3,1289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1289,1,3,0)
 ;;=3^Resp Failure,Acute,Unspec w/ Hypoxia or Hypercapnia
 ;;^UTILITY(U,$J,358.3,1289,1,4,0)
 ;;=4^J96.00
 ;;^UTILITY(U,$J,358.3,1289,2)
 ;;=^5008347
 ;;^UTILITY(U,$J,358.3,1290,0)
 ;;=J96.02^^6^107^5
 ;;^UTILITY(U,$J,358.3,1290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1290,1,3,0)
 ;;=3^Resp Failure,Acute w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,1290,1,4,0)
 ;;=4^J96.02
 ;;^UTILITY(U,$J,358.3,1290,2)
 ;;=^5008349
 ;;^UTILITY(U,$J,358.3,1291,0)
 ;;=J96.01^^6^107^6
 ;;^UTILITY(U,$J,358.3,1291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1291,1,3,0)
 ;;=3^Resp Failure,Acute w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,1291,1,4,0)
 ;;=4^J96.01
 ;;^UTILITY(U,$J,358.3,1291,2)
 ;;=^5008348
 ;;^UTILITY(U,$J,358.3,1292,0)
 ;;=J96.22^^6^107^3
 ;;^UTILITY(U,$J,358.3,1292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1292,1,3,0)
 ;;=3^Resp Failure,Acute & Chronic w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,1292,1,4,0)
 ;;=4^J96.22
 ;;^UTILITY(U,$J,358.3,1292,2)
 ;;=^5008355
 ;;^UTILITY(U,$J,358.3,1293,0)
 ;;=J96.21^^6^107^4
 ;;^UTILITY(U,$J,358.3,1293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1293,1,3,0)
 ;;=3^Resp Failure,Acute & Chronic w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,1293,1,4,0)
 ;;=4^J96.21
 ;;^UTILITY(U,$J,358.3,1293,2)
 ;;=^5008354
 ;;^UTILITY(U,$J,358.3,1294,0)
 ;;=J96.10^^6^107^10
 ;;^UTILITY(U,$J,358.3,1294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1294,1,3,0)
 ;;=3^Resp Failure,Chronic,Unspec w/ Hypoxia or Hypercapnia
 ;;^UTILITY(U,$J,358.3,1294,1,4,0)
 ;;=4^J96.10
 ;;^UTILITY(U,$J,358.3,1294,2)
 ;;=^5008350
 ;;^UTILITY(U,$J,358.3,1295,0)
 ;;=J96.12^^6^107^8
 ;;^UTILITY(U,$J,358.3,1295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1295,1,3,0)
 ;;=3^Resp Failure,Chronic w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,1295,1,4,0)
 ;;=4^J96.12
 ;;^UTILITY(U,$J,358.3,1295,2)
 ;;=^5008352
 ;;^UTILITY(U,$J,358.3,1296,0)
 ;;=J96.11^^6^107^9
 ;;^UTILITY(U,$J,358.3,1296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1296,1,3,0)
 ;;=3^Resp Failure,Chronic w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,1296,1,4,0)
 ;;=4^J96.11
 ;;^UTILITY(U,$J,358.3,1296,2)
 ;;=^5008351
 ;;^UTILITY(U,$J,358.3,1297,0)
 ;;=S23.9XXA^^6^108^18
 ;;^UTILITY(U,$J,358.3,1297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1297,1,3,0)
 ;;=3^Sprain Thorax,Unspec Part,Initial Encounter
 ;;^UTILITY(U,$J,358.3,1297,1,4,0)
 ;;=4^S23.9XXA
 ;;^UTILITY(U,$J,358.3,1297,2)
 ;;=^5023267
 ;;^UTILITY(U,$J,358.3,1298,0)
 ;;=I69.928^^6^108^13
 ;;^UTILITY(U,$J,358.3,1298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1298,1,3,0)
 ;;=3^Speech/Lang Deficits Following Unspec Cerebrovascular Disease
 ;;^UTILITY(U,$J,358.3,1298,1,4,0)
 ;;=4^I69.928
 ;;^UTILITY(U,$J,358.3,1298,2)
 ;;=^5007557
 ;;^UTILITY(U,$J,358.3,1299,0)
 ;;=S13.4XXA^^6^108^17
 ;;^UTILITY(U,$J,358.3,1299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1299,1,3,0)
 ;;=3^Sprain Ligaments Cervical Spine,Initial Encounter
 ;;^UTILITY(U,$J,358.3,1299,1,4,0)
 ;;=4^S13.4XXA
 ;;^UTILITY(U,$J,358.3,1299,2)
 ;;=^5022028
 ;;^UTILITY(U,$J,358.3,1300,0)
 ;;=M15.3^^6^108^5
 ;;^UTILITY(U,$J,358.3,1300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1300,1,3,0)
 ;;=3^Secondary Multiple Arthritis
 ;;^UTILITY(U,$J,358.3,1300,1,4,0)
 ;;=4^M15.3
 ;;^UTILITY(U,$J,358.3,1300,2)
 ;;=^5010765
 ;;^UTILITY(U,$J,358.3,1301,0)
 ;;=L08.9^^6^108^9
 ;;^UTILITY(U,$J,358.3,1301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1301,1,3,0)
 ;;=3^Skin Infection,Unspec
 ;;^UTILITY(U,$J,358.3,1301,1,4,0)
 ;;=4^L08.9
 ;;^UTILITY(U,$J,358.3,1301,2)
 ;;=^5009082
 ;;^UTILITY(U,$J,358.3,1302,0)
 ;;=L98.9^^6^108^10
 ;;^UTILITY(U,$J,358.3,1302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1302,1,3,0)
 ;;=3^Skin/Subcutaneous Tissue Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,1302,1,4,0)
 ;;=4^L98.9
 ;;^UTILITY(U,$J,358.3,1302,2)
 ;;=^5009595
 ;;^UTILITY(U,$J,358.3,1303,0)
 ;;=M48.06^^6^108^14
 ;;^UTILITY(U,$J,358.3,1303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1303,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region
 ;;^UTILITY(U,$J,358.3,1303,1,4,0)
 ;;=4^M48.06
 ;;^UTILITY(U,$J,358.3,1303,2)
 ;;=^5012093
 ;;^UTILITY(U,$J,358.3,1304,0)
 ;;=R22.2^^6^108^19
 ;;^UTILITY(U,$J,358.3,1304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1304,1,3,0)
 ;;=3^Swelling,Mass & Lump,Trunk
 ;;^UTILITY(U,$J,358.3,1304,1,4,0)
 ;;=4^R22.2
 ;;^UTILITY(U,$J,358.3,1304,2)
 ;;=^5019286
 ;;^UTILITY(U,$J,358.3,1305,0)
 ;;=M54.31^^6^108^3
 ;;^UTILITY(U,$J,358.3,1305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1305,1,3,0)
 ;;=3^Sciatica,Right Side
 ;;^UTILITY(U,$J,358.3,1305,1,4,0)
 ;;=4^M54.31
 ;;^UTILITY(U,$J,358.3,1305,2)
 ;;=^5012306
 ;;^UTILITY(U,$J,358.3,1306,0)
 ;;=M54.32^^6^108^2
 ;;^UTILITY(U,$J,358.3,1306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1306,1,3,0)
 ;;=3^Sciatica,Left Side
 ;;^UTILITY(U,$J,358.3,1306,1,4,0)
 ;;=4^M54.32
 ;;^UTILITY(U,$J,358.3,1306,2)
 ;;=^5012307
 ;;^UTILITY(U,$J,358.3,1307,0)
 ;;=F20.5^^6^108^1
 ;;^UTILITY(U,$J,358.3,1307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1307,1,3,0)
 ;;=3^Schizophrenia,Residual
 ;;^UTILITY(U,$J,358.3,1307,1,4,0)
 ;;=4^F20.5
 ;;^UTILITY(U,$J,358.3,1307,2)
 ;;=^5003473
 ;;^UTILITY(U,$J,358.3,1308,0)
 ;;=J01.90^^6^108^7
 ;;^UTILITY(U,$J,358.3,1308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1308,1,3,0)
 ;;=3^Sinusitis Acute,Unspec
 ;;^UTILITY(U,$J,358.3,1308,1,4,0)
 ;;=4^J01.90
 ;;^UTILITY(U,$J,358.3,1308,2)
 ;;=^5008127
 ;;^UTILITY(U,$J,358.3,1309,0)
 ;;=J32.9^^6^108^8
 ;;^UTILITY(U,$J,358.3,1309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1309,1,3,0)
 ;;=3^Sinusitis,Chronic Unspec
 ;;^UTILITY(U,$J,358.3,1309,1,4,0)
 ;;=4^J32.9
 ;;^UTILITY(U,$J,358.3,1309,2)
 ;;=^5008207
