IBDEI13M ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17836,1,3,0)
 ;;=3^Fall from Pedestrian Conveyance,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17836,1,4,0)
 ;;=4^V00.891D
 ;;^UTILITY(U,$J,358.3,17836,2)
 ;;=^5055965
 ;;^UTILITY(U,$J,358.3,17837,0)
 ;;=V00.892A^^61^794^108
 ;;^UTILITY(U,$J,358.3,17837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17837,1,3,0)
 ;;=3^Pedestrian Conveyance Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,17837,1,4,0)
 ;;=4^V00.892A
 ;;^UTILITY(U,$J,358.3,17837,2)
 ;;=^5055967
 ;;^UTILITY(U,$J,358.3,17838,0)
 ;;=V00.892D^^61^794^109
 ;;^UTILITY(U,$J,358.3,17838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17838,1,3,0)
 ;;=3^Pedestrian Conveyance Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17838,1,4,0)
 ;;=4^V00.892D
 ;;^UTILITY(U,$J,358.3,17838,2)
 ;;=^5055968
 ;;^UTILITY(U,$J,358.3,17839,0)
 ;;=V00.898A^^61^794^106
 ;;^UTILITY(U,$J,358.3,17839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17839,1,3,0)
 ;;=3^Pedestrian Conveyance Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,17839,1,4,0)
 ;;=4^V00.898A
 ;;^UTILITY(U,$J,358.3,17839,2)
 ;;=^5055970
 ;;^UTILITY(U,$J,358.3,17840,0)
 ;;=V00.898D^^61^794^107
 ;;^UTILITY(U,$J,358.3,17840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17840,1,3,0)
 ;;=3^Pedestrian Conveyance Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17840,1,4,0)
 ;;=4^V00.898D
 ;;^UTILITY(U,$J,358.3,17840,2)
 ;;=^5055971
 ;;^UTILITY(U,$J,358.3,17841,0)
 ;;=W00.0XXA^^61^794^84
 ;;^UTILITY(U,$J,358.3,17841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17841,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,17841,1,4,0)
 ;;=4^W00.0XXA
 ;;^UTILITY(U,$J,358.3,17841,2)
 ;;=^5059510
 ;;^UTILITY(U,$J,358.3,17842,0)
 ;;=W00.0XXD^^61^794^85
 ;;^UTILITY(U,$J,358.3,17842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17842,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17842,1,4,0)
 ;;=4^W00.0XXD
 ;;^UTILITY(U,$J,358.3,17842,2)
 ;;=^5059511
 ;;^UTILITY(U,$J,358.3,17843,0)
 ;;=W00.1XXA^^61^794^64
 ;;^UTILITY(U,$J,358.3,17843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17843,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,17843,1,4,0)
 ;;=4^W00.1XXA
 ;;^UTILITY(U,$J,358.3,17843,2)
 ;;=^5059513
 ;;^UTILITY(U,$J,358.3,17844,0)
 ;;=W00.1XXD^^61^794^65
 ;;^UTILITY(U,$J,358.3,17844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17844,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17844,1,4,0)
 ;;=4^W00.1XXD
 ;;^UTILITY(U,$J,358.3,17844,2)
 ;;=^5059514
 ;;^UTILITY(U,$J,358.3,17845,0)
 ;;=W00.2XXA^^61^794^58
 ;;^UTILITY(U,$J,358.3,17845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17845,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,17845,1,4,0)
 ;;=4^W00.2XXA
 ;;^UTILITY(U,$J,358.3,17845,2)
 ;;=^5059516
 ;;^UTILITY(U,$J,358.3,17846,0)
 ;;=W00.2XXD^^61^794^59
 ;;^UTILITY(U,$J,358.3,17846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17846,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17846,1,4,0)
 ;;=4^W00.2XXD
 ;;^UTILITY(U,$J,358.3,17846,2)
 ;;=^5059517
 ;;^UTILITY(U,$J,358.3,17847,0)
 ;;=W00.9XXA^^61^794^30
 ;;^UTILITY(U,$J,358.3,17847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17847,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,17847,1,4,0)
 ;;=4^W00.9XXA
