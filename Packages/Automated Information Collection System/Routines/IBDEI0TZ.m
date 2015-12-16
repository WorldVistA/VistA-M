IBDEI0TZ ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14523,1,2,0)
 ;;=2^Drsg Absorpt <=16 sq in w/o Bdr
 ;;^UTILITY(U,$J,358.3,14523,1,3,0)
 ;;=3^A6251
 ;;^UTILITY(U,$J,358.3,14524,0)
 ;;=A6441^^75^893^26^^^^1
 ;;^UTILITY(U,$J,358.3,14524,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14524,1,2,0)
 ;;=2^Pad Bandage W >= 3 < 5/Yd
 ;;^UTILITY(U,$J,358.3,14524,1,3,0)
 ;;=3^A6441
 ;;^UTILITY(U,$J,358.3,14525,0)
 ;;=A6456^^75^893^35^^^^1
 ;;^UTILITY(U,$J,358.3,14525,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14525,1,2,0)
 ;;=2^Zinc Past Bandage W >= 3 < 5/Yd
 ;;^UTILITY(U,$J,358.3,14525,1,3,0)
 ;;=3^A6456
 ;;^UTILITY(U,$J,358.3,14526,0)
 ;;=A6010^^75^893^32^^^^1
 ;;^UTILITY(U,$J,358.3,14526,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14526,1,2,0)
 ;;=2^Wound Filler Collagen Based
 ;;^UTILITY(U,$J,358.3,14526,1,3,0)
 ;;=3^A6010
 ;;^UTILITY(U,$J,358.3,14527,0)
 ;;=Q4118^^75^893^19^^^^1
 ;;^UTILITY(U,$J,358.3,14527,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14527,1,2,0)
 ;;=2^Matristem Micromatrix
 ;;^UTILITY(U,$J,358.3,14527,1,3,0)
 ;;=3^Q4118
 ;;^UTILITY(U,$J,358.3,14528,0)
 ;;=L3560^^75^893^21^^^^1
 ;;^UTILITY(U,$J,358.3,14528,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14528,1,2,0)
 ;;=2^O Shoe Add Horseshoe Toe Tap
 ;;^UTILITY(U,$J,358.3,14528,1,3,0)
 ;;=3^L3560
 ;;^UTILITY(U,$J,358.3,14529,0)
 ;;=28190^^75^894^8^^^^1
 ;;^UTILITY(U,$J,358.3,14529,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14529,1,2,0)
 ;;=2^Removal of foreign body, foot; subcutaneous
 ;;^UTILITY(U,$J,358.3,14529,1,3,0)
 ;;=3^28190
 ;;^UTILITY(U,$J,358.3,14530,0)
 ;;=28192^^75^894^7^^^^1
 ;;^UTILITY(U,$J,358.3,14530,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14530,1,2,0)
 ;;=2^Removal of foreign body, foot; deep
 ;;^UTILITY(U,$J,358.3,14530,1,3,0)
 ;;=3^28192
 ;;^UTILITY(U,$J,358.3,14531,0)
 ;;=28193^^75^894^6^^^^1
 ;;^UTILITY(U,$J,358.3,14531,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14531,1,2,0)
 ;;=2^Removal of foreign body, foot; complicated
 ;;^UTILITY(U,$J,358.3,14531,1,3,0)
 ;;=3^28193
 ;;^UTILITY(U,$J,358.3,14532,0)
 ;;=20520^^75^894^4^^^^1
 ;;^UTILITY(U,$J,358.3,14532,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14532,1,2,0)
 ;;=2^Removal of foreign body in muscle or tendon sheath; simple
 ;;^UTILITY(U,$J,358.3,14532,1,3,0)
 ;;=3^20520
 ;;^UTILITY(U,$J,358.3,14533,0)
 ;;=20525^^75^894^5^^^^1
 ;;^UTILITY(U,$J,358.3,14533,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14533,1,2,0)
 ;;=2^Removal of foreign body in muscle or tendon sheath; deep or complicated
 ;;^UTILITY(U,$J,358.3,14533,1,3,0)
 ;;=3^20525
 ;;^UTILITY(U,$J,358.3,14534,0)
 ;;=20670^^75^894^10^^^^1
 ;;^UTILITY(U,$J,358.3,14534,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14534,1,2,0)
 ;;=2^Removal of implant; superficial (eg, buried wire, pin or rod)
 ;;^UTILITY(U,$J,358.3,14534,1,3,0)
 ;;=3^20670
 ;;^UTILITY(U,$J,358.3,14535,0)
 ;;=20680^^75^894^9^^^^1
 ;;^UTILITY(U,$J,358.3,14535,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14535,1,2,0)
 ;;=2^Removal of implant; deep (eg, buried wire, pin, screw, metal band, nail, rod or plate)
 ;;^UTILITY(U,$J,358.3,14535,1,3,0)
 ;;=3^20680
 ;;^UTILITY(U,$J,358.3,14536,0)
 ;;=S0630^^75^894^3^^^^1
 ;;^UTILITY(U,$J,358.3,14536,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14536,1,2,0)
 ;;=2^Removal of Sutures
 ;;^UTILITY(U,$J,358.3,14536,1,3,0)
 ;;=3^S0630
 ;;^UTILITY(U,$J,358.3,14537,0)
 ;;=28805^^75^895^1^^^^1
 ;;^UTILITY(U,$J,358.3,14537,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14537,1,2,0)
 ;;=2^Amputation, foot; transmetatarsal
 ;;^UTILITY(U,$J,358.3,14537,1,3,0)
 ;;=3^28805
 ;;^UTILITY(U,$J,358.3,14538,0)
 ;;=28810^^75^895^2^^^^1
