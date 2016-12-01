IBDEI01N ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1603,1,3,0)
 ;;=3^Occlusion/Stenosis of Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,1603,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,1603,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,1604,0)
 ;;=I63.031^^8^128^56
 ;;^UTILITY(U,$J,358.3,1604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1604,1,3,0)
 ;;=3^Cerebral Infarction d/t Thrombosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,1604,1,4,0)
 ;;=4^I63.031
 ;;^UTILITY(U,$J,358.3,1604,2)
 ;;=^5007299
 ;;^UTILITY(U,$J,358.3,1605,0)
 ;;=I65.01^^8^128^82
 ;;^UTILITY(U,$J,358.3,1605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1605,1,3,0)
 ;;=3^Occlusion/Stenosis of Right Vertebral Artery
 ;;^UTILITY(U,$J,358.3,1605,1,4,0)
 ;;=4^I65.01
 ;;^UTILITY(U,$J,358.3,1605,2)
 ;;=^5007356
 ;;^UTILITY(U,$J,358.3,1606,0)
 ;;=I65.02^^8^128^79
 ;;^UTILITY(U,$J,358.3,1606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1606,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Vertebral Artery
 ;;^UTILITY(U,$J,358.3,1606,1,4,0)
 ;;=4^I65.02
 ;;^UTILITY(U,$J,358.3,1606,2)
 ;;=^5007357
 ;;^UTILITY(U,$J,358.3,1607,0)
 ;;=I65.03^^8^128^77
 ;;^UTILITY(U,$J,358.3,1607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1607,1,3,0)
 ;;=3^Occlusion/Stenosis of Bilateral Vertebral Arteries
 ;;^UTILITY(U,$J,358.3,1607,1,4,0)
 ;;=4^I65.03
 ;;^UTILITY(U,$J,358.3,1607,2)
 ;;=^5007358
 ;;^UTILITY(U,$J,358.3,1608,0)
 ;;=I65.8^^8^128^80
 ;;^UTILITY(U,$J,358.3,1608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1608,1,3,0)
 ;;=3^Occlusion/Stenosis of Precerebral Arteries NEC
 ;;^UTILITY(U,$J,358.3,1608,1,4,0)
 ;;=4^I65.8
 ;;^UTILITY(U,$J,358.3,1608,2)
 ;;=^5007364
 ;;^UTILITY(U,$J,358.3,1609,0)
 ;;=I63.032^^8^128^55
 ;;^UTILITY(U,$J,358.3,1609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1609,1,3,0)
 ;;=3^Cerebral Infarction d/t Thrombosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,1609,1,4,0)
 ;;=4^I63.032
 ;;^UTILITY(U,$J,358.3,1609,2)
 ;;=^5007300
 ;;^UTILITY(U,$J,358.3,1610,0)
 ;;=I63.131^^8^128^54
 ;;^UTILITY(U,$J,358.3,1610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1610,1,3,0)
 ;;=3^Cerebral Infarction d/t Embolism of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,1610,1,4,0)
 ;;=4^I63.131
 ;;^UTILITY(U,$J,358.3,1610,2)
 ;;=^5007308
 ;;^UTILITY(U,$J,358.3,1611,0)
 ;;=I63.132^^8^128^53
 ;;^UTILITY(U,$J,358.3,1611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1611,1,3,0)
 ;;=3^Cerebral Infarction d/t Embolism of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,1611,1,4,0)
 ;;=4^I63.132
 ;;^UTILITY(U,$J,358.3,1611,2)
 ;;=^5007309
 ;;^UTILITY(U,$J,358.3,1612,0)
 ;;=I63.231^^8^128^57
 ;;^UTILITY(U,$J,358.3,1612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1612,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occlusion/Stenosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,1612,1,4,0)
 ;;=4^I63.231
 ;;^UTILITY(U,$J,358.3,1612,2)
 ;;=^5007316
 ;;^UTILITY(U,$J,358.3,1613,0)
 ;;=I63.232^^8^128^58
 ;;^UTILITY(U,$J,358.3,1613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1613,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occlusion/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,1613,1,4,0)
 ;;=4^I63.232
 ;;^UTILITY(U,$J,358.3,1613,2)
 ;;=^5007317
 ;;^UTILITY(U,$J,358.3,1614,0)
 ;;=I63.211^^8^128^59
 ;;^UTILITY(U,$J,358.3,1614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1614,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occlusion/Stenosis of Right Vertebral Artery
 ;;^UTILITY(U,$J,358.3,1614,1,4,0)
 ;;=4^I63.211
 ;;^UTILITY(U,$J,358.3,1614,2)
 ;;=^5007313
 ;;^UTILITY(U,$J,358.3,1615,0)
 ;;=I63.212^^8^128^60
 ;;^UTILITY(U,$J,358.3,1615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1615,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occlusion/Stenosis of Left Vertebral Artery
 ;;^UTILITY(U,$J,358.3,1615,1,4,0)
 ;;=4^I63.212
 ;;^UTILITY(U,$J,358.3,1615,2)
 ;;=^5007314
 ;;^UTILITY(U,$J,358.3,1616,0)
 ;;=G45.9^^8^128^94
 ;;^UTILITY(U,$J,358.3,1616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1616,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attack,Unspec
 ;;^UTILITY(U,$J,358.3,1616,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,1616,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,1617,0)
 ;;=I70.0^^8^128^14
 ;;^UTILITY(U,$J,358.3,1617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1617,1,3,0)
 ;;=3^Atherosclerosis of Aorta
 ;;^UTILITY(U,$J,358.3,1617,1,4,0)
 ;;=4^I70.0
 ;;^UTILITY(U,$J,358.3,1617,2)
 ;;=^269759
 ;;^UTILITY(U,$J,358.3,1618,0)
 ;;=I70.1^^8^128^16
 ;;^UTILITY(U,$J,358.3,1618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1618,1,3,0)
 ;;=3^Atherosclerosis of Renal Artery
 ;;^UTILITY(U,$J,358.3,1618,1,4,0)
 ;;=4^I70.1
 ;;^UTILITY(U,$J,358.3,1618,2)
 ;;=^269760
 ;;^UTILITY(U,$J,358.3,1619,0)
 ;;=I70.211^^8^128^36
 ;;^UTILITY(U,$J,358.3,1619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1619,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,1619,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,1619,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,1620,0)
 ;;=I70.212^^8^128^32
 ;;^UTILITY(U,$J,358.3,1620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1620,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,1620,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,1620,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,1621,0)
 ;;=I70.213^^8^128^28
 ;;^UTILITY(U,$J,358.3,1621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1621,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,1621,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,1621,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,1622,0)
 ;;=I70.221^^8^128^37
 ;;^UTILITY(U,$J,358.3,1622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1622,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,1622,1,4,0)
 ;;=4^I70.221
 ;;^UTILITY(U,$J,358.3,1622,2)
 ;;=^5007583
 ;;^UTILITY(U,$J,358.3,1623,0)
 ;;=I70.222^^8^128^33
 ;;^UTILITY(U,$J,358.3,1623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1623,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,1623,1,4,0)
 ;;=4^I70.222
 ;;^UTILITY(U,$J,358.3,1623,2)
 ;;=^5007584
 ;;^UTILITY(U,$J,358.3,1624,0)
 ;;=I70.223^^8^128^29
 ;;^UTILITY(U,$J,358.3,1624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1624,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,1624,1,4,0)
 ;;=4^I70.223
 ;;^UTILITY(U,$J,358.3,1624,2)
 ;;=^5007585
 ;;^UTILITY(U,$J,358.3,1625,0)
 ;;=I70.231^^8^128^38
 ;;^UTILITY(U,$J,358.3,1625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1625,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Thigh Ulceration
 ;;^UTILITY(U,$J,358.3,1625,1,4,0)
 ;;=4^I70.231
 ;;^UTILITY(U,$J,358.3,1625,2)
 ;;=^5007588
 ;;^UTILITY(U,$J,358.3,1626,0)
 ;;=I70.234^^8^128^39
 ;;^UTILITY(U,$J,358.3,1626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1626,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Heel/Midfoot Ulcer
 ;;^UTILITY(U,$J,358.3,1626,1,4,0)
 ;;=4^I70.234
 ;;^UTILITY(U,$J,358.3,1626,2)
 ;;=^5007591
 ;;^UTILITY(U,$J,358.3,1627,0)
 ;;=I70.239^^8^128^40
 ;;^UTILITY(U,$J,358.3,1627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1627,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,1627,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,1627,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,1628,0)
 ;;=I70.241^^8^128^34
 ;;^UTILITY(U,$J,358.3,1628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1628,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Thigh Ulceration
 ;;^UTILITY(U,$J,358.3,1628,1,4,0)
 ;;=4^I70.241
 ;;^UTILITY(U,$J,358.3,1628,2)
 ;;=^5007595
 ;;^UTILITY(U,$J,358.3,1629,0)
 ;;=I70.249^^8^128^35
 ;;^UTILITY(U,$J,358.3,1629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1629,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,1629,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,1629,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,1630,0)
 ;;=I70.262^^8^128^31
 ;;^UTILITY(U,$J,358.3,1630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1630,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,1630,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,1630,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,1631,0)
 ;;=I70.261^^8^128^41
 ;;^UTILITY(U,$J,358.3,1631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1631,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,1631,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,1631,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,1632,0)
 ;;=I70.263^^8^128^30
 ;;^UTILITY(U,$J,358.3,1632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1632,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Gangrene
 ;;^UTILITY(U,$J,358.3,1632,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,1632,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,1633,0)
 ;;=I70.301^^8^128^50
 ;;^UTILITY(U,$J,358.3,1633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1633,1,3,0)
 ;;=3^Athscl Unspec Type Bypass of Right Leg
 ;;^UTILITY(U,$J,358.3,1633,1,4,0)
 ;;=4^I70.301
 ;;^UTILITY(U,$J,358.3,1633,2)
 ;;=^5007611
 ;;^UTILITY(U,$J,358.3,1634,0)
 ;;=I70.302^^8^128^49
 ;;^UTILITY(U,$J,358.3,1634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1634,1,3,0)
 ;;=3^Athscl Unspec Type Bypass of Left Leg
 ;;^UTILITY(U,$J,358.3,1634,1,4,0)
 ;;=4^I70.302
 ;;^UTILITY(U,$J,358.3,1634,2)
 ;;=^5007612
 ;;^UTILITY(U,$J,358.3,1635,0)
 ;;=I70.303^^8^128^48
 ;;^UTILITY(U,$J,358.3,1635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1635,1,3,0)
 ;;=3^Athscl Unspec Type Bypass of Bilateral Legs
 ;;^UTILITY(U,$J,358.3,1635,1,4,0)
 ;;=4^I70.303
 ;;^UTILITY(U,$J,358.3,1635,2)
 ;;=^5007613
 ;;^UTILITY(U,$J,358.3,1636,0)
 ;;=I70.411^^8^128^24
 ;;^UTILITY(U,$J,358.3,1636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1636,1,3,0)
 ;;=3^Athscl Autologous Vein Bypass of Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,1636,1,4,0)
 ;;=4^I70.411
 ;;^UTILITY(U,$J,358.3,1636,2)
 ;;=^5007654
