IBDEI03F ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8185,2)
 ;;=^5158074
 ;;^UTILITY(U,$J,358.3,8186,0)
 ;;=I80.259^^45^419^33
 ;;^UTILITY(U,$J,358.3,8186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8186,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis,Unspec Calf Muscle Vein
 ;;^UTILITY(U,$J,358.3,8186,1,4,0)
 ;;=4^I80.259
 ;;^UTILITY(U,$J,358.3,8186,2)
 ;;=^5158058
 ;;^UTILITY(U,$J,358.3,8187,0)
 ;;=I82.409^^45^419^26
 ;;^UTILITY(U,$J,358.3,8187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8187,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Deep Vein,LE Unspec Acute
 ;;^UTILITY(U,$J,358.3,8187,1,4,0)
 ;;=4^I82.409
 ;;^UTILITY(U,$J,358.3,8187,2)
 ;;=^5133625
 ;;^UTILITY(U,$J,358.3,8188,0)
 ;;=I82.509^^45^419^27
 ;;^UTILITY(U,$J,358.3,8188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8188,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Deep Vein,LE Unspec Chronic
 ;;^UTILITY(U,$J,358.3,8188,1,4,0)
 ;;=4^I82.509
 ;;^UTILITY(U,$J,358.3,8188,2)
 ;;=^5133628
 ;;^UTILITY(U,$J,358.3,8189,0)
 ;;=E78.1^^45^420^24
 ;;^UTILITY(U,$J,358.3,8189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8189,1,3,0)
 ;;=3^Pure Hyperglyceridemia
 ;;^UTILITY(U,$J,358.3,8189,1,4,0)
 ;;=4^E78.1
 ;;^UTILITY(U,$J,358.3,8189,2)
 ;;=^101303
 ;;^UTILITY(U,$J,358.3,8190,0)
 ;;=E78.2^^45^420^22
 ;;^UTILITY(U,$J,358.3,8190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8190,1,3,0)
 ;;=3^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,8190,1,4,0)
 ;;=4^E78.2
 ;;^UTILITY(U,$J,358.3,8190,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,8191,0)
 ;;=I10.^^45^420^9
 ;;^UTILITY(U,$J,358.3,8191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8191,1,3,0)
 ;;=3^Essential Primary Hypertension
 ;;^UTILITY(U,$J,358.3,8191,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,8191,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,8192,0)
 ;;=I11.9^^45^420^20
 ;;^UTILITY(U,$J,358.3,8192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8192,1,3,0)
 ;;=3^Hypertensive Heart Disease w/o Heart Failure
 ;;^UTILITY(U,$J,358.3,8192,1,4,0)
 ;;=4^I11.9
 ;;^UTILITY(U,$J,358.3,8192,2)
 ;;=^5007064
 ;;^UTILITY(U,$J,358.3,8193,0)
 ;;=I11.0^^45^420^19
 ;;^UTILITY(U,$J,358.3,8193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8193,1,3,0)
 ;;=3^Hypertensive Heart Disease w/ Heart Failure
 ;;^UTILITY(U,$J,358.3,8193,1,4,0)
 ;;=4^I11.0
 ;;^UTILITY(U,$J,358.3,8193,2)
 ;;=^5007063
 ;;^UTILITY(U,$J,358.3,8194,0)
 ;;=I12.0^^45^420^15
 ;;^UTILITY(U,$J,358.3,8194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8194,1,3,0)
 ;;=3^Hypertensive CKD w/ ESRD
 ;;^UTILITY(U,$J,358.3,8194,1,4,0)
 ;;=4^I12.0
 ;;^UTILITY(U,$J,358.3,8194,2)
 ;;=^5007065
 ;;^UTILITY(U,$J,358.3,8195,0)
 ;;=I13.10^^45^420^13
 ;;^UTILITY(U,$J,358.3,8195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8195,1,3,0)
 ;;=3^HTN Hrt & Chr Kdny Dis w/o Hrt Fail w/ Stg 1-4 Chr Kdny
 ;;^UTILITY(U,$J,358.3,8195,1,4,0)
 ;;=4^I13.10
 ;;^UTILITY(U,$J,358.3,8195,2)
 ;;=^5007068
 ;;^UTILITY(U,$J,358.3,8196,0)
 ;;=I13.0^^45^420^11
 ;;^UTILITY(U,$J,358.3,8196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8196,1,3,0)
 ;;=3^HTN Hrt & Chr Kdny Dis w/ Hrt Fail w/ Stg 1-4 Chr Kdny
 ;;^UTILITY(U,$J,358.3,8196,1,4,0)
 ;;=4^I13.0
 ;;^UTILITY(U,$J,358.3,8196,2)
 ;;=^5007067
 ;;^UTILITY(U,$J,358.3,8197,0)
 ;;=I13.11^^45^420^14
 ;;^UTILITY(U,$J,358.3,8197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8197,1,3,0)
 ;;=3^HTN Hrt & Chr Kdny Dis w/o Hrt Fail w/ Stg 5 Chr Kdny
 ;;^UTILITY(U,$J,358.3,8197,1,4,0)
 ;;=4^I13.11
 ;;^UTILITY(U,$J,358.3,8197,2)
 ;;=^5007069
 ;;^UTILITY(U,$J,358.3,8198,0)
 ;;=I13.2^^45^420^12
 ;;^UTILITY(U,$J,358.3,8198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8198,1,3,0)
 ;;=3^HTN Hrt & Chr Kdny Dis w/ Hrt Fail w/ Stg 5 Chr Kdny
 ;;^UTILITY(U,$J,358.3,8198,1,4,0)
 ;;=4^I13.2
 ;;^UTILITY(U,$J,358.3,8198,2)
 ;;=^5007070
 ;;^UTILITY(U,$J,358.3,8199,0)
 ;;=I48.91^^45^420^6
 ;;^UTILITY(U,$J,358.3,8199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8199,1,3,0)
 ;;=3^Atrial Fibrillation,Unspec
 ;;^UTILITY(U,$J,358.3,8199,1,4,0)
 ;;=4^I48.91
 ;;^UTILITY(U,$J,358.3,8199,2)
 ;;=^5007229
 ;;^UTILITY(U,$J,358.3,8200,0)
 ;;=I48.92^^45^420^7
 ;;^UTILITY(U,$J,358.3,8200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8200,1,3,0)
 ;;=3^Atrial Flutter,Unspec
 ;;^UTILITY(U,$J,358.3,8200,1,4,0)
 ;;=4^I48.92
 ;;^UTILITY(U,$J,358.3,8200,2)
 ;;=^5007230
 ;;^UTILITY(U,$J,358.3,8201,0)
 ;;=I16.1^^45^420^18
 ;;^UTILITY(U,$J,358.3,8201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8201,1,3,0)
 ;;=3^Hypertensive Emergency
 ;;^UTILITY(U,$J,358.3,8201,1,4,0)
 ;;=4^I16.1
 ;;^UTILITY(U,$J,358.3,8201,2)
 ;;=^8204721
 ;;^UTILITY(U,$J,358.3,8202,0)
 ;;=I16.0^^45^420^21
 ;;^UTILITY(U,$J,358.3,8202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8202,1,3,0)
 ;;=3^Hypertensive Urgency
 ;;^UTILITY(U,$J,358.3,8202,1,4,0)
 ;;=4^I16.0
 ;;^UTILITY(U,$J,358.3,8202,2)
 ;;=^8133013
 ;;^UTILITY(U,$J,358.3,8203,0)
 ;;=I16.9^^45^420^17
 ;;^UTILITY(U,$J,358.3,8203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8203,1,3,0)
 ;;=3^Hypertensive Crisis,Unspec
 ;;^UTILITY(U,$J,358.3,8203,1,4,0)
 ;;=4^I16.9
 ;;^UTILITY(U,$J,358.3,8203,2)
 ;;=^5138600
 ;;^UTILITY(U,$J,358.3,8204,0)
 ;;=E78.01^^45^420^10
 ;;^UTILITY(U,$J,358.3,8204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8204,1,3,0)
 ;;=3^Familial Hypercholesterolemia
 ;;^UTILITY(U,$J,358.3,8204,1,4,0)
 ;;=4^E78.01
 ;;^UTILITY(U,$J,358.3,8204,2)
 ;;=^7570555
 ;;^UTILITY(U,$J,358.3,8205,0)
 ;;=E78.00^^45^420^23
 ;;^UTILITY(U,$J,358.3,8205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8205,1,3,0)
 ;;=3^Pure Hypercholesterolemia,Unspec
 ;;^UTILITY(U,$J,358.3,8205,1,4,0)
 ;;=4^E78.00
 ;;^UTILITY(U,$J,358.3,8205,2)
 ;;=^5138435
 ;;^UTILITY(U,$J,358.3,8206,0)
 ;;=I47.2^^45^420^25
 ;;^UTILITY(U,$J,358.3,8206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8206,1,3,0)
 ;;=3^Ventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,8206,1,4,0)
 ;;=4^I47.2
 ;;^UTILITY(U,$J,358.3,8206,2)
 ;;=^125976
 ;;^UTILITY(U,$J,358.3,8207,0)
 ;;=I42.6^^45^420^1
 ;;^UTILITY(U,$J,358.3,8207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8207,1,3,0)
 ;;=3^Alcoholic Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,8207,1,4,0)
 ;;=4^I42.6
 ;;^UTILITY(U,$J,358.3,8207,2)
 ;;=^5007197
 ;;^UTILITY(U,$J,358.3,8208,0)
 ;;=I51.7^^45^420^8
 ;;^UTILITY(U,$J,358.3,8208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8208,1,3,0)
 ;;=3^Cardiomegaly
 ;;^UTILITY(U,$J,358.3,8208,1,4,0)
 ;;=4^I51.7
 ;;^UTILITY(U,$J,358.3,8208,2)
 ;;=^5007257
 ;;^UTILITY(U,$J,358.3,8209,0)
 ;;=I48.20^^45^420^2
 ;;^UTILITY(U,$J,358.3,8209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8209,1,3,0)
 ;;=3^Atrial Fibrillation,Chronic,Unspec
 ;;^UTILITY(U,$J,358.3,8209,1,4,0)
 ;;=4^I48.20
 ;;^UTILITY(U,$J,358.3,8209,2)
 ;;=^5158048
 ;;^UTILITY(U,$J,358.3,8210,0)
 ;;=I48.11^^45^420^3
 ;;^UTILITY(U,$J,358.3,8210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8210,1,3,0)
 ;;=3^Atrial Fibrillation,Longstanding Persistent
 ;;^UTILITY(U,$J,358.3,8210,1,4,0)
 ;;=4^I48.11
 ;;^UTILITY(U,$J,358.3,8210,2)
 ;;=^5158046
 ;;^UTILITY(U,$J,358.3,8211,0)
 ;;=I48.19^^45^420^4
 ;;^UTILITY(U,$J,358.3,8211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8211,1,3,0)
 ;;=3^Atrial Fibrillation,Other Persistent
 ;;^UTILITY(U,$J,358.3,8211,1,4,0)
 ;;=4^I48.19
 ;;^UTILITY(U,$J,358.3,8211,2)
 ;;=^5158047
 ;;^UTILITY(U,$J,358.3,8212,0)
 ;;=I48.21^^45^420^5
 ;;^UTILITY(U,$J,358.3,8212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8212,1,3,0)
 ;;=3^Atrial Fibrillation,Permanent
 ;;^UTILITY(U,$J,358.3,8212,1,4,0)
 ;;=4^I48.21
 ;;^UTILITY(U,$J,358.3,8212,2)
 ;;=^304710
 ;;^UTILITY(U,$J,358.3,8213,0)
 ;;=I12.9^^45^420^16
 ;;^UTILITY(U,$J,358.3,8213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8213,1,3,0)
 ;;=3^Hypertensive CKD w/ Stg 1-4 CKD
 ;;^UTILITY(U,$J,358.3,8213,1,4,0)
 ;;=4^I12.9
 ;;^UTILITY(U,$J,358.3,8213,2)
 ;;=^5007066
 ;;^UTILITY(U,$J,358.3,8214,0)
 ;;=B07.9^^45^421^328
 ;;^UTILITY(U,$J,358.3,8214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8214,1,3,0)
 ;;=3^Viral Wart,Unspec
 ;;^UTILITY(U,$J,358.3,8214,1,4,0)
 ;;=4^B07.9
 ;;^UTILITY(U,$J,358.3,8214,2)
 ;;=^5000519
 ;;^UTILITY(U,$J,358.3,8215,0)
 ;;=A63.0^^45^421^35
 ;;^UTILITY(U,$J,358.3,8215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8215,1,3,0)
 ;;=3^Anogenital (Venereal) Warts
 ;;^UTILITY(U,$J,358.3,8215,1,4,0)
 ;;=4^A63.0
 ;;^UTILITY(U,$J,358.3,8215,2)
 ;;=^5000360
 ;;^UTILITY(U,$J,358.3,8216,0)
 ;;=B35.0^^45^421^319
 ;;^UTILITY(U,$J,358.3,8216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8216,1,3,0)
 ;;=3^Tinea Barbae and Tinea Capitis
 ;;^UTILITY(U,$J,358.3,8216,1,4,0)
 ;;=4^B35.0
 ;;^UTILITY(U,$J,358.3,8216,2)
 ;;=^5000604
 ;;^UTILITY(U,$J,358.3,8217,0)
 ;;=B35.1^^45^421^324
 ;;^UTILITY(U,$J,358.3,8217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8217,1,3,0)
 ;;=3^Tinea Unguium
 ;;^UTILITY(U,$J,358.3,8217,1,4,0)
 ;;=4^B35.1
 ;;^UTILITY(U,$J,358.3,8217,2)
 ;;=^119748
 ;;^UTILITY(U,$J,358.3,8218,0)
 ;;=B35.6^^45^421^321
 ;;^UTILITY(U,$J,358.3,8218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8218,1,3,0)
 ;;=3^Tinea Cruris
 ;;^UTILITY(U,$J,358.3,8218,1,4,0)
 ;;=4^B35.6
 ;;^UTILITY(U,$J,358.3,8218,2)
 ;;=^119711
 ;;^UTILITY(U,$J,358.3,8219,0)
 ;;=B35.3^^45^421^323
 ;;^UTILITY(U,$J,358.3,8219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8219,1,3,0)
 ;;=3^Tinea Pedis
 ;;^UTILITY(U,$J,358.3,8219,1,4,0)
 ;;=4^B35.3
 ;;^UTILITY(U,$J,358.3,8219,2)
 ;;=^119732
 ;;^UTILITY(U,$J,358.3,8220,0)
 ;;=B35.5^^45^421^322
 ;;^UTILITY(U,$J,358.3,8220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8220,1,3,0)
 ;;=3^Tinea Imbricata
 ;;^UTILITY(U,$J,358.3,8220,1,4,0)
 ;;=4^B35.5
 ;;^UTILITY(U,$J,358.3,8220,2)
 ;;=^119725
 ;;^UTILITY(U,$J,358.3,8221,0)
 ;;=B35.4^^45^421^320
 ;;^UTILITY(U,$J,358.3,8221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8221,1,3,0)
 ;;=3^Tinea Corporis
 ;;^UTILITY(U,$J,358.3,8221,1,4,0)
 ;;=4^B35.4
 ;;^UTILITY(U,$J,358.3,8221,2)
 ;;=^119704
 ;;^UTILITY(U,$J,358.3,8222,0)
 ;;=B35.8^^45^421^140
 ;;^UTILITY(U,$J,358.3,8222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8222,1,3,0)
 ;;=3^Dermatophytoses,Other
 ;;^UTILITY(U,$J,358.3,8222,1,4,0)
 ;;=4^B35.8
 ;;^UTILITY(U,$J,358.3,8222,2)
 ;;=^5000606
 ;;^UTILITY(U,$J,358.3,8223,0)
 ;;=B36.9^^45^421^312
 ;;^UTILITY(U,$J,358.3,8223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8223,1,3,0)
 ;;=3^Superficial Mycosis,Unspec
 ;;^UTILITY(U,$J,358.3,8223,1,4,0)
 ;;=4^B36.9
 ;;^UTILITY(U,$J,358.3,8223,2)
 ;;=^5000611
 ;;^UTILITY(U,$J,358.3,8224,0)
 ;;=D69.0^^45^421^33
 ;;^UTILITY(U,$J,358.3,8224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8224,1,3,0)
 ;;=3^Allergic Purpura
 ;;^UTILITY(U,$J,358.3,8224,1,4,0)
 ;;=4^D69.0
 ;;^UTILITY(U,$J,358.3,8224,2)
 ;;=^5002365
 ;;^UTILITY(U,$J,358.3,8225,0)
 ;;=B00.9^^45^421^161
 ;;^UTILITY(U,$J,358.3,8225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8225,1,3,0)
 ;;=3^Herpesviral Infection,Unspec
 ;;^UTILITY(U,$J,358.3,8225,1,4,0)
 ;;=4^B00.9
 ;;^UTILITY(U,$J,358.3,8225,2)
 ;;=^5000480
 ;;^UTILITY(U,$J,358.3,8226,0)
 ;;=B02.9^^45^421^331
 ;;^UTILITY(U,$J,358.3,8226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8226,1,3,0)
 ;;=3^Zoster w/o Complications
 ;;^UTILITY(U,$J,358.3,8226,1,4,0)
 ;;=4^B02.9
 ;;^UTILITY(U,$J,358.3,8226,2)
 ;;=^5000501
 ;;^UTILITY(U,$J,358.3,8227,0)
 ;;=D17.9^^45^421^90
 ;;^UTILITY(U,$J,358.3,8227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8227,1,3,0)
 ;;=3^Benign Lipomatous Neop,Unspec
 ;;^UTILITY(U,$J,358.3,8227,1,4,0)
 ;;=4^D17.9
 ;;^UTILITY(U,$J,358.3,8227,2)
 ;;=^5002020
 ;;^UTILITY(U,$J,358.3,8228,0)
 ;;=E08.621^^45^421^137
 ;;^UTILITY(U,$J,358.3,8228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8228,1,3,0)
 ;;=3^DM d/t Underlying Condition w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,8228,1,4,0)
 ;;=4^E08.621
 ;;^UTILITY(U,$J,358.3,8228,2)
 ;;=^5002534
 ;;^UTILITY(U,$J,358.3,8229,0)
 ;;=E09.621^^45^421^136
 ;;^UTILITY(U,$J,358.3,8229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8229,1,3,0)
 ;;=3^DM d/t Drug/Chemical w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,8229,1,4,0)
 ;;=4^E09.621
 ;;^UTILITY(U,$J,358.3,8229,2)
 ;;=^5002576
 ;;^UTILITY(U,$J,358.3,8230,0)
 ;;=H05.011^^45^421^112
 ;;^UTILITY(U,$J,358.3,8230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8230,1,3,0)
 ;;=3^Cellulitis of Right Orbit
 ;;^UTILITY(U,$J,358.3,8230,1,4,0)
 ;;=4^H05.011
 ;;^UTILITY(U,$J,358.3,8230,2)
 ;;=^5004560
 ;;^UTILITY(U,$J,358.3,8231,0)
 ;;=H05.012^^45^421^105
 ;;^UTILITY(U,$J,358.3,8231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8231,1,3,0)
 ;;=3^Cellulitis of Left Orbit
 ;;^UTILITY(U,$J,358.3,8231,1,4,0)
 ;;=4^H05.012
 ;;^UTILITY(U,$J,358.3,8231,2)
 ;;=^5004561
 ;;^UTILITY(U,$J,358.3,8232,0)
 ;;=H05.013^^45^421^99
 ;;^UTILITY(U,$J,358.3,8232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8232,1,3,0)
 ;;=3^Cellulitis of Bilateral Orbits
 ;;^UTILITY(U,$J,358.3,8232,1,4,0)
 ;;=4^H05.013
 ;;^UTILITY(U,$J,358.3,8232,2)
 ;;=^5004562
 ;;^UTILITY(U,$J,358.3,8233,0)
 ;;=I70.331^^45^421^51
 ;;^UTILITY(U,$J,358.3,8233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8233,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,8233,1,4,0)
 ;;=4^I70.331
 ;;^UTILITY(U,$J,358.3,8233,2)
 ;;=^5007626
 ;;^UTILITY(U,$J,358.3,8234,0)
 ;;=I70.332^^45^421^52
 ;;^UTILITY(U,$J,358.3,8234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8234,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,8234,1,4,0)
 ;;=4^I70.332
 ;;^UTILITY(U,$J,358.3,8234,2)
 ;;=^5007627
 ;;^UTILITY(U,$J,358.3,8235,0)
 ;;=I70.333^^45^421^53
 ;;^UTILITY(U,$J,358.3,8235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8235,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,8235,1,4,0)
 ;;=4^I70.333
 ;;^UTILITY(U,$J,358.3,8235,2)
 ;;=^5007628
 ;;^UTILITY(U,$J,358.3,8236,0)
 ;;=I70.334^^45^421^54
 ;;^UTILITY(U,$J,358.3,8236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8236,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,8236,1,4,0)
 ;;=4^I70.334
 ;;^UTILITY(U,$J,358.3,8236,2)
 ;;=^5007629
 ;;^UTILITY(U,$J,358.3,8237,0)
 ;;=I70.335^^45^421^55
 ;;^UTILITY(U,$J,358.3,8237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8237,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,8237,1,4,0)
 ;;=4^I70.335
 ;;^UTILITY(U,$J,358.3,8237,2)
 ;;=^5007630
 ;;^UTILITY(U,$J,358.3,8238,0)
 ;;=I70.341^^45^421^50
 ;;^UTILITY(U,$J,358.3,8238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8238,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,8238,1,4,0)
 ;;=4^I70.341
 ;;^UTILITY(U,$J,358.3,8238,2)
 ;;=^5007633
 ;;^UTILITY(U,$J,358.3,8239,0)
 ;;=I70.342^^45^421^47
 ;;^UTILITY(U,$J,358.3,8239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8239,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,8239,1,4,0)
 ;;=4^I70.342
 ;;^UTILITY(U,$J,358.3,8239,2)
 ;;=^5007634
 ;;^UTILITY(U,$J,358.3,8240,0)
 ;;=I70.343^^45^421^46
 ;;^UTILITY(U,$J,358.3,8240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8240,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,8240,1,4,0)
 ;;=4^I70.343
 ;;^UTILITY(U,$J,358.3,8240,2)
 ;;=^5007635
 ;;^UTILITY(U,$J,358.3,8241,0)
 ;;=I70.344^^45^421^48
 ;;^UTILITY(U,$J,358.3,8241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8241,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,8241,1,4,0)
 ;;=4^I70.344
 ;;^UTILITY(U,$J,358.3,8241,2)
 ;;=^5007636
 ;;^UTILITY(U,$J,358.3,8242,0)
 ;;=I70.345^^45^421^49
 ;;^UTILITY(U,$J,358.3,8242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8242,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,8242,1,4,0)
 ;;=4^I70.345
 ;;^UTILITY(U,$J,358.3,8242,2)
 ;;=^5007637
 ;;^UTILITY(U,$J,358.3,8243,0)
 ;;=I70.431^^45^421^41
 ;;^UTILITY(U,$J,358.3,8243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8243,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,8243,1,4,0)
 ;;=4^I70.431
 ;;^UTILITY(U,$J,358.3,8243,2)
 ;;=^5007664
 ;;^UTILITY(U,$J,358.3,8244,0)
 ;;=I70.432^^45^421^42
 ;;^UTILITY(U,$J,358.3,8244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8244,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,8244,1,4,0)
 ;;=4^I70.432
 ;;^UTILITY(U,$J,358.3,8244,2)
 ;;=^5007665
 ;;^UTILITY(U,$J,358.3,8245,0)
 ;;=I70.433^^45^421^43
 ;;^UTILITY(U,$J,358.3,8245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8245,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,8245,1,4,0)
 ;;=4^I70.433
 ;;^UTILITY(U,$J,358.3,8245,2)
 ;;=^5007666
 ;;^UTILITY(U,$J,358.3,8246,0)
 ;;=I70.434^^45^421^44
 ;;^UTILITY(U,$J,358.3,8246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8246,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,8246,1,4,0)
 ;;=4^I70.434
 ;;^UTILITY(U,$J,358.3,8246,2)
 ;;=^5007667
 ;;^UTILITY(U,$J,358.3,8247,0)
 ;;=I70.435^^45^421^45
 ;;^UTILITY(U,$J,358.3,8247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8247,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,8247,1,4,0)
 ;;=4^I70.435
 ;;^UTILITY(U,$J,358.3,8247,2)
 ;;=^5007668
 ;;^UTILITY(U,$J,358.3,8248,0)
 ;;=I70.441^^45^421^36
 ;;^UTILITY(U,$J,358.3,8248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8248,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,8248,1,4,0)
 ;;=4^I70.441
 ;;^UTILITY(U,$J,358.3,8248,2)
 ;;=^5007671
 ;;^UTILITY(U,$J,358.3,8249,0)
 ;;=I70.442^^45^421^37
 ;;^UTILITY(U,$J,358.3,8249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8249,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,8249,1,4,0)
 ;;=4^I70.442
 ;;^UTILITY(U,$J,358.3,8249,2)
 ;;=^5007672
 ;;^UTILITY(U,$J,358.3,8250,0)
 ;;=I70.443^^45^421^38
 ;;^UTILITY(U,$J,358.3,8250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8250,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,8250,1,4,0)
 ;;=4^I70.443
 ;;^UTILITY(U,$J,358.3,8250,2)
 ;;=^5007673
 ;;^UTILITY(U,$J,358.3,8251,0)
 ;;=I70.444^^45^421^39
 ;;^UTILITY(U,$J,358.3,8251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8251,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,8251,1,4,0)
 ;;=4^I70.444
 ;;^UTILITY(U,$J,358.3,8251,2)
 ;;=^5007674
 ;;^UTILITY(U,$J,358.3,8252,0)
 ;;=I70.445^^45^421^40
 ;;^UTILITY(U,$J,358.3,8252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8252,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,8252,1,4,0)
 ;;=4^I70.445
 ;;^UTILITY(U,$J,358.3,8252,2)
 ;;=^5007675
 ;;^UTILITY(U,$J,358.3,8253,0)
 ;;=I70.531^^45^421^61
 ;;^UTILITY(U,$J,358.3,8253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8253,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,8253,1,4,0)
 ;;=4^I70.531
 ;;^UTILITY(U,$J,358.3,8253,2)
 ;;=^5007702
 ;;^UTILITY(U,$J,358.3,8254,0)
 ;;=I70.532^^45^421^62
 ;;^UTILITY(U,$J,358.3,8254,1,0)
 ;;=^358.31IA^4^2
