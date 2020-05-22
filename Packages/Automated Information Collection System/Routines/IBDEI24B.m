IBDEI24B ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33837,1,3,0)
 ;;=3^Traumatic arthropathy, left shoulder
 ;;^UTILITY(U,$J,358.3,33837,1,4,0)
 ;;=4^M12.512
 ;;^UTILITY(U,$J,358.3,33837,2)
 ;;=^5010620
 ;;^UTILITY(U,$J,358.3,33838,0)
 ;;=M12.511^^132^1712^50
 ;;^UTILITY(U,$J,358.3,33838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33838,1,3,0)
 ;;=3^Traumatic arthropathy, right shoulder
 ;;^UTILITY(U,$J,358.3,33838,1,4,0)
 ;;=4^M12.511
 ;;^UTILITY(U,$J,358.3,33838,2)
 ;;=^5010619
 ;;^UTILITY(U,$J,358.3,33839,0)
 ;;=S43.102A^^132^1712^17
 ;;^UTILITY(U,$J,358.3,33839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33839,1,3,0)
 ;;=3^Dislocation of left acromioclavicular joint, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,33839,1,4,0)
 ;;=4^S43.102A
 ;;^UTILITY(U,$J,358.3,33839,2)
 ;;=^5027732
 ;;^UTILITY(U,$J,358.3,33840,0)
 ;;=S43.005A^^132^1712^19
 ;;^UTILITY(U,$J,358.3,33840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33840,1,3,0)
 ;;=3^Dislocation of left shoulder joint, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,33840,1,4,0)
 ;;=4^S43.005A
 ;;^UTILITY(U,$J,358.3,33840,2)
 ;;=^5027666
 ;;^UTILITY(U,$J,358.3,33841,0)
 ;;=S43.101A^^132^1712^21
 ;;^UTILITY(U,$J,358.3,33841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33841,1,3,0)
 ;;=3^Dislocation of right acromioclavicular joint, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,33841,1,4,0)
 ;;=4^S43.101A
 ;;^UTILITY(U,$J,358.3,33841,2)
 ;;=^5027729
 ;;^UTILITY(U,$J,358.3,33842,0)
 ;;=S43.004A^^132^1712^23
 ;;^UTILITY(U,$J,358.3,33842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33842,1,3,0)
 ;;=3^Dislocation of right shoulder joint, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,33842,1,4,0)
 ;;=4^S43.004A
 ;;^UTILITY(U,$J,358.3,33842,2)
 ;;=^5027663
 ;;^UTILITY(U,$J,358.3,33843,0)
 ;;=S40.012D^^132^1712^14
 ;;^UTILITY(U,$J,358.3,33843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33843,1,3,0)
 ;;=3^Contusion of left shoulder, subsequent encounter
 ;;^UTILITY(U,$J,358.3,33843,1,4,0)
 ;;=4^S40.012D
 ;;^UTILITY(U,$J,358.3,33843,2)
 ;;=^5026157
 ;;^UTILITY(U,$J,358.3,33844,0)
 ;;=S40.011D^^132^1712^16
 ;;^UTILITY(U,$J,358.3,33844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33844,1,3,0)
 ;;=3^Contusion of right shoulder, subsequent encounter
 ;;^UTILITY(U,$J,358.3,33844,1,4,0)
 ;;=4^S40.011D
 ;;^UTILITY(U,$J,358.3,33844,2)
 ;;=^5026154
 ;;^UTILITY(U,$J,358.3,33845,0)
 ;;=S43.102D^^132^1712^18
 ;;^UTILITY(U,$J,358.3,33845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33845,1,3,0)
 ;;=3^Dislocation of left acromioclavicular joint, subs
 ;;^UTILITY(U,$J,358.3,33845,1,4,0)
 ;;=4^S43.102D
 ;;^UTILITY(U,$J,358.3,33845,2)
 ;;=^5027733
 ;;^UTILITY(U,$J,358.3,33846,0)
 ;;=S43.101D^^132^1712^22
 ;;^UTILITY(U,$J,358.3,33846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33846,1,3,0)
 ;;=3^Dislocation of right acromioclavicular joint, subs
 ;;^UTILITY(U,$J,358.3,33846,1,4,0)
 ;;=4^S43.101D
 ;;^UTILITY(U,$J,358.3,33846,2)
 ;;=^5027730
 ;;^UTILITY(U,$J,358.3,33847,0)
 ;;=S43.004D^^132^1712^24
 ;;^UTILITY(U,$J,358.3,33847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33847,1,3,0)
 ;;=3^Dislocation of right shoulder joint, subs encntr
 ;;^UTILITY(U,$J,358.3,33847,1,4,0)
 ;;=4^S43.004D
 ;;^UTILITY(U,$J,358.3,33847,2)
 ;;=^5027664
 ;;^UTILITY(U,$J,358.3,33848,0)
 ;;=S42.002D^^132^1712^27
 ;;^UTILITY(U,$J,358.3,33848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33848,1,3,0)
 ;;=3^Fx unsp part of l clavicle, subs for fx w routn heal
