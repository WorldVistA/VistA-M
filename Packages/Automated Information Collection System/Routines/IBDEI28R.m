IBDEI28R ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35787,1,3,0)
 ;;=3^Postconcussional syndrome
 ;;^UTILITY(U,$J,358.3,35787,1,4,0)
 ;;=4^F07.81
 ;;^UTILITY(U,$J,358.3,35787,2)
 ;;=^5003064
 ;;^UTILITY(U,$J,358.3,35788,0)
 ;;=R41.2^^139^1824^5
 ;;^UTILITY(U,$J,358.3,35788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35788,1,3,0)
 ;;=3^Retrograde amnesia
 ;;^UTILITY(U,$J,358.3,35788,1,4,0)
 ;;=4^R41.2
 ;;^UTILITY(U,$J,358.3,35788,2)
 ;;=^5019438
 ;;^UTILITY(U,$J,358.3,35789,0)
 ;;=T84.81XA^^139^1825^2
 ;;^UTILITY(U,$J,358.3,35789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35789,1,3,0)
 ;;=3^Embolism d/t internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,35789,1,4,0)
 ;;=4^T84.81XA
 ;;^UTILITY(U,$J,358.3,35789,2)
 ;;=^5055454
 ;;^UTILITY(U,$J,358.3,35790,0)
 ;;=T84.82XA^^139^1825^3
 ;;^UTILITY(U,$J,358.3,35790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35790,1,3,0)
 ;;=3^Fibrosis d/t internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,35790,1,4,0)
 ;;=4^T84.82XA
 ;;^UTILITY(U,$J,358.3,35790,2)
 ;;=^5055457
 ;;^UTILITY(U,$J,358.3,35791,0)
 ;;=T84.83XA^^139^1825^4
 ;;^UTILITY(U,$J,358.3,35791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35791,1,3,0)
 ;;=3^Hemorrhage d/t internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,35791,1,4,0)
 ;;=4^T84.83XA
 ;;^UTILITY(U,$J,358.3,35791,2)
 ;;=^5055460
 ;;^UTILITY(U,$J,358.3,35792,0)
 ;;=T84.84XA^^139^1825^5
 ;;^UTILITY(U,$J,358.3,35792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35792,1,3,0)
 ;;=3^Pain d/t internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,35792,1,4,0)
 ;;=4^T84.84XA
 ;;^UTILITY(U,$J,358.3,35792,2)
 ;;=^5055463
 ;;^UTILITY(U,$J,358.3,35793,0)
 ;;=T84.85XA^^139^1825^6
 ;;^UTILITY(U,$J,358.3,35793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35793,1,3,0)
 ;;=3^Stenosis d/t internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,35793,1,4,0)
 ;;=4^T84.85XA
 ;;^UTILITY(U,$J,358.3,35793,2)
 ;;=^5055466
 ;;^UTILITY(U,$J,358.3,35794,0)
 ;;=T84.86XA^^139^1825^7
 ;;^UTILITY(U,$J,358.3,35794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35794,1,3,0)
 ;;=3^Thrombosis d/t internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,35794,1,4,0)
 ;;=4^T84.86XA
 ;;^UTILITY(U,$J,358.3,35794,2)
 ;;=^5055469
 ;;^UTILITY(U,$J,358.3,35795,0)
 ;;=T88.9XXS^^139^1825^1
 ;;^UTILITY(U,$J,358.3,35795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35795,1,3,0)
 ;;=3^Complication of surgical and medical care, unsp, sequela
 ;;^UTILITY(U,$J,358.3,35795,1,4,0)
 ;;=4^T88.9XXS
 ;;^UTILITY(U,$J,358.3,35795,2)
 ;;=^5055819
 ;;^UTILITY(U,$J,358.3,35796,0)
 ;;=M86.672^^139^1826^2
 ;;^UTILITY(U,$J,358.3,35796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35796,1,3,0)
 ;;=3^Chr Osteomyelitis,Lt Ankle/Foot NEC
 ;;^UTILITY(U,$J,358.3,35796,1,4,0)
 ;;=4^M86.672
 ;;^UTILITY(U,$J,358.3,35796,2)
 ;;=^5014642
 ;;^UTILITY(U,$J,358.3,35797,0)
 ;;=M86.642^^139^1826^3
 ;;^UTILITY(U,$J,358.3,35797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35797,1,3,0)
 ;;=3^Chr Osteomyelitis,Lt Hand NEC
 ;;^UTILITY(U,$J,358.3,35797,1,4,0)
 ;;=4^M86.642
 ;;^UTILITY(U,$J,358.3,35797,2)
 ;;=^5134074
 ;;^UTILITY(U,$J,358.3,35798,0)
 ;;=M86.622^^139^1826^4
 ;;^UTILITY(U,$J,358.3,35798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35798,1,3,0)
 ;;=3^Chr Osteomyelitis,Lt Humerus NEC
 ;;^UTILITY(U,$J,358.3,35798,1,4,0)
 ;;=4^M86.622
 ;;^UTILITY(U,$J,358.3,35798,2)
 ;;=^5134070
