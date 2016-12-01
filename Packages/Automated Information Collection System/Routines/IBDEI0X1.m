IBDEI0X1 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,43352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43352,1,3,0)
 ;;=3^Rheumatoid Arthritis w/o Rhematoid Factor,Unspec Site
 ;;^UTILITY(U,$J,358.3,43352,1,4,0)
 ;;=4^M06.00
 ;;^UTILITY(U,$J,358.3,43352,2)
 ;;=^5010047
 ;;^UTILITY(U,$J,358.3,43353,0)
 ;;=M06.30^^127^1861^158
 ;;^UTILITY(U,$J,358.3,43353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43353,1,3,0)
 ;;=3^Rheumatoid Nodule,Unspec Site
 ;;^UTILITY(U,$J,358.3,43353,1,4,0)
 ;;=4^M06.30
 ;;^UTILITY(U,$J,358.3,43353,2)
 ;;=^5010096
 ;;^UTILITY(U,$J,358.3,43354,0)
 ;;=M06.4^^127^1861^48
 ;;^UTILITY(U,$J,358.3,43354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43354,1,3,0)
 ;;=3^Inflammatory Polyarthropathy
 ;;^UTILITY(U,$J,358.3,43354,1,4,0)
 ;;=4^M06.4
 ;;^UTILITY(U,$J,358.3,43354,2)
 ;;=^5010120
 ;;^UTILITY(U,$J,358.3,43355,0)
 ;;=M06.39^^127^1861^157
 ;;^UTILITY(U,$J,358.3,43355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43355,1,3,0)
 ;;=3^Rheumatoid Nodule,Mult Sites
 ;;^UTILITY(U,$J,358.3,43355,1,4,0)
 ;;=4^M06.39
 ;;^UTILITY(U,$J,358.3,43355,2)
 ;;=^5010119
 ;;^UTILITY(U,$J,358.3,43356,0)
 ;;=M15.0^^127^1861^121
 ;;^UTILITY(U,$J,358.3,43356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43356,1,3,0)
 ;;=3^Primary Generalized Osteoarthritis
 ;;^UTILITY(U,$J,358.3,43356,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,43356,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,43357,0)
 ;;=M06.9^^127^1861^156
 ;;^UTILITY(U,$J,358.3,43357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43357,1,3,0)
 ;;=3^Rheumatoid Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,43357,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,43357,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,43358,0)
 ;;=M16.0^^127^1861^124
 ;;^UTILITY(U,$J,358.3,43358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43358,1,3,0)
 ;;=3^Primary Osteoarthritis of Hip,Bilateral
 ;;^UTILITY(U,$J,358.3,43358,1,4,0)
 ;;=4^M16.0
 ;;^UTILITY(U,$J,358.3,43358,2)
 ;;=^5010769
 ;;^UTILITY(U,$J,358.3,43359,0)
 ;;=M16.11^^127^1861^133
 ;;^UTILITY(U,$J,358.3,43359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43359,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,43359,1,4,0)
 ;;=4^M16.11
 ;;^UTILITY(U,$J,358.3,43359,2)
 ;;=^5010771
 ;;^UTILITY(U,$J,358.3,43360,0)
 ;;=M16.12^^127^1861^127
 ;;^UTILITY(U,$J,358.3,43360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43360,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,43360,1,4,0)
 ;;=4^M16.12
 ;;^UTILITY(U,$J,358.3,43360,2)
 ;;=^5010772
 ;;^UTILITY(U,$J,358.3,43361,0)
 ;;=M17.0^^127^1861^123
 ;;^UTILITY(U,$J,358.3,43361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43361,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral Knees
 ;;^UTILITY(U,$J,358.3,43361,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,43361,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,43362,0)
 ;;=M17.11^^127^1861^134
 ;;^UTILITY(U,$J,358.3,43362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43362,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,43362,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,43362,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,43363,0)
 ;;=M17.12^^127^1861^128
 ;;^UTILITY(U,$J,358.3,43363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43363,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,43363,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,43363,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,43364,0)
 ;;=M18.0^^127^1861^122
 ;;^UTILITY(U,$J,358.3,43364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43364,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral 1st Carpometacarp Jts
 ;;^UTILITY(U,$J,358.3,43364,1,4,0)
 ;;=4^M18.0
 ;;^UTILITY(U,$J,358.3,43364,2)
 ;;=^5010795
 ;;^UTILITY(U,$J,358.3,43365,0)
 ;;=M18.11^^127^1861^132
 ;;^UTILITY(U,$J,358.3,43365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43365,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,43365,1,4,0)
 ;;=4^M18.11
 ;;^UTILITY(U,$J,358.3,43365,2)
 ;;=^5010797
 ;;^UTILITY(U,$J,358.3,43366,0)
 ;;=M18.12^^127^1861^126
 ;;^UTILITY(U,$J,358.3,43366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43366,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,43366,1,4,0)
 ;;=4^M18.12
 ;;^UTILITY(U,$J,358.3,43366,2)
 ;;=^5010798
 ;;^UTILITY(U,$J,358.3,43367,0)
 ;;=M19.011^^127^1861^135
 ;;^UTILITY(U,$J,358.3,43367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43367,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,43367,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,43367,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,43368,0)
 ;;=M19.012^^127^1861^129
 ;;^UTILITY(U,$J,358.3,43368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43368,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,43368,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,43368,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,43369,0)
 ;;=M19.031^^127^1861^136
 ;;^UTILITY(U,$J,358.3,43369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43369,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,43369,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,43369,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,43370,0)
 ;;=M19.032^^127^1861^130
 ;;^UTILITY(U,$J,358.3,43370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43370,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,43370,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,43370,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,43371,0)
 ;;=M19.041^^127^1861^131
 ;;^UTILITY(U,$J,358.3,43371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43371,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,43371,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,43371,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,43372,0)
 ;;=M19.042^^127^1861^125
 ;;^UTILITY(U,$J,358.3,43372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43372,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,43372,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,43372,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,43373,0)
 ;;=M19.90^^127^1861^68
 ;;^UTILITY(U,$J,358.3,43373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43373,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,43373,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,43373,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,43374,0)
 ;;=M25.40^^127^1861^37
 ;;^UTILITY(U,$J,358.3,43374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43374,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,43374,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,43374,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,43375,0)
 ;;=M45.0^^127^1861^6
 ;;^UTILITY(U,$J,358.3,43375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43375,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,43375,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,43375,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,43376,0)
 ;;=M45.2^^127^1861^3
 ;;^UTILITY(U,$J,358.3,43376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43376,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,43376,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,43376,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,43377,0)
 ;;=M45.4^^127^1861^7
 ;;^UTILITY(U,$J,358.3,43377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43377,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,43377,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,43377,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,43378,0)
 ;;=M45.7^^127^1861^4
 ;;^UTILITY(U,$J,358.3,43378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43378,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,43378,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,43378,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,43379,0)
 ;;=M45.8^^127^1861^5
 ;;^UTILITY(U,$J,358.3,43379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43379,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,43379,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,43379,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,43380,0)
 ;;=M47.22^^127^1861^172
 ;;^UTILITY(U,$J,358.3,43380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43380,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,43380,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,43380,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,43381,0)
 ;;=M47.24^^127^1861^174
 ;;^UTILITY(U,$J,358.3,43381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43381,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,43381,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,43381,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,43382,0)
 ;;=M47.27^^127^1861^173
 ;;^UTILITY(U,$J,358.3,43382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43382,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,43382,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,43382,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,43383,0)
 ;;=M47.812^^127^1861^169
 ;;^UTILITY(U,$J,358.3,43383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43383,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,43383,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,43383,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,43384,0)
 ;;=M47.814^^127^1861^170
 ;;^UTILITY(U,$J,358.3,43384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43384,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,43384,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,43384,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,43385,0)
 ;;=M47.817^^127^1861^171
 ;;^UTILITY(U,$J,358.3,43385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43385,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,43385,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,43385,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,43386,0)
 ;;=M48.50XA^^127^1861^21
 ;;^UTILITY(U,$J,358.3,43386,1,0)
 ;;=^358.31IA^4^2
