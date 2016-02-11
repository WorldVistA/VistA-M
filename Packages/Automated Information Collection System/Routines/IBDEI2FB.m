IBDEI2FB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40695,1,4,0)
 ;;=4^S93.324A
 ;;^UTILITY(U,$J,358.3,40695,2)
 ;;=^5045759
 ;;^UTILITY(U,$J,358.3,40696,0)
 ;;=S93.334A^^189^2084^68
 ;;^UTILITY(U,$J,358.3,40696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40696,1,3,0)
 ;;=3^Dislocation of rt ft, oth, init enc
 ;;^UTILITY(U,$J,358.3,40696,1,4,0)
 ;;=4^S93.334A
 ;;^UTILITY(U,$J,358.3,40696,2)
 ;;=^5045771
 ;;^UTILITY(U,$J,358.3,40697,0)
 ;;=S93.335A^^189^2084^65
 ;;^UTILITY(U,$J,358.3,40697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40697,1,3,0)
 ;;=3^Dislocation of lft ft, oth, init enc
 ;;^UTILITY(U,$J,358.3,40697,1,4,0)
 ;;=4^S93.335A
 ;;^UTILITY(U,$J,358.3,40697,2)
 ;;=^5137669
 ;;^UTILITY(U,$J,358.3,40698,0)
 ;;=S93.125A^^189^2084^58
 ;;^UTILITY(U,$J,358.3,40698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40698,1,3,0)
 ;;=3^Dislocation of MTP joint of lft lsr toe(s), init
 ;;^UTILITY(U,$J,358.3,40698,1,4,0)
 ;;=4^S93.125A
 ;;^UTILITY(U,$J,358.3,40698,2)
 ;;=^5045669
 ;;^UTILITY(U,$J,358.3,40699,0)
 ;;=S93.124A^^189^2084^60
 ;;^UTILITY(U,$J,358.3,40699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40699,1,3,0)
 ;;=3^Dislocation of MTP joint of rt lsr toe(s), init
 ;;^UTILITY(U,$J,358.3,40699,1,4,0)
 ;;=4^S93.124A
 ;;^UTILITY(U,$J,358.3,40699,2)
 ;;=^5045666
 ;;^UTILITY(U,$J,358.3,40700,0)
 ;;=S93.121A^^189^2084^59
 ;;^UTILITY(U,$J,358.3,40700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40700,1,3,0)
 ;;=3^Dislocation of MTP joint of rt great toe, init
 ;;^UTILITY(U,$J,358.3,40700,1,4,0)
 ;;=4^S93.121A
 ;;^UTILITY(U,$J,358.3,40700,2)
 ;;=^5045657
 ;;^UTILITY(U,$J,358.3,40701,0)
 ;;=S93.122A^^189^2084^57
 ;;^UTILITY(U,$J,358.3,40701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40701,1,3,0)
 ;;=3^Dislocation of MTP joint of lft great toe, init
 ;;^UTILITY(U,$J,358.3,40701,1,4,0)
 ;;=4^S93.122A
 ;;^UTILITY(U,$J,358.3,40701,2)
 ;;=^5045660
 ;;^UTILITY(U,$J,358.3,40702,0)
 ;;=S93.111A^^189^2084^63
 ;;^UTILITY(U,$J,358.3,40702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40702,1,3,0)
 ;;=3^Dislocation of interphaln joint of right grt toe, init
 ;;^UTILITY(U,$J,358.3,40702,1,4,0)
 ;;=4^S93.111A
 ;;^UTILITY(U,$J,358.3,40702,2)
 ;;=^5045636
 ;;^UTILITY(U,$J,358.3,40703,0)
 ;;=S93.112A^^189^2084^61
 ;;^UTILITY(U,$J,358.3,40703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40703,1,3,0)
 ;;=3^Dislocation of interphalangeal joint of lft grt toe, init
 ;;^UTILITY(U,$J,358.3,40703,1,4,0)
 ;;=4^S93.112A
 ;;^UTILITY(U,$J,358.3,40703,2)
 ;;=^5045639
 ;;^UTILITY(U,$J,358.3,40704,0)
 ;;=S93.114A^^189^2084^64
 ;;^UTILITY(U,$J,358.3,40704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40704,1,3,0)
 ;;=3^Dislocation of interphaln joint of rt lsr toe(s), init
 ;;^UTILITY(U,$J,358.3,40704,1,4,0)
 ;;=4^S93.114A
 ;;^UTILITY(U,$J,358.3,40704,2)
 ;;=^5045645
 ;;^UTILITY(U,$J,358.3,40705,0)
 ;;=S93.115A^^189^2084^62
 ;;^UTILITY(U,$J,358.3,40705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40705,1,3,0)
 ;;=3^Dislocation of interphaln joint of lft lsr toe(s), init
 ;;^UTILITY(U,$J,358.3,40705,1,4,0)
 ;;=4^S93.115A
 ;;^UTILITY(U,$J,358.3,40705,2)
 ;;=^5045648
 ;;^UTILITY(U,$J,358.3,40706,0)
 ;;=S93.104A^^189^2084^70
 ;;^UTILITY(U,$J,358.3,40706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40706,1,3,0)
 ;;=3^Dislocation of rt toe(s), unspec, init enc
 ;;^UTILITY(U,$J,358.3,40706,1,4,0)
 ;;=4^S93.104A
 ;;^UTILITY(U,$J,358.3,40706,2)
 ;;=^5045630
 ;;^UTILITY(U,$J,358.3,40707,0)
 ;;=S93.105A^^189^2084^67
 ;;^UTILITY(U,$J,358.3,40707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40707,1,3,0)
 ;;=3^Dislocation of lft toe(s), unspec, init enc
 ;;^UTILITY(U,$J,358.3,40707,1,4,0)
 ;;=4^S93.105A
