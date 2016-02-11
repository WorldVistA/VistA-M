IBDEI31C ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,50890,1,3,0)
 ;;=3^Compl rotatr-cuff tear/ruptr of lft shldr, not trauma
 ;;^UTILITY(U,$J,358.3,50890,1,4,0)
 ;;=4^M75.122
 ;;^UTILITY(U,$J,358.3,50890,2)
 ;;=^5013249
 ;;^UTILITY(U,$J,358.3,50891,0)
 ;;=M66.821^^222^2466^272
 ;;^UTILITY(U,$J,358.3,50891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50891,1,3,0)
 ;;=3^Spont rptr of oth tendons, rt upper arm
 ;;^UTILITY(U,$J,358.3,50891,1,4,0)
 ;;=4^M66.821
 ;;^UTILITY(U,$J,358.3,50891,2)
 ;;=^5012896
 ;;^UTILITY(U,$J,358.3,50892,0)
 ;;=M66.822^^222^2466^270
 ;;^UTILITY(U,$J,358.3,50892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50892,1,3,0)
 ;;=3^Spont rptr of oth tendons, lft upper arm
 ;;^UTILITY(U,$J,358.3,50892,1,4,0)
 ;;=4^M66.822
 ;;^UTILITY(U,$J,358.3,50892,2)
 ;;=^5133838
 ;;^UTILITY(U,$J,358.3,50893,0)
 ;;=M66.231^^222^2466^259
 ;;^UTILITY(U,$J,358.3,50893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50893,1,3,0)
 ;;=3^Spont rptr of extensor tendons, rt forearm
 ;;^UTILITY(U,$J,358.3,50893,1,4,0)
 ;;=4^M66.231
 ;;^UTILITY(U,$J,358.3,50893,2)
 ;;=^5012854
 ;;^UTILITY(U,$J,358.3,50894,0)
 ;;=M66.232^^222^2466^255
 ;;^UTILITY(U,$J,358.3,50894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50894,1,3,0)
 ;;=3^Spont rptr of extensor tendons, lft forearm
 ;;^UTILITY(U,$J,358.3,50894,1,4,0)
 ;;=4^M66.232
 ;;^UTILITY(U,$J,358.3,50894,2)
 ;;=^5012855
 ;;^UTILITY(U,$J,358.3,50895,0)
 ;;=M66.241^^222^2466^260
 ;;^UTILITY(U,$J,358.3,50895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50895,1,3,0)
 ;;=3^Spont rptr of extensor tendons, rt hand
 ;;^UTILITY(U,$J,358.3,50895,1,4,0)
 ;;=4^M66.241
 ;;^UTILITY(U,$J,358.3,50895,2)
 ;;=^5012857
 ;;^UTILITY(U,$J,358.3,50896,0)
 ;;=M66.242^^222^2466^256
 ;;^UTILITY(U,$J,358.3,50896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50896,1,3,0)
 ;;=3^Spont rptr of extensor tendons, lft hand
 ;;^UTILITY(U,$J,358.3,50896,1,4,0)
 ;;=4^M66.242
 ;;^UTILITY(U,$J,358.3,50896,2)
 ;;=^5012858
 ;;^UTILITY(U,$J,358.3,50897,0)
 ;;=M66.331^^222^2466^266
 ;;^UTILITY(U,$J,358.3,50897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50897,1,3,0)
 ;;=3^Spont rptr of flexor tendons, rt forearm
 ;;^UTILITY(U,$J,358.3,50897,1,4,0)
 ;;=4^M66.331
 ;;^UTILITY(U,$J,358.3,50897,2)
 ;;=^5012878
 ;;^UTILITY(U,$J,358.3,50898,0)
 ;;=M66.332^^222^2466^263
 ;;^UTILITY(U,$J,358.3,50898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50898,1,3,0)
 ;;=3^Spont rptr of flexor tendons, lft forearm
 ;;^UTILITY(U,$J,358.3,50898,1,4,0)
 ;;=4^M66.332
 ;;^UTILITY(U,$J,358.3,50898,2)
 ;;=^5012879
 ;;^UTILITY(U,$J,358.3,50899,0)
 ;;=M66.341^^222^2466^267
 ;;^UTILITY(U,$J,358.3,50899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50899,1,3,0)
 ;;=3^Spont rptr of flexor tendons, rt hand
 ;;^UTILITY(U,$J,358.3,50899,1,4,0)
 ;;=4^M66.341
 ;;^UTILITY(U,$J,358.3,50899,2)
 ;;=^5012881
 ;;^UTILITY(U,$J,358.3,50900,0)
 ;;=M66.342^^222^2466^264
 ;;^UTILITY(U,$J,358.3,50900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50900,1,3,0)
 ;;=3^Spont rptr of flexor tendons, lft hand
 ;;^UTILITY(U,$J,358.3,50900,1,4,0)
 ;;=4^M66.342
 ;;^UTILITY(U,$J,358.3,50900,2)
 ;;=^5012882
 ;;^UTILITY(U,$J,358.3,50901,0)
 ;;=M66.251^^222^2466^262
 ;;^UTILITY(U,$J,358.3,50901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50901,1,3,0)
 ;;=3^Spont rptr of extensor tendons, rt thigh
 ;;^UTILITY(U,$J,358.3,50901,1,4,0)
 ;;=4^M66.251
 ;;^UTILITY(U,$J,358.3,50901,2)
 ;;=^5012860
 ;;^UTILITY(U,$J,358.3,50902,0)
 ;;=M66.252^^222^2466^258
 ;;^UTILITY(U,$J,358.3,50902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50902,1,3,0)
 ;;=3^Spont rptr of extensor tendons, lft thigh
 ;;^UTILITY(U,$J,358.3,50902,1,4,0)
 ;;=4^M66.252
