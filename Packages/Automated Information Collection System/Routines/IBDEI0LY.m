IBDEI0LY ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9875,2)
 ;;=^5055964
 ;;^UTILITY(U,$J,358.3,9876,0)
 ;;=V00.891D^^39^420^63
 ;;^UTILITY(U,$J,358.3,9876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9876,1,3,0)
 ;;=3^Fall from Pedestrian Conveyance,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9876,1,4,0)
 ;;=4^V00.891D
 ;;^UTILITY(U,$J,358.3,9876,2)
 ;;=^5055965
 ;;^UTILITY(U,$J,358.3,9877,0)
 ;;=V00.892A^^39^420^108
 ;;^UTILITY(U,$J,358.3,9877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9877,1,3,0)
 ;;=3^Pedestrian Conveyance Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,9877,1,4,0)
 ;;=4^V00.892A
 ;;^UTILITY(U,$J,358.3,9877,2)
 ;;=^5055967
 ;;^UTILITY(U,$J,358.3,9878,0)
 ;;=V00.892D^^39^420^109
 ;;^UTILITY(U,$J,358.3,9878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9878,1,3,0)
 ;;=3^Pedestrian Conveyance Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9878,1,4,0)
 ;;=4^V00.892D
 ;;^UTILITY(U,$J,358.3,9878,2)
 ;;=^5055968
 ;;^UTILITY(U,$J,358.3,9879,0)
 ;;=V00.898A^^39^420^106
 ;;^UTILITY(U,$J,358.3,9879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9879,1,3,0)
 ;;=3^Pedestrian Conveyance Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,9879,1,4,0)
 ;;=4^V00.898A
 ;;^UTILITY(U,$J,358.3,9879,2)
 ;;=^5055970
 ;;^UTILITY(U,$J,358.3,9880,0)
 ;;=V00.898D^^39^420^107
 ;;^UTILITY(U,$J,358.3,9880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9880,1,3,0)
 ;;=3^Pedestrian Conveyance Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9880,1,4,0)
 ;;=4^V00.898D
 ;;^UTILITY(U,$J,358.3,9880,2)
 ;;=^5055971
 ;;^UTILITY(U,$J,358.3,9881,0)
 ;;=W00.0XXA^^39^420^84
 ;;^UTILITY(U,$J,358.3,9881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9881,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,9881,1,4,0)
 ;;=4^W00.0XXA
 ;;^UTILITY(U,$J,358.3,9881,2)
 ;;=^5059510
 ;;^UTILITY(U,$J,358.3,9882,0)
 ;;=W00.0XXD^^39^420^85
 ;;^UTILITY(U,$J,358.3,9882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9882,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9882,1,4,0)
 ;;=4^W00.0XXD
 ;;^UTILITY(U,$J,358.3,9882,2)
 ;;=^5059511
 ;;^UTILITY(U,$J,358.3,9883,0)
 ;;=W00.1XXA^^39^420^64
 ;;^UTILITY(U,$J,358.3,9883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9883,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,9883,1,4,0)
 ;;=4^W00.1XXA
 ;;^UTILITY(U,$J,358.3,9883,2)
 ;;=^5059513
 ;;^UTILITY(U,$J,358.3,9884,0)
 ;;=W00.1XXD^^39^420^65
 ;;^UTILITY(U,$J,358.3,9884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9884,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9884,1,4,0)
 ;;=4^W00.1XXD
 ;;^UTILITY(U,$J,358.3,9884,2)
 ;;=^5059514
 ;;^UTILITY(U,$J,358.3,9885,0)
 ;;=W00.2XXA^^39^420^58
 ;;^UTILITY(U,$J,358.3,9885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9885,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,9885,1,4,0)
 ;;=4^W00.2XXA
 ;;^UTILITY(U,$J,358.3,9885,2)
 ;;=^5059516
 ;;^UTILITY(U,$J,358.3,9886,0)
 ;;=W00.2XXD^^39^420^59
 ;;^UTILITY(U,$J,358.3,9886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9886,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,9886,1,4,0)
 ;;=4^W00.2XXD
 ;;^UTILITY(U,$J,358.3,9886,2)
 ;;=^5059517
 ;;^UTILITY(U,$J,358.3,9887,0)
 ;;=W00.9XXA^^39^420^30
 ;;^UTILITY(U,$J,358.3,9887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9887,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Init Encntr
