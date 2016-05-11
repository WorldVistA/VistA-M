IBDEI1V1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31607,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31607,1,2,0)
 ;;=2^Drsg Collagen <=16 sq in
 ;;^UTILITY(U,$J,358.3,31607,1,3,0)
 ;;=3^A6021
 ;;^UTILITY(U,$J,358.3,31608,0)
 ;;=A6196^^125^1600^8^^^^1
 ;;^UTILITY(U,$J,358.3,31608,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31608,1,2,0)
 ;;=2^Drsg Alginate <=16 sq in
 ;;^UTILITY(U,$J,358.3,31608,1,3,0)
 ;;=3^A6196
 ;;^UTILITY(U,$J,358.3,31609,0)
 ;;=A6197^^125^1600^9^^^^1
 ;;^UTILITY(U,$J,358.3,31609,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31609,1,2,0)
 ;;=2^Drsg Alginate >16 <=48 sq in
 ;;^UTILITY(U,$J,358.3,31609,1,3,0)
 ;;=3^A6197
 ;;^UTILITY(U,$J,358.3,31610,0)
 ;;=A6209^^125^1600^11^^^^1
 ;;^UTILITY(U,$J,358.3,31610,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31610,1,2,0)
 ;;=2^Drsg Foam <=16 sq in w/o Bdr
 ;;^UTILITY(U,$J,358.3,31610,1,3,0)
 ;;=3^A6209
 ;;^UTILITY(U,$J,358.3,31611,0)
 ;;=A6251^^125^1600^7^^^^1
 ;;^UTILITY(U,$J,358.3,31611,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31611,1,2,0)
 ;;=2^Drsg Absorpt <=16 sq in w/o Bdr
 ;;^UTILITY(U,$J,358.3,31611,1,3,0)
 ;;=3^A6251
 ;;^UTILITY(U,$J,358.3,31612,0)
 ;;=A6441^^125^1600^26^^^^1
 ;;^UTILITY(U,$J,358.3,31612,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31612,1,2,0)
 ;;=2^Pad Bandage W >= 3 < 5/Yd
 ;;^UTILITY(U,$J,358.3,31612,1,3,0)
 ;;=3^A6441
 ;;^UTILITY(U,$J,358.3,31613,0)
 ;;=A6456^^125^1600^35^^^^1
 ;;^UTILITY(U,$J,358.3,31613,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31613,1,2,0)
 ;;=2^Zinc Past Bandage W >= 3 < 5/Yd
 ;;^UTILITY(U,$J,358.3,31613,1,3,0)
 ;;=3^A6456
 ;;^UTILITY(U,$J,358.3,31614,0)
 ;;=A6010^^125^1600^32^^^^1
 ;;^UTILITY(U,$J,358.3,31614,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31614,1,2,0)
 ;;=2^Wound Filler Collagen Based
 ;;^UTILITY(U,$J,358.3,31614,1,3,0)
 ;;=3^A6010
 ;;^UTILITY(U,$J,358.3,31615,0)
 ;;=Q4118^^125^1600^19^^^^1
 ;;^UTILITY(U,$J,358.3,31615,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31615,1,2,0)
 ;;=2^Matristem Micromatrix
 ;;^UTILITY(U,$J,358.3,31615,1,3,0)
 ;;=3^Q4118
 ;;^UTILITY(U,$J,358.3,31616,0)
 ;;=L3560^^125^1600^21^^^^1
 ;;^UTILITY(U,$J,358.3,31616,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31616,1,2,0)
 ;;=2^O Shoe Add Horseshoe Toe Tap
 ;;^UTILITY(U,$J,358.3,31616,1,3,0)
 ;;=3^L3560
 ;;^UTILITY(U,$J,358.3,31617,0)
 ;;=28190^^125^1601^8^^^^1
 ;;^UTILITY(U,$J,358.3,31617,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31617,1,2,0)
 ;;=2^Removal of foreign body, foot; subcutaneous
 ;;^UTILITY(U,$J,358.3,31617,1,3,0)
 ;;=3^28190
 ;;^UTILITY(U,$J,358.3,31618,0)
 ;;=28192^^125^1601^7^^^^1
 ;;^UTILITY(U,$J,358.3,31618,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31618,1,2,0)
 ;;=2^Removal of foreign body, foot; deep
 ;;^UTILITY(U,$J,358.3,31618,1,3,0)
 ;;=3^28192
 ;;^UTILITY(U,$J,358.3,31619,0)
 ;;=28193^^125^1601^6^^^^1
 ;;^UTILITY(U,$J,358.3,31619,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31619,1,2,0)
 ;;=2^Removal of foreign body, foot; complicated
 ;;^UTILITY(U,$J,358.3,31619,1,3,0)
 ;;=3^28193
 ;;^UTILITY(U,$J,358.3,31620,0)
 ;;=20520^^125^1601^4^^^^1
 ;;^UTILITY(U,$J,358.3,31620,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31620,1,2,0)
 ;;=2^Removal of foreign body in muscle or tendon sheath; simple
 ;;^UTILITY(U,$J,358.3,31620,1,3,0)
 ;;=3^20520
 ;;^UTILITY(U,$J,358.3,31621,0)
 ;;=20525^^125^1601^5^^^^1
 ;;^UTILITY(U,$J,358.3,31621,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31621,1,2,0)
 ;;=2^Removal of foreign body in muscle or tendon sheath; deep or complicated
 ;;^UTILITY(U,$J,358.3,31621,1,3,0)
 ;;=3^20525
 ;;^UTILITY(U,$J,358.3,31622,0)
 ;;=20670^^125^1601^10^^^^1
 ;;^UTILITY(U,$J,358.3,31622,1,0)
 ;;=^358.31IA^3^2
