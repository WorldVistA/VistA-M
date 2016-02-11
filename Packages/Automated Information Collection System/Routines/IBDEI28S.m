IBDEI28S ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37649,2)
 ;;=^5010838
 ;;^UTILITY(U,$J,358.3,37650,0)
 ;;=M19.212^^172^1888^47
 ;;^UTILITY(U,$J,358.3,37650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37650,1,3,0)
 ;;=3^Secondary osteoarthritis, left shoulder
 ;;^UTILITY(U,$J,358.3,37650,1,4,0)
 ;;=4^M19.212
 ;;^UTILITY(U,$J,358.3,37650,2)
 ;;=^5010839
 ;;^UTILITY(U,$J,358.3,37651,0)
 ;;=S43.005D^^172^1888^20
 ;;^UTILITY(U,$J,358.3,37651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37651,1,3,0)
 ;;=3^Dislocation of left shoulder joint, subs encntr
 ;;^UTILITY(U,$J,358.3,37651,1,4,0)
 ;;=4^S43.005D
 ;;^UTILITY(U,$J,358.3,37651,2)
 ;;=^5027667
 ;;^UTILITY(U,$J,358.3,37652,0)
 ;;=M80.072A^^172^1889^3
 ;;^UTILITY(U,$J,358.3,37652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37652,1,3,0)
 ;;=3^Age-rel osteopor w current path fracture, left ank/ft, init
 ;;^UTILITY(U,$J,358.3,37652,1,4,0)
 ;;=4^M80.072A
 ;;^UTILITY(U,$J,358.3,37652,2)
 ;;=^5013483
 ;;^UTILITY(U,$J,358.3,37653,0)
 ;;=M80.071A^^172^1889^4
 ;;^UTILITY(U,$J,358.3,37653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37653,1,3,0)
 ;;=3^Age-rel osteopor w current path fracture, right ank/ft, init
 ;;^UTILITY(U,$J,358.3,37653,1,4,0)
 ;;=4^M80.071A
 ;;^UTILITY(U,$J,358.3,37653,2)
 ;;=^5013477
 ;;^UTILITY(U,$J,358.3,37654,0)
 ;;=S80.12XA^^172^1889^5
 ;;^UTILITY(U,$J,358.3,37654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37654,1,3,0)
 ;;=3^Contusion of left lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,37654,1,4,0)
 ;;=4^S80.12XA
 ;;^UTILITY(U,$J,358.3,37654,2)
 ;;=^5039903
 ;;^UTILITY(U,$J,358.3,37655,0)
 ;;=S80.11XA^^172^1889^7
 ;;^UTILITY(U,$J,358.3,37655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37655,1,3,0)
 ;;=3^Contusion of right lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,37655,1,4,0)
 ;;=4^S80.11XA
 ;;^UTILITY(U,$J,358.3,37655,2)
 ;;=^5039900
 ;;^UTILITY(U,$J,358.3,37656,0)
 ;;=S82.425A^^172^1889^17
 ;;^UTILITY(U,$J,358.3,37656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37656,1,3,0)
 ;;=3^Nondisp transverse fracture of shaft of left fibula, init
 ;;^UTILITY(U,$J,358.3,37656,1,4,0)
 ;;=4^S82.425A
 ;;^UTILITY(U,$J,358.3,37656,2)
 ;;=^5041778
 ;;^UTILITY(U,$J,358.3,37657,0)
 ;;=S82.424A^^172^1889^18
 ;;^UTILITY(U,$J,358.3,37657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37657,1,3,0)
 ;;=3^Nondisp transverse fracture of shaft of right fibula, init
 ;;^UTILITY(U,$J,358.3,37657,1,4,0)
 ;;=4^S82.424A
 ;;^UTILITY(U,$J,358.3,37657,2)
 ;;=^5041762
 ;;^UTILITY(U,$J,358.3,37658,0)
 ;;=S82.292A^^172^1889^9
 ;;^UTILITY(U,$J,358.3,37658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37658,1,3,0)
 ;;=3^Fracture of shaft of left tibia, init for clos fx NEC
 ;;^UTILITY(U,$J,358.3,37658,1,4,0)
 ;;=4^S82.292A
 ;;^UTILITY(U,$J,358.3,37658,2)
 ;;=^5136798
 ;;^UTILITY(U,$J,358.3,37659,0)
 ;;=S82.291A^^172^1889^10
 ;;^UTILITY(U,$J,358.3,37659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37659,1,3,0)
 ;;=3^Fracture of shaft of right tibia, init for clos fx NEC
 ;;^UTILITY(U,$J,358.3,37659,1,4,0)
 ;;=4^S82.291A
 ;;^UTILITY(U,$J,358.3,37659,2)
 ;;=^5041619
 ;;^UTILITY(U,$J,358.3,37660,0)
 ;;=M79.672^^172^1889^21
 ;;^UTILITY(U,$J,358.3,37660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37660,1,3,0)
 ;;=3^Pain in left foot
 ;;^UTILITY(U,$J,358.3,37660,1,4,0)
 ;;=4^M79.672
 ;;^UTILITY(U,$J,358.3,37660,2)
 ;;=^5013351
 ;;^UTILITY(U,$J,358.3,37661,0)
 ;;=M79.605^^172^1889^22
 ;;^UTILITY(U,$J,358.3,37661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37661,1,3,0)
 ;;=3^Pain in left leg
 ;;^UTILITY(U,$J,358.3,37661,1,4,0)
 ;;=4^M79.605
 ;;^UTILITY(U,$J,358.3,37661,2)
 ;;=^5013329
