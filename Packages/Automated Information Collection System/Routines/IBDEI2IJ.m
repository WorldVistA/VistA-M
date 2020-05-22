IBDEI2IJ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40125,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,40125,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,40125,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,40126,0)
 ;;=M25.40^^152^2006^38
 ;;^UTILITY(U,$J,358.3,40126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40126,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,40126,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,40126,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,40127,0)
 ;;=M45.0^^152^2006^6
 ;;^UTILITY(U,$J,358.3,40127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40127,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,40127,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,40127,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,40128,0)
 ;;=M45.2^^152^2006^3
 ;;^UTILITY(U,$J,358.3,40128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40128,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,40128,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,40128,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,40129,0)
 ;;=M45.4^^152^2006^7
 ;;^UTILITY(U,$J,358.3,40129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40129,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,40129,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,40129,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,40130,0)
 ;;=M45.7^^152^2006^4
 ;;^UTILITY(U,$J,358.3,40130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40130,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,40130,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,40130,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,40131,0)
 ;;=M45.8^^152^2006^5
 ;;^UTILITY(U,$J,358.3,40131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40131,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,40131,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,40131,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,40132,0)
 ;;=M47.22^^152^2006^180
 ;;^UTILITY(U,$J,358.3,40132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40132,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,40132,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,40132,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,40133,0)
 ;;=M47.24^^152^2006^182
 ;;^UTILITY(U,$J,358.3,40133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40133,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,40133,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,40133,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,40134,0)
 ;;=M47.27^^152^2006^181
 ;;^UTILITY(U,$J,358.3,40134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40134,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,40134,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,40134,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,40135,0)
 ;;=M47.812^^152^2006^177
 ;;^UTILITY(U,$J,358.3,40135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40135,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,40135,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,40135,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,40136,0)
 ;;=M47.814^^152^2006^178
 ;;^UTILITY(U,$J,358.3,40136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40136,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,40136,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,40136,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,40137,0)
 ;;=M47.817^^152^2006^179
