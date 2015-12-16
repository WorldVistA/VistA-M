IBDEI0CF ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5540,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5540,1,2,0)
 ;;=2^13133
 ;;^UTILITY(U,$J,358.3,5540,1,3,0)
 ;;=3^Complex Repair Nk/Hd/Ft;Ea Addl 5 cm
 ;;^UTILITY(U,$J,358.3,5541,0)
 ;;=13100^^26^356^1^^^^1
 ;;^UTILITY(U,$J,358.3,5541,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5541,1,2,0)
 ;;=2^13100
 ;;^UTILITY(U,$J,358.3,5541,1,3,0)
 ;;=3^Complex Repair Trunk;1.1 to 2.5 cm
 ;;^UTILITY(U,$J,358.3,5542,0)
 ;;=13101^^26^356^2^^^^1
 ;;^UTILITY(U,$J,358.3,5542,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5542,1,2,0)
 ;;=2^13101
 ;;^UTILITY(U,$J,358.3,5542,1,3,0)
 ;;=3^Complex Repair Trunk;2.6 to 7.5 cm
 ;;^UTILITY(U,$J,358.3,5543,0)
 ;;=13102^^26^356^3^^^^1
 ;;^UTILITY(U,$J,358.3,5543,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5543,1,2,0)
 ;;=2^13102
 ;;^UTILITY(U,$J,358.3,5543,1,3,0)
 ;;=3^Complex Repair Trunk;Ea Addl 5 cm
 ;;^UTILITY(U,$J,358.3,5544,0)
 ;;=14040^^26^357^1^^^^1
 ;;^UTILITY(U,$J,358.3,5544,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5544,1,2,0)
 ;;=2^14040
 ;;^UTILITY(U,$J,358.3,5544,1,3,0)
 ;;=3^Tissue Rearrangement,Face/Nk/Hd/Ft,Up to 10.0 sq cm
 ;;^UTILITY(U,$J,358.3,5545,0)
 ;;=14041^^26^357^2^^^^1
 ;;^UTILITY(U,$J,358.3,5545,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5545,1,2,0)
 ;;=2^14041
 ;;^UTILITY(U,$J,358.3,5545,1,3,0)
 ;;=3^Tissue Rearrangement,Face/Nk/Hd/Ft,10.1 to 30.0 sq cm
 ;;^UTILITY(U,$J,358.3,5546,0)
 ;;=14020^^26^358^1^^^^1
 ;;^UTILITY(U,$J,358.3,5546,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5546,1,2,0)
 ;;=2^14020
 ;;^UTILITY(U,$J,358.3,5546,1,3,0)
 ;;=3^Tissue Rearrangement,S/A/L,Up to 10.0 sq cm
 ;;^UTILITY(U,$J,358.3,5547,0)
 ;;=14021^^26^358^2^^^^1
 ;;^UTILITY(U,$J,358.3,5547,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5547,1,2,0)
 ;;=2^14021
 ;;^UTILITY(U,$J,358.3,5547,1,3,0)
 ;;=3^Tissue Rearrangement,S/A/L,10.1 to 30.0 sq cm
 ;;^UTILITY(U,$J,358.3,5548,0)
 ;;=14000^^26^359^1^^^^1
 ;;^UTILITY(U,$J,358.3,5548,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5548,1,2,0)
 ;;=2^14000
 ;;^UTILITY(U,$J,358.3,5548,1,3,0)
 ;;=3^Tissue Rearrangement,Trunk,Up to 10.0 sq cm
 ;;^UTILITY(U,$J,358.3,5549,0)
 ;;=14001^^26^359^2^^^^1
 ;;^UTILITY(U,$J,358.3,5549,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5549,1,2,0)
 ;;=2^14001
 ;;^UTILITY(U,$J,358.3,5549,1,3,0)
 ;;=3^Tissue Rearrangement,Trunk,10.1 to 30.0 sq cm
 ;;^UTILITY(U,$J,358.3,5550,0)
 ;;=13120^^26^360^1^^^^1
 ;;^UTILITY(U,$J,358.3,5550,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5550,1,2,0)
 ;;=2^13120
 ;;^UTILITY(U,$J,358.3,5550,1,3,0)
 ;;=3^Complex Repair Scalp;1.1 to 2.5 cm
 ;;^UTILITY(U,$J,358.3,5551,0)
 ;;=13121^^26^360^2^^^^1
 ;;^UTILITY(U,$J,358.3,5551,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5551,1,2,0)
 ;;=2^13121
 ;;^UTILITY(U,$J,358.3,5551,1,3,0)
 ;;=3^Complex Repair Scalp;2.6 to 7.5 cm
 ;;^UTILITY(U,$J,358.3,5552,0)
 ;;=13122^^26^360^3^^^^1
 ;;^UTILITY(U,$J,358.3,5552,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5552,1,2,0)
 ;;=2^13122
 ;;^UTILITY(U,$J,358.3,5552,1,3,0)
 ;;=3^Complex Repair Scalp;Ea Addl 5 cm
 ;;^UTILITY(U,$J,358.3,5553,0)
 ;;=14060^^26^361^1^^^^1
 ;;^UTILITY(U,$J,358.3,5553,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5553,1,2,0)
 ;;=2^14060
 ;;^UTILITY(U,$J,358.3,5553,1,3,0)
 ;;=3^Tissue Rearrangement Eyelid,10sq cm or less
 ;;^UTILITY(U,$J,358.3,5554,0)
 ;;=14061^^26^361^2^^^^1
 ;;^UTILITY(U,$J,358.3,5554,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5554,1,2,0)
 ;;=2^14061
 ;;^UTILITY(U,$J,358.3,5554,1,3,0)
 ;;=3^Tissue Rearrangement Eyelid,10.1 to 30.0sq cm
 ;;^UTILITY(U,$J,358.3,5555,0)
 ;;=67810^^26^362^2^^^^1
 ;;^UTILITY(U,$J,358.3,5555,1,0)
 ;;=^358.31IA^3^2
