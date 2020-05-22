IBDEI00U ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1465,0)
 ;;=95723^^17^122^10^^^^1
 ;;^UTILITY(U,$J,358.3,1465,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1465,1,2,0)
 ;;=2^95723
 ;;^UTILITY(U,$J,358.3,1465,1,3,0)
 ;;=3^EEG Recording 61-84 Hrs w/o Video
 ;;^UTILITY(U,$J,358.3,1466,0)
 ;;=95724^^17^122^9^^^^1
 ;;^UTILITY(U,$J,358.3,1466,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1466,1,2,0)
 ;;=2^95724
 ;;^UTILITY(U,$J,358.3,1466,1,3,0)
 ;;=3^EEG Recording 61-84 Hrs w/ Video
 ;;^UTILITY(U,$J,358.3,1467,0)
 ;;=95725^^17^122^12^^^^1
 ;;^UTILITY(U,$J,358.3,1467,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1467,1,2,0)
 ;;=2^95725
 ;;^UTILITY(U,$J,358.3,1467,1,3,0)
 ;;=3^EEG Recording > 84 Hrs w/o Video
 ;;^UTILITY(U,$J,358.3,1468,0)
 ;;=95726^^17^122^11^^^^1
 ;;^UTILITY(U,$J,358.3,1468,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1468,1,2,0)
 ;;=2^95726
 ;;^UTILITY(U,$J,358.3,1468,1,3,0)
 ;;=3^EEG Recording > 84 Hrs w/ Video
 ;;^UTILITY(U,$J,358.3,1469,0)
 ;;=95806^^17^123^9^^^^1
 ;;^UTILITY(U,$J,358.3,1469,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1469,1,2,0)
 ;;=2^95806
 ;;^UTILITY(U,$J,358.3,1469,1,3,0)
 ;;=3^Sleep Study/Unattended
 ;;^UTILITY(U,$J,358.3,1470,0)
 ;;=95807^^17^123^8^^^^1
 ;;^UTILITY(U,$J,358.3,1470,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1470,1,2,0)
 ;;=2^95807
 ;;^UTILITY(U,$J,358.3,1470,1,3,0)
 ;;=3^Sleep Study in Hosp/Clinic
 ;;^UTILITY(U,$J,358.3,1471,0)
 ;;=95805^^17^123^3^^^^1
 ;;^UTILITY(U,$J,358.3,1471,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1471,1,2,0)
 ;;=2^95805
 ;;^UTILITY(U,$J,358.3,1471,1,3,0)
 ;;=3^Multiple Sleep Latency Test
 ;;^UTILITY(U,$J,358.3,1472,0)
 ;;=95808^^17^123^4^^^^1
 ;;^UTILITY(U,$J,358.3,1472,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1472,1,2,0)
 ;;=2^95808
 ;;^UTILITY(U,$J,358.3,1472,1,3,0)
 ;;=3^Polysomnography,1-3
 ;;^UTILITY(U,$J,358.3,1473,0)
 ;;=G8839^^17^123^7^^^^1
 ;;^UTILITY(U,$J,358.3,1473,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1473,1,2,0)
 ;;=2^G8839
 ;;^UTILITY(U,$J,358.3,1473,1,3,0)
 ;;=3^Sleep Apnea Assess
 ;;^UTILITY(U,$J,358.3,1474,0)
 ;;=92585^^17^123^2^^^^1
 ;;^UTILITY(U,$J,358.3,1474,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1474,1,2,0)
 ;;=2^92585
 ;;^UTILITY(U,$J,358.3,1474,1,3,0)
 ;;=3^Auditor Evoke Potent,Comprehensive
 ;;^UTILITY(U,$J,358.3,1475,0)
 ;;=95803^^17^123^1^^^^1
 ;;^UTILITY(U,$J,358.3,1475,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1475,1,2,0)
 ;;=2^95803
 ;;^UTILITY(U,$J,358.3,1475,1,3,0)
 ;;=3^Actigraphy Testing (72hrs/14 consecutive days)
 ;;^UTILITY(U,$J,358.3,1476,0)
 ;;=95810^^17^123^5^^^^1
 ;;^UTILITY(U,$J,358.3,1476,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1476,1,2,0)
 ;;=2^95810
 ;;^UTILITY(U,$J,358.3,1476,1,3,0)
 ;;=3^Polysomnography w/ 4+ Parameters         
 ;;^UTILITY(U,$J,358.3,1477,0)
 ;;=95811^^17^123^6^^^^1
 ;;^UTILITY(U,$J,358.3,1477,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1477,1,2,0)
 ;;=2^95811
 ;;^UTILITY(U,$J,358.3,1477,1,3,0)
 ;;=3^Polysomnography w/ 4+ Parameters w/ CPAP
 ;;^UTILITY(U,$J,358.3,1478,0)
 ;;=95860^^17^124^12^^^^1
 ;;^UTILITY(U,$J,358.3,1478,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1478,1,2,0)
 ;;=2^95860
 ;;^UTILITY(U,$J,358.3,1478,1,3,0)
 ;;=3^EMG, one extremity
 ;;^UTILITY(U,$J,358.3,1479,0)
 ;;=95861^^17^124^1^^^^1
 ;;^UTILITY(U,$J,358.3,1479,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1479,1,2,0)
 ;;=2^95861
 ;;^UTILITY(U,$J,358.3,1479,1,3,0)
 ;;=3^EMG, 2 extremities
 ;;^UTILITY(U,$J,358.3,1480,0)
 ;;=95863^^17^124^2^^^^1
 ;;^UTILITY(U,$J,358.3,1480,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1480,1,2,0)
 ;;=2^95863
 ;;^UTILITY(U,$J,358.3,1480,1,3,0)
 ;;=3^EMG, 3 extremities
 ;;^UTILITY(U,$J,358.3,1481,0)
 ;;=95864^^17^124^3^^^^1
 ;;^UTILITY(U,$J,358.3,1481,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1481,1,2,0)
 ;;=2^95864
 ;;^UTILITY(U,$J,358.3,1481,1,3,0)
 ;;=3^EMG, 4 extremities
 ;;^UTILITY(U,$J,358.3,1482,0)
 ;;=95869^^17^124^11^^^^1
 ;;^UTILITY(U,$J,358.3,1482,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1482,1,2,0)
 ;;=2^95869
 ;;^UTILITY(U,$J,358.3,1482,1,3,0)
 ;;=3^EMG, Thoracic Paraspinal Muscles,T-2 to T-11
 ;;^UTILITY(U,$J,358.3,1483,0)
 ;;=95867^^17^124^6^^^^1
 ;;^UTILITY(U,$J,358.3,1483,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1483,1,2,0)
 ;;=2^95867
 ;;^UTILITY(U,$J,358.3,1483,1,3,0)
 ;;=3^EMG, Cranial Nerve supplied Muscles, unilat
 ;;^UTILITY(U,$J,358.3,1484,0)
 ;;=51785^^17^124^4^^^^1
 ;;^UTILITY(U,$J,358.3,1484,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1484,1,2,0)
 ;;=2^51785
 ;;^UTILITY(U,$J,358.3,1484,1,3,0)
 ;;=3^EMG, Anal/Urinary Muscle
 ;;^UTILITY(U,$J,358.3,1485,0)
 ;;=51792^^17^124^28^^^^1
 ;;^UTILITY(U,$J,358.3,1485,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1485,1,2,0)
 ;;=2^51792
 ;;^UTILITY(U,$J,358.3,1485,1,3,0)
 ;;=3^Urinary Reflex Study
 ;;^UTILITY(U,$J,358.3,1486,0)
 ;;=95865^^17^124^8^^^^1
 ;;^UTILITY(U,$J,358.3,1486,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1486,1,2,0)
 ;;=2^95865
 ;;^UTILITY(U,$J,358.3,1486,1,3,0)
 ;;=3^EMG, Larynx
 ;;^UTILITY(U,$J,358.3,1487,0)
 ;;=95866^^17^124^7^^^^1
 ;;^UTILITY(U,$J,358.3,1487,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1487,1,2,0)
 ;;=2^95866
 ;;^UTILITY(U,$J,358.3,1487,1,3,0)
 ;;=3^EMG, Hemidiaphragm
 ;;^UTILITY(U,$J,358.3,1488,0)
 ;;=95870^^17^124^9^^^^1
 ;;^UTILITY(U,$J,358.3,1488,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1488,1,2,0)
 ;;=2^95870
 ;;^UTILITY(U,$J,358.3,1488,1,3,0)
 ;;=3^EMG, Limited-One extremity
 ;;^UTILITY(U,$J,358.3,1489,0)
 ;;=95872^^17^124^10^^^^1
 ;;^UTILITY(U,$J,358.3,1489,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1489,1,2,0)
 ;;=2^95872
 ;;^UTILITY(U,$J,358.3,1489,1,3,0)
 ;;=3^EMG, Single Fiber Electrode
 ;;^UTILITY(U,$J,358.3,1490,0)
 ;;=95873^^17^124^16^^^^1
 ;;^UTILITY(U,$J,358.3,1490,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1490,1,2,0)
 ;;=2^95873
 ;;^UTILITY(U,$J,358.3,1490,1,3,0)
 ;;=3^Elec Stim,Guide chemodenervation
 ;;^UTILITY(U,$J,358.3,1491,0)
 ;;=95874^^17^124^26^^^^1
 ;;^UTILITY(U,$J,358.3,1491,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1491,1,2,0)
 ;;=2^95874
 ;;^UTILITY(U,$J,358.3,1491,1,3,0)
 ;;=3^Needle EMG,Guide Chemodenervation
 ;;^UTILITY(U,$J,358.3,1492,0)
 ;;=95875^^17^124^17^^^^1
 ;;^UTILITY(U,$J,358.3,1492,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1492,1,2,0)
 ;;=2^95875
 ;;^UTILITY(U,$J,358.3,1492,1,3,0)
 ;;=3^Ischemic limb exercise test
 ;;^UTILITY(U,$J,358.3,1493,0)
 ;;=95885^^17^124^14^^^^1
 ;;^UTILITY(U,$J,358.3,1493,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1493,1,2,0)
 ;;=2^95885
 ;;^UTILITY(U,$J,358.3,1493,1,3,0)
 ;;=3^EMG,ea extrem w/nerve conduction;limited
 ;;^UTILITY(U,$J,358.3,1494,0)
 ;;=95886^^17^124^13^^^^1
 ;;^UTILITY(U,$J,358.3,1494,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1494,1,2,0)
 ;;=2^95886
 ;;^UTILITY(U,$J,358.3,1494,1,3,0)
 ;;=3^EMG,>4 muscles,>2 nerves/>3 spinal levels
 ;;^UTILITY(U,$J,358.3,1495,0)
 ;;=95887^^17^124^15^^^^1
 ;;^UTILITY(U,$J,358.3,1495,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1495,1,2,0)
 ;;=2^95887
 ;;^UTILITY(U,$J,358.3,1495,1,3,0)
 ;;=3^EMG,non-extremity w/nerve conduction
 ;;^UTILITY(U,$J,358.3,1496,0)
 ;;=95868^^17^124^5^^^^1
 ;;^UTILITY(U,$J,358.3,1496,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1496,1,2,0)
 ;;=2^95868
 ;;^UTILITY(U,$J,358.3,1496,1,3,0)
 ;;=3^EMG, Cranial Nerve supplied Muscles, bil
 ;;^UTILITY(U,$J,358.3,1497,0)
 ;;=95905^^17^124^18^^^^1
 ;;^UTILITY(U,$J,358.3,1497,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1497,1,2,0)
 ;;=2^95905
 ;;^UTILITY(U,$J,358.3,1497,1,3,0)
 ;;=3^Motor&Sens NCS, preconf electrode,ea limb
 ;;^UTILITY(U,$J,358.3,1498,0)
 ;;=95907^^17^124^19^^^^1
 ;;^UTILITY(U,$J,358.3,1498,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1498,1,2,0)
 ;;=2^95907
 ;;^UTILITY(U,$J,358.3,1498,1,3,0)
 ;;=3^NCS,1-2 Studies
 ;;^UTILITY(U,$J,358.3,1499,0)
 ;;=95908^^17^124^22^^^^1
 ;;^UTILITY(U,$J,358.3,1499,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1499,1,2,0)
 ;;=2^95908
 ;;^UTILITY(U,$J,358.3,1499,1,3,0)
 ;;=3^NCS,3-4 Studies
 ;;^UTILITY(U,$J,358.3,1500,0)
 ;;=95909^^17^124^23^^^^1
 ;;^UTILITY(U,$J,358.3,1500,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1500,1,2,0)
 ;;=2^95909
 ;;^UTILITY(U,$J,358.3,1500,1,3,0)
 ;;=3^NCS,5-6 Studies
 ;;^UTILITY(U,$J,358.3,1501,0)
 ;;=95910^^17^124^24^^^^1
 ;;^UTILITY(U,$J,358.3,1501,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1501,1,2,0)
 ;;=2^95910
 ;;^UTILITY(U,$J,358.3,1501,1,3,0)
 ;;=3^NCS,7-8 Studies
 ;;^UTILITY(U,$J,358.3,1502,0)
 ;;=95911^^17^124^25^^^^1
 ;;^UTILITY(U,$J,358.3,1502,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1502,1,2,0)
 ;;=2^95911
 ;;^UTILITY(U,$J,358.3,1502,1,3,0)
 ;;=3^NCS,9-10 Studies
 ;;^UTILITY(U,$J,358.3,1503,0)
 ;;=95912^^17^124^20^^^^1
 ;;^UTILITY(U,$J,358.3,1503,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1503,1,2,0)
 ;;=2^95912
 ;;^UTILITY(U,$J,358.3,1503,1,3,0)
 ;;=3^NCS,11-12 Studies
 ;;^UTILITY(U,$J,358.3,1504,0)
 ;;=95913^^17^124^21^^^^1
 ;;^UTILITY(U,$J,358.3,1504,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1504,1,2,0)
 ;;=2^95913
 ;;^UTILITY(U,$J,358.3,1504,1,3,0)
 ;;=3^NCS,13 or More Studies
 ;;^UTILITY(U,$J,358.3,1505,0)
 ;;=95937^^17^124^27^^^^1
 ;;^UTILITY(U,$J,358.3,1505,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1505,1,2,0)
 ;;=2^95937
 ;;^UTILITY(U,$J,358.3,1505,1,3,0)
 ;;=3^Neuromuscular Junction Test
 ;;^UTILITY(U,$J,358.3,1506,0)
 ;;=95925^^17^125^7^^^^1
 ;;^UTILITY(U,$J,358.3,1506,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1506,1,2,0)
 ;;=2^95925
 ;;^UTILITY(U,$J,358.3,1506,1,3,0)
 ;;=3^Short Latency SSEP, Periph Nerve, Upper Ext
 ;;^UTILITY(U,$J,358.3,1507,0)
 ;;=95926^^17^125^5^^^^1
 ;;^UTILITY(U,$J,358.3,1507,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1507,1,2,0)
 ;;=2^95926
 ;;^UTILITY(U,$J,358.3,1507,1,3,0)
 ;;=3^Short Latency SSEP, Periph Nerve, Lower Ext
 ;;^UTILITY(U,$J,358.3,1508,0)
 ;;=95927^^17^125^6^^^^1
 ;;^UTILITY(U,$J,358.3,1508,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1508,1,2,0)
 ;;=2^95927
 ;;^UTILITY(U,$J,358.3,1508,1,3,0)
 ;;=3^Short Latency SSEP, Periph Nerve, Trunk/Head
 ;;^UTILITY(U,$J,358.3,1509,0)
 ;;=95930^^17^125^9^^^^1
 ;;^UTILITY(U,$J,358.3,1509,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1509,1,2,0)
 ;;=2^95930
 ;;^UTILITY(U,$J,358.3,1509,1,3,0)
 ;;=3^Visual Evoked Potential
 ;;^UTILITY(U,$J,358.3,1510,0)
 ;;=95933^^17^125^1^^^^1
 ;;^UTILITY(U,$J,358.3,1510,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1510,1,2,0)
 ;;=2^95933
 ;;^UTILITY(U,$J,358.3,1510,1,3,0)
 ;;=3^Blink Reflex Test
 ;;^UTILITY(U,$J,358.3,1511,0)
 ;;=95937^^17^125^4^^^^1
 ;;^UTILITY(U,$J,358.3,1511,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1511,1,2,0)
 ;;=2^95937
 ;;^UTILITY(U,$J,358.3,1511,1,3,0)
 ;;=3^Neuromuscular Junction Test
 ;;^UTILITY(U,$J,358.3,1512,0)
 ;;=95938^^17^125^8^^^^1
 ;;^UTILITY(U,$J,358.3,1512,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1512,1,2,0)
 ;;=2^95938
 ;;^UTILITY(U,$J,358.3,1512,1,3,0)
 ;;=3^Short Latency SSEP,Periph Nerve,Upper&Lower
 ;;^UTILITY(U,$J,358.3,1513,0)
 ;;=20206^^17^126^4^^^^1
 ;;^UTILITY(U,$J,358.3,1513,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1513,1,2,0)
 ;;=2^20206
 ;;^UTILITY(U,$J,358.3,1513,1,3,0)
 ;;=3^Needle Biopsy of Muscle
 ;;^UTILITY(U,$J,358.3,1514,0)
 ;;=64795^^17^126^1^^^^1
 ;;^UTILITY(U,$J,358.3,1514,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1514,1,2,0)
 ;;=2^64795
 ;;^UTILITY(U,$J,358.3,1514,1,3,0)
 ;;=3^Biopsy of Nerve
 ;;^UTILITY(U,$J,358.3,1515,0)
 ;;=20200^^17^126^2^^^^1
 ;;^UTILITY(U,$J,358.3,1515,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1515,1,2,0)
 ;;=2^20200
 ;;^UTILITY(U,$J,358.3,1515,1,3,0)
 ;;=3^Muscle Biopsy, Superficial
 ;;^UTILITY(U,$J,358.3,1516,0)
 ;;=20205^^17^126^3^^^^1
 ;;^UTILITY(U,$J,358.3,1516,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1516,1,2,0)
 ;;=2^20205
 ;;^UTILITY(U,$J,358.3,1516,1,3,0)
 ;;=3^Muscle Biopsy,Deep
 ;;^UTILITY(U,$J,358.3,1517,0)
 ;;=95921^^17^127^1^^^^1
 ;;^UTILITY(U,$J,358.3,1517,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1517,1,2,0)
 ;;=2^95921
 ;;^UTILITY(U,$J,358.3,1517,1,3,0)
 ;;=3^Autonomic Nerv Function Test
 ;;^UTILITY(U,$J,358.3,1518,0)
 ;;=95922^^17^127^2^^^^1
 ;;^UTILITY(U,$J,358.3,1518,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1518,1,2,0)
 ;;=2^95922
 ;;^UTILITY(U,$J,358.3,1518,1,3,0)
 ;;=3^ANS; Vasomotor Adrenergic Innervation
 ;;^UTILITY(U,$J,358.3,1519,0)
 ;;=95923^^17^127^3^^^^1
 ;;^UTILITY(U,$J,358.3,1519,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1519,1,2,0)
 ;;=2^95923
 ;;^UTILITY(U,$J,358.3,1519,1,3,0)
 ;;=3^ANS; Sudomotor
 ;;^UTILITY(U,$J,358.3,1520,0)
 ;;=61796^^17^128^1^^^^1
 ;;^UTILITY(U,$J,358.3,1520,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1520,1,2,0)
 ;;=2^61796
 ;;^UTILITY(U,$J,358.3,1520,1,3,0)
 ;;=3^SRS Cranial Lesion,Simple
 ;;^UTILITY(U,$J,358.3,1521,0)
 ;;=61797^^17^128^2^^^^1
 ;;^UTILITY(U,$J,358.3,1521,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1521,1,2,0)
 ;;=2^61797
 ;;^UTILITY(U,$J,358.3,1521,1,3,0)
 ;;=3^SRS Cranial Lesion,Simple,Addl Lesion
 ;;^UTILITY(U,$J,358.3,1522,0)
 ;;=61800^^17^128^3^^^^1
 ;;^UTILITY(U,$J,358.3,1522,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1522,1,2,0)
 ;;=2^61800
 ;;^UTILITY(U,$J,358.3,1522,1,3,0)
 ;;=3^Apply SRS Headframe,Add-On
 ;;^UTILITY(U,$J,358.3,1523,0)
 ;;=98960^^17^129^1^^^^1
 ;;^UTILITY(U,$J,358.3,1523,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1523,1,2,0)
 ;;=2^98960
 ;;^UTILITY(U,$J,358.3,1523,1,3,0)
 ;;=3^Self-Mgmt Ed/Train,1 Pt
 ;;^UTILITY(U,$J,358.3,1524,0)
 ;;=98961^^17^129^2^^^^1
 ;;^UTILITY(U,$J,358.3,1524,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1524,1,2,0)
 ;;=2^98961
 ;;^UTILITY(U,$J,358.3,1524,1,3,0)
 ;;=3^Self-Mgmt Ed/Train,2-4 Pts
 ;;^UTILITY(U,$J,358.3,1525,0)
 ;;=98962^^17^129^3^^^^1
 ;;^UTILITY(U,$J,358.3,1525,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1525,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,1525,1,3,0)
 ;;=3^Self-Mgmt Ed/Train,5-8 Pts
 ;;^UTILITY(U,$J,358.3,1526,0)
 ;;=95971^^17^130^6^^^^1
 ;;^UTILITY(U,$J,358.3,1526,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1526,1,2,0)
 ;;=2^95971
 ;;^UTILITY(U,$J,358.3,1526,1,3,0)
 ;;=3^Analyze Neurostim,Simple
 ;;^UTILITY(U,$J,358.3,1527,0)
 ;;=95972^^17^130^5^^^^1
 ;;^UTILITY(U,$J,358.3,1527,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1527,1,2,0)
 ;;=2^95972
 ;;^UTILITY(U,$J,358.3,1527,1,3,0)
 ;;=3^Analyze Neurostim,Complex
 ;;^UTILITY(U,$J,358.3,1528,0)
 ;;=95976^^17^130^4^^^^1
 ;;^UTILITY(U,$J,358.3,1528,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1528,1,2,0)
 ;;=2^95976
 ;;^UTILITY(U,$J,358.3,1528,1,3,0)
 ;;=3^Analyze Neurostim w/ Simple Cranial Nerve
 ;;^UTILITY(U,$J,358.3,1529,0)
 ;;=95977^^17^130^3^^^^1
 ;;^UTILITY(U,$J,358.3,1529,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1529,1,2,0)
 ;;=2^95977
 ;;^UTILITY(U,$J,358.3,1529,1,3,0)
 ;;=3^Analyze Neurostim w/ Complex Cranial Nerve
 ;;^UTILITY(U,$J,358.3,1530,0)
 ;;=95983^^17^130^1^^^^1
 ;;^UTILITY(U,$J,358.3,1530,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1530,1,2,0)
 ;;=2^95983
 ;;^UTILITY(U,$J,358.3,1530,1,3,0)
 ;;=3^Analyze Neurostim w/ Brain,1st 15 min
 ;;^UTILITY(U,$J,358.3,1531,0)
 ;;=95984^^17^130^2^^^^1
 ;;^UTILITY(U,$J,358.3,1531,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1531,1,2,0)
 ;;=2^95984
 ;;^UTILITY(U,$J,358.3,1531,1,3,0)
 ;;=3^Analyze Neurostim w/ Brain,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,1532,0)
 ;;=G40.A01^^18^131^3
 ;;^UTILITY(U,$J,358.3,1532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1532,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1532,1,4,0)
 ;;=4^G40.A01
 ;;^UTILITY(U,$J,358.3,1532,2)
 ;;=^5003868
 ;;^UTILITY(U,$J,358.3,1533,0)
 ;;=G40.A09^^18^131^4
 ;;^UTILITY(U,$J,358.3,1533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1533,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1533,1,4,0)
 ;;=4^G40.A09
 ;;^UTILITY(U,$J,358.3,1533,2)
 ;;=^5003869
 ;;^UTILITY(U,$J,358.3,1534,0)
 ;;=G40.A11^^18^131^1
 ;;^UTILITY(U,$J,358.3,1534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1534,1,3,0)
 ;;=3^Absence Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1534,1,4,0)
 ;;=4^G40.A11
 ;;^UTILITY(U,$J,358.3,1534,2)
 ;;=^5003870
 ;;^UTILITY(U,$J,358.3,1535,0)
 ;;=G40.A19^^18^131^2
 ;;^UTILITY(U,$J,358.3,1535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1535,1,3,0)
 ;;=3^Absence Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1535,1,4,0)
 ;;=4^G40.A19
 ;;^UTILITY(U,$J,358.3,1535,2)
 ;;=^5003871
 ;;^UTILITY(U,$J,358.3,1536,0)
 ;;=G40.309^^18^131^17
 ;;^UTILITY(U,$J,358.3,1536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1536,1,3,0)
 ;;=3^Generalized Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1536,1,4,0)
 ;;=4^G40.309
 ;;^UTILITY(U,$J,358.3,1536,2)
 ;;=^5003842
 ;;^UTILITY(U,$J,358.3,1537,0)
 ;;=G40.311^^18^131^15
 ;;^UTILITY(U,$J,358.3,1537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1537,1,3,0)
 ;;=3^Generalized Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1537,1,4,0)
 ;;=4^G40.311
 ;;^UTILITY(U,$J,358.3,1537,2)
 ;;=^5003843
 ;;^UTILITY(U,$J,358.3,1538,0)
 ;;=G40.319^^18^131^16
 ;;^UTILITY(U,$J,358.3,1538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1538,1,3,0)
 ;;=3^Generalized Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1538,1,4,0)
 ;;=4^G40.319
 ;;^UTILITY(U,$J,358.3,1538,2)
 ;;=^5003844
 ;;^UTILITY(U,$J,358.3,1539,0)
 ;;=G40.409^^18^131^20
 ;;^UTILITY(U,$J,358.3,1539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1539,1,3,0)
 ;;=3^Generalized Seizures,Other, Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1539,1,4,0)
 ;;=4^G40.409
 ;;^UTILITY(U,$J,358.3,1539,2)
 ;;=^5003846
 ;;^UTILITY(U,$J,358.3,1540,0)
 ;;=G40.411^^18^131^18
 ;;^UTILITY(U,$J,358.3,1540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1540,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1540,1,4,0)
 ;;=4^G40.411
 ;;^UTILITY(U,$J,358.3,1540,2)
 ;;=^5003847
 ;;^UTILITY(U,$J,358.3,1541,0)
 ;;=G40.419^^18^131^19
 ;;^UTILITY(U,$J,358.3,1541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1541,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1541,1,4,0)
 ;;=4^G40.419
 ;;^UTILITY(U,$J,358.3,1541,2)
 ;;=^5003848
 ;;^UTILITY(U,$J,358.3,1542,0)
 ;;=G40.209^^18^131^7
 ;;^UTILITY(U,$J,358.3,1542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1542,1,3,0)
 ;;=3^Complex Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1542,1,4,0)
 ;;=4^G40.209
 ;;^UTILITY(U,$J,358.3,1542,2)
 ;;=^5003838
 ;;^UTILITY(U,$J,358.3,1543,0)
 ;;=G40.211^^18^131^5
 ;;^UTILITY(U,$J,358.3,1543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1543,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1543,1,4,0)
 ;;=4^G40.211
 ;;^UTILITY(U,$J,358.3,1543,2)
 ;;=^5003839
 ;;^UTILITY(U,$J,358.3,1544,0)
 ;;=G40.219^^18^131^6
 ;;^UTILITY(U,$J,358.3,1544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1544,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1544,1,4,0)
 ;;=4^G40.219
