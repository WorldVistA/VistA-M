IBDEI01G ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1336,0)
 ;;=93571^^17^97^8^^^^1
 ;;^UTILITY(U,$J,358.3,1336,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1336,1,2,0)
 ;;=2^93571
 ;;^UTILITY(U,$J,358.3,1336,1,3,0)
 ;;=3^Intravascular Dopplar Add-On, First Vessel
 ;;^UTILITY(U,$J,358.3,1337,0)
 ;;=93572^^17^97^9^^^^1
 ;;^UTILITY(U,$J,358.3,1337,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1337,1,2,0)
 ;;=2^93572
 ;;^UTILITY(U,$J,358.3,1337,1,3,0)
 ;;=3^Intravascular Dopplar, Each Addl Vessel
 ;;^UTILITY(U,$J,358.3,1338,0)
 ;;=93307^^17^97^2^^^^1
 ;;^UTILITY(U,$J,358.3,1338,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1338,1,2,0)
 ;;=2^93307
 ;;^UTILITY(U,$J,358.3,1338,1,3,0)
 ;;=3^TTE w/o Doppler
 ;;^UTILITY(U,$J,358.3,1339,0)
 ;;=93312^^17^97^4^^^^1
 ;;^UTILITY(U,$J,358.3,1339,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1339,1,2,0)
 ;;=2^93312
 ;;^UTILITY(U,$J,358.3,1339,1,3,0)
 ;;=3^Transesophageal Echocardiography
 ;;^UTILITY(U,$J,358.3,1340,0)
 ;;=93308^^17^97^3^^^^1
 ;;^UTILITY(U,$J,358.3,1340,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1340,1,2,0)
 ;;=2^93308
 ;;^UTILITY(U,$J,358.3,1340,1,3,0)
 ;;=3^Transthoracic Follow-Up Echo
 ;;^UTILITY(U,$J,358.3,1341,0)
 ;;=93320^^17^97^5^^^^1
 ;;^UTILITY(U,$J,358.3,1341,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1341,1,2,0)
 ;;=2^93320
 ;;^UTILITY(U,$J,358.3,1341,1,3,0)
 ;;=3^Doppler Echo Add-On
 ;;^UTILITY(U,$J,358.3,1342,0)
 ;;=93325^^17^97^6^^^^1
 ;;^UTILITY(U,$J,358.3,1342,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1342,1,2,0)
 ;;=2^93325
 ;;^UTILITY(U,$J,358.3,1342,1,3,0)
 ;;=3^Dopplar Echo Color Flow Add-On
 ;;^UTILITY(U,$J,358.3,1343,0)
 ;;=93306^^17^97^1^^^^1
 ;;^UTILITY(U,$J,358.3,1343,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1343,1,2,0)
 ;;=2^93306
 ;;^UTILITY(U,$J,358.3,1343,1,3,0)
 ;;=3^TTE w/ Doppler,Complete
 ;;^UTILITY(U,$J,358.3,1344,0)
 ;;=93740^^17^97^10^^^^1
 ;;^UTILITY(U,$J,358.3,1344,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1344,1,2,0)
 ;;=2^93740
 ;;^UTILITY(U,$J,358.3,1344,1,3,0)
 ;;=3^Temperature Gradient Studies
 ;;^UTILITY(U,$J,358.3,1345,0)
 ;;=34800^^17^98^1^^^^1
 ;;^UTILITY(U,$J,358.3,1345,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1345,1,2,0)
 ;;=2^34800
 ;;^UTILITY(U,$J,358.3,1345,1,3,0)
 ;;=3^Endovasc Abdo Repair W/Tube
 ;;^UTILITY(U,$J,358.3,1346,0)
 ;;=34802^^17^98^2^^^^1
 ;;^UTILITY(U,$J,358.3,1346,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1346,1,2,0)
 ;;=2^34802
 ;;^UTILITY(U,$J,358.3,1346,1,3,0)
 ;;=3^Endovasc Abdo Repr W/Bifurc
 ;;^UTILITY(U,$J,358.3,1347,0)
 ;;=34803^^17^98^3^^^^1
 ;;^UTILITY(U,$J,358.3,1347,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1347,1,2,0)
 ;;=2^34803
 ;;^UTILITY(U,$J,358.3,1347,1,3,0)
 ;;=3^Endovas Aaa Repr W/3-P Part
 ;;^UTILITY(U,$J,358.3,1348,0)
 ;;=93000^^18^99^1
 ;;^UTILITY(U,$J,358.3,1348,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1348,1,2,0)
 ;;=2^93000
 ;;^UTILITY(U,$J,358.3,1348,1,3,0)
 ;;=3^EKG 12 Lead W/Report
 ;;^UTILITY(U,$J,358.3,1349,0)
 ;;=93005^^18^99^3
 ;;^UTILITY(U,$J,358.3,1349,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1349,1,2,0)
 ;;=2^93005
 ;;^UTILITY(U,$J,358.3,1349,1,3,0)
 ;;=3^EKG, Tracing Only No Report
 ;;^UTILITY(U,$J,358.3,1350,0)
 ;;=93278^^18^99^4
 ;;^UTILITY(U,$J,358.3,1350,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1350,1,2,0)
 ;;=2^93278
 ;;^UTILITY(U,$J,358.3,1350,1,3,0)
 ;;=3^EKG/Signal-Averaged
 ;;^UTILITY(U,$J,358.3,1351,0)
 ;;=93010^^18^99^2^^^^1
 ;;^UTILITY(U,$J,358.3,1351,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1351,1,2,0)
 ;;=2^93010
 ;;^UTILITY(U,$J,358.3,1351,1,3,0)
 ;;=3^EKG Read Only
 ;;^UTILITY(U,$J,358.3,1352,0)
 ;;=0295T^^18^99^5^^^^1
 ;;^UTILITY(U,$J,358.3,1352,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1352,1,2,0)
 ;;=2^0295T
 ;;^UTILITY(U,$J,358.3,1352,1,3,0)
 ;;=3^Ext ECG Complete
 ;;^UTILITY(U,$J,358.3,1353,0)
 ;;=0296T^^18^99^6^^^^1
 ;;^UTILITY(U,$J,358.3,1353,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1353,1,2,0)
 ;;=2^0296T
 ;;^UTILITY(U,$J,358.3,1353,1,3,0)
 ;;=3^Ext ECG Recording
 ;;^UTILITY(U,$J,358.3,1354,0)
 ;;=0297T^^18^99^8^^^^1
 ;;^UTILITY(U,$J,358.3,1354,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1354,1,2,0)
 ;;=2^0297T
 ;;^UTILITY(U,$J,358.3,1354,1,3,0)
 ;;=3^Ext ECG Scan w/Report
 ;;^UTILITY(U,$J,358.3,1355,0)
 ;;=0298T^^18^99^7^^^^1
 ;;^UTILITY(U,$J,358.3,1355,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1355,1,2,0)
 ;;=2^0298T
 ;;^UTILITY(U,$J,358.3,1355,1,3,0)
 ;;=3^Ext ECG Review and Interp
 ;;^UTILITY(U,$J,358.3,1356,0)
 ;;=93015^^18^100^7
 ;;^UTILITY(U,$J,358.3,1356,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1356,1,2,0)
 ;;=2^93015
 ;;^UTILITY(U,$J,358.3,1356,1,3,0)
 ;;=3^Cardiovascular Stress Test
 ;;^UTILITY(U,$J,358.3,1357,0)
 ;;=93660^^18^100^14
 ;;^UTILITY(U,$J,358.3,1357,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1357,1,2,0)
 ;;=2^93660
 ;;^UTILITY(U,$J,358.3,1357,1,3,0)
 ;;=3^Tilt Test Study
 ;;^UTILITY(U,$J,358.3,1358,0)
 ;;=78472^^18^100^2^^^^1
 ;;^UTILITY(U,$J,358.3,1358,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1358,1,2,0)
 ;;=2^78472
 ;;^UTILITY(U,$J,358.3,1358,1,3,0)
 ;;=3^Cardiac Blood Pool Gate+EF 
 ;;^UTILITY(U,$J,358.3,1359,0)
 ;;=78473^^18^100^1^^^^1
 ;;^UTILITY(U,$J,358.3,1359,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1359,1,2,0)
 ;;=2^78473
 ;;^UTILITY(U,$J,358.3,1359,1,3,0)
 ;;=3^Cardiac Blood Pool Gate mult
 ;;^UTILITY(U,$J,358.3,1360,0)
 ;;=78481^^18^100^6^^^^1
 ;;^UTILITY(U,$J,358.3,1360,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1360,1,2,0)
 ;;=2^78481
 ;;^UTILITY(U,$J,358.3,1360,1,3,0)
 ;;=3^Cardiac Blood Pool Imag
 ;;^UTILITY(U,$J,358.3,1361,0)
 ;;=78483^^18^100^5^^^^1
 ;;^UTILITY(U,$J,358.3,1361,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1361,1,2,0)
 ;;=2^78483
 ;;^UTILITY(U,$J,358.3,1361,1,3,0)
 ;;=3^Cardiac Blood Pool Imag mult
 ;;^UTILITY(U,$J,358.3,1362,0)
 ;;=78491^^18^100^12^^^^1
 ;;^UTILITY(U,$J,358.3,1362,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1362,1,2,0)
 ;;=2^78491
 ;;^UTILITY(U,$J,358.3,1362,1,3,0)
 ;;=3^PET, Single, Rest or stress
 ;;^UTILITY(U,$J,358.3,1363,0)
 ;;=78492^^18^100^13^^^^1
 ;;^UTILITY(U,$J,358.3,1363,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1363,1,2,0)
 ;;=2^78492
 ;;^UTILITY(U,$J,358.3,1363,1,3,0)
 ;;=3^PET, multiple, rest or stress
 ;;^UTILITY(U,$J,358.3,1364,0)
 ;;=78496^^18^100^4^^^^1
 ;;^UTILITY(U,$J,358.3,1364,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1364,1,2,0)
 ;;=2^78496
 ;;^UTILITY(U,$J,358.3,1364,1,3,0)
 ;;=3^Cardiac Blood Pool Imag Gate sgl+EF
 ;;^UTILITY(U,$J,358.3,1365,0)
 ;;=78451^^18^100^8^^^^1
 ;;^UTILITY(U,$J,358.3,1365,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1365,1,2,0)
 ;;=2^78451
 ;;^UTILITY(U,$J,358.3,1365,1,3,0)
 ;;=3^HT Muscle Image Spect,Single
 ;;^UTILITY(U,$J,358.3,1366,0)
 ;;=78452^^18^100^9^^^^1
 ;;^UTILITY(U,$J,358.3,1366,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1366,1,2,0)
 ;;=2^78452
 ;;^UTILITY(U,$J,358.3,1366,1,3,0)
 ;;=3^HT Muscle Image Spect,Multi
 ;;^UTILITY(U,$J,358.3,1367,0)
 ;;=78453^^18^100^10^^^^1
 ;;^UTILITY(U,$J,358.3,1367,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1367,1,2,0)
 ;;=2^78453
 ;;^UTILITY(U,$J,358.3,1367,1,3,0)
 ;;=3^HT Muscle Image,Planar,Single
 ;;^UTILITY(U,$J,358.3,1368,0)
 ;;=78454^^18^100^11^^^^1
 ;;^UTILITY(U,$J,358.3,1368,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1368,1,2,0)
 ;;=2^78454
 ;;^UTILITY(U,$J,358.3,1368,1,3,0)
 ;;=3^HT Muscle Image,Planar,Multi
 ;;^UTILITY(U,$J,358.3,1369,0)
 ;;=93307^^18^101^10^^^^1
 ;;^UTILITY(U,$J,358.3,1369,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1369,1,2,0)
 ;;=2^93307
 ;;^UTILITY(U,$J,358.3,1369,1,3,0)
 ;;=3^Echo,TT,2D,M Mode
 ;;^UTILITY(U,$J,358.3,1370,0)
 ;;=93308^^18^101^6^^^^1
 ;;^UTILITY(U,$J,358.3,1370,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1370,1,2,0)
 ;;=2^93308
 ;;^UTILITY(U,$J,358.3,1370,1,3,0)
 ;;=3^Echo F/U Or Limited Study
 ;;^UTILITY(U,$J,358.3,1371,0)
 ;;=93320^^18^101^3^^^^1
 ;;^UTILITY(U,$J,358.3,1371,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1371,1,2,0)
 ;;=2^93320
 ;;^UTILITY(U,$J,358.3,1371,1,3,0)
 ;;=3^Doppler Echo pulse wave
 ;;^UTILITY(U,$J,358.3,1372,0)
 ;;=93325^^18^101^2^^^^1
 ;;^UTILITY(U,$J,358.3,1372,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1372,1,2,0)
 ;;=2^93325
 ;;^UTILITY(U,$J,358.3,1372,1,3,0)
 ;;=3^Doppler ECHO color flow velocity mapping
 ;;^UTILITY(U,$J,358.3,1373,0)
 ;;=93350^^18^101^5^^^^1
 ;;^UTILITY(U,$J,358.3,1373,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1373,1,2,0)
 ;;=2^93350
 ;;^UTILITY(U,$J,358.3,1373,1,3,0)
 ;;=3^ECHO,transthoracic rest & stress test
 ;;^UTILITY(U,$J,358.3,1374,0)
 ;;=93306^^18^101^11^^^^1
 ;;^UTILITY(U,$J,358.3,1374,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1374,1,2,0)
 ;;=2^93306
 ;;^UTILITY(U,$J,358.3,1374,1,3,0)
 ;;=3^Echo,TT,2D,M Mode w/ Color Doppler
 ;;^UTILITY(U,$J,358.3,1375,0)
 ;;=93321^^18^101^4^^^^1
 ;;^UTILITY(U,$J,358.3,1375,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1375,1,2,0)
 ;;=2^93321
 ;;^UTILITY(U,$J,358.3,1375,1,3,0)
 ;;=3^Doppler Echo, Heart
 ;;^UTILITY(U,$J,358.3,1376,0)
 ;;=93351^^18^101^13^^^^1
 ;;^UTILITY(U,$J,358.3,1376,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1376,1,2,0)
 ;;=2^93351
 ;;^UTILITY(U,$J,358.3,1376,1,3,0)
 ;;=3^Stress TTE Complete
 ;;^UTILITY(U,$J,358.3,1377,0)
 ;;=93352^^18^101^1^^^^1
 ;;^UTILITY(U,$J,358.3,1377,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1377,1,2,0)
 ;;=2^93352
 ;;^UTILITY(U,$J,358.3,1377,1,3,0)
 ;;=3^Admin ECG Contrast Agent
 ;;^UTILITY(U,$J,358.3,1378,0)
 ;;=93312^^18^101^9^^^^1
 ;;^UTILITY(U,$J,358.3,1378,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1378,1,2,0)
 ;;=2^93312
 ;;^UTILITY(U,$J,358.3,1378,1,3,0)
 ;;=3^Echo Transesophageal w/wo M-mode record
 ;;^UTILITY(U,$J,358.3,1379,0)
 ;;=93313^^18^101^8^^^^1
 ;;^UTILITY(U,$J,358.3,1379,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1379,1,2,0)
 ;;=2^93313
 ;;^UTILITY(U,$J,358.3,1379,1,3,0)
 ;;=3^Echo Transesophageal w/ placement of probe
 ;;^UTILITY(U,$J,358.3,1380,0)
 ;;=93314^^18^101^7^^^^1
