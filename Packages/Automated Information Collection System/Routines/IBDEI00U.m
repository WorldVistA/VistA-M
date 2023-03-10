IBDEI00U ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1499,0)
 ;;=G23.0^^13^103^10
 ;;^UTILITY(U,$J,358.3,1499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1499,1,3,0)
 ;;=3^Hallervorden-Spatz Disease
 ;;^UTILITY(U,$J,358.3,1499,1,4,0)
 ;;=4^G23.0
 ;;^UTILITY(U,$J,358.3,1499,2)
 ;;=^5003779
 ;;^UTILITY(U,$J,358.3,1500,0)
 ;;=G90.3^^13^103^11
 ;;^UTILITY(U,$J,358.3,1500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1500,1,3,0)
 ;;=3^Multi-Syst Degeneration of Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,1500,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,1500,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,1501,0)
 ;;=G21.11^^13^103^13
 ;;^UTILITY(U,$J,358.3,1501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1501,1,3,0)
 ;;=3^Neuroleptic Induced Parkinsonism
 ;;^UTILITY(U,$J,358.3,1501,1,4,0)
 ;;=4^G21.11
 ;;^UTILITY(U,$J,358.3,1501,2)
 ;;=^5003772
 ;;^UTILITY(U,$J,358.3,1502,0)
 ;;=G21.19^^13^103^5
 ;;^UTILITY(U,$J,358.3,1502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1502,1,3,0)
 ;;=3^Drug-Induced Secondary Parkinsonism
 ;;^UTILITY(U,$J,358.3,1502,1,4,0)
 ;;=4^G21.19
 ;;^UTILITY(U,$J,358.3,1502,2)
 ;;=^5003773
 ;;^UTILITY(U,$J,358.3,1503,0)
 ;;=G23.8^^13^103^4
 ;;^UTILITY(U,$J,358.3,1503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1503,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia
 ;;^UTILITY(U,$J,358.3,1503,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,1503,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,1504,0)
 ;;=G47.61^^13^103^15
 ;;^UTILITY(U,$J,358.3,1504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1504,1,3,0)
 ;;=3^Periodic Limb Movement Disorder
 ;;^UTILITY(U,$J,358.3,1504,1,4,0)
 ;;=4^G47.61
 ;;^UTILITY(U,$J,358.3,1504,2)
 ;;=^5003987
 ;;^UTILITY(U,$J,358.3,1505,0)
 ;;=G23.1^^13^103^16
 ;;^UTILITY(U,$J,358.3,1505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1505,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia
 ;;^UTILITY(U,$J,358.3,1505,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,1505,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,1506,0)
 ;;=G47.52^^13^103^17
 ;;^UTILITY(U,$J,358.3,1506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1506,1,3,0)
 ;;=3^REM Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,1506,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,1506,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,1507,0)
 ;;=G23.2^^13^103^20
 ;;^UTILITY(U,$J,358.3,1507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1507,1,3,0)
 ;;=3^Striatonigral Degeneration
 ;;^UTILITY(U,$J,358.3,1507,1,4,0)
 ;;=4^G23.2
 ;;^UTILITY(U,$J,358.3,1507,2)
 ;;=^5003781
 ;;^UTILITY(U,$J,358.3,1508,0)
 ;;=F95.2^^13^103^22
 ;;^UTILITY(U,$J,358.3,1508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1508,1,3,0)
 ;;=3^Tourett's Disorder
 ;;^UTILITY(U,$J,358.3,1508,1,4,0)
 ;;=4^F95.2
 ;;^UTILITY(U,$J,358.3,1508,2)
 ;;=^331942
 ;;^UTILITY(U,$J,358.3,1509,0)
 ;;=G21.4^^13^103^24
 ;;^UTILITY(U,$J,358.3,1509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1509,1,3,0)
 ;;=3^Vascular Parkinsonism
 ;;^UTILITY(U,$J,358.3,1509,1,4,0)
 ;;=4^G21.4
 ;;^UTILITY(U,$J,358.3,1509,2)
 ;;=^5003776
 ;;^UTILITY(U,$J,358.3,1510,0)
 ;;=I69.393^^13^103^1
 ;;^UTILITY(U,$J,358.3,1510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1510,1,3,0)
 ;;=3^Ataxia following Cerebral Infarction
 ;;^UTILITY(U,$J,358.3,1510,1,4,0)
 ;;=4^I69.393
 ;;^UTILITY(U,$J,358.3,1510,2)
 ;;=^5007518
 ;;^UTILITY(U,$J,358.3,1511,0)
 ;;=F44.4^^13^103^3
 ;;^UTILITY(U,$J,358.3,1511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1511,1,3,0)
 ;;=3^Conversion Disorder w/ Motor Symptom or Deficit
 ;;^UTILITY(U,$J,358.3,1511,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,1511,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,1512,0)
 ;;=C71.9^^13^104^5
 ;;^UTILITY(U,$J,358.3,1512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1512,1,3,0)
 ;;=3^Malig Neop Brain,Unspec
 ;;^UTILITY(U,$J,358.3,1512,1,4,0)
 ;;=4^C71.9
 ;;^UTILITY(U,$J,358.3,1512,2)
 ;;=^5001297
 ;;^UTILITY(U,$J,358.3,1513,0)
 ;;=C72.0^^13^104^8
 ;;^UTILITY(U,$J,358.3,1513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1513,1,3,0)
 ;;=3^Malig Neop Spinal Cord
 ;;^UTILITY(U,$J,358.3,1513,1,4,0)
 ;;=4^C72.0
 ;;^UTILITY(U,$J,358.3,1513,2)
 ;;=^267292
 ;;^UTILITY(U,$J,358.3,1514,0)
 ;;=C72.1^^13^104^6
 ;;^UTILITY(U,$J,358.3,1514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1514,1,3,0)
 ;;=3^Malig Neop Cauda Equina
 ;;^UTILITY(U,$J,358.3,1514,1,4,0)
 ;;=4^C72.1
 ;;^UTILITY(U,$J,358.3,1514,2)
 ;;=^5001298
 ;;^UTILITY(U,$J,358.3,1515,0)
 ;;=C79.31^^13^104^14
 ;;^UTILITY(U,$J,358.3,1515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1515,1,3,0)
 ;;=3^Secondary Malig Neop Brain
 ;;^UTILITY(U,$J,358.3,1515,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,1515,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,1516,0)
 ;;=D32.0^^13^104^1
 ;;^UTILITY(U,$J,358.3,1516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1516,1,3,0)
 ;;=3^Benign Neop Cerebral Meninges
 ;;^UTILITY(U,$J,358.3,1516,1,4,0)
 ;;=4^D32.0
 ;;^UTILITY(U,$J,358.3,1516,2)
 ;;=^267681
 ;;^UTILITY(U,$J,358.3,1517,0)
 ;;=D33.4^^13^104^3
 ;;^UTILITY(U,$J,358.3,1517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1517,1,3,0)
 ;;=3^Benign Neop Spinal Cord
 ;;^UTILITY(U,$J,358.3,1517,1,4,0)
 ;;=4^D33.4
 ;;^UTILITY(U,$J,358.3,1517,2)
 ;;=^267682
 ;;^UTILITY(U,$J,358.3,1518,0)
 ;;=D32.9^^13^104^2
 ;;^UTILITY(U,$J,358.3,1518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1518,1,3,0)
 ;;=3^Benign Neop Meninges
 ;;^UTILITY(U,$J,358.3,1518,1,4,0)
 ;;=4^D32.9
 ;;^UTILITY(U,$J,358.3,1518,2)
 ;;=^5002135
 ;;^UTILITY(U,$J,358.3,1519,0)
 ;;=D32.1^^13^104^4
 ;;^UTILITY(U,$J,358.3,1519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1519,1,3,0)
 ;;=3^Benign Neop Spinal Meninges
 ;;^UTILITY(U,$J,358.3,1519,1,4,0)
 ;;=4^D32.1
 ;;^UTILITY(U,$J,358.3,1519,2)
 ;;=^267683
 ;;^UTILITY(U,$J,358.3,1520,0)
 ;;=C70.0^^13^104^7
 ;;^UTILITY(U,$J,358.3,1520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1520,1,3,0)
 ;;=3^Malig Neop Cerebral Meninges
 ;;^UTILITY(U,$J,358.3,1520,1,4,0)
 ;;=4^C70.0
 ;;^UTILITY(U,$J,358.3,1520,2)
 ;;=^267291
 ;;^UTILITY(U,$J,358.3,1521,0)
 ;;=C70.9^^13^104^9
 ;;^UTILITY(U,$J,358.3,1521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1521,1,3,0)
 ;;=3^Malig Neop Spinal Meninges
 ;;^UTILITY(U,$J,358.3,1521,1,4,0)
 ;;=4^C70.9
 ;;^UTILITY(U,$J,358.3,1521,2)
 ;;=^5001293
 ;;^UTILITY(U,$J,358.3,1522,0)
 ;;=D49.6^^13^104^10
 ;;^UTILITY(U,$J,358.3,1522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1522,1,3,0)
 ;;=3^Neop of Unspec Behavior,Brain
 ;;^UTILITY(U,$J,358.3,1522,1,4,0)
 ;;=4^D49.6
 ;;^UTILITY(U,$J,358.3,1522,2)
 ;;=^5002276
 ;;^UTILITY(U,$J,358.3,1523,0)
 ;;=D49.7^^13^104^12
 ;;^UTILITY(U,$J,358.3,1523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1523,1,3,0)
 ;;=3^Neop of Unspec Behavior,Endo Glands & Oth Prt Nervous System
 ;;^UTILITY(U,$J,358.3,1523,1,4,0)
 ;;=4^D49.7
 ;;^UTILITY(U,$J,358.3,1523,2)
 ;;=^5002277
 ;;^UTILITY(U,$J,358.3,1524,0)
 ;;=D42.0^^13^104^11
 ;;^UTILITY(U,$J,358.3,1524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1524,1,3,0)
 ;;=3^Neop of Unspec Behavior,Cerebral Meninges
 ;;^UTILITY(U,$J,358.3,1524,1,4,0)
 ;;=4^D42.0
 ;;^UTILITY(U,$J,358.3,1524,2)
 ;;=^5002225
 ;;^UTILITY(U,$J,358.3,1525,0)
 ;;=D42.9^^13^104^13
 ;;^UTILITY(U,$J,358.3,1525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1525,1,3,0)
 ;;=3^Neop of Unspec Behavior,Spinal Meninges
 ;;^UTILITY(U,$J,358.3,1525,1,4,0)
 ;;=4^D42.9
 ;;^UTILITY(U,$J,358.3,1525,2)
 ;;=^5002227
 ;;^UTILITY(U,$J,358.3,1526,0)
 ;;=F03.90^^13^105^18
 ;;^UTILITY(U,$J,358.3,1526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1526,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,1526,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,1526,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,1527,0)
 ;;=G30.9^^13^105^5
 ;;^UTILITY(U,$J,358.3,1527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1527,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,1527,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,1527,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,1528,0)
 ;;=F03.91^^13^105^16
 ;;^UTILITY(U,$J,358.3,1528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1528,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,1528,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,1528,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,1529,0)
 ;;=G30.0^^13^105^3
 ;;^UTILITY(U,$J,358.3,1529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1529,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,1529,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,1529,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,1530,0)
 ;;=G30.1^^13^105^4
 ;;^UTILITY(U,$J,358.3,1530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1530,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,1530,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,1530,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,1531,0)
 ;;=G31.01^^13^105^32
 ;;^UTILITY(U,$J,358.3,1531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1531,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,1531,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,1531,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,1532,0)
 ;;=G31.83^^13^105^17
 ;;^UTILITY(U,$J,358.3,1532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1532,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,1532,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,1532,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,1533,0)
 ;;=F01.50^^13^105^38
 ;;^UTILITY(U,$J,358.3,1533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1533,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,1533,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,1533,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,1534,0)
 ;;=G31.84^^13^105^26
 ;;^UTILITY(U,$J,358.3,1534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1534,1,3,0)
 ;;=3^Mild Cognitive Impairment
 ;;^UTILITY(U,$J,358.3,1534,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,1534,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,1535,0)
 ;;=G31.85^^13^105^10
 ;;^UTILITY(U,$J,358.3,1535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1535,1,3,0)
 ;;=3^Corticobasal Degeneration
 ;;^UTILITY(U,$J,358.3,1535,1,4,0)
 ;;=4^G31.85
 ;;^UTILITY(U,$J,358.3,1535,2)
 ;;=^340507
 ;;^UTILITY(U,$J,358.3,1536,0)
 ;;=G10.^^13^105^23
 ;;^UTILITY(U,$J,358.3,1536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1536,1,3,0)
 ;;=3^Huntington's Disease
 ;;^UTILITY(U,$J,358.3,1536,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,1536,2)
 ;;=^5003751
 ;;^UTILITY(U,$J,358.3,1537,0)
 ;;=G11.3^^13^105^9
 ;;^UTILITY(U,$J,358.3,1537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1537,1,3,0)
 ;;=3^Cerebellar Ataxia w/ Defective DNA Repair
 ;;^UTILITY(U,$J,358.3,1537,1,4,0)
 ;;=4^G11.3
 ;;^UTILITY(U,$J,358.3,1537,2)
 ;;=^5003755
 ;;^UTILITY(U,$J,358.3,1538,0)
 ;;=G11.8^^13^105^22
 ;;^UTILITY(U,$J,358.3,1538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1538,1,3,0)
 ;;=3^Hereditary Ataxias,Other
 ;;^UTILITY(U,$J,358.3,1538,1,4,0)
 ;;=4^G11.8
 ;;^UTILITY(U,$J,358.3,1538,2)
 ;;=^5003757
 ;;^UTILITY(U,$J,358.3,1539,0)
 ;;=G12.9^^13^105^36
 ;;^UTILITY(U,$J,358.3,1539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1539,1,3,0)
 ;;=3^Spinal Muscular Atrophy,Unspec
 ;;^UTILITY(U,$J,358.3,1539,1,4,0)
 ;;=4^G12.9
 ;;^UTILITY(U,$J,358.3,1539,2)
 ;;=^5003764
 ;;^UTILITY(U,$J,358.3,1540,0)
 ;;=G12.21^^13^105^6
 ;;^UTILITY(U,$J,358.3,1540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1540,1,3,0)
 ;;=3^Amyotrophic Lateral Sclerosis
 ;;^UTILITY(U,$J,358.3,1540,1,4,0)
 ;;=4^G12.21
 ;;^UTILITY(U,$J,358.3,1540,2)
 ;;=^6639
 ;;^UTILITY(U,$J,358.3,1541,0)
 ;;=A81.9^^13^105^8
 ;;^UTILITY(U,$J,358.3,1541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1541,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,1541,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,1541,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,1542,0)
 ;;=A81.09^^13^105^11
 ;;^UTILITY(U,$J,358.3,1542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1542,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,1542,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,1542,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,1543,0)
 ;;=A81.00^^13^105^12
 ;;^UTILITY(U,$J,358.3,1543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1543,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,1543,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,1543,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,1544,0)
 ;;=A81.01^^13^105^13
 ;;^UTILITY(U,$J,358.3,1544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1544,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,1544,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,1544,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,1545,0)
 ;;=A81.89^^13^105^7
 ;;^UTILITY(U,$J,358.3,1545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1545,1,3,0)
 ;;=3^Atypical Virus Infection of CNS NEC
 ;;^UTILITY(U,$J,358.3,1545,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,1545,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,1546,0)
 ;;=A81.2^^13^105^33
 ;;^UTILITY(U,$J,358.3,1546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1546,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,1546,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,1546,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,1547,0)
 ;;=B20.^^13^105^20
 ;;^UTILITY(U,$J,358.3,1547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1547,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,1547,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,1547,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,1548,0)
 ;;=B20.^^13^105^21
 ;;^UTILITY(U,$J,358.3,1548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1548,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,1548,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,1548,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,1549,0)
 ;;=F10.27^^13^105^1
 ;;^UTILITY(U,$J,358.3,1549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1549,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,1549,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,1549,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,1550,0)
 ;;=F02.81^^13^105^14
 ;;^UTILITY(U,$J,358.3,1550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1550,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturb
 ;;^UTILITY(U,$J,358.3,1550,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,1550,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,1551,0)
 ;;=F02.80^^13^105^15
 ;;^UTILITY(U,$J,358.3,1551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1551,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,1551,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,1551,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,1552,0)
 ;;=F19.97^^13^105^35
 ;;^UTILITY(U,$J,358.3,1552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1552,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,1552,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,1552,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,1553,0)
 ;;=F01.51^^13^105^37
 ;;^UTILITY(U,$J,358.3,1553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1553,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,1553,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,1553,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,1554,0)
 ;;=G10.^^13^105^24
 ;;^UTILITY(U,$J,358.3,1554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1554,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,1554,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,1554,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,1555,0)
 ;;=G10.^^13^105^25
 ;;^UTILITY(U,$J,358.3,1555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1555,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,1555,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,1555,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,1556,0)
 ;;=G90.3^^13^105^27
 ;;^UTILITY(U,$J,358.3,1556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1556,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,1556,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,1556,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,1557,0)
 ;;=G91.2^^13^105^28
 ;;^UTILITY(U,$J,358.3,1557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1557,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,1557,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,1557,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,1558,0)
 ;;=G91.2^^13^105^29
 ;;^UTILITY(U,$J,358.3,1558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1558,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,1558,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,1558,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,1559,0)
 ;;=G30.8^^13^105^2
 ;;^UTILITY(U,$J,358.3,1559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1559,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,1559,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,1559,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,1560,0)
 ;;=G31.09^^13^105^19
 ;;^UTILITY(U,$J,358.3,1560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1560,1,3,0)
 ;;=3^Frontotemporal Dementia NEC
 ;;^UTILITY(U,$J,358.3,1560,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,1560,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,1561,0)
 ;;=G20.^^13^105^30
 ;;^UTILITY(U,$J,358.3,1561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1561,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,1561,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,1561,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,1562,0)
 ;;=G20.^^13^105^31
 ;;^UTILITY(U,$J,358.3,1562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1562,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,1562,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,1562,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,1563,0)
 ;;=G23.1^^13^105^34
 ;;^UTILITY(U,$J,358.3,1563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1563,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia
 ;;^UTILITY(U,$J,358.3,1563,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,1563,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,1564,0)
 ;;=E53.8^^13^106^7
 ;;^UTILITY(U,$J,358.3,1564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1564,1,3,0)
 ;;=3^Deficiency of Vitamin B Group,Other Spec
 ;;^UTILITY(U,$J,358.3,1564,1,4,0)
 ;;=4^E53.8
 ;;^UTILITY(U,$J,358.3,1564,2)
 ;;=^5002797
 ;;^UTILITY(U,$J,358.3,1565,0)
 ;;=F44.4^^13^106^5
 ;;^UTILITY(U,$J,358.3,1565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1565,1,3,0)
 ;;=3^Conversion Disorder w/ Motor Symptom/Deficit
 ;;^UTILITY(U,$J,358.3,1565,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,1565,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,1566,0)
 ;;=F44.6^^13^106^6
 ;;^UTILITY(U,$J,358.3,1566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1566,1,3,0)
 ;;=3^Conversion Disorder w/ Sensory Symptom/Deficit
 ;;^UTILITY(U,$J,358.3,1566,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,1566,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,1567,0)
 ;;=F10.20^^13^106^1
 ;;^UTILITY(U,$J,358.3,1567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1567,1,3,0)
 ;;=3^Alcohol Dependence Uncomplicated
 ;;^UTILITY(U,$J,358.3,1567,1,4,0)
 ;;=4^F10.20
