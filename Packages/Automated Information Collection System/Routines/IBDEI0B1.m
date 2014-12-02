IBDEI0B1 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5166,0)
 ;;=10080^^40^432^6^^^^1
 ;;^UTILITY(U,$J,358.3,5166,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5166,1,2,0)
 ;;=2^10080
 ;;^UTILITY(U,$J,358.3,5166,1,3,0)
 ;;=3^I&D of pilonidal cyst; simple
 ;;^UTILITY(U,$J,358.3,5167,0)
 ;;=10081^^40^432^5^^^^1
 ;;^UTILITY(U,$J,358.3,5167,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5167,1,2,0)
 ;;=2^10081
 ;;^UTILITY(U,$J,358.3,5167,1,3,0)
 ;;=3^I&D of pilonidal cyst; complicated
 ;;^UTILITY(U,$J,358.3,5168,0)
 ;;=10120^^40^432^7^^^^1
 ;;^UTILITY(U,$J,358.3,5168,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5168,1,2,0)
 ;;=2^10120
 ;;^UTILITY(U,$J,358.3,5168,1,3,0)
 ;;=3^Incision & Removal Foreign Body,SQ
 ;;^UTILITY(U,$J,358.3,5169,0)
 ;;=10121^^40^432^9^^^^1
 ;;^UTILITY(U,$J,358.3,5169,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5169,1,2,0)
 ;;=2^10121
 ;;^UTILITY(U,$J,358.3,5169,1,3,0)
 ;;=3^Removal of Foreign Body, SQ, Complicated
 ;;^UTILITY(U,$J,358.3,5170,0)
 ;;=10140^^40^432^2^^^^1
 ;;^UTILITY(U,$J,358.3,5170,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5170,1,2,0)
 ;;=2^10140
 ;;^UTILITY(U,$J,358.3,5170,1,3,0)
 ;;=3^Drainage of Hematoma/Fluid
 ;;^UTILITY(U,$J,358.3,5171,0)
 ;;=10160^^40^432^8^^^^1
 ;;^UTILITY(U,$J,358.3,5171,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5171,1,2,0)
 ;;=2^10160
 ;;^UTILITY(U,$J,358.3,5171,1,3,0)
 ;;=3^Puncture Drainage of Lesion
 ;;^UTILITY(U,$J,358.3,5172,0)
 ;;=11200^^40^433^7^^^^1
 ;;^UTILITY(U,$J,358.3,5172,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5172,1,2,0)
 ;;=2^11200
 ;;^UTILITY(U,$J,358.3,5172,1,3,0)
 ;;=3^Removal of Skin Tags,</=15 tags
 ;;^UTILITY(U,$J,358.3,5173,0)
 ;;=11201^^40^433^8^^^^1
 ;;^UTILITY(U,$J,358.3,5173,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5173,1,2,0)
 ;;=2^11201
 ;;^UTILITY(U,$J,358.3,5173,1,3,0)
 ;;=3^Removal of Skin Tags,Ea Add 10 tags
 ;;^UTILITY(U,$J,358.3,5174,0)
 ;;=11900^^40^433^4^^^^1
 ;;^UTILITY(U,$J,358.3,5174,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5174,1,2,0)
 ;;=2^11900
 ;;^UTILITY(U,$J,358.3,5174,1,3,0)
 ;;=3^INJ,Intralesional;<8 lesions
 ;;^UTILITY(U,$J,358.3,5175,0)
 ;;=11901^^40^433^5^^^^1
 ;;^UTILITY(U,$J,358.3,5175,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5175,1,2,0)
 ;;=2^11901
 ;;^UTILITY(U,$J,358.3,5175,1,3,0)
 ;;=3^INJ,intralesional;>7 lesions
 ;;^UTILITY(U,$J,358.3,5176,0)
 ;;=10030^^40^433^6^^^^1
 ;;^UTILITY(U,$J,358.3,5176,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5176,1,2,0)
 ;;=2^10030
 ;;^UTILITY(U,$J,358.3,5176,1,3,0)
 ;;=3^Image Guided Fluid Collect by Cath Percut
 ;;^UTILITY(U,$J,358.3,5177,0)
 ;;=11770^^40^433^3^^^^1
 ;;^UTILITY(U,$J,358.3,5177,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5177,1,2,0)
 ;;=2^11770
 ;;^UTILITY(U,$J,358.3,5177,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Simple
 ;;^UTILITY(U,$J,358.3,5178,0)
 ;;=11771^^40^433^2^^^^1
 ;;^UTILITY(U,$J,358.3,5178,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5178,1,2,0)
 ;;=2^11771
 ;;^UTILITY(U,$J,358.3,5178,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Extensive
 ;;^UTILITY(U,$J,358.3,5179,0)
 ;;=11772^^40^433^1^^^^1
 ;;^UTILITY(U,$J,358.3,5179,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5179,1,2,0)
 ;;=2^11772
 ;;^UTILITY(U,$J,358.3,5179,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Compl
 ;;^UTILITY(U,$J,358.3,5180,0)
 ;;=11719^^40^434^1^^^^1
 ;;^UTILITY(U,$J,358.3,5180,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5180,1,2,0)
 ;;=2^11719
 ;;^UTILITY(U,$J,358.3,5180,1,3,0)
 ;;=3^Trim nondystrophic nails, any number
 ;;^UTILITY(U,$J,358.3,5181,0)
 ;;=11720^^40^434^2^^^^1
 ;;^UTILITY(U,$J,358.3,5181,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5181,1,2,0)
 ;;=2^11720
