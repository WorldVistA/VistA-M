IBDEI1AF ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23106,1,3,0)
 ;;=3^Removal of Foreign Body, SQ, Complicated
 ;;^UTILITY(U,$J,358.3,23107,0)
 ;;=10140^^136^1395^2^^^^1
 ;;^UTILITY(U,$J,358.3,23107,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23107,1,2,0)
 ;;=2^10140
 ;;^UTILITY(U,$J,358.3,23107,1,3,0)
 ;;=3^Drainage of Hematoma/Fluid
 ;;^UTILITY(U,$J,358.3,23108,0)
 ;;=10160^^136^1395^8^^^^1
 ;;^UTILITY(U,$J,358.3,23108,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23108,1,2,0)
 ;;=2^10160
 ;;^UTILITY(U,$J,358.3,23108,1,3,0)
 ;;=3^Puncture Drainage of Lesion
 ;;^UTILITY(U,$J,358.3,23109,0)
 ;;=11200^^136^1396^7^^^^1
 ;;^UTILITY(U,$J,358.3,23109,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23109,1,2,0)
 ;;=2^11200
 ;;^UTILITY(U,$J,358.3,23109,1,3,0)
 ;;=3^Removal of Skin Tags,</=15 tags
 ;;^UTILITY(U,$J,358.3,23110,0)
 ;;=11201^^136^1396^8^^^^1
 ;;^UTILITY(U,$J,358.3,23110,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23110,1,2,0)
 ;;=2^11201
 ;;^UTILITY(U,$J,358.3,23110,1,3,0)
 ;;=3^Removal of Skin Tags,Ea Add 10 tags
 ;;^UTILITY(U,$J,358.3,23111,0)
 ;;=11900^^136^1396^4^^^^1
 ;;^UTILITY(U,$J,358.3,23111,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23111,1,2,0)
 ;;=2^11900
 ;;^UTILITY(U,$J,358.3,23111,1,3,0)
 ;;=3^INJ,Intralesional;<8 lesions
 ;;^UTILITY(U,$J,358.3,23112,0)
 ;;=11901^^136^1396^5^^^^1
 ;;^UTILITY(U,$J,358.3,23112,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23112,1,2,0)
 ;;=2^11901
 ;;^UTILITY(U,$J,358.3,23112,1,3,0)
 ;;=3^INJ,intralesional;>7 lesions
 ;;^UTILITY(U,$J,358.3,23113,0)
 ;;=10030^^136^1396^6^^^^1
 ;;^UTILITY(U,$J,358.3,23113,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23113,1,2,0)
 ;;=2^10030
 ;;^UTILITY(U,$J,358.3,23113,1,3,0)
 ;;=3^Image Guided Fluid Collect by Cath Percut
 ;;^UTILITY(U,$J,358.3,23114,0)
 ;;=11770^^136^1396^3^^^^1
 ;;^UTILITY(U,$J,358.3,23114,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23114,1,2,0)
 ;;=2^11770
 ;;^UTILITY(U,$J,358.3,23114,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Simple
 ;;^UTILITY(U,$J,358.3,23115,0)
 ;;=11771^^136^1396^2^^^^1
 ;;^UTILITY(U,$J,358.3,23115,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23115,1,2,0)
 ;;=2^11771
 ;;^UTILITY(U,$J,358.3,23115,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Extensive
 ;;^UTILITY(U,$J,358.3,23116,0)
 ;;=11772^^136^1396^1^^^^1
 ;;^UTILITY(U,$J,358.3,23116,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23116,1,2,0)
 ;;=2^11772
 ;;^UTILITY(U,$J,358.3,23116,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Compl
 ;;^UTILITY(U,$J,358.3,23117,0)
 ;;=11719^^136^1397^1^^^^1
 ;;^UTILITY(U,$J,358.3,23117,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23117,1,2,0)
 ;;=2^11719
 ;;^UTILITY(U,$J,358.3,23117,1,3,0)
 ;;=3^Trim nondystrophic nails, any number
 ;;^UTILITY(U,$J,358.3,23118,0)
 ;;=11720^^136^1397^2^^^^1
 ;;^UTILITY(U,$J,358.3,23118,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23118,1,2,0)
 ;;=2^11720
 ;;^UTILITY(U,$J,358.3,23118,1,3,0)
 ;;=3^Debride of nail(s) any method;1-5
 ;;^UTILITY(U,$J,358.3,23119,0)
 ;;=11721^^136^1397^3^^^^1
 ;;^UTILITY(U,$J,358.3,23119,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23119,1,2,0)
 ;;=2^11721
 ;;^UTILITY(U,$J,358.3,23119,1,3,0)
 ;;=3^Debride of nail(s) any method;6+
 ;;^UTILITY(U,$J,358.3,23120,0)
 ;;=11730^^136^1397^4^^^^1
 ;;^UTILITY(U,$J,358.3,23120,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23120,1,2,0)
 ;;=2^11730
 ;;^UTILITY(U,$J,358.3,23120,1,3,0)
 ;;=3^Avulsion of nail plate,simple;single
 ;;^UTILITY(U,$J,358.3,23121,0)
 ;;=11732^^136^1397^5^^^^1
 ;;^UTILITY(U,$J,358.3,23121,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23121,1,2,0)
 ;;=2^11732
 ;;^UTILITY(U,$J,358.3,23121,1,3,0)
 ;;=3^Avulsion of nail plate,Ea Add nail plate
