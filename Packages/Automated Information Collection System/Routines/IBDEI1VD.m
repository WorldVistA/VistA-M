IBDEI1VD ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31761,0)
 ;;=T25.111A^^126^1605^34
 ;;^UTILITY(U,$J,358.3,31761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31761,1,3,0)
 ;;=3^Burn of rt ankl, first degree, init enc
 ;;^UTILITY(U,$J,358.3,31761,1,4,0)
 ;;=4^T25.111A
 ;;^UTILITY(U,$J,358.3,31761,2)
 ;;=^5048514
 ;;^UTILITY(U,$J,358.3,31762,0)
 ;;=T25.112A^^126^1605^18
 ;;^UTILITY(U,$J,358.3,31762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31762,1,3,0)
 ;;=3^Burn of lft ankl, first degree, init enc
 ;;^UTILITY(U,$J,358.3,31762,1,4,0)
 ;;=4^T25.112A
 ;;^UTILITY(U,$J,358.3,31762,2)
 ;;=^5048517
 ;;^UTILITY(U,$J,358.3,31763,0)
 ;;=T24.131A^^126^1605^42
 ;;^UTILITY(U,$J,358.3,31763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31763,1,3,0)
 ;;=3^Burn of rt lwr leg, first degree, init enc
 ;;^UTILITY(U,$J,358.3,31763,1,4,0)
 ;;=4^T24.131A
 ;;^UTILITY(U,$J,358.3,31763,2)
 ;;=^5048232
 ;;^UTILITY(U,$J,358.3,31764,0)
 ;;=T24.132A^^126^1605^26
 ;;^UTILITY(U,$J,358.3,31764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31764,1,3,0)
 ;;=3^Burn of lft lwr leg, first degree, init enc
 ;;^UTILITY(U,$J,358.3,31764,1,4,0)
 ;;=4^T24.132A
 ;;^UTILITY(U,$J,358.3,31764,2)
 ;;=^5048235
 ;;^UTILITY(U,$J,358.3,31765,0)
 ;;=T25.232A^^126^1605^30
 ;;^UTILITY(U,$J,358.3,31765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31765,1,3,0)
 ;;=3^Burn of lft toe(s) (nail), sec degree, init enc
 ;;^UTILITY(U,$J,358.3,31765,1,4,0)
 ;;=4^T25.232A
 ;;^UTILITY(U,$J,358.3,31765,2)
 ;;=^5048571
 ;;^UTILITY(U,$J,358.3,31766,0)
 ;;=T25.231A^^126^1605^46
 ;;^UTILITY(U,$J,358.3,31766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31766,1,3,0)
 ;;=3^Burn of rt toe(s) (nail), sec degree, init enc
 ;;^UTILITY(U,$J,358.3,31766,1,4,0)
 ;;=4^T25.231A
 ;;^UTILITY(U,$J,358.3,31766,2)
 ;;=^5048568
 ;;^UTILITY(U,$J,358.3,31767,0)
 ;;=T25.221A^^126^1605^39
 ;;^UTILITY(U,$J,358.3,31767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31767,1,3,0)
 ;;=3^Burn of rt ft, sec degree, init enc
 ;;^UTILITY(U,$J,358.3,31767,1,4,0)
 ;;=4^T25.221A
 ;;^UTILITY(U,$J,358.3,31767,2)
 ;;=^5048559
 ;;^UTILITY(U,$J,358.3,31768,0)
 ;;=T25.222A^^126^1605^23
 ;;^UTILITY(U,$J,358.3,31768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31768,1,3,0)
 ;;=3^Burn of lft ft, sec degree, init enc
 ;;^UTILITY(U,$J,358.3,31768,1,4,0)
 ;;=4^T25.222A
 ;;^UTILITY(U,$J,358.3,31768,2)
 ;;=^5048562
 ;;^UTILITY(U,$J,358.3,31769,0)
 ;;=T25.211A^^126^1605^35
 ;;^UTILITY(U,$J,358.3,31769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31769,1,3,0)
 ;;=3^Burn of rt ankl, sec degree, init enc
 ;;^UTILITY(U,$J,358.3,31769,1,4,0)
 ;;=4^T25.211A
 ;;^UTILITY(U,$J,358.3,31769,2)
 ;;=^5048550
 ;;^UTILITY(U,$J,358.3,31770,0)
 ;;=T25.212A^^126^1605^19
 ;;^UTILITY(U,$J,358.3,31770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31770,1,3,0)
 ;;=3^Burn of lft ankl, sec degree, init enc
 ;;^UTILITY(U,$J,358.3,31770,1,4,0)
 ;;=4^T25.212A
 ;;^UTILITY(U,$J,358.3,31770,2)
 ;;=^5048553
 ;;^UTILITY(U,$J,358.3,31771,0)
 ;;=T24.231A^^126^1605^43
 ;;^UTILITY(U,$J,358.3,31771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31771,1,3,0)
 ;;=3^Burn of rt lwr leg, sec degree, init enc
 ;;^UTILITY(U,$J,358.3,31771,1,4,0)
 ;;=4^T24.231A
 ;;^UTILITY(U,$J,358.3,31771,2)
 ;;=^5048274
 ;;^UTILITY(U,$J,358.3,31772,0)
 ;;=T24.232A^^126^1605^27
 ;;^UTILITY(U,$J,358.3,31772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31772,1,3,0)
 ;;=3^Burn of lft lwr leg, sec degree, init enc
 ;;^UTILITY(U,$J,358.3,31772,1,4,0)
 ;;=4^T24.232A
 ;;^UTILITY(U,$J,358.3,31772,2)
 ;;=^5048277
 ;;^UTILITY(U,$J,358.3,31773,0)
 ;;=T25.331A^^126^1605^47
 ;;^UTILITY(U,$J,358.3,31773,1,0)
 ;;=^358.31IA^4^2
