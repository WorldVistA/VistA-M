IBDEI1RA ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31032,1,4,0)
 ;;=4^M12.511
 ;;^UTILITY(U,$J,358.3,31032,2)
 ;;=^5010619
 ;;^UTILITY(U,$J,358.3,31033,0)
 ;;=S43.102A^^179^1938^15
 ;;^UTILITY(U,$J,358.3,31033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31033,1,3,0)
 ;;=3^Dislocation of left acromioclavicular joint, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31033,1,4,0)
 ;;=4^S43.102A
 ;;^UTILITY(U,$J,358.3,31033,2)
 ;;=^5027732
 ;;^UTILITY(U,$J,358.3,31034,0)
 ;;=S43.005A^^179^1938^16
 ;;^UTILITY(U,$J,358.3,31034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31034,1,3,0)
 ;;=3^Dislocation of left shoulder joint, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31034,1,4,0)
 ;;=4^S43.005A
 ;;^UTILITY(U,$J,358.3,31034,2)
 ;;=^5027666
 ;;^UTILITY(U,$J,358.3,31035,0)
 ;;=S43.101A^^179^1938^17
 ;;^UTILITY(U,$J,358.3,31035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31035,1,3,0)
 ;;=3^Dislocation of right acromioclavicular joint, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31035,1,4,0)
 ;;=4^S43.101A
 ;;^UTILITY(U,$J,358.3,31035,2)
 ;;=^5027729
 ;;^UTILITY(U,$J,358.3,31036,0)
 ;;=S43.004A^^179^1938^18
 ;;^UTILITY(U,$J,358.3,31036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31036,1,3,0)
 ;;=3^Dislocation of right shoulder joint, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31036,1,4,0)
 ;;=4^S43.004A
 ;;^UTILITY(U,$J,358.3,31036,2)
 ;;=^5027663
 ;;^UTILITY(U,$J,358.3,31037,0)
 ;;=M80.072A^^179^1939^1
 ;;^UTILITY(U,$J,358.3,31037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31037,1,3,0)
 ;;=3^Age-rel osteopor w current path fracture, left ank/ft, init
 ;;^UTILITY(U,$J,358.3,31037,1,4,0)
 ;;=4^M80.072A
 ;;^UTILITY(U,$J,358.3,31037,2)
 ;;=^5013483
 ;;^UTILITY(U,$J,358.3,31038,0)
 ;;=M80.071A^^179^1939^2
 ;;^UTILITY(U,$J,358.3,31038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31038,1,3,0)
 ;;=3^Age-rel osteopor w current path fracture, right ank/ft, init
 ;;^UTILITY(U,$J,358.3,31038,1,4,0)
 ;;=4^M80.071A
 ;;^UTILITY(U,$J,358.3,31038,2)
 ;;=^5013477
 ;;^UTILITY(U,$J,358.3,31039,0)
 ;;=S80.12XA^^179^1939^3
 ;;^UTILITY(U,$J,358.3,31039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31039,1,3,0)
 ;;=3^Contusion of left lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,31039,1,4,0)
 ;;=4^S80.12XA
 ;;^UTILITY(U,$J,358.3,31039,2)
 ;;=^5039903
 ;;^UTILITY(U,$J,358.3,31040,0)
 ;;=S80.11XA^^179^1939^4
 ;;^UTILITY(U,$J,358.3,31040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31040,1,3,0)
 ;;=3^Contusion of right lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,31040,1,4,0)
 ;;=4^S80.11XA
 ;;^UTILITY(U,$J,358.3,31040,2)
 ;;=^5039900
 ;;^UTILITY(U,$J,358.3,31041,0)
 ;;=S82.425A^^179^1939^9
 ;;^UTILITY(U,$J,358.3,31041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31041,1,3,0)
 ;;=3^Nondisp transverse fracture of shaft of left fibula, init
 ;;^UTILITY(U,$J,358.3,31041,1,4,0)
 ;;=4^S82.425A
 ;;^UTILITY(U,$J,358.3,31041,2)
 ;;=^5041778
 ;;^UTILITY(U,$J,358.3,31042,0)
 ;;=S82.424A^^179^1939^10
 ;;^UTILITY(U,$J,358.3,31042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31042,1,3,0)
 ;;=3^Nondisp transverse fracture of shaft of right fibula, init
 ;;^UTILITY(U,$J,358.3,31042,1,4,0)
 ;;=4^S82.424A
 ;;^UTILITY(U,$J,358.3,31042,2)
 ;;=^5041762
 ;;^UTILITY(U,$J,358.3,31043,0)
 ;;=S82.292A^^179^1939^5
 ;;^UTILITY(U,$J,358.3,31043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31043,1,3,0)
 ;;=3^Fracture of shaft of left tibia, init for clos fx NEC
 ;;^UTILITY(U,$J,358.3,31043,1,4,0)
 ;;=4^S82.292A
 ;;^UTILITY(U,$J,358.3,31043,2)
 ;;=^5136798
 ;;^UTILITY(U,$J,358.3,31044,0)
 ;;=S82.291A^^179^1939^6
 ;;^UTILITY(U,$J,358.3,31044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31044,1,3,0)
 ;;=3^Fracture of shaft of right tibia, init for clos fx NEC
