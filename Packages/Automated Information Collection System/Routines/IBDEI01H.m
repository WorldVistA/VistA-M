IBDEI01H ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,138,0)
 ;;=H83.3X2^^1^8^2
 ;;^UTILITY(U,$J,358.3,138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,138,1,3,0)
 ;;=3^Noise effects on left inner ear
 ;;^UTILITY(U,$J,358.3,138,1,4,0)
 ;;=4^H83.3X2
 ;;^UTILITY(U,$J,358.3,138,2)
 ;;=^5006907
 ;;^UTILITY(U,$J,358.3,139,0)
 ;;=H83.3X3^^1^8^1
 ;;^UTILITY(U,$J,358.3,139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,139,1,3,0)
 ;;=3^Noise effects on bilateral inner ear
 ;;^UTILITY(U,$J,358.3,139,1,4,0)
 ;;=4^H83.3X3
 ;;^UTILITY(U,$J,358.3,139,2)
 ;;=^5006908
 ;;^UTILITY(U,$J,358.3,140,0)
 ;;=H55.01^^1^9^1
 ;;^UTILITY(U,$J,358.3,140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,140,1,3,0)
 ;;=3^Congenital nystagmus
 ;;^UTILITY(U,$J,358.3,140,1,4,0)
 ;;=4^H55.01
 ;;^UTILITY(U,$J,358.3,140,2)
 ;;=^5006371
 ;;^UTILITY(U,$J,358.3,141,0)
 ;;=H55.04^^1^9^2
 ;;^UTILITY(U,$J,358.3,141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,141,1,3,0)
 ;;=3^Dissociated nystagmus
 ;;^UTILITY(U,$J,358.3,141,1,4,0)
 ;;=4^H55.04
 ;;^UTILITY(U,$J,358.3,141,2)
 ;;=^269325
 ;;^UTILITY(U,$J,358.3,142,0)
 ;;=H55.02^^1^9^3
 ;;^UTILITY(U,$J,358.3,142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,142,1,3,0)
 ;;=3^Latent nystagmus
 ;;^UTILITY(U,$J,358.3,142,1,4,0)
 ;;=4^H55.02
 ;;^UTILITY(U,$J,358.3,142,2)
 ;;=^5006372
 ;;^UTILITY(U,$J,358.3,143,0)
 ;;=H55.09^^1^9^4
 ;;^UTILITY(U,$J,358.3,143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,143,1,3,0)
 ;;=3^Nystagmus NEC
 ;;^UTILITY(U,$J,358.3,143,1,4,0)
 ;;=4^H55.09
 ;;^UTILITY(U,$J,358.3,143,2)
 ;;=^87599
 ;;^UTILITY(U,$J,358.3,144,0)
 ;;=H55.81^^1^9^5
 ;;^UTILITY(U,$J,358.3,144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,144,1,3,0)
 ;;=3^Saccadic eye movements
 ;;^UTILITY(U,$J,358.3,144,1,4,0)
 ;;=4^H55.81
 ;;^UTILITY(U,$J,358.3,144,2)
 ;;=^5006373
 ;;^UTILITY(U,$J,358.3,145,0)
 ;;=H55.03^^1^9^6
 ;;^UTILITY(U,$J,358.3,145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,145,1,3,0)
 ;;=3^Visual deprivation nystagmus
 ;;^UTILITY(U,$J,358.3,145,1,4,0)
 ;;=4^H55.03
 ;;^UTILITY(U,$J,358.3,145,2)
 ;;=^269322
 ;;^UTILITY(U,$J,358.3,146,0)
 ;;=T36.5X5A^^1^10^1
 ;;^UTILITY(U,$J,358.3,146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,146,1,3,0)
 ;;=3^Adverse effect of aminoglycosides, initial encounter
 ;;^UTILITY(U,$J,358.3,146,1,4,0)
 ;;=4^T36.5X5A
 ;;^UTILITY(U,$J,358.3,146,2)
 ;;=^5049358
 ;;^UTILITY(U,$J,358.3,147,0)
 ;;=T36.5X5S^^1^10^2
 ;;^UTILITY(U,$J,358.3,147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,147,1,3,0)
 ;;=3^Adverse effect of aminoglycosides, sequela
 ;;^UTILITY(U,$J,358.3,147,1,4,0)
 ;;=4^T36.5X5S
 ;;^UTILITY(U,$J,358.3,147,2)
 ;;=^5049360
 ;;^UTILITY(U,$J,358.3,148,0)
 ;;=T36.5X5D^^1^10^3
 ;;^UTILITY(U,$J,358.3,148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,148,1,3,0)
 ;;=3^Adverse effect of aminoglycosides, subsequent encounter
 ;;^UTILITY(U,$J,358.3,148,1,4,0)
 ;;=4^T36.5X5D
 ;;^UTILITY(U,$J,358.3,148,2)
 ;;=^5049359
 ;;^UTILITY(U,$J,358.3,149,0)
 ;;=T45.1X5A^^1^10^5
 ;;^UTILITY(U,$J,358.3,149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,149,1,3,0)
 ;;=3^Adverse effect of antineoplastic and immunosup drugs, init
 ;;^UTILITY(U,$J,358.3,149,1,4,0)
 ;;=4^T45.1X5A
 ;;^UTILITY(U,$J,358.3,149,2)
 ;;=^5051026
 ;;^UTILITY(U,$J,358.3,150,0)
 ;;=T45.1X5D^^1^10^6
 ;;^UTILITY(U,$J,358.3,150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,150,1,3,0)
 ;;=3^Adverse effect of antineoplastic and immunosup drugs, subs
 ;;^UTILITY(U,$J,358.3,150,1,4,0)
 ;;=4^T45.1X5D
 ;;^UTILITY(U,$J,358.3,150,2)
 ;;=^5051027
 ;;^UTILITY(U,$J,358.3,151,0)
 ;;=T45.1X5S^^1^10^4
 ;;^UTILITY(U,$J,358.3,151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,151,1,3,0)
 ;;=3^Adverse effect of antineopl and immunosup drugs, sequela
