IBDEI081 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7966,1,3,0)
 ;;=3^Rheumatoid Nodule,Unspec Site
 ;;^UTILITY(U,$J,358.3,7966,1,4,0)
 ;;=4^M06.30
 ;;^UTILITY(U,$J,358.3,7966,2)
 ;;=^5010096
 ;;^UTILITY(U,$J,358.3,7967,0)
 ;;=M06.4^^42^504^48
 ;;^UTILITY(U,$J,358.3,7967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7967,1,3,0)
 ;;=3^Inflammatory Polyarthropathy
 ;;^UTILITY(U,$J,358.3,7967,1,4,0)
 ;;=4^M06.4
 ;;^UTILITY(U,$J,358.3,7967,2)
 ;;=^5010120
 ;;^UTILITY(U,$J,358.3,7968,0)
 ;;=M06.39^^42^504^148
 ;;^UTILITY(U,$J,358.3,7968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7968,1,3,0)
 ;;=3^Rheumatoid Nodule,Mult Sites
 ;;^UTILITY(U,$J,358.3,7968,1,4,0)
 ;;=4^M06.39
 ;;^UTILITY(U,$J,358.3,7968,2)
 ;;=^5010119
 ;;^UTILITY(U,$J,358.3,7969,0)
 ;;=M15.0^^42^504^112
 ;;^UTILITY(U,$J,358.3,7969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7969,1,3,0)
 ;;=3^Primary Generalized Osteoarthritis
 ;;^UTILITY(U,$J,358.3,7969,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,7969,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,7970,0)
 ;;=M06.9^^42^504^147
 ;;^UTILITY(U,$J,358.3,7970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7970,1,3,0)
 ;;=3^Rheumatoid Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,7970,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,7970,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,7971,0)
 ;;=M16.0^^42^504^115
 ;;^UTILITY(U,$J,358.3,7971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7971,1,3,0)
 ;;=3^Primary Osteoarthritis of Hip,Bilateral
 ;;^UTILITY(U,$J,358.3,7971,1,4,0)
 ;;=4^M16.0
 ;;^UTILITY(U,$J,358.3,7971,2)
 ;;=^5010769
 ;;^UTILITY(U,$J,358.3,7972,0)
 ;;=M16.11^^42^504^124
 ;;^UTILITY(U,$J,358.3,7972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7972,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,7972,1,4,0)
 ;;=4^M16.11
 ;;^UTILITY(U,$J,358.3,7972,2)
 ;;=^5010771
 ;;^UTILITY(U,$J,358.3,7973,0)
 ;;=M16.12^^42^504^118
 ;;^UTILITY(U,$J,358.3,7973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7973,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,7973,1,4,0)
 ;;=4^M16.12
 ;;^UTILITY(U,$J,358.3,7973,2)
 ;;=^5010772
 ;;^UTILITY(U,$J,358.3,7974,0)
 ;;=M17.0^^42^504^114
 ;;^UTILITY(U,$J,358.3,7974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7974,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral Knees
 ;;^UTILITY(U,$J,358.3,7974,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,7974,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,7975,0)
 ;;=M17.11^^42^504^125
 ;;^UTILITY(U,$J,358.3,7975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7975,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,7975,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,7975,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,7976,0)
 ;;=M17.12^^42^504^119
 ;;^UTILITY(U,$J,358.3,7976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7976,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,7976,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,7976,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,7977,0)
 ;;=M18.0^^42^504^113
 ;;^UTILITY(U,$J,358.3,7977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7977,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral 1st Carpometacarp Jts
 ;;^UTILITY(U,$J,358.3,7977,1,4,0)
 ;;=4^M18.0
 ;;^UTILITY(U,$J,358.3,7977,2)
 ;;=^5010795
 ;;^UTILITY(U,$J,358.3,7978,0)
 ;;=M18.11^^42^504^123
 ;;^UTILITY(U,$J,358.3,7978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7978,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,7978,1,4,0)
 ;;=4^M18.11
 ;;^UTILITY(U,$J,358.3,7978,2)
 ;;=^5010797
 ;;^UTILITY(U,$J,358.3,7979,0)
 ;;=M18.12^^42^504^117
 ;;^UTILITY(U,$J,358.3,7979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7979,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,7979,1,4,0)
 ;;=4^M18.12
 ;;^UTILITY(U,$J,358.3,7979,2)
 ;;=^5010798
 ;;^UTILITY(U,$J,358.3,7980,0)
 ;;=M19.011^^42^504^126
 ;;^UTILITY(U,$J,358.3,7980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7980,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,7980,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,7980,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,7981,0)
 ;;=M19.012^^42^504^120
 ;;^UTILITY(U,$J,358.3,7981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7981,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,7981,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,7981,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,7982,0)
 ;;=M19.031^^42^504^127
 ;;^UTILITY(U,$J,358.3,7982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7982,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,7982,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,7982,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,7983,0)
 ;;=M19.032^^42^504^121
 ;;^UTILITY(U,$J,358.3,7983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7983,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,7983,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,7983,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,7984,0)
 ;;=M19.041^^42^504^122
 ;;^UTILITY(U,$J,358.3,7984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7984,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,7984,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,7984,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,7985,0)
 ;;=M19.042^^42^504^116
 ;;^UTILITY(U,$J,358.3,7985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7985,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,7985,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,7985,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,7986,0)
 ;;=M19.90^^42^504^68
 ;;^UTILITY(U,$J,358.3,7986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7986,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,7986,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,7986,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,7987,0)
 ;;=M25.40^^42^504^37
 ;;^UTILITY(U,$J,358.3,7987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7987,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,7987,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,7987,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,7988,0)
 ;;=M45.0^^42^504^6
 ;;^UTILITY(U,$J,358.3,7988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7988,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,7988,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,7988,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,7989,0)
 ;;=M45.2^^42^504^3
 ;;^UTILITY(U,$J,358.3,7989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7989,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,7989,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,7989,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,7990,0)
 ;;=M45.4^^42^504^7
 ;;^UTILITY(U,$J,358.3,7990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7990,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,7990,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,7990,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,7991,0)
 ;;=M45.7^^42^504^4
 ;;^UTILITY(U,$J,358.3,7991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7991,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,7991,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,7991,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,7992,0)
 ;;=M45.8^^42^504^5
 ;;^UTILITY(U,$J,358.3,7992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7992,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,7992,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,7992,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,7993,0)
 ;;=M47.22^^42^504^163
 ;;^UTILITY(U,$J,358.3,7993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7993,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,7993,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,7993,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,7994,0)
 ;;=M47.24^^42^504^165
