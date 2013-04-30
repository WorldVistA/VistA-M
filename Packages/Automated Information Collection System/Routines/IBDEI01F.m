IBDEI01F ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1293,0)
 ;;=93459^^17^95^9^^^^1
 ;;^UTILITY(U,$J,358.3,1293,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1293,1,2,0)
 ;;=2^93459
 ;;^UTILITY(U,$J,358.3,1293,1,3,0)
 ;;=3^Lt Hrt Angio,V-Gram,Bypass,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1294,0)
 ;;=93460^^17^95^10^^^^1
 ;;^UTILITY(U,$J,358.3,1294,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1294,1,2,0)
 ;;=2^93460
 ;;^UTILITY(U,$J,358.3,1294,1,3,0)
 ;;=3^Cor Angio, RHC/LHC, V-Gram, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1295,0)
 ;;=93461^^17^95^11^^^^1
 ;;^UTILITY(U,$J,358.3,1295,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1295,1,2,0)
 ;;=2^93461
 ;;^UTILITY(U,$J,358.3,1295,1,3,0)
 ;;=3^R&L Hrt Angio,V-Gram,Bypass,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1296,0)
 ;;=93462^^17^95^12^^^^1
 ;;^UTILITY(U,$J,358.3,1296,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1296,1,2,0)
 ;;=2^93462
 ;;^UTILITY(U,$J,358.3,1296,1,3,0)
 ;;=3^Lt Hrt Cath Trnsptl Puncture
 ;;^UTILITY(U,$J,358.3,1297,0)
 ;;=93561^^17^95^16^^^^1
 ;;^UTILITY(U,$J,358.3,1297,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1297,1,2,0)
 ;;=2^93561
 ;;^UTILITY(U,$J,358.3,1297,1,3,0)
 ;;=3^Indicator Dilution Study-Arterial/Ven
 ;;^UTILITY(U,$J,358.3,1298,0)
 ;;=93562^^17^95^17^^^^1
 ;;^UTILITY(U,$J,358.3,1298,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1298,1,2,0)
 ;;=2^93562
 ;;^UTILITY(U,$J,358.3,1298,1,3,0)
 ;;=3^Subsq Measure of Cardiac Output
 ;;^UTILITY(U,$J,358.3,1299,0)
 ;;=93463^^17^95^13^^^^1
 ;;^UTILITY(U,$J,358.3,1299,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1299,1,2,0)
 ;;=2^93463
 ;;^UTILITY(U,$J,358.3,1299,1,3,0)
 ;;=3^Pharm agent admin, when performed
 ;;^UTILITY(U,$J,358.3,1300,0)
 ;;=93505^^17^95^15^^^^1
 ;;^UTILITY(U,$J,358.3,1300,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1300,1,2,0)
 ;;=2^93505
 ;;^UTILITY(U,$J,358.3,1300,1,3,0)
 ;;=3^Endomyocardial Biopsy
 ;;^UTILITY(U,$J,358.3,1301,0)
 ;;=36100^^17^96^10^^^^1
 ;;^UTILITY(U,$J,358.3,1301,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1301,1,2,0)
 ;;=2^36100
 ;;^UTILITY(U,$J,358.3,1301,1,3,0)
 ;;=3^Intro Needle Or Cath Carotid Or Vert. Artery
 ;;^UTILITY(U,$J,358.3,1302,0)
 ;;=36120^^17^96^9^^^^1
 ;;^UTILITY(U,$J,358.3,1302,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1302,1,2,0)
 ;;=2^36120
 ;;^UTILITY(U,$J,358.3,1302,1,3,0)
 ;;=3^Intro Needle Or Cath Brachial Artery
 ;;^UTILITY(U,$J,358.3,1303,0)
 ;;=36140^^17^96^11^^^^1
 ;;^UTILITY(U,$J,358.3,1303,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1303,1,2,0)
 ;;=2^36140
 ;;^UTILITY(U,$J,358.3,1303,1,3,0)
 ;;=3^Intro Needle Or Cath Ext Artery
 ;;^UTILITY(U,$J,358.3,1304,0)
 ;;=36215^^17^96^31^^^^1
 ;;^UTILITY(U,$J,358.3,1304,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1304,1,2,0)
 ;;=2^36215
 ;;^UTILITY(U,$J,358.3,1304,1,3,0)
 ;;=3^Select Cath Arterial 1St Order Thor/Brachiocephalic
 ;;^UTILITY(U,$J,358.3,1305,0)
 ;;=36011^^17^96^32^^^^1
 ;;^UTILITY(U,$J,358.3,1305,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1305,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,1305,1,3,0)
 ;;=3^Select Cath Venous 1St Order (Renal Jug)
 ;;^UTILITY(U,$J,358.3,1306,0)
 ;;=36245^^17^96^24^^^^1
 ;;^UTILITY(U,$J,358.3,1306,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1306,1,2,0)
 ;;=2^36245
 ;;^UTILITY(U,$J,358.3,1306,1,3,0)
 ;;=3^Select Cath 1St Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,1307,0)
 ;;=36246^^17^96^27^^^^1
 ;;^UTILITY(U,$J,358.3,1307,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1307,1,2,0)
 ;;=2^36246
 ;;^UTILITY(U,$J,358.3,1307,1,3,0)
 ;;=3^Select Cath 2Nd Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,1308,0)
 ;;=36247^^17^96^29^^^^1
 ;;^UTILITY(U,$J,358.3,1308,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1308,1,2,0)
 ;;=2^36247
 ;;^UTILITY(U,$J,358.3,1308,1,3,0)
 ;;=3^Select Cath 3Rd Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,1309,0)
 ;;=36216^^17^96^28^^^^1
 ;;^UTILITY(U,$J,358.3,1309,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1309,1,2,0)
 ;;=2^36216
 ;;^UTILITY(U,$J,358.3,1309,1,3,0)
 ;;=3^Select Cath 2Nd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,1310,0)
 ;;=36217^^17^96^30^^^^1
 ;;^UTILITY(U,$J,358.3,1310,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1310,1,2,0)
 ;;=2^36217
 ;;^UTILITY(U,$J,358.3,1310,1,3,0)
 ;;=3^Select Cath 3Rd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,1311,0)
 ;;=36218^^17^96^4^^^^1
 ;;^UTILITY(U,$J,358.3,1311,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1311,1,2,0)
 ;;=2^36218
 ;;^UTILITY(U,$J,358.3,1311,1,3,0)
 ;;=3^Each Addl 2Nd/3Rd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,1312,0)
 ;;=36248^^17^96^3^^^^1
 ;;^UTILITY(U,$J,358.3,1312,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1312,1,2,0)
 ;;=2^36248
 ;;^UTILITY(U,$J,358.3,1312,1,3,0)
 ;;=3^Each Addl 2Nd/3Rd Order Pelvic/Le
 ;;^UTILITY(U,$J,358.3,1313,0)
 ;;=36200^^17^96^12^^^^1
 ;;^UTILITY(U,$J,358.3,1313,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1313,1,2,0)
 ;;=2^36200
 ;;^UTILITY(U,$J,358.3,1313,1,3,0)
 ;;=3^Non-Select Cath, Aorta
 ;;^UTILITY(U,$J,358.3,1314,0)
 ;;=33010^^17^96^34^^^^1
 ;;^UTILITY(U,$J,358.3,1314,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1314,1,2,0)
 ;;=2^33010
 ;;^UTILITY(U,$J,358.3,1314,1,3,0)
 ;;=3^Visceral Selective
 ;;^UTILITY(U,$J,358.3,1315,0)
 ;;=35471^^17^96^23^^^^1
 ;;^UTILITY(U,$J,358.3,1315,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1315,1,2,0)
 ;;=2^35471
 ;;^UTILITY(U,$J,358.3,1315,1,3,0)
 ;;=3^Repair Arterial Blockage
 ;;^UTILITY(U,$J,358.3,1316,0)
 ;;=35475^^17^96^13^^^^1
 ;;^UTILITY(U,$J,358.3,1316,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1316,1,2,0)
 ;;=2^35475
 ;;^UTILITY(U,$J,358.3,1316,1,3,0)
 ;;=3^Pelvic Selective
 ;;^UTILITY(U,$J,358.3,1317,0)
 ;;=36005^^17^96^5^^^^1
 ;;^UTILITY(U,$J,358.3,1317,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1317,1,2,0)
 ;;=2^36005
 ;;^UTILITY(U,$J,358.3,1317,1,3,0)
 ;;=3^Injection Ext Venography
 ;;^UTILITY(U,$J,358.3,1318,0)
 ;;=36147^^17^96^1^^^^1
 ;;^UTILITY(U,$J,358.3,1318,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1318,1,2,0)
 ;;=2^36147
 ;;^UTILITY(U,$J,358.3,1318,1,3,0)
 ;;=3^Access AV Dial Grft for Eval
 ;;^UTILITY(U,$J,358.3,1319,0)
 ;;=36148^^17^96^2^^^^1
 ;;^UTILITY(U,$J,358.3,1319,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1319,1,2,0)
 ;;=2^36148
 ;;^UTILITY(U,$J,358.3,1319,1,3,0)
 ;;=3^Access AV Dial Grft for Eval,Ea Addl
 ;;^UTILITY(U,$J,358.3,1320,0)
 ;;=36251^^17^96^25^^^^1
 ;;^UTILITY(U,$J,358.3,1320,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1320,1,2,0)
 ;;=2^36251
 ;;^UTILITY(U,$J,358.3,1320,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Acc Art
 ;;^UTILITY(U,$J,358.3,1321,0)
 ;;=36252^^17^96^26^^^^1
 ;;^UTILITY(U,$J,358.3,1321,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1321,1,2,0)
 ;;=2^36252
 ;;^UTILITY(U,$J,358.3,1321,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Acc Art Bilat
 ;;^UTILITY(U,$J,358.3,1322,0)
 ;;=36254^^17^96^6^^^^1
 ;;^UTILITY(U,$J,358.3,1322,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1322,1,2,0)
 ;;=2^36254
 ;;^UTILITY(U,$J,358.3,1322,1,3,0)
 ;;=3^Ins Cath Ren Art 2nd+ Bilat
 ;;^UTILITY(U,$J,358.3,1323,0)
 ;;=36253^^17^96^7^^^^1
 ;;^UTILITY(U,$J,358.3,1323,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1323,1,2,0)
 ;;=2^36253
 ;;^UTILITY(U,$J,358.3,1323,1,3,0)
 ;;=3^Ins Cath Ren Art 2nd+ Unilat
 ;;^UTILITY(U,$J,358.3,1324,0)
 ;;=37191^^17^96^8^^^^1
 ;;^UTILITY(U,$J,358.3,1324,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1324,1,2,0)
 ;;=2^37191
 ;;^UTILITY(U,$J,358.3,1324,1,3,0)
 ;;=3^Ins Intravas Vena Cava Filter,Endovas
 ;;^UTILITY(U,$J,358.3,1325,0)
 ;;=37205^^17^96^33^^^^1
 ;;^UTILITY(U,$J,358.3,1325,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1325,1,2,0)
 ;;=2^37205
 ;;^UTILITY(U,$J,358.3,1325,1,3,0)
 ;;=3^Transcath Plcmt of Intravas Stent
 ;;^UTILITY(U,$J,358.3,1326,0)
 ;;=36221^^17^96^19^^^^1
 ;;^UTILITY(U,$J,358.3,1326,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1326,1,2,0)
 ;;=2^36221
 ;;^UTILITY(U,$J,358.3,1326,1,3,0)
 ;;=3^Place Cath Thoracic Aorta
 ;;^UTILITY(U,$J,358.3,1327,0)
 ;;=36222^^17^96^16^^^^1
 ;;^UTILITY(U,$J,358.3,1327,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1327,1,2,0)
 ;;=2^36222
 ;;^UTILITY(U,$J,358.3,1327,1,3,0)
 ;;=3^Place Cath Carotid/Inom Art
 ;;^UTILITY(U,$J,358.3,1328,0)
 ;;=36223^^17^96^15^^^^1
 ;;^UTILITY(U,$J,358.3,1328,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1328,1,2,0)
 ;;=2^36223
 ;;^UTILITY(U,$J,358.3,1328,1,3,0)
 ;;=3^Place Cath Carotid Inc Extracranial
 ;;^UTILITY(U,$J,358.3,1329,0)
 ;;=36224^^17^96^14^^^^1
 ;;^UTILITY(U,$J,358.3,1329,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1329,1,2,0)
 ;;=2^36224
 ;;^UTILITY(U,$J,358.3,1329,1,3,0)
 ;;=3^Place Cath Carotid Art
 ;;^UTILITY(U,$J,358.3,1330,0)
 ;;=36225^^17^96^18^^^^1
 ;;^UTILITY(U,$J,358.3,1330,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1330,1,2,0)
 ;;=2^36225
 ;;^UTILITY(U,$J,358.3,1330,1,3,0)
 ;;=3^Place Cath Subclavian Art
 ;;^UTILITY(U,$J,358.3,1331,0)
 ;;=36226^^17^96^20^^^^1
 ;;^UTILITY(U,$J,358.3,1331,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1331,1,2,0)
 ;;=2^36226
 ;;^UTILITY(U,$J,358.3,1331,1,3,0)
 ;;=3^Place Cath Vertebral Art
 ;;^UTILITY(U,$J,358.3,1332,0)
 ;;=36227^^17^96^21^^^^1
 ;;^UTILITY(U,$J,358.3,1332,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1332,1,2,0)
 ;;=2^36227
 ;;^UTILITY(U,$J,358.3,1332,1,3,0)
 ;;=3^Place Cath Xtrnl Carotid
 ;;^UTILITY(U,$J,358.3,1333,0)
 ;;=36228^^17^96^17^^^^1
 ;;^UTILITY(U,$J,358.3,1333,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1333,1,2,0)
 ;;=2^36228
 ;;^UTILITY(U,$J,358.3,1333,1,3,0)
 ;;=3^Place Cath Intracranial Art
 ;;^UTILITY(U,$J,358.3,1334,0)
 ;;=37197^^17^96^22^^^^1
 ;;^UTILITY(U,$J,358.3,1334,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1334,1,2,0)
 ;;=2^37197
 ;;^UTILITY(U,$J,358.3,1334,1,3,0)
 ;;=3^Remove Intrvas Foreign Body
 ;;^UTILITY(U,$J,358.3,1335,0)
 ;;=93561^^17^97^7^^^^1
 ;;^UTILITY(U,$J,358.3,1335,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1335,1,2,0)
 ;;=2^93561
 ;;^UTILITY(U,$J,358.3,1335,1,3,0)
 ;;=3^Thermal Dilution Study W/Cardiac Output
