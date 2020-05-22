IBDEI23I ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33496,1,3,0)
 ;;=3^Path fx in oth disease, right femur, init encntr
 ;;^UTILITY(U,$J,358.3,33496,1,4,0)
 ;;=4^M84.551A
 ;;^UTILITY(U,$J,358.3,33496,2)
 ;;=^5014118
 ;;^UTILITY(U,$J,358.3,33497,0)
 ;;=M84.652A^^132^1703^21
 ;;^UTILITY(U,$J,358.3,33497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33497,1,3,0)
 ;;=3^Pathological fracture in oth disease, left femur, init
 ;;^UTILITY(U,$J,358.3,33497,1,4,0)
 ;;=4^M84.652A
 ;;^UTILITY(U,$J,358.3,33497,2)
 ;;=^5134003
 ;;^UTILITY(U,$J,358.3,33498,0)
 ;;=M61.051^^132^1703^10
 ;;^UTILITY(U,$J,358.3,33498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33498,1,3,0)
 ;;=3^Myositis ossificans traumatica, right thigh
 ;;^UTILITY(U,$J,358.3,33498,1,4,0)
 ;;=4^M61.051
 ;;^UTILITY(U,$J,358.3,33498,2)
 ;;=^5012423
 ;;^UTILITY(U,$J,358.3,33499,0)
 ;;=S72.355A^^132^1703^13
 ;;^UTILITY(U,$J,358.3,33499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33499,1,3,0)
 ;;=3^Nondisp commnt fx shaft of right femur, init encntr
 ;;^UTILITY(U,$J,358.3,33499,1,4,0)
 ;;=4^S72.355A
 ;;^UTILITY(U,$J,358.3,33499,2)
 ;;=^5038496
 ;;^UTILITY(U,$J,358.3,33500,0)
 ;;=M84.651A^^132^1703^22
 ;;^UTILITY(U,$J,358.3,33500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33500,1,3,0)
 ;;=3^Pathological fracture in oth disease, right femur, init
 ;;^UTILITY(U,$J,358.3,33500,1,4,0)
 ;;=4^M84.651A
 ;;^UTILITY(U,$J,358.3,33500,2)
 ;;=^5014262
 ;;^UTILITY(U,$J,358.3,33501,0)
 ;;=M84.452A^^132^1703^23
 ;;^UTILITY(U,$J,358.3,33501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33501,1,3,0)
 ;;=3^Pathological fracture, left femur, init encntr for fracture
 ;;^UTILITY(U,$J,358.3,33501,1,4,0)
 ;;=4^M84.452A
 ;;^UTILITY(U,$J,358.3,33501,2)
 ;;=^5013908
 ;;^UTILITY(U,$J,358.3,33502,0)
 ;;=M84.451A^^132^1703^25
 ;;^UTILITY(U,$J,358.3,33502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33502,1,3,0)
 ;;=3^Pathological fracture, right femur, init encntr for fracture
 ;;^UTILITY(U,$J,358.3,33502,1,4,0)
 ;;=4^M84.451A
 ;;^UTILITY(U,$J,358.3,33502,2)
 ;;=^5013902
 ;;^UTILITY(U,$J,358.3,33503,0)
 ;;=M84.352A^^132^1703^27
 ;;^UTILITY(U,$J,358.3,33503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33503,1,3,0)
 ;;=3^Stress fracture, left femur, initial encounter for fracture
 ;;^UTILITY(U,$J,358.3,33503,1,4,0)
 ;;=4^M84.352A
 ;;^UTILITY(U,$J,358.3,33503,2)
 ;;=^5013686
 ;;^UTILITY(U,$J,358.3,33504,0)
 ;;=M84.351A^^132^1703^29
 ;;^UTILITY(U,$J,358.3,33504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33504,1,3,0)
 ;;=3^Stress fracture, right femur, initial encounter for fracture
 ;;^UTILITY(U,$J,358.3,33504,1,4,0)
 ;;=4^M84.351A
 ;;^UTILITY(U,$J,358.3,33504,2)
 ;;=^5013680
 ;;^UTILITY(U,$J,358.3,33505,0)
 ;;=S70.12XD^^132^1703^2
 ;;^UTILITY(U,$J,358.3,33505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33505,1,3,0)
 ;;=3^Contusion of left thigh, subsequent encounter
 ;;^UTILITY(U,$J,358.3,33505,1,4,0)
 ;;=4^S70.12XD
 ;;^UTILITY(U,$J,358.3,33505,2)
 ;;=^5036847
 ;;^UTILITY(U,$J,358.3,33506,0)
 ;;=S70.11XD^^132^1703^4
 ;;^UTILITY(U,$J,358.3,33506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33506,1,3,0)
 ;;=3^Contusion of right thigh, subsequent encounter
 ;;^UTILITY(U,$J,358.3,33506,1,4,0)
 ;;=4^S70.11XD
 ;;^UTILITY(U,$J,358.3,33506,2)
 ;;=^5036844
 ;;^UTILITY(U,$J,358.3,33507,0)
 ;;=S72.352D^^132^1703^6
 ;;^UTILITY(U,$J,358.3,33507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33507,1,3,0)
 ;;=3^Displ comminuted fx shaft of left femur, subs encntr
