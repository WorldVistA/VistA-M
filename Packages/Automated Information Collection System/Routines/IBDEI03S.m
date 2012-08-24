IBDEI03S ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4776,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4776,1,4,0)
 ;;=4^Laceration, Face, Nos
 ;;^UTILITY(U,$J,358.3,4776,1,5,0)
 ;;=5^873.40
 ;;^UTILITY(U,$J,358.3,4776,2)
 ;;=Laceration, Face, NOS^274939
 ;;^UTILITY(U,$J,358.3,4777,0)
 ;;=874.8^^42^330^8
 ;;^UTILITY(U,$J,358.3,4777,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4777,1,4,0)
 ;;=4^Laceration, Neck
 ;;^UTILITY(U,$J,358.3,4777,1,5,0)
 ;;=5^874.8
 ;;^UTILITY(U,$J,358.3,4777,2)
 ;;=Laceration, Neck^274988
 ;;^UTILITY(U,$J,358.3,4778,0)
 ;;=873.20^^42^330^4.25
 ;;^UTILITY(U,$J,358.3,4778,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4778,1,4,0)
 ;;=4^Laceration, Nose
 ;;^UTILITY(U,$J,358.3,4778,1,5,0)
 ;;=5^873.20
 ;;^UTILITY(U,$J,358.3,4778,2)
 ;;=Laceration, Nose^274924
 ;;^UTILITY(U,$J,358.3,4779,0)
 ;;=873.0^^42^330^2
 ;;^UTILITY(U,$J,358.3,4779,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4779,1,4,0)
 ;;=4^Laceration, Scalp
 ;;^UTILITY(U,$J,358.3,4779,1,5,0)
 ;;=5^873.0
 ;;^UTILITY(U,$J,358.3,4779,2)
 ;;=Laceration, Scalp^274921
 ;;^UTILITY(U,$J,358.3,4780,0)
 ;;=880.02^^42^330^11
 ;;^UTILITY(U,$J,358.3,4780,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4780,1,4,0)
 ;;=4^Laceration, Axilla
 ;;^UTILITY(U,$J,358.3,4780,1,5,0)
 ;;=5^880.02
 ;;^UTILITY(U,$J,358.3,4780,2)
 ;;=Laceration, Axilla^275027
 ;;^UTILITY(U,$J,358.3,4781,0)
 ;;=877.0^^42^330^12
 ;;^UTILITY(U,$J,358.3,4781,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4781,1,4,0)
 ;;=4^Laceration, Buttock
 ;;^UTILITY(U,$J,358.3,4781,1,5,0)
 ;;=5^877.0
 ;;^UTILITY(U,$J,358.3,4781,2)
 ;;=Laceration, Buttock^274999
 ;;^UTILITY(U,$J,358.3,4782,0)
 ;;=879.4^^42^330^11.5
 ;;^UTILITY(U,$J,358.3,4782,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4782,1,4,0)
 ;;=4^Laceration, Groin/Inguinal
 ;;^UTILITY(U,$J,358.3,4782,1,5,0)
 ;;=5^879.4
 ;;^UTILITY(U,$J,358.3,4782,2)
 ;;=Laceration, Groin/Inguinal^275017
 ;;^UTILITY(U,$J,358.3,4783,0)
 ;;=884.0^^42^330^18.75
 ;;^UTILITY(U,$J,358.3,4783,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4783,1,4,0)
 ;;=4^Laceration, Arm Nos
 ;;^UTILITY(U,$J,358.3,4783,1,5,0)
 ;;=5^884.0
 ;;^UTILITY(U,$J,358.3,4783,2)
 ;;=Laceration, Arm NOS^275064
 ;;^UTILITY(U,$J,358.3,4784,0)
 ;;=883.0^^42^330^15
 ;;^UTILITY(U,$J,358.3,4784,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4784,1,4,0)
 ;;=4^Laceration, Finger
 ;;^UTILITY(U,$J,358.3,4784,1,5,0)
 ;;=5^883.0
 ;;^UTILITY(U,$J,358.3,4784,2)
 ;;=Laceration, Finger^275060
 ;;^UTILITY(U,$J,358.3,4785,0)
 ;;=881.01^^42^330^18.5
 ;;^UTILITY(U,$J,358.3,4785,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4785,1,4,0)
 ;;=4^Laceration, Elbow
 ;;^UTILITY(U,$J,358.3,4785,1,5,0)
 ;;=5^881.01
 ;;^UTILITY(U,$J,358.3,4785,2)
 ;;=Laceration, Elbow^275045
 ;;^UTILITY(U,$J,358.3,4786,0)
 ;;=882.0^^42^330^17
 ;;^UTILITY(U,$J,358.3,4786,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4786,1,4,0)
 ;;=4^Laceration, Hand
 ;;^UTILITY(U,$J,358.3,4786,1,5,0)
 ;;=5^882.0
 ;;^UTILITY(U,$J,358.3,4786,2)
 ;;=Laceration, Hand^275056
 ;;^UTILITY(U,$J,358.3,4787,0)
 ;;=881.02^^42^330^18
 ;;^UTILITY(U,$J,358.3,4787,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4787,1,4,0)
 ;;=4^Laceration, Wrist
 ;;^UTILITY(U,$J,358.3,4787,1,5,0)
 ;;=5^881.02
 ;;^UTILITY(U,$J,358.3,4787,2)
 ;;=Laceration, Wrist^275046
 ;;^UTILITY(U,$J,358.3,4788,0)
 ;;=880.00^^42^330^19
 ;;^UTILITY(U,$J,358.3,4788,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4788,1,4,0)
 ;;=4^Laceration, Shoulder
 ;;^UTILITY(U,$J,358.3,4788,1,5,0)
 ;;=5^880.00
 ;;^UTILITY(U,$J,358.3,4788,2)
 ;;=Laceration, Shoulder^275025
 ;;^UTILITY(U,$J,358.3,4789,0)
 ;;=890.0^^42^330^25
 ;;^UTILITY(U,$J,358.3,4789,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4789,1,4,0)
 ;;=4^Laceration, Hip/Thigh
 ;;^UTILITY(U,$J,358.3,4789,1,5,0)
 ;;=5^890.0
 ;;^UTILITY(U,$J,358.3,4789,2)
 ;;=Laceration, Hip/Thigh^275083
 ;;^UTILITY(U,$J,358.3,4790,0)
 ;;=891.0^^42^330^24
 ;;^UTILITY(U,$J,358.3,4790,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4790,1,4,0)
 ;;=4^Laceration, Knee/Leg/Ankle
 ;;^UTILITY(U,$J,358.3,4790,1,5,0)
 ;;=5^891.0
 ;;^UTILITY(U,$J,358.3,4790,2)
 ;;=Laceration, Knee/Leg/Ankle^275087
 ;;^UTILITY(U,$J,358.3,4791,0)
 ;;=893.0^^42^330^22
 ;;^UTILITY(U,$J,358.3,4791,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4791,1,4,0)
 ;;=4^Laceration, Toe
 ;;^UTILITY(U,$J,358.3,4791,1,5,0)
 ;;=5^893.0
 ;;^UTILITY(U,$J,358.3,4791,2)
 ;;=Laceration, Toe^275095
 ;;^UTILITY(U,$J,358.3,4792,0)
 ;;=892.0^^42^330^23
 ;;^UTILITY(U,$J,358.3,4792,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4792,1,4,0)
 ;;=4^Laceration, Foot
 ;;^UTILITY(U,$J,358.3,4792,1,5,0)
 ;;=5^892.0
 ;;^UTILITY(U,$J,358.3,4792,2)
 ;;=Laceration, Fott^275091
 ;;^UTILITY(U,$J,358.3,4793,0)
 ;;=530.0^^43^331^1
 ;;^UTILITY(U,$J,358.3,4793,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4793,1,2,0)
 ;;=2^530.0
 ;;^UTILITY(U,$J,358.3,4793,1,5,0)
 ;;=5^Achalasia 
 ;;^UTILITY(U,$J,358.3,4793,2)
 ;;=^42424
 ;;^UTILITY(U,$J,358.3,4794,0)
 ;;=150.9^^43^331^2
 ;;^UTILITY(U,$J,358.3,4794,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4794,1,2,0)
 ;;=2^150.9
 ;;^UTILITY(U,$J,358.3,4794,1,5,0)
 ;;=5^Cancer, Esophageal, Unspec
 ;;^UTILITY(U,$J,358.3,4794,2)
 ;;=^267055
 ;;^UTILITY(U,$J,358.3,4795,0)
 ;;=786.50^^43^331^3
 ;;^UTILITY(U,$J,358.3,4795,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4795,1,2,0)
 ;;=2^786.50
 ;;^UTILITY(U,$J,358.3,4795,1,5,0)
 ;;=5^Chest Pain, Central
 ;;^UTILITY(U,$J,358.3,4795,2)
 ;;=^22485
 ;;^UTILITY(U,$J,358.3,4796,0)
 ;;=750.3^^43^331^5
 ;;^UTILITY(U,$J,358.3,4796,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4796,1,2,0)
 ;;=2^750.3
 ;;^UTILITY(U,$J,358.3,4796,1,5,0)
 ;;=5^Esoph Ring/Congenital
 ;;^UTILITY(U,$J,358.3,4796,2)
 ;;=^27483
 ;;^UTILITY(U,$J,358.3,4797,0)
 ;;=530.10^^43^331^10
 ;;^UTILITY(U,$J,358.3,4797,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4797,1,2,0)
 ;;=2^530.10
 ;;^UTILITY(U,$J,358.3,4797,1,5,0)
 ;;=5^Esophagitis, Unsp.
 ;;^UTILITY(U,$J,358.3,4797,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,4798,0)
 ;;=112.84^^43^331^8
 ;;^UTILITY(U,$J,358.3,4798,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4798,1,2,0)
 ;;=2^112.84
 ;;^UTILITY(U,$J,358.3,4798,1,5,0)
 ;;=5^Esophagitis Candida
 ;;^UTILITY(U,$J,358.3,4798,2)
 ;;=^259729
 ;;^UTILITY(U,$J,358.3,4799,0)
 ;;=530.11^^43^331^9
 ;;^UTILITY(U,$J,358.3,4799,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4799,1,2,0)
 ;;=2^530.11
 ;;^UTILITY(U,$J,358.3,4799,1,5,0)
 ;;=5^Esophagitis Due To Reflux
 ;;^UTILITY(U,$J,358.3,4799,2)
 ;;=Esophagitis due to Reflux^295747
 ;;^UTILITY(U,$J,358.3,4800,0)
 ;;=530.81^^43^331^6
 ;;^UTILITY(U,$J,358.3,4800,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4800,1,2,0)
 ;;=2^530.81
 ;;^UTILITY(U,$J,358.3,4800,1,5,0)
 ;;=5^Esophageal Reflux
 ;;^UTILITY(U,$J,358.3,4800,2)
 ;;=^295749
 ;;^UTILITY(U,$J,358.3,4801,0)
 ;;=787.1^^43^331^11
 ;;^UTILITY(U,$J,358.3,4801,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4801,1,2,0)
 ;;=2^787.1
 ;;^UTILITY(U,$J,358.3,4801,1,5,0)
 ;;=5^Heartburn
 ;;^UTILITY(U,$J,358.3,4801,2)
 ;;=^54996
 ;;^UTILITY(U,$J,358.3,4802,0)
 ;;=553.3^^43^331^12
 ;;^UTILITY(U,$J,358.3,4802,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4802,1,2,0)
 ;;=2^553.3
 ;;^UTILITY(U,$J,358.3,4802,1,5,0)
 ;;=5^Hiatal Hernia
 ;;^UTILITY(U,$J,358.3,4802,2)
 ;;=^33903
 ;;^UTILITY(U,$J,358.3,4803,0)
 ;;=530.7^^43^331^13
 ;;^UTILITY(U,$J,358.3,4803,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4803,1,2,0)
 ;;=2^530.7
 ;;^UTILITY(U,$J,358.3,4803,1,5,0)
 ;;=5^Mallory-Weiss Syndrome
 ;;^UTILITY(U,$J,358.3,4803,2)
 ;;=^49479
 ;;^UTILITY(U,$J,358.3,4804,0)
 ;;=530.3^^43^331^7
 ;;^UTILITY(U,$J,358.3,4804,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4804,1,2,0)
 ;;=2^530.3
 ;;^UTILITY(U,$J,358.3,4804,1,5,0)
 ;;=5^Esophageal Stricture
 ;;^UTILITY(U,$J,358.3,4804,2)
 ;;=Esophageal Stricture^114760
 ;;^UTILITY(U,$J,358.3,4805,0)
 ;;=456.0^^43^331^16
 ;;^UTILITY(U,$J,358.3,4805,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4805,1,2,0)
 ;;=2^456.0
 ;;^UTILITY(U,$J,358.3,4805,1,5,0)
 ;;=5^Varices Wtih Bleed
 ;;^UTILITY(U,$J,358.3,4805,2)
 ;;=Varices wtih bleed^269835
 ;;^UTILITY(U,$J,358.3,4806,0)
 ;;=456.1^^43^331^15
 ;;^UTILITY(U,$J,358.3,4806,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4806,1,2,0)
 ;;=2^456.1
 ;;^UTILITY(U,$J,358.3,4806,1,5,0)
 ;;=5^Varices W/O Bleed
 ;;^UTILITY(U,$J,358.3,4806,2)
 ;;=^269836
 ;;^UTILITY(U,$J,358.3,4807,0)
 ;;=530.6^^43^331^17
 ;;^UTILITY(U,$J,358.3,4807,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4807,1,2,0)
 ;;=2^530.6
 ;;^UTILITY(U,$J,358.3,4807,1,5,0)
 ;;=5^Zenker'S Diverticulum
 ;;^UTILITY(U,$J,358.3,4807,2)
 ;;=^270063
 ;;^UTILITY(U,$J,358.3,4808,0)
 ;;=530.20^^43^331^14
 ;;^UTILITY(U,$J,358.3,4808,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4808,1,2,0)
 ;;=2^530.20
 ;;^UTILITY(U,$J,358.3,4808,1,5,0)
 ;;=5^Ulcer Of Esophagus
 ;;^UTILITY(U,$J,358.3,4808,2)
 ;;=^329929
 ;;^UTILITY(U,$J,358.3,4809,0)
 ;;=787.20^^43^331^4
 ;;^UTILITY(U,$J,358.3,4809,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4809,1,2,0)
 ;;=2^787.20
 ;;^UTILITY(U,$J,358.3,4809,1,5,0)
 ;;=5^Dysphagia Nos
 ;;^UTILITY(U,$J,358.3,4809,2)
 ;;=^335307
 ;;^UTILITY(U,$J,358.3,4810,0)
 ;;=151.9^^43^332^3
 ;;^UTILITY(U,$J,358.3,4810,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4810,1,2,0)
 ;;=2^151.9
 ;;^UTILITY(U,$J,358.3,4810,1,5,0)
 ;;=5^Cancer Gastric, Unspec
 ;;^UTILITY(U,$J,358.3,4810,2)
 ;;=^73532
 ;;^UTILITY(U,$J,358.3,4811,0)
 ;;=537.3^^43^332^12
 ;;^UTILITY(U,$J,358.3,4811,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4811,1,2,0)
 ;;=2^537.3
 ;;^UTILITY(U,$J,358.3,4811,1,5,0)
 ;;=5^Other Obstruc Of Duodenum
 ;;^UTILITY(U,$J,358.3,4811,2)
 ;;=^87744
 ;;^UTILITY(U,$J,358.3,4812,0)
 ;;=536.3^^43^332^9
 ;;^UTILITY(U,$J,358.3,4812,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4812,1,2,0)
 ;;=2^536.3
 ;;^UTILITY(U,$J,358.3,4812,1,5,0)
 ;;=5^Gastroparesis
 ;;^UTILITY(U,$J,358.3,4812,2)
 ;;=^264447
 ;;^UTILITY(U,$J,358.3,4813,0)
 ;;=535.50^^43^332^8
 ;;^UTILITY(U,$J,358.3,4813,1,0)
 ;;=^358.31IA^5^2
