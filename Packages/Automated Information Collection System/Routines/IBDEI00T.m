IBDEI00T ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1385,1,3,0)
 ;;=3^Paternity Testing
 ;;^UTILITY(U,$J,358.3,1385,1,4,0)
 ;;=4^Z02.81
 ;;^UTILITY(U,$J,358.3,1385,2)
 ;;=^5062642
 ;;^UTILITY(U,$J,358.3,1386,0)
 ;;=Z02.3^^15^112^11
 ;;^UTILITY(U,$J,358.3,1386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1386,1,3,0)
 ;;=3^Recruitment to Armed Forces Exam
 ;;^UTILITY(U,$J,358.3,1386,1,4,0)
 ;;=4^Z02.3
 ;;^UTILITY(U,$J,358.3,1386,2)
 ;;=^5062636
 ;;^UTILITY(U,$J,358.3,1387,0)
 ;;=Z02.1^^15^112^10
 ;;^UTILITY(U,$J,358.3,1387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1387,1,3,0)
 ;;=3^Pre-Employment Exam
 ;;^UTILITY(U,$J,358.3,1387,1,4,0)
 ;;=4^Z02.1
 ;;^UTILITY(U,$J,358.3,1387,2)
 ;;=^5062634
 ;;^UTILITY(U,$J,358.3,1388,0)
 ;;=Z02.89^^15^112^1
 ;;^UTILITY(U,$J,358.3,1388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1388,1,3,0)
 ;;=3^Administrative Exam NEC
 ;;^UTILITY(U,$J,358.3,1388,1,4,0)
 ;;=4^Z02.89
 ;;^UTILITY(U,$J,358.3,1388,2)
 ;;=^5062645
 ;;^UTILITY(U,$J,358.3,1389,0)
 ;;=Z01.00^^15^112^5
 ;;^UTILITY(U,$J,358.3,1389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1389,1,3,0)
 ;;=3^Eyes/Vision Exam w/o Abnormal Findings
 ;;^UTILITY(U,$J,358.3,1389,1,4,0)
 ;;=4^Z01.00
 ;;^UTILITY(U,$J,358.3,1389,2)
 ;;=^5062612
 ;;^UTILITY(U,$J,358.3,1390,0)
 ;;=Z01.01^^15^112^4
 ;;^UTILITY(U,$J,358.3,1390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1390,1,3,0)
 ;;=3^Eyes/Vision Exam w/ Abnormal Findings
 ;;^UTILITY(U,$J,358.3,1390,1,4,0)
 ;;=4^Z01.01
 ;;^UTILITY(U,$J,358.3,1390,2)
 ;;=^5062613
 ;;^UTILITY(U,$J,358.3,1391,0)
 ;;=Z11.1^^15^112^12
 ;;^UTILITY(U,$J,358.3,1391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1391,1,3,0)
 ;;=3^Respiratory Tuberculosis Screen
 ;;^UTILITY(U,$J,358.3,1391,1,4,0)
 ;;=4^Z11.1
 ;;^UTILITY(U,$J,358.3,1391,2)
 ;;=^5062670
 ;;^UTILITY(U,$J,358.3,1392,0)
 ;;=Z00.01^^15^112^6
 ;;^UTILITY(U,$J,358.3,1392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1392,1,3,0)
 ;;=3^General Adult Med Exam w/ Abnormal Findings
 ;;^UTILITY(U,$J,358.3,1392,1,4,0)
 ;;=4^Z00.01
 ;;^UTILITY(U,$J,358.3,1392,2)
 ;;=^5062600
 ;;^UTILITY(U,$J,358.3,1393,0)
 ;;=Z11.7^^15^112^14
 ;;^UTILITY(U,$J,358.3,1393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1393,1,3,0)
 ;;=3^Testing for Latent Tuberculosis Infection
 ;;^UTILITY(U,$J,358.3,1393,1,4,0)
 ;;=4^Z11.7
 ;;^UTILITY(U,$J,358.3,1393,2)
 ;;=^5158320
 ;;^UTILITY(U,$J,358.3,1394,0)
 ;;=Z11.59^^15^112^13
 ;;^UTILITY(U,$J,358.3,1394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1394,1,3,0)
 ;;=3^Screen for Other Viral Diseases
 ;;^UTILITY(U,$J,358.3,1394,1,4,0)
 ;;=4^Z11.59
 ;;^UTILITY(U,$J,358.3,1394,2)
 ;;=^5062675
 ;;^UTILITY(U,$J,358.3,1395,0)
 ;;=Z09.^^15^113^2
 ;;^UTILITY(U,$J,358.3,1395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1395,1,3,0)
 ;;=3^F/U Exam after Trtmt for Conditions Oth Than Malig Neop
 ;;^UTILITY(U,$J,358.3,1395,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,1395,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,1396,0)
 ;;=Z08.^^15^113^3
 ;;^UTILITY(U,$J,358.3,1396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1396,1,3,0)
 ;;=3^F/U Exam after Trtmt for Malig Neop
 ;;^UTILITY(U,$J,358.3,1396,1,4,0)
 ;;=4^Z08.
 ;;^UTILITY(U,$J,358.3,1396,2)
 ;;=^5062667
 ;;^UTILITY(U,$J,358.3,1397,0)
 ;;=Z86.15^^15^113^5
 ;;^UTILITY(U,$J,358.3,1397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1397,1,3,0)
 ;;=3^Personal Hx of Latent Tuberculosis Infection
 ;;^UTILITY(U,$J,358.3,1397,1,4,0)
 ;;=4^Z86.15
 ;;^UTILITY(U,$J,358.3,1397,2)
 ;;=^5158331
 ;;^UTILITY(U,$J,358.3,1398,0)
 ;;=Z20.828^^15^113^1
 ;;^UTILITY(U,$J,358.3,1398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1398,1,3,0)
 ;;=3^Contact w/ & Exposure to Oth Viral Communicable Diseases
 ;;^UTILITY(U,$J,358.3,1398,1,4,0)
 ;;=4^Z20.828
 ;;^UTILITY(U,$J,358.3,1398,2)
 ;;=^5062774
 ;;^UTILITY(U,$J,358.3,1399,0)
 ;;=Z03.818^^15^113^4
 ;;^UTILITY(U,$J,358.3,1399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1399,1,3,0)
 ;;=3^Obs for Susp Expsr to Oth Biolog Agents Ruled Out
 ;;^UTILITY(U,$J,358.3,1399,1,4,0)
 ;;=4^Z03.818
 ;;^UTILITY(U,$J,358.3,1399,2)
 ;;=^5062655
 ;;^UTILITY(U,$J,358.3,1400,0)
 ;;=Z23.^^15^114^1
 ;;^UTILITY(U,$J,358.3,1400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1400,1,3,0)
 ;;=3^Encounter for immunization(s)
 ;;^UTILITY(U,$J,358.3,1400,1,4,0)
 ;;=4^Z23.
 ;;^UTILITY(U,$J,358.3,1400,2)
 ;;=^5062795
 ;;^UTILITY(U,$J,358.3,1401,0)
 ;;=Z71.89^^15^115^1
 ;;^UTILITY(U,$J,358.3,1401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1401,1,3,0)
 ;;=3^Counseling,Oth Specified
 ;;^UTILITY(U,$J,358.3,1401,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,1401,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,1402,0)
 ;;=Y93.B1^^15^116^2
 ;;^UTILITY(U,$J,358.3,1402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1402,1,3,0)
 ;;=3^Activity Exercise Machines Primarily Muscle Conditioning
 ;;^UTILITY(U,$J,358.3,1402,1,4,0)
 ;;=4^Y93.B1
 ;;^UTILITY(U,$J,358.3,1402,2)
 ;;=^5062552
 ;;^UTILITY(U,$J,358.3,1403,0)
 ;;=Y93.A1^^15^116^1
 ;;^UTILITY(U,$J,358.3,1403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1403,1,3,0)
 ;;=3^Activity Exercise Machines Primarily Cardiovasc Conditioning
 ;;^UTILITY(U,$J,358.3,1403,1,4,0)
 ;;=4^Y93.A1
 ;;^UTILITY(U,$J,358.3,1403,2)
 ;;=^5062545
 ;;^UTILITY(U,$J,358.3,1404,0)
 ;;=Z91.5^^15^117^1
 ;;^UTILITY(U,$J,358.3,1404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1404,1,3,0)
 ;;=3^Personal Hx of Suicide Attempt(s)
 ;;^UTILITY(U,$J,358.3,1404,1,4,0)
 ;;=4^Z91.5
 ;;^UTILITY(U,$J,358.3,1404,2)
 ;;=^5063624
 ;;^UTILITY(U,$J,358.3,1405,0)
 ;;=R45.851^^15^117^2
 ;;^UTILITY(U,$J,358.3,1405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1405,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,1405,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,1405,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,1406,0)
 ;;=T14.91XA^^15^117^3
 ;;^UTILITY(U,$J,358.3,1406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1406,1,3,0)
 ;;=3^Suicide Attempt,Initial Encntr
 ;;^UTILITY(U,$J,358.3,1406,1,4,0)
 ;;=4^T14.91XA
 ;;^UTILITY(U,$J,358.3,1406,2)
 ;;=^5151779
 ;;^UTILITY(U,$J,358.3,1407,0)
 ;;=T14.91XD^^15^117^4
 ;;^UTILITY(U,$J,358.3,1407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1407,1,3,0)
 ;;=3^Suicide Attempt,Subsequent Encntr
 ;;^UTILITY(U,$J,358.3,1407,1,4,0)
 ;;=4^T14.91XD
 ;;^UTILITY(U,$J,358.3,1407,2)
 ;;=^5151780
 ;;^UTILITY(U,$J,358.3,1408,0)
 ;;=T14.91XS^^15^117^5
 ;;^UTILITY(U,$J,358.3,1408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1408,1,3,0)
 ;;=3^Suicide Attempt,Sequela
 ;;^UTILITY(U,$J,358.3,1408,1,4,0)
 ;;=4^T14.91XS
 ;;^UTILITY(U,$J,358.3,1408,2)
 ;;=^5151781
 ;;^UTILITY(U,$J,358.3,1409,0)
 ;;=99211^^16^118^1
 ;;^UTILITY(U,$J,358.3,1409,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1409,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,1409,1,3,0)
 ;;=3^RN/LPN Visit
 ;;^UTILITY(U,$J,358.3,1410,0)
 ;;=99212^^16^118^2
 ;;^UTILITY(U,$J,358.3,1410,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1410,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,1410,1,3,0)
 ;;=3^Problem Focused
 ;;^UTILITY(U,$J,358.3,1411,0)
 ;;=99213^^16^118^3
 ;;^UTILITY(U,$J,358.3,1411,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1411,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,1411,1,3,0)
 ;;=3^Exp Prob Focused
 ;;^UTILITY(U,$J,358.3,1412,0)
 ;;=99214^^16^118^4
 ;;^UTILITY(U,$J,358.3,1412,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1412,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,1412,1,3,0)
 ;;=3^Detailed
 ;;^UTILITY(U,$J,358.3,1413,0)
 ;;=99215^^16^118^5
 ;;^UTILITY(U,$J,358.3,1413,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1413,1,2,0)
 ;;=2^99215
 ;;^UTILITY(U,$J,358.3,1413,1,3,0)
 ;;=3^Comprehensive
 ;;^UTILITY(U,$J,358.3,1414,0)
 ;;=99241^^16^119^1
 ;;^UTILITY(U,$J,358.3,1414,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1414,1,2,0)
 ;;=2^99241
 ;;^UTILITY(U,$J,358.3,1414,1,3,0)
 ;;=3^Prob Focused
 ;;^UTILITY(U,$J,358.3,1415,0)
 ;;=99242^^16^119^2
 ;;^UTILITY(U,$J,358.3,1415,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1415,1,2,0)
 ;;=2^99242
 ;;^UTILITY(U,$J,358.3,1415,1,3,0)
 ;;=3^Exp Problem Focused
 ;;^UTILITY(U,$J,358.3,1416,0)
 ;;=99243^^16^119^3
 ;;^UTILITY(U,$J,358.3,1416,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1416,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,1416,1,3,0)
 ;;=3^Detailed
 ;;^UTILITY(U,$J,358.3,1417,0)
 ;;=99244^^16^119^4
 ;;^UTILITY(U,$J,358.3,1417,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1417,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,1417,1,3,0)
 ;;=3^Comprehensive, Mod Cmplx
 ;;^UTILITY(U,$J,358.3,1418,0)
 ;;=99245^^16^119^5
 ;;^UTILITY(U,$J,358.3,1418,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1418,1,2,0)
 ;;=2^99245
 ;;^UTILITY(U,$J,358.3,1418,1,3,0)
 ;;=3^Comprehensive, High Cmplx
 ;;^UTILITY(U,$J,358.3,1419,0)
 ;;=99201^^16^120^1
 ;;^UTILITY(U,$J,358.3,1419,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1419,1,2,0)
 ;;=2^99201
 ;;^UTILITY(U,$J,358.3,1419,1,3,0)
 ;;=3^Prob Focused
 ;;^UTILITY(U,$J,358.3,1420,0)
 ;;=99202^^16^120^2
 ;;^UTILITY(U,$J,358.3,1420,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1420,1,2,0)
 ;;=2^99202
 ;;^UTILITY(U,$J,358.3,1420,1,3,0)
 ;;=3^Expanded Prob Focus
 ;;^UTILITY(U,$J,358.3,1421,0)
 ;;=99203^^16^120^3
 ;;^UTILITY(U,$J,358.3,1421,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1421,1,2,0)
 ;;=2^99203
 ;;^UTILITY(U,$J,358.3,1421,1,3,0)
 ;;=3^Detailed
 ;;^UTILITY(U,$J,358.3,1422,0)
 ;;=99204^^16^120^4
 ;;^UTILITY(U,$J,358.3,1422,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1422,1,2,0)
 ;;=2^99204
 ;;^UTILITY(U,$J,358.3,1422,1,3,0)
 ;;=3^Comprehensive, Moderate
 ;;^UTILITY(U,$J,358.3,1423,0)
 ;;=99205^^16^120^5
 ;;^UTILITY(U,$J,358.3,1423,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1423,1,2,0)
 ;;=2^99205
 ;;^UTILITY(U,$J,358.3,1423,1,3,0)
 ;;=3^Comprehensive, High Complx
 ;;^UTILITY(U,$J,358.3,1424,0)
 ;;=92532^^17^121^21
 ;;^UTILITY(U,$J,358.3,1424,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1424,1,2,0)
 ;;=2^92532
 ;;^UTILITY(U,$J,358.3,1424,1,3,0)
 ;;=3^Positional Nystagmus Study
 ;;^UTILITY(U,$J,358.3,1425,0)
 ;;=95857^^17^121^26
 ;;^UTILITY(U,$J,358.3,1425,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1425,1,2,0)
 ;;=2^95857
 ;;^UTILITY(U,$J,358.3,1425,1,3,0)
 ;;=3^Tensilon Test
 ;;^UTILITY(U,$J,358.3,1426,0)
 ;;=64612^^17^121^5^^^^1
 ;;^UTILITY(U,$J,358.3,1426,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1426,1,2,0)
 ;;=2^64612
 ;;^UTILITY(U,$J,358.3,1426,1,3,0)
 ;;=3^Chemodenervation Face Muscle,Unilateral
 ;;^UTILITY(U,$J,358.3,1427,0)
 ;;=J0585^^17^121^4^^^^1
 ;;^UTILITY(U,$J,358.3,1427,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1427,1,2,0)
 ;;=2^J0585
 ;;^UTILITY(U,$J,358.3,1427,1,3,0)
 ;;=3^Chemodenervation Botox A,1 unit
 ;;^UTILITY(U,$J,358.3,1428,0)
 ;;=20552^^17^121^28^^^^1
 ;;^UTILITY(U,$J,358.3,1428,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1428,1,2,0)
 ;;=2^20552
 ;;^UTILITY(U,$J,358.3,1428,1,3,0)
 ;;=3^Trigger Point, 1 or 2 muscles
 ;;^UTILITY(U,$J,358.3,1429,0)
 ;;=20553^^17^121^29^^^^1
 ;;^UTILITY(U,$J,358.3,1429,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1429,1,2,0)
 ;;=2^20553
 ;;^UTILITY(U,$J,358.3,1429,1,3,0)
 ;;=3^Trigger Point, 3 or more muscles
 ;;^UTILITY(U,$J,358.3,1430,0)
 ;;=20612^^17^121^16^^^^1
 ;;^UTILITY(U,$J,358.3,1430,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1430,1,2,0)
 ;;=2^20612
 ;;^UTILITY(U,$J,358.3,1430,1,3,0)
 ;;=3^Ganglion Cyst Aspriation/Injection
 ;;^UTILITY(U,$J,358.3,1431,0)
 ;;=64450^^17^121^18^^^^1
 ;;^UTILITY(U,$J,358.3,1431,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1431,1,2,0)
 ;;=2^64450
 ;;^UTILITY(U,$J,358.3,1431,1,3,0)
 ;;=3^Nerve Block, peripheral nerve
 ;;^UTILITY(U,$J,358.3,1432,0)
 ;;=95990^^17^121^23^^^^1
 ;;^UTILITY(U,$J,358.3,1432,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1432,1,2,0)
 ;;=2^95990
 ;;^UTILITY(U,$J,358.3,1432,1,3,0)
 ;;=3^Refill Spinal Implant Pump by RN
 ;;^UTILITY(U,$J,358.3,1433,0)
 ;;=96402^^17^121^17^^^^1
 ;;^UTILITY(U,$J,358.3,1433,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1433,1,2,0)
 ;;=2^96402
 ;;^UTILITY(U,$J,358.3,1433,1,3,0)
 ;;=3^Injec,IM,anti-neplastic horm
 ;;^UTILITY(U,$J,358.3,1434,0)
 ;;=96372^^17^121^27^^^^1
 ;;^UTILITY(U,$J,358.3,1434,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1434,1,2,0)
 ;;=2^96372
 ;;^UTILITY(U,$J,358.3,1434,1,3,0)
 ;;=3^Ther/Proph/Diag Inj, SC/IM
 ;;^UTILITY(U,$J,358.3,1435,0)
 ;;=64616^^17^121^8^^^^1
 ;;^UTILITY(U,$J,358.3,1435,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1435,1,2,0)
 ;;=2^64616
 ;;^UTILITY(U,$J,358.3,1435,1,3,0)
 ;;=3^Chemodenervation Neck Muscle,Unilateral            
 ;;^UTILITY(U,$J,358.3,1436,0)
 ;;=64642^^17^121^3^^^^1
 ;;^UTILITY(U,$J,358.3,1436,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1436,1,2,0)
 ;;=2^64642
 ;;^UTILITY(U,$J,358.3,1436,1,3,0)
 ;;=3^Chemodenervation 1 Ext/1-4 Muscles
 ;;^UTILITY(U,$J,358.3,1437,0)
 ;;=64643^^17^121^11^^^^1
 ;;^UTILITY(U,$J,358.3,1437,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1437,1,2,0)
 ;;=2^64643
 ;;^UTILITY(U,$J,358.3,1437,1,3,0)
 ;;=3^Chemodenervation,Ea Addl Ext,1-4 Muscle 
 ;;^UTILITY(U,$J,358.3,1438,0)
 ;;=64644^^17^121^2^^^^1
 ;;^UTILITY(U,$J,358.3,1438,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1438,1,2,0)
 ;;=2^64644
 ;;^UTILITY(U,$J,358.3,1438,1,3,0)
 ;;=3^Chemodenervation 1 Ext 5 or > Muscles
 ;;^UTILITY(U,$J,358.3,1439,0)
 ;;=64645^^17^121^12^^^^1
 ;;^UTILITY(U,$J,358.3,1439,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1439,1,2,0)
 ;;=2^64645
 ;;^UTILITY(U,$J,358.3,1439,1,3,0)
 ;;=3^Chemodenervation,Ea Addl Ext,5 or > Mu
 ;;^UTILITY(U,$J,358.3,1440,0)
 ;;=64646^^17^121^9^^^^1
 ;;^UTILITY(U,$J,358.3,1440,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1440,1,2,0)
 ;;=2^64646
 ;;^UTILITY(U,$J,358.3,1440,1,3,0)
 ;;=3^Chemodenervation Trunk,1-5 Muscles
 ;;^UTILITY(U,$J,358.3,1441,0)
 ;;=64647^^17^121^10^^^^1
 ;;^UTILITY(U,$J,358.3,1441,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1441,1,2,0)
 ;;=2^64647
 ;;^UTILITY(U,$J,358.3,1441,1,3,0)
 ;;=3^Chemodenervation Trunk,6 or > Muscles   
 ;;^UTILITY(U,$J,358.3,1442,0)
 ;;=64615^^17^121^7^^^^1
 ;;^UTILITY(U,$J,358.3,1442,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1442,1,2,0)
 ;;=2^64615
 ;;^UTILITY(U,$J,358.3,1442,1,3,0)
 ;;=3^Chemodenervation Muscle for Migraine,Bilateral
 ;;^UTILITY(U,$J,358.3,1443,0)
 ;;=64617^^17^121^6^^^^1
 ;;^UTILITY(U,$J,358.3,1443,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1443,1,2,0)
 ;;=2^64617
 ;;^UTILITY(U,$J,358.3,1443,1,3,0)
 ;;=3^Chemodenervation Muscle Larynx,Unilateral
 ;;^UTILITY(U,$J,358.3,1444,0)
 ;;=62270^^17^121^24^^^^1
 ;;^UTILITY(U,$J,358.3,1444,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1444,1,2,0)
 ;;=2^62270
 ;;^UTILITY(U,$J,358.3,1444,1,3,0)
 ;;=3^Spinal Fluid Tap-Diagnostic 
 ;;^UTILITY(U,$J,358.3,1445,0)
 ;;=62272^^17^121^13^^^^1
 ;;^UTILITY(U,$J,358.3,1445,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1445,1,2,0)
 ;;=2^62272
 ;;^UTILITY(U,$J,358.3,1445,1,3,0)
 ;;=3^Drain Cerebro Spinal Fluid
 ;;^UTILITY(U,$J,358.3,1446,0)
 ;;=64400^^17^121^20^^^^1
 ;;^UTILITY(U,$J,358.3,1446,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1446,1,2,0)
 ;;=2^64400
 ;;^UTILITY(U,$J,358.3,1446,1,3,0)
 ;;=3^Nerve Block,Trigeminal
 ;;^UTILITY(U,$J,358.3,1447,0)
 ;;=78645^^17^121^1^^^^1
 ;;^UTILITY(U,$J,358.3,1447,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1447,1,2,0)
 ;;=2^78645
 ;;^UTILITY(U,$J,358.3,1447,1,3,0)
 ;;=3^CSF Shunt Evaluation
 ;;^UTILITY(U,$J,358.3,1448,0)
 ;;=86580^^17^121^25^^^^1
 ;;^UTILITY(U,$J,358.3,1448,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1448,1,2,0)
 ;;=2^86580
 ;;^UTILITY(U,$J,358.3,1448,1,3,0)
 ;;=3^TB Intradermal Test
 ;;^UTILITY(U,$J,358.3,1449,0)
 ;;=64405^^17^121^19^^^^1
 ;;^UTILITY(U,$J,358.3,1449,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1449,1,2,0)
 ;;=2^64405
 ;;^UTILITY(U,$J,358.3,1449,1,3,0)
 ;;=3^Nerve Block,Occipital
 ;;^UTILITY(U,$J,358.3,1450,0)
 ;;=95991^^17^121^22^^^^1
 ;;^UTILITY(U,$J,358.3,1450,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1450,1,2,0)
 ;;=2^95991
 ;;^UTILITY(U,$J,358.3,1450,1,3,0)
 ;;=3^Refill Spinal Implant Pump by MD/NP/PA
 ;;^UTILITY(U,$J,358.3,1451,0)
 ;;=97014^^17^121^14^^^^1
 ;;^UTILITY(U,$J,358.3,1451,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1451,1,2,0)
 ;;=2^97014
 ;;^UTILITY(U,$J,358.3,1451,1,3,0)
 ;;=3^Electric Stimulation Therapy,Unattended
 ;;^UTILITY(U,$J,358.3,1452,0)
 ;;=97032^^17^121^15^^^^1
 ;;^UTILITY(U,$J,358.3,1452,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1452,1,2,0)
 ;;=2^97032
 ;;^UTILITY(U,$J,358.3,1452,1,3,0)
 ;;=3^Electrical Stimulation,Manual,Ea 15 min
 ;;^UTILITY(U,$J,358.3,1453,0)
 ;;=95816^^17^122^14^^^^1
 ;;^UTILITY(U,$J,358.3,1453,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1453,1,2,0)
 ;;=2^95816
 ;;^UTILITY(U,$J,358.3,1453,1,3,0)
 ;;=3^EEG,Awake and Drowsy
 ;;^UTILITY(U,$J,358.3,1454,0)
 ;;=95819^^17^122^13^^^^1
 ;;^UTILITY(U,$J,358.3,1454,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1454,1,2,0)
 ;;=2^95819
 ;;^UTILITY(U,$J,358.3,1454,1,3,0)
 ;;=3^EEG,Awake and Asleep
 ;;^UTILITY(U,$J,358.3,1455,0)
 ;;=95822^^17^122^16^^^^1
 ;;^UTILITY(U,$J,358.3,1455,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1455,1,2,0)
 ;;=2^95822
 ;;^UTILITY(U,$J,358.3,1455,1,3,0)
 ;;=3^EEG,Sleep or Coma only
 ;;^UTILITY(U,$J,358.3,1456,0)
 ;;=95812^^17^122^1^^^^1
 ;;^UTILITY(U,$J,358.3,1456,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1456,1,2,0)
 ;;=2^95812
 ;;^UTILITY(U,$J,358.3,1456,1,3,0)
 ;;=3^EEG 41-60 min
 ;;^UTILITY(U,$J,358.3,1457,0)
 ;;=95813^^17^122^2^^^^1
 ;;^UTILITY(U,$J,358.3,1457,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1457,1,2,0)
 ;;=2^95813
 ;;^UTILITY(U,$J,358.3,1457,1,3,0)
 ;;=3^EEG > 1 hr
 ;;^UTILITY(U,$J,358.3,1458,0)
 ;;=95957^^17^122^15^^^^1
 ;;^UTILITY(U,$J,358.3,1458,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1458,1,2,0)
 ;;=2^95957
 ;;^UTILITY(U,$J,358.3,1458,1,3,0)
 ;;=3^EEG,Digital Analysis
 ;;^UTILITY(U,$J,358.3,1459,0)
 ;;=95717^^17^122^6^^^^1
 ;;^UTILITY(U,$J,358.3,1459,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1459,1,2,0)
 ;;=2^95717
 ;;^UTILITY(U,$J,358.3,1459,1,3,0)
 ;;=3^EEG Recording 2-12 Hrs w/o Video
 ;;^UTILITY(U,$J,358.3,1460,0)
 ;;=95718^^17^122^5^^^^1
 ;;^UTILITY(U,$J,358.3,1460,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1460,1,2,0)
 ;;=2^95718
 ;;^UTILITY(U,$J,358.3,1460,1,3,0)
 ;;=3^EEG Recording 2-12 Hrs w/ Video
 ;;^UTILITY(U,$J,358.3,1461,0)
 ;;=95719^^17^122^4^^^^1
 ;;^UTILITY(U,$J,358.3,1461,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1461,1,2,0)
 ;;=2^95719
 ;;^UTILITY(U,$J,358.3,1461,1,3,0)
 ;;=3^EEG Recording 13-26 Hrs w/o Video
 ;;^UTILITY(U,$J,358.3,1462,0)
 ;;=95720^^17^122^3^^^^1
 ;;^UTILITY(U,$J,358.3,1462,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1462,1,2,0)
 ;;=2^95720
 ;;^UTILITY(U,$J,358.3,1462,1,3,0)
 ;;=3^EEG Recording 13-26 Hrs w/ Video
 ;;^UTILITY(U,$J,358.3,1463,0)
 ;;=95721^^17^122^8^^^^1
 ;;^UTILITY(U,$J,358.3,1463,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1463,1,2,0)
 ;;=2^95721
 ;;^UTILITY(U,$J,358.3,1463,1,3,0)
 ;;=3^EEG Recording 36-60 Hrs w/o Video
 ;;^UTILITY(U,$J,358.3,1464,0)
 ;;=95722^^17^122^7^^^^1
 ;;^UTILITY(U,$J,358.3,1464,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1464,1,2,0)
 ;;=2^95722
 ;;^UTILITY(U,$J,358.3,1464,1,3,0)
 ;;=3^EEG Recording 36-60 Hrs w/ Video
