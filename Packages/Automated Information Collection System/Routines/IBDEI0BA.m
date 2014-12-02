IBDEI0BA ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5305,1,2,0)
 ;;=2^96912
 ;;^UTILITY(U,$J,358.3,5305,1,3,0)
 ;;=3^Photochemotherapy w/ UV-A
 ;;^UTILITY(U,$J,358.3,5306,0)
 ;;=96567^^40^455^6^^^^1
 ;;^UTILITY(U,$J,358.3,5306,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5306,1,2,0)
 ;;=2^96567
 ;;^UTILITY(U,$J,358.3,5306,1,3,0)
 ;;=3^Photodynamic Tx Skin
 ;;^UTILITY(U,$J,358.3,5307,0)
 ;;=96920^^40^455^1^^^^1
 ;;^UTILITY(U,$J,358.3,5307,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5307,1,2,0)
 ;;=2^96920
 ;;^UTILITY(U,$J,358.3,5307,1,3,0)
 ;;=3^Laser Tx Skin < 250 sq cm
 ;;^UTILITY(U,$J,358.3,5308,0)
 ;;=96921^^40^455^2^^^^1
 ;;^UTILITY(U,$J,358.3,5308,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5308,1,2,0)
 ;;=2^96921
 ;;^UTILITY(U,$J,358.3,5308,1,3,0)
 ;;=3^Laser Tx Skin 250-500 sq cm
 ;;^UTILITY(U,$J,358.3,5309,0)
 ;;=96922^^40^455^3^^^^1
 ;;^UTILITY(U,$J,358.3,5309,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5309,1,2,0)
 ;;=2^96922
 ;;^UTILITY(U,$J,358.3,5309,1,3,0)
 ;;=3^Laser Tx Skin > 500 sq cm
 ;;^UTILITY(U,$J,358.3,5310,0)
 ;;=13151^^40^456^1^^^^1
 ;;^UTILITY(U,$J,358.3,5310,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5310,1,2,0)
 ;;=2^13151
 ;;^UTILITY(U,$J,358.3,5310,1,3,0)
 ;;=3^Complex Repair Face;1.1 to 2.5 cm
 ;;^UTILITY(U,$J,358.3,5311,0)
 ;;=13152^^40^456^2^^^^1
 ;;^UTILITY(U,$J,358.3,5311,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5311,1,2,0)
 ;;=2^13152
 ;;^UTILITY(U,$J,358.3,5311,1,3,0)
 ;;=3^Complex Repair Face;2.6 to 7.5 cm
 ;;^UTILITY(U,$J,358.3,5312,0)
 ;;=13153^^40^456^3^^^^1
 ;;^UTILITY(U,$J,358.3,5312,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5312,1,2,0)
 ;;=2^13153
 ;;^UTILITY(U,$J,358.3,5312,1,3,0)
 ;;=3^Complex Repair Face;Ea Addl 5 cm
 ;;^UTILITY(U,$J,358.3,5313,0)
 ;;=13131^^40^457^1^^^^1
 ;;^UTILITY(U,$J,358.3,5313,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5313,1,2,0)
 ;;=2^13131
 ;;^UTILITY(U,$J,358.3,5313,1,3,0)
 ;;=3^Complex Repair Nk/Hd/Ft;1.1 to 2.5 cm
 ;;^UTILITY(U,$J,358.3,5314,0)
 ;;=13132^^40^457^2^^^^1
 ;;^UTILITY(U,$J,358.3,5314,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5314,1,2,0)
 ;;=2^13132
 ;;^UTILITY(U,$J,358.3,5314,1,3,0)
 ;;=3^Complex Repair Nk/Hd/Ft;2.6 to 7.5 cm
 ;;^UTILITY(U,$J,358.3,5315,0)
 ;;=13133^^40^457^3^^^^1
 ;;^UTILITY(U,$J,358.3,5315,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5315,1,2,0)
 ;;=2^13133
 ;;^UTILITY(U,$J,358.3,5315,1,3,0)
 ;;=3^Complex Repair Nk/Hd/Ft;Ea Addl 5 cm
 ;;^UTILITY(U,$J,358.3,5316,0)
 ;;=13100^^40^458^1^^^^1
 ;;^UTILITY(U,$J,358.3,5316,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5316,1,2,0)
 ;;=2^13100
 ;;^UTILITY(U,$J,358.3,5316,1,3,0)
 ;;=3^Complex Repair Trunk;1.1 to 2.5 cm
 ;;^UTILITY(U,$J,358.3,5317,0)
 ;;=13101^^40^458^2^^^^1
 ;;^UTILITY(U,$J,358.3,5317,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5317,1,2,0)
 ;;=2^13101
 ;;^UTILITY(U,$J,358.3,5317,1,3,0)
 ;;=3^Complex Repair Trunk;2.6 to 7.5 cm
 ;;^UTILITY(U,$J,358.3,5318,0)
 ;;=13102^^40^458^3^^^^1
 ;;^UTILITY(U,$J,358.3,5318,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5318,1,2,0)
 ;;=2^13102
 ;;^UTILITY(U,$J,358.3,5318,1,3,0)
 ;;=3^Complex Repair Trunk;Ea Addl 5 cm
 ;;^UTILITY(U,$J,358.3,5319,0)
 ;;=14040^^40^459^1^^^^1
 ;;^UTILITY(U,$J,358.3,5319,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5319,1,2,0)
 ;;=2^14040
 ;;^UTILITY(U,$J,358.3,5319,1,3,0)
 ;;=3^Skin Tissue Rearrangement,Face/Nk/Hd/Ft,Up to 10.0 sq cm
 ;;^UTILITY(U,$J,358.3,5320,0)
 ;;=14041^^40^459^2^^^^1
 ;;^UTILITY(U,$J,358.3,5320,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5320,1,2,0)
 ;;=2^14041
 ;;^UTILITY(U,$J,358.3,5320,1,3,0)
 ;;=3^Skin Tissue Rearrangement,Face/Nk/Hd/Ft,10.1 to 30.0 sq cm
