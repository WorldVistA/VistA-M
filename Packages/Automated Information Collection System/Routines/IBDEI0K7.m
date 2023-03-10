IBDEI0K7 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9089,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,9089,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,9090,0)
 ;;=M19.041^^39^407^137
 ;;^UTILITY(U,$J,358.3,9090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9090,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,9090,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,9090,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,9091,0)
 ;;=M19.042^^39^407^131
 ;;^UTILITY(U,$J,358.3,9091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9091,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,9091,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,9091,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,9092,0)
 ;;=M19.90^^39^407^72
 ;;^UTILITY(U,$J,358.3,9092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9092,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,9092,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,9092,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,9093,0)
 ;;=M25.40^^39^407^38
 ;;^UTILITY(U,$J,358.3,9093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9093,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,9093,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,9093,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,9094,0)
 ;;=M45.0^^39^407^6
 ;;^UTILITY(U,$J,358.3,9094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9094,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,9094,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,9094,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,9095,0)
 ;;=M45.2^^39^407^3
 ;;^UTILITY(U,$J,358.3,9095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9095,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,9095,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,9095,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,9096,0)
 ;;=M45.4^^39^407^7
 ;;^UTILITY(U,$J,358.3,9096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9096,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,9096,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,9096,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,9097,0)
 ;;=M45.7^^39^407^4
 ;;^UTILITY(U,$J,358.3,9097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9097,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,9097,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,9097,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,9098,0)
 ;;=M45.8^^39^407^5
 ;;^UTILITY(U,$J,358.3,9098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9098,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,9098,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,9098,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,9099,0)
 ;;=M47.22^^39^407^180
 ;;^UTILITY(U,$J,358.3,9099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9099,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,9099,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,9099,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,9100,0)
 ;;=M47.24^^39^407^182
 ;;^UTILITY(U,$J,358.3,9100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9100,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,9100,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,9100,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,9101,0)
 ;;=M47.27^^39^407^181
 ;;^UTILITY(U,$J,358.3,9101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9101,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,9101,1,4,0)
 ;;=4^M47.27
