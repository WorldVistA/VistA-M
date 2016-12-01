IBDEI0TK ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38893,1,3,0)
 ;;=3^Spont rptr of extensor tendons, lft thigh
 ;;^UTILITY(U,$J,358.3,38893,1,4,0)
 ;;=4^M66.252
 ;;^UTILITY(U,$J,358.3,38893,2)
 ;;=^5012861
 ;;^UTILITY(U,$J,358.3,38894,0)
 ;;=M66.261^^109^1612^262
 ;;^UTILITY(U,$J,358.3,38894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38894,1,3,0)
 ;;=3^Spont rptr of extensor tendons, rt lwr leg
 ;;^UTILITY(U,$J,358.3,38894,1,4,0)
 ;;=4^M66.261
 ;;^UTILITY(U,$J,358.3,38894,2)
 ;;=^5012863
 ;;^UTILITY(U,$J,358.3,38895,0)
 ;;=M66.262^^109^1612^258
 ;;^UTILITY(U,$J,358.3,38895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38895,1,3,0)
 ;;=3^Spont rptr of extensor tendons, lft lwr leg
 ;;^UTILITY(U,$J,358.3,38895,1,4,0)
 ;;=4^M66.262
 ;;^UTILITY(U,$J,358.3,38895,2)
 ;;=^5012864
 ;;^UTILITY(U,$J,358.3,38896,0)
 ;;=M66.361^^109^1612^269
 ;;^UTILITY(U,$J,358.3,38896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38896,1,3,0)
 ;;=3^Spont rptr of flexor tendons, rt lwr leg
 ;;^UTILITY(U,$J,358.3,38896,1,4,0)
 ;;=4^M66.361
 ;;^UTILITY(U,$J,358.3,38896,2)
 ;;=^5012887
 ;;^UTILITY(U,$J,358.3,38897,0)
 ;;=M66.362^^109^1612^266
 ;;^UTILITY(U,$J,358.3,38897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38897,1,3,0)
 ;;=3^Spont rptr of flexor tendons, lft lwr leg
 ;;^UTILITY(U,$J,358.3,38897,1,4,0)
 ;;=4^M66.362
 ;;^UTILITY(U,$J,358.3,38897,2)
 ;;=^5012888
 ;;^UTILITY(U,$J,358.3,38898,0)
 ;;=M66.871^^109^1612^272
 ;;^UTILITY(U,$J,358.3,38898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38898,1,3,0)
 ;;=3^Spont rptr of oth tendons, rt ankle & foot
 ;;^UTILITY(U,$J,358.3,38898,1,4,0)
 ;;=4^M66.871
 ;;^UTILITY(U,$J,358.3,38898,2)
 ;;=^5012901
 ;;^UTILITY(U,$J,358.3,38899,0)
 ;;=M66.872^^109^1612^270
 ;;^UTILITY(U,$J,358.3,38899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38899,1,3,0)
 ;;=3^Spont rptr of oth tendons, lft ankle & foot
 ;;^UTILITY(U,$J,358.3,38899,1,4,0)
 ;;=4^M66.872
 ;;^UTILITY(U,$J,358.3,38899,2)
 ;;=^5133843
 ;;^UTILITY(U,$J,358.3,38900,0)
 ;;=M67.01^^109^1612^223
 ;;^UTILITY(U,$J,358.3,38900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38900,1,3,0)
 ;;=3^Short Achilles tendon (acquired), rt ankle
 ;;^UTILITY(U,$J,358.3,38900,1,4,0)
 ;;=4^M67.01
 ;;^UTILITY(U,$J,358.3,38900,2)
 ;;=^5012906
 ;;^UTILITY(U,$J,358.3,38901,0)
 ;;=M67.02^^109^1612^222
 ;;^UTILITY(U,$J,358.3,38901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38901,1,3,0)
 ;;=3^Short Achilles tendon (acquired), lft ankle
 ;;^UTILITY(U,$J,358.3,38901,1,4,0)
 ;;=4^M67.02
 ;;^UTILITY(U,$J,358.3,38901,2)
 ;;=^5012907
 ;;^UTILITY(U,$J,358.3,38902,0)
 ;;=M65.20^^109^1612^92
 ;;^UTILITY(U,$J,358.3,38902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38902,1,3,0)
 ;;=3^Calcific tendinitis, unspec site
 ;;^UTILITY(U,$J,358.3,38902,1,4,0)
 ;;=4^M65.20
 ;;^UTILITY(U,$J,358.3,38902,2)
 ;;=^5012755
 ;;^UTILITY(U,$J,358.3,38903,0)
 ;;=M71.40^^109^1612^93
 ;;^UTILITY(U,$J,358.3,38903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38903,1,3,0)
 ;;=3^Calcium deposit in bursa, unspec site
 ;;^UTILITY(U,$J,358.3,38903,1,4,0)
 ;;=4^M71.40
 ;;^UTILITY(U,$J,358.3,38903,2)
 ;;=^5013169
 ;;^UTILITY(U,$J,358.3,38904,0)
 ;;=M67.51^^109^1612^201
 ;;^UTILITY(U,$J,358.3,38904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38904,1,3,0)
 ;;=3^Plica syndrome, rt knee
 ;;^UTILITY(U,$J,358.3,38904,1,4,0)
 ;;=4^M67.51
 ;;^UTILITY(U,$J,358.3,38904,2)
 ;;=^5012981
 ;;^UTILITY(U,$J,358.3,38905,0)
 ;;=M67.52^^109^1612^200
 ;;^UTILITY(U,$J,358.3,38905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38905,1,3,0)
 ;;=3^Plica syndrome, lft knee
 ;;^UTILITY(U,$J,358.3,38905,1,4,0)
 ;;=4^M67.52
 ;;^UTILITY(U,$J,358.3,38905,2)
 ;;=^5012982
 ;;^UTILITY(U,$J,358.3,38906,0)
 ;;=M65.011^^109^1612^32
 ;;^UTILITY(U,$J,358.3,38906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38906,1,3,0)
 ;;=3^Abscess of tendon sheath, rt shoulder
 ;;^UTILITY(U,$J,358.3,38906,1,4,0)
 ;;=4^M65.011
 ;;^UTILITY(U,$J,358.3,38906,2)
 ;;=^5012710
 ;;^UTILITY(U,$J,358.3,38907,0)
 ;;=M65.012^^109^1612^24
 ;;^UTILITY(U,$J,358.3,38907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38907,1,3,0)
 ;;=3^Abscess of tendon sheath, lft shoulder
 ;;^UTILITY(U,$J,358.3,38907,1,4,0)
 ;;=4^M65.012
 ;;^UTILITY(U,$J,358.3,38907,2)
 ;;=^5012711
 ;;^UTILITY(U,$J,358.3,38908,0)
 ;;=M65.022^^109^1612^26
 ;;^UTILITY(U,$J,358.3,38908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38908,1,3,0)
 ;;=3^Abscess of tendon sheath, lft upper arm
 ;;^UTILITY(U,$J,358.3,38908,1,4,0)
 ;;=4^M65.022
 ;;^UTILITY(U,$J,358.3,38908,2)
 ;;=^5012714
 ;;^UTILITY(U,$J,358.3,38909,0)
 ;;=M65.031^^109^1612^29
 ;;^UTILITY(U,$J,358.3,38909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38909,1,3,0)
 ;;=3^Abscess of tendon sheath, rt forearm
 ;;^UTILITY(U,$J,358.3,38909,1,4,0)
 ;;=4^M65.031
 ;;^UTILITY(U,$J,358.3,38909,2)
 ;;=^5012716
 ;;^UTILITY(U,$J,358.3,38910,0)
 ;;=M65.032^^109^1612^21
 ;;^UTILITY(U,$J,358.3,38910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38910,1,3,0)
 ;;=3^Abscess of tendon sheath, lft forearm
 ;;^UTILITY(U,$J,358.3,38910,1,4,0)
 ;;=4^M65.032
 ;;^UTILITY(U,$J,358.3,38910,2)
 ;;=^5012717
 ;;^UTILITY(U,$J,358.3,38911,0)
 ;;=M65.041^^109^1612^30
 ;;^UTILITY(U,$J,358.3,38911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38911,1,3,0)
 ;;=3^Abscess of tendon sheath, rt hand
 ;;^UTILITY(U,$J,358.3,38911,1,4,0)
 ;;=4^M65.041
 ;;^UTILITY(U,$J,358.3,38911,2)
 ;;=^5012719
 ;;^UTILITY(U,$J,358.3,38912,0)
 ;;=M65.042^^109^1612^22
 ;;^UTILITY(U,$J,358.3,38912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38912,1,3,0)
 ;;=3^Abscess of tendon sheath, lft hand
 ;;^UTILITY(U,$J,358.3,38912,1,4,0)
 ;;=4^M65.042
 ;;^UTILITY(U,$J,358.3,38912,2)
 ;;=^5012720
 ;;^UTILITY(U,$J,358.3,38913,0)
 ;;=M65.051^^109^1612^33
 ;;^UTILITY(U,$J,358.3,38913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38913,1,3,0)
 ;;=3^Abscess of tendon sheath, rt thigh
 ;;^UTILITY(U,$J,358.3,38913,1,4,0)
 ;;=4^M65.051
 ;;^UTILITY(U,$J,358.3,38913,2)
 ;;=^5012722
 ;;^UTILITY(U,$J,358.3,38914,0)
 ;;=M65.052^^109^1612^25
 ;;^UTILITY(U,$J,358.3,38914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38914,1,3,0)
 ;;=3^Abscess of tendon sheath, lft thigh
 ;;^UTILITY(U,$J,358.3,38914,1,4,0)
 ;;=4^M65.052
 ;;^UTILITY(U,$J,358.3,38914,2)
 ;;=^5012723
 ;;^UTILITY(U,$J,358.3,38915,0)
 ;;=M65.061^^109^1612^31
 ;;^UTILITY(U,$J,358.3,38915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38915,1,3,0)
 ;;=3^Abscess of tendon sheath, rt lwr leg
 ;;^UTILITY(U,$J,358.3,38915,1,4,0)
 ;;=4^M65.061
 ;;^UTILITY(U,$J,358.3,38915,2)
 ;;=^5012725
 ;;^UTILITY(U,$J,358.3,38916,0)
 ;;=M65.062^^109^1612^23
 ;;^UTILITY(U,$J,358.3,38916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38916,1,3,0)
 ;;=3^Abscess of tendon sheath, lft lwr leg
 ;;^UTILITY(U,$J,358.3,38916,1,4,0)
 ;;=4^M65.062
 ;;^UTILITY(U,$J,358.3,38916,2)
 ;;=^5012726
 ;;^UTILITY(U,$J,358.3,38917,0)
 ;;=M65.071^^109^1612^28
 ;;^UTILITY(U,$J,358.3,38917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38917,1,3,0)
 ;;=3^Abscess of tendon sheath, rt ankle & foot
 ;;^UTILITY(U,$J,358.3,38917,1,4,0)
 ;;=4^M65.071
 ;;^UTILITY(U,$J,358.3,38917,2)
 ;;=^5012728
 ;;^UTILITY(U,$J,358.3,38918,0)
 ;;=M65.072^^109^1612^20
 ;;^UTILITY(U,$J,358.3,38918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38918,1,3,0)
 ;;=3^Abscess of tendon sheath, lft ankle & foot
 ;;^UTILITY(U,$J,358.3,38918,1,4,0)
 ;;=4^M65.072
 ;;^UTILITY(U,$J,358.3,38918,2)
 ;;=^5012729
 ;;^UTILITY(U,$J,358.3,38919,0)
 ;;=M65.08^^109^1612^27
 ;;^UTILITY(U,$J,358.3,38919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38919,1,3,0)
 ;;=3^Abscess of tendon sheath, oth site
 ;;^UTILITY(U,$J,358.3,38919,1,4,0)
 ;;=4^M65.08
 ;;^UTILITY(U,$J,358.3,38919,2)
 ;;=^5012731
 ;;^UTILITY(U,$J,358.3,38920,0)
 ;;=M67.811^^109^1612^118
 ;;^UTILITY(U,$J,358.3,38920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38920,1,3,0)
 ;;=3^Disorders of synovium, rt shldr, oth, spec
 ;;^UTILITY(U,$J,358.3,38920,1,4,0)
 ;;=4^M67.811
 ;;^UTILITY(U,$J,358.3,38920,2)
 ;;=^5012984
 ;;^UTILITY(U,$J,358.3,38921,0)
 ;;=M67.812^^109^1612^111
 ;;^UTILITY(U,$J,358.3,38921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38921,1,3,0)
 ;;=3^Disorders of synovium, lft shldr, oth, spec
 ;;^UTILITY(U,$J,358.3,38921,1,4,0)
 ;;=4^M67.812
 ;;^UTILITY(U,$J,358.3,38921,2)
 ;;=^5012985
 ;;^UTILITY(U,$J,358.3,38922,0)
 ;;=M67.813^^109^1612^132
 ;;^UTILITY(U,$J,358.3,38922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38922,1,3,0)
 ;;=3^Disorders of tendon, rt shoulder, oth, spec
 ;;^UTILITY(U,$J,358.3,38922,1,4,0)
 ;;=4^M67.813
 ;;^UTILITY(U,$J,358.3,38922,2)
 ;;=^5012986
 ;;^UTILITY(U,$J,358.3,38923,0)
 ;;=M67.814^^109^1612^125
 ;;^UTILITY(U,$J,358.3,38923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38923,1,3,0)
 ;;=3^Disorders of tendon, lft shldr, oth, spec
 ;;^UTILITY(U,$J,358.3,38923,1,4,0)
 ;;=4^M67.814
 ;;^UTILITY(U,$J,358.3,38923,2)
 ;;=^5012987
 ;;^UTILITY(U,$J,358.3,38924,0)
 ;;=M67.821^^109^1612^114
 ;;^UTILITY(U,$J,358.3,38924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38924,1,3,0)
 ;;=3^Disorders of synovium, rt elbow, oth, spec
 ;;^UTILITY(U,$J,358.3,38924,1,4,0)
 ;;=4^M67.821
 ;;^UTILITY(U,$J,358.3,38924,2)
 ;;=^5012989
 ;;^UTILITY(U,$J,358.3,38925,0)
 ;;=M67.822^^109^1612^107
 ;;^UTILITY(U,$J,358.3,38925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38925,1,3,0)
 ;;=3^Disorders of synovium, lft elbow, oth, spec
 ;;^UTILITY(U,$J,358.3,38925,1,4,0)
 ;;=4^M67.822
 ;;^UTILITY(U,$J,358.3,38925,2)
 ;;=^5012990
 ;;^UTILITY(U,$J,358.3,38926,0)
 ;;=M67.823^^109^1612^128
 ;;^UTILITY(U,$J,358.3,38926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38926,1,3,0)
 ;;=3^Disorders of tendon, rt elbow, oth, spec
 ;;^UTILITY(U,$J,358.3,38926,1,4,0)
 ;;=4^M67.823
 ;;^UTILITY(U,$J,358.3,38926,2)
 ;;=^5012991
 ;;^UTILITY(U,$J,358.3,38927,0)
 ;;=M67.824^^109^1612^121
 ;;^UTILITY(U,$J,358.3,38927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38927,1,3,0)
 ;;=3^Disorders of tendon, lft elbow, oth, spec
