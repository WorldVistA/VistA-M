IBDEI288 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37403,1,4,0)
 ;;=4^S60.222D
 ;;^UTILITY(U,$J,358.3,37403,2)
 ;;=^5032280
 ;;^UTILITY(U,$J,358.3,37404,0)
 ;;=S60.221D^^172^1882^8
 ;;^UTILITY(U,$J,358.3,37404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37404,1,3,0)
 ;;=3^Contusion of right hand, subsequent encounter
 ;;^UTILITY(U,$J,358.3,37404,1,4,0)
 ;;=4^S60.221D
 ;;^UTILITY(U,$J,358.3,37404,2)
 ;;=^5032277
 ;;^UTILITY(U,$J,358.3,37405,0)
 ;;=M19.141^^172^1882^21
 ;;^UTILITY(U,$J,358.3,37405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37405,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, right hand
 ;;^UTILITY(U,$J,358.3,37405,1,4,0)
 ;;=4^M19.141
 ;;^UTILITY(U,$J,358.3,37405,2)
 ;;=^5010832
 ;;^UTILITY(U,$J,358.3,37406,0)
 ;;=M19.142^^172^1882^20
 ;;^UTILITY(U,$J,358.3,37406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37406,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, left hand
 ;;^UTILITY(U,$J,358.3,37406,1,4,0)
 ;;=4^M19.142
 ;;^UTILITY(U,$J,358.3,37406,2)
 ;;=^5010833
 ;;^UTILITY(U,$J,358.3,37407,0)
 ;;=M19.231^^172^1882^25
 ;;^UTILITY(U,$J,358.3,37407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37407,1,3,0)
 ;;=3^Secondary osteoarthritis, right wrist
 ;;^UTILITY(U,$J,358.3,37407,1,4,0)
 ;;=4^M19.231
 ;;^UTILITY(U,$J,358.3,37407,2)
 ;;=^5010844
 ;;^UTILITY(U,$J,358.3,37408,0)
 ;;=M19.232^^172^1882^24
 ;;^UTILITY(U,$J,358.3,37408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37408,1,3,0)
 ;;=3^Secondary osteoarthritis, left wrist
 ;;^UTILITY(U,$J,358.3,37408,1,4,0)
 ;;=4^M19.232
 ;;^UTILITY(U,$J,358.3,37408,2)
 ;;=^5010845
 ;;^UTILITY(U,$J,358.3,37409,0)
 ;;=S40.022A^^172^1883^1
 ;;^UTILITY(U,$J,358.3,37409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37409,1,3,0)
 ;;=3^Contusion of left upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,37409,1,4,0)
 ;;=4^S40.022A
 ;;^UTILITY(U,$J,358.3,37409,2)
 ;;=^5026165
 ;;^UTILITY(U,$J,358.3,37410,0)
 ;;=S40.021A^^172^1883^3
 ;;^UTILITY(U,$J,358.3,37410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37410,1,3,0)
 ;;=3^Contusion of right upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,37410,1,4,0)
 ;;=4^S40.021A
 ;;^UTILITY(U,$J,358.3,37410,2)
 ;;=^5026162
 ;;^UTILITY(U,$J,358.3,37411,0)
 ;;=M84.422A^^172^1883^9
 ;;^UTILITY(U,$J,358.3,37411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37411,1,3,0)
 ;;=3^Pathological fracture, left humerus, init for fx
 ;;^UTILITY(U,$J,358.3,37411,1,4,0)
 ;;=4^M84.422A
 ;;^UTILITY(U,$J,358.3,37411,2)
 ;;=^5013824
 ;;^UTILITY(U,$J,358.3,37412,0)
 ;;=M84.421A^^172^1883^11
 ;;^UTILITY(U,$J,358.3,37412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37412,1,3,0)
 ;;=3^Pathological fracture, right humerus, init for fx
 ;;^UTILITY(U,$J,358.3,37412,1,4,0)
 ;;=4^M84.421A
 ;;^UTILITY(U,$J,358.3,37412,2)
 ;;=^5013818
 ;;^UTILITY(U,$J,358.3,37413,0)
 ;;=S42.202A^^172^1883^5
 ;;^UTILITY(U,$J,358.3,37413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37413,1,3,0)
 ;;=3^Fracture of upper end of left humerus, init for clos fx,Unspec
 ;;^UTILITY(U,$J,358.3,37413,1,4,0)
 ;;=4^S42.202A
 ;;^UTILITY(U,$J,358.3,37413,2)
 ;;=^5026768
 ;;^UTILITY(U,$J,358.3,37414,0)
 ;;=S42.201A^^172^1883^7
 ;;^UTILITY(U,$J,358.3,37414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37414,1,3,0)
 ;;=3^Fracture of upper end of right humerus, init,Unspec
 ;;^UTILITY(U,$J,358.3,37414,1,4,0)
 ;;=4^S42.201A
 ;;^UTILITY(U,$J,358.3,37414,2)
 ;;=^5026761
 ;;^UTILITY(U,$J,358.3,37415,0)
 ;;=S40.022D^^172^1883^2
 ;;^UTILITY(U,$J,358.3,37415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37415,1,3,0)
 ;;=3^Contusion of left upper arm, subsequent encounter
 ;;^UTILITY(U,$J,358.3,37415,1,4,0)
 ;;=4^S40.022D
