IBDEI0QP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12232,1,4,0)
 ;;=4^S42.102A
 ;;^UTILITY(U,$J,358.3,12232,2)
 ;;=^5026537
 ;;^UTILITY(U,$J,358.3,12233,0)
 ;;=S92.201A^^71^708^107
 ;;^UTILITY(U,$J,358.3,12233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12233,1,3,0)
 ;;=3^Fx of unsp tarsal bone(s) of right foot, init
 ;;^UTILITY(U,$J,358.3,12233,1,4,0)
 ;;=4^S92.201A
 ;;^UTILITY(U,$J,358.3,12233,2)
 ;;=^5044822
 ;;^UTILITY(U,$J,358.3,12234,0)
 ;;=S92.202A^^71^708^106
 ;;^UTILITY(U,$J,358.3,12234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12234,1,3,0)
 ;;=3^Fx of unsp tarsal bone(s) of left foot, init
 ;;^UTILITY(U,$J,358.3,12234,1,4,0)
 ;;=4^S92.202A
 ;;^UTILITY(U,$J,358.3,12234,2)
 ;;=^5044829
 ;;^UTILITY(U,$J,358.3,12235,0)
 ;;=S62.501A^^71^708^105
 ;;^UTILITY(U,$J,358.3,12235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12235,1,3,0)
 ;;=3^Fx of unsp phalanx of right thumb, init for clos fx
 ;;^UTILITY(U,$J,358.3,12235,1,4,0)
 ;;=4^S62.501A
 ;;^UTILITY(U,$J,358.3,12235,2)
 ;;=^5034284
 ;;^UTILITY(U,$J,358.3,12236,0)
 ;;=S62.502A^^71^708^100
 ;;^UTILITY(U,$J,358.3,12236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12236,1,3,0)
 ;;=3^Fx of unsp phalanx of left thumb, init for clos fx
 ;;^UTILITY(U,$J,358.3,12236,1,4,0)
 ;;=4^S62.502A
 ;;^UTILITY(U,$J,358.3,12236,2)
 ;;=^5034291
 ;;^UTILITY(U,$J,358.3,12237,0)
 ;;=S82.201A^^71^708^85
 ;;^UTILITY(U,$J,358.3,12237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12237,1,3,0)
 ;;=3^Fx of right tibia shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,12237,1,4,0)
 ;;=4^S82.201A
 ;;^UTILITY(U,$J,358.3,12237,2)
 ;;=^5041102
 ;;^UTILITY(U,$J,358.3,12238,0)
 ;;=S82.202A^^71^708^72
 ;;^UTILITY(U,$J,358.3,12238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12238,1,3,0)
 ;;=3^Fx of left tibia shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,12238,1,4,0)
 ;;=4^S82.202A
 ;;^UTILITY(U,$J,358.3,12238,2)
 ;;=^5041118
 ;;^UTILITY(U,$J,358.3,12239,0)
 ;;=S92.911A^^71^708^86
 ;;^UTILITY(U,$J,358.3,12239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12239,1,3,0)
 ;;=3^Fx of right toe(s) unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,12239,1,4,0)
 ;;=4^S92.911A
 ;;^UTILITY(U,$J,358.3,12239,2)
 ;;=^5045592
 ;;^UTILITY(U,$J,358.3,12240,0)
 ;;=S92.912A^^71^708^73
 ;;^UTILITY(U,$J,358.3,12240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12240,1,3,0)
 ;;=3^Fx of left toe(s) unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,12240,1,4,0)
 ;;=4^S92.912A
 ;;^UTILITY(U,$J,358.3,12240,2)
 ;;=^5045599
 ;;^UTILITY(U,$J,358.3,12241,0)
 ;;=S52.201A^^71^708^87
 ;;^UTILITY(U,$J,358.3,12241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12241,1,3,0)
 ;;=3^Fx of right ulna shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,12241,1,4,0)
 ;;=4^S52.201A
 ;;^UTILITY(U,$J,358.3,12241,2)
 ;;=^5029260
 ;;^UTILITY(U,$J,358.3,12242,0)
 ;;=S52.202A^^71^708^74
 ;;^UTILITY(U,$J,358.3,12242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12242,1,3,0)
 ;;=3^Fx of left ulna shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,12242,1,4,0)
 ;;=4^S52.202A
 ;;^UTILITY(U,$J,358.3,12242,2)
 ;;=^5029276
 ;;^UTILITY(U,$J,358.3,12243,0)
 ;;=T59.91XA^^71^708^245
 ;;^UTILITY(U,$J,358.3,12243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12243,1,3,0)
 ;;=3^Toxic effect of unsp gases, fumes and vapors, acc, init
 ;;^UTILITY(U,$J,358.3,12243,1,4,0)
 ;;=4^T59.91XA
 ;;^UTILITY(U,$J,358.3,12243,2)
 ;;=^5053042
 ;;^UTILITY(U,$J,358.3,12244,0)
 ;;=S41.111A^^71^708^135
 ;;^UTILITY(U,$J,358.3,12244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12244,1,3,0)
 ;;=3^Laceration w/o fb of right upper arm, init encntr
 ;;^UTILITY(U,$J,358.3,12244,1,4,0)
 ;;=4^S41.111A
