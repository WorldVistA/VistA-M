IBDEI27Z ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37290,2)
 ;;=^5135082
 ;;^UTILITY(U,$J,358.3,37291,0)
 ;;=S42.402D^^172^1878^17
 ;;^UTILITY(U,$J,358.3,37291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37291,1,3,0)
 ;;=3^Fracture lower end of left humerus, subs encntr
 ;;^UTILITY(U,$J,358.3,37291,1,4,0)
 ;;=4^S42.402D
 ;;^UTILITY(U,$J,358.3,37291,2)
 ;;=^5134717
 ;;^UTILITY(U,$J,358.3,37292,0)
 ;;=S42.401D^^172^1878^18
 ;;^UTILITY(U,$J,358.3,37292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37292,1,3,0)
 ;;=3^Fracture lower end of right humerus, subs encntr
 ;;^UTILITY(U,$J,358.3,37292,1,4,0)
 ;;=4^S42.401D
 ;;^UTILITY(U,$J,358.3,37292,2)
 ;;=^5027296
 ;;^UTILITY(U,$J,358.3,37293,0)
 ;;=S52.125D^^172^1878^30
 ;;^UTILITY(U,$J,358.3,37293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37293,1,3,0)
 ;;=3^Nondisp fx of head of left radius, subs encntr
 ;;^UTILITY(U,$J,358.3,37293,1,4,0)
 ;;=4^S52.125D
 ;;^UTILITY(U,$J,358.3,37293,2)
 ;;=^5029114
 ;;^UTILITY(U,$J,358.3,37294,0)
 ;;=S52.124D^^172^1878^32
 ;;^UTILITY(U,$J,358.3,37294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37294,1,3,0)
 ;;=3^Nondisp fx of head of right radius, subs encntr
 ;;^UTILITY(U,$J,358.3,37294,1,4,0)
 ;;=4^S52.124D
 ;;^UTILITY(U,$J,358.3,37294,2)
 ;;=^5029098
 ;;^UTILITY(U,$J,358.3,37295,0)
 ;;=M19.121^^172^1878^38
 ;;^UTILITY(U,$J,358.3,37295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37295,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, right elbow
 ;;^UTILITY(U,$J,358.3,37295,1,4,0)
 ;;=4^M19.121
 ;;^UTILITY(U,$J,358.3,37295,2)
 ;;=^5010826
 ;;^UTILITY(U,$J,358.3,37296,0)
 ;;=M19.122^^172^1878^37
 ;;^UTILITY(U,$J,358.3,37296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37296,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, left elbow
 ;;^UTILITY(U,$J,358.3,37296,1,4,0)
 ;;=4^M19.122
 ;;^UTILITY(U,$J,358.3,37296,2)
 ;;=^5010827
 ;;^UTILITY(U,$J,358.3,37297,0)
 ;;=S53.402D^^172^1878^42
 ;;^UTILITY(U,$J,358.3,37297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37297,1,3,0)
 ;;=3^Sprain of left elbow, subsequent encounter
 ;;^UTILITY(U,$J,358.3,37297,1,4,0)
 ;;=4^S53.402D
 ;;^UTILITY(U,$J,358.3,37297,2)
 ;;=^5031365
 ;;^UTILITY(U,$J,358.3,37298,0)
 ;;=S53.401D^^172^1878^44
 ;;^UTILITY(U,$J,358.3,37298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37298,1,3,0)
 ;;=3^Sprain of right elbow, subsequent encounter
 ;;^UTILITY(U,$J,358.3,37298,1,4,0)
 ;;=4^S53.401D
 ;;^UTILITY(U,$J,358.3,37298,2)
 ;;=^5031362
 ;;^UTILITY(U,$J,358.3,37299,0)
 ;;=S70.12XA^^172^1879^1
 ;;^UTILITY(U,$J,358.3,37299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37299,1,3,0)
 ;;=3^Contusion of left thigh, initial encounter
 ;;^UTILITY(U,$J,358.3,37299,1,4,0)
 ;;=4^S70.12XA
 ;;^UTILITY(U,$J,358.3,37299,2)
 ;;=^5036846
 ;;^UTILITY(U,$J,358.3,37300,0)
 ;;=S70.11XA^^172^1879^3
 ;;^UTILITY(U,$J,358.3,37300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37300,1,3,0)
 ;;=3^Contusion of right thigh, initial encounter
 ;;^UTILITY(U,$J,358.3,37300,1,4,0)
 ;;=4^S70.11XA
 ;;^UTILITY(U,$J,358.3,37300,2)
 ;;=^5036843
 ;;^UTILITY(U,$J,358.3,37301,0)
 ;;=S72.352A^^172^1879^5
 ;;^UTILITY(U,$J,358.3,37301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37301,1,3,0)
 ;;=3^Displ comminuted fx shaft of left femur, init encntr
 ;;^UTILITY(U,$J,358.3,37301,1,4,0)
 ;;=4^S72.352A
 ;;^UTILITY(U,$J,358.3,37301,2)
 ;;=^5038448
 ;;^UTILITY(U,$J,358.3,37302,0)
 ;;=S72.351A^^172^1879^7
 ;;^UTILITY(U,$J,358.3,37302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37302,1,3,0)
 ;;=3^Displ comminuted fx shaft of right femur, init encntr
 ;;^UTILITY(U,$J,358.3,37302,1,4,0)
 ;;=4^S72.351A
 ;;^UTILITY(U,$J,358.3,37302,2)
 ;;=^5038432
