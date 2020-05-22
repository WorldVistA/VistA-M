IBDEI23C ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33426,1,3,0)
 ;;=3^Traumatic arthropathy, left ankle and foot
 ;;^UTILITY(U,$J,358.3,33426,1,4,0)
 ;;=4^M12.572
 ;;^UTILITY(U,$J,358.3,33426,2)
 ;;=^5010638
 ;;^UTILITY(U,$J,358.3,33427,0)
 ;;=M12.571^^132^1701^46
 ;;^UTILITY(U,$J,358.3,33427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33427,1,3,0)
 ;;=3^Traumatic arthropathy, right ankle and foot
 ;;^UTILITY(U,$J,358.3,33427,1,4,0)
 ;;=4^M12.571
 ;;^UTILITY(U,$J,358.3,33427,2)
 ;;=^5010637
 ;;^UTILITY(U,$J,358.3,33428,0)
 ;;=S82.92XA^^132^1701^9
 ;;^UTILITY(U,$J,358.3,33428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33428,1,3,0)
 ;;=3^Fracture of left lower leg, init for clos fx,Unspec
 ;;^UTILITY(U,$J,358.3,33428,1,4,0)
 ;;=4^S82.92XA
 ;;^UTILITY(U,$J,358.3,33428,2)
 ;;=^5136962
 ;;^UTILITY(U,$J,358.3,33429,0)
 ;;=S82.91XA^^132^1701^11
 ;;^UTILITY(U,$J,358.3,33429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33429,1,3,0)
 ;;=3^Fracture of right lower leg, init for clos fx,Unspec
 ;;^UTILITY(U,$J,358.3,33429,1,4,0)
 ;;=4^S82.91XA
 ;;^UTILITY(U,$J,358.3,33429,2)
 ;;=^5136961
 ;;^UTILITY(U,$J,358.3,33430,0)
 ;;=S82.52XD^^132^1701^6
 ;;^UTILITY(U,$J,358.3,33430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33430,1,3,0)
 ;;=3^Disp fx of medial malleolus of left tibia, subs encntr
 ;;^UTILITY(U,$J,358.3,33430,1,4,0)
 ;;=4^S82.52XD
 ;;^UTILITY(U,$J,358.3,33430,2)
 ;;=^5042234
 ;;^UTILITY(U,$J,358.3,33431,0)
 ;;=S82.51XD^^132^1701^8
 ;;^UTILITY(U,$J,358.3,33431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33431,1,3,0)
 ;;=3^Disp fx of medial malleolus of right tibia, subs encntr
 ;;^UTILITY(U,$J,358.3,33431,1,4,0)
 ;;=4^S82.51XD
 ;;^UTILITY(U,$J,358.3,33431,2)
 ;;=^5042218
 ;;^UTILITY(U,$J,358.3,33432,0)
 ;;=S82.92XD^^132^1701^10
 ;;^UTILITY(U,$J,358.3,33432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33432,1,3,0)
 ;;=3^Fracture of left lower leg, subs encntr
 ;;^UTILITY(U,$J,358.3,33432,1,4,0)
 ;;=4^S82.92XD
 ;;^UTILITY(U,$J,358.3,33432,2)
 ;;=^5136968
 ;;^UTILITY(U,$J,358.3,33433,0)
 ;;=S82.91XD^^132^1701^12
 ;;^UTILITY(U,$J,358.3,33433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33433,1,3,0)
 ;;=3^Fracture of right lower leg, subs encntr
 ;;^UTILITY(U,$J,358.3,33433,1,4,0)
 ;;=4^S82.91XD
 ;;^UTILITY(U,$J,358.3,33433,2)
 ;;=^5136967
 ;;^UTILITY(U,$J,358.3,33434,0)
 ;;=S82.65XD^^132^1701^20
 ;;^UTILITY(U,$J,358.3,33434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33434,1,3,0)
 ;;=3^Nondisp fx of lateral malleolus of left fibula, subs encntr
 ;;^UTILITY(U,$J,358.3,33434,1,4,0)
 ;;=4^S82.65XD
 ;;^UTILITY(U,$J,358.3,33434,2)
 ;;=^5042378
 ;;^UTILITY(U,$J,358.3,33435,0)
 ;;=S82.64XD^^132^1701^22
 ;;^UTILITY(U,$J,358.3,33435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33435,1,3,0)
 ;;=3^Nondisp fx of lateral malleolus of right fibula, subs encntr
 ;;^UTILITY(U,$J,358.3,33435,1,4,0)
 ;;=4^S82.64XD
 ;;^UTILITY(U,$J,358.3,33435,2)
 ;;=^5042362
 ;;^UTILITY(U,$J,358.3,33436,0)
 ;;=S82.55XD^^132^1701^24
 ;;^UTILITY(U,$J,358.3,33436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33436,1,3,0)
 ;;=3^Nondisp fx of medial malleolus of left tibia, subs encntr
 ;;^UTILITY(U,$J,358.3,33436,1,4,0)
 ;;=4^S82.55XD
 ;;^UTILITY(U,$J,358.3,33436,2)
 ;;=^5042282
 ;;^UTILITY(U,$J,358.3,33437,0)
 ;;=S82.54XD^^132^1701^26
 ;;^UTILITY(U,$J,358.3,33437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33437,1,3,0)
 ;;=3^Nondisp fx of medial malleolus of right tibia, subs encntr
