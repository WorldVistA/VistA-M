IBDEI02F ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2699,0)
 ;;=M75.111^^14^192^161
 ;;^UTILITY(U,$J,358.3,2699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2699,1,3,0)
 ;;=3^Rotator Cuff Syndrome,Right Shoulder
 ;;^UTILITY(U,$J,358.3,2699,1,4,0)
 ;;=4^M75.111
 ;;^UTILITY(U,$J,358.3,2699,2)
 ;;=^5013245
 ;;^UTILITY(U,$J,358.3,2700,0)
 ;;=M75.112^^14^192^160
 ;;^UTILITY(U,$J,358.3,2700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2700,1,3,0)
 ;;=3^Rotator Cuff Syndrome,Left Shoulder
 ;;^UTILITY(U,$J,358.3,2700,1,4,0)
 ;;=4^M75.112
 ;;^UTILITY(U,$J,358.3,2700,2)
 ;;=^5013246
 ;;^UTILITY(U,$J,358.3,2701,0)
 ;;=M75.51^^14^192^10
 ;;^UTILITY(U,$J,358.3,2701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2701,1,3,0)
 ;;=3^Bursitis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,2701,1,4,0)
 ;;=4^M75.51
 ;;^UTILITY(U,$J,358.3,2701,2)
 ;;=^5133690
 ;;^UTILITY(U,$J,358.3,2702,0)
 ;;=M75.52^^14^192^9
 ;;^UTILITY(U,$J,358.3,2702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2702,1,3,0)
 ;;=3^Bursitis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,2702,1,4,0)
 ;;=4^M75.52
 ;;^UTILITY(U,$J,358.3,2702,2)
 ;;=^5133691
 ;;^UTILITY(U,$J,358.3,2703,0)
 ;;=M77.11^^14^192^54
 ;;^UTILITY(U,$J,358.3,2703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2703,1,3,0)
 ;;=3^Lateral Epicondylitis,Right Elbow
 ;;^UTILITY(U,$J,358.3,2703,1,4,0)
 ;;=4^M77.11
 ;;^UTILITY(U,$J,358.3,2703,2)
 ;;=^5013304
 ;;^UTILITY(U,$J,358.3,2704,0)
 ;;=M77.12^^14^192^53
 ;;^UTILITY(U,$J,358.3,2704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2704,1,3,0)
 ;;=3^Lateral Epicondylitis,Left Elbow
 ;;^UTILITY(U,$J,358.3,2704,1,4,0)
 ;;=4^M77.12
 ;;^UTILITY(U,$J,358.3,2704,2)
 ;;=^5013305
 ;;^UTILITY(U,$J,358.3,2705,0)
 ;;=M79.1^^14^192^61
 ;;^UTILITY(U,$J,358.3,2705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2705,1,3,0)
 ;;=3^Myalgia
 ;;^UTILITY(U,$J,358.3,2705,1,4,0)
 ;;=4^M79.1
 ;;^UTILITY(U,$J,358.3,2705,2)
 ;;=^5013321
 ;;^UTILITY(U,$J,358.3,2706,0)
 ;;=M79.7^^14^192^39
 ;;^UTILITY(U,$J,358.3,2706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2706,1,3,0)
 ;;=3^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,2706,1,4,0)
 ;;=4^M79.7
 ;;^UTILITY(U,$J,358.3,2706,2)
 ;;=^46261
 ;;^UTILITY(U,$J,358.3,2707,0)
 ;;=M80.08XA^^14^192^1
 ;;^UTILITY(U,$J,358.3,2707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2707,1,3,0)
 ;;=3^Age-Related Osteoporosis w/ Vertebra Fx,Init Encntr
 ;;^UTILITY(U,$J,358.3,2707,1,4,0)
 ;;=4^M80.08XA
 ;;^UTILITY(U,$J,358.3,2707,2)
 ;;=^5013495
 ;;^UTILITY(U,$J,358.3,2708,0)
 ;;=M80.08XD^^14^192^2
 ;;^UTILITY(U,$J,358.3,2708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2708,1,3,0)
 ;;=3^Age-Related Osteoporosis w/ Vertebra Fx,Subs Encntr
 ;;^UTILITY(U,$J,358.3,2708,1,4,0)
 ;;=4^M80.08XD
 ;;^UTILITY(U,$J,358.3,2708,2)
 ;;=^5013496
 ;;^UTILITY(U,$J,358.3,2709,0)
 ;;=M84.48XA^^14^192^118
 ;;^UTILITY(U,$J,358.3,2709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2709,1,3,0)
 ;;=3^Pathological Fx,Oth Site,Init Encntr
 ;;^UTILITY(U,$J,358.3,2709,1,4,0)
 ;;=4^M84.48XA
 ;;^UTILITY(U,$J,358.3,2709,2)
 ;;=^5014016
 ;;^UTILITY(U,$J,358.3,2710,0)
 ;;=M84.48XD^^14^192^119
 ;;^UTILITY(U,$J,358.3,2710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2710,1,3,0)
 ;;=3^Pathological Fx,Oth Site,Subs Encntr
 ;;^UTILITY(U,$J,358.3,2710,1,4,0)
 ;;=4^M84.48XD
 ;;^UTILITY(U,$J,358.3,2710,2)
 ;;=^5014017
 ;;^UTILITY(U,$J,358.3,2711,0)
 ;;=M87.011^^14^192^45
 ;;^UTILITY(U,$J,358.3,2711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2711,1,3,0)
 ;;=3^Idiopathic Aseptic Necrosis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,2711,1,4,0)
 ;;=4^M87.011
 ;;^UTILITY(U,$J,358.3,2711,2)
 ;;=^5014658
 ;;^UTILITY(U,$J,358.3,2712,0)
 ;;=M87.012^^14^192^42
 ;;^UTILITY(U,$J,358.3,2712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2712,1,3,0)
 ;;=3^Idiopathic Aseptic Necrosis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,2712,1,4,0)
 ;;=4^M87.012
 ;;^UTILITY(U,$J,358.3,2712,2)
 ;;=^5014659
 ;;^UTILITY(U,$J,358.3,2713,0)
 ;;=M87.050^^14^192^43
 ;;^UTILITY(U,$J,358.3,2713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2713,1,3,0)
 ;;=3^Idiopathic Aseptic Necrosis of Pelvis
 ;;^UTILITY(U,$J,358.3,2713,1,4,0)
 ;;=4^M87.050
 ;;^UTILITY(U,$J,358.3,2713,2)
 ;;=^5014679
 ;;^UTILITY(U,$J,358.3,2714,0)
 ;;=M87.051^^14^192^44
 ;;^UTILITY(U,$J,358.3,2714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2714,1,3,0)
 ;;=3^Idiopathic Aseptic Necrosis of Right Femur
 ;;^UTILITY(U,$J,358.3,2714,1,4,0)
 ;;=4^M87.051
 ;;^UTILITY(U,$J,358.3,2714,2)
 ;;=^5014680
 ;;^UTILITY(U,$J,358.3,2715,0)
 ;;=M87.052^^14^192^41
 ;;^UTILITY(U,$J,358.3,2715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2715,1,3,0)
 ;;=3^Idiopathic Aseptic Necrosis of Left Femur
 ;;^UTILITY(U,$J,358.3,2715,1,4,0)
 ;;=4^M87.052
 ;;^UTILITY(U,$J,358.3,2715,2)
 ;;=^5014681
 ;;^UTILITY(U,$J,358.3,2716,0)
 ;;=M87.111^^14^192^74
 ;;^UTILITY(U,$J,358.3,2716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2716,1,3,0)
 ;;=3^Osteonecrosis d/t Drugs,Right Shoulder
 ;;^UTILITY(U,$J,358.3,2716,1,4,0)
 ;;=4^M87.111
 ;;^UTILITY(U,$J,358.3,2716,2)
 ;;=^5014701
 ;;^UTILITY(U,$J,358.3,2717,0)
 ;;=M87.112^^14^192^71
 ;;^UTILITY(U,$J,358.3,2717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2717,1,3,0)
 ;;=3^Osteonecrosis d/t Drugs,Left Shoulder
 ;;^UTILITY(U,$J,358.3,2717,1,4,0)
 ;;=4^M87.112
 ;;^UTILITY(U,$J,358.3,2717,2)
 ;;=^5014702
 ;;^UTILITY(U,$J,358.3,2718,0)
 ;;=M87.150^^14^192^72
 ;;^UTILITY(U,$J,358.3,2718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2718,1,3,0)
 ;;=3^Osteonecrosis d/t Drugs,Pelvis
 ;;^UTILITY(U,$J,358.3,2718,1,4,0)
 ;;=4^M87.150
 ;;^UTILITY(U,$J,358.3,2718,2)
 ;;=^5014722
 ;;^UTILITY(U,$J,358.3,2719,0)
 ;;=M87.151^^14^192^73
 ;;^UTILITY(U,$J,358.3,2719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2719,1,3,0)
 ;;=3^Osteonecrosis d/t Drugs,Right Femur
 ;;^UTILITY(U,$J,358.3,2719,1,4,0)
 ;;=4^M87.151
 ;;^UTILITY(U,$J,358.3,2719,2)
 ;;=^5014723
 ;;^UTILITY(U,$J,358.3,2720,0)
 ;;=M87.152^^14^192^70
 ;;^UTILITY(U,$J,358.3,2720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2720,1,3,0)
 ;;=3^Osteonecrosis d/t Drugs,Left Femur
 ;;^UTILITY(U,$J,358.3,2720,1,4,0)
 ;;=4^M87.152
 ;;^UTILITY(U,$J,358.3,2720,2)
 ;;=^5014724
 ;;^UTILITY(U,$J,358.3,2721,0)
 ;;=M87.180^^14^192^69
 ;;^UTILITY(U,$J,358.3,2721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2721,1,3,0)
 ;;=3^Osteonecrosis d/t Drugs,Jaw
 ;;^UTILITY(U,$J,358.3,2721,1,4,0)
 ;;=4^M87.180
 ;;^UTILITY(U,$J,358.3,2721,2)
 ;;=^5014741
 ;;^UTILITY(U,$J,358.3,2722,0)
 ;;=M87.311^^14^192^168
 ;;^UTILITY(U,$J,358.3,2722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2722,1,3,0)
 ;;=3^Secondary Osteonecrosis,Right Shoulder
 ;;^UTILITY(U,$J,358.3,2722,1,4,0)
 ;;=4^M87.311
 ;;^UTILITY(U,$J,358.3,2722,2)
 ;;=^5014788
 ;;^UTILITY(U,$J,358.3,2723,0)
 ;;=M87.312^^14^192^165
 ;;^UTILITY(U,$J,358.3,2723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2723,1,3,0)
 ;;=3^Secondary Osteonecrosis,Left Shoulder
 ;;^UTILITY(U,$J,358.3,2723,1,4,0)
 ;;=4^M87.312
 ;;^UTILITY(U,$J,358.3,2723,2)
 ;;=^5014789
 ;;^UTILITY(U,$J,358.3,2724,0)
 ;;=M87.350^^14^192^166
 ;;^UTILITY(U,$J,358.3,2724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2724,1,3,0)
 ;;=3^Secondary Osteonecrosis,Pelvis
 ;;^UTILITY(U,$J,358.3,2724,1,4,0)
 ;;=4^M87.350
 ;;^UTILITY(U,$J,358.3,2724,2)
 ;;=^5014809
 ;;^UTILITY(U,$J,358.3,2725,0)
 ;;=M87.351^^14^192^167
 ;;^UTILITY(U,$J,358.3,2725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2725,1,3,0)
 ;;=3^Secondary Osteonecrosis,Right Femur
 ;;^UTILITY(U,$J,358.3,2725,1,4,0)
 ;;=4^M87.351
 ;;^UTILITY(U,$J,358.3,2725,2)
 ;;=^5014810
 ;;^UTILITY(U,$J,358.3,2726,0)
 ;;=M87.352^^14^192^164
 ;;^UTILITY(U,$J,358.3,2726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2726,1,3,0)
 ;;=3^Secondary Osteonecrosis,Left Femur
 ;;^UTILITY(U,$J,358.3,2726,1,4,0)
 ;;=4^M87.352
 ;;^UTILITY(U,$J,358.3,2726,2)
 ;;=^5014811
 ;;^UTILITY(U,$J,358.3,2727,0)
 ;;=M87.811^^14^192^79
 ;;^UTILITY(U,$J,358.3,2727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2727,1,3,0)
 ;;=3^Osteonecrosis,Right Shoulder
 ;;^UTILITY(U,$J,358.3,2727,1,4,0)
 ;;=4^M87.811
 ;;^UTILITY(U,$J,358.3,2727,2)
 ;;=^5014831
 ;;^UTILITY(U,$J,358.3,2728,0)
 ;;=M87.812^^14^192^76
 ;;^UTILITY(U,$J,358.3,2728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2728,1,3,0)
 ;;=3^Osteonecrosis,Left Shoulder
 ;;^UTILITY(U,$J,358.3,2728,1,4,0)
 ;;=4^M87.812
 ;;^UTILITY(U,$J,358.3,2728,2)
 ;;=^5014832
 ;;^UTILITY(U,$J,358.3,2729,0)
 ;;=M87.850^^14^192^77
 ;;^UTILITY(U,$J,358.3,2729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2729,1,3,0)
 ;;=3^Osteonecrosis,Pelvis
 ;;^UTILITY(U,$J,358.3,2729,1,4,0)
 ;;=4^M87.850
 ;;^UTILITY(U,$J,358.3,2729,2)
 ;;=^5014852
 ;;^UTILITY(U,$J,358.3,2730,0)
 ;;=M87.851^^14^192^78
 ;;^UTILITY(U,$J,358.3,2730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2730,1,3,0)
 ;;=3^Osteonecrosis,Right Femur
 ;;^UTILITY(U,$J,358.3,2730,1,4,0)
 ;;=4^M87.851
 ;;^UTILITY(U,$J,358.3,2730,2)
 ;;=^5014853
 ;;^UTILITY(U,$J,358.3,2731,0)
 ;;=M87.852^^14^192^75
 ;;^UTILITY(U,$J,358.3,2731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2731,1,3,0)
 ;;=3^Osteonecrosis,Left Femur
 ;;^UTILITY(U,$J,358.3,2731,1,4,0)
 ;;=4^M87.852
 ;;^UTILITY(U,$J,358.3,2731,2)
 ;;=^5014854
 ;;^UTILITY(U,$J,358.3,2732,0)
 ;;=M88.0^^14^192^66
 ;;^UTILITY(U,$J,358.3,2732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2732,1,3,0)
 ;;=3^Osteitis Deformans of Skull
 ;;^UTILITY(U,$J,358.3,2732,1,4,0)
 ;;=4^M88.0
 ;;^UTILITY(U,$J,358.3,2732,2)
 ;;=^5014874
 ;;^UTILITY(U,$J,358.3,2733,0)
 ;;=M88.1^^14^192^67
 ;;^UTILITY(U,$J,358.3,2733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2733,1,3,0)
 ;;=3^Osteitis Deformans of Vertebrae
 ;;^UTILITY(U,$J,358.3,2733,1,4,0)
 ;;=4^M88.1
 ;;^UTILITY(U,$J,358.3,2733,2)
 ;;=^5014875
 ;;^UTILITY(U,$J,358.3,2734,0)
 ;;=M88.89^^14^192^65
 ;;^UTILITY(U,$J,358.3,2734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2734,1,3,0)
 ;;=3^Osteitis Deformans of Mult Sites
 ;;^UTILITY(U,$J,358.3,2734,1,4,0)
 ;;=4^M88.89
 ;;^UTILITY(U,$J,358.3,2734,2)
 ;;=^5014898
