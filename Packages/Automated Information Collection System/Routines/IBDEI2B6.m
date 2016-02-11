IBDEI2B6 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38771,2)
 ;;=^5010820
 ;;^UTILITY(U,$J,358.3,38772,0)
 ;;=M19.041^^180^1985^24
 ;;^UTILITY(U,$J,358.3,38772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38772,1,3,0)
 ;;=3^Primary osteoarthritis, right hand
 ;;^UTILITY(U,$J,358.3,38772,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,38772,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,38773,0)
 ;;=M19.011^^180^1985^25
 ;;^UTILITY(U,$J,358.3,38773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38773,1,3,0)
 ;;=3^Primary osteoarthritis, right shoulder
 ;;^UTILITY(U,$J,358.3,38773,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,38773,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,38774,0)
 ;;=M76.12^^180^1985^26
 ;;^UTILITY(U,$J,358.3,38774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38774,1,3,0)
 ;;=3^Psoas tendinitis, left hip
 ;;^UTILITY(U,$J,358.3,38774,1,4,0)
 ;;=4^M76.12
 ;;^UTILITY(U,$J,358.3,38774,2)
 ;;=^5013271
 ;;^UTILITY(U,$J,358.3,38775,0)
 ;;=M76.11^^180^1985^27
 ;;^UTILITY(U,$J,358.3,38775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38775,1,3,0)
 ;;=3^Psoas tendinitis, right hip
 ;;^UTILITY(U,$J,358.3,38775,1,4,0)
 ;;=4^M76.11
 ;;^UTILITY(U,$J,358.3,38775,2)
 ;;=^5013270
 ;;^UTILITY(U,$J,358.3,38776,0)
 ;;=M70.62^^180^1985^58
 ;;^UTILITY(U,$J,358.3,38776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38776,1,3,0)
 ;;=3^Trochanteric bursitis, left hip
 ;;^UTILITY(U,$J,358.3,38776,1,4,0)
 ;;=4^M70.62
 ;;^UTILITY(U,$J,358.3,38776,2)
 ;;=^5013060
 ;;^UTILITY(U,$J,358.3,38777,0)
 ;;=M70.61^^180^1985^59
 ;;^UTILITY(U,$J,358.3,38777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38777,1,3,0)
 ;;=3^Trochanteric bursitis, right hip
 ;;^UTILITY(U,$J,358.3,38777,1,4,0)
 ;;=4^M70.61
 ;;^UTILITY(U,$J,358.3,38777,2)
 ;;=^5013059
 ;;^UTILITY(U,$J,358.3,38778,0)
 ;;=S22.9XXS^^180^1986^6
 ;;^UTILITY(U,$J,358.3,38778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38778,1,3,0)
 ;;=3^Fracture of bony thorax, part unspecified, sequela
 ;;^UTILITY(U,$J,358.3,38778,1,4,0)
 ;;=4^S22.9XXS
 ;;^UTILITY(U,$J,358.3,38778,2)
 ;;=^5023158
 ;;^UTILITY(U,$J,358.3,38779,0)
 ;;=S42.92XS^^180^1986^14
 ;;^UTILITY(U,$J,358.3,38779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38779,1,3,0)
 ;;=3^Fracture of left shoulder girdle, part unspecified, sequela
 ;;^UTILITY(U,$J,358.3,38779,1,4,0)
 ;;=4^S42.92XS
 ;;^UTILITY(U,$J,358.3,38779,2)
 ;;=^5027656
 ;;^UTILITY(U,$J,358.3,38780,0)
 ;;=S12.9XXS^^180^1986^21
 ;;^UTILITY(U,$J,358.3,38780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38780,1,3,0)
 ;;=3^Fracture of neck, unspecified, sequela
 ;;^UTILITY(U,$J,358.3,38780,1,4,0)
 ;;=4^S12.9XXS
 ;;^UTILITY(U,$J,358.3,38780,2)
 ;;=^5021964
 ;;^UTILITY(U,$J,358.3,38781,0)
 ;;=S42.91XS^^180^1986^31
 ;;^UTILITY(U,$J,358.3,38781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38781,1,3,0)
 ;;=3^Fracture of right shoulder girdle, part unspecified, sequela
 ;;^UTILITY(U,$J,358.3,38781,1,4,0)
 ;;=4^S42.91XS
 ;;^UTILITY(U,$J,358.3,38781,2)
 ;;=^5027649
 ;;^UTILITY(U,$J,358.3,38782,0)
 ;;=S72.001S^^180^1986^40
 ;;^UTILITY(U,$J,358.3,38782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38782,1,3,0)
 ;;=3^Fracture of unspecified part of neck of right femur, sequela
 ;;^UTILITY(U,$J,358.3,38782,1,4,0)
 ;;=4^S72.001S
 ;;^UTILITY(U,$J,358.3,38782,2)
 ;;=^5037062
 ;;^UTILITY(U,$J,358.3,38783,0)
 ;;=S32.9XXS^^180^1986^41
 ;;^UTILITY(U,$J,358.3,38783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38783,1,3,0)
 ;;=3^Fracture of unspecified parts of lumbosacral spine & pelvis, sequela
 ;;^UTILITY(U,$J,358.3,38783,1,4,0)
 ;;=4^S32.9XXS
 ;;^UTILITY(U,$J,358.3,38783,2)
 ;;=^5025126
 ;;^UTILITY(U,$J,358.3,38784,0)
 ;;=S92.902S^^180^1986^10
