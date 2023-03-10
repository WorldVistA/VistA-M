IBDEI0VS ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14325,0)
 ;;=S82.424D^^55^675^20
 ;;^UTILITY(U,$J,358.3,14325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14325,1,3,0)
 ;;=3^Nondisp transverse fx shaft of r fibula, subs encntr
 ;;^UTILITY(U,$J,358.3,14325,1,4,0)
 ;;=4^S82.424D
 ;;^UTILITY(U,$J,358.3,14325,2)
 ;;=^5041765
 ;;^UTILITY(U,$J,358.3,14326,0)
 ;;=M84.464D^^55^675^32
 ;;^UTILITY(U,$J,358.3,14326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14326,1,3,0)
 ;;=3^Pathological fracture, left fibula, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,14326,1,4,0)
 ;;=4^M84.464D
 ;;^UTILITY(U,$J,358.3,14326,2)
 ;;=^5013951
 ;;^UTILITY(U,$J,358.3,14327,0)
 ;;=M84.461D^^55^675^38
 ;;^UTILITY(U,$J,358.3,14327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14327,1,3,0)
 ;;=3^Pathological fracture, right tibia, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,14327,1,4,0)
 ;;=4^M84.461D
 ;;^UTILITY(U,$J,358.3,14327,2)
 ;;=^5013933
 ;;^UTILITY(U,$J,358.3,14328,0)
 ;;=M84.462A^^55^675^33
 ;;^UTILITY(U,$J,358.3,14328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14328,1,3,0)
 ;;=3^Pathological fracture, left tibia, init encntr for fracture
 ;;^UTILITY(U,$J,358.3,14328,1,4,0)
 ;;=4^M84.462A
 ;;^UTILITY(U,$J,358.3,14328,2)
 ;;=^5013938
 ;;^UTILITY(U,$J,358.3,14329,0)
 ;;=M84.462D^^55^675^34
 ;;^UTILITY(U,$J,358.3,14329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14329,1,3,0)
 ;;=3^Pathological fracture, left tibia, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,14329,1,4,0)
 ;;=4^M84.462D
 ;;^UTILITY(U,$J,358.3,14329,2)
 ;;=^5013939
 ;;^UTILITY(U,$J,358.3,14330,0)
 ;;=M84.469A^^55^675^39
 ;;^UTILITY(U,$J,358.3,14330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14330,1,3,0)
 ;;=3^Pathological fracture, unsp tibia and fibula, init for fx
 ;;^UTILITY(U,$J,358.3,14330,1,4,0)
 ;;=4^M84.469A
 ;;^UTILITY(U,$J,358.3,14330,2)
 ;;=^5013956
 ;;^UTILITY(U,$J,358.3,14331,0)
 ;;=M84.469D^^55^675^40
 ;;^UTILITY(U,$J,358.3,14331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14331,1,3,0)
 ;;=3^Pathological fracture, unsp tibia and fibula, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,14331,1,4,0)
 ;;=4^M84.469D
 ;;^UTILITY(U,$J,358.3,14331,2)
 ;;=^5013957
 ;;^UTILITY(U,$J,358.3,14332,0)
 ;;=M84.463D^^55^675^36
 ;;^UTILITY(U,$J,358.3,14332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14332,1,3,0)
 ;;=3^Pathological fracture, right fibula, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,14332,1,4,0)
 ;;=4^M84.463D
 ;;^UTILITY(U,$J,358.3,14332,2)
 ;;=^5013945
 ;;^UTILITY(U,$J,358.3,14333,0)
 ;;=M00.832^^55^676^1
 ;;^UTILITY(U,$J,358.3,14333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14333,1,3,0)
 ;;=3^Arthritis d/t other bacteria, left wrist
 ;;^UTILITY(U,$J,358.3,14333,1,4,0)
 ;;=4^M00.832
 ;;^UTILITY(U,$J,358.3,14333,2)
 ;;=^5009677
 ;;^UTILITY(U,$J,358.3,14334,0)
 ;;=M00.831^^55^676^2
 ;;^UTILITY(U,$J,358.3,14334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14334,1,3,0)
 ;;=3^Arthritis d/t other bacteria, right wrist
 ;;^UTILITY(U,$J,358.3,14334,1,4,0)
 ;;=4^M00.831
 ;;^UTILITY(U,$J,358.3,14334,2)
 ;;=^5009676
 ;;^UTILITY(U,$J,358.3,14335,0)
 ;;=G56.02^^55^676^3
 ;;^UTILITY(U,$J,358.3,14335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14335,1,3,0)
 ;;=3^Carpal tunnel syndrome, left upper limb
 ;;^UTILITY(U,$J,358.3,14335,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,14335,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,14336,0)
 ;;=G56.01^^55^676^4
 ;;^UTILITY(U,$J,358.3,14336,1,0)
 ;;=^358.31IA^4^2
