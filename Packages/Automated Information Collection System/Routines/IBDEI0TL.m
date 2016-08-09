IBDEI0TL ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29776,1,3,0)
 ;;=3^Dislocation of right acromioclavicular joint, subs
 ;;^UTILITY(U,$J,358.3,29776,1,4,0)
 ;;=4^S43.101D
 ;;^UTILITY(U,$J,358.3,29776,2)
 ;;=^5027730
 ;;^UTILITY(U,$J,358.3,29777,0)
 ;;=S43.004D^^111^1432^24
 ;;^UTILITY(U,$J,358.3,29777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29777,1,3,0)
 ;;=3^Dislocation of right shoulder joint, subs encntr
 ;;^UTILITY(U,$J,358.3,29777,1,4,0)
 ;;=4^S43.004D
 ;;^UTILITY(U,$J,358.3,29777,2)
 ;;=^5027664
 ;;^UTILITY(U,$J,358.3,29778,0)
 ;;=S42.002D^^111^1432^27
 ;;^UTILITY(U,$J,358.3,29778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29778,1,3,0)
 ;;=3^Fx unsp part of l clavicle, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,29778,1,4,0)
 ;;=4^S42.002D
 ;;^UTILITY(U,$J,358.3,29778,2)
 ;;=^5026378
 ;;^UTILITY(U,$J,358.3,29779,0)
 ;;=S42.001D^^111^1432^28
 ;;^UTILITY(U,$J,358.3,29779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29779,1,3,0)
 ;;=3^Fx unsp part of r clavicle, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,29779,1,4,0)
 ;;=4^S42.001D
 ;;^UTILITY(U,$J,358.3,29779,2)
 ;;=^5026371
 ;;^UTILITY(U,$J,358.3,29780,0)
 ;;=S43.025D^^111^1432^38
 ;;^UTILITY(U,$J,358.3,29780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29780,1,3,0)
 ;;=3^Posterior dislocation of left humerus, subsequent encounter
 ;;^UTILITY(U,$J,358.3,29780,1,4,0)
 ;;=4^S43.025D
 ;;^UTILITY(U,$J,358.3,29780,2)
 ;;=^5027700
 ;;^UTILITY(U,$J,358.3,29781,0)
 ;;=S43.024D^^111^1432^40
 ;;^UTILITY(U,$J,358.3,29781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29781,1,3,0)
 ;;=3^Posterior dislocation of right humerus, subsequent encounter
 ;;^UTILITY(U,$J,358.3,29781,1,4,0)
 ;;=4^S43.024D
 ;;^UTILITY(U,$J,358.3,29781,2)
 ;;=^5027697
 ;;^UTILITY(U,$J,358.3,29782,0)
 ;;=M19.111^^111^1432^36
 ;;^UTILITY(U,$J,358.3,29782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29782,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, right shoulder
 ;;^UTILITY(U,$J,358.3,29782,1,4,0)
 ;;=4^M19.111
 ;;^UTILITY(U,$J,358.3,29782,2)
 ;;=^5010823
 ;;^UTILITY(U,$J,358.3,29783,0)
 ;;=M19.112^^111^1432^35
 ;;^UTILITY(U,$J,358.3,29783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29783,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, left shoulder
 ;;^UTILITY(U,$J,358.3,29783,1,4,0)
 ;;=4^M19.112
 ;;^UTILITY(U,$J,358.3,29783,2)
 ;;=^5010824
 ;;^UTILITY(U,$J,358.3,29784,0)
 ;;=M19.211^^111^1432^48
 ;;^UTILITY(U,$J,358.3,29784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29784,1,3,0)
 ;;=3^Secondary osteoarthritis, right shoulder
 ;;^UTILITY(U,$J,358.3,29784,1,4,0)
 ;;=4^M19.211
 ;;^UTILITY(U,$J,358.3,29784,2)
 ;;=^5010838
 ;;^UTILITY(U,$J,358.3,29785,0)
 ;;=M19.212^^111^1432^47
 ;;^UTILITY(U,$J,358.3,29785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29785,1,3,0)
 ;;=3^Secondary osteoarthritis, left shoulder
 ;;^UTILITY(U,$J,358.3,29785,1,4,0)
 ;;=4^M19.212
 ;;^UTILITY(U,$J,358.3,29785,2)
 ;;=^5010839
 ;;^UTILITY(U,$J,358.3,29786,0)
 ;;=S43.005D^^111^1432^20
 ;;^UTILITY(U,$J,358.3,29786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29786,1,3,0)
 ;;=3^Dislocation of left shoulder joint, subs encntr
 ;;^UTILITY(U,$J,358.3,29786,1,4,0)
 ;;=4^S43.005D
 ;;^UTILITY(U,$J,358.3,29786,2)
 ;;=^5027667
 ;;^UTILITY(U,$J,358.3,29787,0)
 ;;=M80.072A^^111^1433^3
 ;;^UTILITY(U,$J,358.3,29787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29787,1,3,0)
 ;;=3^Age-rel osteopor w current path fracture, left ank/ft, init
 ;;^UTILITY(U,$J,358.3,29787,1,4,0)
 ;;=4^M80.072A
 ;;^UTILITY(U,$J,358.3,29787,2)
 ;;=^5013483
 ;;^UTILITY(U,$J,358.3,29788,0)
 ;;=M80.071A^^111^1433^4
 ;;^UTILITY(U,$J,358.3,29788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29788,1,3,0)
 ;;=3^Age-rel osteopor w current path fracture, right ank/ft, init
 ;;^UTILITY(U,$J,358.3,29788,1,4,0)
 ;;=4^M80.071A
 ;;^UTILITY(U,$J,358.3,29788,2)
 ;;=^5013477
 ;;^UTILITY(U,$J,358.3,29789,0)
 ;;=S80.12XA^^111^1433^5
 ;;^UTILITY(U,$J,358.3,29789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29789,1,3,0)
 ;;=3^Contusion of left lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,29789,1,4,0)
 ;;=4^S80.12XA
 ;;^UTILITY(U,$J,358.3,29789,2)
 ;;=^5039903
 ;;^UTILITY(U,$J,358.3,29790,0)
 ;;=S80.11XA^^111^1433^7
 ;;^UTILITY(U,$J,358.3,29790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29790,1,3,0)
 ;;=3^Contusion of right lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,29790,1,4,0)
 ;;=4^S80.11XA
 ;;^UTILITY(U,$J,358.3,29790,2)
 ;;=^5039900
 ;;^UTILITY(U,$J,358.3,29791,0)
 ;;=S82.425A^^111^1433^17
 ;;^UTILITY(U,$J,358.3,29791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29791,1,3,0)
 ;;=3^Nondisp transverse fracture of shaft of left fibula, init
 ;;^UTILITY(U,$J,358.3,29791,1,4,0)
 ;;=4^S82.425A
 ;;^UTILITY(U,$J,358.3,29791,2)
 ;;=^5041778
 ;;^UTILITY(U,$J,358.3,29792,0)
 ;;=S82.424A^^111^1433^18
 ;;^UTILITY(U,$J,358.3,29792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29792,1,3,0)
 ;;=3^Nondisp transverse fracture of shaft of right fibula, init
 ;;^UTILITY(U,$J,358.3,29792,1,4,0)
 ;;=4^S82.424A
 ;;^UTILITY(U,$J,358.3,29792,2)
 ;;=^5041762
 ;;^UTILITY(U,$J,358.3,29793,0)
 ;;=S82.292A^^111^1433^9
 ;;^UTILITY(U,$J,358.3,29793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29793,1,3,0)
 ;;=3^Fracture of shaft of left tibia, init for clos fx NEC
 ;;^UTILITY(U,$J,358.3,29793,1,4,0)
 ;;=4^S82.292A
 ;;^UTILITY(U,$J,358.3,29793,2)
 ;;=^5136798
 ;;^UTILITY(U,$J,358.3,29794,0)
 ;;=S82.291A^^111^1433^10
 ;;^UTILITY(U,$J,358.3,29794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29794,1,3,0)
 ;;=3^Fracture of shaft of right tibia, init for clos fx NEC
 ;;^UTILITY(U,$J,358.3,29794,1,4,0)
 ;;=4^S82.291A
 ;;^UTILITY(U,$J,358.3,29794,2)
 ;;=^5041619
 ;;^UTILITY(U,$J,358.3,29795,0)
 ;;=M79.672^^111^1433^21
 ;;^UTILITY(U,$J,358.3,29795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29795,1,3,0)
 ;;=3^Pain in left foot
 ;;^UTILITY(U,$J,358.3,29795,1,4,0)
 ;;=4^M79.672
 ;;^UTILITY(U,$J,358.3,29795,2)
 ;;=^5013351
 ;;^UTILITY(U,$J,358.3,29796,0)
 ;;=M79.605^^111^1433^22
 ;;^UTILITY(U,$J,358.3,29796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29796,1,3,0)
 ;;=3^Pain in left leg
 ;;^UTILITY(U,$J,358.3,29796,1,4,0)
 ;;=4^M79.605
 ;;^UTILITY(U,$J,358.3,29796,2)
 ;;=^5013329
 ;;^UTILITY(U,$J,358.3,29797,0)
 ;;=M79.662^^111^1433^23
 ;;^UTILITY(U,$J,358.3,29797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29797,1,3,0)
 ;;=3^Pain in left lower leg
 ;;^UTILITY(U,$J,358.3,29797,1,4,0)
 ;;=4^M79.662
 ;;^UTILITY(U,$J,358.3,29797,2)
 ;;=^5013348
 ;;^UTILITY(U,$J,358.3,29798,0)
 ;;=M79.652^^111^1433^24
 ;;^UTILITY(U,$J,358.3,29798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29798,1,3,0)
 ;;=3^Pain in left thigh
 ;;^UTILITY(U,$J,358.3,29798,1,4,0)
 ;;=4^M79.652
 ;;^UTILITY(U,$J,358.3,29798,2)
 ;;=^5013345
 ;;^UTILITY(U,$J,358.3,29799,0)
 ;;=M79.675^^111^1433^25
 ;;^UTILITY(U,$J,358.3,29799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29799,1,3,0)
 ;;=3^Pain in left toe(s)
 ;;^UTILITY(U,$J,358.3,29799,1,4,0)
 ;;=4^M79.675
 ;;^UTILITY(U,$J,358.3,29799,2)
 ;;=^5013354
 ;;^UTILITY(U,$J,358.3,29800,0)
 ;;=M79.671^^111^1433^26
 ;;^UTILITY(U,$J,358.3,29800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29800,1,3,0)
 ;;=3^Pain in right foot
 ;;^UTILITY(U,$J,358.3,29800,1,4,0)
 ;;=4^M79.671
 ;;^UTILITY(U,$J,358.3,29800,2)
 ;;=^5013350
 ;;^UTILITY(U,$J,358.3,29801,0)
 ;;=M79.604^^111^1433^27
 ;;^UTILITY(U,$J,358.3,29801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29801,1,3,0)
 ;;=3^Pain in right leg
 ;;^UTILITY(U,$J,358.3,29801,1,4,0)
 ;;=4^M79.604
 ;;^UTILITY(U,$J,358.3,29801,2)
 ;;=^5013328
 ;;^UTILITY(U,$J,358.3,29802,0)
 ;;=M79.661^^111^1433^28
 ;;^UTILITY(U,$J,358.3,29802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29802,1,3,0)
 ;;=3^Pain in right lower leg
 ;;^UTILITY(U,$J,358.3,29802,1,4,0)
 ;;=4^M79.661
