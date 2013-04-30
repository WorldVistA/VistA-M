IBDEI01C ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1161,1,3,0)
 ;;=3^ICD Device Progr Eval,Multi
 ;;^UTILITY(U,$J,358.3,1162,0)
 ;;=93281^^17^89^32^^^^1
 ;;^UTILITY(U,$J,358.3,1162,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1162,1,2,0)
 ;;=2^93281
 ;;^UTILITY(U,$J,358.3,1162,1,3,0)
 ;;=3^PM Device Progr Eval,Multi
 ;;^UTILITY(U,$J,358.3,1163,0)
 ;;=33227^^17^89^13^^^^1
 ;;^UTILITY(U,$J,358.3,1163,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1163,1,2,0)
 ;;=2^33227
 ;;^UTILITY(U,$J,358.3,1163,1,3,0)
 ;;=3^Remove PM Pulse Gen w/Replc PM Gen,Single
 ;;^UTILITY(U,$J,358.3,1164,0)
 ;;=33228^^17^89^14^^^^1
 ;;^UTILITY(U,$J,358.3,1164,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1164,1,2,0)
 ;;=2^33228
 ;;^UTILITY(U,$J,358.3,1164,1,3,0)
 ;;=3^Remove PM Pulse Gen w/Replc PM Gen,Dual
 ;;^UTILITY(U,$J,358.3,1165,0)
 ;;=33229^^17^89^15^^^^1
 ;;^UTILITY(U,$J,358.3,1165,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1165,1,2,0)
 ;;=2^33229
 ;;^UTILITY(U,$J,358.3,1165,1,3,0)
 ;;=3^Remove PM Pulse Gen w/Replc PM Gen,Mult
 ;;^UTILITY(U,$J,358.3,1166,0)
 ;;=33230^^17^89^16^^^^1
 ;;^UTILITY(U,$J,358.3,1166,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1166,1,2,0)
 ;;=2^33230
 ;;^UTILITY(U,$J,358.3,1166,1,3,0)
 ;;=3^Insert ICD Gen Only,Existing Single
 ;;^UTILITY(U,$J,358.3,1167,0)
 ;;=33231^^17^89^17^^^^1
 ;;^UTILITY(U,$J,358.3,1167,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1167,1,2,0)
 ;;=2^33231
 ;;^UTILITY(U,$J,358.3,1167,1,3,0)
 ;;=3^Insert ICD Gen Only,Existing Mult
 ;;^UTILITY(U,$J,358.3,1168,0)
 ;;=33233^^17^89^19^^^^1
 ;;^UTILITY(U,$J,358.3,1168,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1168,1,2,0)
 ;;=2^33233
 ;;^UTILITY(U,$J,358.3,1168,1,3,0)
 ;;=3^Removal of PM Generator Only
 ;;^UTILITY(U,$J,358.3,1169,0)
 ;;=33262^^17^89^26^^^^1
 ;;^UTILITY(U,$J,358.3,1169,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1169,1,2,0)
 ;;=2^33262
 ;;^UTILITY(U,$J,358.3,1169,1,3,0)
 ;;=3^Remv ICD Gen w/Replc PM Gen,Single
 ;;^UTILITY(U,$J,358.3,1170,0)
 ;;=33263^^17^89^27^^^^1
 ;;^UTILITY(U,$J,358.3,1170,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1170,1,2,0)
 ;;=2^33263
 ;;^UTILITY(U,$J,358.3,1170,1,3,0)
 ;;=3^Remv ICD Gen w/Replc PM Gen,Dual
 ;;^UTILITY(U,$J,358.3,1171,0)
 ;;=33264^^17^89^28^^^^1
 ;;^UTILITY(U,$J,358.3,1171,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1171,1,2,0)
 ;;=2^33264
 ;;^UTILITY(U,$J,358.3,1171,1,3,0)
 ;;=3^Remv ICD Gen w/Replc PM Gen,Multiple
 ;;^UTILITY(U,$J,358.3,1172,0)
 ;;=93286^^17^89^37^^^^1
 ;;^UTILITY(U,$J,358.3,1172,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1172,1,2,0)
 ;;=2^93286
 ;;^UTILITY(U,$J,358.3,1172,1,3,0)
 ;;=3^Pre-Op PM Device Eval w/Review&Rpt
 ;;^UTILITY(U,$J,358.3,1173,0)
 ;;=93287^^17^89^38^^^^1
 ;;^UTILITY(U,$J,358.3,1173,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1173,1,2,0)
 ;;=2^93287
 ;;^UTILITY(U,$J,358.3,1173,1,3,0)
 ;;=3^Pre-Op ICD Device Eval
 ;;^UTILITY(U,$J,358.3,1174,0)
 ;;=93290^^17^89^41^^^^1
 ;;^UTILITY(U,$J,358.3,1174,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1174,1,2,0)
 ;;=2^93290
 ;;^UTILITY(U,$J,358.3,1174,1,3,0)
 ;;=3^ICM Device Eval
 ;;^UTILITY(U,$J,358.3,1175,0)
 ;;=93293^^17^89^44^^^^1
 ;;^UTILITY(U,$J,358.3,1175,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1175,1,2,0)
 ;;=2^93293
 ;;^UTILITY(U,$J,358.3,1175,1,3,0)
 ;;=3^PM Phone R-Strip Device Eval
 ;;^UTILITY(U,$J,358.3,1176,0)
 ;;=92992^^17^90^1^^^^1
 ;;^UTILITY(U,$J,358.3,1176,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1176,1,2,0)
 ;;=2^92992
 ;;^UTILITY(U,$J,358.3,1176,1,3,0)
 ;;=3^Atrial Septectomy Trans Balloon (Inc Cath)
 ;;^UTILITY(U,$J,358.3,1177,0)
 ;;=92993^^17^90^22^^^^1
 ;;^UTILITY(U,$J,358.3,1177,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1177,1,2,0)
 ;;=2^92993
 ;;^UTILITY(U,$J,358.3,1177,1,3,0)
 ;;=3^Park Septostomy,Includes Cath
 ;;^UTILITY(U,$J,358.3,1178,0)
 ;;=92975^^17^90^24^^^^1
 ;;^UTILITY(U,$J,358.3,1178,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1178,1,2,0)
 ;;=2^92975
 ;;^UTILITY(U,$J,358.3,1178,1,3,0)
 ;;=3^Thrombo Cor Includes Cor Angiog
 ;;^UTILITY(U,$J,358.3,1179,0)
 ;;=92977^^17^90^25^^^^1
 ;;^UTILITY(U,$J,358.3,1179,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1179,1,2,0)
 ;;=2^92977
 ;;^UTILITY(U,$J,358.3,1179,1,3,0)
 ;;=3^Thrombo Cor,Inc Cor Angio Iv Inf
 ;;^UTILITY(U,$J,358.3,1180,0)
 ;;=92978^^17^90^7^^^^1
 ;;^UTILITY(U,$J,358.3,1180,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1180,1,2,0)
 ;;=2^92978
 ;;^UTILITY(U,$J,358.3,1180,1,3,0)
 ;;=3^Intr Vasc U/S During Diag Eval
 ;;^UTILITY(U,$J,358.3,1181,0)
 ;;=92979^^17^90^8^^^^1
 ;;^UTILITY(U,$J,358.3,1181,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1181,1,2,0)
 ;;=2^92979
 ;;^UTILITY(U,$J,358.3,1181,1,3,0)
 ;;=3^     Each Add'L Vessel (W/92978)
 ;;^UTILITY(U,$J,358.3,1182,0)
 ;;=36010^^17^90^5^^^^1
 ;;^UTILITY(U,$J,358.3,1182,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1182,1,2,0)
 ;;=2^36010
 ;;^UTILITY(U,$J,358.3,1182,1,3,0)
 ;;=3^Cath Place Svc/Ivc (Sheath)
 ;;^UTILITY(U,$J,358.3,1183,0)
 ;;=36011^^17^90^6^^^^1
 ;;^UTILITY(U,$J,358.3,1183,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1183,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,1183,1,3,0)
 ;;=3^Cath Place Vein 1St Order(Sheath
 ;;^UTILITY(U,$J,358.3,1184,0)
 ;;=92970^^17^90^3^^^^1
 ;;^UTILITY(U,$J,358.3,1184,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1184,1,2,0)
 ;;=2^92970
 ;;^UTILITY(U,$J,358.3,1184,1,3,0)
 ;;=3^Cardio Assist Dev Insert
 ;;^UTILITY(U,$J,358.3,1185,0)
 ;;=76930^^17^90^26^^^^1
 ;;^UTILITY(U,$J,358.3,1185,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1185,1,2,0)
 ;;=2^76930
 ;;^UTILITY(U,$J,358.3,1185,1,3,0)
 ;;=3^U/S Guide (W/33010)
 ;;^UTILITY(U,$J,358.3,1186,0)
 ;;=76000^^17^90^2^^^^1
 ;;^UTILITY(U,$J,358.3,1186,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1186,1,2,0)
 ;;=2^76000
 ;;^UTILITY(U,$J,358.3,1186,1,3,0)
 ;;=3^Cardiac Fluoro<1Hr(No Cath Proc)
 ;;^UTILITY(U,$J,358.3,1187,0)
 ;;=92973^^17^90^23^^^^1
 ;;^UTILITY(U,$J,358.3,1187,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1187,1,2,0)
 ;;=2^92973
 ;;^UTILITY(U,$J,358.3,1187,1,3,0)
 ;;=3^Perc Coronary Thrombectomy Mechanical
 ;;^UTILITY(U,$J,358.3,1188,0)
 ;;=92974^^17^90^4^^^^1
 ;;^UTILITY(U,$J,358.3,1188,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1188,1,2,0)
 ;;=2^92974
 ;;^UTILITY(U,$J,358.3,1188,1,3,0)
 ;;=3^Cath Place Cardio Brachytx
 ;;^UTILITY(U,$J,358.3,1189,0)
 ;;=92920^^17^90^18^^^^1
 ;;^UTILITY(U,$J,358.3,1189,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1189,1,2,0)
 ;;=2^92920
 ;;^UTILITY(U,$J,358.3,1189,1,3,0)
 ;;=3^PRQ Cardia Angioplast 1 Art
 ;;^UTILITY(U,$J,358.3,1190,0)
 ;;=92921^^17^90^19^^^^1
 ;;^UTILITY(U,$J,358.3,1190,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1190,1,2,0)
 ;;=2^92921
 ;;^UTILITY(U,$J,358.3,1190,1,3,0)
 ;;=3^PRQ Cardiac Angio Addl Art
 ;;^UTILITY(U,$J,358.3,1191,0)
 ;;=92924^^17^90^9^^^^1
 ;;^UTILITY(U,$J,358.3,1191,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1191,1,2,0)
 ;;=2^92924
 ;;^UTILITY(U,$J,358.3,1191,1,3,0)
 ;;=3^PRQ Card Angio/Athrect 1 Art
 ;;^UTILITY(U,$J,358.3,1192,0)
 ;;=92925^^17^90^10^^^^1
 ;;^UTILITY(U,$J,358.3,1192,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1192,1,2,0)
 ;;=2^92925
 ;;^UTILITY(U,$J,358.3,1192,1,3,0)
 ;;=3^PRQ Card Angio/Athrect Addl Art
 ;;^UTILITY(U,$J,358.3,1193,0)
 ;;=92928^^17^90^16^^^^1
 ;;^UTILITY(U,$J,358.3,1193,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1193,1,2,0)
 ;;=2^92928
 ;;^UTILITY(U,$J,358.3,1193,1,3,0)
 ;;=3^PRQ Card Stent w/ Angio 1 Vsl
 ;;^UTILITY(U,$J,358.3,1194,0)
 ;;=92929^^17^90^17^^^^1
 ;;^UTILITY(U,$J,358.3,1194,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1194,1,2,0)
 ;;=2^92929
 ;;^UTILITY(U,$J,358.3,1194,1,3,0)
 ;;=3^PRQ Card Stent w/ Angio Addl Vsl
 ;;^UTILITY(U,$J,358.3,1195,0)
 ;;=92933^^17^90^14^^^^1
 ;;^UTILITY(U,$J,358.3,1195,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1195,1,2,0)
 ;;=2^92933
 ;;^UTILITY(U,$J,358.3,1195,1,3,0)
 ;;=3^PRQ Card Stent Ath/Angio
 ;;^UTILITY(U,$J,358.3,1196,0)
 ;;=92934^^17^90^15^^^^1
 ;;^UTILITY(U,$J,358.3,1196,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1196,1,2,0)
 ;;=2^92934
 ;;^UTILITY(U,$J,358.3,1196,1,3,0)
 ;;=3^PRQ Card Stent Ath/Angio Ea Addl Branch
 ;;^UTILITY(U,$J,358.3,1197,0)
 ;;=92937^^17^90^20^^^^1
 ;;^UTILITY(U,$J,358.3,1197,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1197,1,2,0)
 ;;=2^92937
 ;;^UTILITY(U,$J,358.3,1197,1,3,0)
 ;;=3^PRQ Revasc Byp Graft 1 Vsl
 ;;^UTILITY(U,$J,358.3,1198,0)
 ;;=92938^^17^90^21^^^^1
 ;;^UTILITY(U,$J,358.3,1198,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1198,1,2,0)
 ;;=2^92938
 ;;^UTILITY(U,$J,358.3,1198,1,3,0)
 ;;=3^PRQ Revasc Byp Graft Addl Vsl
 ;;^UTILITY(U,$J,358.3,1199,0)
 ;;=92941^^17^90^13^^^^1
 ;;^UTILITY(U,$J,358.3,1199,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1199,1,2,0)
 ;;=2^92941
 ;;^UTILITY(U,$J,358.3,1199,1,3,0)
 ;;=3^PRQ Card Revasc MI 1 Vsl
 ;;^UTILITY(U,$J,358.3,1200,0)
 ;;=92943^^17^90^11^^^^1
 ;;^UTILITY(U,$J,358.3,1200,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1200,1,2,0)
 ;;=2^92943
 ;;^UTILITY(U,$J,358.3,1200,1,3,0)
 ;;=3^PRQ Card Revasc Chronic 1 Vsl
 ;;^UTILITY(U,$J,358.3,1201,0)
 ;;=92944^^17^90^12^^^^1
 ;;^UTILITY(U,$J,358.3,1201,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1201,1,2,0)
 ;;=2^92944
 ;;^UTILITY(U,$J,358.3,1201,1,3,0)
 ;;=3^PRQ Card Revasc Chronic Addl Vsl
 ;;^UTILITY(U,$J,358.3,1202,0)
 ;;=93600^^17^91^3^^^^1
 ;;^UTILITY(U,$J,358.3,1202,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1202,1,2,0)
 ;;=2^93600
 ;;^UTILITY(U,$J,358.3,1202,1,3,0)
 ;;=3^Bundle Of His Record
 ;;^UTILITY(U,$J,358.3,1203,0)
 ;;=93602^^17^91^19^^^^1
 ;;^UTILITY(U,$J,358.3,1203,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1203,1,2,0)
 ;;=2^93602
 ;;^UTILITY(U,$J,358.3,1203,1,3,0)
 ;;=3^Intra-Atrial Record
 ;;^UTILITY(U,$J,358.3,1204,0)
 ;;=93603^^17^91^22^^^^1
 ;;^UTILITY(U,$J,358.3,1204,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1204,1,2,0)
 ;;=2^93603
 ;;^UTILITY(U,$J,358.3,1204,1,3,0)
 ;;=3^R Vent Record
 ;;^UTILITY(U,$J,358.3,1205,0)
 ;;=93609^^17^91^21^^^^1
