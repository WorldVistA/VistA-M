IBDEI02C ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2719,2)
 ;;=^5011687
 ;;^UTILITY(U,$J,358.3,2720,0)
 ;;=M25.862^^12^106^26
 ;;^UTILITY(U,$J,358.3,2720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2720,1,3,0)
 ;;=3^Joint disorders, lft knee, oth, spec
 ;;^UTILITY(U,$J,358.3,2720,1,4,0)
 ;;=4^M25.862
 ;;^UTILITY(U,$J,358.3,2720,2)
 ;;=^5011688
 ;;^UTILITY(U,$J,358.3,2721,0)
 ;;=M25.871^^12^106^29
 ;;^UTILITY(U,$J,358.3,2721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2721,1,3,0)
 ;;=3^Joint disorders, rt ankle & foot, oth, spec
 ;;^UTILITY(U,$J,358.3,2721,1,4,0)
 ;;=4^M25.871
 ;;^UTILITY(U,$J,358.3,2721,2)
 ;;=^5011690
 ;;^UTILITY(U,$J,358.3,2722,0)
 ;;=M25.872^^12^106^22
 ;;^UTILITY(U,$J,358.3,2722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2722,1,3,0)
 ;;=3^Joint disorders, lft ankle & foot, oth, spec
 ;;^UTILITY(U,$J,358.3,2722,1,4,0)
 ;;=4^M25.872
 ;;^UTILITY(U,$J,358.3,2722,2)
 ;;=^5011691
 ;;^UTILITY(U,$J,358.3,2723,0)
 ;;=M79.641^^12^106^45
 ;;^UTILITY(U,$J,358.3,2723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2723,1,3,0)
 ;;=3^Pain in rt hand
 ;;^UTILITY(U,$J,358.3,2723,1,4,0)
 ;;=4^M79.641
 ;;^UTILITY(U,$J,358.3,2723,2)
 ;;=^5013338
 ;;^UTILITY(U,$J,358.3,2724,0)
 ;;=M79.642^^12^106^39
 ;;^UTILITY(U,$J,358.3,2724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2724,1,3,0)
 ;;=3^Pain in lft hand
 ;;^UTILITY(U,$J,358.3,2724,1,4,0)
 ;;=4^M79.642
 ;;^UTILITY(U,$J,358.3,2724,2)
 ;;=^5013339
 ;;^UTILITY(U,$J,358.3,2725,0)
 ;;=M25.9^^12^106^20
 ;;^UTILITY(U,$J,358.3,2725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2725,1,3,0)
 ;;=3^Joint disorder, unspec
 ;;^UTILITY(U,$J,358.3,2725,1,4,0)
 ;;=4^M25.9
 ;;^UTILITY(U,$J,358.3,2725,2)
 ;;=^5011693
 ;;^UTILITY(U,$J,358.3,2726,0)
 ;;=D84.1^^12^107^3
 ;;^UTILITY(U,$J,358.3,2726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2726,1,3,0)
 ;;=3^Defects in the complement system
 ;;^UTILITY(U,$J,358.3,2726,1,4,0)
 ;;=4^D84.1
 ;;^UTILITY(U,$J,358.3,2726,2)
 ;;=^5002439
 ;;^UTILITY(U,$J,358.3,2727,0)
 ;;=G95.9^^12^107^8
 ;;^UTILITY(U,$J,358.3,2727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2727,1,3,0)
 ;;=3^Disease of spinal cord, unspec
 ;;^UTILITY(U,$J,358.3,2727,1,4,0)
 ;;=4^G95.9
 ;;^UTILITY(U,$J,358.3,2727,2)
 ;;=^5004194
 ;;^UTILITY(U,$J,358.3,2728,0)
 ;;=H16.321^^12^107^7
 ;;^UTILITY(U,$J,358.3,2728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2728,1,3,0)
 ;;=3^Diffuse interstitial keratitis, rt eye
 ;;^UTILITY(U,$J,358.3,2728,1,4,0)
 ;;=4^H16.321
 ;;^UTILITY(U,$J,358.3,2728,2)
 ;;=^5004953
 ;;^UTILITY(U,$J,358.3,2729,0)
 ;;=H16.322^^12^107^6
 ;;^UTILITY(U,$J,358.3,2729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2729,1,3,0)
 ;;=3^Diffuse interstitial keratitis, lft eye
 ;;^UTILITY(U,$J,358.3,2729,1,4,0)
 ;;=4^H16.322
 ;;^UTILITY(U,$J,358.3,2729,2)
 ;;=^5004954
 ;;^UTILITY(U,$J,358.3,2730,0)
 ;;=H16.323^^12^107^5
 ;;^UTILITY(U,$J,358.3,2730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2730,1,3,0)
 ;;=3^Diffuse interstitial keratitis, bilat
 ;;^UTILITY(U,$J,358.3,2730,1,4,0)
 ;;=4^H16.323
 ;;^UTILITY(U,$J,358.3,2730,2)
 ;;=^5004955
 ;;^UTILITY(U,$J,358.3,2731,0)
 ;;=N28.9^^12^107^9
 ;;^UTILITY(U,$J,358.3,2731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2731,1,3,0)
 ;;=3^Disorder of kidney & ureter, unspec
 ;;^UTILITY(U,$J,358.3,2731,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,2731,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,2732,0)
 ;;=M15.1^^12^107^13
 ;;^UTILITY(U,$J,358.3,2732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2732,1,3,0)
 ;;=3^Heberden's nodes (w/ arthropathy)
 ;;^UTILITY(U,$J,358.3,2732,1,4,0)
 ;;=4^M15.1
 ;;^UTILITY(U,$J,358.3,2732,2)
 ;;=^5010763
 ;;^UTILITY(U,$J,358.3,2733,0)
 ;;=R26.2^^12^107^4
 ;;^UTILITY(U,$J,358.3,2733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2733,1,3,0)
 ;;=3^Difficulty in walking, NEC
 ;;^UTILITY(U,$J,358.3,2733,1,4,0)
 ;;=4^R26.2
 ;;^UTILITY(U,$J,358.3,2733,2)
 ;;=^5019306
 ;;^UTILITY(U,$J,358.3,2734,0)
 ;;=M15.2^^12^107^2
 ;;^UTILITY(U,$J,358.3,2734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2734,1,3,0)
 ;;=3^Bouchard's nodes (w/ arthropathy)
 ;;^UTILITY(U,$J,358.3,2734,1,4,0)
 ;;=4^M15.2
 ;;^UTILITY(U,$J,358.3,2734,2)
 ;;=^5010764
 ;;^UTILITY(U,$J,358.3,2735,0)
 ;;=M87.00^^12^107^14
 ;;^UTILITY(U,$J,358.3,2735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2735,1,3,0)
 ;;=3^Idiopth aseptic necr of unspec bone
 ;;^UTILITY(U,$J,358.3,2735,1,4,0)
 ;;=4^M87.00
 ;;^UTILITY(U,$J,358.3,2735,2)
 ;;=^5014657
 ;;^UTILITY(U,$J,358.3,2736,0)
 ;;=R53.81^^12^107^15
 ;;^UTILITY(U,$J,358.3,2736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2736,1,3,0)
 ;;=3^Malaise, oth
 ;;^UTILITY(U,$J,358.3,2736,1,4,0)
 ;;=4^R53.81
 ;;^UTILITY(U,$J,358.3,2736,2)
 ;;=^5019518
 ;;^UTILITY(U,$J,358.3,2737,0)
 ;;=R53.83^^12^107^11
 ;;^UTILITY(U,$J,358.3,2737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2737,1,3,0)
 ;;=3^Fatigue, oth
 ;;^UTILITY(U,$J,358.3,2737,1,4,0)
 ;;=4^R53.83
 ;;^UTILITY(U,$J,358.3,2737,2)
 ;;=^5019520
 ;;^UTILITY(U,$J,358.3,2738,0)
 ;;=R51.^^12^107^12
 ;;^UTILITY(U,$J,358.3,2738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2738,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,2738,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,2738,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,2739,0)
 ;;=T50.905A^^12^107^1
 ;;^UTILITY(U,$J,358.3,2739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2739,1,3,0)
 ;;=3^Advrs effect of unsp drug/meds/biol subst, init
 ;;^UTILITY(U,$J,358.3,2739,1,4,0)
 ;;=4^T50.905A
 ;;^UTILITY(U,$J,358.3,2739,2)
 ;;=^5052160
 ;;^UTILITY(U,$J,358.3,2740,0)
 ;;=Z09.^^12^107^10
 ;;^UTILITY(U,$J,358.3,2740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2740,1,3,0)
 ;;=3^Encntr for f/u exam aft trtmt for cond oth than malig neoplm
 ;;^UTILITY(U,$J,358.3,2740,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,2740,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,2741,0)
 ;;=G95.89^^12^108^1
 ;;^UTILITY(U,$J,358.3,2741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2741,1,3,0)
 ;;=3^Diseases of spinal cord, oth, spec
 ;;^UTILITY(U,$J,358.3,2741,1,4,0)
 ;;=4^G95.89
 ;;^UTILITY(U,$J,358.3,2741,2)
 ;;=^5004193
 ;;^UTILITY(U,$J,358.3,2742,0)
 ;;=M15.0^^12^109^2
 ;;^UTILITY(U,$J,358.3,2742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2742,1,3,0)
 ;;=3^Prim generalized (osteo)arthritis
 ;;^UTILITY(U,$J,358.3,2742,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,2742,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,2743,0)
 ;;=M19.91^^12^109^17
 ;;^UTILITY(U,$J,358.3,2743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2743,1,3,0)
 ;;=3^Prim osteoarthritis, unspec site
 ;;^UTILITY(U,$J,358.3,2743,1,4,0)
 ;;=4^M19.91
 ;;^UTILITY(U,$J,358.3,2743,2)
 ;;=^5010854
 ;;^UTILITY(U,$J,358.3,2744,0)
 ;;=M19.011^^12^109^15
 ;;^UTILITY(U,$J,358.3,2744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2744,1,3,0)
 ;;=3^Prim osteoarthritis, rt shldr
 ;;^UTILITY(U,$J,358.3,2744,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,2744,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,2745,0)
 ;;=M19.012^^12^109^8
 ;;^UTILITY(U,$J,358.3,2745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2745,1,3,0)
 ;;=3^Prim osteoarthritis, lft shldr
 ;;^UTILITY(U,$J,358.3,2745,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,2745,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,2746,0)
 ;;=M19.021^^12^109^11
 ;;^UTILITY(U,$J,358.3,2746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2746,1,3,0)
 ;;=3^Prim osteoarthritis, rt elbow
 ;;^UTILITY(U,$J,358.3,2746,1,4,0)
 ;;=4^M19.021
 ;;^UTILITY(U,$J,358.3,2746,2)
 ;;=^5010811
 ;;^UTILITY(U,$J,358.3,2747,0)
 ;;=M19.022^^12^109^4
 ;;^UTILITY(U,$J,358.3,2747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2747,1,3,0)
 ;;=3^Prim osteoarthritis, lft elbow
 ;;^UTILITY(U,$J,358.3,2747,1,4,0)
 ;;=4^M19.022
 ;;^UTILITY(U,$J,358.3,2747,2)
 ;;=^5010812
 ;;^UTILITY(U,$J,358.3,2748,0)
 ;;=M19.031^^12^109^16
 ;;^UTILITY(U,$J,358.3,2748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2748,1,3,0)
 ;;=3^Prim osteoarthritis, rt wrist
 ;;^UTILITY(U,$J,358.3,2748,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,2748,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,2749,0)
 ;;=M19.032^^12^109^9
 ;;^UTILITY(U,$J,358.3,2749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2749,1,3,0)
 ;;=3^Prim osteoarthritis, lft wrist
 ;;^UTILITY(U,$J,358.3,2749,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,2749,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,2750,0)
 ;;=M19.041^^12^109^12
 ;;^UTILITY(U,$J,358.3,2750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2750,1,3,0)
 ;;=3^Prim osteoarthritis, rt hand
 ;;^UTILITY(U,$J,358.3,2750,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,2750,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,2751,0)
 ;;=M19.042^^12^109^5
 ;;^UTILITY(U,$J,358.3,2751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2751,1,3,0)
 ;;=3^Prim osteoarthritis, lft hand
 ;;^UTILITY(U,$J,358.3,2751,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,2751,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,2752,0)
 ;;=M19.071^^12^109^10
 ;;^UTILITY(U,$J,358.3,2752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2752,1,3,0)
 ;;=3^Prim osteoarthritis, rt ankle & foot
 ;;^UTILITY(U,$J,358.3,2752,1,4,0)
 ;;=4^M19.071
 ;;^UTILITY(U,$J,358.3,2752,2)
 ;;=^5010820
 ;;^UTILITY(U,$J,358.3,2753,0)
 ;;=M19.072^^12^109^3
 ;;^UTILITY(U,$J,358.3,2753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2753,1,3,0)
 ;;=3^Prim osteoarthritis, lft ankle & foot
 ;;^UTILITY(U,$J,358.3,2753,1,4,0)
 ;;=4^M19.072
 ;;^UTILITY(U,$J,358.3,2753,2)
 ;;=^5010821
 ;;^UTILITY(U,$J,358.3,2754,0)
 ;;=M19.93^^12^109^32
 ;;^UTILITY(U,$J,358.3,2754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2754,1,3,0)
 ;;=3^Second osteoarthritis, unspec site
 ;;^UTILITY(U,$J,358.3,2754,1,4,0)
 ;;=4^M19.93
 ;;^UTILITY(U,$J,358.3,2754,2)
 ;;=^5010856
 ;;^UTILITY(U,$J,358.3,2755,0)
 ;;=M19.211^^12^109^30
 ;;^UTILITY(U,$J,358.3,2755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2755,1,3,0)
 ;;=3^Second osteoarthritis, rt shldr
 ;;^UTILITY(U,$J,358.3,2755,1,4,0)
 ;;=4^M19.211
 ;;^UTILITY(U,$J,358.3,2755,2)
 ;;=^5010838
 ;;^UTILITY(U,$J,358.3,2756,0)
 ;;=M19.212^^12^109^25
 ;;^UTILITY(U,$J,358.3,2756,1,0)
 ;;=^358.31IA^4^2
