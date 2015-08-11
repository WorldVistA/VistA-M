IBDEI1C0 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23881,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; scalp, neck, hands, feet, genitalia- 0.6 to 1.0 cm 
 ;;^UTILITY(U,$J,358.3,23881,1,3,0)
 ;;=3^11306
 ;;^UTILITY(U,$J,358.3,23882,0)
 ;;=11307^^142^1482^7
 ;;^UTILITY(U,$J,358.3,23882,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23882,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; scalp, neck, hands, feet, genitalia- 1.1 to 2.0 cm
 ;;^UTILITY(U,$J,358.3,23882,1,3,0)
 ;;=3^11307
 ;;^UTILITY(U,$J,358.3,23883,0)
 ;;=11308^^142^1482^8
 ;;^UTILITY(U,$J,358.3,23883,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23883,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; scalp, neck, hands, feet, genitalia- over 2.0 cm
 ;;^UTILITY(U,$J,358.3,23883,1,3,0)
 ;;=3^11308
 ;;^UTILITY(U,$J,358.3,23884,0)
 ;;=11303^^142^1482^4^^^^1
 ;;^UTILITY(U,$J,358.3,23884,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23884,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; trunk, arms or legs- over 2.0 cm
 ;;^UTILITY(U,$J,358.3,23884,1,3,0)
 ;;=3^11303
 ;;^UTILITY(U,$J,358.3,23885,0)
 ;;=11719^^142^1483^1^^^^1
 ;;^UTILITY(U,$J,358.3,23885,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23885,1,2,0)
 ;;=2^Trimming Nondystrophic Nails, any number
 ;;^UTILITY(U,$J,358.3,23885,1,3,0)
 ;;=3^11719
 ;;^UTILITY(U,$J,358.3,23886,0)
 ;;=G0127^^142^1483^2^^^^1
 ;;^UTILITY(U,$J,358.3,23886,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23886,1,2,0)
 ;;=2^Trimming Dystrophic Nails, any number
 ;;^UTILITY(U,$J,358.3,23886,1,3,0)
 ;;=3^G0127
 ;;^UTILITY(U,$J,358.3,23887,0)
 ;;=11720^^142^1483^3^^^^1
 ;;^UTILITY(U,$J,358.3,23887,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23887,1,2,0)
 ;;=2^Debridement of Nail(s)any method(s); 1-5 
 ;;^UTILITY(U,$J,358.3,23887,1,3,0)
 ;;=3^11720
 ;;^UTILITY(U,$J,358.3,23888,0)
 ;;=11721^^142^1483^4^^^^1
 ;;^UTILITY(U,$J,358.3,23888,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23888,1,2,0)
 ;;=2^Debridement of Nails any method; 6 or more
 ;;^UTILITY(U,$J,358.3,23888,1,3,0)
 ;;=3^11721
 ;;^UTILITY(U,$J,358.3,23889,0)
 ;;=11730^^142^1483^5^^^^1
 ;;^UTILITY(U,$J,358.3,23889,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23889,1,2,0)
 ;;=2^Avulsion of Nail Plate,part/comp,single
 ;;^UTILITY(U,$J,358.3,23889,1,3,0)
 ;;=3^11730
 ;;^UTILITY(U,$J,358.3,23890,0)
 ;;=11732^^142^1483^6^^^^1
 ;;^UTILITY(U,$J,358.3,23890,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23890,1,2,0)
 ;;=2^Avulsion of Nail Plate,part/comp,ea addl nail
 ;;^UTILITY(U,$J,358.3,23890,1,3,0)
 ;;=3^11732
 ;;^UTILITY(U,$J,358.3,23891,0)
 ;;=11740^^142^1483^7^^^^1
 ;;^UTILITY(U,$J,358.3,23891,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23891,1,2,0)
 ;;=2^Evacuation Subungual Hematoma
 ;;^UTILITY(U,$J,358.3,23891,1,3,0)
 ;;=3^11740
 ;;^UTILITY(U,$J,358.3,23892,0)
 ;;=11750^^142^1483^8^^^^1
 ;;^UTILITY(U,$J,358.3,23892,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23892,1,2,0)
 ;;=2^Excision of Nail and Nail Matrx, partial or complete, for permanent removal
 ;;^UTILITY(U,$J,358.3,23892,1,3,0)
 ;;=3^11750
 ;;^UTILITY(U,$J,358.3,23893,0)
 ;;=11755^^142^1483^9^^^^1
 ;;^UTILITY(U,$J,358.3,23893,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23893,1,2,0)
 ;;=2^Biopsy of Nail Unit
 ;;^UTILITY(U,$J,358.3,23893,1,3,0)
 ;;=3^11755
 ;;^UTILITY(U,$J,358.3,23894,0)
 ;;=11760^^142^1483^10^^^^1
 ;;^UTILITY(U,$J,358.3,23894,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23894,1,2,0)
 ;;=2^Repair of Nail Bed
 ;;^UTILITY(U,$J,358.3,23894,1,3,0)
 ;;=3^11760
 ;;^UTILITY(U,$J,358.3,23895,0)
 ;;=11765^^142^1483^11^^^^1
 ;;^UTILITY(U,$J,358.3,23895,1,0)
 ;;=^358.31IA^3^2
