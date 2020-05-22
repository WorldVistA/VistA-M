IBDEI1L2 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25300,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,25301,0)
 ;;=M25.40^^107^1217^38
 ;;^UTILITY(U,$J,358.3,25301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25301,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,25301,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,25301,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,25302,0)
 ;;=M45.0^^107^1217^6
 ;;^UTILITY(U,$J,358.3,25302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25302,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,25302,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,25302,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,25303,0)
 ;;=M45.2^^107^1217^3
 ;;^UTILITY(U,$J,358.3,25303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25303,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,25303,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,25303,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,25304,0)
 ;;=M45.4^^107^1217^7
 ;;^UTILITY(U,$J,358.3,25304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25304,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,25304,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,25304,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,25305,0)
 ;;=M45.7^^107^1217^4
 ;;^UTILITY(U,$J,358.3,25305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25305,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,25305,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,25305,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,25306,0)
 ;;=M45.8^^107^1217^5
 ;;^UTILITY(U,$J,358.3,25306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25306,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,25306,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,25306,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,25307,0)
 ;;=M47.22^^107^1217^180
 ;;^UTILITY(U,$J,358.3,25307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25307,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,25307,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,25307,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,25308,0)
 ;;=M47.24^^107^1217^182
 ;;^UTILITY(U,$J,358.3,25308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25308,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,25308,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,25308,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,25309,0)
 ;;=M47.27^^107^1217^181
 ;;^UTILITY(U,$J,358.3,25309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25309,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,25309,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,25309,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,25310,0)
 ;;=M47.812^^107^1217^177
 ;;^UTILITY(U,$J,358.3,25310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25310,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,25310,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,25310,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,25311,0)
 ;;=M47.814^^107^1217^178
 ;;^UTILITY(U,$J,358.3,25311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25311,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,25311,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,25311,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,25312,0)
 ;;=M47.817^^107^1217^179
 ;;^UTILITY(U,$J,358.3,25312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25312,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
