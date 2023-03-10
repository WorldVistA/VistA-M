IBDEI0LZ ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9887,1,4,0)
 ;;=4^W00.9XXA
 ;;^UTILITY(U,$J,358.3,9887,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,9888,0)
 ;;=W00.9XXD^^39^420^31
 ;;^UTILITY(U,$J,358.3,9888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9888,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9888,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,9888,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,9889,0)
 ;;=W01.0XXA^^39^420^92
 ;;^UTILITY(U,$J,358.3,9889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9889,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,9889,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,9889,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,9890,0)
 ;;=W01.0XXD^^39^420^93
 ;;^UTILITY(U,$J,358.3,9890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9890,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9890,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,9890,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,9891,0)
 ;;=W03.XXXA^^39^420^90
 ;;^UTILITY(U,$J,358.3,9891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9891,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,9891,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,9891,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,9892,0)
 ;;=W03.XXXD^^39^420^91
 ;;^UTILITY(U,$J,358.3,9892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9892,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9892,1,4,0)
 ;;=4^W03.XXXD
 ;;^UTILITY(U,$J,358.3,9892,2)
 ;;=^5059545
 ;;^UTILITY(U,$J,358.3,9893,0)
 ;;=W05.0XXA^^39^420^56
 ;;^UTILITY(U,$J,358.3,9893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9893,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Init Encntr
 ;;^UTILITY(U,$J,358.3,9893,1,4,0)
 ;;=4^W05.0XXA
 ;;^UTILITY(U,$J,358.3,9893,2)
 ;;=^5059550
 ;;^UTILITY(U,$J,358.3,9894,0)
 ;;=W05.0XXD^^39^420^57
 ;;^UTILITY(U,$J,358.3,9894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9894,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9894,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,9894,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,9895,0)
 ;;=W05.1XXA^^39^420^54
 ;;^UTILITY(U,$J,358.3,9895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9895,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,9895,1,4,0)
 ;;=4^W05.1XXA
 ;;^UTILITY(U,$J,358.3,9895,2)
 ;;=^5059553
 ;;^UTILITY(U,$J,358.3,9896,0)
 ;;=W05.1XXD^^39^420^55
 ;;^UTILITY(U,$J,358.3,9896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9896,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9896,1,4,0)
 ;;=4^W05.1XXD
 ;;^UTILITY(U,$J,358.3,9896,2)
 ;;=^5059554
 ;;^UTILITY(U,$J,358.3,9897,0)
 ;;=W05.2XXA^^39^420^52
 ;;^UTILITY(U,$J,358.3,9897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9897,1,3,0)
 ;;=3^Fall from Non-Moving Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,9897,1,4,0)
 ;;=4^W05.2XXA
 ;;^UTILITY(U,$J,358.3,9897,2)
 ;;=^5059556
 ;;^UTILITY(U,$J,358.3,9898,0)
 ;;=W05.2XXD^^39^420^53
 ;;^UTILITY(U,$J,358.3,9898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9898,1,3,0)
 ;;=3^Fall from Non-Moving Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9898,1,4,0)
 ;;=4^W05.2XXD
 ;;^UTILITY(U,$J,358.3,9898,2)
 ;;=^5059557
 ;;^UTILITY(U,$J,358.3,9899,0)
 ;;=W06.XXXA^^39^420^34
