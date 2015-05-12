IBDEI01K ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1719,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,1719,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,1720,0)
 ;;=C7B.03^^7^87^18
 ;;^UTILITY(U,$J,358.3,1720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1720,1,3,0)
 ;;=3^Secondary Malig Neop Bone
 ;;^UTILITY(U,$J,358.3,1720,1,4,0)
 ;;=4^C7B.03
 ;;^UTILITY(U,$J,358.3,1720,2)
 ;;=^5001384
 ;;^UTILITY(U,$J,358.3,1721,0)
 ;;=C81.90^^7^87^3
 ;;^UTILITY(U,$J,358.3,1721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1721,1,3,0)
 ;;=3^Hodgkin Lymphoma,Unspec
 ;;^UTILITY(U,$J,358.3,1721,1,4,0)
 ;;=4^C81.90
 ;;^UTILITY(U,$J,358.3,1721,2)
 ;;=^5001451
 ;;^UTILITY(U,$J,358.3,1722,0)
 ;;=C81.99^^7^87^2
 ;;^UTILITY(U,$J,358.3,1722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1722,1,3,0)
 ;;=3^Hodgkin Lymphoma,Extranodal & Solid Organ Sites,Unspec
 ;;^UTILITY(U,$J,358.3,1722,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,1722,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,1723,0)
 ;;=E86.1^^7^88^13
 ;;^UTILITY(U,$J,358.3,1723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1723,1,3,0)
 ;;=3^Hypovolemia
 ;;^UTILITY(U,$J,358.3,1723,1,4,0)
 ;;=4^E86.1
 ;;^UTILITY(U,$J,358.3,1723,2)
 ;;=^332744
 ;;^UTILITY(U,$J,358.3,1724,0)
 ;;=E85.9^^7^88^2
 ;;^UTILITY(U,$J,358.3,1724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1724,1,3,0)
 ;;=3^Amyloidosis,Unspec
 ;;^UTILITY(U,$J,358.3,1724,1,4,0)
 ;;=4^E85.9
 ;;^UTILITY(U,$J,358.3,1724,2)
 ;;=^334185
 ;;^UTILITY(U,$J,358.3,1725,0)
 ;;=J34.9^^7^88^14
 ;;^UTILITY(U,$J,358.3,1725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1725,1,3,0)
 ;;=3^Nose & Nasal Sinuses Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,1725,1,4,0)
 ;;=4^J34.9
 ;;^UTILITY(U,$J,358.3,1725,2)
 ;;=^5008212
 ;;^UTILITY(U,$J,358.3,1726,0)
 ;;=Q21.1^^7^88^6
 ;;^UTILITY(U,$J,358.3,1726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1726,1,3,0)
 ;;=3^Atrial Septal Defect
 ;;^UTILITY(U,$J,358.3,1726,1,4,0)
 ;;=4^Q21.1
 ;;^UTILITY(U,$J,358.3,1726,2)
 ;;=^186788
 ;;^UTILITY(U,$J,358.3,1727,0)
 ;;=R56.9^^7^88^8
 ;;^UTILITY(U,$J,358.3,1727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1727,1,3,0)
 ;;=3^Convulsions,Unspec
 ;;^UTILITY(U,$J,358.3,1727,1,4,0)
 ;;=4^R56.9
 ;;^UTILITY(U,$J,358.3,1727,2)
 ;;=^5019524
 ;;^UTILITY(U,$J,358.3,1728,0)
 ;;=R57.0^^7^88^7
 ;;^UTILITY(U,$J,358.3,1728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1728,1,3,0)
 ;;=3^Cardiogenic Shock
 ;;^UTILITY(U,$J,358.3,1728,1,4,0)
 ;;=4^R57.0
 ;;^UTILITY(U,$J,358.3,1728,2)
 ;;=^5019525
 ;;^UTILITY(U,$J,358.3,1729,0)
 ;;=T79.4XXA^^7^88^17
 ;;^UTILITY(U,$J,358.3,1729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1729,1,3,0)
 ;;=3^Traumatic Shock,Init Encnt
 ;;^UTILITY(U,$J,358.3,1729,1,4,0)
 ;;=4^T79.4XXA
 ;;^UTILITY(U,$J,358.3,1729,2)
 ;;=^5054305
 ;;^UTILITY(U,$J,358.3,1730,0)
 ;;=T78.2XXA^^7^88^4
 ;;^UTILITY(U,$J,358.3,1730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1730,1,3,0)
 ;;=3^Anaphylactic Shock,Unspec,Init Encnt
 ;;^UTILITY(U,$J,358.3,1730,1,4,0)
 ;;=4^T78.2XXA
 ;;^UTILITY(U,$J,358.3,1730,2)
 ;;=^5054278
 ;;^UTILITY(U,$J,358.3,1731,0)
 ;;=T50.905A^^7^88^1
 ;;^UTILITY(U,$J,358.3,1731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1731,1,3,0)
 ;;=3^Adverse Effect Drug/Meds/Biol Substance,Init Encnt
 ;;^UTILITY(U,$J,358.3,1731,1,4,0)
 ;;=4^T50.905A
 ;;^UTILITY(U,$J,358.3,1731,2)
 ;;=^5052160
 ;;^UTILITY(U,$J,358.3,1732,0)
 ;;=T88.4XXA^^7^88^10
 ;;^UTILITY(U,$J,358.3,1732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1732,1,3,0)
 ;;=3^Failed/Difficult Intubation,Init Encnt
 ;;^UTILITY(U,$J,358.3,1732,1,4,0)
 ;;=4^T88.4XXA
 ;;^UTILITY(U,$J,358.3,1732,2)
 ;;=^5055796
 ;;^UTILITY(U,$J,358.3,1733,0)
 ;;=T88.59XA^^7^88^5
 ;;^UTILITY(U,$J,358.3,1733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1733,1,3,0)
 ;;=3^Anesthesia Complications,Init Encnt
 ;;^UTILITY(U,$J,358.3,1733,1,4,0)
 ;;=4^T88.59XA
 ;;^UTILITY(U,$J,358.3,1733,2)
 ;;=^5055805
 ;;^UTILITY(U,$J,358.3,1734,0)
 ;;=T88.6XXA^^7^88^3
 ;;^UTILITY(U,$J,358.3,1734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1734,1,3,0)
 ;;=3^Anaphylactic Reaction d/t Adverse Eff Drug/Med Prop Admin,Init Encnt
 ;;^UTILITY(U,$J,358.3,1734,1,4,0)
 ;;=4^T88.6XXA
 ;;^UTILITY(U,$J,358.3,1734,2)
 ;;=^5055808
 ;;^UTILITY(U,$J,358.3,1735,0)
 ;;=T81.10XA^^7^88^16
 ;;^UTILITY(U,$J,358.3,1735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1735,1,3,0)
 ;;=3^Postprocedural Shock,Unspec,Init Encnt
 ;;^UTILITY(U,$J,358.3,1735,1,4,0)
 ;;=4^T81.10XA
 ;;^UTILITY(U,$J,358.3,1735,2)
 ;;=^5054455
 ;;^UTILITY(U,$J,358.3,1736,0)
 ;;=T81.12XA^^7^88^15
 ;;^UTILITY(U,$J,358.3,1736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1736,1,3,0)
 ;;=3^Postprocedural Septic Shock,Init Encnt
 ;;^UTILITY(U,$J,358.3,1736,1,4,0)
 ;;=4^T81.12XA
 ;;^UTILITY(U,$J,358.3,1736,2)
 ;;=^5054461
 ;;^UTILITY(U,$J,358.3,1737,0)
 ;;=Z45.2^^7^88^18
 ;;^UTILITY(U,$J,358.3,1737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1737,1,3,0)
 ;;=3^VAD Adjustment & Management Encounter
 ;;^UTILITY(U,$J,358.3,1737,1,4,0)
 ;;=4^Z45.2
 ;;^UTILITY(U,$J,358.3,1737,2)
 ;;=^5062999
 ;;^UTILITY(U,$J,358.3,1738,0)
 ;;=Z71.1^^7^88^11
 ;;^UTILITY(U,$J,358.3,1738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1738,1,3,0)
 ;;=3^Feared Hlth Complaint-No Diagnosis Made
 ;;^UTILITY(U,$J,358.3,1738,1,4,0)
 ;;=4^Z71.1
 ;;^UTILITY(U,$J,358.3,1738,2)
 ;;=^5063243
 ;;^UTILITY(U,$J,358.3,1739,0)
 ;;=Z00.6^^7^88^9
 ;;^UTILITY(U,$J,358.3,1739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1739,1,3,0)
 ;;=3^Exam for Nrml Cmprsn & Ctrl in Clncl Research Prog
 ;;^UTILITY(U,$J,358.3,1739,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,1739,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,1740,0)
 ;;=Z00.8^^7^88^12
 ;;^UTILITY(U,$J,358.3,1740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1740,1,3,0)
 ;;=3^General Examination Encounter
 ;;^UTILITY(U,$J,358.3,1740,1,4,0)
 ;;=4^Z00.8
 ;;^UTILITY(U,$J,358.3,1740,2)
 ;;=^5062611
 ;;^UTILITY(U,$J,358.3,1741,0)
 ;;=Z01.818^^7^89^3
 ;;^UTILITY(U,$J,358.3,1741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1741,1,3,0)
 ;;=3^Preprocedural Examination
 ;;^UTILITY(U,$J,358.3,1741,1,4,0)
 ;;=4^Z01.818
 ;;^UTILITY(U,$J,358.3,1741,2)
 ;;=^5062628
 ;;^UTILITY(U,$J,358.3,1742,0)
 ;;=Z01.810^^7^89^2
 ;;^UTILITY(U,$J,358.3,1742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1742,1,3,0)
 ;;=3^Preprocedural Cardiovascular Examination
 ;;^UTILITY(U,$J,358.3,1742,1,4,0)
 ;;=4^Z01.810
 ;;^UTILITY(U,$J,358.3,1742,2)
 ;;=^5062625
 ;;^UTILITY(U,$J,358.3,1743,0)
 ;;=Z01.811^^7^89^4
 ;;^UTILITY(U,$J,358.3,1743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1743,1,3,0)
 ;;=3^Preprocedural Respiratory Examination
 ;;^UTILITY(U,$J,358.3,1743,1,4,0)
 ;;=4^Z01.811
 ;;^UTILITY(U,$J,358.3,1743,2)
 ;;=^5062626
 ;;^UTILITY(U,$J,358.3,1744,0)
 ;;=Z48.89^^7^89^1
 ;;^UTILITY(U,$J,358.3,1744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1744,1,3,0)
 ;;=3^Postsurgical Aftercare
 ;;^UTILITY(U,$J,358.3,1744,1,4,0)
 ;;=4^Z48.89
 ;;^UTILITY(U,$J,358.3,1744,2)
 ;;=^5063055
 ;;^UTILITY(U,$J,358.3,1745,0)
 ;;=J95.821^^7^90^5
 ;;^UTILITY(U,$J,358.3,1745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1745,1,3,0)
 ;;=3^Acute Postprocedural Respiratory Failure
 ;;^UTILITY(U,$J,358.3,1745,1,4,0)
 ;;=4^J95.821
 ;;^UTILITY(U,$J,358.3,1745,2)
 ;;=^5008338
 ;;^UTILITY(U,$J,358.3,1746,0)
 ;;=J96.00^^7^90^8
 ;;^UTILITY(U,$J,358.3,1746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1746,1,3,0)
 ;;=3^Acute Respiratory Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1746,1,4,0)
 ;;=4^J96.00
 ;;^UTILITY(U,$J,358.3,1746,2)
 ;;=^5008347
 ;;^UTILITY(U,$J,358.3,1747,0)
 ;;=J96.01^^7^90^7
 ;;^UTILITY(U,$J,358.3,1747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1747,1,3,0)
 ;;=3^Acute Respiratory Failure w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,1747,1,4,0)
 ;;=4^J96.01
 ;;^UTILITY(U,$J,358.3,1747,2)
 ;;=^5008348
 ;;^UTILITY(U,$J,358.3,1748,0)
 ;;=J96.02^^7^90^6
 ;;^UTILITY(U,$J,358.3,1748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1748,1,3,0)
 ;;=3^Acute Respiratory Failure w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,1748,1,4,0)
 ;;=4^J96.02
 ;;^UTILITY(U,$J,358.3,1748,2)
 ;;=^5008349
 ;;^UTILITY(U,$J,358.3,1749,0)
 ;;=J96.10^^7^90^11
 ;;^UTILITY(U,$J,358.3,1749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1749,1,3,0)
 ;;=3^Chronic Respiratory Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1749,1,4,0)
 ;;=4^J96.10
 ;;^UTILITY(U,$J,358.3,1749,2)
 ;;=^5008350
 ;;^UTILITY(U,$J,358.3,1750,0)
 ;;=J96.11^^7^90^10
 ;;^UTILITY(U,$J,358.3,1750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1750,1,3,0)
 ;;=3^Chronic Respiratory Failure w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,1750,1,4,0)
 ;;=4^J96.11
 ;;^UTILITY(U,$J,358.3,1750,2)
 ;;=^5008351
 ;;^UTILITY(U,$J,358.3,1751,0)
 ;;=J96.12^^7^90^9
 ;;^UTILITY(U,$J,358.3,1751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1751,1,3,0)
 ;;=3^Chronic Respiratory Failure w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,1751,1,4,0)
 ;;=4^J96.12
 ;;^UTILITY(U,$J,358.3,1751,2)
 ;;=^5008352
 ;;^UTILITY(U,$J,358.3,1752,0)
 ;;=J96.20^^7^90^4
 ;;^UTILITY(U,$J,358.3,1752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1752,1,3,0)
 ;;=3^Acute & Chronic Respiratory Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1752,1,4,0)
 ;;=4^J96.20
 ;;^UTILITY(U,$J,358.3,1752,2)
 ;;=^5008353
 ;;^UTILITY(U,$J,358.3,1753,0)
 ;;=J96.21^^7^90^2
 ;;^UTILITY(U,$J,358.3,1753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1753,1,3,0)
 ;;=3^Acute & Chronic Respiratory Failure w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,1753,1,4,0)
 ;;=4^J96.21
 ;;^UTILITY(U,$J,358.3,1753,2)
 ;;=^5008354
 ;;^UTILITY(U,$J,358.3,1754,0)
 ;;=J96.22^^7^90^3
 ;;^UTILITY(U,$J,358.3,1754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1754,1,3,0)
 ;;=3^Acute & Chronic Respiratory Failure w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,1754,1,4,0)
 ;;=4^J96.22
 ;;^UTILITY(U,$J,358.3,1754,2)
 ;;=^5008355
 ;;^UTILITY(U,$J,358.3,1755,0)
 ;;=R79.81^^7^90^1
 ;;^UTILITY(U,$J,358.3,1755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1755,1,3,0)
 ;;=3^Abnormal Blood-Gas Level
 ;;^UTILITY(U,$J,358.3,1755,1,4,0)
 ;;=4^R79.81
 ;;^UTILITY(U,$J,358.3,1755,2)
 ;;=^5019592
