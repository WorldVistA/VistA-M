IBDEI0VO ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14278,1,3,0)
 ;;=3^Contusion of right shoulder, subsequent encounter
 ;;^UTILITY(U,$J,358.3,14278,1,4,0)
 ;;=4^S40.011D
 ;;^UTILITY(U,$J,358.3,14278,2)
 ;;=^5026154
 ;;^UTILITY(U,$J,358.3,14279,0)
 ;;=S43.102D^^55^674^18
 ;;^UTILITY(U,$J,358.3,14279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14279,1,3,0)
 ;;=3^Dislocation of left acromioclavicular joint, subs
 ;;^UTILITY(U,$J,358.3,14279,1,4,0)
 ;;=4^S43.102D
 ;;^UTILITY(U,$J,358.3,14279,2)
 ;;=^5027733
 ;;^UTILITY(U,$J,358.3,14280,0)
 ;;=S43.101D^^55^674^22
 ;;^UTILITY(U,$J,358.3,14280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14280,1,3,0)
 ;;=3^Dislocation of right acromioclavicular joint, subs
 ;;^UTILITY(U,$J,358.3,14280,1,4,0)
 ;;=4^S43.101D
 ;;^UTILITY(U,$J,358.3,14280,2)
 ;;=^5027730
 ;;^UTILITY(U,$J,358.3,14281,0)
 ;;=S43.004D^^55^674^24
 ;;^UTILITY(U,$J,358.3,14281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14281,1,3,0)
 ;;=3^Dislocation of right shoulder joint, subs encntr
 ;;^UTILITY(U,$J,358.3,14281,1,4,0)
 ;;=4^S43.004D
 ;;^UTILITY(U,$J,358.3,14281,2)
 ;;=^5027664
 ;;^UTILITY(U,$J,358.3,14282,0)
 ;;=S42.002D^^55^674^27
 ;;^UTILITY(U,$J,358.3,14282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14282,1,3,0)
 ;;=3^Fx unsp part of l clavicle, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,14282,1,4,0)
 ;;=4^S42.002D
 ;;^UTILITY(U,$J,358.3,14282,2)
 ;;=^5026378
 ;;^UTILITY(U,$J,358.3,14283,0)
 ;;=S42.001D^^55^674^28
 ;;^UTILITY(U,$J,358.3,14283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14283,1,3,0)
 ;;=3^Fx unsp part of r clavicle, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,14283,1,4,0)
 ;;=4^S42.001D
 ;;^UTILITY(U,$J,358.3,14283,2)
 ;;=^5026371
 ;;^UTILITY(U,$J,358.3,14284,0)
 ;;=S43.025D^^55^674^38
 ;;^UTILITY(U,$J,358.3,14284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14284,1,3,0)
 ;;=3^Posterior dislocation of left humerus, subsequent encounter
 ;;^UTILITY(U,$J,358.3,14284,1,4,0)
 ;;=4^S43.025D
 ;;^UTILITY(U,$J,358.3,14284,2)
 ;;=^5027700
 ;;^UTILITY(U,$J,358.3,14285,0)
 ;;=S43.024D^^55^674^40
 ;;^UTILITY(U,$J,358.3,14285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14285,1,3,0)
 ;;=3^Posterior dislocation of right humerus, subsequent encounter
 ;;^UTILITY(U,$J,358.3,14285,1,4,0)
 ;;=4^S43.024D
 ;;^UTILITY(U,$J,358.3,14285,2)
 ;;=^5027697
 ;;^UTILITY(U,$J,358.3,14286,0)
 ;;=M19.111^^55^674^36
 ;;^UTILITY(U,$J,358.3,14286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14286,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, right shoulder
 ;;^UTILITY(U,$J,358.3,14286,1,4,0)
 ;;=4^M19.111
 ;;^UTILITY(U,$J,358.3,14286,2)
 ;;=^5010823
 ;;^UTILITY(U,$J,358.3,14287,0)
 ;;=M19.112^^55^674^35
 ;;^UTILITY(U,$J,358.3,14287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14287,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, left shoulder
 ;;^UTILITY(U,$J,358.3,14287,1,4,0)
 ;;=4^M19.112
 ;;^UTILITY(U,$J,358.3,14287,2)
 ;;=^5010824
 ;;^UTILITY(U,$J,358.3,14288,0)
 ;;=M19.211^^55^674^48
 ;;^UTILITY(U,$J,358.3,14288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14288,1,3,0)
 ;;=3^Secondary osteoarthritis, right shoulder
 ;;^UTILITY(U,$J,358.3,14288,1,4,0)
 ;;=4^M19.211
 ;;^UTILITY(U,$J,358.3,14288,2)
 ;;=^5010838
 ;;^UTILITY(U,$J,358.3,14289,0)
 ;;=M19.212^^55^674^47
 ;;^UTILITY(U,$J,358.3,14289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14289,1,3,0)
 ;;=3^Secondary osteoarthritis, left shoulder
 ;;^UTILITY(U,$J,358.3,14289,1,4,0)
 ;;=4^M19.212
