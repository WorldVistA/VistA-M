IBDEI0TD ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14215,0)
 ;;=11305^^75^873^1
 ;;^UTILITY(U,$J,358.3,14215,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14215,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Scalp,Neck,Hand;0.5cm or less
 ;;^UTILITY(U,$J,358.3,14215,1,3,0)
 ;;=3^11305
 ;;^UTILITY(U,$J,358.3,14216,0)
 ;;=11306^^75^873^2
 ;;^UTILITY(U,$J,358.3,14216,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14216,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Scalp,Neck,Hand;0.6cm-1.0cm
 ;;^UTILITY(U,$J,358.3,14216,1,3,0)
 ;;=3^11306
 ;;^UTILITY(U,$J,358.3,14217,0)
 ;;=11307^^75^873^3
 ;;^UTILITY(U,$J,358.3,14217,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14217,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Scalp,Neck,Hand;1.1cm-2.0cm
 ;;^UTILITY(U,$J,358.3,14217,1,3,0)
 ;;=3^11307
 ;;^UTILITY(U,$J,358.3,14218,0)
 ;;=11308^^75^873^4
 ;;^UTILITY(U,$J,358.3,14218,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14218,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Scalp,Neck,Hand > 2.0cm
 ;;^UTILITY(U,$J,358.3,14218,1,3,0)
 ;;=3^11308
 ;;^UTILITY(U,$J,358.3,14219,0)
 ;;=11303^^75^873^8^^^^1
 ;;^UTILITY(U,$J,358.3,14219,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14219,1,2,0)
 ;;=2^Shaving of Epidermal Lesion,Single-Trunk,Arms,Legs;> 2.0cm
 ;;^UTILITY(U,$J,358.3,14219,1,3,0)
 ;;=3^11303
 ;;^UTILITY(U,$J,358.3,14220,0)
 ;;=11719^^75^874^10^^^^1
 ;;^UTILITY(U,$J,358.3,14220,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14220,1,2,0)
 ;;=2^Trimming Nondystrophic Nails, any number
 ;;^UTILITY(U,$J,358.3,14220,1,3,0)
 ;;=3^11719
 ;;^UTILITY(U,$J,358.3,14221,0)
 ;;=G0127^^75^874^9^^^^1
 ;;^UTILITY(U,$J,358.3,14221,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14221,1,2,0)
 ;;=2^Trimming Dystrophic Nails, any number
 ;;^UTILITY(U,$J,358.3,14221,1,3,0)
 ;;=3^G0127
 ;;^UTILITY(U,$J,358.3,14222,0)
 ;;=11720^^75^874^4^^^^1
 ;;^UTILITY(U,$J,358.3,14222,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14222,1,2,0)
 ;;=2^Debridement of Nail(s)any method(s); 1-5 
 ;;^UTILITY(U,$J,358.3,14222,1,3,0)
 ;;=3^11720
 ;;^UTILITY(U,$J,358.3,14223,0)
 ;;=11721^^75^874^5^^^^1
 ;;^UTILITY(U,$J,358.3,14223,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14223,1,2,0)
 ;;=2^Debridement of Nails any method; 6 or more
 ;;^UTILITY(U,$J,358.3,14223,1,3,0)
 ;;=3^11721
 ;;^UTILITY(U,$J,358.3,14224,0)
 ;;=11730^^75^874^1^^^^1
 ;;^UTILITY(U,$J,358.3,14224,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14224,1,2,0)
 ;;=2^Avulsion of Nail Plate,part/comp,single
 ;;^UTILITY(U,$J,358.3,14224,1,3,0)
 ;;=3^11730
 ;;^UTILITY(U,$J,358.3,14225,0)
 ;;=11732^^75^874^2^^^^1
 ;;^UTILITY(U,$J,358.3,14225,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14225,1,2,0)
 ;;=2^Avulsion of Nail Plate,part/comp,ea addl nail
 ;;^UTILITY(U,$J,358.3,14225,1,3,0)
 ;;=3^11732
 ;;^UTILITY(U,$J,358.3,14226,0)
 ;;=11740^^75^874^6^^^^1
 ;;^UTILITY(U,$J,358.3,14226,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14226,1,2,0)
 ;;=2^Evacuation Subungual Hematoma
 ;;^UTILITY(U,$J,358.3,14226,1,3,0)
 ;;=3^11740
 ;;^UTILITY(U,$J,358.3,14227,0)
 ;;=11750^^75^874^7^^^^1
 ;;^UTILITY(U,$J,358.3,14227,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14227,1,2,0)
 ;;=2^Excision of Nail and Nail Matrx, partial or complete, for permanent removal
 ;;^UTILITY(U,$J,358.3,14227,1,3,0)
 ;;=3^11750
 ;;^UTILITY(U,$J,358.3,14228,0)
 ;;=11755^^75^874^3^^^^1
 ;;^UTILITY(U,$J,358.3,14228,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14228,1,2,0)
 ;;=2^Biopsy of Nail Unit
 ;;^UTILITY(U,$J,358.3,14228,1,3,0)
 ;;=3^11755
 ;;^UTILITY(U,$J,358.3,14229,0)
 ;;=11760^^75^874^8^^^^1
 ;;^UTILITY(U,$J,358.3,14229,1,0)
 ;;=^358.31IA^3^2
