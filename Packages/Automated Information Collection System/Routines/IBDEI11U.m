IBDEI11U ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17051,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,17051,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,17052,0)
 ;;=M19.90^^61^781^72
 ;;^UTILITY(U,$J,358.3,17052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17052,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,17052,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,17052,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,17053,0)
 ;;=M25.40^^61^781^38
 ;;^UTILITY(U,$J,358.3,17053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17053,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,17053,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,17053,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,17054,0)
 ;;=M45.0^^61^781^6
 ;;^UTILITY(U,$J,358.3,17054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17054,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,17054,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,17054,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,17055,0)
 ;;=M45.2^^61^781^3
 ;;^UTILITY(U,$J,358.3,17055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17055,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,17055,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,17055,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,17056,0)
 ;;=M45.4^^61^781^7
 ;;^UTILITY(U,$J,358.3,17056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17056,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,17056,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,17056,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,17057,0)
 ;;=M45.7^^61^781^4
 ;;^UTILITY(U,$J,358.3,17057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17057,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,17057,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,17057,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,17058,0)
 ;;=M45.8^^61^781^5
 ;;^UTILITY(U,$J,358.3,17058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17058,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,17058,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,17058,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,17059,0)
 ;;=M47.22^^61^781^180
 ;;^UTILITY(U,$J,358.3,17059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17059,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,17059,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,17059,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,17060,0)
 ;;=M47.24^^61^781^182
 ;;^UTILITY(U,$J,358.3,17060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17060,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,17060,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,17060,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,17061,0)
 ;;=M47.27^^61^781^181
 ;;^UTILITY(U,$J,358.3,17061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17061,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,17061,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,17061,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,17062,0)
 ;;=M47.812^^61^781^177
 ;;^UTILITY(U,$J,358.3,17062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17062,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,17062,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,17062,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,17063,0)
 ;;=M47.814^^61^781^178
 ;;^UTILITY(U,$J,358.3,17063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17063,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
