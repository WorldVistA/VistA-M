IBDEI09C ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4094,0)
 ;;=11606^^20^236^6^^^^1
 ;;^UTILITY(U,$J,358.3,4094,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4094,1,2,0)
 ;;=2^11606
 ;;^UTILITY(U,$J,358.3,4094,1,3,0)
 ;;=3^Exc Mal Lesion Tnk/Arm/Leg > 4.0cm
 ;;^UTILITY(U,$J,358.3,4095,0)
 ;;=10040^^20^237^1^^^^1
 ;;^UTILITY(U,$J,358.3,4095,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4095,1,2,0)
 ;;=2^10040
 ;;^UTILITY(U,$J,358.3,4095,1,3,0)
 ;;=3^Acne Surgery
 ;;^UTILITY(U,$J,358.3,4096,0)
 ;;=10060^^20^237^4^^^^1
 ;;^UTILITY(U,$J,358.3,4096,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4096,1,2,0)
 ;;=2^10060
 ;;^UTILITY(U,$J,358.3,4096,1,3,0)
 ;;=3^I&D of abscess; simple or single
 ;;^UTILITY(U,$J,358.3,4097,0)
 ;;=10061^^20^237^3^^^^1
 ;;^UTILITY(U,$J,358.3,4097,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4097,1,2,0)
 ;;=2^10061
 ;;^UTILITY(U,$J,358.3,4097,1,3,0)
 ;;=3^I&D of abscess; complicated
 ;;^UTILITY(U,$J,358.3,4098,0)
 ;;=10080^^20^237^6^^^^1
 ;;^UTILITY(U,$J,358.3,4098,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4098,1,2,0)
 ;;=2^10080
 ;;^UTILITY(U,$J,358.3,4098,1,3,0)
 ;;=3^I&D of pilonidal cyst; simple
 ;;^UTILITY(U,$J,358.3,4099,0)
 ;;=10081^^20^237^5^^^^1
 ;;^UTILITY(U,$J,358.3,4099,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4099,1,2,0)
 ;;=2^10081
 ;;^UTILITY(U,$J,358.3,4099,1,3,0)
 ;;=3^I&D of pilonidal cyst; complicated
 ;;^UTILITY(U,$J,358.3,4100,0)
 ;;=10120^^20^237^7^^^^1
 ;;^UTILITY(U,$J,358.3,4100,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4100,1,2,0)
 ;;=2^10120
 ;;^UTILITY(U,$J,358.3,4100,1,3,0)
 ;;=3^Incision & Removal Foreign Body,SQ
 ;;^UTILITY(U,$J,358.3,4101,0)
 ;;=10121^^20^237^9^^^^1
 ;;^UTILITY(U,$J,358.3,4101,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4101,1,2,0)
 ;;=2^10121
 ;;^UTILITY(U,$J,358.3,4101,1,3,0)
 ;;=3^Removal of Foreign Body, SQ, Complicated
 ;;^UTILITY(U,$J,358.3,4102,0)
 ;;=10140^^20^237^2^^^^1
 ;;^UTILITY(U,$J,358.3,4102,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4102,1,2,0)
 ;;=2^10140
 ;;^UTILITY(U,$J,358.3,4102,1,3,0)
 ;;=3^Drainage of Hematoma/Fluid
 ;;^UTILITY(U,$J,358.3,4103,0)
 ;;=10160^^20^237^8^^^^1
 ;;^UTILITY(U,$J,358.3,4103,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4103,1,2,0)
 ;;=2^10160
 ;;^UTILITY(U,$J,358.3,4103,1,3,0)
 ;;=3^Puncture Drainage of Lesion
 ;;^UTILITY(U,$J,358.3,4104,0)
 ;;=11200^^20^238^7^^^^1
 ;;^UTILITY(U,$J,358.3,4104,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4104,1,2,0)
 ;;=2^11200
 ;;^UTILITY(U,$J,358.3,4104,1,3,0)
 ;;=3^Removal of Skin Tags,</=15 tags
 ;;^UTILITY(U,$J,358.3,4105,0)
 ;;=11201^^20^238^8^^^^1
 ;;^UTILITY(U,$J,358.3,4105,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4105,1,2,0)
 ;;=2^11201
 ;;^UTILITY(U,$J,358.3,4105,1,3,0)
 ;;=3^Removal of Skin Tags,Ea Add 10 tags
 ;;^UTILITY(U,$J,358.3,4106,0)
 ;;=11900^^20^238^4^^^^1
 ;;^UTILITY(U,$J,358.3,4106,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4106,1,2,0)
 ;;=2^11900
 ;;^UTILITY(U,$J,358.3,4106,1,3,0)
 ;;=3^INJ,Intralesional;<8 lesions
 ;;^UTILITY(U,$J,358.3,4107,0)
 ;;=11901^^20^238^5^^^^1
 ;;^UTILITY(U,$J,358.3,4107,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4107,1,2,0)
 ;;=2^11901
 ;;^UTILITY(U,$J,358.3,4107,1,3,0)
 ;;=3^INJ,intralesional;>7 lesions
 ;;^UTILITY(U,$J,358.3,4108,0)
 ;;=10030^^20^238^6^^^^1
 ;;^UTILITY(U,$J,358.3,4108,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4108,1,2,0)
 ;;=2^10030
 ;;^UTILITY(U,$J,358.3,4108,1,3,0)
 ;;=3^Image Guided Fluid Collect by Cath Percut
 ;;^UTILITY(U,$J,358.3,4109,0)
 ;;=11770^^20^238^3^^^^1
 ;;^UTILITY(U,$J,358.3,4109,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4109,1,2,0)
 ;;=2^11770
 ;;^UTILITY(U,$J,358.3,4109,1,3,0)
 ;;=3^Exc Pilonidal Cyst/Sinus;Simple
