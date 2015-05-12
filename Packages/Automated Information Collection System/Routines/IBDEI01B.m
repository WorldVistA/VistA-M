IBDEI01B ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1390,1,3,0)
 ;;=3^Postviral Fatigue Syndrome
 ;;^UTILITY(U,$J,358.3,1390,1,4,0)
 ;;=4^G93.3
 ;;^UTILITY(U,$J,358.3,1390,2)
 ;;=^5004181
 ;;^UTILITY(U,$J,358.3,1391,0)
 ;;=R53.1^^5^71^20
 ;;^UTILITY(U,$J,358.3,1391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1391,1,3,0)
 ;;=3^Weakness
 ;;^UTILITY(U,$J,358.3,1391,1,4,0)
 ;;=4^R53.1
 ;;^UTILITY(U,$J,358.3,1391,2)
 ;;=^5019516
 ;;^UTILITY(U,$J,358.3,1392,0)
 ;;=I48.0^^5^72^1
 ;;^UTILITY(U,$J,358.3,1392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1392,1,3,0)
 ;;=3^Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,1392,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,1392,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,1393,0)
 ;;=R55.^^5^72^2
 ;;^UTILITY(U,$J,358.3,1393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1393,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,1393,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,1393,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,1394,0)
 ;;=G00.9^^5^73^3
 ;;^UTILITY(U,$J,358.3,1394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1394,1,3,0)
 ;;=3^Bacterial Meningitis,Unspec
 ;;^UTILITY(U,$J,358.3,1394,1,4,0)
 ;;=4^G00.9
 ;;^UTILITY(U,$J,358.3,1394,2)
 ;;=^5003724
 ;;^UTILITY(U,$J,358.3,1395,0)
 ;;=G04.00^^5^73^1
 ;;^UTILITY(U,$J,358.3,1395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1395,1,3,0)
 ;;=3^Acute Disseminated Encephalitis/Encephalomyelitis,Unspec
 ;;^UTILITY(U,$J,358.3,1395,1,4,0)
 ;;=4^G04.00
 ;;^UTILITY(U,$J,358.3,1395,2)
 ;;=^5003730
 ;;^UTILITY(U,$J,358.3,1396,0)
 ;;=G04.90^^5^73^5
 ;;^UTILITY(U,$J,358.3,1396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1396,1,3,0)
 ;;=3^Encephalitis/Encephalomyelitis,Unspec
 ;;^UTILITY(U,$J,358.3,1396,1,4,0)
 ;;=4^G04.90
 ;;^UTILITY(U,$J,358.3,1396,2)
 ;;=^5003741
 ;;^UTILITY(U,$J,358.3,1397,0)
 ;;=G35.^^5^73^7
 ;;^UTILITY(U,$J,358.3,1397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1397,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,1397,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,1397,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,1398,0)
 ;;=G36.0^^5^73^8
 ;;^UTILITY(U,$J,358.3,1398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1398,1,3,0)
 ;;=3^Neuromyelitis Optica
 ;;^UTILITY(U,$J,358.3,1398,1,4,0)
 ;;=4^G36.0
 ;;^UTILITY(U,$J,358.3,1398,2)
 ;;=^5003817
 ;;^UTILITY(U,$J,358.3,1399,0)
 ;;=G37.3^^5^73^2
 ;;^UTILITY(U,$J,358.3,1399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1399,1,3,0)
 ;;=3^Acute Transverse Myelitis in Demyelinating Disease of CNSL
 ;;^UTILITY(U,$J,358.3,1399,1,4,0)
 ;;=4^G37.3
 ;;^UTILITY(U,$J,358.3,1399,2)
 ;;=^5003824
 ;;^UTILITY(U,$J,358.3,1400,0)
 ;;=G61.0^^5^73^6
 ;;^UTILITY(U,$J,358.3,1400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1400,1,3,0)
 ;;=3^Guillain-Barre Syndrome
 ;;^UTILITY(U,$J,358.3,1400,1,4,0)
 ;;=4^G61.0
 ;;^UTILITY(U,$J,358.3,1400,2)
 ;;=^53405
 ;;^UTILITY(U,$J,358.3,1401,0)
 ;;=G61.81^^5^73^4
 ;;^UTILITY(U,$J,358.3,1401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1401,1,3,0)
 ;;=3^Chronic Inflammatory Demyelinating Polyneuritis
 ;;^UTILITY(U,$J,358.3,1401,1,4,0)
 ;;=4^G61.81
 ;;^UTILITY(U,$J,358.3,1401,2)
 ;;=^328480
 ;;^UTILITY(U,$J,358.3,1402,0)
 ;;=D86.81^^5^73^9
 ;;^UTILITY(U,$J,358.3,1402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1402,1,3,0)
 ;;=3^Sarcoid Meningitis
 ;;^UTILITY(U,$J,358.3,1402,1,4,0)
 ;;=4^D86.81
 ;;^UTILITY(U,$J,358.3,1402,2)
 ;;=^5002446
 ;;^UTILITY(U,$J,358.3,1403,0)
 ;;=G51.0^^5^74^2
 ;;^UTILITY(U,$J,358.3,1403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1403,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,1403,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,1403,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,1404,0)
 ;;=G54.0^^5^74^3
 ;;^UTILITY(U,$J,358.3,1404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1404,1,3,0)
 ;;=3^Brachial Plexus Disorders
 ;;^UTILITY(U,$J,358.3,1404,1,4,0)
 ;;=4^G54.0
 ;;^UTILITY(U,$J,358.3,1404,2)
 ;;=^5004007
 ;;^UTILITY(U,$J,358.3,1405,0)
 ;;=G56.00^^5^74^4
 ;;^UTILITY(U,$J,358.3,1405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1405,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Unspec Upper Limb
 ;;^UTILITY(U,$J,358.3,1405,1,4,0)
 ;;=4^G56.00
 ;;^UTILITY(U,$J,358.3,1405,2)
 ;;=^5004017
 ;;^UTILITY(U,$J,358.3,1406,0)
 ;;=G56.20^^5^74^14
 ;;^UTILITY(U,$J,358.3,1406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1406,1,3,0)
 ;;=3^Lesion of Ulnar Nerve,Unspec Upper Limb
 ;;^UTILITY(U,$J,358.3,1406,1,4,0)
 ;;=4^G56.20
 ;;^UTILITY(U,$J,358.3,1406,2)
 ;;=^5004023
 ;;^UTILITY(U,$J,358.3,1407,0)
 ;;=G56.90^^5^74^18
 ;;^UTILITY(U,$J,358.3,1407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1407,1,3,0)
 ;;=3^Mononeuropathy,Unspec Upper Limb
 ;;^UTILITY(U,$J,358.3,1407,1,4,0)
 ;;=4^G56.90
 ;;^UTILITY(U,$J,358.3,1407,2)
 ;;=^5004035
 ;;^UTILITY(U,$J,358.3,1408,0)
 ;;=G57.00^^5^74^13
 ;;^UTILITY(U,$J,358.3,1408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1408,1,3,0)
 ;;=3^Lesion Sciatic Nerve,Unspec Lower Limb
 ;;^UTILITY(U,$J,358.3,1408,1,4,0)
 ;;=4^G57.00
 ;;^UTILITY(U,$J,358.3,1408,2)
 ;;=^5004038
 ;;^UTILITY(U,$J,358.3,1409,0)
 ;;=G57.10^^5^74^15
 ;;^UTILITY(U,$J,358.3,1409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1409,1,3,0)
 ;;=3^Meralgia Paresthetica,Unspec Lower Limb
 ;;^UTILITY(U,$J,358.3,1409,1,4,0)
 ;;=4^G57.10
 ;;^UTILITY(U,$J,358.3,1409,2)
 ;;=^5004041
 ;;^UTILITY(U,$J,358.3,1410,0)
 ;;=G57.90^^5^74^17
 ;;^UTILITY(U,$J,358.3,1410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1410,1,3,0)
 ;;=3^Mononeuropathy,Unspec Lower Limb
 ;;^UTILITY(U,$J,358.3,1410,1,4,0)
 ;;=4^G57.90
 ;;^UTILITY(U,$J,358.3,1410,2)
 ;;=^5004061
 ;;^UTILITY(U,$J,358.3,1411,0)
 ;;=G58.7^^5^74^16
 ;;^UTILITY(U,$J,358.3,1411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1411,1,3,0)
 ;;=3^Mononeuritis Multiplex
 ;;^UTILITY(U,$J,358.3,1411,1,4,0)
 ;;=4^G58.7
 ;;^UTILITY(U,$J,358.3,1411,2)
 ;;=^5004063
 ;;^UTILITY(U,$J,358.3,1412,0)
 ;;=G60.0^^5^74^8
 ;;^UTILITY(U,$J,358.3,1412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1412,1,3,0)
 ;;=3^Hereditary Motor & Sensory Neuropathy
 ;;^UTILITY(U,$J,358.3,1412,1,4,0)
 ;;=4^G60.0
 ;;^UTILITY(U,$J,358.3,1412,2)
 ;;=^5004067
 ;;^UTILITY(U,$J,358.3,1413,0)
 ;;=G60.3^^5^74^9
 ;;^UTILITY(U,$J,358.3,1413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1413,1,3,0)
 ;;=3^Idiopathic Progressive Neuropathy
 ;;^UTILITY(U,$J,358.3,1413,1,4,0)
 ;;=4^G60.3
 ;;^UTILITY(U,$J,358.3,1413,2)
 ;;=^5004069
 ;;^UTILITY(U,$J,358.3,1414,0)
 ;;=G62.0^^5^74^7
 ;;^UTILITY(U,$J,358.3,1414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1414,1,3,0)
 ;;=3^Drug-Induced Polyneuropathy
 ;;^UTILITY(U,$J,358.3,1414,1,4,0)
 ;;=4^G62.0
 ;;^UTILITY(U,$J,358.3,1414,2)
 ;;=^5004075
 ;;^UTILITY(U,$J,358.3,1415,0)
 ;;=G62.1^^5^74^1
 ;;^UTILITY(U,$J,358.3,1415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1415,1,3,0)
 ;;=3^Alcoholic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,1415,1,4,0)
 ;;=4^G62.1
 ;;^UTILITY(U,$J,358.3,1415,2)
 ;;=^5004076
 ;;^UTILITY(U,$J,358.3,1416,0)
 ;;=G63.^^5^74^21
 ;;^UTILITY(U,$J,358.3,1416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1416,1,3,0)
 ;;=3^Polyneuropathy in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,1416,1,4,0)
 ;;=4^G63.
 ;;^UTILITY(U,$J,358.3,1416,2)
 ;;=^5004080
 ;;^UTILITY(U,$J,358.3,1417,0)
 ;;=G70.00^^5^74^20
 ;;^UTILITY(U,$J,358.3,1417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1417,1,3,0)
 ;;=3^Myasthenia Gravis w/o Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,1417,1,4,0)
 ;;=4^G70.00
 ;;^UTILITY(U,$J,358.3,1417,2)
 ;;=^329920
 ;;^UTILITY(U,$J,358.3,1418,0)
 ;;=G70.01^^5^74^19
 ;;^UTILITY(U,$J,358.3,1418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1418,1,3,0)
 ;;=3^Myasthenia Gravis w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,1418,1,4,0)
 ;;=4^G70.01
 ;;^UTILITY(U,$J,358.3,1418,2)
 ;;=^329921
 ;;^UTILITY(U,$J,358.3,1419,0)
 ;;=G70.80^^5^74^12
 ;;^UTILITY(U,$J,358.3,1419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1419,1,3,0)
 ;;=3^Lambert-Eaton Syndrome,Unspec
 ;;^UTILITY(U,$J,358.3,1419,1,4,0)
 ;;=4^G70.80
 ;;^UTILITY(U,$J,358.3,1419,2)
 ;;=^340608
 ;;^UTILITY(U,$J,358.3,1420,0)
 ;;=G72.0^^5^74^6
 ;;^UTILITY(U,$J,358.3,1420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1420,1,3,0)
 ;;=3^Drug-Induced Myopathy
 ;;^UTILITY(U,$J,358.3,1420,1,4,0)
 ;;=4^G72.0
 ;;^UTILITY(U,$J,358.3,1420,2)
 ;;=^5004095
 ;;^UTILITY(U,$J,358.3,1421,0)
 ;;=G72.41^^5^74^10
 ;;^UTILITY(U,$J,358.3,1421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1421,1,3,0)
 ;;=3^Inclusion Body Myositis
 ;;^UTILITY(U,$J,358.3,1421,1,4,0)
 ;;=4^G72.41
 ;;^UTILITY(U,$J,358.3,1421,2)
 ;;=^5004098
 ;;^UTILITY(U,$J,358.3,1422,0)
 ;;=G72.49^^5^74^11
 ;;^UTILITY(U,$J,358.3,1422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1422,1,3,0)
 ;;=3^Inflammatory & Immune Myopathies NEC
 ;;^UTILITY(U,$J,358.3,1422,1,4,0)
 ;;=4^G72.49
 ;;^UTILITY(U,$J,358.3,1422,2)
 ;;=^5004099
 ;;^UTILITY(U,$J,358.3,1423,0)
 ;;=E11.40^^5^74^5
 ;;^UTILITY(U,$J,358.3,1423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1423,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathy
 ;;^UTILITY(U,$J,358.3,1423,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,1423,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,1424,0)
 ;;=M54.2^^5^75^1
 ;;^UTILITY(U,$J,358.3,1424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1424,1,3,0)
 ;;=3^Cervicalgia
 ;;^UTILITY(U,$J,358.3,1424,1,4,0)
 ;;=4^M54.2
 ;;^UTILITY(U,$J,358.3,1424,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,1425,0)
 ;;=M54.5^^5^75^3
 ;;^UTILITY(U,$J,358.3,1425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1425,1,3,0)
 ;;=3^Low Back Pain
 ;;^UTILITY(U,$J,358.3,1425,1,4,0)
 ;;=4^M54.5
 ;;^UTILITY(U,$J,358.3,1425,2)
 ;;=^5012311
 ;;^UTILITY(U,$J,358.3,1426,0)
 ;;=M54.9^^5^75^2
 ;;^UTILITY(U,$J,358.3,1426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1426,1,3,0)
 ;;=3^Dorsalgia,Unspec
 ;;^UTILITY(U,$J,358.3,1426,1,4,0)
 ;;=4^M54.9
 ;;^UTILITY(U,$J,358.3,1426,2)
 ;;=^5012314
 ;;^UTILITY(U,$J,358.3,1427,0)
 ;;=M54.10^^5^75^8
 ;;^UTILITY(U,$J,358.3,1427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1427,1,3,0)
 ;;=3^Radiculopathy,Site Unspec
 ;;^UTILITY(U,$J,358.3,1427,1,4,0)
 ;;=4^M54.10
