IBDEI01H ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1609,1,4,0)
 ;;=4^R10.30
 ;;^UTILITY(U,$J,358.3,1609,2)
 ;;=^5019210
 ;;^UTILITY(U,$J,358.3,1610,0)
 ;;=I21.3^^7^82^15
 ;;^UTILITY(U,$J,358.3,1610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1610,1,3,0)
 ;;=3^STEMI,Unspec Site
 ;;^UTILITY(U,$J,358.3,1610,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,1610,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,1611,0)
 ;;=I21.4^^7^82^11
 ;;^UTILITY(U,$J,358.3,1611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1611,1,3,0)
 ;;=3^NSTEMI
 ;;^UTILITY(U,$J,358.3,1611,1,4,0)
 ;;=4^I21.4
 ;;^UTILITY(U,$J,358.3,1611,2)
 ;;=^5007088
 ;;^UTILITY(U,$J,358.3,1612,0)
 ;;=I42.9^^7^82^5
 ;;^UTILITY(U,$J,358.3,1612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1612,1,3,0)
 ;;=3^Cardiomyopathy,Unspec
 ;;^UTILITY(U,$J,358.3,1612,1,4,0)
 ;;=4^I42.9
 ;;^UTILITY(U,$J,358.3,1612,2)
 ;;=^5007200
 ;;^UTILITY(U,$J,358.3,1613,0)
 ;;=I48.91^^7^82^1
 ;;^UTILITY(U,$J,358.3,1613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1613,1,3,0)
 ;;=3^Atrial Fibrillation,Unspec
 ;;^UTILITY(U,$J,358.3,1613,1,4,0)
 ;;=4^I48.91
 ;;^UTILITY(U,$J,358.3,1613,2)
 ;;=^5007229
 ;;^UTILITY(U,$J,358.3,1614,0)
 ;;=I48.92^^7^82^2
 ;;^UTILITY(U,$J,358.3,1614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1614,1,3,0)
 ;;=3^Atrial Flutter,Unspec
 ;;^UTILITY(U,$J,358.3,1614,1,4,0)
 ;;=4^I48.92
 ;;^UTILITY(U,$J,358.3,1614,2)
 ;;=^5007230
 ;;^UTILITY(U,$J,358.3,1615,0)
 ;;=I46.9^^7^82^3
 ;;^UTILITY(U,$J,358.3,1615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1615,1,3,0)
 ;;=3^Cardiac Arrest,Unspec Cause
 ;;^UTILITY(U,$J,358.3,1615,1,4,0)
 ;;=4^I46.9
 ;;^UTILITY(U,$J,358.3,1615,2)
 ;;=^5007221
 ;;^UTILITY(U,$J,358.3,1616,0)
 ;;=I49.9^^7^82^4
 ;;^UTILITY(U,$J,358.3,1616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1616,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,1616,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,1616,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,1617,0)
 ;;=I50.9^^7^82^10
 ;;^UTILITY(U,$J,358.3,1617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1617,1,3,0)
 ;;=3^Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1617,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,1617,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,1618,0)
 ;;=I65.21^^7^82^14
 ;;^UTILITY(U,$J,358.3,1618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1618,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,1618,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,1618,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,1619,0)
 ;;=I65.22^^7^82^13
 ;;^UTILITY(U,$J,358.3,1619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1619,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,1619,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,1619,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,1620,0)
 ;;=I65.23^^7^82^12
 ;;^UTILITY(U,$J,358.3,1620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1620,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,1620,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,1620,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,1621,0)
 ;;=I63.131^^7^82^9
 ;;^UTILITY(U,$J,358.3,1621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1621,1,3,0)
 ;;=3^Cerebral Infarction d/t Embolism Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,1621,1,4,0)
 ;;=4^I63.131
 ;;^UTILITY(U,$J,358.3,1621,2)
 ;;=^5007308
 ;;^UTILITY(U,$J,358.3,1622,0)
 ;;=I63.132^^7^82^8
 ;;^UTILITY(U,$J,358.3,1622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1622,1,3,0)
 ;;=3^Cerebral Infarction d/t Embolism Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,1622,1,4,0)
 ;;=4^I63.132
 ;;^UTILITY(U,$J,358.3,1622,2)
 ;;=^5007309
 ;;^UTILITY(U,$J,358.3,1623,0)
 ;;=I63.231^^7^82^7
 ;;^UTILITY(U,$J,358.3,1623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1623,1,3,0)
 ;;=3^Cereb Infrc d/t Unspec Occls/Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,1623,1,4,0)
 ;;=4^I63.231
 ;;^UTILITY(U,$J,358.3,1623,2)
 ;;=^5007316
 ;;^UTILITY(U,$J,358.3,1624,0)
 ;;=I63.232^^7^82^6
 ;;^UTILITY(U,$J,358.3,1624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1624,1,3,0)
 ;;=3^Cereb Infrc d/t Unspec Occls/Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,1624,1,4,0)
 ;;=4^I63.232
 ;;^UTILITY(U,$J,358.3,1624,2)
 ;;=^5007317
 ;;^UTILITY(U,$J,358.3,1625,0)
 ;;=K63.9^^7^83^4
 ;;^UTILITY(U,$J,358.3,1625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1625,1,3,0)
 ;;=3^Intestinal Disease,Unspec
 ;;^UTILITY(U,$J,358.3,1625,1,4,0)
 ;;=4^K63.9
 ;;^UTILITY(U,$J,358.3,1625,2)
 ;;=^5008768
 ;;^UTILITY(U,$J,358.3,1626,0)
 ;;=K76.6^^7^83^7
 ;;^UTILITY(U,$J,358.3,1626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1626,1,3,0)
 ;;=3^Portal Hypertension
 ;;^UTILITY(U,$J,358.3,1626,1,4,0)
 ;;=4^K76.6
 ;;^UTILITY(U,$J,358.3,1626,2)
 ;;=^5008834
 ;;^UTILITY(U,$J,358.3,1627,0)
 ;;=K76.9^^7^83^5
 ;;^UTILITY(U,$J,358.3,1627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1627,1,3,0)
 ;;=3^Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,1627,1,4,0)
 ;;=4^K76.9
 ;;^UTILITY(U,$J,358.3,1627,2)
 ;;=^5008836
 ;;^UTILITY(U,$J,358.3,1628,0)
 ;;=K80.20^^7^83^2
 ;;^UTILITY(U,$J,358.3,1628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1628,1,3,0)
 ;;=3^Calculus of Gallbladder w/o  Cholecystitis w/o Obstruction
 ;;^UTILITY(U,$J,358.3,1628,1,4,0)
 ;;=4^K80.20
 ;;^UTILITY(U,$J,358.3,1628,2)
 ;;=^5008846
 ;;^UTILITY(U,$J,358.3,1629,0)
 ;;=K83.0^^7^83^3
 ;;^UTILITY(U,$J,358.3,1629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1629,1,3,0)
 ;;=3^Cholangitis
 ;;^UTILITY(U,$J,358.3,1629,1,4,0)
 ;;=4^K83.0
 ;;^UTILITY(U,$J,358.3,1629,2)
 ;;=^23291
 ;;^UTILITY(U,$J,358.3,1630,0)
 ;;=K83.9^^7^83^1
 ;;^UTILITY(U,$J,358.3,1630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1630,1,3,0)
 ;;=3^Biliary Tract Disease,Unspec
 ;;^UTILITY(U,$J,358.3,1630,1,4,0)
 ;;=4^K83.9
 ;;^UTILITY(U,$J,358.3,1630,2)
 ;;=^5008881
 ;;^UTILITY(U,$J,358.3,1631,0)
 ;;=K86.1^^7^83^6
 ;;^UTILITY(U,$J,358.3,1631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1631,1,3,0)
 ;;=3^Pancreatitis, Chronic
 ;;^UTILITY(U,$J,358.3,1631,1,4,0)
 ;;=4^K86.1
 ;;^UTILITY(U,$J,358.3,1631,2)
 ;;=^5008889
 ;;^UTILITY(U,$J,358.3,1632,0)
 ;;=K86.3^^7^83^8
 ;;^UTILITY(U,$J,358.3,1632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1632,1,3,0)
 ;;=3^Pseudocyst of Pancreas
 ;;^UTILITY(U,$J,358.3,1632,1,4,0)
 ;;=4^K86.3
 ;;^UTILITY(U,$J,358.3,1632,2)
 ;;=^5008891
 ;;^UTILITY(U,$J,358.3,1633,0)
 ;;=G04.91^^7^84^31
 ;;^UTILITY(U,$J,358.3,1633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1633,1,3,0)
 ;;=3^Myelitis,Unspec
 ;;^UTILITY(U,$J,358.3,1633,1,4,0)
 ;;=4^G04.91
 ;;^UTILITY(U,$J,358.3,1633,2)
 ;;=^5003742
 ;;^UTILITY(U,$J,358.3,1634,0)
 ;;=G95.0^^7^84^49
 ;;^UTILITY(U,$J,358.3,1634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1634,1,3,0)
 ;;=3^Syringomyelia & Syringobulbia
 ;;^UTILITY(U,$J,358.3,1634,1,4,0)
 ;;=4^G95.0
 ;;^UTILITY(U,$J,358.3,1634,2)
 ;;=^116874
 ;;^UTILITY(U,$J,358.3,1635,0)
 ;;=G99.0^^7^84^1
 ;;^UTILITY(U,$J,358.3,1635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1635,1,3,0)
 ;;=3^Autonomic Neuropathy
 ;;^UTILITY(U,$J,358.3,1635,1,4,0)
 ;;=4^G99.0
 ;;^UTILITY(U,$J,358.3,1635,2)
 ;;=^5004215
 ;;^UTILITY(U,$J,358.3,1636,0)
 ;;=G90.50^^7^84^5
 ;;^UTILITY(U,$J,358.3,1636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1636,1,3,0)
 ;;=3^Complex Regional Pain Syndrome I,Unspec
 ;;^UTILITY(U,$J,358.3,1636,1,4,0)
 ;;=4^G90.50
 ;;^UTILITY(U,$J,358.3,1636,2)
 ;;=^5004163
 ;;^UTILITY(U,$J,358.3,1637,0)
 ;;=G83.4^^7^84^4
 ;;^UTILITY(U,$J,358.3,1637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1637,1,3,0)
 ;;=3^Cauda Equina Syndrome
 ;;^UTILITY(U,$J,358.3,1637,1,4,0)
 ;;=4^G83.4
 ;;^UTILITY(U,$J,358.3,1637,2)
 ;;=^265172
 ;;^UTILITY(U,$J,358.3,1638,0)
 ;;=G50.0^^7^84^50
 ;;^UTILITY(U,$J,358.3,1638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1638,1,3,0)
 ;;=3^Trigeminal Neuralgia
 ;;^UTILITY(U,$J,358.3,1638,1,4,0)
 ;;=4^G50.0
 ;;^UTILITY(U,$J,358.3,1638,2)
 ;;=^121978
 ;;^UTILITY(U,$J,358.3,1639,0)
 ;;=G51.9^^7^84^17
 ;;^UTILITY(U,$J,358.3,1639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1639,1,3,0)
 ;;=3^Facial Nerve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,1639,1,4,0)
 ;;=4^G51.9
 ;;^UTILITY(U,$J,358.3,1639,2)
 ;;=^5003998
 ;;^UTILITY(U,$J,358.3,1640,0)
 ;;=G52.9^^7^84^6
 ;;^UTILITY(U,$J,358.3,1640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1640,1,3,0)
 ;;=3^Cranial Nerve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,1640,1,4,0)
 ;;=4^G52.9
 ;;^UTILITY(U,$J,358.3,1640,2)
 ;;=^5004005
 ;;^UTILITY(U,$J,358.3,1641,0)
 ;;=G54.9^^7^84^41
 ;;^UTILITY(U,$J,358.3,1641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1641,1,3,0)
 ;;=3^Nerve Root & Plexus Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,1641,1,4,0)
 ;;=4^G54.9
 ;;^UTILITY(U,$J,358.3,1641,2)
 ;;=^5004015
 ;;^UTILITY(U,$J,358.3,1642,0)
 ;;=G56.01^^7^84^3
 ;;^UTILITY(U,$J,358.3,1642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1642,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,1642,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,1642,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,1643,0)
 ;;=G56.02^^7^84^2
 ;;^UTILITY(U,$J,358.3,1643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1643,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,1643,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,1643,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,1644,0)
 ;;=G56.11^^7^84^21
 ;;^UTILITY(U,$J,358.3,1644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1644,1,3,0)
 ;;=3^Median Nerve Lesions,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,1644,1,4,0)
 ;;=4^G56.11
 ;;^UTILITY(U,$J,358.3,1644,2)
 ;;=^5004021
 ;;^UTILITY(U,$J,358.3,1645,0)
 ;;=G56.12^^7^84^20
 ;;^UTILITY(U,$J,358.3,1645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1645,1,3,0)
 ;;=3^Median Nerve Lesions,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,1645,1,4,0)
 ;;=4^G56.12
 ;;^UTILITY(U,$J,358.3,1645,2)
 ;;=^5004022
 ;;^UTILITY(U,$J,358.3,1646,0)
 ;;=G56.21^^7^84^52
 ;;^UTILITY(U,$J,358.3,1646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1646,1,3,0)
 ;;=3^Ulnar Nerve Lesion,Right Upper Limb
