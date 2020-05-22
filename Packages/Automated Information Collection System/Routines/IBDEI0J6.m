IBDEI0J6 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8385,1,2,0)
 ;;=2^10140
 ;;^UTILITY(U,$J,358.3,8385,1,3,0)
 ;;=3^Drainage of Hematoma/Fluid
 ;;^UTILITY(U,$J,358.3,8386,0)
 ;;=10160^^66^540^8^^^^1
 ;;^UTILITY(U,$J,358.3,8386,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8386,1,2,0)
 ;;=2^10160
 ;;^UTILITY(U,$J,358.3,8386,1,3,0)
 ;;=3^Puncture Drainage of Lesion
 ;;^UTILITY(U,$J,358.3,8387,0)
 ;;=11200^^66^541^7^^^^1
 ;;^UTILITY(U,$J,358.3,8387,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8387,1,2,0)
 ;;=2^11200
 ;;^UTILITY(U,$J,358.3,8387,1,3,0)
 ;;=3^Removal of Skin Tags,</=15 tags
 ;;^UTILITY(U,$J,358.3,8388,0)
 ;;=11201^^66^541^8^^^^1
 ;;^UTILITY(U,$J,358.3,8388,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8388,1,2,0)
 ;;=2^11201
 ;;^UTILITY(U,$J,358.3,8388,1,3,0)
 ;;=3^Removal of Skin Tags,Ea Add 10 tags
 ;;^UTILITY(U,$J,358.3,8389,0)
 ;;=11900^^66^541^4^^^^1
 ;;^UTILITY(U,$J,358.3,8389,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8389,1,2,0)
 ;;=2^11900
 ;;^UTILITY(U,$J,358.3,8389,1,3,0)
 ;;=3^INJ,Intralesional;<8 lesions
 ;;^UTILITY(U,$J,358.3,8390,0)
 ;;=11901^^66^541^5^^^^1
 ;;^UTILITY(U,$J,358.3,8390,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8390,1,2,0)
 ;;=2^11901
 ;;^UTILITY(U,$J,358.3,8390,1,3,0)
 ;;=3^INJ,intralesional;>7 lesions
 ;;^UTILITY(U,$J,358.3,8391,0)
 ;;=10030^^66^541^6^^^^1
 ;;^UTILITY(U,$J,358.3,8391,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8391,1,2,0)
 ;;=2^10030
 ;;^UTILITY(U,$J,358.3,8391,1,3,0)
 ;;=3^Image Guided Fluid Collect by Cath Percut
 ;;^UTILITY(U,$J,358.3,8392,0)
 ;;=11770^^66^541^3^^^^1
 ;;^UTILITY(U,$J,358.3,8392,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8392,1,2,0)
 ;;=2^11770
 ;;^UTILITY(U,$J,358.3,8392,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Simple
 ;;^UTILITY(U,$J,358.3,8393,0)
 ;;=11771^^66^541^2^^^^1
 ;;^UTILITY(U,$J,358.3,8393,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8393,1,2,0)
 ;;=2^11771
 ;;^UTILITY(U,$J,358.3,8393,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Extensive
 ;;^UTILITY(U,$J,358.3,8394,0)
 ;;=11772^^66^541^1^^^^1
 ;;^UTILITY(U,$J,358.3,8394,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8394,1,2,0)
 ;;=2^11772
 ;;^UTILITY(U,$J,358.3,8394,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Compl
 ;;^UTILITY(U,$J,358.3,8395,0)
 ;;=11719^^66^542^10^^^^1
 ;;^UTILITY(U,$J,358.3,8395,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8395,1,2,0)
 ;;=2^11719
 ;;^UTILITY(U,$J,358.3,8395,1,3,0)
 ;;=3^Trim nondystrophic nails, any number
 ;;^UTILITY(U,$J,358.3,8396,0)
 ;;=11720^^66^542^3^^^^1
 ;;^UTILITY(U,$J,358.3,8396,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8396,1,2,0)
 ;;=2^11720
 ;;^UTILITY(U,$J,358.3,8396,1,3,0)
 ;;=3^Debride of nail(s) any method;1-5
 ;;^UTILITY(U,$J,358.3,8397,0)
 ;;=11721^^66^542^4^^^^1
 ;;^UTILITY(U,$J,358.3,8397,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8397,1,2,0)
 ;;=2^11721
 ;;^UTILITY(U,$J,358.3,8397,1,3,0)
 ;;=3^Debride of nail(s) any method;6+
 ;;^UTILITY(U,$J,358.3,8398,0)
 ;;=11730^^66^542^2^^^^1
 ;;^UTILITY(U,$J,358.3,8398,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8398,1,2,0)
 ;;=2^11730
 ;;^UTILITY(U,$J,358.3,8398,1,3,0)
 ;;=3^Avulsion of nail plate,simple;single
 ;;^UTILITY(U,$J,358.3,8399,0)
 ;;=11732^^66^542^1^^^^1
 ;;^UTILITY(U,$J,358.3,8399,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8399,1,2,0)
 ;;=2^11732
 ;;^UTILITY(U,$J,358.3,8399,1,3,0)
 ;;=3^Avulsion of nail plate,Ea Add nail plate
 ;;^UTILITY(U,$J,358.3,8400,0)
 ;;=11740^^66^542^5^^^^1
