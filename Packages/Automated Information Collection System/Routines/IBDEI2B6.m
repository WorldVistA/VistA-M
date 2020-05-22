IBDEI2B6 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36856,1,2,0)
 ;;=2^10060
 ;;^UTILITY(U,$J,358.3,36856,1,3,0)
 ;;=3^I&D of abscess; simple or single
 ;;^UTILITY(U,$J,358.3,36857,0)
 ;;=10061^^143^1871^3^^^^1
 ;;^UTILITY(U,$J,358.3,36857,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36857,1,2,0)
 ;;=2^10061
 ;;^UTILITY(U,$J,358.3,36857,1,3,0)
 ;;=3^I&D of abscess; complicated
 ;;^UTILITY(U,$J,358.3,36858,0)
 ;;=10080^^143^1871^6^^^^1
 ;;^UTILITY(U,$J,358.3,36858,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36858,1,2,0)
 ;;=2^10080
 ;;^UTILITY(U,$J,358.3,36858,1,3,0)
 ;;=3^I&D of pilonidal cyst; simple
 ;;^UTILITY(U,$J,358.3,36859,0)
 ;;=10081^^143^1871^5^^^^1
 ;;^UTILITY(U,$J,358.3,36859,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36859,1,2,0)
 ;;=2^10081
 ;;^UTILITY(U,$J,358.3,36859,1,3,0)
 ;;=3^I&D of pilonidal cyst; complicated
 ;;^UTILITY(U,$J,358.3,36860,0)
 ;;=10120^^143^1871^7^^^^1
 ;;^UTILITY(U,$J,358.3,36860,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36860,1,2,0)
 ;;=2^10120
 ;;^UTILITY(U,$J,358.3,36860,1,3,0)
 ;;=3^Incision & Removal Foreign Body,SQ
 ;;^UTILITY(U,$J,358.3,36861,0)
 ;;=10121^^143^1871^9^^^^1
 ;;^UTILITY(U,$J,358.3,36861,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36861,1,2,0)
 ;;=2^10121
 ;;^UTILITY(U,$J,358.3,36861,1,3,0)
 ;;=3^Removal of Foreign Body, SQ, Complicated
 ;;^UTILITY(U,$J,358.3,36862,0)
 ;;=10140^^143^1871^2^^^^1
 ;;^UTILITY(U,$J,358.3,36862,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36862,1,2,0)
 ;;=2^10140
 ;;^UTILITY(U,$J,358.3,36862,1,3,0)
 ;;=3^Drainage of Hematoma/Fluid
 ;;^UTILITY(U,$J,358.3,36863,0)
 ;;=10160^^143^1871^8^^^^1
 ;;^UTILITY(U,$J,358.3,36863,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36863,1,2,0)
 ;;=2^10160
 ;;^UTILITY(U,$J,358.3,36863,1,3,0)
 ;;=3^Puncture Drainage of Lesion
 ;;^UTILITY(U,$J,358.3,36864,0)
 ;;=11200^^143^1872^7^^^^1
 ;;^UTILITY(U,$J,358.3,36864,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36864,1,2,0)
 ;;=2^11200
 ;;^UTILITY(U,$J,358.3,36864,1,3,0)
 ;;=3^Removal of Skin Tags,</=15 tags
 ;;^UTILITY(U,$J,358.3,36865,0)
 ;;=11201^^143^1872^8^^^^1
 ;;^UTILITY(U,$J,358.3,36865,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36865,1,2,0)
 ;;=2^11201
 ;;^UTILITY(U,$J,358.3,36865,1,3,0)
 ;;=3^Removal of Skin Tags,Ea Add 10 tags
 ;;^UTILITY(U,$J,358.3,36866,0)
 ;;=11900^^143^1872^4^^^^1
 ;;^UTILITY(U,$J,358.3,36866,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36866,1,2,0)
 ;;=2^11900
 ;;^UTILITY(U,$J,358.3,36866,1,3,0)
 ;;=3^INJ,Intralesional;<8 lesions
 ;;^UTILITY(U,$J,358.3,36867,0)
 ;;=11901^^143^1872^5^^^^1
 ;;^UTILITY(U,$J,358.3,36867,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36867,1,2,0)
 ;;=2^11901
 ;;^UTILITY(U,$J,358.3,36867,1,3,0)
 ;;=3^INJ,intralesional;>7 lesions
 ;;^UTILITY(U,$J,358.3,36868,0)
 ;;=10030^^143^1872^6^^^^1
 ;;^UTILITY(U,$J,358.3,36868,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36868,1,2,0)
 ;;=2^10030
 ;;^UTILITY(U,$J,358.3,36868,1,3,0)
 ;;=3^Image Guided Fluid Collect by Cath Percut
 ;;^UTILITY(U,$J,358.3,36869,0)
 ;;=11770^^143^1872^3^^^^1
 ;;^UTILITY(U,$J,358.3,36869,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36869,1,2,0)
 ;;=2^11770
 ;;^UTILITY(U,$J,358.3,36869,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Simple
 ;;^UTILITY(U,$J,358.3,36870,0)
 ;;=11771^^143^1872^2^^^^1
 ;;^UTILITY(U,$J,358.3,36870,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36870,1,2,0)
 ;;=2^11771
 ;;^UTILITY(U,$J,358.3,36870,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Extensive
