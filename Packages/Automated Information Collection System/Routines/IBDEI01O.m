IBDEI01O ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,226,0)
 ;;=T45.1X6A^^1^10^80
 ;;^UTILITY(U,$J,358.3,226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,226,1,3,0)
 ;;=3^Underdosing of antineoplastic and immunosup drugs, init
 ;;^UTILITY(U,$J,358.3,226,1,4,0)
 ;;=4^T45.1X6A
 ;;^UTILITY(U,$J,358.3,226,2)
 ;;=^5051029
 ;;^UTILITY(U,$J,358.3,227,0)
 ;;=T45.1X6D^^1^10^81
 ;;^UTILITY(U,$J,358.3,227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,227,1,3,0)
 ;;=3^Underdosing of antineoplastic and immunosup drugs, subs
 ;;^UTILITY(U,$J,358.3,227,1,4,0)
 ;;=4^T45.1X6D
 ;;^UTILITY(U,$J,358.3,227,2)
 ;;=^5051030
 ;;^UTILITY(U,$J,358.3,228,0)
 ;;=T45.1X6S^^1^10^82
 ;;^UTILITY(U,$J,358.3,228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,228,1,3,0)
 ;;=3^Underdosing of antineoplastic and immunosup drugs, sequela
 ;;^UTILITY(U,$J,358.3,228,1,4,0)
 ;;=4^T45.1X6S
 ;;^UTILITY(U,$J,358.3,228,2)
 ;;=^5051031
 ;;^UTILITY(U,$J,358.3,229,0)
 ;;=T36.8X6A^^1^10^83
 ;;^UTILITY(U,$J,358.3,229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,229,1,3,0)
 ;;=3^Underdosing of other systemic antibiotics, initial encounter
 ;;^UTILITY(U,$J,358.3,229,1,4,0)
 ;;=4^T36.8X6A
 ;;^UTILITY(U,$J,358.3,229,2)
 ;;=^5049415
 ;;^UTILITY(U,$J,358.3,230,0)
 ;;=T36.8X6D^^1^10^84
 ;;^UTILITY(U,$J,358.3,230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,230,1,3,0)
 ;;=3^Underdosing of other systemic antibiotics, subs encntr
 ;;^UTILITY(U,$J,358.3,230,1,4,0)
 ;;=4^T36.8X6D
 ;;^UTILITY(U,$J,358.3,230,2)
 ;;=^5049416
 ;;^UTILITY(U,$J,358.3,231,0)
 ;;=T36.8X6S^^1^10^85
 ;;^UTILITY(U,$J,358.3,231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,231,1,3,0)
 ;;=3^Underdosing of other systemic antibiotics, sequela
 ;;^UTILITY(U,$J,358.3,231,1,4,0)
 ;;=4^T36.8X6S
 ;;^UTILITY(U,$J,358.3,231,2)
 ;;=^5049417
 ;;^UTILITY(U,$J,358.3,232,0)
 ;;=T49.6X6A^^1^10^86
 ;;^UTILITY(U,$J,358.3,232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,232,1,3,0)
 ;;=3^Underdosing of otorhino drugs and preparations, init
 ;;^UTILITY(U,$J,358.3,232,1,4,0)
 ;;=4^T49.6X6A
 ;;^UTILITY(U,$J,358.3,232,2)
 ;;=^5051929
 ;;^UTILITY(U,$J,358.3,233,0)
 ;;=T49.6X6D^^1^10^87
 ;;^UTILITY(U,$J,358.3,233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,233,1,3,0)
 ;;=3^Underdosing of otorhino drugs and preparations, subs
 ;;^UTILITY(U,$J,358.3,233,1,4,0)
 ;;=4^T49.6X6D
 ;;^UTILITY(U,$J,358.3,233,2)
 ;;=^5051930
 ;;^UTILITY(U,$J,358.3,234,0)
 ;;=T49.6X6S^^1^10^88
 ;;^UTILITY(U,$J,358.3,234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,234,1,3,0)
 ;;=3^Underdosing of otorhino drugs and preparations, sequela
 ;;^UTILITY(U,$J,358.3,234,1,4,0)
 ;;=4^T49.6X6S
 ;;^UTILITY(U,$J,358.3,234,2)
 ;;=^5051931
 ;;^UTILITY(U,$J,358.3,235,0)
 ;;=T36.96XA^^1^10^89
 ;;^UTILITY(U,$J,358.3,235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,235,1,3,0)
 ;;=3^Underdosing of unspecified systemic antibiotic, init encntr
 ;;^UTILITY(U,$J,358.3,235,1,4,0)
 ;;=4^T36.96XA
 ;;^UTILITY(U,$J,358.3,235,2)
 ;;=^5049433
 ;;^UTILITY(U,$J,358.3,236,0)
 ;;=T36.96XD^^1^10^90
 ;;^UTILITY(U,$J,358.3,236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,236,1,3,0)
 ;;=3^Underdosing of unspecified systemic antibiotic, subs encntr
 ;;^UTILITY(U,$J,358.3,236,1,4,0)
 ;;=4^T36.96XD
 ;;^UTILITY(U,$J,358.3,236,2)
 ;;=^5049434
 ;;^UTILITY(U,$J,358.3,237,0)
 ;;=T36.96XS^^1^10^91
 ;;^UTILITY(U,$J,358.3,237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,237,1,3,0)
 ;;=3^Underdosing of unspecified systemic antibiotic, sequela
 ;;^UTILITY(U,$J,358.3,237,1,4,0)
 ;;=4^T36.96XS
 ;;^UTILITY(U,$J,358.3,237,2)
 ;;=^5049435
 ;;^UTILITY(U,$J,358.3,238,0)
 ;;=Z45.320^^1^11^1
 ;;^UTILITY(U,$J,358.3,238,1,0)
 ;;=^358.31IA^4^2
