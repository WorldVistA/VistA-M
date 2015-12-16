IBDEI01N ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,213,1,4,0)
 ;;=4^T36.91XS
 ;;^UTILITY(U,$J,358.3,213,2)
 ;;=^5049420
 ;;^UTILITY(U,$J,358.3,214,0)
 ;;=T36.93XA^^1^10^68
 ;;^UTILITY(U,$J,358.3,214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,214,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, assault, init encntr
 ;;^UTILITY(U,$J,358.3,214,1,4,0)
 ;;=4^T36.93XA
 ;;^UTILITY(U,$J,358.3,214,2)
 ;;=^5049424
 ;;^UTILITY(U,$J,358.3,215,0)
 ;;=T36.93XD^^1^10^69
 ;;^UTILITY(U,$J,358.3,215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,215,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, assault, subs encntr
 ;;^UTILITY(U,$J,358.3,215,1,4,0)
 ;;=4^T36.93XD
 ;;^UTILITY(U,$J,358.3,215,2)
 ;;=^5049425
 ;;^UTILITY(U,$J,358.3,216,0)
 ;;=T36.93XS^^1^10^70
 ;;^UTILITY(U,$J,358.3,216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,216,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, assault, sequela
 ;;^UTILITY(U,$J,358.3,216,1,4,0)
 ;;=4^T36.93XS
 ;;^UTILITY(U,$J,358.3,216,2)
 ;;=^5049426
 ;;^UTILITY(U,$J,358.3,217,0)
 ;;=T36.92XA^^1^10^71
 ;;^UTILITY(U,$J,358.3,217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,217,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, self-harm, init
 ;;^UTILITY(U,$J,358.3,217,1,4,0)
 ;;=4^T36.92XA
 ;;^UTILITY(U,$J,358.3,217,2)
 ;;=^5049421
 ;;^UTILITY(U,$J,358.3,218,0)
 ;;=T36.92XD^^1^10^72
 ;;^UTILITY(U,$J,358.3,218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,218,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, self-harm, subs
 ;;^UTILITY(U,$J,358.3,218,1,4,0)
 ;;=4^T36.92XD
 ;;^UTILITY(U,$J,358.3,218,2)
 ;;=^5049422
 ;;^UTILITY(U,$J,358.3,219,0)
 ;;=T36.92XS^^1^10^73
 ;;^UTILITY(U,$J,358.3,219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,219,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, self-harm, sequela
 ;;^UTILITY(U,$J,358.3,219,1,4,0)
 ;;=4^T36.92XS
 ;;^UTILITY(U,$J,358.3,219,2)
 ;;=^5049423
 ;;^UTILITY(U,$J,358.3,220,0)
 ;;=T36.94XA^^1^10^74
 ;;^UTILITY(U,$J,358.3,220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,220,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, undetermined, init
 ;;^UTILITY(U,$J,358.3,220,1,4,0)
 ;;=4^T36.94XA
 ;;^UTILITY(U,$J,358.3,220,2)
 ;;=^5049427
 ;;^UTILITY(U,$J,358.3,221,0)
 ;;=T36.94XD^^1^10^75
 ;;^UTILITY(U,$J,358.3,221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,221,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, undetermined, subs
 ;;^UTILITY(U,$J,358.3,221,1,4,0)
 ;;=4^T36.94XD
 ;;^UTILITY(U,$J,358.3,221,2)
 ;;=^5049428
 ;;^UTILITY(U,$J,358.3,222,0)
 ;;=T36.94XS^^1^10^76
 ;;^UTILITY(U,$J,358.3,222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,222,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, undetermined, sequela
 ;;^UTILITY(U,$J,358.3,222,1,4,0)
 ;;=4^T36.94XS
 ;;^UTILITY(U,$J,358.3,222,2)
 ;;=^5049429
 ;;^UTILITY(U,$J,358.3,223,0)
 ;;=T36.5X6A^^1^10^77
 ;;^UTILITY(U,$J,358.3,223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,223,1,3,0)
 ;;=3^Underdosing of aminoglycosides, initial encounter
 ;;^UTILITY(U,$J,358.3,223,1,4,0)
 ;;=4^T36.5X6A
 ;;^UTILITY(U,$J,358.3,223,2)
 ;;=^5049361
 ;;^UTILITY(U,$J,358.3,224,0)
 ;;=T36.5X6D^^1^10^79
 ;;^UTILITY(U,$J,358.3,224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,224,1,3,0)
 ;;=3^Underdosing of aminoglycosides, subsequent encounter
 ;;^UTILITY(U,$J,358.3,224,1,4,0)
 ;;=4^T36.5X6D
 ;;^UTILITY(U,$J,358.3,224,2)
 ;;=^5049362
 ;;^UTILITY(U,$J,358.3,225,0)
 ;;=T36.5X6S^^1^10^78
 ;;^UTILITY(U,$J,358.3,225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,225,1,3,0)
 ;;=3^Underdosing of aminoglycosides, sequela
 ;;^UTILITY(U,$J,358.3,225,1,4,0)
 ;;=4^T36.5X6S
 ;;^UTILITY(U,$J,358.3,225,2)
 ;;=^5049363
