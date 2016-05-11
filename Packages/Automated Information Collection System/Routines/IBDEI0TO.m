IBDEI0TO ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13914,2)
 ;;=^5010798
 ;;^UTILITY(U,$J,358.3,13915,0)
 ;;=M19.011^^53^599^135
 ;;^UTILITY(U,$J,358.3,13915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13915,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,13915,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,13915,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,13916,0)
 ;;=M19.012^^53^599^129
 ;;^UTILITY(U,$J,358.3,13916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13916,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,13916,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,13916,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,13917,0)
 ;;=M19.031^^53^599^136
 ;;^UTILITY(U,$J,358.3,13917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13917,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,13917,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,13917,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,13918,0)
 ;;=M19.032^^53^599^130
 ;;^UTILITY(U,$J,358.3,13918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13918,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,13918,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,13918,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,13919,0)
 ;;=M19.041^^53^599^131
 ;;^UTILITY(U,$J,358.3,13919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13919,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,13919,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,13919,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,13920,0)
 ;;=M19.042^^53^599^125
 ;;^UTILITY(U,$J,358.3,13920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13920,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,13920,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,13920,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,13921,0)
 ;;=M19.90^^53^599^68
 ;;^UTILITY(U,$J,358.3,13921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13921,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,13921,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,13921,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,13922,0)
 ;;=M25.40^^53^599^37
 ;;^UTILITY(U,$J,358.3,13922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13922,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,13922,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,13922,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,13923,0)
 ;;=M45.0^^53^599^6
 ;;^UTILITY(U,$J,358.3,13923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13923,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,13923,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,13923,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,13924,0)
 ;;=M45.2^^53^599^3
 ;;^UTILITY(U,$J,358.3,13924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13924,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,13924,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,13924,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,13925,0)
 ;;=M45.4^^53^599^7
 ;;^UTILITY(U,$J,358.3,13925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13925,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,13925,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,13925,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,13926,0)
 ;;=M45.7^^53^599^4
 ;;^UTILITY(U,$J,358.3,13926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13926,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,13926,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,13926,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,13927,0)
 ;;=M45.8^^53^599^5
 ;;^UTILITY(U,$J,358.3,13927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13927,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
