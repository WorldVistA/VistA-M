IBDEI27S ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37203,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,37203,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,37204,0)
 ;;=99244^^171^1875^4
 ;;^UTILITY(U,$J,358.3,37204,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,37204,1,1,0)
 ;;=1^Comprehensive,Moderate
 ;;^UTILITY(U,$J,358.3,37204,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,37205,0)
 ;;=99245^^171^1875^5
 ;;^UTILITY(U,$J,358.3,37205,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,37205,1,1,0)
 ;;=1^Comprehensive,High
 ;;^UTILITY(U,$J,358.3,37205,1,2,0)
 ;;=2^99245
 ;;^UTILITY(U,$J,358.3,37206,0)
 ;;=99024^^171^1876^1
 ;;^UTILITY(U,$J,358.3,37206,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,37206,1,1,0)
 ;;=1^Post-Op Follow-up Visit
 ;;^UTILITY(U,$J,358.3,37206,1,2,0)
 ;;=2^99024
 ;;^UTILITY(U,$J,358.3,37207,0)
 ;;=M76.62^^172^1877^1
 ;;^UTILITY(U,$J,358.3,37207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37207,1,3,0)
 ;;=3^Achilles tendinitis, left leg
 ;;^UTILITY(U,$J,358.3,37207,1,4,0)
 ;;=4^M76.62
 ;;^UTILITY(U,$J,358.3,37207,2)
 ;;=^5013286
 ;;^UTILITY(U,$J,358.3,37208,0)
 ;;=M76.61^^172^1877^2
 ;;^UTILITY(U,$J,358.3,37208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37208,1,3,0)
 ;;=3^Achilles tendinitis, right leg
 ;;^UTILITY(U,$J,358.3,37208,1,4,0)
 ;;=4^M76.61
 ;;^UTILITY(U,$J,358.3,37208,2)
 ;;=^5013285
 ;;^UTILITY(U,$J,358.3,37209,0)
 ;;=M00.872^^172^1877^3
 ;;^UTILITY(U,$J,358.3,37209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37209,1,3,0)
 ;;=3^Arthritis d/t other bacteria, left ankle and foot
 ;;^UTILITY(U,$J,358.3,37209,1,4,0)
 ;;=4^M00.872
 ;;^UTILITY(U,$J,358.3,37209,2)
 ;;=^5009689
 ;;^UTILITY(U,$J,358.3,37210,0)
 ;;=M00.871^^172^1877^4
 ;;^UTILITY(U,$J,358.3,37210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37210,1,3,0)
 ;;=3^Arthritis d/t other bacteria, right ankle and foot
 ;;^UTILITY(U,$J,358.3,37210,1,4,0)
 ;;=4^M00.871
 ;;^UTILITY(U,$J,358.3,37210,2)
 ;;=^5009688
 ;;^UTILITY(U,$J,358.3,37211,0)
 ;;=S82.52XA^^172^1877^5
 ;;^UTILITY(U,$J,358.3,37211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37211,1,3,0)
 ;;=3^Disp fx of medial malleolus of left tibia, init for clos fx
 ;;^UTILITY(U,$J,358.3,37211,1,4,0)
 ;;=4^S82.52XA
 ;;^UTILITY(U,$J,358.3,37211,2)
 ;;=^5042231
 ;;^UTILITY(U,$J,358.3,37212,0)
 ;;=S82.51XA^^172^1877^7
 ;;^UTILITY(U,$J,358.3,37212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37212,1,3,0)
 ;;=3^Disp fx of medial malleolus of right tibia, init for clos fx
 ;;^UTILITY(U,$J,358.3,37212,1,4,0)
 ;;=4^S82.51XA
 ;;^UTILITY(U,$J,358.3,37212,2)
 ;;=^5042215
 ;;^UTILITY(U,$J,358.3,37213,0)
 ;;=M24.072^^172^1877^15
 ;;^UTILITY(U,$J,358.3,37213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37213,1,3,0)
 ;;=3^Loose body in left ankle
 ;;^UTILITY(U,$J,358.3,37213,1,4,0)
 ;;=4^M24.072
 ;;^UTILITY(U,$J,358.3,37213,2)
 ;;=^5011294
 ;;^UTILITY(U,$J,358.3,37214,0)
 ;;=M24.071^^172^1877^16
 ;;^UTILITY(U,$J,358.3,37214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37214,1,3,0)
 ;;=3^Loose body in right ankle
 ;;^UTILITY(U,$J,358.3,37214,1,4,0)
 ;;=4^M24.071
 ;;^UTILITY(U,$J,358.3,37214,2)
 ;;=^5011293
 ;;^UTILITY(U,$J,358.3,37215,0)
 ;;=S82.65XA^^172^1877^19
 ;;^UTILITY(U,$J,358.3,37215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37215,1,3,0)
 ;;=3^Nondisp fx of lateral malleolus of left fibula, init
 ;;^UTILITY(U,$J,358.3,37215,1,4,0)
 ;;=4^S82.65XA
 ;;^UTILITY(U,$J,358.3,37215,2)
 ;;=^5042375
 ;;^UTILITY(U,$J,358.3,37216,0)
 ;;=S82.64XA^^172^1877^21
 ;;^UTILITY(U,$J,358.3,37216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37216,1,3,0)
 ;;=3^Nondisp fx of lateral malleolus of right fibula, init
 ;;^UTILITY(U,$J,358.3,37216,1,4,0)
 ;;=4^S82.64XA
