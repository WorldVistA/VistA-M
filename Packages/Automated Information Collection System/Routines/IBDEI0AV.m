IBDEI0AV ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13784,1,3,0)
 ;;=3^Inflammatory Polyarthropathy
 ;;^UTILITY(U,$J,358.3,13784,1,4,0)
 ;;=4^M06.4
 ;;^UTILITY(U,$J,358.3,13784,2)
 ;;=^5010120
 ;;^UTILITY(U,$J,358.3,13785,0)
 ;;=M06.39^^43^630^157
 ;;^UTILITY(U,$J,358.3,13785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13785,1,3,0)
 ;;=3^Rheumatoid Nodule,Mult Sites
 ;;^UTILITY(U,$J,358.3,13785,1,4,0)
 ;;=4^M06.39
 ;;^UTILITY(U,$J,358.3,13785,2)
 ;;=^5010119
 ;;^UTILITY(U,$J,358.3,13786,0)
 ;;=M15.0^^43^630^121
 ;;^UTILITY(U,$J,358.3,13786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13786,1,3,0)
 ;;=3^Primary Generalized Osteoarthritis
 ;;^UTILITY(U,$J,358.3,13786,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,13786,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,13787,0)
 ;;=M06.9^^43^630^156
 ;;^UTILITY(U,$J,358.3,13787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13787,1,3,0)
 ;;=3^Rheumatoid Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,13787,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,13787,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,13788,0)
 ;;=M16.0^^43^630^124
 ;;^UTILITY(U,$J,358.3,13788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13788,1,3,0)
 ;;=3^Primary Osteoarthritis of Hip,Bilateral
 ;;^UTILITY(U,$J,358.3,13788,1,4,0)
 ;;=4^M16.0
 ;;^UTILITY(U,$J,358.3,13788,2)
 ;;=^5010769
 ;;^UTILITY(U,$J,358.3,13789,0)
 ;;=M16.11^^43^630^133
 ;;^UTILITY(U,$J,358.3,13789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13789,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,13789,1,4,0)
 ;;=4^M16.11
 ;;^UTILITY(U,$J,358.3,13789,2)
 ;;=^5010771
 ;;^UTILITY(U,$J,358.3,13790,0)
 ;;=M16.12^^43^630^127
 ;;^UTILITY(U,$J,358.3,13790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13790,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,13790,1,4,0)
 ;;=4^M16.12
 ;;^UTILITY(U,$J,358.3,13790,2)
 ;;=^5010772
 ;;^UTILITY(U,$J,358.3,13791,0)
 ;;=M17.0^^43^630^123
 ;;^UTILITY(U,$J,358.3,13791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13791,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral Knees
 ;;^UTILITY(U,$J,358.3,13791,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,13791,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,13792,0)
 ;;=M17.11^^43^630^134
 ;;^UTILITY(U,$J,358.3,13792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13792,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,13792,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,13792,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,13793,0)
 ;;=M17.12^^43^630^128
 ;;^UTILITY(U,$J,358.3,13793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13793,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,13793,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,13793,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,13794,0)
 ;;=M18.0^^43^630^122
 ;;^UTILITY(U,$J,358.3,13794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13794,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral 1st Carpometacarp Jts
 ;;^UTILITY(U,$J,358.3,13794,1,4,0)
 ;;=4^M18.0
 ;;^UTILITY(U,$J,358.3,13794,2)
 ;;=^5010795
 ;;^UTILITY(U,$J,358.3,13795,0)
 ;;=M18.11^^43^630^132
 ;;^UTILITY(U,$J,358.3,13795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13795,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,13795,1,4,0)
 ;;=4^M18.11
 ;;^UTILITY(U,$J,358.3,13795,2)
 ;;=^5010797
 ;;^UTILITY(U,$J,358.3,13796,0)
 ;;=M18.12^^43^630^126
 ;;^UTILITY(U,$J,358.3,13796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13796,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,13796,1,4,0)
 ;;=4^M18.12
 ;;^UTILITY(U,$J,358.3,13796,2)
 ;;=^5010798
 ;;^UTILITY(U,$J,358.3,13797,0)
 ;;=M19.011^^43^630^135
 ;;^UTILITY(U,$J,358.3,13797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13797,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,13797,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,13797,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,13798,0)
 ;;=M19.012^^43^630^129
 ;;^UTILITY(U,$J,358.3,13798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13798,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,13798,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,13798,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,13799,0)
 ;;=M19.031^^43^630^136
 ;;^UTILITY(U,$J,358.3,13799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13799,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,13799,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,13799,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,13800,0)
 ;;=M19.032^^43^630^130
 ;;^UTILITY(U,$J,358.3,13800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13800,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,13800,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,13800,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,13801,0)
 ;;=M19.041^^43^630^131
 ;;^UTILITY(U,$J,358.3,13801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13801,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,13801,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,13801,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,13802,0)
 ;;=M19.042^^43^630^125
 ;;^UTILITY(U,$J,358.3,13802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13802,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,13802,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,13802,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,13803,0)
 ;;=M19.90^^43^630^68
 ;;^UTILITY(U,$J,358.3,13803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13803,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,13803,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,13803,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,13804,0)
 ;;=M25.40^^43^630^37
 ;;^UTILITY(U,$J,358.3,13804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13804,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,13804,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,13804,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,13805,0)
 ;;=M45.0^^43^630^6
 ;;^UTILITY(U,$J,358.3,13805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13805,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,13805,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,13805,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,13806,0)
 ;;=M45.2^^43^630^3
 ;;^UTILITY(U,$J,358.3,13806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13806,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,13806,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,13806,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,13807,0)
 ;;=M45.4^^43^630^7
 ;;^UTILITY(U,$J,358.3,13807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13807,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,13807,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,13807,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,13808,0)
 ;;=M45.7^^43^630^4
 ;;^UTILITY(U,$J,358.3,13808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13808,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,13808,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,13808,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,13809,0)
 ;;=M45.8^^43^630^5
 ;;^UTILITY(U,$J,358.3,13809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13809,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,13809,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,13809,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,13810,0)
 ;;=M47.22^^43^630^172
 ;;^UTILITY(U,$J,358.3,13810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13810,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,13810,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,13810,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,13811,0)
 ;;=M47.24^^43^630^174
 ;;^UTILITY(U,$J,358.3,13811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13811,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,13811,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,13811,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,13812,0)
 ;;=M47.27^^43^630^173
 ;;^UTILITY(U,$J,358.3,13812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13812,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,13812,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,13812,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,13813,0)
 ;;=M47.812^^43^630^169
 ;;^UTILITY(U,$J,358.3,13813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13813,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,13813,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,13813,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,13814,0)
 ;;=M47.814^^43^630^170
 ;;^UTILITY(U,$J,358.3,13814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13814,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,13814,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,13814,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,13815,0)
 ;;=M47.817^^43^630^171
 ;;^UTILITY(U,$J,358.3,13815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13815,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,13815,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,13815,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,13816,0)
 ;;=M48.50XA^^43^630^21
 ;;^UTILITY(U,$J,358.3,13816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13816,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,13816,1,4,0)
 ;;=4^M48.50XA
 ;;^UTILITY(U,$J,358.3,13816,2)
 ;;=^5012159
 ;;^UTILITY(U,$J,358.3,13817,0)
 ;;=M48.50XD^^43^630^22
 ;;^UTILITY(U,$J,358.3,13817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13817,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,13817,1,4,0)
 ;;=4^M48.50XD
 ;;^UTILITY(U,$J,358.3,13817,2)
 ;;=^5012160
 ;;^UTILITY(U,$J,358.3,13818,0)
 ;;=M48.52XA^^43^630^23
 ;;^UTILITY(U,$J,358.3,13818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13818,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,13818,1,4,0)
 ;;=4^M48.52XA
