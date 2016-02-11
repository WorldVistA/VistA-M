IBDEI0EW ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6520,0)
 ;;=11604^^45^410^5^^^^1
 ;;^UTILITY(U,$J,358.3,6520,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6520,1,2,0)
 ;;=2^11604
 ;;^UTILITY(U,$J,358.3,6520,1,3,0)
 ;;=3^Exc Mal Lesion Tnk/Arm/Leg,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,6521,0)
 ;;=11606^^45^410^6^^^^1
 ;;^UTILITY(U,$J,358.3,6521,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6521,1,2,0)
 ;;=2^11606
 ;;^UTILITY(U,$J,358.3,6521,1,3,0)
 ;;=3^Exc Mal Lesion Tnk/Arm/Leg > 4.0cm
 ;;^UTILITY(U,$J,358.3,6522,0)
 ;;=10040^^45^411^1^^^^1
 ;;^UTILITY(U,$J,358.3,6522,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6522,1,2,0)
 ;;=2^10040
 ;;^UTILITY(U,$J,358.3,6522,1,3,0)
 ;;=3^Acne Surgery
 ;;^UTILITY(U,$J,358.3,6523,0)
 ;;=10060^^45^411^4^^^^1
 ;;^UTILITY(U,$J,358.3,6523,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6523,1,2,0)
 ;;=2^10060
 ;;^UTILITY(U,$J,358.3,6523,1,3,0)
 ;;=3^I&D of abscess; simple or single
 ;;^UTILITY(U,$J,358.3,6524,0)
 ;;=10061^^45^411^3^^^^1
 ;;^UTILITY(U,$J,358.3,6524,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6524,1,2,0)
 ;;=2^10061
 ;;^UTILITY(U,$J,358.3,6524,1,3,0)
 ;;=3^I&D of abscess; complicated
 ;;^UTILITY(U,$J,358.3,6525,0)
 ;;=10080^^45^411^6^^^^1
 ;;^UTILITY(U,$J,358.3,6525,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6525,1,2,0)
 ;;=2^10080
 ;;^UTILITY(U,$J,358.3,6525,1,3,0)
 ;;=3^I&D of pilonidal cyst; simple
 ;;^UTILITY(U,$J,358.3,6526,0)
 ;;=10081^^45^411^5^^^^1
 ;;^UTILITY(U,$J,358.3,6526,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6526,1,2,0)
 ;;=2^10081
 ;;^UTILITY(U,$J,358.3,6526,1,3,0)
 ;;=3^I&D of pilonidal cyst; complicated
 ;;^UTILITY(U,$J,358.3,6527,0)
 ;;=10120^^45^411^7^^^^1
 ;;^UTILITY(U,$J,358.3,6527,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6527,1,2,0)
 ;;=2^10120
 ;;^UTILITY(U,$J,358.3,6527,1,3,0)
 ;;=3^Incision & Removal Foreign Body,SQ
 ;;^UTILITY(U,$J,358.3,6528,0)
 ;;=10121^^45^411^9^^^^1
 ;;^UTILITY(U,$J,358.3,6528,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6528,1,2,0)
 ;;=2^10121
 ;;^UTILITY(U,$J,358.3,6528,1,3,0)
 ;;=3^Removal of Foreign Body, SQ, Complicated
 ;;^UTILITY(U,$J,358.3,6529,0)
 ;;=10140^^45^411^2^^^^1
 ;;^UTILITY(U,$J,358.3,6529,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6529,1,2,0)
 ;;=2^10140
 ;;^UTILITY(U,$J,358.3,6529,1,3,0)
 ;;=3^Drainage of Hematoma/Fluid
 ;;^UTILITY(U,$J,358.3,6530,0)
 ;;=10160^^45^411^8^^^^1
 ;;^UTILITY(U,$J,358.3,6530,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6530,1,2,0)
 ;;=2^10160
 ;;^UTILITY(U,$J,358.3,6530,1,3,0)
 ;;=3^Puncture Drainage of Lesion
 ;;^UTILITY(U,$J,358.3,6531,0)
 ;;=11200^^45^412^7^^^^1
 ;;^UTILITY(U,$J,358.3,6531,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6531,1,2,0)
 ;;=2^11200
 ;;^UTILITY(U,$J,358.3,6531,1,3,0)
 ;;=3^Removal of Skin Tags,</=15 tags
 ;;^UTILITY(U,$J,358.3,6532,0)
 ;;=11201^^45^412^8^^^^1
 ;;^UTILITY(U,$J,358.3,6532,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6532,1,2,0)
 ;;=2^11201
 ;;^UTILITY(U,$J,358.3,6532,1,3,0)
 ;;=3^Removal of Skin Tags,Ea Add 10 tags
 ;;^UTILITY(U,$J,358.3,6533,0)
 ;;=11900^^45^412^4^^^^1
 ;;^UTILITY(U,$J,358.3,6533,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6533,1,2,0)
 ;;=2^11900
 ;;^UTILITY(U,$J,358.3,6533,1,3,0)
 ;;=3^INJ,Intralesional;<8 lesions
 ;;^UTILITY(U,$J,358.3,6534,0)
 ;;=11901^^45^412^5^^^^1
 ;;^UTILITY(U,$J,358.3,6534,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6534,1,2,0)
 ;;=2^11901
 ;;^UTILITY(U,$J,358.3,6534,1,3,0)
 ;;=3^INJ,intralesional;>7 lesions
 ;;^UTILITY(U,$J,358.3,6535,0)
 ;;=10030^^45^412^6^^^^1
 ;;^UTILITY(U,$J,358.3,6535,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6535,1,2,0)
 ;;=2^10030
 ;;^UTILITY(U,$J,358.3,6535,1,3,0)
 ;;=3^Image Guided Fluid Collect by Cath Percut
