IBDEI37H ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,51185,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,51185,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,51185,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,51186,0)
 ;;=M25.40^^193^2503^38
 ;;^UTILITY(U,$J,358.3,51186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51186,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,51186,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,51186,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,51187,0)
 ;;=M45.0^^193^2503^6
 ;;^UTILITY(U,$J,358.3,51187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51187,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,51187,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,51187,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,51188,0)
 ;;=M45.2^^193^2503^3
 ;;^UTILITY(U,$J,358.3,51188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51188,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,51188,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,51188,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,51189,0)
 ;;=M45.4^^193^2503^7
 ;;^UTILITY(U,$J,358.3,51189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51189,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,51189,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,51189,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,51190,0)
 ;;=M45.7^^193^2503^4
 ;;^UTILITY(U,$J,358.3,51190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51190,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,51190,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,51190,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,51191,0)
 ;;=M45.8^^193^2503^5
 ;;^UTILITY(U,$J,358.3,51191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51191,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,51191,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,51191,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,51192,0)
 ;;=M47.22^^193^2503^180
 ;;^UTILITY(U,$J,358.3,51192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51192,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,51192,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,51192,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,51193,0)
 ;;=M47.24^^193^2503^182
 ;;^UTILITY(U,$J,358.3,51193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51193,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,51193,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,51193,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,51194,0)
 ;;=M47.27^^193^2503^181
 ;;^UTILITY(U,$J,358.3,51194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51194,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,51194,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,51194,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,51195,0)
 ;;=M47.812^^193^2503^177
 ;;^UTILITY(U,$J,358.3,51195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51195,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,51195,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,51195,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,51196,0)
 ;;=M47.814^^193^2503^178
 ;;^UTILITY(U,$J,358.3,51196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51196,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,51196,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,51196,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,51197,0)
 ;;=M47.817^^193^2503^179
