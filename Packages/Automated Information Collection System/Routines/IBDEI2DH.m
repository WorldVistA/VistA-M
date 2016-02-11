IBDEI2DH ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39841,1,2,0)
 ;;=2^10081
 ;;^UTILITY(U,$J,358.3,39841,1,3,0)
 ;;=3^I&D of pilonidal cyst; complicated
 ;;^UTILITY(U,$J,358.3,39842,0)
 ;;=10120^^185^2042^7^^^^1
 ;;^UTILITY(U,$J,358.3,39842,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39842,1,2,0)
 ;;=2^10120
 ;;^UTILITY(U,$J,358.3,39842,1,3,0)
 ;;=3^Incision & Removal Foreign Body,SQ
 ;;^UTILITY(U,$J,358.3,39843,0)
 ;;=10121^^185^2042^9^^^^1
 ;;^UTILITY(U,$J,358.3,39843,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39843,1,2,0)
 ;;=2^10121
 ;;^UTILITY(U,$J,358.3,39843,1,3,0)
 ;;=3^Removal of Foreign Body, SQ, Complicated
 ;;^UTILITY(U,$J,358.3,39844,0)
 ;;=10140^^185^2042^2^^^^1
 ;;^UTILITY(U,$J,358.3,39844,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39844,1,2,0)
 ;;=2^10140
 ;;^UTILITY(U,$J,358.3,39844,1,3,0)
 ;;=3^Drainage of Hematoma/Fluid
 ;;^UTILITY(U,$J,358.3,39845,0)
 ;;=10160^^185^2042^8^^^^1
 ;;^UTILITY(U,$J,358.3,39845,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39845,1,2,0)
 ;;=2^10160
 ;;^UTILITY(U,$J,358.3,39845,1,3,0)
 ;;=3^Puncture Drainage of Lesion
 ;;^UTILITY(U,$J,358.3,39846,0)
 ;;=11200^^185^2043^7^^^^1
 ;;^UTILITY(U,$J,358.3,39846,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39846,1,2,0)
 ;;=2^11200
 ;;^UTILITY(U,$J,358.3,39846,1,3,0)
 ;;=3^Removal of Skin Tags,</=15 tags
 ;;^UTILITY(U,$J,358.3,39847,0)
 ;;=11201^^185^2043^8^^^^1
 ;;^UTILITY(U,$J,358.3,39847,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39847,1,2,0)
 ;;=2^11201
 ;;^UTILITY(U,$J,358.3,39847,1,3,0)
 ;;=3^Removal of Skin Tags,Ea Add 10 tags
 ;;^UTILITY(U,$J,358.3,39848,0)
 ;;=11900^^185^2043^4^^^^1
 ;;^UTILITY(U,$J,358.3,39848,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39848,1,2,0)
 ;;=2^11900
 ;;^UTILITY(U,$J,358.3,39848,1,3,0)
 ;;=3^INJ,Intralesional;<8 lesions
 ;;^UTILITY(U,$J,358.3,39849,0)
 ;;=11901^^185^2043^5^^^^1
 ;;^UTILITY(U,$J,358.3,39849,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39849,1,2,0)
 ;;=2^11901
 ;;^UTILITY(U,$J,358.3,39849,1,3,0)
 ;;=3^INJ,intralesional;>7 lesions
 ;;^UTILITY(U,$J,358.3,39850,0)
 ;;=10030^^185^2043^6^^^^1
 ;;^UTILITY(U,$J,358.3,39850,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39850,1,2,0)
 ;;=2^10030
 ;;^UTILITY(U,$J,358.3,39850,1,3,0)
 ;;=3^Image Guided Fluid Collect by Cath Percut
 ;;^UTILITY(U,$J,358.3,39851,0)
 ;;=11770^^185^2043^3^^^^1
 ;;^UTILITY(U,$J,358.3,39851,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39851,1,2,0)
 ;;=2^11770
 ;;^UTILITY(U,$J,358.3,39851,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Simple
 ;;^UTILITY(U,$J,358.3,39852,0)
 ;;=11771^^185^2043^2^^^^1
 ;;^UTILITY(U,$J,358.3,39852,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39852,1,2,0)
 ;;=2^11771
 ;;^UTILITY(U,$J,358.3,39852,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Extensive
 ;;^UTILITY(U,$J,358.3,39853,0)
 ;;=11772^^185^2043^1^^^^1
 ;;^UTILITY(U,$J,358.3,39853,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39853,1,2,0)
 ;;=2^11772
 ;;^UTILITY(U,$J,358.3,39853,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Compl
 ;;^UTILITY(U,$J,358.3,39854,0)
 ;;=11719^^185^2044^1^^^^1
 ;;^UTILITY(U,$J,358.3,39854,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39854,1,2,0)
 ;;=2^11719
 ;;^UTILITY(U,$J,358.3,39854,1,3,0)
 ;;=3^Trim nondystrophic nails, any number
 ;;^UTILITY(U,$J,358.3,39855,0)
 ;;=11720^^185^2044^2^^^^1
 ;;^UTILITY(U,$J,358.3,39855,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39855,1,2,0)
 ;;=2^11720
 ;;^UTILITY(U,$J,358.3,39855,1,3,0)
 ;;=3^Debride of nail(s) any method;1-5
 ;;^UTILITY(U,$J,358.3,39856,0)
 ;;=11721^^185^2044^3^^^^1
 ;;^UTILITY(U,$J,358.3,39856,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39856,1,2,0)
 ;;=2^11721
