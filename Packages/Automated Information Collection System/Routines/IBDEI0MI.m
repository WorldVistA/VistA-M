IBDEI0MI ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22696,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Ankle
 ;;^UTILITY(U,$J,358.3,22696,1,4,0)
 ;;=4^M05.771
 ;;^UTILITY(U,$J,358.3,22696,2)
 ;;=^5010019
 ;;^UTILITY(U,$J,358.3,22697,0)
 ;;=M05.772^^89^1052^142
 ;;^UTILITY(U,$J,358.3,22697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22697,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Ankle
 ;;^UTILITY(U,$J,358.3,22697,1,4,0)
 ;;=4^M05.772
 ;;^UTILITY(U,$J,358.3,22697,2)
 ;;=^5010020
 ;;^UTILITY(U,$J,358.3,22698,0)
 ;;=M05.79^^89^1052^148
 ;;^UTILITY(U,$J,358.3,22698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22698,1,3,0)
 ;;=3^Rheumatoid Arthritis of Multiple Sites
 ;;^UTILITY(U,$J,358.3,22698,1,4,0)
 ;;=4^M05.79
 ;;^UTILITY(U,$J,358.3,22698,2)
 ;;=^5010022
 ;;^UTILITY(U,$J,358.3,22699,0)
 ;;=M06.00^^89^1052^155
 ;;^UTILITY(U,$J,358.3,22699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22699,1,3,0)
 ;;=3^Rheumatoid Arthritis w/o Rhematoid Factor,Unspec Site
 ;;^UTILITY(U,$J,358.3,22699,1,4,0)
 ;;=4^M06.00
 ;;^UTILITY(U,$J,358.3,22699,2)
 ;;=^5010047
 ;;^UTILITY(U,$J,358.3,22700,0)
 ;;=M06.30^^89^1052^158
 ;;^UTILITY(U,$J,358.3,22700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22700,1,3,0)
 ;;=3^Rheumatoid Nodule,Unspec Site
 ;;^UTILITY(U,$J,358.3,22700,1,4,0)
 ;;=4^M06.30
 ;;^UTILITY(U,$J,358.3,22700,2)
 ;;=^5010096
 ;;^UTILITY(U,$J,358.3,22701,0)
 ;;=M06.4^^89^1052^48
 ;;^UTILITY(U,$J,358.3,22701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22701,1,3,0)
 ;;=3^Inflammatory Polyarthropathy
 ;;^UTILITY(U,$J,358.3,22701,1,4,0)
 ;;=4^M06.4
 ;;^UTILITY(U,$J,358.3,22701,2)
 ;;=^5010120
 ;;^UTILITY(U,$J,358.3,22702,0)
 ;;=M06.39^^89^1052^157
 ;;^UTILITY(U,$J,358.3,22702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22702,1,3,0)
 ;;=3^Rheumatoid Nodule,Mult Sites
 ;;^UTILITY(U,$J,358.3,22702,1,4,0)
 ;;=4^M06.39
 ;;^UTILITY(U,$J,358.3,22702,2)
 ;;=^5010119
 ;;^UTILITY(U,$J,358.3,22703,0)
 ;;=M15.0^^89^1052^121
 ;;^UTILITY(U,$J,358.3,22703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22703,1,3,0)
 ;;=3^Primary Generalized Osteoarthritis
 ;;^UTILITY(U,$J,358.3,22703,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,22703,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,22704,0)
 ;;=M06.9^^89^1052^156
 ;;^UTILITY(U,$J,358.3,22704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22704,1,3,0)
 ;;=3^Rheumatoid Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,22704,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,22704,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,22705,0)
 ;;=M16.0^^89^1052^124
 ;;^UTILITY(U,$J,358.3,22705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22705,1,3,0)
 ;;=3^Primary Osteoarthritis of Hip,Bilateral
 ;;^UTILITY(U,$J,358.3,22705,1,4,0)
 ;;=4^M16.0
 ;;^UTILITY(U,$J,358.3,22705,2)
 ;;=^5010769
 ;;^UTILITY(U,$J,358.3,22706,0)
 ;;=M16.11^^89^1052^133
 ;;^UTILITY(U,$J,358.3,22706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22706,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,22706,1,4,0)
 ;;=4^M16.11
 ;;^UTILITY(U,$J,358.3,22706,2)
 ;;=^5010771
 ;;^UTILITY(U,$J,358.3,22707,0)
 ;;=M16.12^^89^1052^127
 ;;^UTILITY(U,$J,358.3,22707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22707,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,22707,1,4,0)
 ;;=4^M16.12
 ;;^UTILITY(U,$J,358.3,22707,2)
 ;;=^5010772
 ;;^UTILITY(U,$J,358.3,22708,0)
 ;;=M17.0^^89^1052^123
 ;;^UTILITY(U,$J,358.3,22708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22708,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral Knees
 ;;^UTILITY(U,$J,358.3,22708,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,22708,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,22709,0)
 ;;=M17.11^^89^1052^134
 ;;^UTILITY(U,$J,358.3,22709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22709,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,22709,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,22709,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,22710,0)
 ;;=M17.12^^89^1052^128
 ;;^UTILITY(U,$J,358.3,22710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22710,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,22710,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,22710,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,22711,0)
 ;;=M18.0^^89^1052^122
 ;;^UTILITY(U,$J,358.3,22711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22711,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral 1st Carpometacarp Jts
 ;;^UTILITY(U,$J,358.3,22711,1,4,0)
 ;;=4^M18.0
 ;;^UTILITY(U,$J,358.3,22711,2)
 ;;=^5010795
 ;;^UTILITY(U,$J,358.3,22712,0)
 ;;=M18.11^^89^1052^132
 ;;^UTILITY(U,$J,358.3,22712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22712,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,22712,1,4,0)
 ;;=4^M18.11
 ;;^UTILITY(U,$J,358.3,22712,2)
 ;;=^5010797
 ;;^UTILITY(U,$J,358.3,22713,0)
 ;;=M18.12^^89^1052^126
 ;;^UTILITY(U,$J,358.3,22713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22713,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,22713,1,4,0)
 ;;=4^M18.12
 ;;^UTILITY(U,$J,358.3,22713,2)
 ;;=^5010798
 ;;^UTILITY(U,$J,358.3,22714,0)
 ;;=M19.011^^89^1052^135
 ;;^UTILITY(U,$J,358.3,22714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22714,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,22714,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,22714,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,22715,0)
 ;;=M19.012^^89^1052^129
 ;;^UTILITY(U,$J,358.3,22715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22715,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,22715,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,22715,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,22716,0)
 ;;=M19.031^^89^1052^136
 ;;^UTILITY(U,$J,358.3,22716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22716,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,22716,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,22716,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,22717,0)
 ;;=M19.032^^89^1052^130
 ;;^UTILITY(U,$J,358.3,22717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22717,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,22717,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,22717,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,22718,0)
 ;;=M19.041^^89^1052^131
 ;;^UTILITY(U,$J,358.3,22718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22718,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,22718,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,22718,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,22719,0)
 ;;=M19.042^^89^1052^125
 ;;^UTILITY(U,$J,358.3,22719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22719,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,22719,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,22719,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,22720,0)
 ;;=M19.90^^89^1052^68
 ;;^UTILITY(U,$J,358.3,22720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22720,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,22720,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,22720,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,22721,0)
 ;;=M25.40^^89^1052^37
 ;;^UTILITY(U,$J,358.3,22721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22721,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,22721,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,22721,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,22722,0)
 ;;=M45.0^^89^1052^6
 ;;^UTILITY(U,$J,358.3,22722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22722,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,22722,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,22722,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,22723,0)
 ;;=M45.2^^89^1052^3
 ;;^UTILITY(U,$J,358.3,22723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22723,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
