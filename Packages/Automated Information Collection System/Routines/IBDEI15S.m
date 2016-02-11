IBDEI15S ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19358,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,19358,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,19358,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,19359,0)
 ;;=M45.0^^94^922^6
 ;;^UTILITY(U,$J,358.3,19359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19359,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,19359,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,19359,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,19360,0)
 ;;=M45.2^^94^922^3
 ;;^UTILITY(U,$J,358.3,19360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19360,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,19360,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,19360,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,19361,0)
 ;;=M45.4^^94^922^7
 ;;^UTILITY(U,$J,358.3,19361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19361,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,19361,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,19361,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,19362,0)
 ;;=M45.7^^94^922^4
 ;;^UTILITY(U,$J,358.3,19362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19362,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,19362,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,19362,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,19363,0)
 ;;=M45.8^^94^922^5
 ;;^UTILITY(U,$J,358.3,19363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19363,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,19363,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,19363,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,19364,0)
 ;;=M47.22^^94^922^155
 ;;^UTILITY(U,$J,358.3,19364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19364,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,19364,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,19364,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,19365,0)
 ;;=M47.24^^94^922^157
 ;;^UTILITY(U,$J,358.3,19365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19365,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,19365,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,19365,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,19366,0)
 ;;=M47.27^^94^922^156
 ;;^UTILITY(U,$J,358.3,19366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19366,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,19366,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,19366,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,19367,0)
 ;;=M47.812^^94^922^152
 ;;^UTILITY(U,$J,358.3,19367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19367,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,19367,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,19367,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,19368,0)
 ;;=M47.814^^94^922^153
 ;;^UTILITY(U,$J,358.3,19368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19368,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,19368,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,19368,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,19369,0)
 ;;=M47.817^^94^922^154
 ;;^UTILITY(U,$J,358.3,19369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19369,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,19369,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,19369,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,19370,0)
 ;;=M48.50XA^^94^922^21
 ;;^UTILITY(U,$J,358.3,19370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19370,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Init Encntr
