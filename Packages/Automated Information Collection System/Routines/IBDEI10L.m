IBDEI10L ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18178,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18178,1,2,0)
 ;;=2^10120
 ;;^UTILITY(U,$J,358.3,18178,1,3,0)
 ;;=3^Incision & Removal Foreign Body,SQ
 ;;^UTILITY(U,$J,358.3,18179,0)
 ;;=10121^^119^1130^9^^^^1
 ;;^UTILITY(U,$J,358.3,18179,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18179,1,2,0)
 ;;=2^10121
 ;;^UTILITY(U,$J,358.3,18179,1,3,0)
 ;;=3^Removal of Foreign Body, SQ, Complicated
 ;;^UTILITY(U,$J,358.3,18180,0)
 ;;=10140^^119^1130^2^^^^1
 ;;^UTILITY(U,$J,358.3,18180,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18180,1,2,0)
 ;;=2^10140
 ;;^UTILITY(U,$J,358.3,18180,1,3,0)
 ;;=3^Drainage of Hematoma/Fluid
 ;;^UTILITY(U,$J,358.3,18181,0)
 ;;=10160^^119^1130^8^^^^1
 ;;^UTILITY(U,$J,358.3,18181,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18181,1,2,0)
 ;;=2^10160
 ;;^UTILITY(U,$J,358.3,18181,1,3,0)
 ;;=3^Puncture Drainage of Lesion
 ;;^UTILITY(U,$J,358.3,18182,0)
 ;;=11200^^119^1131^7^^^^1
 ;;^UTILITY(U,$J,358.3,18182,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18182,1,2,0)
 ;;=2^11200
 ;;^UTILITY(U,$J,358.3,18182,1,3,0)
 ;;=3^Removal of Skin Tags,</=15 tags
 ;;^UTILITY(U,$J,358.3,18183,0)
 ;;=11201^^119^1131^8^^^^1
 ;;^UTILITY(U,$J,358.3,18183,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18183,1,2,0)
 ;;=2^11201
 ;;^UTILITY(U,$J,358.3,18183,1,3,0)
 ;;=3^Removal of Skin Tags,Ea Add 10 tags
 ;;^UTILITY(U,$J,358.3,18184,0)
 ;;=11900^^119^1131^4^^^^1
 ;;^UTILITY(U,$J,358.3,18184,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18184,1,2,0)
 ;;=2^11900
 ;;^UTILITY(U,$J,358.3,18184,1,3,0)
 ;;=3^INJ,Intralesional;<8 lesions
 ;;^UTILITY(U,$J,358.3,18185,0)
 ;;=11901^^119^1131^5^^^^1
 ;;^UTILITY(U,$J,358.3,18185,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18185,1,2,0)
 ;;=2^11901
 ;;^UTILITY(U,$J,358.3,18185,1,3,0)
 ;;=3^INJ,intralesional;>7 lesions
 ;;^UTILITY(U,$J,358.3,18186,0)
 ;;=10030^^119^1131^6^^^^1
 ;;^UTILITY(U,$J,358.3,18186,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18186,1,2,0)
 ;;=2^10030
 ;;^UTILITY(U,$J,358.3,18186,1,3,0)
 ;;=3^Image Guided Fluid Collect by Cath Percut
 ;;^UTILITY(U,$J,358.3,18187,0)
 ;;=11770^^119^1131^3^^^^1
 ;;^UTILITY(U,$J,358.3,18187,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18187,1,2,0)
 ;;=2^11770
 ;;^UTILITY(U,$J,358.3,18187,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Simple
 ;;^UTILITY(U,$J,358.3,18188,0)
 ;;=11771^^119^1131^2^^^^1
 ;;^UTILITY(U,$J,358.3,18188,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18188,1,2,0)
 ;;=2^11771
 ;;^UTILITY(U,$J,358.3,18188,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Extensive
 ;;^UTILITY(U,$J,358.3,18189,0)
 ;;=11772^^119^1131^1^^^^1
 ;;^UTILITY(U,$J,358.3,18189,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18189,1,2,0)
 ;;=2^11772
 ;;^UTILITY(U,$J,358.3,18189,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Compl
 ;;^UTILITY(U,$J,358.3,18190,0)
 ;;=11719^^119^1132^1^^^^1
 ;;^UTILITY(U,$J,358.3,18190,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18190,1,2,0)
 ;;=2^11719
 ;;^UTILITY(U,$J,358.3,18190,1,3,0)
 ;;=3^Trim nondystrophic nails, any number
 ;;^UTILITY(U,$J,358.3,18191,0)
 ;;=11720^^119^1132^2^^^^1
 ;;^UTILITY(U,$J,358.3,18191,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18191,1,2,0)
 ;;=2^11720
 ;;^UTILITY(U,$J,358.3,18191,1,3,0)
 ;;=3^Debride of nail(s) any method;1-5
 ;;^UTILITY(U,$J,358.3,18192,0)
 ;;=11721^^119^1132^3^^^^1
 ;;^UTILITY(U,$J,358.3,18192,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18192,1,2,0)
 ;;=2^11721
 ;;^UTILITY(U,$J,358.3,18192,1,3,0)
 ;;=3^Debride of nail(s) any method;6+
 ;;^UTILITY(U,$J,358.3,18193,0)
 ;;=11730^^119^1132^4^^^^1
 ;;^UTILITY(U,$J,358.3,18193,1,0)
 ;;=^358.31IA^3^2
