IBDEI0F9 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7034,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,7034,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,7035,0)
 ;;=M19.032^^30^402^121
 ;;^UTILITY(U,$J,358.3,7035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7035,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,7035,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,7035,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,7036,0)
 ;;=M19.041^^30^402^122
 ;;^UTILITY(U,$J,358.3,7036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7036,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,7036,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,7036,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,7037,0)
 ;;=M19.042^^30^402^116
 ;;^UTILITY(U,$J,358.3,7037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7037,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,7037,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,7037,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,7038,0)
 ;;=M19.90^^30^402^68
 ;;^UTILITY(U,$J,358.3,7038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7038,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,7038,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,7038,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,7039,0)
 ;;=M25.40^^30^402^37
 ;;^UTILITY(U,$J,358.3,7039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7039,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,7039,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,7039,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,7040,0)
 ;;=M45.0^^30^402^6
 ;;^UTILITY(U,$J,358.3,7040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7040,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,7040,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,7040,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,7041,0)
 ;;=M45.2^^30^402^3
 ;;^UTILITY(U,$J,358.3,7041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7041,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,7041,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,7041,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,7042,0)
 ;;=M45.4^^30^402^7
 ;;^UTILITY(U,$J,358.3,7042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7042,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,7042,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,7042,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,7043,0)
 ;;=M45.7^^30^402^4
 ;;^UTILITY(U,$J,358.3,7043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7043,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,7043,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,7043,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,7044,0)
 ;;=M45.8^^30^402^5
 ;;^UTILITY(U,$J,358.3,7044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7044,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,7044,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,7044,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,7045,0)
 ;;=M47.22^^30^402^163
 ;;^UTILITY(U,$J,358.3,7045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7045,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,7045,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,7045,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,7046,0)
 ;;=M47.24^^30^402^165
 ;;^UTILITY(U,$J,358.3,7046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7046,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,7046,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,7046,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,7047,0)
 ;;=M47.27^^30^402^164
 ;;^UTILITY(U,$J,358.3,7047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7047,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
