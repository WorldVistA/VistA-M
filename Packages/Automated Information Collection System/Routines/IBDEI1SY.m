IBDEI1SY ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32184,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,32184,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,32184,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,32185,0)
 ;;=M19.042^^190^1949^98
 ;;^UTILITY(U,$J,358.3,32185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32185,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,32185,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,32185,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,32186,0)
 ;;=M19.90^^190^1949^59
 ;;^UTILITY(U,$J,358.3,32186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32186,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,32186,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,32186,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,32187,0)
 ;;=M25.40^^190^1949^29
 ;;^UTILITY(U,$J,358.3,32187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32187,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,32187,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,32187,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,32188,0)
 ;;=M45.0^^190^1949^6
 ;;^UTILITY(U,$J,358.3,32188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32188,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,32188,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,32188,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,32189,0)
 ;;=M45.2^^190^1949^3
 ;;^UTILITY(U,$J,358.3,32189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32189,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,32189,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,32189,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,32190,0)
 ;;=M45.4^^190^1949^7
 ;;^UTILITY(U,$J,358.3,32190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32190,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,32190,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,32190,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,32191,0)
 ;;=M45.7^^190^1949^4
 ;;^UTILITY(U,$J,358.3,32191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32191,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,32191,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,32191,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,32192,0)
 ;;=M45.8^^190^1949^5
 ;;^UTILITY(U,$J,358.3,32192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32192,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,32192,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,32192,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,32193,0)
 ;;=M47.22^^190^1949^145
 ;;^UTILITY(U,$J,358.3,32193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32193,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,32193,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,32193,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,32194,0)
 ;;=M47.24^^190^1949^147
 ;;^UTILITY(U,$J,358.3,32194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32194,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,32194,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,32194,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,32195,0)
 ;;=M47.27^^190^1949^146
 ;;^UTILITY(U,$J,358.3,32195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32195,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,32195,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,32195,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,32196,0)
 ;;=M47.812^^190^1949^142
 ;;^UTILITY(U,$J,358.3,32196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32196,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,32196,1,4,0)
 ;;=4^M47.812
