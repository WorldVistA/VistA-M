IBDEI0J5 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8370,1,3,0)
 ;;=3^Exc Ben Lesion Tnk/Arm/Leg,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,8371,0)
 ;;=11406^^66^538^6^^^^1
 ;;^UTILITY(U,$J,358.3,8371,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8371,1,2,0)
 ;;=2^11406
 ;;^UTILITY(U,$J,358.3,8371,1,3,0)
 ;;=3^Exc Ben Lesion Tnk/Arm/Leg > 4.0cm
 ;;^UTILITY(U,$J,358.3,8372,0)
 ;;=11600^^66^539^1^^^^1
 ;;^UTILITY(U,$J,358.3,8372,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8372,1,2,0)
 ;;=2^11600
 ;;^UTILITY(U,$J,358.3,8372,1,3,0)
 ;;=3^Exc Mal Lesion Tnk/Arm/Leg,0.5cm or <
 ;;^UTILITY(U,$J,358.3,8373,0)
 ;;=11601^^66^539^2^^^^1
 ;;^UTILITY(U,$J,358.3,8373,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8373,1,2,0)
 ;;=2^11601
 ;;^UTILITY(U,$J,358.3,8373,1,3,0)
 ;;=3^Exc Mal Lesion Tnk/Arm/Leg,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,8374,0)
 ;;=11602^^66^539^3^^^^1
 ;;^UTILITY(U,$J,358.3,8374,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8374,1,2,0)
 ;;=2^11602
 ;;^UTILITY(U,$J,358.3,8374,1,3,0)
 ;;=3^Exc Mal Lesion Tnk/Arm/Leg,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,8375,0)
 ;;=11603^^66^539^4^^^^1
 ;;^UTILITY(U,$J,358.3,8375,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8375,1,2,0)
 ;;=2^11603
 ;;^UTILITY(U,$J,358.3,8375,1,3,0)
 ;;=3^Exc Mal Lesion Tnk/Arm/Leg,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,8376,0)
 ;;=11604^^66^539^5^^^^1
 ;;^UTILITY(U,$J,358.3,8376,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8376,1,2,0)
 ;;=2^11604
 ;;^UTILITY(U,$J,358.3,8376,1,3,0)
 ;;=3^Exc Mal Lesion Tnk/Arm/Leg,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,8377,0)
 ;;=11606^^66^539^6^^^^1
 ;;^UTILITY(U,$J,358.3,8377,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8377,1,2,0)
 ;;=2^11606
 ;;^UTILITY(U,$J,358.3,8377,1,3,0)
 ;;=3^Exc Mal Lesion Tnk/Arm/Leg > 4.0cm
 ;;^UTILITY(U,$J,358.3,8378,0)
 ;;=10040^^66^540^1^^^^1
 ;;^UTILITY(U,$J,358.3,8378,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8378,1,2,0)
 ;;=2^10040
 ;;^UTILITY(U,$J,358.3,8378,1,3,0)
 ;;=3^Acne Surgery
 ;;^UTILITY(U,$J,358.3,8379,0)
 ;;=10060^^66^540^4^^^^1
 ;;^UTILITY(U,$J,358.3,8379,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8379,1,2,0)
 ;;=2^10060
 ;;^UTILITY(U,$J,358.3,8379,1,3,0)
 ;;=3^I&D of abscess; simple or single
 ;;^UTILITY(U,$J,358.3,8380,0)
 ;;=10061^^66^540^3^^^^1
 ;;^UTILITY(U,$J,358.3,8380,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8380,1,2,0)
 ;;=2^10061
 ;;^UTILITY(U,$J,358.3,8380,1,3,0)
 ;;=3^I&D of abscess; complicated
 ;;^UTILITY(U,$J,358.3,8381,0)
 ;;=10080^^66^540^6^^^^1
 ;;^UTILITY(U,$J,358.3,8381,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8381,1,2,0)
 ;;=2^10080
 ;;^UTILITY(U,$J,358.3,8381,1,3,0)
 ;;=3^I&D of pilonidal cyst; simple
 ;;^UTILITY(U,$J,358.3,8382,0)
 ;;=10081^^66^540^5^^^^1
 ;;^UTILITY(U,$J,358.3,8382,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8382,1,2,0)
 ;;=2^10081
 ;;^UTILITY(U,$J,358.3,8382,1,3,0)
 ;;=3^I&D of pilonidal cyst; complicated
 ;;^UTILITY(U,$J,358.3,8383,0)
 ;;=10120^^66^540^7^^^^1
 ;;^UTILITY(U,$J,358.3,8383,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8383,1,2,0)
 ;;=2^10120
 ;;^UTILITY(U,$J,358.3,8383,1,3,0)
 ;;=3^Incision & Removal Foreign Body,SQ
 ;;^UTILITY(U,$J,358.3,8384,0)
 ;;=10121^^66^540^9^^^^1
 ;;^UTILITY(U,$J,358.3,8384,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8384,1,2,0)
 ;;=2^10121
 ;;^UTILITY(U,$J,358.3,8384,1,3,0)
 ;;=3^Removal of Foreign Body, SQ, Complicated
 ;;^UTILITY(U,$J,358.3,8385,0)
 ;;=10140^^66^540^2^^^^1
 ;;^UTILITY(U,$J,358.3,8385,1,0)
 ;;=^358.31IA^3^2
