IBDEI271 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37210,1,3,0)
 ;;=3^Compl rotatr-cuff tear/ruptr of lft shldr, not trauma
 ;;^UTILITY(U,$J,358.3,37210,1,4,0)
 ;;=4^M75.122
 ;;^UTILITY(U,$J,358.3,37210,2)
 ;;=^5013249
 ;;^UTILITY(U,$J,358.3,37211,0)
 ;;=M66.821^^140^1787^273
 ;;^UTILITY(U,$J,358.3,37211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37211,1,3,0)
 ;;=3^Spont rptr of oth tendons, rt upper arm
 ;;^UTILITY(U,$J,358.3,37211,1,4,0)
 ;;=4^M66.821
 ;;^UTILITY(U,$J,358.3,37211,2)
 ;;=^5012896
 ;;^UTILITY(U,$J,358.3,37212,0)
 ;;=M66.822^^140^1787^271
 ;;^UTILITY(U,$J,358.3,37212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37212,1,3,0)
 ;;=3^Spont rptr of oth tendons, lft upper arm
 ;;^UTILITY(U,$J,358.3,37212,1,4,0)
 ;;=4^M66.822
 ;;^UTILITY(U,$J,358.3,37212,2)
 ;;=^5133838
 ;;^UTILITY(U,$J,358.3,37213,0)
 ;;=M66.231^^140^1787^260
 ;;^UTILITY(U,$J,358.3,37213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37213,1,3,0)
 ;;=3^Spont rptr of extensor tendons, rt forearm
 ;;^UTILITY(U,$J,358.3,37213,1,4,0)
 ;;=4^M66.231
 ;;^UTILITY(U,$J,358.3,37213,2)
 ;;=^5012854
 ;;^UTILITY(U,$J,358.3,37214,0)
 ;;=M66.232^^140^1787^256
 ;;^UTILITY(U,$J,358.3,37214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37214,1,3,0)
 ;;=3^Spont rptr of extensor tendons, lft forearm
 ;;^UTILITY(U,$J,358.3,37214,1,4,0)
 ;;=4^M66.232
 ;;^UTILITY(U,$J,358.3,37214,2)
 ;;=^5012855
 ;;^UTILITY(U,$J,358.3,37215,0)
 ;;=M66.241^^140^1787^261
 ;;^UTILITY(U,$J,358.3,37215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37215,1,3,0)
 ;;=3^Spont rptr of extensor tendons, rt hand
 ;;^UTILITY(U,$J,358.3,37215,1,4,0)
 ;;=4^M66.241
 ;;^UTILITY(U,$J,358.3,37215,2)
 ;;=^5012857
 ;;^UTILITY(U,$J,358.3,37216,0)
 ;;=M66.242^^140^1787^257
 ;;^UTILITY(U,$J,358.3,37216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37216,1,3,0)
 ;;=3^Spont rptr of extensor tendons, lft hand
 ;;^UTILITY(U,$J,358.3,37216,1,4,0)
 ;;=4^M66.242
 ;;^UTILITY(U,$J,358.3,37216,2)
 ;;=^5012858
 ;;^UTILITY(U,$J,358.3,37217,0)
 ;;=M66.331^^140^1787^267
 ;;^UTILITY(U,$J,358.3,37217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37217,1,3,0)
 ;;=3^Spont rptr of flexor tendons, rt forearm
 ;;^UTILITY(U,$J,358.3,37217,1,4,0)
 ;;=4^M66.331
 ;;^UTILITY(U,$J,358.3,37217,2)
 ;;=^5012878
 ;;^UTILITY(U,$J,358.3,37218,0)
 ;;=M66.332^^140^1787^264
 ;;^UTILITY(U,$J,358.3,37218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37218,1,3,0)
 ;;=3^Spont rptr of flexor tendons, lft forearm
 ;;^UTILITY(U,$J,358.3,37218,1,4,0)
 ;;=4^M66.332
 ;;^UTILITY(U,$J,358.3,37218,2)
 ;;=^5012879
 ;;^UTILITY(U,$J,358.3,37219,0)
 ;;=M66.341^^140^1787^268
 ;;^UTILITY(U,$J,358.3,37219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37219,1,3,0)
 ;;=3^Spont rptr of flexor tendons, rt hand
 ;;^UTILITY(U,$J,358.3,37219,1,4,0)
 ;;=4^M66.341
 ;;^UTILITY(U,$J,358.3,37219,2)
 ;;=^5012881
 ;;^UTILITY(U,$J,358.3,37220,0)
 ;;=M66.342^^140^1787^265
 ;;^UTILITY(U,$J,358.3,37220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37220,1,3,0)
 ;;=3^Spont rptr of flexor tendons, lft hand
 ;;^UTILITY(U,$J,358.3,37220,1,4,0)
 ;;=4^M66.342
 ;;^UTILITY(U,$J,358.3,37220,2)
 ;;=^5012882
 ;;^UTILITY(U,$J,358.3,37221,0)
 ;;=M66.251^^140^1787^263
 ;;^UTILITY(U,$J,358.3,37221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37221,1,3,0)
 ;;=3^Spont rptr of extensor tendons, rt thigh
 ;;^UTILITY(U,$J,358.3,37221,1,4,0)
 ;;=4^M66.251
 ;;^UTILITY(U,$J,358.3,37221,2)
 ;;=^5012860
 ;;^UTILITY(U,$J,358.3,37222,0)
 ;;=M66.252^^140^1787^259
 ;;^UTILITY(U,$J,358.3,37222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37222,1,3,0)
 ;;=3^Spont rptr of extensor tendons, lft thigh
 ;;^UTILITY(U,$J,358.3,37222,1,4,0)
 ;;=4^M66.252
