IBDEI025 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2467,1,3,0)
 ;;=3^Compl rotatr-cuff tear/ruptr of lft shldr, not trauma
 ;;^UTILITY(U,$J,358.3,2467,1,4,0)
 ;;=4^M75.122
 ;;^UTILITY(U,$J,358.3,2467,2)
 ;;=^5013249
 ;;^UTILITY(U,$J,358.3,2468,0)
 ;;=M66.821^^12^104^272
 ;;^UTILITY(U,$J,358.3,2468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2468,1,3,0)
 ;;=3^Spont rptr of oth tendons, rt upper arm
 ;;^UTILITY(U,$J,358.3,2468,1,4,0)
 ;;=4^M66.821
 ;;^UTILITY(U,$J,358.3,2468,2)
 ;;=^5012896
 ;;^UTILITY(U,$J,358.3,2469,0)
 ;;=M66.822^^12^104^270
 ;;^UTILITY(U,$J,358.3,2469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2469,1,3,0)
 ;;=3^Spont rptr of oth tendons, lft upper arm
 ;;^UTILITY(U,$J,358.3,2469,1,4,0)
 ;;=4^M66.822
 ;;^UTILITY(U,$J,358.3,2469,2)
 ;;=^5133838
 ;;^UTILITY(U,$J,358.3,2470,0)
 ;;=M66.231^^12^104^259
 ;;^UTILITY(U,$J,358.3,2470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2470,1,3,0)
 ;;=3^Spont rptr of extensor tendons, rt forearm
 ;;^UTILITY(U,$J,358.3,2470,1,4,0)
 ;;=4^M66.231
 ;;^UTILITY(U,$J,358.3,2470,2)
 ;;=^5012854
 ;;^UTILITY(U,$J,358.3,2471,0)
 ;;=M66.232^^12^104^255
 ;;^UTILITY(U,$J,358.3,2471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2471,1,3,0)
 ;;=3^Spont rptr of extensor tendons, lft forearm
 ;;^UTILITY(U,$J,358.3,2471,1,4,0)
 ;;=4^M66.232
 ;;^UTILITY(U,$J,358.3,2471,2)
 ;;=^5012855
 ;;^UTILITY(U,$J,358.3,2472,0)
 ;;=M66.241^^12^104^260
 ;;^UTILITY(U,$J,358.3,2472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2472,1,3,0)
 ;;=3^Spont rptr of extensor tendons, rt hand
 ;;^UTILITY(U,$J,358.3,2472,1,4,0)
 ;;=4^M66.241
 ;;^UTILITY(U,$J,358.3,2472,2)
 ;;=^5012857
 ;;^UTILITY(U,$J,358.3,2473,0)
 ;;=M66.242^^12^104^256
 ;;^UTILITY(U,$J,358.3,2473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2473,1,3,0)
 ;;=3^Spont rptr of extensor tendons, lft hand
 ;;^UTILITY(U,$J,358.3,2473,1,4,0)
 ;;=4^M66.242
 ;;^UTILITY(U,$J,358.3,2473,2)
 ;;=^5012858
 ;;^UTILITY(U,$J,358.3,2474,0)
 ;;=M66.331^^12^104^266
 ;;^UTILITY(U,$J,358.3,2474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2474,1,3,0)
 ;;=3^Spont rptr of flexor tendons, rt forearm
 ;;^UTILITY(U,$J,358.3,2474,1,4,0)
 ;;=4^M66.331
 ;;^UTILITY(U,$J,358.3,2474,2)
 ;;=^5012878
 ;;^UTILITY(U,$J,358.3,2475,0)
 ;;=M66.332^^12^104^263
 ;;^UTILITY(U,$J,358.3,2475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2475,1,3,0)
 ;;=3^Spont rptr of flexor tendons, lft forearm
 ;;^UTILITY(U,$J,358.3,2475,1,4,0)
 ;;=4^M66.332
 ;;^UTILITY(U,$J,358.3,2475,2)
 ;;=^5012879
 ;;^UTILITY(U,$J,358.3,2476,0)
 ;;=M66.341^^12^104^267
 ;;^UTILITY(U,$J,358.3,2476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2476,1,3,0)
 ;;=3^Spont rptr of flexor tendons, rt hand
 ;;^UTILITY(U,$J,358.3,2476,1,4,0)
 ;;=4^M66.341
 ;;^UTILITY(U,$J,358.3,2476,2)
 ;;=^5012881
 ;;^UTILITY(U,$J,358.3,2477,0)
 ;;=M66.342^^12^104^264
 ;;^UTILITY(U,$J,358.3,2477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2477,1,3,0)
 ;;=3^Spont rptr of flexor tendons, lft hand
 ;;^UTILITY(U,$J,358.3,2477,1,4,0)
 ;;=4^M66.342
 ;;^UTILITY(U,$J,358.3,2477,2)
 ;;=^5012882
 ;;^UTILITY(U,$J,358.3,2478,0)
 ;;=M66.251^^12^104^262
 ;;^UTILITY(U,$J,358.3,2478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2478,1,3,0)
 ;;=3^Spont rptr of extensor tendons, rt thigh
 ;;^UTILITY(U,$J,358.3,2478,1,4,0)
 ;;=4^M66.251
 ;;^UTILITY(U,$J,358.3,2478,2)
 ;;=^5012860
 ;;^UTILITY(U,$J,358.3,2479,0)
 ;;=M66.252^^12^104^258
 ;;^UTILITY(U,$J,358.3,2479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2479,1,3,0)
 ;;=3^Spont rptr of extensor tendons, lft thigh
 ;;^UTILITY(U,$J,358.3,2479,1,4,0)
 ;;=4^M66.252
 ;;^UTILITY(U,$J,358.3,2479,2)
 ;;=^5012861
 ;;^UTILITY(U,$J,358.3,2480,0)
 ;;=M66.261^^12^104^261
 ;;^UTILITY(U,$J,358.3,2480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2480,1,3,0)
 ;;=3^Spont rptr of extensor tendons, rt lwr leg
 ;;^UTILITY(U,$J,358.3,2480,1,4,0)
 ;;=4^M66.261
 ;;^UTILITY(U,$J,358.3,2480,2)
 ;;=^5012863
 ;;^UTILITY(U,$J,358.3,2481,0)
 ;;=M66.262^^12^104^257
 ;;^UTILITY(U,$J,358.3,2481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2481,1,3,0)
 ;;=3^Spont rptr of extensor tendons, lft lwr leg
 ;;^UTILITY(U,$J,358.3,2481,1,4,0)
 ;;=4^M66.262
 ;;^UTILITY(U,$J,358.3,2481,2)
 ;;=^5012864
 ;;^UTILITY(U,$J,358.3,2482,0)
 ;;=M66.361^^12^104^268
 ;;^UTILITY(U,$J,358.3,2482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2482,1,3,0)
 ;;=3^Spont rptr of flexor tendons, rt lwr leg
 ;;^UTILITY(U,$J,358.3,2482,1,4,0)
 ;;=4^M66.361
 ;;^UTILITY(U,$J,358.3,2482,2)
 ;;=^5012887
 ;;^UTILITY(U,$J,358.3,2483,0)
 ;;=M66.362^^12^104^265
 ;;^UTILITY(U,$J,358.3,2483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2483,1,3,0)
 ;;=3^Spont rptr of flexor tendons, lft lwr leg
 ;;^UTILITY(U,$J,358.3,2483,1,4,0)
 ;;=4^M66.362
 ;;^UTILITY(U,$J,358.3,2483,2)
 ;;=^5012888
 ;;^UTILITY(U,$J,358.3,2484,0)
 ;;=M66.871^^12^104^271
 ;;^UTILITY(U,$J,358.3,2484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2484,1,3,0)
 ;;=3^Spont rptr of oth tendons, rt ankle & foot
 ;;^UTILITY(U,$J,358.3,2484,1,4,0)
 ;;=4^M66.871
 ;;^UTILITY(U,$J,358.3,2484,2)
 ;;=^5012901
 ;;^UTILITY(U,$J,358.3,2485,0)
 ;;=M66.872^^12^104^269
 ;;^UTILITY(U,$J,358.3,2485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2485,1,3,0)
 ;;=3^Spont rptr of oth tendons, lft ankle & foot
 ;;^UTILITY(U,$J,358.3,2485,1,4,0)
 ;;=4^M66.872
 ;;^UTILITY(U,$J,358.3,2485,2)
 ;;=^5133843
 ;;^UTILITY(U,$J,358.3,2486,0)
 ;;=M67.01^^12^104^222
 ;;^UTILITY(U,$J,358.3,2486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2486,1,3,0)
 ;;=3^Short Achilles tendon (acquired), rt ankle
 ;;^UTILITY(U,$J,358.3,2486,1,4,0)
 ;;=4^M67.01
 ;;^UTILITY(U,$J,358.3,2486,2)
 ;;=^5012906
 ;;^UTILITY(U,$J,358.3,2487,0)
 ;;=M67.02^^12^104^221
 ;;^UTILITY(U,$J,358.3,2487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2487,1,3,0)
 ;;=3^Short Achilles tendon (acquired), lft ankle
 ;;^UTILITY(U,$J,358.3,2487,1,4,0)
 ;;=4^M67.02
 ;;^UTILITY(U,$J,358.3,2487,2)
 ;;=^5012907
 ;;^UTILITY(U,$J,358.3,2488,0)
 ;;=M65.20^^12^104^92
 ;;^UTILITY(U,$J,358.3,2488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2488,1,3,0)
 ;;=3^Calcific tendinitis, unspec site
 ;;^UTILITY(U,$J,358.3,2488,1,4,0)
 ;;=4^M65.20
 ;;^UTILITY(U,$J,358.3,2488,2)
 ;;=^5012755
 ;;^UTILITY(U,$J,358.3,2489,0)
 ;;=M71.40^^12^104^93
 ;;^UTILITY(U,$J,358.3,2489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2489,1,3,0)
 ;;=3^Calcium deposit in bursa, unspec site
 ;;^UTILITY(U,$J,358.3,2489,1,4,0)
 ;;=4^M71.40
 ;;^UTILITY(U,$J,358.3,2489,2)
 ;;=^5013169
 ;;^UTILITY(U,$J,358.3,2490,0)
 ;;=M67.51^^12^104^199
 ;;^UTILITY(U,$J,358.3,2490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2490,1,3,0)
 ;;=3^Plica syndrome, rt knee
 ;;^UTILITY(U,$J,358.3,2490,1,4,0)
 ;;=4^M67.51
 ;;^UTILITY(U,$J,358.3,2490,2)
 ;;=^5012981
 ;;^UTILITY(U,$J,358.3,2491,0)
 ;;=M67.52^^12^104^198
 ;;^UTILITY(U,$J,358.3,2491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2491,1,3,0)
 ;;=3^Plica syndrome, lft knee
 ;;^UTILITY(U,$J,358.3,2491,1,4,0)
 ;;=4^M67.52
 ;;^UTILITY(U,$J,358.3,2491,2)
 ;;=^5012982
 ;;^UTILITY(U,$J,358.3,2492,0)
 ;;=M65.011^^12^104^32
 ;;^UTILITY(U,$J,358.3,2492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2492,1,3,0)
 ;;=3^Abscess of tendon sheath, rt shoulder
 ;;^UTILITY(U,$J,358.3,2492,1,4,0)
 ;;=4^M65.011
 ;;^UTILITY(U,$J,358.3,2492,2)
 ;;=^5012710
 ;;^UTILITY(U,$J,358.3,2493,0)
 ;;=M65.012^^12^104^24
 ;;^UTILITY(U,$J,358.3,2493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2493,1,3,0)
 ;;=3^Abscess of tendon sheath, lft shoulder
 ;;^UTILITY(U,$J,358.3,2493,1,4,0)
 ;;=4^M65.012
 ;;^UTILITY(U,$J,358.3,2493,2)
 ;;=^5012711
 ;;^UTILITY(U,$J,358.3,2494,0)
 ;;=M65.022^^12^104^26
 ;;^UTILITY(U,$J,358.3,2494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2494,1,3,0)
 ;;=3^Abscess of tendon sheath, lft upper arm
 ;;^UTILITY(U,$J,358.3,2494,1,4,0)
 ;;=4^M65.022
 ;;^UTILITY(U,$J,358.3,2494,2)
 ;;=^5012714
 ;;^UTILITY(U,$J,358.3,2495,0)
 ;;=M65.031^^12^104^29
 ;;^UTILITY(U,$J,358.3,2495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2495,1,3,0)
 ;;=3^Abscess of tendon sheath, rt forearm
 ;;^UTILITY(U,$J,358.3,2495,1,4,0)
 ;;=4^M65.031
 ;;^UTILITY(U,$J,358.3,2495,2)
 ;;=^5012716
 ;;^UTILITY(U,$J,358.3,2496,0)
 ;;=M65.032^^12^104^21
 ;;^UTILITY(U,$J,358.3,2496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2496,1,3,0)
 ;;=3^Abscess of tendon sheath, lft forearm
 ;;^UTILITY(U,$J,358.3,2496,1,4,0)
 ;;=4^M65.032
 ;;^UTILITY(U,$J,358.3,2496,2)
 ;;=^5012717
 ;;^UTILITY(U,$J,358.3,2497,0)
 ;;=M65.041^^12^104^30
 ;;^UTILITY(U,$J,358.3,2497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2497,1,3,0)
 ;;=3^Abscess of tendon sheath, rt hand
 ;;^UTILITY(U,$J,358.3,2497,1,4,0)
 ;;=4^M65.041
 ;;^UTILITY(U,$J,358.3,2497,2)
 ;;=^5012719
 ;;^UTILITY(U,$J,358.3,2498,0)
 ;;=M65.042^^12^104^22
 ;;^UTILITY(U,$J,358.3,2498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2498,1,3,0)
 ;;=3^Abscess of tendon sheath, lft hand
 ;;^UTILITY(U,$J,358.3,2498,1,4,0)
 ;;=4^M65.042
 ;;^UTILITY(U,$J,358.3,2498,2)
 ;;=^5012720
 ;;^UTILITY(U,$J,358.3,2499,0)
 ;;=M65.051^^12^104^33
 ;;^UTILITY(U,$J,358.3,2499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2499,1,3,0)
 ;;=3^Abscess of tendon sheath, rt thigh
 ;;^UTILITY(U,$J,358.3,2499,1,4,0)
 ;;=4^M65.051
 ;;^UTILITY(U,$J,358.3,2499,2)
 ;;=^5012722
 ;;^UTILITY(U,$J,358.3,2500,0)
 ;;=M65.052^^12^104^25
 ;;^UTILITY(U,$J,358.3,2500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2500,1,3,0)
 ;;=3^Abscess of tendon sheath, lft thigh
 ;;^UTILITY(U,$J,358.3,2500,1,4,0)
 ;;=4^M65.052
 ;;^UTILITY(U,$J,358.3,2500,2)
 ;;=^5012723
 ;;^UTILITY(U,$J,358.3,2501,0)
 ;;=M65.061^^12^104^31
 ;;^UTILITY(U,$J,358.3,2501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2501,1,3,0)
 ;;=3^Abscess of tendon sheath, rt lwr leg
 ;;^UTILITY(U,$J,358.3,2501,1,4,0)
 ;;=4^M65.061
 ;;^UTILITY(U,$J,358.3,2501,2)
 ;;=^5012725
 ;;^UTILITY(U,$J,358.3,2502,0)
 ;;=M65.062^^12^104^23
 ;;^UTILITY(U,$J,358.3,2502,1,0)
 ;;=^358.31IA^4^2
