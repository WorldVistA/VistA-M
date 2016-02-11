IBDEI27V ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37241,1,3,0)
 ;;=3^Disp fx of medial malleolus of right tibia, subs encntr
 ;;^UTILITY(U,$J,358.3,37241,1,4,0)
 ;;=4^S82.51XD
 ;;^UTILITY(U,$J,358.3,37241,2)
 ;;=^5042218
 ;;^UTILITY(U,$J,358.3,37242,0)
 ;;=S82.92XD^^172^1877^10
 ;;^UTILITY(U,$J,358.3,37242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37242,1,3,0)
 ;;=3^Fracture of left lower leg, subs encntr
 ;;^UTILITY(U,$J,358.3,37242,1,4,0)
 ;;=4^S82.92XD
 ;;^UTILITY(U,$J,358.3,37242,2)
 ;;=^5136968
 ;;^UTILITY(U,$J,358.3,37243,0)
 ;;=S82.91XD^^172^1877^12
 ;;^UTILITY(U,$J,358.3,37243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37243,1,3,0)
 ;;=3^Fracture of right lower leg, subs encntr
 ;;^UTILITY(U,$J,358.3,37243,1,4,0)
 ;;=4^S82.91XD
 ;;^UTILITY(U,$J,358.3,37243,2)
 ;;=^5136967
 ;;^UTILITY(U,$J,358.3,37244,0)
 ;;=S82.65XD^^172^1877^20
 ;;^UTILITY(U,$J,358.3,37244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37244,1,3,0)
 ;;=3^Nondisp fx of lateral malleolus of left fibula, subs encntr
 ;;^UTILITY(U,$J,358.3,37244,1,4,0)
 ;;=4^S82.65XD
 ;;^UTILITY(U,$J,358.3,37244,2)
 ;;=^5042378
 ;;^UTILITY(U,$J,358.3,37245,0)
 ;;=S82.64XD^^172^1877^22
 ;;^UTILITY(U,$J,358.3,37245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37245,1,3,0)
 ;;=3^Nondisp fx of lateral malleolus of right fibula, subs encntr
 ;;^UTILITY(U,$J,358.3,37245,1,4,0)
 ;;=4^S82.64XD
 ;;^UTILITY(U,$J,358.3,37245,2)
 ;;=^5042362
 ;;^UTILITY(U,$J,358.3,37246,0)
 ;;=S82.55XD^^172^1877^24
 ;;^UTILITY(U,$J,358.3,37246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37246,1,3,0)
 ;;=3^Nondisp fx of medial malleolus of left tibia, subs encntr
 ;;^UTILITY(U,$J,358.3,37246,1,4,0)
 ;;=4^S82.55XD
 ;;^UTILITY(U,$J,358.3,37246,2)
 ;;=^5042282
 ;;^UTILITY(U,$J,358.3,37247,0)
 ;;=S82.54XD^^172^1877^26
 ;;^UTILITY(U,$J,358.3,37247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37247,1,3,0)
 ;;=3^Nondisp fx of medial malleolus of right tibia, subs encntr
 ;;^UTILITY(U,$J,358.3,37247,1,4,0)
 ;;=4^S82.54XD
 ;;^UTILITY(U,$J,358.3,37247,2)
 ;;=^5042266
 ;;^UTILITY(U,$J,358.3,37248,0)
 ;;=M19.171^^172^1877^34
 ;;^UTILITY(U,$J,358.3,37248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37248,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, right ankle & foot
 ;;^UTILITY(U,$J,358.3,37248,1,4,0)
 ;;=4^M19.171
 ;;^UTILITY(U,$J,358.3,37248,2)
 ;;=^5010835
 ;;^UTILITY(U,$J,358.3,37249,0)
 ;;=M19.172^^172^1877^33
 ;;^UTILITY(U,$J,358.3,37249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37249,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, left ankle & foot
 ;;^UTILITY(U,$J,358.3,37249,1,4,0)
 ;;=4^M19.172
 ;;^UTILITY(U,$J,358.3,37249,2)
 ;;=^5010836
 ;;^UTILITY(U,$J,358.3,37250,0)
 ;;=S93.402D^^172^1877^41
 ;;^UTILITY(U,$J,358.3,37250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37250,1,3,0)
 ;;=3^Sprain of unspec ligament of left ankle, subs encntr
 ;;^UTILITY(U,$J,358.3,37250,1,4,0)
 ;;=4^S93.402D
 ;;^UTILITY(U,$J,358.3,37250,2)
 ;;=^5045778
 ;;^UTILITY(U,$J,358.3,37251,0)
 ;;=S93.401D^^172^1877^42
 ;;^UTILITY(U,$J,358.3,37251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37251,1,3,0)
 ;;=3^Sprain of unspec ligament of right ankle, subs encntr
 ;;^UTILITY(U,$J,358.3,37251,1,4,0)
 ;;=4^S93.401D
 ;;^UTILITY(U,$J,358.3,37251,2)
 ;;=^5045775
 ;;^UTILITY(U,$J,358.3,37252,0)
 ;;=M25.571^^172^1877^30
 ;;^UTILITY(U,$J,358.3,37252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37252,1,3,0)
 ;;=3^Pain in right ankle & joints of right foot
 ;;^UTILITY(U,$J,358.3,37252,1,4,0)
 ;;=4^M25.571
 ;;^UTILITY(U,$J,358.3,37252,2)
 ;;=^5011617
 ;;^UTILITY(U,$J,358.3,37253,0)
 ;;=G56.22^^172^1878^23
 ;;^UTILITY(U,$J,358.3,37253,1,0)
 ;;=^358.31IA^4^2
