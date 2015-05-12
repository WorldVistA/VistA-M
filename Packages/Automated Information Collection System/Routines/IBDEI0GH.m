IBDEI0GH ; ; 19-NOV-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22254,1,2,0)
 ;;=2^11604
 ;;^UTILITY(U,$J,358.3,22254,1,3,0)
 ;;=3^Exc Mal Lesion Tnk/Arm/Leg,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,22255,0)
 ;;=11606^^121^1316^6^^^^1
 ;;^UTILITY(U,$J,358.3,22255,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22255,1,2,0)
 ;;=2^11606
 ;;^UTILITY(U,$J,358.3,22255,1,3,0)
 ;;=3^Exc Mal Lesion Tnk/Arm/Leg > 4.0cm
 ;;^UTILITY(U,$J,358.3,22256,0)
 ;;=10040^^121^1317^1^^^^1
 ;;^UTILITY(U,$J,358.3,22256,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22256,1,2,0)
 ;;=2^10040
 ;;^UTILITY(U,$J,358.3,22256,1,3,0)
 ;;=3^Acne Surgery
 ;;^UTILITY(U,$J,358.3,22257,0)
 ;;=10060^^121^1317^4^^^^1
 ;;^UTILITY(U,$J,358.3,22257,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22257,1,2,0)
 ;;=2^10060
 ;;^UTILITY(U,$J,358.3,22257,1,3,0)
 ;;=3^I&D of abscess; simple or single
 ;;^UTILITY(U,$J,358.3,22258,0)
 ;;=10061^^121^1317^3^^^^1
 ;;^UTILITY(U,$J,358.3,22258,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22258,1,2,0)
 ;;=2^10061
 ;;^UTILITY(U,$J,358.3,22258,1,3,0)
 ;;=3^I&D of abscess; complicated
 ;;^UTILITY(U,$J,358.3,22259,0)
 ;;=10080^^121^1317^6^^^^1
 ;;^UTILITY(U,$J,358.3,22259,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22259,1,2,0)
 ;;=2^10080
 ;;^UTILITY(U,$J,358.3,22259,1,3,0)
 ;;=3^I&D of pilonidal cyst; simple
 ;;^UTILITY(U,$J,358.3,22260,0)
 ;;=10081^^121^1317^5^^^^1
 ;;^UTILITY(U,$J,358.3,22260,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22260,1,2,0)
 ;;=2^10081
 ;;^UTILITY(U,$J,358.3,22260,1,3,0)
 ;;=3^I&D of pilonidal cyst; complicated
 ;;^UTILITY(U,$J,358.3,22261,0)
 ;;=10120^^121^1317^7^^^^1
 ;;^UTILITY(U,$J,358.3,22261,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22261,1,2,0)
 ;;=2^10120
 ;;^UTILITY(U,$J,358.3,22261,1,3,0)
 ;;=3^Incision & Removal Foreign Body,SQ
 ;;^UTILITY(U,$J,358.3,22262,0)
 ;;=10121^^121^1317^9^^^^1
 ;;^UTILITY(U,$J,358.3,22262,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22262,1,2,0)
 ;;=2^10121
 ;;^UTILITY(U,$J,358.3,22262,1,3,0)
 ;;=3^Removal of Foreign Body, SQ, Complicated
 ;;^UTILITY(U,$J,358.3,22263,0)
 ;;=10140^^121^1317^2^^^^1
 ;;^UTILITY(U,$J,358.3,22263,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22263,1,2,0)
 ;;=2^10140
 ;;^UTILITY(U,$J,358.3,22263,1,3,0)
 ;;=3^Drainage of Hematoma/Fluid
 ;;^UTILITY(U,$J,358.3,22264,0)
 ;;=10160^^121^1317^8^^^^1
 ;;^UTILITY(U,$J,358.3,22264,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22264,1,2,0)
 ;;=2^10160
 ;;^UTILITY(U,$J,358.3,22264,1,3,0)
 ;;=3^Puncture Drainage of Lesion
 ;;^UTILITY(U,$J,358.3,22265,0)
 ;;=11200^^121^1318^7^^^^1
 ;;^UTILITY(U,$J,358.3,22265,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22265,1,2,0)
 ;;=2^11200
 ;;^UTILITY(U,$J,358.3,22265,1,3,0)
 ;;=3^Removal of Skin Tags,</=15 tags
 ;;^UTILITY(U,$J,358.3,22266,0)
 ;;=11201^^121^1318^8^^^^1
 ;;^UTILITY(U,$J,358.3,22266,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22266,1,2,0)
 ;;=2^11201
 ;;^UTILITY(U,$J,358.3,22266,1,3,0)
 ;;=3^Removal of Skin Tags,Ea Add 10 tags
 ;;^UTILITY(U,$J,358.3,22267,0)
 ;;=11900^^121^1318^4^^^^1
 ;;^UTILITY(U,$J,358.3,22267,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22267,1,2,0)
 ;;=2^11900
 ;;^UTILITY(U,$J,358.3,22267,1,3,0)
 ;;=3^INJ,Intralesional;<8 lesions
 ;;^UTILITY(U,$J,358.3,22268,0)
 ;;=11901^^121^1318^5^^^^1
 ;;^UTILITY(U,$J,358.3,22268,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22268,1,2,0)
 ;;=2^11901
 ;;^UTILITY(U,$J,358.3,22268,1,3,0)
 ;;=3^INJ,intralesional;>7 lesions
 ;;^UTILITY(U,$J,358.3,22269,0)
 ;;=10030^^121^1318^6^^^^1
 ;;^UTILITY(U,$J,358.3,22269,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22269,1,2,0)
 ;;=2^10030
 ;;^UTILITY(U,$J,358.3,22269,1,3,0)
 ;;=3^Image Guided Fluid Collect by Cath Percut
 ;;^UTILITY(U,$J,358.3,22270,0)
 ;;=11770^^121^1318^3^^^^1
 ;;^UTILITY(U,$J,358.3,22270,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22270,1,2,0)
 ;;=2^11770
 ;;^UTILITY(U,$J,358.3,22270,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Simple
 ;;^UTILITY(U,$J,358.3,22271,0)
 ;;=11771^^121^1318^2^^^^1
 ;;^UTILITY(U,$J,358.3,22271,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22271,1,2,0)
 ;;=2^11771
 ;;^UTILITY(U,$J,358.3,22271,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Extensive
 ;;^UTILITY(U,$J,358.3,22272,0)
 ;;=11772^^121^1318^1^^^^1
 ;;^UTILITY(U,$J,358.3,22272,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22272,1,2,0)
 ;;=2^11772
 ;;^UTILITY(U,$J,358.3,22272,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Compl
 ;;^UTILITY(U,$J,358.3,22273,0)
 ;;=11719^^121^1319^1^^^^1
 ;;^UTILITY(U,$J,358.3,22273,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22273,1,2,0)
 ;;=2^11719
 ;;^UTILITY(U,$J,358.3,22273,1,3,0)
 ;;=3^Trim nondystrophic nails, any number
 ;;^UTILITY(U,$J,358.3,22274,0)
 ;;=11720^^121^1319^2^^^^1
 ;;^UTILITY(U,$J,358.3,22274,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22274,1,2,0)
 ;;=2^11720
 ;;^UTILITY(U,$J,358.3,22274,1,3,0)
 ;;=3^Debride of nail(s) any method;1-5
 ;;^UTILITY(U,$J,358.3,22275,0)
 ;;=11721^^121^1319^3^^^^1
 ;;^UTILITY(U,$J,358.3,22275,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22275,1,2,0)
 ;;=2^11721
 ;;^UTILITY(U,$J,358.3,22275,1,3,0)
 ;;=3^Debride of nail(s) any method;6+
 ;;^UTILITY(U,$J,358.3,22276,0)
 ;;=11730^^121^1319^4^^^^1
 ;;^UTILITY(U,$J,358.3,22276,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22276,1,2,0)
 ;;=2^11730
 ;;^UTILITY(U,$J,358.3,22276,1,3,0)
 ;;=3^Avulsion of nail plate,simple;single
 ;;^UTILITY(U,$J,358.3,22277,0)
 ;;=11732^^121^1319^5^^^^1
 ;;^UTILITY(U,$J,358.3,22277,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22277,1,2,0)
 ;;=2^11732
 ;;^UTILITY(U,$J,358.3,22277,1,3,0)
 ;;=3^Avulsion of nail plate,Ea Add nail plate
 ;;^UTILITY(U,$J,358.3,22278,0)
 ;;=11740^^121^1319^6^^^^1
 ;;^UTILITY(U,$J,358.3,22278,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22278,1,2,0)
 ;;=2^11740
 ;;^UTILITY(U,$J,358.3,22278,1,3,0)
 ;;=3^Evacuation of subungual hematoma
 ;;^UTILITY(U,$J,358.3,22279,0)
 ;;=11750^^121^1319^7^^^^1
 ;;^UTILITY(U,$J,358.3,22279,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22279,1,2,0)
 ;;=2^11750
 ;;^UTILITY(U,$J,358.3,22279,1,3,0)
 ;;=3^Exc of nail&nail matrix,perm removal
 ;;^UTILITY(U,$J,358.3,22280,0)
 ;;=11752^^121^1319^8^^^^1
 ;;^UTILITY(U,$J,358.3,22280,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22280,1,2,0)
 ;;=2^11752
 ;;^UTILITY(U,$J,358.3,22280,1,3,0)
 ;;=3^Exc of nail&nail matrix,w/amp of tuft
 ;;^UTILITY(U,$J,358.3,22281,0)
 ;;=11760^^121^1319^9^^^^1
 ;;^UTILITY(U,$J,358.3,22281,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22281,1,2,0)
 ;;=2^11760
 ;;^UTILITY(U,$J,358.3,22281,1,3,0)
 ;;=3^Repair of nail bed
 ;;^UTILITY(U,$J,358.3,22282,0)
 ;;=11765^^121^1319^10^^^^1
 ;;^UTILITY(U,$J,358.3,22282,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22282,1,2,0)
 ;;=2^11765
 ;;^UTILITY(U,$J,358.3,22282,1,3,0)
 ;;=3^Wedge excision of skin of nail fold
 ;;^UTILITY(U,$J,358.3,22283,0)
 ;;=11300^^121^1320^1^^^^1
 ;;^UTILITY(U,$J,358.3,22283,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22283,1,2,0)
 ;;=2^11300
 ;;^UTILITY(U,$J,358.3,22283,1,3,0)
 ;;=3^Shaving Epidermm Arm/Leg: 0.5cm or less
 ;;^UTILITY(U,$J,358.3,22284,0)
 ;;=11301^^121^1320^2^^^^1
 ;;^UTILITY(U,$J,358.3,22284,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22284,1,2,0)
 ;;=2^11301
 ;;^UTILITY(U,$J,358.3,22284,1,3,0)
 ;;=3^Shaving Epidermm Arm/Leg: 0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,22285,0)
 ;;=11302^^121^1320^3^^^^1
 ;;^UTILITY(U,$J,358.3,22285,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22285,1,2,0)
 ;;=2^11302
 ;;^UTILITY(U,$J,358.3,22285,1,3,0)
 ;;=3^Shaving Epidermm Arm/Leg: 1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,22286,0)
 ;;=11303^^121^1320^4^^^^1
 ;;^UTILITY(U,$J,358.3,22286,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22286,1,2,0)
 ;;=2^11303
 ;;^UTILITY(U,$J,358.3,22286,1,3,0)
 ;;=3^Shaving Epidermm Arm/Leg > 2.0cm
 ;;^UTILITY(U,$J,358.3,22287,0)
 ;;=12001^^121^1321^1^^^^1
 ;;^UTILITY(U,$J,358.3,22287,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22287,1,2,0)
 ;;=2^12001
 ;;^UTILITY(U,$J,358.3,22287,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,22288,0)
 ;;=12002^^121^1321^2^^^^1
 ;;^UTILITY(U,$J,358.3,22288,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22288,1,2,0)
 ;;=2^12002
 ;;^UTILITY(U,$J,358.3,22288,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 2.6 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,22289,0)
 ;;=12004^^121^1321^3^^^^1
 ;;^UTILITY(U,$J,358.3,22289,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22289,1,2,0)
 ;;=2^12004
 ;;^UTILITY(U,$J,358.3,22289,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 7.6 cm to 12.5 cm
 ;;^UTILITY(U,$J,358.3,22290,0)
 ;;=12005^^121^1321^4^^^^1
 ;;^UTILITY(U,$J,358.3,22290,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22290,1,2,0)
 ;;=2^12005
 ;;^UTILITY(U,$J,358.3,22290,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 12.6 cm to 20 cm
 ;;^UTILITY(U,$J,358.3,22291,0)
 ;;=12006^^121^1321^5^^^^1
 ;;^UTILITY(U,$J,358.3,22291,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22291,1,2,0)
 ;;=2^12006
 ;;^UTILITY(U,$J,358.3,22291,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 20.1 cm to 30 cm
 ;;^UTILITY(U,$J,358.3,22292,0)
 ;;=12007^^121^1321^6^^^^1
 ;;^UTILITY(U,$J,358.3,22292,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22292,1,2,0)
 ;;=2^12007
 ;;^UTILITY(U,$J,358.3,22292,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; over 30 cm
 ;;^UTILITY(U,$J,358.3,22293,0)
 ;;=12031^^121^1322^1^^^^1
 ;;^UTILITY(U,$J,358.3,22293,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22293,1,2,0)
 ;;=2^12031
 ;;^UTILITY(U,$J,358.3,22293,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,22294,0)
 ;;=12032^^121^1322^2^^^^1
 ;;^UTILITY(U,$J,358.3,22294,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22294,1,2,0)
 ;;=2^12032
 ;;^UTILITY(U,$J,358.3,22294,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 2.6 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,22295,0)
 ;;=12034^^121^1322^3^^^^1
 ;;^UTILITY(U,$J,358.3,22295,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22295,1,2,0)
 ;;=2^12034
 ;;^UTILITY(U,$J,358.3,22295,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 7.6 cm to 12.5 cm
