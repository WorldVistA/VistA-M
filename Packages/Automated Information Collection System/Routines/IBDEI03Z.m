IBDEI03Z ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1429,1,3,0)
 ;;=3^Underdosing of aminoglycosides, initial encounter
 ;;^UTILITY(U,$J,358.3,1429,1,4,0)
 ;;=4^T36.5X6A
 ;;^UTILITY(U,$J,358.3,1429,2)
 ;;=^5049361
 ;;^UTILITY(U,$J,358.3,1430,0)
 ;;=T36.5X6D^^8^135^79
 ;;^UTILITY(U,$J,358.3,1430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1430,1,3,0)
 ;;=3^Underdosing of aminoglycosides, subsequent encounter
 ;;^UTILITY(U,$J,358.3,1430,1,4,0)
 ;;=4^T36.5X6D
 ;;^UTILITY(U,$J,358.3,1430,2)
 ;;=^5049362
 ;;^UTILITY(U,$J,358.3,1431,0)
 ;;=T36.5X6S^^8^135^78
 ;;^UTILITY(U,$J,358.3,1431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1431,1,3,0)
 ;;=3^Underdosing of aminoglycosides, sequela
 ;;^UTILITY(U,$J,358.3,1431,1,4,0)
 ;;=4^T36.5X6S
 ;;^UTILITY(U,$J,358.3,1431,2)
 ;;=^5049363
 ;;^UTILITY(U,$J,358.3,1432,0)
 ;;=T45.1X6A^^8^135^80
 ;;^UTILITY(U,$J,358.3,1432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1432,1,3,0)
 ;;=3^Underdosing of antineoplastic and immunosup drugs, init
 ;;^UTILITY(U,$J,358.3,1432,1,4,0)
 ;;=4^T45.1X6A
 ;;^UTILITY(U,$J,358.3,1432,2)
 ;;=^5051029
 ;;^UTILITY(U,$J,358.3,1433,0)
 ;;=T45.1X6D^^8^135^81
 ;;^UTILITY(U,$J,358.3,1433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1433,1,3,0)
 ;;=3^Underdosing of antineoplastic and immunosup drugs, subs
 ;;^UTILITY(U,$J,358.3,1433,1,4,0)
 ;;=4^T45.1X6D
 ;;^UTILITY(U,$J,358.3,1433,2)
 ;;=^5051030
 ;;^UTILITY(U,$J,358.3,1434,0)
 ;;=T45.1X6S^^8^135^82
 ;;^UTILITY(U,$J,358.3,1434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1434,1,3,0)
 ;;=3^Underdosing of antineoplastic and immunosup drugs, sequela
 ;;^UTILITY(U,$J,358.3,1434,1,4,0)
 ;;=4^T45.1X6S
 ;;^UTILITY(U,$J,358.3,1434,2)
 ;;=^5051031
 ;;^UTILITY(U,$J,358.3,1435,0)
 ;;=T36.8X6A^^8^135^83
 ;;^UTILITY(U,$J,358.3,1435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1435,1,3,0)
 ;;=3^Underdosing of other systemic antibiotics, initial encounter
 ;;^UTILITY(U,$J,358.3,1435,1,4,0)
 ;;=4^T36.8X6A
 ;;^UTILITY(U,$J,358.3,1435,2)
 ;;=^5049415
 ;;^UTILITY(U,$J,358.3,1436,0)
 ;;=T36.8X6D^^8^135^84
 ;;^UTILITY(U,$J,358.3,1436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1436,1,3,0)
 ;;=3^Underdosing of other systemic antibiotics, subs encntr
 ;;^UTILITY(U,$J,358.3,1436,1,4,0)
 ;;=4^T36.8X6D
 ;;^UTILITY(U,$J,358.3,1436,2)
 ;;=^5049416
 ;;^UTILITY(U,$J,358.3,1437,0)
 ;;=T36.8X6S^^8^135^85
 ;;^UTILITY(U,$J,358.3,1437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1437,1,3,0)
 ;;=3^Underdosing of other systemic antibiotics, sequela
 ;;^UTILITY(U,$J,358.3,1437,1,4,0)
 ;;=4^T36.8X6S
 ;;^UTILITY(U,$J,358.3,1437,2)
 ;;=^5049417
 ;;^UTILITY(U,$J,358.3,1438,0)
 ;;=T49.6X6A^^8^135^86
 ;;^UTILITY(U,$J,358.3,1438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1438,1,3,0)
 ;;=3^Underdosing of otorhino drugs and preparations, init
 ;;^UTILITY(U,$J,358.3,1438,1,4,0)
 ;;=4^T49.6X6A
 ;;^UTILITY(U,$J,358.3,1438,2)
 ;;=^5051929
 ;;^UTILITY(U,$J,358.3,1439,0)
 ;;=T49.6X6D^^8^135^87
 ;;^UTILITY(U,$J,358.3,1439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1439,1,3,0)
 ;;=3^Underdosing of otorhino drugs and preparations, subs
 ;;^UTILITY(U,$J,358.3,1439,1,4,0)
 ;;=4^T49.6X6D
 ;;^UTILITY(U,$J,358.3,1439,2)
 ;;=^5051930
 ;;^UTILITY(U,$J,358.3,1440,0)
 ;;=T49.6X6S^^8^135^88
 ;;^UTILITY(U,$J,358.3,1440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1440,1,3,0)
 ;;=3^Underdosing of otorhino drugs and preparations, sequela
 ;;^UTILITY(U,$J,358.3,1440,1,4,0)
 ;;=4^T49.6X6S
 ;;^UTILITY(U,$J,358.3,1440,2)
 ;;=^5051931
 ;;^UTILITY(U,$J,358.3,1441,0)
 ;;=T36.96XA^^8^135^89
 ;;^UTILITY(U,$J,358.3,1441,1,0)
 ;;=^358.31IA^4^2
