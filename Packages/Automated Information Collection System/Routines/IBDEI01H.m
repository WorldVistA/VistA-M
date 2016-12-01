IBDEI01H ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1388,1,3,0)
 ;;=3^Cardiac Arrest,Cause Unspec
 ;;^UTILITY(U,$J,358.3,1388,1,4,0)
 ;;=4^I46.9
 ;;^UTILITY(U,$J,358.3,1388,2)
 ;;=^5007221
 ;;^UTILITY(U,$J,358.3,1389,0)
 ;;=I46.8^^8^115^16
 ;;^UTILITY(U,$J,358.3,1389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1389,1,3,0)
 ;;=3^Cardiac Arrest d/t Underlying Condition
 ;;^UTILITY(U,$J,358.3,1389,1,4,0)
 ;;=4^I46.8
 ;;^UTILITY(U,$J,358.3,1389,2)
 ;;=^5007220
 ;;^UTILITY(U,$J,358.3,1390,0)
 ;;=I46.2^^8^115^15
 ;;^UTILITY(U,$J,358.3,1390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1390,1,3,0)
 ;;=3^Cardiac Arrest d/t Underlying Cardiac Condition
 ;;^UTILITY(U,$J,358.3,1390,1,4,0)
 ;;=4^I46.2
 ;;^UTILITY(U,$J,358.3,1390,2)
 ;;=^5007219
 ;;^UTILITY(U,$J,358.3,1391,0)
 ;;=I49.40^^8^115^37
 ;;^UTILITY(U,$J,358.3,1391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1391,1,3,0)
 ;;=3^Premature Depolarization,Unspec
 ;;^UTILITY(U,$J,358.3,1391,1,4,0)
 ;;=4^I49.40
 ;;^UTILITY(U,$J,358.3,1391,2)
 ;;=^5007234
 ;;^UTILITY(U,$J,358.3,1392,0)
 ;;=I49.1^^8^115^10
 ;;^UTILITY(U,$J,358.3,1392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1392,1,3,0)
 ;;=3^Atrial Premature Depolarization
 ;;^UTILITY(U,$J,358.3,1392,1,4,0)
 ;;=4^I49.1
 ;;^UTILITY(U,$J,358.3,1392,2)
 ;;=^5007231
 ;;^UTILITY(U,$J,358.3,1393,0)
 ;;=I49.49^^8^115^36
 ;;^UTILITY(U,$J,358.3,1393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1393,1,3,0)
 ;;=3^Premature Depolarization NEC
 ;;^UTILITY(U,$J,358.3,1393,1,4,0)
 ;;=4^I49.49
 ;;^UTILITY(U,$J,358.3,1393,2)
 ;;=^5007235
 ;;^UTILITY(U,$J,358.3,1394,0)
 ;;=I49.5^^8^115^44
 ;;^UTILITY(U,$J,358.3,1394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1394,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,1394,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,1394,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,1395,0)
 ;;=R00.1^^8^115^12
 ;;^UTILITY(U,$J,358.3,1395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1395,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,1395,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,1395,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,1396,0)
 ;;=T82.110A^^8^115^13
 ;;^UTILITY(U,$J,358.3,1396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1396,1,3,0)
 ;;=3^Breakdown of Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,1396,1,4,0)
 ;;=4^T82.110A
 ;;^UTILITY(U,$J,358.3,1396,2)
 ;;=^5054680
 ;;^UTILITY(U,$J,358.3,1397,0)
 ;;=T82.111A^^8^115^14
 ;;^UTILITY(U,$J,358.3,1397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1397,1,3,0)
 ;;=3^Breakdown of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,1397,1,4,0)
 ;;=4^T82.111A
 ;;^UTILITY(U,$J,358.3,1397,2)
 ;;=^5054683
 ;;^UTILITY(U,$J,358.3,1398,0)
 ;;=T82.120A^^8^115^22
 ;;^UTILITY(U,$J,358.3,1398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1398,1,3,0)
 ;;=3^Displacement of Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,1398,1,4,0)
 ;;=4^T82.120A
 ;;^UTILITY(U,$J,358.3,1398,2)
 ;;=^5054692
 ;;^UTILITY(U,$J,358.3,1399,0)
 ;;=T82.121A^^8^115^23
 ;;^UTILITY(U,$J,358.3,1399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1399,1,3,0)
 ;;=3^Displacement of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,1399,1,4,0)
 ;;=4^T82.121A
 ;;^UTILITY(U,$J,358.3,1399,2)
 ;;=^5054695
 ;;^UTILITY(U,$J,358.3,1400,0)
 ;;=T82.190A^^8^115^31
 ;;^UTILITY(U,$J,358.3,1400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1400,1,3,0)
 ;;=3^Mech Compl of Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,1400,1,4,0)
 ;;=4^T82.190A
 ;;^UTILITY(U,$J,358.3,1400,2)
 ;;=^5054704
 ;;^UTILITY(U,$J,358.3,1401,0)
 ;;=T82.191A^^8^115^32
 ;;^UTILITY(U,$J,358.3,1401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1401,1,3,0)
 ;;=3^Mech Compl of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,1401,1,4,0)
 ;;=4^T82.191A
 ;;^UTILITY(U,$J,358.3,1401,2)
 ;;=^5054707
 ;;^UTILITY(U,$J,358.3,1402,0)
 ;;=Z95.0^^8^115^39
 ;;^UTILITY(U,$J,358.3,1402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1402,1,3,0)
 ;;=3^Presence of Cardiac Pacemaker
 ;;^UTILITY(U,$J,358.3,1402,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,1402,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,1403,0)
 ;;=Z95.810^^8^115^38
 ;;^UTILITY(U,$J,358.3,1403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1403,1,3,0)
 ;;=3^Presence of Automatic Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,1403,1,4,0)
 ;;=4^Z95.810
 ;;^UTILITY(U,$J,358.3,1403,2)
 ;;=^5063674
 ;;^UTILITY(U,$J,358.3,1404,0)
 ;;=Z45.010^^8^115^20
 ;;^UTILITY(U,$J,358.3,1404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1404,1,3,0)
 ;;=3^Check/Test Cardiac Pacemaker Pulse Generator
 ;;^UTILITY(U,$J,358.3,1404,1,4,0)
 ;;=4^Z45.010
 ;;^UTILITY(U,$J,358.3,1404,2)
 ;;=^5062994
 ;;^UTILITY(U,$J,358.3,1405,0)
 ;;=Z45.018^^8^115^6
 ;;^UTILITY(U,$J,358.3,1405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1405,1,3,0)
 ;;=3^Adjust/Manage Cardiac Pacemaker Parts
 ;;^UTILITY(U,$J,358.3,1405,1,4,0)
 ;;=4^Z45.018
 ;;^UTILITY(U,$J,358.3,1405,2)
 ;;=^5062995
 ;;^UTILITY(U,$J,358.3,1406,0)
 ;;=Z45.02^^8^115^5
 ;;^UTILITY(U,$J,358.3,1406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1406,1,3,0)
 ;;=3^Adjust/Manage Automatic Implantable Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,1406,1,4,0)
 ;;=4^Z45.02
 ;;^UTILITY(U,$J,358.3,1406,2)
 ;;=^5062996
 ;;^UTILITY(U,$J,358.3,1407,0)
 ;;=I48.3^^8^115^9
 ;;^UTILITY(U,$J,358.3,1407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1407,1,3,0)
 ;;=3^Atrial Flutter,Typical
 ;;^UTILITY(U,$J,358.3,1407,1,4,0)
 ;;=4^I48.3
 ;;^UTILITY(U,$J,358.3,1407,2)
 ;;=^5007227
 ;;^UTILITY(U,$J,358.3,1408,0)
 ;;=I48.4^^8^115^8
 ;;^UTILITY(U,$J,358.3,1408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1408,1,3,0)
 ;;=3^Atrial Flutter,Atypical
 ;;^UTILITY(U,$J,358.3,1408,1,4,0)
 ;;=4^I48.4
 ;;^UTILITY(U,$J,358.3,1408,2)
 ;;=^5007228
 ;;^UTILITY(U,$J,358.3,1409,0)
 ;;=I25.5^^8^115^19
 ;;^UTILITY(U,$J,358.3,1409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1409,1,3,0)
 ;;=3^Cardiomyopathy,Ischemic
 ;;^UTILITY(U,$J,358.3,1409,1,4,0)
 ;;=4^I25.5
 ;;^UTILITY(U,$J,358.3,1409,2)
 ;;=^5007115
 ;;^UTILITY(U,$J,358.3,1410,0)
 ;;=I42.0^^8^115^18
 ;;^UTILITY(U,$J,358.3,1410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1410,1,3,0)
 ;;=3^Cardiomyopathy,Dilated
 ;;^UTILITY(U,$J,358.3,1410,1,4,0)
 ;;=4^I42.0
 ;;^UTILITY(U,$J,358.3,1410,2)
 ;;=^5007194
 ;;^UTILITY(U,$J,358.3,1411,0)
 ;;=I25.110^^8^116^15
 ;;^UTILITY(U,$J,358.3,1411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1411,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Cor Art w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1411,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,1411,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,1412,0)
 ;;=I25.700^^8^116^34
 ;;^UTILITY(U,$J,358.3,1412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1412,1,3,0)
 ;;=3^Athscl of CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1412,1,4,0)
 ;;=4^I25.700
 ;;^UTILITY(U,$J,358.3,1412,2)
 ;;=^5007117
 ;;^UTILITY(U,$J,358.3,1413,0)
 ;;=I25.710^^8^116^10
 ;;^UTILITY(U,$J,358.3,1413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1413,1,3,0)
 ;;=3^Athscl Autologous Vein CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1413,1,4,0)
 ;;=4^I25.710
 ;;^UTILITY(U,$J,358.3,1413,2)
 ;;=^5007121
 ;;^UTILITY(U,$J,358.3,1414,0)
 ;;=I25.720^^8^116^6
 ;;^UTILITY(U,$J,358.3,1414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1414,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1414,1,4,0)
 ;;=4^I25.720
 ;;^UTILITY(U,$J,358.3,1414,2)
 ;;=^5007125
 ;;^UTILITY(U,$J,358.3,1415,0)
 ;;=I25.730^^8^116^24
 ;;^UTILITY(U,$J,358.3,1415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1415,1,3,0)
 ;;=3^Athscl Nonautologous Biological CABG w/ Unstable Angina Pectoris
 ;;^UTILITY(U,$J,358.3,1415,1,4,0)
 ;;=4^I25.730
 ;;^UTILITY(U,$J,358.3,1415,2)
 ;;=^5007127
 ;;^UTILITY(U,$J,358.3,1416,0)
 ;;=I25.750^^8^116^19
 ;;^UTILITY(U,$J,358.3,1416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1416,1,3,0)
 ;;=3^Athscl Native Cor Art of Transplanted Hrt w/ Unstable Angina
 ;;^UTILITY(U,$J,358.3,1416,1,4,0)
 ;;=4^I25.750
 ;;^UTILITY(U,$J,358.3,1416,2)
 ;;=^5007131
 ;;^UTILITY(U,$J,358.3,1417,0)
 ;;=I25.760^^8^116^11
 ;;^UTILITY(U,$J,358.3,1417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1417,1,3,0)
 ;;=3^Athscl Bypass of Cor Art of Transplanted Hrt w/ Unstable Angina
 ;;^UTILITY(U,$J,358.3,1417,1,4,0)
 ;;=4^I25.760
 ;;^UTILITY(U,$J,358.3,1417,2)
 ;;=^5007135
 ;;^UTILITY(U,$J,358.3,1418,0)
 ;;=I25.790^^8^116^35
 ;;^UTILITY(U,$J,358.3,1418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1418,1,3,0)
 ;;=3^Athscl of CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1418,1,4,0)
 ;;=4^I25.790
 ;;^UTILITY(U,$J,358.3,1418,2)
 ;;=^5007139
 ;;^UTILITY(U,$J,358.3,1419,0)
 ;;=I20.0^^8^116^42
 ;;^UTILITY(U,$J,358.3,1419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1419,1,3,0)
 ;;=3^Unstable Angina
 ;;^UTILITY(U,$J,358.3,1419,1,4,0)
 ;;=4^I20.0
 ;;^UTILITY(U,$J,358.3,1419,2)
 ;;=^5007076
 ;;^UTILITY(U,$J,358.3,1420,0)
 ;;=I25.759^^8^116^20
 ;;^UTILITY(U,$J,358.3,1420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1420,1,3,0)
 ;;=3^Athscl Native Cor Art of Transplanted Hrt w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,1420,1,4,0)
 ;;=4^I25.759
 ;;^UTILITY(U,$J,358.3,1420,2)
 ;;=^5007134
 ;;^UTILITY(U,$J,358.3,1421,0)
 ;;=I25.761^^8^116^12
 ;;^UTILITY(U,$J,358.3,1421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1421,1,3,0)
 ;;=3^Athscl Bypass of Cor Art of Transplanted Hrt w/ Ang Pctrs w/ Spasm
 ;;^UTILITY(U,$J,358.3,1421,1,4,0)
 ;;=4^I25.761
 ;;^UTILITY(U,$J,358.3,1421,2)
 ;;=^5007136
 ;;^UTILITY(U,$J,358.3,1422,0)
 ;;=I25.768^^8^116^13
 ;;^UTILITY(U,$J,358.3,1422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1422,1,3,0)
 ;;=3^Athscl Bypass of Cor Art of Transplanted Hrt w/ Oth Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1422,1,4,0)
 ;;=4^I25.768
 ;;^UTILITY(U,$J,358.3,1422,2)
 ;;=^5007137
 ;;^UTILITY(U,$J,358.3,1423,0)
 ;;=I25.769^^8^116^14
 ;;^UTILITY(U,$J,358.3,1423,1,0)
 ;;=^358.31IA^4^2
