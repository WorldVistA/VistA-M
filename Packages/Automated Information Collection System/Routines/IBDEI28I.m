IBDEI28I ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37527,1,4,0)
 ;;=4^M93.262
 ;;^UTILITY(U,$J,358.3,37527,2)
 ;;=^5015272
 ;;^UTILITY(U,$J,358.3,37528,0)
 ;;=G89.11^^172^1886^1
 ;;^UTILITY(U,$J,358.3,37528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37528,1,3,0)
 ;;=3^Acute pain due to trauma
 ;;^UTILITY(U,$J,358.3,37528,1,4,0)
 ;;=4^G89.11
 ;;^UTILITY(U,$J,358.3,37528,2)
 ;;=^5004152
 ;;^UTILITY(U,$J,358.3,37529,0)
 ;;=G89.21^^172^1886^3
 ;;^UTILITY(U,$J,358.3,37529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37529,1,3,0)
 ;;=3^Chronic pain due to trauma
 ;;^UTILITY(U,$J,358.3,37529,1,4,0)
 ;;=4^G89.21
 ;;^UTILITY(U,$J,358.3,37529,2)
 ;;=^5004155
 ;;^UTILITY(U,$J,358.3,37530,0)
 ;;=G89.18^^172^1886^2
 ;;^UTILITY(U,$J,358.3,37530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37530,1,3,0)
 ;;=3^Acute postprocedural pain NEC
 ;;^UTILITY(U,$J,358.3,37530,1,4,0)
 ;;=4^G89.18
 ;;^UTILITY(U,$J,358.3,37530,2)
 ;;=^5004154
 ;;^UTILITY(U,$J,358.3,37531,0)
 ;;=G89.28^^172^1886^4
 ;;^UTILITY(U,$J,358.3,37531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37531,1,3,0)
 ;;=3^Chronic postprocedural pain NEC
 ;;^UTILITY(U,$J,358.3,37531,1,4,0)
 ;;=4^G89.28
 ;;^UTILITY(U,$J,358.3,37531,2)
 ;;=^5004157
 ;;^UTILITY(U,$J,358.3,37532,0)
 ;;=M00.851^^172^1887^2
 ;;^UTILITY(U,$J,358.3,37532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37532,1,3,0)
 ;;=3^Arthritis d/t other bacteria, right hip
 ;;^UTILITY(U,$J,358.3,37532,1,4,0)
 ;;=4^M00.851
 ;;^UTILITY(U,$J,358.3,37532,2)
 ;;=^5009682
 ;;^UTILITY(U,$J,358.3,37533,0)
 ;;=M00.852^^172^1887^1
 ;;^UTILITY(U,$J,358.3,37533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37533,1,3,0)
 ;;=3^Arthritis d/t other bacteria, left hip
 ;;^UTILITY(U,$J,358.3,37533,1,4,0)
 ;;=4^M00.852
 ;;^UTILITY(U,$J,358.3,37533,2)
 ;;=^5009683
 ;;^UTILITY(U,$J,358.3,37534,0)
 ;;=S70.02XA^^172^1887^5
 ;;^UTILITY(U,$J,358.3,37534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37534,1,3,0)
 ;;=3^Contusion of left hip, initial encounter
 ;;^UTILITY(U,$J,358.3,37534,1,4,0)
 ;;=4^S70.02XA
 ;;^UTILITY(U,$J,358.3,37534,2)
 ;;=^5036837
 ;;^UTILITY(U,$J,358.3,37535,0)
 ;;=S70.01XA^^172^1887^7
 ;;^UTILITY(U,$J,358.3,37535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37535,1,3,0)
 ;;=3^Contusion of right hip, initial encounter
 ;;^UTILITY(U,$J,358.3,37535,1,4,0)
 ;;=4^S70.01XA
 ;;^UTILITY(U,$J,358.3,37535,2)
 ;;=^5036834
 ;;^UTILITY(U,$J,358.3,37536,0)
 ;;=S72.142A^^172^1887^19
 ;;^UTILITY(U,$J,358.3,37536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37536,1,3,0)
 ;;=3^Displaced intertrochanteric fracture of left femur, init
 ;;^UTILITY(U,$J,358.3,37536,1,4,0)
 ;;=4^S72.142A
 ;;^UTILITY(U,$J,358.3,37536,2)
 ;;=^5037931
 ;;^UTILITY(U,$J,358.3,37537,0)
 ;;=S72.141A^^172^1887^20
 ;;^UTILITY(U,$J,358.3,37537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37537,1,3,0)
 ;;=3^Displaced intertrochanteric fracture of right femur, init
 ;;^UTILITY(U,$J,358.3,37537,1,4,0)
 ;;=4^S72.141A
 ;;^UTILITY(U,$J,358.3,37537,2)
 ;;=^5037915
 ;;^UTILITY(U,$J,358.3,37538,0)
 ;;=S72.22XA^^172^1887^23
 ;;^UTILITY(U,$J,358.3,37538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37538,1,3,0)
 ;;=3^Displaced subtrochanteric fracture of left femur, init
 ;;^UTILITY(U,$J,358.3,37538,1,4,0)
 ;;=4^S72.22XA
 ;;^UTILITY(U,$J,358.3,37538,2)
 ;;=^5038027
 ;;^UTILITY(U,$J,358.3,37539,0)
 ;;=S72.21XA^^172^1887^25
 ;;^UTILITY(U,$J,358.3,37539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37539,1,3,0)
 ;;=3^Displaced subtrochanteric fracture of right femur, init
 ;;^UTILITY(U,$J,358.3,37539,1,4,0)
 ;;=4^S72.21XA
 ;;^UTILITY(U,$J,358.3,37539,2)
 ;;=^5038011
 ;;^UTILITY(U,$J,358.3,37540,0)
 ;;=S72.002A^^172^1887^29
