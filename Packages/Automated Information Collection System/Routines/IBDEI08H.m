IBDEI08H ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3838,0)
 ;;=10080^^32^350^6^^^^1
 ;;^UTILITY(U,$J,358.3,3838,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3838,1,2,0)
 ;;=2^10080
 ;;^UTILITY(U,$J,358.3,3838,1,3,0)
 ;;=3^I&D of pilonidal cyst; simple
 ;;^UTILITY(U,$J,358.3,3839,0)
 ;;=10081^^32^350^5^^^^1
 ;;^UTILITY(U,$J,358.3,3839,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3839,1,2,0)
 ;;=2^10081
 ;;^UTILITY(U,$J,358.3,3839,1,3,0)
 ;;=3^I&D of pilonidal cyst; complicated
 ;;^UTILITY(U,$J,358.3,3840,0)
 ;;=10120^^32^350^7^^^^1
 ;;^UTILITY(U,$J,358.3,3840,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3840,1,2,0)
 ;;=2^10120
 ;;^UTILITY(U,$J,358.3,3840,1,3,0)
 ;;=3^Incision & Removal Foreign Body,SQ
 ;;^UTILITY(U,$J,358.3,3841,0)
 ;;=10121^^32^350^9^^^^1
 ;;^UTILITY(U,$J,358.3,3841,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3841,1,2,0)
 ;;=2^10121
 ;;^UTILITY(U,$J,358.3,3841,1,3,0)
 ;;=3^Removal of Foreign Body, SQ, Complicated
 ;;^UTILITY(U,$J,358.3,3842,0)
 ;;=10140^^32^350^2^^^^1
 ;;^UTILITY(U,$J,358.3,3842,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3842,1,2,0)
 ;;=2^10140
 ;;^UTILITY(U,$J,358.3,3842,1,3,0)
 ;;=3^Drainage of Hematoma/Fluid
 ;;^UTILITY(U,$J,358.3,3843,0)
 ;;=10160^^32^350^8^^^^1
 ;;^UTILITY(U,$J,358.3,3843,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3843,1,2,0)
 ;;=2^10160
 ;;^UTILITY(U,$J,358.3,3843,1,3,0)
 ;;=3^Puncture Drainage of Lesion
 ;;^UTILITY(U,$J,358.3,3844,0)
 ;;=11200^^32^351^7^^^^1
 ;;^UTILITY(U,$J,358.3,3844,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3844,1,2,0)
 ;;=2^11200
 ;;^UTILITY(U,$J,358.3,3844,1,3,0)
 ;;=3^Removal of Skin Tags,</=15 tags
 ;;^UTILITY(U,$J,358.3,3845,0)
 ;;=11201^^32^351^8^^^^1
 ;;^UTILITY(U,$J,358.3,3845,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3845,1,2,0)
 ;;=2^11201
 ;;^UTILITY(U,$J,358.3,3845,1,3,0)
 ;;=3^Removal of Skin Tags,Ea Add 10 tags
 ;;^UTILITY(U,$J,358.3,3846,0)
 ;;=11900^^32^351^4^^^^1
 ;;^UTILITY(U,$J,358.3,3846,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3846,1,2,0)
 ;;=2^11900
 ;;^UTILITY(U,$J,358.3,3846,1,3,0)
 ;;=3^INJ,Intralesional;<8 lesions
 ;;^UTILITY(U,$J,358.3,3847,0)
 ;;=11901^^32^351^5^^^^1
 ;;^UTILITY(U,$J,358.3,3847,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3847,1,2,0)
 ;;=2^11901
 ;;^UTILITY(U,$J,358.3,3847,1,3,0)
 ;;=3^INJ,intralesional;>7 lesions
 ;;^UTILITY(U,$J,358.3,3848,0)
 ;;=10030^^32^351^6^^^^1
 ;;^UTILITY(U,$J,358.3,3848,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3848,1,2,0)
 ;;=2^10030
 ;;^UTILITY(U,$J,358.3,3848,1,3,0)
 ;;=3^Image Guided Fluid Collect by Cath Percut
 ;;^UTILITY(U,$J,358.3,3849,0)
 ;;=11770^^32^351^3^^^^1
 ;;^UTILITY(U,$J,358.3,3849,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3849,1,2,0)
 ;;=2^11770
 ;;^UTILITY(U,$J,358.3,3849,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Simple
 ;;^UTILITY(U,$J,358.3,3850,0)
 ;;=11771^^32^351^2^^^^1
 ;;^UTILITY(U,$J,358.3,3850,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3850,1,2,0)
 ;;=2^11771
 ;;^UTILITY(U,$J,358.3,3850,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Extensive
 ;;^UTILITY(U,$J,358.3,3851,0)
 ;;=11772^^32^351^1^^^^1
 ;;^UTILITY(U,$J,358.3,3851,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3851,1,2,0)
 ;;=2^11772
 ;;^UTILITY(U,$J,358.3,3851,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Compl
 ;;^UTILITY(U,$J,358.3,3852,0)
 ;;=11719^^32^352^1^^^^1
 ;;^UTILITY(U,$J,358.3,3852,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3852,1,2,0)
 ;;=2^11719
 ;;^UTILITY(U,$J,358.3,3852,1,3,0)
 ;;=3^Trim nondystrophic nails, any number
 ;;^UTILITY(U,$J,358.3,3853,0)
 ;;=11720^^32^352^2^^^^1
 ;;^UTILITY(U,$J,358.3,3853,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3853,1,2,0)
 ;;=2^11720
