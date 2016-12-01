IBDEI04A ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5156,1,2,0)
 ;;=2^10061
 ;;^UTILITY(U,$J,358.3,5156,1,3,0)
 ;;=3^I&D of abscess; complicated
 ;;^UTILITY(U,$J,358.3,5157,0)
 ;;=10080^^23^321^6^^^^1
 ;;^UTILITY(U,$J,358.3,5157,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5157,1,2,0)
 ;;=2^10080
 ;;^UTILITY(U,$J,358.3,5157,1,3,0)
 ;;=3^I&D of pilonidal cyst; simple
 ;;^UTILITY(U,$J,358.3,5158,0)
 ;;=10081^^23^321^5^^^^1
 ;;^UTILITY(U,$J,358.3,5158,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5158,1,2,0)
 ;;=2^10081
 ;;^UTILITY(U,$J,358.3,5158,1,3,0)
 ;;=3^I&D of pilonidal cyst; complicated
 ;;^UTILITY(U,$J,358.3,5159,0)
 ;;=10120^^23^321^7^^^^1
 ;;^UTILITY(U,$J,358.3,5159,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5159,1,2,0)
 ;;=2^10120
 ;;^UTILITY(U,$J,358.3,5159,1,3,0)
 ;;=3^Incision & Removal Foreign Body,SQ
 ;;^UTILITY(U,$J,358.3,5160,0)
 ;;=10121^^23^321^9^^^^1
 ;;^UTILITY(U,$J,358.3,5160,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5160,1,2,0)
 ;;=2^10121
 ;;^UTILITY(U,$J,358.3,5160,1,3,0)
 ;;=3^Removal of Foreign Body, SQ, Complicated
 ;;^UTILITY(U,$J,358.3,5161,0)
 ;;=10140^^23^321^2^^^^1
 ;;^UTILITY(U,$J,358.3,5161,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5161,1,2,0)
 ;;=2^10140
 ;;^UTILITY(U,$J,358.3,5161,1,3,0)
 ;;=3^Drainage of Hematoma/Fluid
 ;;^UTILITY(U,$J,358.3,5162,0)
 ;;=10160^^23^321^8^^^^1
 ;;^UTILITY(U,$J,358.3,5162,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5162,1,2,0)
 ;;=2^10160
 ;;^UTILITY(U,$J,358.3,5162,1,3,0)
 ;;=3^Puncture Drainage of Lesion
 ;;^UTILITY(U,$J,358.3,5163,0)
 ;;=11200^^23^322^7^^^^1
 ;;^UTILITY(U,$J,358.3,5163,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5163,1,2,0)
 ;;=2^11200
 ;;^UTILITY(U,$J,358.3,5163,1,3,0)
 ;;=3^Removal of Skin Tags,</=15 tags
 ;;^UTILITY(U,$J,358.3,5164,0)
 ;;=11201^^23^322^8^^^^1
 ;;^UTILITY(U,$J,358.3,5164,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5164,1,2,0)
 ;;=2^11201
 ;;^UTILITY(U,$J,358.3,5164,1,3,0)
 ;;=3^Removal of Skin Tags,Ea Add 10 tags
 ;;^UTILITY(U,$J,358.3,5165,0)
 ;;=11900^^23^322^4^^^^1
 ;;^UTILITY(U,$J,358.3,5165,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5165,1,2,0)
 ;;=2^11900
 ;;^UTILITY(U,$J,358.3,5165,1,3,0)
 ;;=3^INJ,Intralesional;<8 lesions
 ;;^UTILITY(U,$J,358.3,5166,0)
 ;;=11901^^23^322^5^^^^1
 ;;^UTILITY(U,$J,358.3,5166,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5166,1,2,0)
 ;;=2^11901
 ;;^UTILITY(U,$J,358.3,5166,1,3,0)
 ;;=3^INJ,intralesional;>7 lesions
 ;;^UTILITY(U,$J,358.3,5167,0)
 ;;=10030^^23^322^6^^^^1
 ;;^UTILITY(U,$J,358.3,5167,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5167,1,2,0)
 ;;=2^10030
 ;;^UTILITY(U,$J,358.3,5167,1,3,0)
 ;;=3^Image Guided Fluid Collect by Cath Percut
 ;;^UTILITY(U,$J,358.3,5168,0)
 ;;=11770^^23^322^3^^^^1
 ;;^UTILITY(U,$J,358.3,5168,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5168,1,2,0)
 ;;=2^11770
 ;;^UTILITY(U,$J,358.3,5168,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Simple
 ;;^UTILITY(U,$J,358.3,5169,0)
 ;;=11771^^23^322^2^^^^1
 ;;^UTILITY(U,$J,358.3,5169,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5169,1,2,0)
 ;;=2^11771
 ;;^UTILITY(U,$J,358.3,5169,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Extensive
 ;;^UTILITY(U,$J,358.3,5170,0)
 ;;=11772^^23^322^1^^^^1
 ;;^UTILITY(U,$J,358.3,5170,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5170,1,2,0)
 ;;=2^11772
 ;;^UTILITY(U,$J,358.3,5170,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Compl
 ;;^UTILITY(U,$J,358.3,5171,0)
 ;;=11719^^23^323^1^^^^1
 ;;^UTILITY(U,$J,358.3,5171,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5171,1,2,0)
 ;;=2^11719
 ;;^UTILITY(U,$J,358.3,5171,1,3,0)
 ;;=3^Trim nondystrophic nails, any number
 ;;^UTILITY(U,$J,358.3,5172,0)
 ;;=11720^^23^323^2^^^^1
 ;;^UTILITY(U,$J,358.3,5172,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5172,1,2,0)
 ;;=2^11720
 ;;^UTILITY(U,$J,358.3,5172,1,3,0)
 ;;=3^Debride of nail(s) any method;1-5
 ;;^UTILITY(U,$J,358.3,5173,0)
 ;;=11721^^23^323^3^^^^1
 ;;^UTILITY(U,$J,358.3,5173,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5173,1,2,0)
 ;;=2^11721
 ;;^UTILITY(U,$J,358.3,5173,1,3,0)
 ;;=3^Debride of nail(s) any method;6+
 ;;^UTILITY(U,$J,358.3,5174,0)
 ;;=11730^^23^323^4^^^^1
 ;;^UTILITY(U,$J,358.3,5174,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5174,1,2,0)
 ;;=2^11730
 ;;^UTILITY(U,$J,358.3,5174,1,3,0)
 ;;=3^Avulsion of nail plate,simple;single
 ;;^UTILITY(U,$J,358.3,5175,0)
 ;;=11732^^23^323^5^^^^1
 ;;^UTILITY(U,$J,358.3,5175,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5175,1,2,0)
 ;;=2^11732
 ;;^UTILITY(U,$J,358.3,5175,1,3,0)
 ;;=3^Avulsion of nail plate,Ea Add nail plate
 ;;^UTILITY(U,$J,358.3,5176,0)
 ;;=11740^^23^323^6^^^^1
 ;;^UTILITY(U,$J,358.3,5176,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5176,1,2,0)
 ;;=2^11740
 ;;^UTILITY(U,$J,358.3,5176,1,3,0)
 ;;=3^Evacuation of subungual hematoma
 ;;^UTILITY(U,$J,358.3,5177,0)
 ;;=11750^^23^323^7^^^^1
 ;;^UTILITY(U,$J,358.3,5177,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5177,1,2,0)
 ;;=2^11750
 ;;^UTILITY(U,$J,358.3,5177,1,3,0)
 ;;=3^Exc of nail&nail matrix,perm removal
 ;;^UTILITY(U,$J,358.3,5178,0)
 ;;=11752^^23^323^8^^^^1
 ;;^UTILITY(U,$J,358.3,5178,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5178,1,2,0)
 ;;=2^11752
 ;;^UTILITY(U,$J,358.3,5178,1,3,0)
 ;;=3^Exc of nail&nail matrix,w/amp of tuft
 ;;^UTILITY(U,$J,358.3,5179,0)
 ;;=11760^^23^323^9^^^^1
 ;;^UTILITY(U,$J,358.3,5179,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5179,1,2,0)
 ;;=2^11760
 ;;^UTILITY(U,$J,358.3,5179,1,3,0)
 ;;=3^Repair of nail bed
 ;;^UTILITY(U,$J,358.3,5180,0)
 ;;=11765^^23^323^10^^^^1
 ;;^UTILITY(U,$J,358.3,5180,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5180,1,2,0)
 ;;=2^11765
 ;;^UTILITY(U,$J,358.3,5180,1,3,0)
 ;;=3^Wedge excision of skin of nail fold
 ;;^UTILITY(U,$J,358.3,5181,0)
 ;;=11300^^23^324^1^^^^1
 ;;^UTILITY(U,$J,358.3,5181,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5181,1,2,0)
 ;;=2^11300
 ;;^UTILITY(U,$J,358.3,5181,1,3,0)
 ;;=3^Shaving Epiderm Arm/Leg: 0.5cm or less
 ;;^UTILITY(U,$J,358.3,5182,0)
 ;;=11301^^23^324^2^^^^1
 ;;^UTILITY(U,$J,358.3,5182,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5182,1,2,0)
 ;;=2^11301
 ;;^UTILITY(U,$J,358.3,5182,1,3,0)
 ;;=3^Shaving Epiderm Arm/Leg: 0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5183,0)
 ;;=11302^^23^324^3^^^^1
 ;;^UTILITY(U,$J,358.3,5183,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5183,1,2,0)
 ;;=2^11302
 ;;^UTILITY(U,$J,358.3,5183,1,3,0)
 ;;=3^Shaving Epiderm Arm/Leg: 1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5184,0)
 ;;=11303^^23^324^4^^^^1
 ;;^UTILITY(U,$J,358.3,5184,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5184,1,2,0)
 ;;=2^11303
 ;;^UTILITY(U,$J,358.3,5184,1,3,0)
 ;;=3^Shaving Epiderm Arm/Leg > 2.0cm
 ;;^UTILITY(U,$J,358.3,5185,0)
 ;;=12001^^23^325^1^^^^1
 ;;^UTILITY(U,$J,358.3,5185,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5185,1,2,0)
 ;;=2^12001
 ;;^UTILITY(U,$J,358.3,5185,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,5186,0)
 ;;=12002^^23^325^2^^^^1
 ;;^UTILITY(U,$J,358.3,5186,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5186,1,2,0)
 ;;=2^12002
 ;;^UTILITY(U,$J,358.3,5186,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 2.6 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,5187,0)
 ;;=12004^^23^325^3^^^^1
 ;;^UTILITY(U,$J,358.3,5187,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5187,1,2,0)
 ;;=2^12004
 ;;^UTILITY(U,$J,358.3,5187,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 7.6 cm to 12.5 cm
 ;;^UTILITY(U,$J,358.3,5188,0)
 ;;=12005^^23^325^4^^^^1
 ;;^UTILITY(U,$J,358.3,5188,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5188,1,2,0)
 ;;=2^12005
 ;;^UTILITY(U,$J,358.3,5188,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 12.6 cm to 20 cm
 ;;^UTILITY(U,$J,358.3,5189,0)
 ;;=12006^^23^325^5^^^^1
 ;;^UTILITY(U,$J,358.3,5189,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5189,1,2,0)
 ;;=2^12006
 ;;^UTILITY(U,$J,358.3,5189,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 20.1 cm to 30 cm
 ;;^UTILITY(U,$J,358.3,5190,0)
 ;;=12007^^23^325^6^^^^1
 ;;^UTILITY(U,$J,358.3,5190,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5190,1,2,0)
 ;;=2^12007
 ;;^UTILITY(U,$J,358.3,5190,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; over 30 cm
 ;;^UTILITY(U,$J,358.3,5191,0)
 ;;=12031^^23^326^1^^^^1
 ;;^UTILITY(U,$J,358.3,5191,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5191,1,2,0)
 ;;=2^12031
 ;;^UTILITY(U,$J,358.3,5191,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,5192,0)
 ;;=12032^^23^326^2^^^^1
 ;;^UTILITY(U,$J,358.3,5192,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5192,1,2,0)
 ;;=2^12032
 ;;^UTILITY(U,$J,358.3,5192,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 2.6 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,5193,0)
 ;;=12034^^23^326^3^^^^1
 ;;^UTILITY(U,$J,358.3,5193,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5193,1,2,0)
 ;;=2^12034
 ;;^UTILITY(U,$J,358.3,5193,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 7.6 cm to 12.5 cm
 ;;^UTILITY(U,$J,358.3,5194,0)
 ;;=12035^^23^326^4^^^^1
 ;;^UTILITY(U,$J,358.3,5194,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5194,1,2,0)
 ;;=2^12035
 ;;^UTILITY(U,$J,358.3,5194,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 12.6 cm to 20 cm
 ;;^UTILITY(U,$J,358.3,5195,0)
 ;;=12036^^23^326^5^^^^1
 ;;^UTILITY(U,$J,358.3,5195,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5195,1,2,0)
 ;;=2^12036
 ;;^UTILITY(U,$J,358.3,5195,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 20.1 cm to 30 cm
 ;;^UTILITY(U,$J,358.3,5196,0)
 ;;=12037^^23^326^6^^^^1
 ;;^UTILITY(U,$J,358.3,5196,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5196,1,2,0)
 ;;=2^12037
 ;;^UTILITY(U,$J,358.3,5196,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; over 30 cm
 ;;^UTILITY(U,$J,358.3,5197,0)
 ;;=17270^^23^327^1^^^^1
 ;;^UTILITY(U,$J,358.3,5197,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5197,1,2,0)
 ;;=2^17270
 ;;^UTILITY(U,$J,358.3,5197,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,0.5cm or <
 ;;^UTILITY(U,$J,358.3,5198,0)
 ;;=17271^^23^327^2^^^^1
 ;;^UTILITY(U,$J,358.3,5198,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5198,1,2,0)
 ;;=2^17271
