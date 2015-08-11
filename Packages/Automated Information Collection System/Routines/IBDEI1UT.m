IBDEI1UT ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33038,1,3,0)
 ;;=3^B Group Vitamin Deficiency NEC
 ;;^UTILITY(U,$J,358.3,33038,1,4,0)
 ;;=4^E53.8
 ;;^UTILITY(U,$J,358.3,33038,2)
 ;;=^5002797
 ;;^UTILITY(U,$J,358.3,33039,0)
 ;;=T25.131A^^191^1964^48
 ;;^UTILITY(U,$J,358.3,33039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33039,1,3,0)
 ;;=3^Burn of rt toe(s)(nail), first degree, init enc
 ;;^UTILITY(U,$J,358.3,33039,1,4,0)
 ;;=4^T25.131A
 ;;^UTILITY(U,$J,358.3,33039,2)
 ;;=^5048532
 ;;^UTILITY(U,$J,358.3,33040,0)
 ;;=T25.132A^^191^1964^32
 ;;^UTILITY(U,$J,358.3,33040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33040,1,3,0)
 ;;=3^Burn of lft toe(s)(nail), first degree, init enc
 ;;^UTILITY(U,$J,358.3,33040,1,4,0)
 ;;=4^T25.132A
 ;;^UTILITY(U,$J,358.3,33040,2)
 ;;=^5048535
 ;;^UTILITY(U,$J,358.3,33041,0)
 ;;=T25.121A^^191^1964^38
 ;;^UTILITY(U,$J,358.3,33041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33041,1,3,0)
 ;;=3^Burn of rt foot, first degree, init enc
 ;;^UTILITY(U,$J,358.3,33041,1,4,0)
 ;;=4^T25.121A
 ;;^UTILITY(U,$J,358.3,33041,2)
 ;;=^5048523
 ;;^UTILITY(U,$J,358.3,33042,0)
 ;;=T25.122A^^191^1964^22
 ;;^UTILITY(U,$J,358.3,33042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33042,1,3,0)
 ;;=3^Burn of lft ft, first degree, init enc
 ;;^UTILITY(U,$J,358.3,33042,1,4,0)
 ;;=4^T25.122A
 ;;^UTILITY(U,$J,358.3,33042,2)
 ;;=^5048526
 ;;^UTILITY(U,$J,358.3,33043,0)
 ;;=T25.111A^^191^1964^34
 ;;^UTILITY(U,$J,358.3,33043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33043,1,3,0)
 ;;=3^Burn of rt ankl, first degree, init enc
 ;;^UTILITY(U,$J,358.3,33043,1,4,0)
 ;;=4^T25.111A
 ;;^UTILITY(U,$J,358.3,33043,2)
 ;;=^5048514
 ;;^UTILITY(U,$J,358.3,33044,0)
 ;;=T25.112A^^191^1964^18
 ;;^UTILITY(U,$J,358.3,33044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33044,1,3,0)
 ;;=3^Burn of lft ankl, first degree, init enc
 ;;^UTILITY(U,$J,358.3,33044,1,4,0)
 ;;=4^T25.112A
 ;;^UTILITY(U,$J,358.3,33044,2)
 ;;=^5048517
 ;;^UTILITY(U,$J,358.3,33045,0)
 ;;=T24.131A^^191^1964^42
 ;;^UTILITY(U,$J,358.3,33045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33045,1,3,0)
 ;;=3^Burn of rt lwr leg, first degree, init enc
 ;;^UTILITY(U,$J,358.3,33045,1,4,0)
 ;;=4^T24.131A
 ;;^UTILITY(U,$J,358.3,33045,2)
 ;;=^5048232
 ;;^UTILITY(U,$J,358.3,33046,0)
 ;;=T24.132A^^191^1964^26
 ;;^UTILITY(U,$J,358.3,33046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33046,1,3,0)
 ;;=3^Burn of lft lwr leg, first degree, init enc
 ;;^UTILITY(U,$J,358.3,33046,1,4,0)
 ;;=4^T24.132A
 ;;^UTILITY(U,$J,358.3,33046,2)
 ;;=^5048235
 ;;^UTILITY(U,$J,358.3,33047,0)
 ;;=T25.232A^^191^1964^30
 ;;^UTILITY(U,$J,358.3,33047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33047,1,3,0)
 ;;=3^Burn of lft toe(s) (nail), sec degree, init enc
 ;;^UTILITY(U,$J,358.3,33047,1,4,0)
 ;;=4^T25.232A
 ;;^UTILITY(U,$J,358.3,33047,2)
 ;;=^5048571
 ;;^UTILITY(U,$J,358.3,33048,0)
 ;;=T25.231A^^191^1964^46
 ;;^UTILITY(U,$J,358.3,33048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33048,1,3,0)
 ;;=3^Burn of rt toe(s) (nail), sec degree, init enc
 ;;^UTILITY(U,$J,358.3,33048,1,4,0)
 ;;=4^T25.231A
 ;;^UTILITY(U,$J,358.3,33048,2)
 ;;=^5048568
 ;;^UTILITY(U,$J,358.3,33049,0)
 ;;=T25.221A^^191^1964^39
 ;;^UTILITY(U,$J,358.3,33049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33049,1,3,0)
 ;;=3^Burn of rt ft, sec degree, init enc
 ;;^UTILITY(U,$J,358.3,33049,1,4,0)
 ;;=4^T25.221A
 ;;^UTILITY(U,$J,358.3,33049,2)
 ;;=^5048559
 ;;^UTILITY(U,$J,358.3,33050,0)
 ;;=T25.222A^^191^1964^23
 ;;^UTILITY(U,$J,358.3,33050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33050,1,3,0)
 ;;=3^Burn of lft ft, sec degree, init enc
