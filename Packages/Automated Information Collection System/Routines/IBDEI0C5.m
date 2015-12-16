IBDEI0C5 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5384,1,2,0)
 ;;=2^11606
 ;;^UTILITY(U,$J,358.3,5384,1,3,0)
 ;;=3^Exc Mal Lesion Tnk/Arm/Leg > 4.0cm
 ;;^UTILITY(U,$J,358.3,5385,0)
 ;;=10040^^26^330^1^^^^1
 ;;^UTILITY(U,$J,358.3,5385,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5385,1,2,0)
 ;;=2^10040
 ;;^UTILITY(U,$J,358.3,5385,1,3,0)
 ;;=3^Acne Surgery
 ;;^UTILITY(U,$J,358.3,5386,0)
 ;;=10060^^26^330^4^^^^1
 ;;^UTILITY(U,$J,358.3,5386,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5386,1,2,0)
 ;;=2^10060
 ;;^UTILITY(U,$J,358.3,5386,1,3,0)
 ;;=3^I&D of abscess; simple or single
 ;;^UTILITY(U,$J,358.3,5387,0)
 ;;=10061^^26^330^3^^^^1
 ;;^UTILITY(U,$J,358.3,5387,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5387,1,2,0)
 ;;=2^10061
 ;;^UTILITY(U,$J,358.3,5387,1,3,0)
 ;;=3^I&D of abscess; complicated
 ;;^UTILITY(U,$J,358.3,5388,0)
 ;;=10080^^26^330^6^^^^1
 ;;^UTILITY(U,$J,358.3,5388,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5388,1,2,0)
 ;;=2^10080
 ;;^UTILITY(U,$J,358.3,5388,1,3,0)
 ;;=3^I&D of pilonidal cyst; simple
 ;;^UTILITY(U,$J,358.3,5389,0)
 ;;=10081^^26^330^5^^^^1
 ;;^UTILITY(U,$J,358.3,5389,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5389,1,2,0)
 ;;=2^10081
 ;;^UTILITY(U,$J,358.3,5389,1,3,0)
 ;;=3^I&D of pilonidal cyst; complicated
 ;;^UTILITY(U,$J,358.3,5390,0)
 ;;=10120^^26^330^7^^^^1
 ;;^UTILITY(U,$J,358.3,5390,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5390,1,2,0)
 ;;=2^10120
 ;;^UTILITY(U,$J,358.3,5390,1,3,0)
 ;;=3^Incision & Removal Foreign Body,SQ
 ;;^UTILITY(U,$J,358.3,5391,0)
 ;;=10121^^26^330^9^^^^1
 ;;^UTILITY(U,$J,358.3,5391,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5391,1,2,0)
 ;;=2^10121
 ;;^UTILITY(U,$J,358.3,5391,1,3,0)
 ;;=3^Removal of Foreign Body, SQ, Complicated
 ;;^UTILITY(U,$J,358.3,5392,0)
 ;;=10140^^26^330^2^^^^1
 ;;^UTILITY(U,$J,358.3,5392,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5392,1,2,0)
 ;;=2^10140
 ;;^UTILITY(U,$J,358.3,5392,1,3,0)
 ;;=3^Drainage of Hematoma/Fluid
 ;;^UTILITY(U,$J,358.3,5393,0)
 ;;=10160^^26^330^8^^^^1
 ;;^UTILITY(U,$J,358.3,5393,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5393,1,2,0)
 ;;=2^10160
 ;;^UTILITY(U,$J,358.3,5393,1,3,0)
 ;;=3^Puncture Drainage of Lesion
 ;;^UTILITY(U,$J,358.3,5394,0)
 ;;=11200^^26^331^7^^^^1
 ;;^UTILITY(U,$J,358.3,5394,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5394,1,2,0)
 ;;=2^11200
 ;;^UTILITY(U,$J,358.3,5394,1,3,0)
 ;;=3^Removal of Skin Tags,</=15 tags
 ;;^UTILITY(U,$J,358.3,5395,0)
 ;;=11201^^26^331^8^^^^1
 ;;^UTILITY(U,$J,358.3,5395,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5395,1,2,0)
 ;;=2^11201
 ;;^UTILITY(U,$J,358.3,5395,1,3,0)
 ;;=3^Removal of Skin Tags,Ea Add 10 tags
 ;;^UTILITY(U,$J,358.3,5396,0)
 ;;=11900^^26^331^4^^^^1
 ;;^UTILITY(U,$J,358.3,5396,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5396,1,2,0)
 ;;=2^11900
 ;;^UTILITY(U,$J,358.3,5396,1,3,0)
 ;;=3^INJ,Intralesional;<8 lesions
 ;;^UTILITY(U,$J,358.3,5397,0)
 ;;=11901^^26^331^5^^^^1
 ;;^UTILITY(U,$J,358.3,5397,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5397,1,2,0)
 ;;=2^11901
 ;;^UTILITY(U,$J,358.3,5397,1,3,0)
 ;;=3^INJ,intralesional;>7 lesions
 ;;^UTILITY(U,$J,358.3,5398,0)
 ;;=10030^^26^331^6^^^^1
 ;;^UTILITY(U,$J,358.3,5398,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5398,1,2,0)
 ;;=2^10030
 ;;^UTILITY(U,$J,358.3,5398,1,3,0)
 ;;=3^Image Guided Fluid Collect by Cath Percut
 ;;^UTILITY(U,$J,358.3,5399,0)
 ;;=11770^^26^331^3^^^^1
 ;;^UTILITY(U,$J,358.3,5399,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5399,1,2,0)
 ;;=2^11770
 ;;^UTILITY(U,$J,358.3,5399,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Simple
 ;;^UTILITY(U,$J,358.3,5400,0)
 ;;=11771^^26^331^2^^^^1
