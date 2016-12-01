IBDEI05M ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6968,2)
 ;;=^5010120
 ;;^UTILITY(U,$J,358.3,6969,0)
 ;;=M06.39^^26^408^148
 ;;^UTILITY(U,$J,358.3,6969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6969,1,3,0)
 ;;=3^Rheumatoid Nodule,Mult Sites
 ;;^UTILITY(U,$J,358.3,6969,1,4,0)
 ;;=4^M06.39
 ;;^UTILITY(U,$J,358.3,6969,2)
 ;;=^5010119
 ;;^UTILITY(U,$J,358.3,6970,0)
 ;;=M15.0^^26^408^112
 ;;^UTILITY(U,$J,358.3,6970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6970,1,3,0)
 ;;=3^Primary Generalized Osteoarthritis
 ;;^UTILITY(U,$J,358.3,6970,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,6970,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,6971,0)
 ;;=M06.9^^26^408^147
 ;;^UTILITY(U,$J,358.3,6971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6971,1,3,0)
 ;;=3^Rheumatoid Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,6971,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,6971,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,6972,0)
 ;;=M16.0^^26^408^115
 ;;^UTILITY(U,$J,358.3,6972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6972,1,3,0)
 ;;=3^Primary Osteoarthritis of Hip,Bilateral
 ;;^UTILITY(U,$J,358.3,6972,1,4,0)
 ;;=4^M16.0
 ;;^UTILITY(U,$J,358.3,6972,2)
 ;;=^5010769
 ;;^UTILITY(U,$J,358.3,6973,0)
 ;;=M16.11^^26^408^124
 ;;^UTILITY(U,$J,358.3,6973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6973,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,6973,1,4,0)
 ;;=4^M16.11
 ;;^UTILITY(U,$J,358.3,6973,2)
 ;;=^5010771
 ;;^UTILITY(U,$J,358.3,6974,0)
 ;;=M16.12^^26^408^118
 ;;^UTILITY(U,$J,358.3,6974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6974,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,6974,1,4,0)
 ;;=4^M16.12
 ;;^UTILITY(U,$J,358.3,6974,2)
 ;;=^5010772
 ;;^UTILITY(U,$J,358.3,6975,0)
 ;;=M17.0^^26^408^114
 ;;^UTILITY(U,$J,358.3,6975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6975,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral Knees
 ;;^UTILITY(U,$J,358.3,6975,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,6975,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,6976,0)
 ;;=M17.11^^26^408^125
 ;;^UTILITY(U,$J,358.3,6976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6976,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,6976,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,6976,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,6977,0)
 ;;=M17.12^^26^408^119
 ;;^UTILITY(U,$J,358.3,6977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6977,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,6977,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,6977,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,6978,0)
 ;;=M18.0^^26^408^113
 ;;^UTILITY(U,$J,358.3,6978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6978,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral 1st Carpometacarp Jts
 ;;^UTILITY(U,$J,358.3,6978,1,4,0)
 ;;=4^M18.0
 ;;^UTILITY(U,$J,358.3,6978,2)
 ;;=^5010795
 ;;^UTILITY(U,$J,358.3,6979,0)
 ;;=M18.11^^26^408^123
 ;;^UTILITY(U,$J,358.3,6979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6979,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,6979,1,4,0)
 ;;=4^M18.11
 ;;^UTILITY(U,$J,358.3,6979,2)
 ;;=^5010797
 ;;^UTILITY(U,$J,358.3,6980,0)
 ;;=M18.12^^26^408^117
 ;;^UTILITY(U,$J,358.3,6980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6980,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,6980,1,4,0)
 ;;=4^M18.12
 ;;^UTILITY(U,$J,358.3,6980,2)
 ;;=^5010798
 ;;^UTILITY(U,$J,358.3,6981,0)
 ;;=M19.011^^26^408^126
 ;;^UTILITY(U,$J,358.3,6981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6981,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,6981,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,6981,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,6982,0)
 ;;=M19.012^^26^408^120
 ;;^UTILITY(U,$J,358.3,6982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6982,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,6982,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,6982,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,6983,0)
 ;;=M19.031^^26^408^127
 ;;^UTILITY(U,$J,358.3,6983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6983,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,6983,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,6983,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,6984,0)
 ;;=M19.032^^26^408^121
 ;;^UTILITY(U,$J,358.3,6984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6984,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,6984,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,6984,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,6985,0)
 ;;=M19.041^^26^408^122
 ;;^UTILITY(U,$J,358.3,6985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6985,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,6985,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,6985,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,6986,0)
 ;;=M19.042^^26^408^116
 ;;^UTILITY(U,$J,358.3,6986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6986,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,6986,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,6986,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,6987,0)
 ;;=M19.90^^26^408^68
 ;;^UTILITY(U,$J,358.3,6987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6987,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,6987,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,6987,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,6988,0)
 ;;=M25.40^^26^408^37
 ;;^UTILITY(U,$J,358.3,6988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6988,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,6988,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,6988,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,6989,0)
 ;;=M45.0^^26^408^6
 ;;^UTILITY(U,$J,358.3,6989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6989,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,6989,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,6989,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,6990,0)
 ;;=M45.2^^26^408^3
 ;;^UTILITY(U,$J,358.3,6990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6990,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,6990,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,6990,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,6991,0)
 ;;=M45.4^^26^408^7
 ;;^UTILITY(U,$J,358.3,6991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6991,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,6991,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,6991,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,6992,0)
 ;;=M45.7^^26^408^4
 ;;^UTILITY(U,$J,358.3,6992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6992,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,6992,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,6992,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,6993,0)
 ;;=M45.8^^26^408^5
 ;;^UTILITY(U,$J,358.3,6993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6993,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,6993,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,6993,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,6994,0)
 ;;=M47.22^^26^408^163
 ;;^UTILITY(U,$J,358.3,6994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6994,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,6994,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,6994,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,6995,0)
 ;;=M47.24^^26^408^165
 ;;^UTILITY(U,$J,358.3,6995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6995,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,6995,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,6995,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,6996,0)
 ;;=M47.27^^26^408^164
 ;;^UTILITY(U,$J,358.3,6996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6996,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,6996,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,6996,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,6997,0)
 ;;=M47.812^^26^408^160
 ;;^UTILITY(U,$J,358.3,6997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6997,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,6997,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,6997,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,6998,0)
 ;;=M47.814^^26^408^161
 ;;^UTILITY(U,$J,358.3,6998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6998,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,6998,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,6998,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,6999,0)
 ;;=M47.817^^26^408^162
 ;;^UTILITY(U,$J,358.3,6999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6999,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,6999,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,6999,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,7000,0)
 ;;=M48.50XA^^26^408^21
 ;;^UTILITY(U,$J,358.3,7000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7000,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,7000,1,4,0)
 ;;=4^M48.50XA
 ;;^UTILITY(U,$J,358.3,7000,2)
 ;;=^5012159
 ;;^UTILITY(U,$J,358.3,7001,0)
 ;;=M48.50XD^^26^408^22
 ;;^UTILITY(U,$J,358.3,7001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7001,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7001,1,4,0)
 ;;=4^M48.50XD
 ;;^UTILITY(U,$J,358.3,7001,2)
 ;;=^5012160
 ;;^UTILITY(U,$J,358.3,7002,0)
 ;;=M48.52XA^^26^408^23
 ;;^UTILITY(U,$J,358.3,7002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7002,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,7002,1,4,0)
 ;;=4^M48.52XA
 ;;^UTILITY(U,$J,358.3,7002,2)
 ;;=^5012167
 ;;^UTILITY(U,$J,358.3,7003,0)
 ;;=M48.52XD^^26^408^24
 ;;^UTILITY(U,$J,358.3,7003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7003,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,7003,1,4,0)
 ;;=4^M48.52XD
