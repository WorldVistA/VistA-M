IBDEI0GR ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7264,1,4,0)
 ;;=4^M18.0
 ;;^UTILITY(U,$J,358.3,7264,2)
 ;;=^5010795
 ;;^UTILITY(U,$J,358.3,7265,0)
 ;;=M18.11^^58^473^135
 ;;^UTILITY(U,$J,358.3,7265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7265,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,7265,1,4,0)
 ;;=4^M18.11
 ;;^UTILITY(U,$J,358.3,7265,2)
 ;;=^5010797
 ;;^UTILITY(U,$J,358.3,7266,0)
 ;;=M18.12^^58^473^129
 ;;^UTILITY(U,$J,358.3,7266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7266,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,7266,1,4,0)
 ;;=4^M18.12
 ;;^UTILITY(U,$J,358.3,7266,2)
 ;;=^5010798
 ;;^UTILITY(U,$J,358.3,7267,0)
 ;;=M19.011^^58^473^138
 ;;^UTILITY(U,$J,358.3,7267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7267,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,7267,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,7267,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,7268,0)
 ;;=M19.012^^58^473^132
 ;;^UTILITY(U,$J,358.3,7268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7268,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,7268,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,7268,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,7269,0)
 ;;=M19.031^^58^473^139
 ;;^UTILITY(U,$J,358.3,7269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7269,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,7269,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,7269,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,7270,0)
 ;;=M19.032^^58^473^133
 ;;^UTILITY(U,$J,358.3,7270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7270,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,7270,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,7270,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,7271,0)
 ;;=M19.041^^58^473^134
 ;;^UTILITY(U,$J,358.3,7271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7271,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,7271,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,7271,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,7272,0)
 ;;=M19.042^^58^473^128
 ;;^UTILITY(U,$J,358.3,7272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7272,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,7272,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,7272,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,7273,0)
 ;;=M19.90^^58^473^71
 ;;^UTILITY(U,$J,358.3,7273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7273,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,7273,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,7273,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,7274,0)
 ;;=M25.40^^58^473^37
 ;;^UTILITY(U,$J,358.3,7274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7274,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,7274,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,7274,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,7275,0)
 ;;=M45.0^^58^473^6
 ;;^UTILITY(U,$J,358.3,7275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7275,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,7275,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,7275,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,7276,0)
 ;;=M45.2^^58^473^3
 ;;^UTILITY(U,$J,358.3,7276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7276,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,7276,1,4,0)
 ;;=4^M45.2
