IBDEI00S ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1354,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1354,1,2,0)
 ;;=2^95887
 ;;^UTILITY(U,$J,358.3,1354,1,3,0)
 ;;=3^EMG,non-extremity w/nerve conduction
 ;;^UTILITY(U,$J,358.3,1355,0)
 ;;=95868^^12^90^5^^^^1
 ;;^UTILITY(U,$J,358.3,1355,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1355,1,2,0)
 ;;=2^95868
 ;;^UTILITY(U,$J,358.3,1355,1,3,0)
 ;;=3^EMG, Cranial Nerve supplied Muscles, bil
 ;;^UTILITY(U,$J,358.3,1356,0)
 ;;=95905^^12^90^18^^^^1
 ;;^UTILITY(U,$J,358.3,1356,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1356,1,2,0)
 ;;=2^95905
 ;;^UTILITY(U,$J,358.3,1356,1,3,0)
 ;;=3^Motor&Sens NCS, preconf electrode,ea limb
 ;;^UTILITY(U,$J,358.3,1357,0)
 ;;=95907^^12^90^19^^^^1
 ;;^UTILITY(U,$J,358.3,1357,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1357,1,2,0)
 ;;=2^95907
 ;;^UTILITY(U,$J,358.3,1357,1,3,0)
 ;;=3^NCS,1-2 Studies
 ;;^UTILITY(U,$J,358.3,1358,0)
 ;;=95908^^12^90^22^^^^1
 ;;^UTILITY(U,$J,358.3,1358,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1358,1,2,0)
 ;;=2^95908
 ;;^UTILITY(U,$J,358.3,1358,1,3,0)
 ;;=3^NCS,3-4 Studies
 ;;^UTILITY(U,$J,358.3,1359,0)
 ;;=95909^^12^90^23^^^^1
 ;;^UTILITY(U,$J,358.3,1359,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1359,1,2,0)
 ;;=2^95909
 ;;^UTILITY(U,$J,358.3,1359,1,3,0)
 ;;=3^NCS,5-6 Studies
 ;;^UTILITY(U,$J,358.3,1360,0)
 ;;=95910^^12^90^24^^^^1
 ;;^UTILITY(U,$J,358.3,1360,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1360,1,2,0)
 ;;=2^95910
 ;;^UTILITY(U,$J,358.3,1360,1,3,0)
 ;;=3^NCS,7-8 Studies
 ;;^UTILITY(U,$J,358.3,1361,0)
 ;;=95911^^12^90^25^^^^1
 ;;^UTILITY(U,$J,358.3,1361,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1361,1,2,0)
 ;;=2^95911
 ;;^UTILITY(U,$J,358.3,1361,1,3,0)
 ;;=3^NCS,9-10 Studies
 ;;^UTILITY(U,$J,358.3,1362,0)
 ;;=95912^^12^90^20^^^^1
 ;;^UTILITY(U,$J,358.3,1362,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1362,1,2,0)
 ;;=2^95912
 ;;^UTILITY(U,$J,358.3,1362,1,3,0)
 ;;=3^NCS,11-12 Studies
 ;;^UTILITY(U,$J,358.3,1363,0)
 ;;=95913^^12^90^21^^^^1
 ;;^UTILITY(U,$J,358.3,1363,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1363,1,2,0)
 ;;=2^95913
 ;;^UTILITY(U,$J,358.3,1363,1,3,0)
 ;;=3^NCS,13 or More Studies
 ;;^UTILITY(U,$J,358.3,1364,0)
 ;;=95937^^12^90^27^^^^1
 ;;^UTILITY(U,$J,358.3,1364,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1364,1,2,0)
 ;;=2^95937
 ;;^UTILITY(U,$J,358.3,1364,1,3,0)
 ;;=3^Neuromuscular Junction Test
 ;;^UTILITY(U,$J,358.3,1365,0)
 ;;=95925^^12^91^9^^^^1
 ;;^UTILITY(U,$J,358.3,1365,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1365,1,2,0)
 ;;=2^95925
 ;;^UTILITY(U,$J,358.3,1365,1,3,0)
 ;;=3^Short Latency SSEP, Periph Nerve, Upper Ext
 ;;^UTILITY(U,$J,358.3,1366,0)
 ;;=95926^^12^91^7^^^^1
 ;;^UTILITY(U,$J,358.3,1366,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1366,1,2,0)
 ;;=2^95926
 ;;^UTILITY(U,$J,358.3,1366,1,3,0)
 ;;=3^Short Latency SSEP, Periph Nerve, Lower Ext
 ;;^UTILITY(U,$J,358.3,1367,0)
 ;;=95927^^12^91^8^^^^1
 ;;^UTILITY(U,$J,358.3,1367,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1367,1,2,0)
 ;;=2^95927
 ;;^UTILITY(U,$J,358.3,1367,1,3,0)
 ;;=3^Short Latency SSEP, Periph Nerve, Trunk/Head
 ;;^UTILITY(U,$J,358.3,1368,0)
 ;;=95930^^12^91^11^^^^1
 ;;^UTILITY(U,$J,358.3,1368,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1368,1,2,0)
 ;;=2^95930
 ;;^UTILITY(U,$J,358.3,1368,1,3,0)
 ;;=3^Visual Evoked Potential
 ;;^UTILITY(U,$J,358.3,1369,0)
 ;;=95933^^12^91^5^^^^1
 ;;^UTILITY(U,$J,358.3,1369,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1369,1,2,0)
 ;;=2^95933
 ;;^UTILITY(U,$J,358.3,1369,1,3,0)
 ;;=3^Blink Reflex Test
 ;;^UTILITY(U,$J,358.3,1370,0)
 ;;=95937^^12^91^6^^^^1
 ;;^UTILITY(U,$J,358.3,1370,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1370,1,2,0)
 ;;=2^95937
 ;;^UTILITY(U,$J,358.3,1370,1,3,0)
 ;;=3^Neuromuscular Junction Test
 ;;^UTILITY(U,$J,358.3,1371,0)
 ;;=95938^^12^91^10^^^^1
 ;;^UTILITY(U,$J,358.3,1371,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1371,1,2,0)
 ;;=2^95938
 ;;^UTILITY(U,$J,358.3,1371,1,3,0)
 ;;=3^Short Latency SSEP,Periph Nerve,Upper&Lower
 ;;^UTILITY(U,$J,358.3,1372,0)
 ;;=92650^^12^91^3^^^^1
 ;;^UTILITY(U,$J,358.3,1372,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1372,1,2,0)
 ;;=2^92650
 ;;^UTILITY(U,$J,358.3,1372,1,3,0)
 ;;=3^AEP Scr Auditory Potential w/ Broadband Stimuli,Automated Analysis
 ;;^UTILITY(U,$J,358.3,1373,0)
 ;;=92651^^12^91^1^^^^1
 ;;^UTILITY(U,$J,358.3,1373,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1373,1,2,0)
 ;;=2^92651
 ;;^UTILITY(U,$J,358.3,1373,1,3,0)
 ;;=3^AEP Hearing Status Determ Broadband Stimuli w/ I&R
 ;;^UTILITY(U,$J,358.3,1374,0)
 ;;=92652^^12^91^4^^^^1
 ;;^UTILITY(U,$J,358.3,1374,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1374,1,2,0)
 ;;=2^92652
 ;;^UTILITY(U,$J,358.3,1374,1,3,0)
 ;;=3^AEP Thrshld Estimation at Multi Freq w/ I&R
 ;;^UTILITY(U,$J,358.3,1375,0)
 ;;=92653^^12^91^2^^^^1
 ;;^UTILITY(U,$J,358.3,1375,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1375,1,2,0)
 ;;=2^92653
 ;;^UTILITY(U,$J,358.3,1375,1,3,0)
 ;;=3^AEP Neurodiagnostic w/ I&R
 ;;^UTILITY(U,$J,358.3,1376,0)
 ;;=20206^^12^92^4^^^^1
 ;;^UTILITY(U,$J,358.3,1376,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1376,1,2,0)
 ;;=2^20206
 ;;^UTILITY(U,$J,358.3,1376,1,3,0)
 ;;=3^Needle Biopsy of Muscle
 ;;^UTILITY(U,$J,358.3,1377,0)
 ;;=64795^^12^92^1^^^^1
 ;;^UTILITY(U,$J,358.3,1377,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1377,1,2,0)
 ;;=2^64795
 ;;^UTILITY(U,$J,358.3,1377,1,3,0)
 ;;=3^Biopsy of Nerve
 ;;^UTILITY(U,$J,358.3,1378,0)
 ;;=20200^^12^92^2^^^^1
 ;;^UTILITY(U,$J,358.3,1378,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1378,1,2,0)
 ;;=2^20200
 ;;^UTILITY(U,$J,358.3,1378,1,3,0)
 ;;=3^Muscle Biopsy, Superficial
 ;;^UTILITY(U,$J,358.3,1379,0)
 ;;=20205^^12^92^3^^^^1
 ;;^UTILITY(U,$J,358.3,1379,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1379,1,2,0)
 ;;=2^20205
 ;;^UTILITY(U,$J,358.3,1379,1,3,0)
 ;;=3^Muscle Biopsy,Deep
 ;;^UTILITY(U,$J,358.3,1380,0)
 ;;=95921^^12^93^1^^^^1
 ;;^UTILITY(U,$J,358.3,1380,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1380,1,2,0)
 ;;=2^95921
 ;;^UTILITY(U,$J,358.3,1380,1,3,0)
 ;;=3^Autonomic Nerv Function Test
 ;;^UTILITY(U,$J,358.3,1381,0)
 ;;=95922^^12^93^2^^^^1
 ;;^UTILITY(U,$J,358.3,1381,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1381,1,2,0)
 ;;=2^95922
 ;;^UTILITY(U,$J,358.3,1381,1,3,0)
 ;;=3^ANS; Vasomotor Adrenergic Innervation
 ;;^UTILITY(U,$J,358.3,1382,0)
 ;;=95923^^12^93^3^^^^1
 ;;^UTILITY(U,$J,358.3,1382,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1382,1,2,0)
 ;;=2^95923
 ;;^UTILITY(U,$J,358.3,1382,1,3,0)
 ;;=3^ANS; Sudomotor
 ;;^UTILITY(U,$J,358.3,1383,0)
 ;;=61796^^12^94^1^^^^1
 ;;^UTILITY(U,$J,358.3,1383,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1383,1,2,0)
 ;;=2^61796
 ;;^UTILITY(U,$J,358.3,1383,1,3,0)
 ;;=3^SRS Cranial Lesion,Simple
 ;;^UTILITY(U,$J,358.3,1384,0)
 ;;=61797^^12^94^2^^^^1
 ;;^UTILITY(U,$J,358.3,1384,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1384,1,2,0)
 ;;=2^61797
 ;;^UTILITY(U,$J,358.3,1384,1,3,0)
 ;;=3^SRS Cranial Lesion,Simple,Addl Lesion
 ;;^UTILITY(U,$J,358.3,1385,0)
 ;;=61800^^12^94^3^^^^1
 ;;^UTILITY(U,$J,358.3,1385,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1385,1,2,0)
 ;;=2^61800
 ;;^UTILITY(U,$J,358.3,1385,1,3,0)
 ;;=3^Apply SRS Headframe,Add-On
 ;;^UTILITY(U,$J,358.3,1386,0)
 ;;=98960^^12^95^1^^^^1
 ;;^UTILITY(U,$J,358.3,1386,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1386,1,2,0)
 ;;=2^98960
 ;;^UTILITY(U,$J,358.3,1386,1,3,0)
 ;;=3^Self-Mgmt Ed/Train,1 Pt
 ;;^UTILITY(U,$J,358.3,1387,0)
 ;;=98961^^12^95^2^^^^1
 ;;^UTILITY(U,$J,358.3,1387,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1387,1,2,0)
 ;;=2^98961
 ;;^UTILITY(U,$J,358.3,1387,1,3,0)
 ;;=3^Self-Mgmt Ed/Train,2-4 Pts
 ;;^UTILITY(U,$J,358.3,1388,0)
 ;;=98962^^12^95^3^^^^1
 ;;^UTILITY(U,$J,358.3,1388,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1388,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,1388,1,3,0)
 ;;=3^Self-Mgmt Ed/Train,5-8 Pts
 ;;^UTILITY(U,$J,358.3,1389,0)
 ;;=95971^^12^96^6^^^^1
 ;;^UTILITY(U,$J,358.3,1389,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1389,1,2,0)
 ;;=2^95971
 ;;^UTILITY(U,$J,358.3,1389,1,3,0)
 ;;=3^Analyze Neurostim,Simple
 ;;^UTILITY(U,$J,358.3,1390,0)
 ;;=95972^^12^96^5^^^^1
 ;;^UTILITY(U,$J,358.3,1390,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1390,1,2,0)
 ;;=2^95972
 ;;^UTILITY(U,$J,358.3,1390,1,3,0)
 ;;=3^Analyze Neurostim,Complex
 ;;^UTILITY(U,$J,358.3,1391,0)
 ;;=95976^^12^96^4^^^^1
 ;;^UTILITY(U,$J,358.3,1391,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1391,1,2,0)
 ;;=2^95976
 ;;^UTILITY(U,$J,358.3,1391,1,3,0)
 ;;=3^Analyze Neurostim w/ Simple Cranial Nerve
 ;;^UTILITY(U,$J,358.3,1392,0)
 ;;=95977^^12^96^3^^^^1
 ;;^UTILITY(U,$J,358.3,1392,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1392,1,2,0)
 ;;=2^95977
 ;;^UTILITY(U,$J,358.3,1392,1,3,0)
 ;;=3^Analyze Neurostim w/ Complex Cranial Nerve
 ;;^UTILITY(U,$J,358.3,1393,0)
 ;;=95983^^12^96^1^^^^1
 ;;^UTILITY(U,$J,358.3,1393,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1393,1,2,0)
 ;;=2^95983
 ;;^UTILITY(U,$J,358.3,1393,1,3,0)
 ;;=3^Analyze Neurostim w/ Brain,1st 15 min
 ;;^UTILITY(U,$J,358.3,1394,0)
 ;;=95984^^12^96^2^^^^1
 ;;^UTILITY(U,$J,358.3,1394,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1394,1,2,0)
 ;;=2^95984
 ;;^UTILITY(U,$J,358.3,1394,1,3,0)
 ;;=3^Analyze Neurostim w/ Brain,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,1395,0)
 ;;=99417^^12^97^1^^^^1
 ;;^UTILITY(U,$J,358.3,1395,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1395,1,2,0)
 ;;=2^99417
 ;;^UTILITY(U,$J,358.3,1395,1,3,0)
 ;;=3^Prolonged Svc,Ea 15 min;Only with 99205 or 99215
 ;;^UTILITY(U,$J,358.3,1396,0)
 ;;=G40.A01^^13^98^3
 ;;^UTILITY(U,$J,358.3,1396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1396,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1396,1,4,0)
 ;;=4^G40.A01
 ;;^UTILITY(U,$J,358.3,1396,2)
 ;;=^5003868
 ;;^UTILITY(U,$J,358.3,1397,0)
 ;;=G40.A09^^13^98^4
 ;;^UTILITY(U,$J,358.3,1397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1397,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1397,1,4,0)
 ;;=4^G40.A09
 ;;^UTILITY(U,$J,358.3,1397,2)
 ;;=^5003869
 ;;^UTILITY(U,$J,358.3,1398,0)
 ;;=G40.A11^^13^98^1
 ;;^UTILITY(U,$J,358.3,1398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1398,1,3,0)
 ;;=3^Absence Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1398,1,4,0)
 ;;=4^G40.A11
 ;;^UTILITY(U,$J,358.3,1398,2)
 ;;=^5003870
 ;;^UTILITY(U,$J,358.3,1399,0)
 ;;=G40.A19^^13^98^2
 ;;^UTILITY(U,$J,358.3,1399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1399,1,3,0)
 ;;=3^Absence Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1399,1,4,0)
 ;;=4^G40.A19
 ;;^UTILITY(U,$J,358.3,1399,2)
 ;;=^5003871
 ;;^UTILITY(U,$J,358.3,1400,0)
 ;;=G40.309^^13^98^17
 ;;^UTILITY(U,$J,358.3,1400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1400,1,3,0)
 ;;=3^Generalized Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1400,1,4,0)
 ;;=4^G40.309
 ;;^UTILITY(U,$J,358.3,1400,2)
 ;;=^5003842
 ;;^UTILITY(U,$J,358.3,1401,0)
 ;;=G40.311^^13^98^15
 ;;^UTILITY(U,$J,358.3,1401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1401,1,3,0)
 ;;=3^Generalized Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1401,1,4,0)
 ;;=4^G40.311
 ;;^UTILITY(U,$J,358.3,1401,2)
 ;;=^5003843
 ;;^UTILITY(U,$J,358.3,1402,0)
 ;;=G40.319^^13^98^16
 ;;^UTILITY(U,$J,358.3,1402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1402,1,3,0)
 ;;=3^Generalized Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1402,1,4,0)
 ;;=4^G40.319
 ;;^UTILITY(U,$J,358.3,1402,2)
 ;;=^5003844
 ;;^UTILITY(U,$J,358.3,1403,0)
 ;;=G40.409^^13^98^20
 ;;^UTILITY(U,$J,358.3,1403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1403,1,3,0)
 ;;=3^Generalized Seizures,Other, Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1403,1,4,0)
 ;;=4^G40.409
 ;;^UTILITY(U,$J,358.3,1403,2)
 ;;=^5003846
 ;;^UTILITY(U,$J,358.3,1404,0)
 ;;=G40.411^^13^98^18
 ;;^UTILITY(U,$J,358.3,1404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1404,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1404,1,4,0)
 ;;=4^G40.411
 ;;^UTILITY(U,$J,358.3,1404,2)
 ;;=^5003847
 ;;^UTILITY(U,$J,358.3,1405,0)
 ;;=G40.419^^13^98^19
 ;;^UTILITY(U,$J,358.3,1405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1405,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1405,1,4,0)
 ;;=4^G40.419
 ;;^UTILITY(U,$J,358.3,1405,2)
 ;;=^5003848
 ;;^UTILITY(U,$J,358.3,1406,0)
 ;;=G40.209^^13^98^7
 ;;^UTILITY(U,$J,358.3,1406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1406,1,3,0)
 ;;=3^Complex Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1406,1,4,0)
 ;;=4^G40.209
 ;;^UTILITY(U,$J,358.3,1406,2)
 ;;=^5003838
 ;;^UTILITY(U,$J,358.3,1407,0)
 ;;=G40.211^^13^98^5
 ;;^UTILITY(U,$J,358.3,1407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1407,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1407,1,4,0)
 ;;=4^G40.211
 ;;^UTILITY(U,$J,358.3,1407,2)
 ;;=^5003839
 ;;^UTILITY(U,$J,358.3,1408,0)
 ;;=G40.219^^13^98^6
 ;;^UTILITY(U,$J,358.3,1408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1408,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1408,1,4,0)
 ;;=4^G40.219
 ;;^UTILITY(U,$J,358.3,1408,2)
 ;;=^5003840
 ;;^UTILITY(U,$J,358.3,1409,0)
 ;;=G40.109^^13^98^28
 ;;^UTILITY(U,$J,358.3,1409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1409,1,3,0)
 ;;=3^Simple Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1409,1,4,0)
 ;;=4^G40.109
 ;;^UTILITY(U,$J,358.3,1409,2)
 ;;=^5003834
 ;;^UTILITY(U,$J,358.3,1410,0)
 ;;=G40.111^^13^98^26
 ;;^UTILITY(U,$J,358.3,1410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1410,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1410,1,4,0)
 ;;=4^G40.111
 ;;^UTILITY(U,$J,358.3,1410,2)
 ;;=^5003835
 ;;^UTILITY(U,$J,358.3,1411,0)
 ;;=G40.119^^13^98^27
 ;;^UTILITY(U,$J,358.3,1411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1411,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1411,1,4,0)
 ;;=4^G40.119
 ;;^UTILITY(U,$J,358.3,1411,2)
 ;;=^5003836
 ;;^UTILITY(U,$J,358.3,1412,0)
 ;;=G40.B09^^13^98^23
 ;;^UTILITY(U,$J,358.3,1412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1412,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1412,1,4,0)
 ;;=4^G40.B09
 ;;^UTILITY(U,$J,358.3,1412,2)
 ;;=^5003873
 ;;^UTILITY(U,$J,358.3,1413,0)
 ;;=G40.B11^^13^98^21
 ;;^UTILITY(U,$J,358.3,1413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1413,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1413,1,4,0)
 ;;=4^G40.B11
 ;;^UTILITY(U,$J,358.3,1413,2)
 ;;=^5003874
 ;;^UTILITY(U,$J,358.3,1414,0)
 ;;=G40.B19^^13^98^22
 ;;^UTILITY(U,$J,358.3,1414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1414,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1414,1,4,0)
 ;;=4^G40.B19
 ;;^UTILITY(U,$J,358.3,1414,2)
 ;;=^5003875
 ;;^UTILITY(U,$J,358.3,1415,0)
 ;;=G40.509^^13^98^14
 ;;^UTILITY(U,$J,358.3,1415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1415,1,3,0)
 ;;=3^Epileptic Seizures d/t External Causes Not Intractalbe w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1415,1,4,0)
 ;;=4^G40.509
 ;;^UTILITY(U,$J,358.3,1415,2)
 ;;=^5003850
 ;;^UTILITY(U,$J,358.3,1416,0)
 ;;=G40.909^^13^98^13
 ;;^UTILITY(U,$J,358.3,1416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1416,1,3,0)
 ;;=3^Epilepsy Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,1416,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,1416,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,1417,0)
 ;;=G40.911^^13^98^10
 ;;^UTILITY(U,$J,358.3,1417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1417,1,3,0)
 ;;=3^Epilepsy Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,1417,1,4,0)
 ;;=4^G40.911
 ;;^UTILITY(U,$J,358.3,1417,2)
 ;;=^5003866
 ;;^UTILITY(U,$J,358.3,1418,0)
 ;;=G40.919^^13^98^11
 ;;^UTILITY(U,$J,358.3,1418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1418,1,3,0)
 ;;=3^Epilepsy Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,1418,1,4,0)
 ;;=4^G40.919
 ;;^UTILITY(U,$J,358.3,1418,2)
 ;;=^5003867
 ;;^UTILITY(U,$J,358.3,1419,0)
 ;;=G93.81^^13^98^24
 ;;^UTILITY(U,$J,358.3,1419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1419,1,3,0)
 ;;=3^Mesial Temporal Sclerosis
 ;;^UTILITY(U,$J,358.3,1419,1,4,0)
 ;;=4^G93.81
 ;;^UTILITY(U,$J,358.3,1419,2)
 ;;=^338233
 ;;^UTILITY(U,$J,358.3,1420,0)
 ;;=F44.5^^13^98^8
 ;;^UTILITY(U,$J,358.3,1420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1420,1,3,0)
 ;;=3^Conversion Disorder w/ Seizures/Convulsions
 ;;^UTILITY(U,$J,358.3,1420,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,1420,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,1421,0)
 ;;=R40.4^^13^98^31
 ;;^UTILITY(U,$J,358.3,1421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1421,1,3,0)
 ;;=3^Transient Alteration of Awareness
 ;;^UTILITY(U,$J,358.3,1421,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,1421,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,1422,0)
 ;;=R40.1^^13^98^30
 ;;^UTILITY(U,$J,358.3,1422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1422,1,3,0)
 ;;=3^Stupor
 ;;^UTILITY(U,$J,358.3,1422,1,4,0)
 ;;=4^R40.1
 ;;^UTILITY(U,$J,358.3,1422,2)
 ;;=^5019353
 ;;^UTILITY(U,$J,358.3,1423,0)
 ;;=R40.0^^13^98^29
 ;;^UTILITY(U,$J,358.3,1423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1423,1,3,0)
 ;;=3^Somnolence
 ;;^UTILITY(U,$J,358.3,1423,1,4,0)
 ;;=4^R40.0
 ;;^UTILITY(U,$J,358.3,1423,2)
 ;;=^5019352
 ;;^UTILITY(U,$J,358.3,1424,0)
 ;;=R56.9^^13^98^9
 ;;^UTILITY(U,$J,358.3,1424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1424,1,3,0)
 ;;=3^Convulsions,Unspec
 ;;^UTILITY(U,$J,358.3,1424,1,4,0)
 ;;=4^R56.9
 ;;^UTILITY(U,$J,358.3,1424,2)
 ;;=^5019524
 ;;^UTILITY(U,$J,358.3,1425,0)
 ;;=R56.1^^13^98^25
 ;;^UTILITY(U,$J,358.3,1425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1425,1,3,0)
 ;;=3^Post Traumatic Seizures
 ;;^UTILITY(U,$J,358.3,1425,1,4,0)
 ;;=4^R56.1
 ;;^UTILITY(U,$J,358.3,1425,2)
 ;;=^5019523
 ;;^UTILITY(U,$J,358.3,1426,0)
 ;;=G40.901^^13^98^12
 ;;^UTILITY(U,$J,358.3,1426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1426,1,3,0)
 ;;=3^Epilepsy Not Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1426,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,1426,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,1427,0)
 ;;=G45.0^^13^99^24
 ;;^UTILITY(U,$J,358.3,1427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1427,1,3,0)
 ;;=3^Vertebro-Basilar Artery Syndrome
 ;;^UTILITY(U,$J,358.3,1427,1,4,0)
 ;;=4^G45.0
 ;;^UTILITY(U,$J,358.3,1427,2)
 ;;=^5003955
 ;;^UTILITY(U,$J,358.3,1428,0)
 ;;=G45.1^^13^99^5
 ;;^UTILITY(U,$J,358.3,1428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1428,1,3,0)
 ;;=3^Carotid Artery Syndrome
 ;;^UTILITY(U,$J,358.3,1428,1,4,0)
 ;;=4^G45.1
 ;;^UTILITY(U,$J,358.3,1428,2)
 ;;=^5003956
