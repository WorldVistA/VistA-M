IBDEI125 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17001,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,17001,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,17001,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,17002,0)
 ;;=M45.4^^88^885^7
 ;;^UTILITY(U,$J,358.3,17002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17002,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,17002,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,17002,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,17003,0)
 ;;=M45.7^^88^885^4
 ;;^UTILITY(U,$J,358.3,17003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17003,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,17003,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,17003,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,17004,0)
 ;;=M45.8^^88^885^5
 ;;^UTILITY(U,$J,358.3,17004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17004,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,17004,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,17004,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,17005,0)
 ;;=M47.22^^88^885^180
 ;;^UTILITY(U,$J,358.3,17005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17005,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,17005,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,17005,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,17006,0)
 ;;=M47.24^^88^885^182
 ;;^UTILITY(U,$J,358.3,17006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17006,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,17006,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,17006,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,17007,0)
 ;;=M47.27^^88^885^181
 ;;^UTILITY(U,$J,358.3,17007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17007,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,17007,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,17007,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,17008,0)
 ;;=M47.812^^88^885^177
 ;;^UTILITY(U,$J,358.3,17008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17008,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,17008,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,17008,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,17009,0)
 ;;=M47.814^^88^885^178
 ;;^UTILITY(U,$J,358.3,17009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17009,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,17009,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,17009,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,17010,0)
 ;;=M47.817^^88^885^179
 ;;^UTILITY(U,$J,358.3,17010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17010,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,17010,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,17010,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,17011,0)
 ;;=M48.50XA^^88^885^22
 ;;^UTILITY(U,$J,358.3,17011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17011,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,17011,1,4,0)
 ;;=4^M48.50XA
 ;;^UTILITY(U,$J,358.3,17011,2)
 ;;=^5012159
 ;;^UTILITY(U,$J,358.3,17012,0)
 ;;=M48.50XD^^88^885^23
 ;;^UTILITY(U,$J,358.3,17012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17012,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17012,1,4,0)
 ;;=4^M48.50XD
