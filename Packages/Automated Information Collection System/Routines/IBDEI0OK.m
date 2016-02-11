IBDEI0OK ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11237,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,11237,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,11238,0)
 ;;=M19.041^^68^681^114
 ;;^UTILITY(U,$J,358.3,11238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11238,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,11238,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,11238,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,11239,0)
 ;;=M19.042^^68^681^108
 ;;^UTILITY(U,$J,358.3,11239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11239,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,11239,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,11239,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,11240,0)
 ;;=M19.90^^68^681^68
 ;;^UTILITY(U,$J,358.3,11240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11240,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,11240,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,11240,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,11241,0)
 ;;=M25.40^^68^681^37
 ;;^UTILITY(U,$J,358.3,11241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11241,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,11241,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,11241,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,11242,0)
 ;;=M45.0^^68^681^6
 ;;^UTILITY(U,$J,358.3,11242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11242,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,11242,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,11242,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,11243,0)
 ;;=M45.2^^68^681^3
 ;;^UTILITY(U,$J,358.3,11243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11243,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,11243,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,11243,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,11244,0)
 ;;=M45.4^^68^681^7
 ;;^UTILITY(U,$J,358.3,11244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11244,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,11244,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,11244,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,11245,0)
 ;;=M45.7^^68^681^4
 ;;^UTILITY(U,$J,358.3,11245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11245,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,11245,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,11245,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,11246,0)
 ;;=M45.8^^68^681^5
 ;;^UTILITY(U,$J,358.3,11246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11246,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,11246,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,11246,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,11247,0)
 ;;=M47.22^^68^681^155
 ;;^UTILITY(U,$J,358.3,11247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11247,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,11247,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,11247,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,11248,0)
 ;;=M47.24^^68^681^157
 ;;^UTILITY(U,$J,358.3,11248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11248,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,11248,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,11248,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,11249,0)
 ;;=M47.27^^68^681^156
 ;;^UTILITY(U,$J,358.3,11249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11249,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,11249,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,11249,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,11250,0)
 ;;=M47.812^^68^681^152
 ;;^UTILITY(U,$J,358.3,11250,1,0)
 ;;=^358.31IA^4^2
