IBDEI00W ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1613,1,4,0)
 ;;=4^G50.0
 ;;^UTILITY(U,$J,358.3,1613,2)
 ;;=^121978
 ;;^UTILITY(U,$J,358.3,1614,0)
 ;;=G44.40^^18^135^4
 ;;^UTILITY(U,$J,358.3,1614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1614,1,3,0)
 ;;=3^Drug-Induced Headache Not Intractable NEC
 ;;^UTILITY(U,$J,358.3,1614,1,4,0)
 ;;=4^G44.40
 ;;^UTILITY(U,$J,358.3,1614,2)
 ;;=^5003947
 ;;^UTILITY(U,$J,358.3,1615,0)
 ;;=G43.901^^18^135^9
 ;;^UTILITY(U,$J,358.3,1615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1615,1,3,0)
 ;;=3^Migraine Not Intractable w/ Status Migrainosus
 ;;^UTILITY(U,$J,358.3,1615,1,4,0)
 ;;=4^G43.901
 ;;^UTILITY(U,$J,358.3,1615,2)
 ;;=^5003908
 ;;^UTILITY(U,$J,358.3,1616,0)
 ;;=G43.101^^18^135^14
 ;;^UTILITY(U,$J,358.3,1616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1616,1,3,0)
 ;;=3^Migraine w/ Aura Not Intractable w/ Status Migrainosus
 ;;^UTILITY(U,$J,358.3,1616,1,4,0)
 ;;=4^G43.101
 ;;^UTILITY(U,$J,358.3,1616,2)
 ;;=^5003880
 ;;^UTILITY(U,$J,358.3,1617,0)
 ;;=G43.001^^18^135^18
 ;;^UTILITY(U,$J,358.3,1617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1617,1,3,0)
 ;;=3^Migraine w/o Aura Not Intractable w/ Status Migrainosus
 ;;^UTILITY(U,$J,358.3,1617,1,4,0)
 ;;=4^G43.001
 ;;^UTILITY(U,$J,358.3,1617,2)
 ;;=^5003876
 ;;^UTILITY(U,$J,358.3,1618,0)
 ;;=G44.309^^18^135^20
 ;;^UTILITY(U,$J,358.3,1618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1618,1,3,0)
 ;;=3^Post-Traumatic Headache Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,1618,1,4,0)
 ;;=4^G44.309
 ;;^UTILITY(U,$J,358.3,1618,2)
 ;;=^5003942
 ;;^UTILITY(U,$J,358.3,1619,0)
 ;;=G44.201^^18^135^21
 ;;^UTILITY(U,$J,358.3,1619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1619,1,3,0)
 ;;=3^Tension-Type Headache Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,1619,1,4,0)
 ;;=4^G44.201
 ;;^UTILITY(U,$J,358.3,1619,2)
 ;;=^5003935
 ;;^UTILITY(U,$J,358.3,1620,0)
 ;;=G20.^^18^136^14
 ;;^UTILITY(U,$J,358.3,1620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1620,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,1620,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,1620,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,1621,0)
 ;;=G21.8^^18^136^19
 ;;^UTILITY(U,$J,358.3,1621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1621,1,3,0)
 ;;=3^Secondary Parkinsonism,Other
 ;;^UTILITY(U,$J,358.3,1621,1,4,0)
 ;;=4^G21.8
 ;;^UTILITY(U,$J,358.3,1621,2)
 ;;=^5003777
 ;;^UTILITY(U,$J,358.3,1622,0)
 ;;=G25.0^^18^136^9
 ;;^UTILITY(U,$J,358.3,1622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1622,1,3,0)
 ;;=3^Essential Tremor
 ;;^UTILITY(U,$J,358.3,1622,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,1622,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,1623,0)
 ;;=G25.1^^18^136^7
 ;;^UTILITY(U,$J,358.3,1623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1623,1,3,0)
 ;;=3^Drug-Induced Tremor
 ;;^UTILITY(U,$J,358.3,1623,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,1623,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,1624,0)
 ;;=G25.2^^18^136^23
 ;;^UTILITY(U,$J,358.3,1624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1624,1,3,0)
 ;;=3^Tremor,Other Spec Forms
 ;;^UTILITY(U,$J,358.3,1624,1,4,0)
 ;;=4^G25.2
 ;;^UTILITY(U,$J,358.3,1624,2)
 ;;=^5003793
 ;;^UTILITY(U,$J,358.3,1625,0)
 ;;=G25.3^^18^136^12
 ;;^UTILITY(U,$J,358.3,1625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1625,1,3,0)
 ;;=3^Myoclonus
 ;;^UTILITY(U,$J,358.3,1625,1,4,0)
 ;;=4^G25.3
 ;;^UTILITY(U,$J,358.3,1625,2)
 ;;=^80620
 ;;^UTILITY(U,$J,358.3,1626,0)
 ;;=G25.69^^18^136^21
 ;;^UTILITY(U,$J,358.3,1626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1626,1,3,0)
 ;;=3^Tics,Organic Origin,Other
 ;;^UTILITY(U,$J,358.3,1626,1,4,0)
 ;;=4^G25.69
 ;;^UTILITY(U,$J,358.3,1626,2)
 ;;=^5003797
 ;;^UTILITY(U,$J,358.3,1627,0)
 ;;=G25.61^^18^136^6
 ;;^UTILITY(U,$J,358.3,1627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1627,1,3,0)
 ;;=3^Drug-Induced Tics
 ;;^UTILITY(U,$J,358.3,1627,1,4,0)
 ;;=4^G25.61
 ;;^UTILITY(U,$J,358.3,1627,2)
 ;;=^5003796
 ;;^UTILITY(U,$J,358.3,1628,0)
 ;;=G25.81^^18^136^18
 ;;^UTILITY(U,$J,358.3,1628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1628,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,1628,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,1628,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,1629,0)
 ;;=R27.0^^18^136^2
 ;;^UTILITY(U,$J,358.3,1629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1629,1,3,0)
 ;;=3^Ataxia,Unspec
 ;;^UTILITY(U,$J,358.3,1629,1,4,0)
 ;;=4^R27.0
 ;;^UTILITY(U,$J,358.3,1629,2)
 ;;=^5019310
 ;;^UTILITY(U,$J,358.3,1630,0)
 ;;=G24.9^^18^136^8
 ;;^UTILITY(U,$J,358.3,1630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1630,1,3,0)
 ;;=3^Dystonia,Unspec
 ;;^UTILITY(U,$J,358.3,1630,1,4,0)
 ;;=4^G24.9
 ;;^UTILITY(U,$J,358.3,1630,2)
 ;;=^5003790
 ;;^UTILITY(U,$J,358.3,1631,0)
 ;;=G23.0^^18^136^10
 ;;^UTILITY(U,$J,358.3,1631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1631,1,3,0)
 ;;=3^Hallervorden-Spatz Disease
 ;;^UTILITY(U,$J,358.3,1631,1,4,0)
 ;;=4^G23.0
 ;;^UTILITY(U,$J,358.3,1631,2)
 ;;=^5003779
 ;;^UTILITY(U,$J,358.3,1632,0)
 ;;=G90.3^^18^136^11
 ;;^UTILITY(U,$J,358.3,1632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1632,1,3,0)
 ;;=3^Multi-Syst Degeneration of Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,1632,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,1632,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,1633,0)
 ;;=G21.11^^18^136^13
 ;;^UTILITY(U,$J,358.3,1633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1633,1,3,0)
 ;;=3^Neuroleptic Induced Parkinsonism
 ;;^UTILITY(U,$J,358.3,1633,1,4,0)
 ;;=4^G21.11
 ;;^UTILITY(U,$J,358.3,1633,2)
 ;;=^5003772
 ;;^UTILITY(U,$J,358.3,1634,0)
 ;;=G21.19^^18^136^5
 ;;^UTILITY(U,$J,358.3,1634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1634,1,3,0)
 ;;=3^Drug-Induced Secondary Parkinsonism
 ;;^UTILITY(U,$J,358.3,1634,1,4,0)
 ;;=4^G21.19
 ;;^UTILITY(U,$J,358.3,1634,2)
 ;;=^5003773
 ;;^UTILITY(U,$J,358.3,1635,0)
 ;;=G23.8^^18^136^4
 ;;^UTILITY(U,$J,358.3,1635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1635,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia
 ;;^UTILITY(U,$J,358.3,1635,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,1635,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,1636,0)
 ;;=G47.61^^18^136^15
 ;;^UTILITY(U,$J,358.3,1636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1636,1,3,0)
 ;;=3^Periodic Limb Movement Disorder
 ;;^UTILITY(U,$J,358.3,1636,1,4,0)
 ;;=4^G47.61
 ;;^UTILITY(U,$J,358.3,1636,2)
 ;;=^5003987
 ;;^UTILITY(U,$J,358.3,1637,0)
 ;;=G23.1^^18^136^16
 ;;^UTILITY(U,$J,358.3,1637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1637,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia
 ;;^UTILITY(U,$J,358.3,1637,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,1637,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,1638,0)
 ;;=G47.52^^18^136^17
 ;;^UTILITY(U,$J,358.3,1638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1638,1,3,0)
 ;;=3^REM Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,1638,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,1638,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,1639,0)
 ;;=G23.2^^18^136^20
 ;;^UTILITY(U,$J,358.3,1639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1639,1,3,0)
 ;;=3^Striatonigral Degeneration
 ;;^UTILITY(U,$J,358.3,1639,1,4,0)
 ;;=4^G23.2
 ;;^UTILITY(U,$J,358.3,1639,2)
 ;;=^5003781
 ;;^UTILITY(U,$J,358.3,1640,0)
 ;;=F95.2^^18^136^22
 ;;^UTILITY(U,$J,358.3,1640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1640,1,3,0)
 ;;=3^Tourett's Disorder
 ;;^UTILITY(U,$J,358.3,1640,1,4,0)
 ;;=4^F95.2
 ;;^UTILITY(U,$J,358.3,1640,2)
 ;;=^331942
 ;;^UTILITY(U,$J,358.3,1641,0)
 ;;=G21.4^^18^136^24
 ;;^UTILITY(U,$J,358.3,1641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1641,1,3,0)
 ;;=3^Vascular Parkinsonism
 ;;^UTILITY(U,$J,358.3,1641,1,4,0)
 ;;=4^G21.4
 ;;^UTILITY(U,$J,358.3,1641,2)
 ;;=^5003776
 ;;^UTILITY(U,$J,358.3,1642,0)
 ;;=I69.393^^18^136^1
 ;;^UTILITY(U,$J,358.3,1642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1642,1,3,0)
 ;;=3^Ataxia following Cerebral Infarction
 ;;^UTILITY(U,$J,358.3,1642,1,4,0)
 ;;=4^I69.393
 ;;^UTILITY(U,$J,358.3,1642,2)
 ;;=^5007518
 ;;^UTILITY(U,$J,358.3,1643,0)
 ;;=F44.4^^18^136^3
 ;;^UTILITY(U,$J,358.3,1643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1643,1,3,0)
 ;;=3^Conversion Disorder w/ Motor Symptom or Deficit
 ;;^UTILITY(U,$J,358.3,1643,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,1643,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,1644,0)
 ;;=C71.9^^18^137^5
 ;;^UTILITY(U,$J,358.3,1644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1644,1,3,0)
 ;;=3^Malig Neop Brain,Unspec
 ;;^UTILITY(U,$J,358.3,1644,1,4,0)
 ;;=4^C71.9
 ;;^UTILITY(U,$J,358.3,1644,2)
 ;;=^5001297
 ;;^UTILITY(U,$J,358.3,1645,0)
 ;;=C72.0^^18^137^8
 ;;^UTILITY(U,$J,358.3,1645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1645,1,3,0)
 ;;=3^Malig Neop Spinal Cord
 ;;^UTILITY(U,$J,358.3,1645,1,4,0)
 ;;=4^C72.0
 ;;^UTILITY(U,$J,358.3,1645,2)
 ;;=^267292
 ;;^UTILITY(U,$J,358.3,1646,0)
 ;;=C72.1^^18^137^6
 ;;^UTILITY(U,$J,358.3,1646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1646,1,3,0)
 ;;=3^Malig Neop Cauda Equina
 ;;^UTILITY(U,$J,358.3,1646,1,4,0)
 ;;=4^C72.1
 ;;^UTILITY(U,$J,358.3,1646,2)
 ;;=^5001298
 ;;^UTILITY(U,$J,358.3,1647,0)
 ;;=C79.31^^18^137^14
 ;;^UTILITY(U,$J,358.3,1647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1647,1,3,0)
 ;;=3^Secondary Malig Neop Brain
 ;;^UTILITY(U,$J,358.3,1647,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,1647,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,1648,0)
 ;;=D32.0^^18^137^1
 ;;^UTILITY(U,$J,358.3,1648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1648,1,3,0)
 ;;=3^Benign Neop Cerebral Meninges
 ;;^UTILITY(U,$J,358.3,1648,1,4,0)
 ;;=4^D32.0
 ;;^UTILITY(U,$J,358.3,1648,2)
 ;;=^267681
 ;;^UTILITY(U,$J,358.3,1649,0)
 ;;=D33.4^^18^137^3
 ;;^UTILITY(U,$J,358.3,1649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1649,1,3,0)
 ;;=3^Benign Neop Spinal Cord
 ;;^UTILITY(U,$J,358.3,1649,1,4,0)
 ;;=4^D33.4
 ;;^UTILITY(U,$J,358.3,1649,2)
 ;;=^267682
 ;;^UTILITY(U,$J,358.3,1650,0)
 ;;=D32.9^^18^137^2
 ;;^UTILITY(U,$J,358.3,1650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1650,1,3,0)
 ;;=3^Benign Neop Meninges
 ;;^UTILITY(U,$J,358.3,1650,1,4,0)
 ;;=4^D32.9
 ;;^UTILITY(U,$J,358.3,1650,2)
 ;;=^5002135
 ;;^UTILITY(U,$J,358.3,1651,0)
 ;;=D32.1^^18^137^4
 ;;^UTILITY(U,$J,358.3,1651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1651,1,3,0)
 ;;=3^Benign Neop Spinal Meninges
 ;;^UTILITY(U,$J,358.3,1651,1,4,0)
 ;;=4^D32.1
 ;;^UTILITY(U,$J,358.3,1651,2)
 ;;=^267683
 ;;^UTILITY(U,$J,358.3,1652,0)
 ;;=C70.0^^18^137^7
 ;;^UTILITY(U,$J,358.3,1652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1652,1,3,0)
 ;;=3^Malig Neop Cerebral Meninges
 ;;^UTILITY(U,$J,358.3,1652,1,4,0)
 ;;=4^C70.0
 ;;^UTILITY(U,$J,358.3,1652,2)
 ;;=^267291
 ;;^UTILITY(U,$J,358.3,1653,0)
 ;;=C70.9^^18^137^9
 ;;^UTILITY(U,$J,358.3,1653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1653,1,3,0)
 ;;=3^Malig Neop Spinal Meninges
 ;;^UTILITY(U,$J,358.3,1653,1,4,0)
 ;;=4^C70.9
 ;;^UTILITY(U,$J,358.3,1653,2)
 ;;=^5001293
 ;;^UTILITY(U,$J,358.3,1654,0)
 ;;=D49.6^^18^137^10
 ;;^UTILITY(U,$J,358.3,1654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1654,1,3,0)
 ;;=3^Neop of Unspec Behavior,Brain
 ;;^UTILITY(U,$J,358.3,1654,1,4,0)
 ;;=4^D49.6
 ;;^UTILITY(U,$J,358.3,1654,2)
 ;;=^5002276
 ;;^UTILITY(U,$J,358.3,1655,0)
 ;;=D49.7^^18^137^12
 ;;^UTILITY(U,$J,358.3,1655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1655,1,3,0)
 ;;=3^Neop of Unspec Behavior,Endo Glands & Oth Prt Nervous System
 ;;^UTILITY(U,$J,358.3,1655,1,4,0)
 ;;=4^D49.7
 ;;^UTILITY(U,$J,358.3,1655,2)
 ;;=^5002277
 ;;^UTILITY(U,$J,358.3,1656,0)
 ;;=D42.0^^18^137^11
 ;;^UTILITY(U,$J,358.3,1656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1656,1,3,0)
 ;;=3^Neop of Unspec Behavior,Cerebral Meninges
 ;;^UTILITY(U,$J,358.3,1656,1,4,0)
 ;;=4^D42.0
 ;;^UTILITY(U,$J,358.3,1656,2)
 ;;=^5002225
 ;;^UTILITY(U,$J,358.3,1657,0)
 ;;=D42.9^^18^137^13
 ;;^UTILITY(U,$J,358.3,1657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1657,1,3,0)
 ;;=3^Neop of Unspec Behavior,Spinal Meninges
 ;;^UTILITY(U,$J,358.3,1657,1,4,0)
 ;;=4^D42.9
 ;;^UTILITY(U,$J,358.3,1657,2)
 ;;=^5002227
 ;;^UTILITY(U,$J,358.3,1658,0)
 ;;=F03.90^^18^138^18
 ;;^UTILITY(U,$J,358.3,1658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1658,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,1658,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,1658,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,1659,0)
 ;;=G30.9^^18^138^5
 ;;^UTILITY(U,$J,358.3,1659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1659,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,1659,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,1659,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,1660,0)
 ;;=F03.91^^18^138^16
 ;;^UTILITY(U,$J,358.3,1660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1660,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,1660,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,1660,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,1661,0)
 ;;=G30.0^^18^138^3
 ;;^UTILITY(U,$J,358.3,1661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1661,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,1661,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,1661,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,1662,0)
 ;;=G30.1^^18^138^4
 ;;^UTILITY(U,$J,358.3,1662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1662,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,1662,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,1662,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,1663,0)
 ;;=G31.01^^18^138^32
 ;;^UTILITY(U,$J,358.3,1663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1663,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,1663,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,1663,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,1664,0)
 ;;=G31.83^^18^138^17
 ;;^UTILITY(U,$J,358.3,1664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1664,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,1664,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,1664,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,1665,0)
 ;;=F01.50^^18^138^38
 ;;^UTILITY(U,$J,358.3,1665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1665,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,1665,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,1665,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,1666,0)
 ;;=G31.84^^18^138^26
 ;;^UTILITY(U,$J,358.3,1666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1666,1,3,0)
 ;;=3^Mild Cognitive Impairment
 ;;^UTILITY(U,$J,358.3,1666,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,1666,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,1667,0)
 ;;=G31.85^^18^138^10
 ;;^UTILITY(U,$J,358.3,1667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1667,1,3,0)
 ;;=3^Corticobasal Degeneration
 ;;^UTILITY(U,$J,358.3,1667,1,4,0)
 ;;=4^G31.85
 ;;^UTILITY(U,$J,358.3,1667,2)
 ;;=^340507
 ;;^UTILITY(U,$J,358.3,1668,0)
 ;;=G10.^^18^138^23
 ;;^UTILITY(U,$J,358.3,1668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1668,1,3,0)
 ;;=3^Huntington's Disease
 ;;^UTILITY(U,$J,358.3,1668,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,1668,2)
 ;;=^5003751
 ;;^UTILITY(U,$J,358.3,1669,0)
 ;;=G11.3^^18^138^9
 ;;^UTILITY(U,$J,358.3,1669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1669,1,3,0)
 ;;=3^Cerebellar Ataxia w/ Defective DNA Repair
 ;;^UTILITY(U,$J,358.3,1669,1,4,0)
 ;;=4^G11.3
 ;;^UTILITY(U,$J,358.3,1669,2)
 ;;=^5003755
 ;;^UTILITY(U,$J,358.3,1670,0)
 ;;=G11.8^^18^138^22
 ;;^UTILITY(U,$J,358.3,1670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1670,1,3,0)
 ;;=3^Hereditary Ataxias,Other
 ;;^UTILITY(U,$J,358.3,1670,1,4,0)
 ;;=4^G11.8
 ;;^UTILITY(U,$J,358.3,1670,2)
 ;;=^5003757
 ;;^UTILITY(U,$J,358.3,1671,0)
 ;;=G12.9^^18^138^36
 ;;^UTILITY(U,$J,358.3,1671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1671,1,3,0)
 ;;=3^Spinal Muscular Atrophy,Unspec
 ;;^UTILITY(U,$J,358.3,1671,1,4,0)
 ;;=4^G12.9
 ;;^UTILITY(U,$J,358.3,1671,2)
 ;;=^5003764
 ;;^UTILITY(U,$J,358.3,1672,0)
 ;;=G12.21^^18^138^6
 ;;^UTILITY(U,$J,358.3,1672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1672,1,3,0)
 ;;=3^Amyotrophic Lateral Sclerosis
 ;;^UTILITY(U,$J,358.3,1672,1,4,0)
 ;;=4^G12.21
 ;;^UTILITY(U,$J,358.3,1672,2)
 ;;=^6639
 ;;^UTILITY(U,$J,358.3,1673,0)
 ;;=A81.9^^18^138^8
 ;;^UTILITY(U,$J,358.3,1673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1673,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,1673,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,1673,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,1674,0)
 ;;=A81.09^^18^138^11
 ;;^UTILITY(U,$J,358.3,1674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1674,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,1674,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,1674,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,1675,0)
 ;;=A81.00^^18^138^12
 ;;^UTILITY(U,$J,358.3,1675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1675,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,1675,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,1675,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,1676,0)
 ;;=A81.01^^18^138^13
 ;;^UTILITY(U,$J,358.3,1676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1676,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,1676,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,1676,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,1677,0)
 ;;=A81.89^^18^138^7
 ;;^UTILITY(U,$J,358.3,1677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1677,1,3,0)
 ;;=3^Atypical Virus Infection of CNS NEC
 ;;^UTILITY(U,$J,358.3,1677,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,1677,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,1678,0)
 ;;=A81.2^^18^138^33
 ;;^UTILITY(U,$J,358.3,1678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1678,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,1678,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,1678,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,1679,0)
 ;;=B20.^^18^138^20
 ;;^UTILITY(U,$J,358.3,1679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1679,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,1679,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,1679,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,1680,0)
 ;;=B20.^^18^138^21
 ;;^UTILITY(U,$J,358.3,1680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1680,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,1680,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,1680,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,1681,0)
 ;;=F10.27^^18^138^1
 ;;^UTILITY(U,$J,358.3,1681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1681,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,1681,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,1681,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,1682,0)
 ;;=F02.81^^18^138^14
 ;;^UTILITY(U,$J,358.3,1682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1682,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturb
 ;;^UTILITY(U,$J,358.3,1682,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,1682,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,1683,0)
 ;;=F02.80^^18^138^15
 ;;^UTILITY(U,$J,358.3,1683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1683,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
