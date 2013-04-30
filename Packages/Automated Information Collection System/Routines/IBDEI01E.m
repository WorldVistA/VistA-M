IBDEI01E ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1249,1,3,0)
 ;;=3^Select Cath 2Nd Order Abd/Pelv/Le Artery
 ;;^UTILITY(U,$J,358.3,1250,0)
 ;;=36247^^17^92^7^^^^1
 ;;^UTILITY(U,$J,358.3,1250,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1250,1,2,0)
 ;;=2^36247
 ;;^UTILITY(U,$J,358.3,1250,1,3,0)
 ;;=3^Select Cath 3Rd Order Abd/Pelv/Le Artery
 ;;^UTILITY(U,$J,358.3,1251,0)
 ;;=37205^^17^92^12^^^^1
 ;;^UTILITY(U,$J,358.3,1251,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1251,1,2,0)
 ;;=2^37205
 ;;^UTILITY(U,$J,358.3,1251,1,3,0)
 ;;=3^Stent Place, Non/Coronary,Percutaneous,Each Vess
 ;;^UTILITY(U,$J,358.3,1252,0)
 ;;=37206^^17^92^13^^^^1
 ;;^UTILITY(U,$J,358.3,1252,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1252,1,2,0)
 ;;=2^37206
 ;;^UTILITY(U,$J,358.3,1252,1,3,0)
 ;;=3^     Each Add Artery (W/37205)
 ;;^UTILITY(U,$J,358.3,1253,0)
 ;;=75960^^17^92^59^^^^1
 ;;^UTILITY(U,$J,358.3,1253,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1253,1,2,0)
 ;;=2^75960
 ;;^UTILITY(U,$J,358.3,1253,1,3,0)
 ;;=3^Transcath Intro/Stens(S) Rad S&I Each Vessel
 ;;^UTILITY(U,$J,358.3,1254,0)
 ;;=75962^^17^92^60^^^^1
 ;;^UTILITY(U,$J,358.3,1254,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1254,1,2,0)
 ;;=2^75962
 ;;^UTILITY(U,$J,358.3,1254,1,3,0)
 ;;=3^Translum Ball Angioplasty,Peripheral Artery, Rad S&I
 ;;^UTILITY(U,$J,358.3,1255,0)
 ;;=75964^^17^92^61^^^^1
 ;;^UTILITY(U,$J,358.3,1255,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1255,1,2,0)
 ;;=2^75964
 ;;^UTILITY(U,$J,358.3,1255,1,3,0)
 ;;=3^     Each Add Artery (W/75962)
 ;;^UTILITY(U,$J,358.3,1256,0)
 ;;=75791^^17^92^58^^^^1
 ;;^UTILITY(U,$J,358.3,1256,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1256,1,2,0)
 ;;=2^75791
 ;;^UTILITY(U,$J,358.3,1256,1,3,0)
 ;;=3^Arteriovenous Shunt
 ;;^UTILITY(U,$J,358.3,1257,0)
 ;;=37220^^17^92^14^^^^1
 ;;^UTILITY(U,$J,358.3,1257,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1257,1,2,0)
 ;;=2^37220
 ;;^UTILITY(U,$J,358.3,1257,1,3,0)
 ;;=3^Iliac Revasc,Unilat,1st Vessel
 ;;^UTILITY(U,$J,358.3,1258,0)
 ;;=37221^^17^92^15^^^^1
 ;;^UTILITY(U,$J,358.3,1258,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1258,1,2,0)
 ;;=2^37221
 ;;^UTILITY(U,$J,358.3,1258,1,3,0)
 ;;=3^Iliac Revasc w/Stent
 ;;^UTILITY(U,$J,358.3,1259,0)
 ;;=37222^^17^92^16^^^^1
 ;;^UTILITY(U,$J,358.3,1259,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1259,1,2,0)
 ;;=2^37222
 ;;^UTILITY(U,$J,358.3,1259,1,3,0)
 ;;=3^Iliac Revasc,ea add Vessel
 ;;^UTILITY(U,$J,358.3,1260,0)
 ;;=37223^^17^92^17^^^^1
 ;;^UTILITY(U,$J,358.3,1260,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1260,1,2,0)
 ;;=2^37223
 ;;^UTILITY(U,$J,358.3,1260,1,3,0)
 ;;=3^Iliac Revasc w/Stent,Add-on
 ;;^UTILITY(U,$J,358.3,1261,0)
 ;;=37224^^17^92^18^^^^1
 ;;^UTILITY(U,$J,358.3,1261,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1261,1,2,0)
 ;;=2^37224
 ;;^UTILITY(U,$J,358.3,1261,1,3,0)
 ;;=3^Fem/Popl Revas w/TLA 1st Vessel
 ;;^UTILITY(U,$J,358.3,1262,0)
 ;;=37225^^17^92^19^^^^1
 ;;^UTILITY(U,$J,358.3,1262,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1262,1,2,0)
 ;;=2^37225
 ;;^UTILITY(U,$J,358.3,1262,1,3,0)
 ;;=3^Fem/Popl Revas w/Ather
 ;;^UTILITY(U,$J,358.3,1263,0)
 ;;=37226^^17^92^20^^^^1
 ;;^UTILITY(U,$J,358.3,1263,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1263,1,2,0)
 ;;=2^37226
 ;;^UTILITY(U,$J,358.3,1263,1,3,0)
 ;;=3^Fem/Popl Revasc w/Stent
 ;;^UTILITY(U,$J,358.3,1264,0)
 ;;=37227^^17^92^21^^^^1
 ;;^UTILITY(U,$J,358.3,1264,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1264,1,2,0)
 ;;=2^37227
 ;;^UTILITY(U,$J,358.3,1264,1,3,0)
 ;;=3^Fem/Popl Revasc w/Stent & Ather
 ;;^UTILITY(U,$J,358.3,1265,0)
 ;;=37228^^17^92^22^^^^1
 ;;^UTILITY(U,$J,358.3,1265,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1265,1,2,0)
 ;;=2^37228
 ;;^UTILITY(U,$J,358.3,1265,1,3,0)
 ;;=3^TIB/Per Revasc w/TLA,1st Vessel
 ;;^UTILITY(U,$J,358.3,1266,0)
 ;;=37229^^17^92^23^^^^1
 ;;^UTILITY(U,$J,358.3,1266,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1266,1,2,0)
 ;;=2^37229
 ;;^UTILITY(U,$J,358.3,1266,1,3,0)
 ;;=3^TIB/Per Revasc w/Ather
 ;;^UTILITY(U,$J,358.3,1267,0)
 ;;=37230^^17^92^24^^^^1
 ;;^UTILITY(U,$J,358.3,1267,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1267,1,2,0)
 ;;=2^37230
 ;;^UTILITY(U,$J,358.3,1267,1,3,0)
 ;;=3^TIB/Per Revasc w/Stent
 ;;^UTILITY(U,$J,358.3,1268,0)
 ;;=37231^^17^92^25^^^^1
 ;;^UTILITY(U,$J,358.3,1268,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1268,1,2,0)
 ;;=2^37231
 ;;^UTILITY(U,$J,358.3,1268,1,3,0)
 ;;=3^TIB/Per Revasc Stent & Ather
 ;;^UTILITY(U,$J,358.3,1269,0)
 ;;=37232^^17^92^26^^^^1
 ;;^UTILITY(U,$J,358.3,1269,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1269,1,2,0)
 ;;=2^37232
 ;;^UTILITY(U,$J,358.3,1269,1,3,0)
 ;;=3^TIB/Per Revasc,ea addl Vessel
 ;;^UTILITY(U,$J,358.3,1270,0)
 ;;=37233^^17^92^27^^^^1
 ;;^UTILITY(U,$J,358.3,1270,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1270,1,2,0)
 ;;=2^37233
 ;;^UTILITY(U,$J,358.3,1270,1,3,0)
 ;;=3^TIB/Per Revasc w/Ather,ea addl Vessel
 ;;^UTILITY(U,$J,358.3,1271,0)
 ;;=37234^^17^92^28^^^^1
 ;;^UTILITY(U,$J,358.3,1271,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1271,1,2,0)
 ;;=2^37234
 ;;^UTILITY(U,$J,358.3,1271,1,3,0)
 ;;=3^TIB/Per Revasc w/Stent,ea addl Vessel
 ;;^UTILITY(U,$J,358.3,1272,0)
 ;;=37235^^17^92^29^^^^1
 ;;^UTILITY(U,$J,358.3,1272,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1272,1,2,0)
 ;;=2^37235
 ;;^UTILITY(U,$J,358.3,1272,1,3,0)
 ;;=3^TIB/Per Revasc w/Stnt&Ather,addl Vessel
 ;;^UTILITY(U,$J,358.3,1273,0)
 ;;=36251^^17^92^8^^^^1
 ;;^UTILITY(U,$J,358.3,1273,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1273,1,2,0)
 ;;=2^36251
 ;;^UTILITY(U,$J,358.3,1273,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Access Art
 ;;^UTILITY(U,$J,358.3,1274,0)
 ;;=36252^^17^92^9^^^^1
 ;;^UTILITY(U,$J,358.3,1274,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1274,1,2,0)
 ;;=2^36252
 ;;^UTILITY(U,$J,358.3,1274,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Acc Art,Bilat
 ;;^UTILITY(U,$J,358.3,1275,0)
 ;;=36254^^17^92^10^^^^1
 ;;^UTILITY(U,$J,358.3,1275,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1275,1,2,0)
 ;;=2^36254
 ;;^UTILITY(U,$J,358.3,1275,1,3,0)
 ;;=3^Superselect Cath Ren Art&Access Art
 ;;^UTILITY(U,$J,358.3,1276,0)
 ;;=37191^^17^92^11^^^^1
 ;;^UTILITY(U,$J,358.3,1276,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1276,1,2,0)
 ;;=2^37191
 ;;^UTILITY(U,$J,358.3,1276,1,3,0)
 ;;=3^Insert Intravas Vena Cava Filter,Endovas
 ;;^UTILITY(U,$J,358.3,1277,0)
 ;;=37619^^17^92^31^^^^1
 ;;^UTILITY(U,$J,358.3,1277,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1277,1,2,0)
 ;;=2^37619
 ;;^UTILITY(U,$J,358.3,1277,1,3,0)
 ;;=3^Open Inferior Vena Cava Filter Placement
 ;;^UTILITY(U,$J,358.3,1278,0)
 ;;=75635^^17^92^35^^^^1
 ;;^UTILITY(U,$J,358.3,1278,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1278,1,2,0)
 ;;=2^75635
 ;;^UTILITY(U,$J,358.3,1278,1,3,0)
 ;;=3^CT Angio Abd Art w/Contrast
 ;;^UTILITY(U,$J,358.3,1279,0)
 ;;=75658^^17^92^38^^^^1
 ;;^UTILITY(U,$J,358.3,1279,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1279,1,2,0)
 ;;=2^75658
 ;;^UTILITY(U,$J,358.3,1279,1,3,0)
 ;;=3^Angiography,Brachial,Retrograd,Rad S&I
 ;;^UTILITY(U,$J,358.3,1280,0)
 ;;=76506^^17^92^62^^^^1
 ;;^UTILITY(U,$J,358.3,1280,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1280,1,2,0)
 ;;=2^76506
 ;;^UTILITY(U,$J,358.3,1280,1,3,0)
 ;;=3^Echoencephalography,Real Time w/Image Doc
 ;;^UTILITY(U,$J,358.3,1281,0)
 ;;=36005^^17^93^1^^^^1
 ;;^UTILITY(U,$J,358.3,1281,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1281,1,2,0)
 ;;=2^36005
 ;;^UTILITY(U,$J,358.3,1281,1,3,0)
 ;;=3^Contrast Venography
 ;;^UTILITY(U,$J,358.3,1282,0)
 ;;=92950^^17^94^2^^^^1
 ;;^UTILITY(U,$J,358.3,1282,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1282,1,2,0)
 ;;=2^92950
 ;;^UTILITY(U,$J,358.3,1282,1,3,0)
 ;;=3^CPR
 ;;^UTILITY(U,$J,358.3,1283,0)
 ;;=33010^^17^94^1^^^^1
 ;;^UTILITY(U,$J,358.3,1283,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1283,1,2,0)
 ;;=2^33010
 ;;^UTILITY(U,$J,358.3,1283,1,3,0)
 ;;=3^Pericardiocentesis
 ;;^UTILITY(U,$J,358.3,1284,0)
 ;;=93503^^17^95^14^^^^1
 ;;^UTILITY(U,$J,358.3,1284,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1284,1,2,0)
 ;;=2^93503
 ;;^UTILITY(U,$J,358.3,1284,1,3,0)
 ;;=3^Swan Ganz Placement
 ;;^UTILITY(U,$J,358.3,1285,0)
 ;;=93451^^17^95^1^^^^1
 ;;^UTILITY(U,$J,358.3,1285,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1285,1,2,0)
 ;;=2^93451
 ;;^UTILITY(U,$J,358.3,1285,1,3,0)
 ;;=3^Right Hrt Cath incl O2 & Cardiac Outpt
 ;;^UTILITY(U,$J,358.3,1286,0)
 ;;=93452^^17^95^2^^^^1
 ;;^UTILITY(U,$J,358.3,1286,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1286,1,2,0)
 ;;=2^93452
 ;;^UTILITY(U,$J,358.3,1286,1,3,0)
 ;;=3^LHC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,1287,0)
 ;;=93453^^17^95^3^^^^1
 ;;^UTILITY(U,$J,358.3,1287,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1287,1,2,0)
 ;;=2^93453
 ;;^UTILITY(U,$J,358.3,1287,1,3,0)
 ;;=3^R&L HC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,1288,0)
 ;;=93454^^17^95^4^^^^1
 ;;^UTILITY(U,$J,358.3,1288,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1288,1,2,0)
 ;;=2^93454
 ;;^UTILITY(U,$J,358.3,1288,1,3,0)
 ;;=3^Coronary Angiography, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1289,0)
 ;;=93455^^17^95^5^^^^1
 ;;^UTILITY(U,$J,358.3,1289,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1289,1,2,0)
 ;;=2^93455
 ;;^UTILITY(U,$J,358.3,1289,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and Bypass angio
 ;;^UTILITY(U,$J,358.3,1290,0)
 ;;=93456^^17^95^6^^^^1
 ;;^UTILITY(U,$J,358.3,1290,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1290,1,2,0)
 ;;=2^93456
 ;;^UTILITY(U,$J,358.3,1290,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and R Heart Cath
 ;;^UTILITY(U,$J,358.3,1291,0)
 ;;=93457^^17^95^7^^^^1
 ;;^UTILITY(U,$J,358.3,1291,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1291,1,2,0)
 ;;=2^93457
 ;;^UTILITY(U,$J,358.3,1291,1,3,0)
 ;;=3^Rt Hrt Angio,Bypass Grft,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1292,0)
 ;;=93458^^17^95^8^^^^1
 ;;^UTILITY(U,$J,358.3,1292,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1292,1,2,0)
 ;;=2^93458
 ;;^UTILITY(U,$J,358.3,1292,1,3,0)
 ;;=3^Cor Angio, LHC, V-Gram, incl inj & S&I
