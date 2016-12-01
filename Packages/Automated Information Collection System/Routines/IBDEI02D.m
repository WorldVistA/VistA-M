IBDEI02D ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2627,2)
 ;;=^5010008
 ;;^UTILITY(U,$J,358.3,2628,0)
 ;;=M05.741^^14^192^150
 ;;^UTILITY(U,$J,358.3,2628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2628,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,2628,1,4,0)
 ;;=4^M05.741
 ;;^UTILITY(U,$J,358.3,2628,2)
 ;;=^5010010
 ;;^UTILITY(U,$J,358.3,2629,0)
 ;;=M05.742^^14^192^143
 ;;^UTILITY(U,$J,358.3,2629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2629,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,2629,1,4,0)
 ;;=4^M05.742
 ;;^UTILITY(U,$J,358.3,2629,2)
 ;;=^5010011
 ;;^UTILITY(U,$J,358.3,2630,0)
 ;;=M05.751^^14^192^151
 ;;^UTILITY(U,$J,358.3,2630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2630,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,2630,1,4,0)
 ;;=4^M05.751
 ;;^UTILITY(U,$J,358.3,2630,2)
 ;;=^5010013
 ;;^UTILITY(U,$J,358.3,2631,0)
 ;;=M05.752^^14^192^144
 ;;^UTILITY(U,$J,358.3,2631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2631,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,2631,1,4,0)
 ;;=4^M05.752
 ;;^UTILITY(U,$J,358.3,2631,2)
 ;;=^5010014
 ;;^UTILITY(U,$J,358.3,2632,0)
 ;;=M05.761^^14^192^152
 ;;^UTILITY(U,$J,358.3,2632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2632,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,2632,1,4,0)
 ;;=4^M05.761
 ;;^UTILITY(U,$J,358.3,2632,2)
 ;;=^5010016
 ;;^UTILITY(U,$J,358.3,2633,0)
 ;;=M05.762^^14^192^145
 ;;^UTILITY(U,$J,358.3,2633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2633,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,2633,1,4,0)
 ;;=4^M05.762
 ;;^UTILITY(U,$J,358.3,2633,2)
 ;;=^5010017
 ;;^UTILITY(U,$J,358.3,2634,0)
 ;;=M05.771^^14^192^149
 ;;^UTILITY(U,$J,358.3,2634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2634,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Ankle
 ;;^UTILITY(U,$J,358.3,2634,1,4,0)
 ;;=4^M05.771
 ;;^UTILITY(U,$J,358.3,2634,2)
 ;;=^5010019
 ;;^UTILITY(U,$J,358.3,2635,0)
 ;;=M05.772^^14^192^142
 ;;^UTILITY(U,$J,358.3,2635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2635,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Ankle
 ;;^UTILITY(U,$J,358.3,2635,1,4,0)
 ;;=4^M05.772
 ;;^UTILITY(U,$J,358.3,2635,2)
 ;;=^5010020
 ;;^UTILITY(U,$J,358.3,2636,0)
 ;;=M05.79^^14^192^148
 ;;^UTILITY(U,$J,358.3,2636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2636,1,3,0)
 ;;=3^Rheumatoid Arthritis of Multiple Sites
 ;;^UTILITY(U,$J,358.3,2636,1,4,0)
 ;;=4^M05.79
 ;;^UTILITY(U,$J,358.3,2636,2)
 ;;=^5010022
 ;;^UTILITY(U,$J,358.3,2637,0)
 ;;=M06.00^^14^192^155
 ;;^UTILITY(U,$J,358.3,2637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2637,1,3,0)
 ;;=3^Rheumatoid Arthritis w/o Rhematoid Factor,Unspec Site
 ;;^UTILITY(U,$J,358.3,2637,1,4,0)
 ;;=4^M06.00
 ;;^UTILITY(U,$J,358.3,2637,2)
 ;;=^5010047
 ;;^UTILITY(U,$J,358.3,2638,0)
 ;;=M06.30^^14^192^158
 ;;^UTILITY(U,$J,358.3,2638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2638,1,3,0)
 ;;=3^Rheumatoid Nodule,Unspec Site
 ;;^UTILITY(U,$J,358.3,2638,1,4,0)
 ;;=4^M06.30
 ;;^UTILITY(U,$J,358.3,2638,2)
 ;;=^5010096
 ;;^UTILITY(U,$J,358.3,2639,0)
 ;;=M06.4^^14^192^48
 ;;^UTILITY(U,$J,358.3,2639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2639,1,3,0)
 ;;=3^Inflammatory Polyarthropathy
 ;;^UTILITY(U,$J,358.3,2639,1,4,0)
 ;;=4^M06.4
 ;;^UTILITY(U,$J,358.3,2639,2)
 ;;=^5010120
 ;;^UTILITY(U,$J,358.3,2640,0)
 ;;=M06.39^^14^192^157
 ;;^UTILITY(U,$J,358.3,2640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2640,1,3,0)
 ;;=3^Rheumatoid Nodule,Mult Sites
 ;;^UTILITY(U,$J,358.3,2640,1,4,0)
 ;;=4^M06.39
 ;;^UTILITY(U,$J,358.3,2640,2)
 ;;=^5010119
 ;;^UTILITY(U,$J,358.3,2641,0)
 ;;=M15.0^^14^192^121
 ;;^UTILITY(U,$J,358.3,2641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2641,1,3,0)
 ;;=3^Primary Generalized Osteoarthritis
 ;;^UTILITY(U,$J,358.3,2641,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,2641,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,2642,0)
 ;;=M06.9^^14^192^156
 ;;^UTILITY(U,$J,358.3,2642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2642,1,3,0)
 ;;=3^Rheumatoid Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,2642,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,2642,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,2643,0)
 ;;=M16.0^^14^192^124
 ;;^UTILITY(U,$J,358.3,2643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2643,1,3,0)
 ;;=3^Primary Osteoarthritis of Hip,Bilateral
 ;;^UTILITY(U,$J,358.3,2643,1,4,0)
 ;;=4^M16.0
 ;;^UTILITY(U,$J,358.3,2643,2)
 ;;=^5010769
 ;;^UTILITY(U,$J,358.3,2644,0)
 ;;=M16.11^^14^192^133
 ;;^UTILITY(U,$J,358.3,2644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2644,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,2644,1,4,0)
 ;;=4^M16.11
 ;;^UTILITY(U,$J,358.3,2644,2)
 ;;=^5010771
 ;;^UTILITY(U,$J,358.3,2645,0)
 ;;=M16.12^^14^192^127
 ;;^UTILITY(U,$J,358.3,2645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2645,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,2645,1,4,0)
 ;;=4^M16.12
 ;;^UTILITY(U,$J,358.3,2645,2)
 ;;=^5010772
 ;;^UTILITY(U,$J,358.3,2646,0)
 ;;=M17.0^^14^192^123
 ;;^UTILITY(U,$J,358.3,2646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2646,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral Knees
 ;;^UTILITY(U,$J,358.3,2646,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,2646,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,2647,0)
 ;;=M17.11^^14^192^134
 ;;^UTILITY(U,$J,358.3,2647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2647,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,2647,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,2647,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,2648,0)
 ;;=M17.12^^14^192^128
 ;;^UTILITY(U,$J,358.3,2648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2648,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,2648,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,2648,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,2649,0)
 ;;=M18.0^^14^192^122
 ;;^UTILITY(U,$J,358.3,2649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2649,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral 1st Carpometacarp Jts
 ;;^UTILITY(U,$J,358.3,2649,1,4,0)
 ;;=4^M18.0
 ;;^UTILITY(U,$J,358.3,2649,2)
 ;;=^5010795
 ;;^UTILITY(U,$J,358.3,2650,0)
 ;;=M18.11^^14^192^132
 ;;^UTILITY(U,$J,358.3,2650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2650,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,2650,1,4,0)
 ;;=4^M18.11
 ;;^UTILITY(U,$J,358.3,2650,2)
 ;;=^5010797
 ;;^UTILITY(U,$J,358.3,2651,0)
 ;;=M18.12^^14^192^126
 ;;^UTILITY(U,$J,358.3,2651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2651,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,2651,1,4,0)
 ;;=4^M18.12
 ;;^UTILITY(U,$J,358.3,2651,2)
 ;;=^5010798
 ;;^UTILITY(U,$J,358.3,2652,0)
 ;;=M19.011^^14^192^135
 ;;^UTILITY(U,$J,358.3,2652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2652,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,2652,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,2652,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,2653,0)
 ;;=M19.012^^14^192^129
 ;;^UTILITY(U,$J,358.3,2653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2653,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,2653,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,2653,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,2654,0)
 ;;=M19.031^^14^192^136
 ;;^UTILITY(U,$J,358.3,2654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2654,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,2654,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,2654,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,2655,0)
 ;;=M19.032^^14^192^130
 ;;^UTILITY(U,$J,358.3,2655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2655,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,2655,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,2655,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,2656,0)
 ;;=M19.041^^14^192^131
 ;;^UTILITY(U,$J,358.3,2656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2656,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,2656,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,2656,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,2657,0)
 ;;=M19.042^^14^192^125
 ;;^UTILITY(U,$J,358.3,2657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2657,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,2657,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,2657,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,2658,0)
 ;;=M19.90^^14^192^68
 ;;^UTILITY(U,$J,358.3,2658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2658,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,2658,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,2658,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,2659,0)
 ;;=M25.40^^14^192^37
 ;;^UTILITY(U,$J,358.3,2659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2659,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,2659,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,2659,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,2660,0)
 ;;=M45.0^^14^192^6
 ;;^UTILITY(U,$J,358.3,2660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2660,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,2660,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,2660,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,2661,0)
 ;;=M45.2^^14^192^3
 ;;^UTILITY(U,$J,358.3,2661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2661,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,2661,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,2661,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,2662,0)
 ;;=M45.4^^14^192^7
 ;;^UTILITY(U,$J,358.3,2662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2662,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,2662,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,2662,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,2663,0)
 ;;=M45.7^^14^192^4
 ;;^UTILITY(U,$J,358.3,2663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2663,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
