IBDEI1UL ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32939,0)
 ;;=M05.9^^191^1963^35
 ;;^UTILITY(U,$J,358.3,32939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32939,1,3,0)
 ;;=3^Arthritis, Rheum w/ Rheum Factor, unspec
 ;;^UTILITY(U,$J,358.3,32939,1,4,0)
 ;;=4^M05.9
 ;;^UTILITY(U,$J,358.3,32939,2)
 ;;=^5010046
 ;;^UTILITY(U,$J,358.3,32940,0)
 ;;=M05.89^^191^1963^33
 ;;^UTILITY(U,$J,358.3,32940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32940,1,3,0)
 ;;=3^Arthritis, Rheum w/ Rheum Factor, multpl sites, oth
 ;;^UTILITY(U,$J,358.3,32940,1,4,0)
 ;;=4^M05.89
 ;;^UTILITY(U,$J,358.3,32940,2)
 ;;=^5010045
 ;;^UTILITY(U,$J,358.3,32941,0)
 ;;=M05.872^^191^1963^32
 ;;^UTILITY(U,$J,358.3,32941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32941,1,3,0)
 ;;=3^Arthritis, Rheum w/ Rheum Factor, lft ank & ft
 ;;^UTILITY(U,$J,358.3,32941,1,4,0)
 ;;=4^M05.872
 ;;^UTILITY(U,$J,358.3,32941,2)
 ;;=^5010043
 ;;^UTILITY(U,$J,358.3,32942,0)
 ;;=M05.871^^191^1963^34
 ;;^UTILITY(U,$J,358.3,32942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32942,1,3,0)
 ;;=3^Arthritis, Rheum w/ Rheum Factor, rt ank & ft
 ;;^UTILITY(U,$J,358.3,32942,1,4,0)
 ;;=4^M05.871
 ;;^UTILITY(U,$J,358.3,32942,2)
 ;;=^5010042
 ;;^UTILITY(U,$J,358.3,32943,0)
 ;;=M12.571^^191^1963^47
 ;;^UTILITY(U,$J,358.3,32943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32943,1,3,0)
 ;;=3^Arthropathy, Traumatic, rt ank & ft
 ;;^UTILITY(U,$J,358.3,32943,1,4,0)
 ;;=4^M12.571
 ;;^UTILITY(U,$J,358.3,32943,2)
 ;;=^5010637
 ;;^UTILITY(U,$J,358.3,32944,0)
 ;;=M12.572^^191^1963^46
 ;;^UTILITY(U,$J,358.3,32944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32944,1,3,0)
 ;;=3^Arthropathy, Traumatic, lft ank & ft
 ;;^UTILITY(U,$J,358.3,32944,1,4,0)
 ;;=4^M12.572
 ;;^UTILITY(U,$J,358.3,32944,2)
 ;;=^5010638
 ;;^UTILITY(U,$J,358.3,32945,0)
 ;;=S80.811A^^191^1963^10
 ;;^UTILITY(U,$J,358.3,32945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32945,1,3,0)
 ;;=3^Abrasion, rt lwr leg, init enc
 ;;^UTILITY(U,$J,358.3,32945,1,4,0)
 ;;=4^S80.811A
 ;;^UTILITY(U,$J,358.3,32945,2)
 ;;=^5039960
 ;;^UTILITY(U,$J,358.3,32946,0)
 ;;=S80.812A^^191^1963^5
 ;;^UTILITY(U,$J,358.3,32946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32946,1,3,0)
 ;;=3^Abrasion, lft lwr leg, init enc
 ;;^UTILITY(U,$J,358.3,32946,1,4,0)
 ;;=4^S80.812A
 ;;^UTILITY(U,$J,358.3,32946,2)
 ;;=^5039963
 ;;^UTILITY(U,$J,358.3,32947,0)
 ;;=S90.511A^^191^1963^6
 ;;^UTILITY(U,$J,358.3,32947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32947,1,3,0)
 ;;=3^Abrasion, rt ank, init enc
 ;;^UTILITY(U,$J,358.3,32947,1,4,0)
 ;;=4^S90.511A
 ;;^UTILITY(U,$J,358.3,32947,2)
 ;;=^5043997
 ;;^UTILITY(U,$J,358.3,32948,0)
 ;;=S90.512A^^191^1963^1
 ;;^UTILITY(U,$J,358.3,32948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32948,1,3,0)
 ;;=3^Abrasion, lft ank, init enc
 ;;^UTILITY(U,$J,358.3,32948,1,4,0)
 ;;=4^S90.512A
 ;;^UTILITY(U,$J,358.3,32948,2)
 ;;=^5044000
 ;;^UTILITY(U,$J,358.3,32949,0)
 ;;=S90.411A^^191^1963^8
 ;;^UTILITY(U,$J,358.3,32949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32949,1,3,0)
 ;;=3^Abrasion, rt grt toe, init enc
 ;;^UTILITY(U,$J,358.3,32949,1,4,0)
 ;;=4^S90.411A
 ;;^UTILITY(U,$J,358.3,32949,2)
 ;;=^5043889
 ;;^UTILITY(U,$J,358.3,32950,0)
 ;;=S90.412A^^191^1963^3
 ;;^UTILITY(U,$J,358.3,32950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32950,1,3,0)
 ;;=3^Abrasion, lft grt toe, init enc
 ;;^UTILITY(U,$J,358.3,32950,1,4,0)
 ;;=4^S90.412A
 ;;^UTILITY(U,$J,358.3,32950,2)
 ;;=^5043892
 ;;^UTILITY(U,$J,358.3,32951,0)
 ;;=S90.414A^^191^1963^9
 ;;^UTILITY(U,$J,358.3,32951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32951,1,3,0)
 ;;=3^Abrasion, rt lsr toe(s), init enc
