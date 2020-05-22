IBDEI244 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33755,1,3,0)
 ;;=3^Chronic postprocedural pain NEC
 ;;^UTILITY(U,$J,358.3,33755,1,4,0)
 ;;=4^G89.28
 ;;^UTILITY(U,$J,358.3,33755,2)
 ;;=^5004157
 ;;^UTILITY(U,$J,358.3,33756,0)
 ;;=G89.29^^132^1710^4
 ;;^UTILITY(U,$J,358.3,33756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33756,1,3,0)
 ;;=3^Chronic Pain,Other
 ;;^UTILITY(U,$J,358.3,33756,1,4,0)
 ;;=4^G89.29
 ;;^UTILITY(U,$J,358.3,33756,2)
 ;;=^5004158
 ;;^UTILITY(U,$J,358.3,33757,0)
 ;;=M00.851^^132^1711^2
 ;;^UTILITY(U,$J,358.3,33757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33757,1,3,0)
 ;;=3^Arthritis d/t other bacteria, right hip
 ;;^UTILITY(U,$J,358.3,33757,1,4,0)
 ;;=4^M00.851
 ;;^UTILITY(U,$J,358.3,33757,2)
 ;;=^5009682
 ;;^UTILITY(U,$J,358.3,33758,0)
 ;;=M00.852^^132^1711^1
 ;;^UTILITY(U,$J,358.3,33758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33758,1,3,0)
 ;;=3^Arthritis d/t other bacteria, left hip
 ;;^UTILITY(U,$J,358.3,33758,1,4,0)
 ;;=4^M00.852
 ;;^UTILITY(U,$J,358.3,33758,2)
 ;;=^5009683
 ;;^UTILITY(U,$J,358.3,33759,0)
 ;;=S70.02XA^^132^1711^5
 ;;^UTILITY(U,$J,358.3,33759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33759,1,3,0)
 ;;=3^Contusion of left hip, initial encounter
 ;;^UTILITY(U,$J,358.3,33759,1,4,0)
 ;;=4^S70.02XA
 ;;^UTILITY(U,$J,358.3,33759,2)
 ;;=^5036837
 ;;^UTILITY(U,$J,358.3,33760,0)
 ;;=S70.01XA^^132^1711^7
 ;;^UTILITY(U,$J,358.3,33760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33760,1,3,0)
 ;;=3^Contusion of right hip, initial encounter
 ;;^UTILITY(U,$J,358.3,33760,1,4,0)
 ;;=4^S70.01XA
 ;;^UTILITY(U,$J,358.3,33760,2)
 ;;=^5036834
 ;;^UTILITY(U,$J,358.3,33761,0)
 ;;=S72.142A^^132^1711^15
 ;;^UTILITY(U,$J,358.3,33761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33761,1,3,0)
 ;;=3^Displaced intertrochanteric fracture of left femur, init
 ;;^UTILITY(U,$J,358.3,33761,1,4,0)
 ;;=4^S72.142A
 ;;^UTILITY(U,$J,358.3,33761,2)
 ;;=^5037931
 ;;^UTILITY(U,$J,358.3,33762,0)
 ;;=S72.141A^^132^1711^16
 ;;^UTILITY(U,$J,358.3,33762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33762,1,3,0)
 ;;=3^Displaced intertrochanteric fracture of right femur, init
 ;;^UTILITY(U,$J,358.3,33762,1,4,0)
 ;;=4^S72.141A
 ;;^UTILITY(U,$J,358.3,33762,2)
 ;;=^5037915
 ;;^UTILITY(U,$J,358.3,33763,0)
 ;;=S72.22XA^^132^1711^17
 ;;^UTILITY(U,$J,358.3,33763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33763,1,3,0)
 ;;=3^Displaced subtrochanteric fracture of left femur, init
 ;;^UTILITY(U,$J,358.3,33763,1,4,0)
 ;;=4^S72.22XA
 ;;^UTILITY(U,$J,358.3,33763,2)
 ;;=^5038027
 ;;^UTILITY(U,$J,358.3,33764,0)
 ;;=S72.21XA^^132^1711^18
 ;;^UTILITY(U,$J,358.3,33764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33764,1,3,0)
 ;;=3^Displaced subtrochanteric fracture of right femur, init
 ;;^UTILITY(U,$J,358.3,33764,1,4,0)
 ;;=4^S72.21XA
 ;;^UTILITY(U,$J,358.3,33764,2)
 ;;=^5038011
 ;;^UTILITY(U,$J,358.3,33765,0)
 ;;=S72.002A^^132^1711^21
 ;;^UTILITY(U,$J,358.3,33765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33765,1,3,0)
 ;;=3^Fracture of unsp part of neck of left femur, init
 ;;^UTILITY(U,$J,358.3,33765,1,4,0)
 ;;=4^S72.002A
 ;;^UTILITY(U,$J,358.3,33765,2)
 ;;=^5037063
 ;;^UTILITY(U,$J,358.3,33766,0)
 ;;=S72.001A^^132^1711^22
 ;;^UTILITY(U,$J,358.3,33766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33766,1,3,0)
 ;;=3^Fracture of unsp part of neck of right femur, init
 ;;^UTILITY(U,$J,358.3,33766,1,4,0)
 ;;=4^S72.001A
 ;;^UTILITY(U,$J,358.3,33766,2)
 ;;=^5037047
