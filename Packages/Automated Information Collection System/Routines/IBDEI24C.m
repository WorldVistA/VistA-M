IBDEI24C ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33848,1,4,0)
 ;;=4^S42.002D
 ;;^UTILITY(U,$J,358.3,33848,2)
 ;;=^5026378
 ;;^UTILITY(U,$J,358.3,33849,0)
 ;;=S42.001D^^132^1712^28
 ;;^UTILITY(U,$J,358.3,33849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33849,1,3,0)
 ;;=3^Fx unsp part of r clavicle, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,33849,1,4,0)
 ;;=4^S42.001D
 ;;^UTILITY(U,$J,358.3,33849,2)
 ;;=^5026371
 ;;^UTILITY(U,$J,358.3,33850,0)
 ;;=S43.025D^^132^1712^38
 ;;^UTILITY(U,$J,358.3,33850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33850,1,3,0)
 ;;=3^Posterior dislocation of left humerus, subsequent encounter
 ;;^UTILITY(U,$J,358.3,33850,1,4,0)
 ;;=4^S43.025D
 ;;^UTILITY(U,$J,358.3,33850,2)
 ;;=^5027700
 ;;^UTILITY(U,$J,358.3,33851,0)
 ;;=S43.024D^^132^1712^40
 ;;^UTILITY(U,$J,358.3,33851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33851,1,3,0)
 ;;=3^Posterior dislocation of right humerus, subsequent encounter
 ;;^UTILITY(U,$J,358.3,33851,1,4,0)
 ;;=4^S43.024D
 ;;^UTILITY(U,$J,358.3,33851,2)
 ;;=^5027697
 ;;^UTILITY(U,$J,358.3,33852,0)
 ;;=M19.111^^132^1712^36
 ;;^UTILITY(U,$J,358.3,33852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33852,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, right shoulder
 ;;^UTILITY(U,$J,358.3,33852,1,4,0)
 ;;=4^M19.111
 ;;^UTILITY(U,$J,358.3,33852,2)
 ;;=^5010823
 ;;^UTILITY(U,$J,358.3,33853,0)
 ;;=M19.112^^132^1712^35
 ;;^UTILITY(U,$J,358.3,33853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33853,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, left shoulder
 ;;^UTILITY(U,$J,358.3,33853,1,4,0)
 ;;=4^M19.112
 ;;^UTILITY(U,$J,358.3,33853,2)
 ;;=^5010824
 ;;^UTILITY(U,$J,358.3,33854,0)
 ;;=M19.211^^132^1712^48
 ;;^UTILITY(U,$J,358.3,33854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33854,1,3,0)
 ;;=3^Secondary osteoarthritis, right shoulder
 ;;^UTILITY(U,$J,358.3,33854,1,4,0)
 ;;=4^M19.211
 ;;^UTILITY(U,$J,358.3,33854,2)
 ;;=^5010838
 ;;^UTILITY(U,$J,358.3,33855,0)
 ;;=M19.212^^132^1712^47
 ;;^UTILITY(U,$J,358.3,33855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33855,1,3,0)
 ;;=3^Secondary osteoarthritis, left shoulder
 ;;^UTILITY(U,$J,358.3,33855,1,4,0)
 ;;=4^M19.212
 ;;^UTILITY(U,$J,358.3,33855,2)
 ;;=^5010839
 ;;^UTILITY(U,$J,358.3,33856,0)
 ;;=S43.005D^^132^1712^20
 ;;^UTILITY(U,$J,358.3,33856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33856,1,3,0)
 ;;=3^Dislocation of left shoulder joint, subs encntr
 ;;^UTILITY(U,$J,358.3,33856,1,4,0)
 ;;=4^S43.005D
 ;;^UTILITY(U,$J,358.3,33856,2)
 ;;=^5027667
 ;;^UTILITY(U,$J,358.3,33857,0)
 ;;=M80.072A^^132^1713^3
 ;;^UTILITY(U,$J,358.3,33857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33857,1,3,0)
 ;;=3^Age-rel osteopor w current path fracture, left ank/ft, init
 ;;^UTILITY(U,$J,358.3,33857,1,4,0)
 ;;=4^M80.072A
 ;;^UTILITY(U,$J,358.3,33857,2)
 ;;=^5013483
 ;;^UTILITY(U,$J,358.3,33858,0)
 ;;=M80.071A^^132^1713^4
 ;;^UTILITY(U,$J,358.3,33858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33858,1,3,0)
 ;;=3^Age-rel osteopor w current path fracture, right ank/ft, init
 ;;^UTILITY(U,$J,358.3,33858,1,4,0)
 ;;=4^M80.071A
 ;;^UTILITY(U,$J,358.3,33858,2)
 ;;=^5013477
 ;;^UTILITY(U,$J,358.3,33859,0)
 ;;=S80.12XA^^132^1713^5
 ;;^UTILITY(U,$J,358.3,33859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33859,1,3,0)
 ;;=3^Contusion of left lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,33859,1,4,0)
 ;;=4^S80.12XA
 ;;^UTILITY(U,$J,358.3,33859,2)
 ;;=^5039903
