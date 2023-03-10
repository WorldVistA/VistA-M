IBDEI0UT ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13911,2)
 ;;=^5029066
 ;;^UTILITY(U,$J,358.3,13912,0)
 ;;=S52.121D^^55^664^12
 ;;^UTILITY(U,$J,358.3,13912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13912,1,3,0)
 ;;=3^Disp fx of head of right radius, subs encntr
 ;;^UTILITY(U,$J,358.3,13912,1,4,0)
 ;;=4^S52.121D
 ;;^UTILITY(U,$J,358.3,13912,2)
 ;;=^5029050
 ;;^UTILITY(U,$J,358.3,13913,0)
 ;;=S52.032D^^55^664^15
 ;;^UTILITY(U,$J,358.3,13913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13913,1,3,0)
 ;;=3^Disp fx of olecran pro w/ intartic extn left ulna, subs encntr
 ;;^UTILITY(U,$J,358.3,13913,1,4,0)
 ;;=4^S52.032D
 ;;^UTILITY(U,$J,358.3,13913,2)
 ;;=^5135083
 ;;^UTILITY(U,$J,358.3,13914,0)
 ;;=S52.031D^^55^664^16
 ;;^UTILITY(U,$J,358.3,13914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13914,1,3,0)
 ;;=3^Disp fx of olecran pro w/ intartic extn right ulna, subs encntr
 ;;^UTILITY(U,$J,358.3,13914,1,4,0)
 ;;=4^S52.031D
 ;;^UTILITY(U,$J,358.3,13914,2)
 ;;=^5135082
 ;;^UTILITY(U,$J,358.3,13915,0)
 ;;=S42.402D^^55^664^17
 ;;^UTILITY(U,$J,358.3,13915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13915,1,3,0)
 ;;=3^Fracture lower end of left humerus, subs encntr
 ;;^UTILITY(U,$J,358.3,13915,1,4,0)
 ;;=4^S42.402D
 ;;^UTILITY(U,$J,358.3,13915,2)
 ;;=^5134717
 ;;^UTILITY(U,$J,358.3,13916,0)
 ;;=S42.401D^^55^664^18
 ;;^UTILITY(U,$J,358.3,13916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13916,1,3,0)
 ;;=3^Fracture lower end of right humerus, subs encntr
 ;;^UTILITY(U,$J,358.3,13916,1,4,0)
 ;;=4^S42.401D
 ;;^UTILITY(U,$J,358.3,13916,2)
 ;;=^5027296
 ;;^UTILITY(U,$J,358.3,13917,0)
 ;;=S52.125D^^55^664^30
 ;;^UTILITY(U,$J,358.3,13917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13917,1,3,0)
 ;;=3^Nondisp fx of head of left radius, subs encntr
 ;;^UTILITY(U,$J,358.3,13917,1,4,0)
 ;;=4^S52.125D
 ;;^UTILITY(U,$J,358.3,13917,2)
 ;;=^5029114
 ;;^UTILITY(U,$J,358.3,13918,0)
 ;;=S52.124D^^55^664^32
 ;;^UTILITY(U,$J,358.3,13918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13918,1,3,0)
 ;;=3^Nondisp fx of head of right radius, subs encntr
 ;;^UTILITY(U,$J,358.3,13918,1,4,0)
 ;;=4^S52.124D
 ;;^UTILITY(U,$J,358.3,13918,2)
 ;;=^5029098
 ;;^UTILITY(U,$J,358.3,13919,0)
 ;;=M19.121^^55^664^38
 ;;^UTILITY(U,$J,358.3,13919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13919,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, right elbow
 ;;^UTILITY(U,$J,358.3,13919,1,4,0)
 ;;=4^M19.121
 ;;^UTILITY(U,$J,358.3,13919,2)
 ;;=^5010826
 ;;^UTILITY(U,$J,358.3,13920,0)
 ;;=M19.122^^55^664^37
 ;;^UTILITY(U,$J,358.3,13920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13920,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, left elbow
 ;;^UTILITY(U,$J,358.3,13920,1,4,0)
 ;;=4^M19.122
 ;;^UTILITY(U,$J,358.3,13920,2)
 ;;=^5010827
 ;;^UTILITY(U,$J,358.3,13921,0)
 ;;=S53.402D^^55^664^42
 ;;^UTILITY(U,$J,358.3,13921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13921,1,3,0)
 ;;=3^Sprain of left elbow, subsequent encounter
 ;;^UTILITY(U,$J,358.3,13921,1,4,0)
 ;;=4^S53.402D
 ;;^UTILITY(U,$J,358.3,13921,2)
 ;;=^5031365
 ;;^UTILITY(U,$J,358.3,13922,0)
 ;;=S53.401D^^55^664^44
 ;;^UTILITY(U,$J,358.3,13922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13922,1,3,0)
 ;;=3^Sprain of right elbow, subsequent encounter
 ;;^UTILITY(U,$J,358.3,13922,1,4,0)
 ;;=4^S53.401D
 ;;^UTILITY(U,$J,358.3,13922,2)
 ;;=^5031362
 ;;^UTILITY(U,$J,358.3,13923,0)
 ;;=S70.12XA^^55^665^1
 ;;^UTILITY(U,$J,358.3,13923,1,0)
 ;;=^358.31IA^4^2
