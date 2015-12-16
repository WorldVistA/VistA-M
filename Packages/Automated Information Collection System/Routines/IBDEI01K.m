IBDEI01K ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,176,1,4,0)
 ;;=4^T45.1X1A
 ;;^UTILITY(U,$J,358.3,176,2)
 ;;=^5051014
 ;;^UTILITY(U,$J,358.3,177,0)
 ;;=T45.1X1D^^1^10^32
 ;;^UTILITY(U,$J,358.3,177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,177,1,3,0)
 ;;=3^Poisoning by antineopl and immunosup drugs, acc, subs
 ;;^UTILITY(U,$J,358.3,177,1,4,0)
 ;;=4^T45.1X1D
 ;;^UTILITY(U,$J,358.3,177,2)
 ;;=^5051015
 ;;^UTILITY(U,$J,358.3,178,0)
 ;;=T45.1X1S^^1^10^33
 ;;^UTILITY(U,$J,358.3,178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,178,1,3,0)
 ;;=3^Poisoning by antineopl and immunosup drugs, acc, sequela
 ;;^UTILITY(U,$J,358.3,178,1,4,0)
 ;;=4^T45.1X1S
 ;;^UTILITY(U,$J,358.3,178,2)
 ;;=^5051016
 ;;^UTILITY(U,$J,358.3,179,0)
 ;;=T45.1X3A^^1^10^34
 ;;^UTILITY(U,$J,358.3,179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,179,1,3,0)
 ;;=3^Poisoning by antineopl and immunosup drugs, assault, init
 ;;^UTILITY(U,$J,358.3,179,1,4,0)
 ;;=4^T45.1X3A
 ;;^UTILITY(U,$J,358.3,179,2)
 ;;=^5051020
 ;;^UTILITY(U,$J,358.3,180,0)
 ;;=T45.1X3D^^1^10^35
 ;;^UTILITY(U,$J,358.3,180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,180,1,3,0)
 ;;=3^Poisoning by antineopl and immunosup drugs, assault, subs
 ;;^UTILITY(U,$J,358.3,180,1,4,0)
 ;;=4^T45.1X3D
 ;;^UTILITY(U,$J,358.3,180,2)
 ;;=^5051021
 ;;^UTILITY(U,$J,358.3,181,0)
 ;;=T45.1X3S^^1^10^36
 ;;^UTILITY(U,$J,358.3,181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,181,1,3,0)
 ;;=3^Poisoning by antineopl and immunosup drugs, assault, sequela
 ;;^UTILITY(U,$J,358.3,181,1,4,0)
 ;;=4^T45.1X3S
 ;;^UTILITY(U,$J,358.3,181,2)
 ;;=^5051022
 ;;^UTILITY(U,$J,358.3,182,0)
 ;;=T45.1X2A^^1^10^37
 ;;^UTILITY(U,$J,358.3,182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,182,1,3,0)
 ;;=3^Poisoning by antineopl and immunosup drugs, self-harm, init
 ;;^UTILITY(U,$J,358.3,182,1,4,0)
 ;;=4^T45.1X2A
 ;;^UTILITY(U,$J,358.3,182,2)
 ;;=^5051017
 ;;^UTILITY(U,$J,358.3,183,0)
 ;;=T45.1X2D^^1^10^38
 ;;^UTILITY(U,$J,358.3,183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,183,1,3,0)
 ;;=3^Poisoning by antineopl and immunosup drugs, self-harm, subs
 ;;^UTILITY(U,$J,358.3,183,1,4,0)
 ;;=4^T45.1X2D
 ;;^UTILITY(U,$J,358.3,183,2)
 ;;=^5051018
 ;;^UTILITY(U,$J,358.3,184,0)
 ;;=T45.1X2S^^1^10^18
 ;;^UTILITY(U,$J,358.3,184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,184,1,3,0)
 ;;=3^Poisn by antineopl and immunosup drugs, self-harm, sequela
 ;;^UTILITY(U,$J,358.3,184,1,4,0)
 ;;=4^T45.1X2S
 ;;^UTILITY(U,$J,358.3,184,2)
 ;;=^5051019
 ;;^UTILITY(U,$J,358.3,185,0)
 ;;=T45.1X4A^^1^10^39
 ;;^UTILITY(U,$J,358.3,185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,185,1,3,0)
 ;;=3^Poisoning by antineopl and immunosup drugs, undet, init
 ;;^UTILITY(U,$J,358.3,185,1,4,0)
 ;;=4^T45.1X4A
 ;;^UTILITY(U,$J,358.3,185,2)
 ;;=^5051023
 ;;^UTILITY(U,$J,358.3,186,0)
 ;;=T45.1X4D^^1^10^40
 ;;^UTILITY(U,$J,358.3,186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,186,1,3,0)
 ;;=3^Poisoning by antineopl and immunosup drugs, undet, subs
 ;;^UTILITY(U,$J,358.3,186,1,4,0)
 ;;=4^T45.1X4D
 ;;^UTILITY(U,$J,358.3,186,2)
 ;;=^5051024
 ;;^UTILITY(U,$J,358.3,187,0)
 ;;=T45.1X4S^^1^10^41
 ;;^UTILITY(U,$J,358.3,187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,187,1,3,0)
 ;;=3^Poisoning by antineopl and immunosup drugs, undet, sequela
 ;;^UTILITY(U,$J,358.3,187,1,4,0)
 ;;=4^T45.1X4S
 ;;^UTILITY(U,$J,358.3,187,2)
 ;;=^5051025
 ;;^UTILITY(U,$J,358.3,188,0)
 ;;=T36.8X1A^^1^10^42
 ;;^UTILITY(U,$J,358.3,188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,188,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, accidental, init
 ;;^UTILITY(U,$J,358.3,188,1,4,0)
 ;;=4^T36.8X1A
 ;;^UTILITY(U,$J,358.3,188,2)
 ;;=^5049400
