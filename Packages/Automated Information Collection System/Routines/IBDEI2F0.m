IBDEI2F0 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40557,1,4,0)
 ;;=4^T25.011A
 ;;^UTILITY(U,$J,358.3,40557,2)
 ;;=^5048490
 ;;^UTILITY(U,$J,358.3,40558,0)
 ;;=T25.012A^^189^2082^21
 ;;^UTILITY(U,$J,358.3,40558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40558,1,3,0)
 ;;=3^Burn of lft ankl, unspec degree, init enc
 ;;^UTILITY(U,$J,358.3,40558,1,4,0)
 ;;=4^T25.012A
 ;;^UTILITY(U,$J,358.3,40558,2)
 ;;=^5048493
 ;;^UTILITY(U,$J,358.3,40559,0)
 ;;=T24.031A^^189^2082^45
 ;;^UTILITY(U,$J,358.3,40559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40559,1,3,0)
 ;;=3^Burn of rt lwr leg, unspec degree, init enc
 ;;^UTILITY(U,$J,358.3,40559,1,4,0)
 ;;=4^T24.031A
 ;;^UTILITY(U,$J,358.3,40559,2)
 ;;=^5048196
 ;;^UTILITY(U,$J,358.3,40560,0)
 ;;=T24.032A^^189^2082^29
 ;;^UTILITY(U,$J,358.3,40560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40560,1,3,0)
 ;;=3^Burn of lft lwr leg, unspec degree, init enc
 ;;^UTILITY(U,$J,358.3,40560,1,4,0)
 ;;=4^T24.032A
 ;;^UTILITY(U,$J,358.3,40560,2)
 ;;=^5048199
 ;;^UTILITY(U,$J,358.3,40561,0)
 ;;=E53.8^^189^2082^1
 ;;^UTILITY(U,$J,358.3,40561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40561,1,3,0)
 ;;=3^B Group Vitamin Deficiency NEC
 ;;^UTILITY(U,$J,358.3,40561,1,4,0)
 ;;=4^E53.8
 ;;^UTILITY(U,$J,358.3,40561,2)
 ;;=^5002797
 ;;^UTILITY(U,$J,358.3,40562,0)
 ;;=T25.131A^^189^2082^48
 ;;^UTILITY(U,$J,358.3,40562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40562,1,3,0)
 ;;=3^Burn of rt toe(s)(nail), first degree, init enc
 ;;^UTILITY(U,$J,358.3,40562,1,4,0)
 ;;=4^T25.131A
 ;;^UTILITY(U,$J,358.3,40562,2)
 ;;=^5048532
 ;;^UTILITY(U,$J,358.3,40563,0)
 ;;=T25.132A^^189^2082^32
 ;;^UTILITY(U,$J,358.3,40563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40563,1,3,0)
 ;;=3^Burn of lft toe(s)(nail), first degree, init enc
 ;;^UTILITY(U,$J,358.3,40563,1,4,0)
 ;;=4^T25.132A
 ;;^UTILITY(U,$J,358.3,40563,2)
 ;;=^5048535
 ;;^UTILITY(U,$J,358.3,40564,0)
 ;;=T25.121A^^189^2082^38
 ;;^UTILITY(U,$J,358.3,40564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40564,1,3,0)
 ;;=3^Burn of rt foot, first degree, init enc
 ;;^UTILITY(U,$J,358.3,40564,1,4,0)
 ;;=4^T25.121A
 ;;^UTILITY(U,$J,358.3,40564,2)
 ;;=^5048523
 ;;^UTILITY(U,$J,358.3,40565,0)
 ;;=T25.122A^^189^2082^22
 ;;^UTILITY(U,$J,358.3,40565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40565,1,3,0)
 ;;=3^Burn of lft ft, first degree, init enc
 ;;^UTILITY(U,$J,358.3,40565,1,4,0)
 ;;=4^T25.122A
 ;;^UTILITY(U,$J,358.3,40565,2)
 ;;=^5048526
 ;;^UTILITY(U,$J,358.3,40566,0)
 ;;=T25.111A^^189^2082^34
 ;;^UTILITY(U,$J,358.3,40566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40566,1,3,0)
 ;;=3^Burn of rt ankl, first degree, init enc
 ;;^UTILITY(U,$J,358.3,40566,1,4,0)
 ;;=4^T25.111A
 ;;^UTILITY(U,$J,358.3,40566,2)
 ;;=^5048514
 ;;^UTILITY(U,$J,358.3,40567,0)
 ;;=T25.112A^^189^2082^18
 ;;^UTILITY(U,$J,358.3,40567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40567,1,3,0)
 ;;=3^Burn of lft ankl, first degree, init enc
 ;;^UTILITY(U,$J,358.3,40567,1,4,0)
 ;;=4^T25.112A
 ;;^UTILITY(U,$J,358.3,40567,2)
 ;;=^5048517
 ;;^UTILITY(U,$J,358.3,40568,0)
 ;;=T24.131A^^189^2082^42
 ;;^UTILITY(U,$J,358.3,40568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40568,1,3,0)
 ;;=3^Burn of rt lwr leg, first degree, init enc
 ;;^UTILITY(U,$J,358.3,40568,1,4,0)
 ;;=4^T24.131A
 ;;^UTILITY(U,$J,358.3,40568,2)
 ;;=^5048232
 ;;^UTILITY(U,$J,358.3,40569,0)
 ;;=T24.132A^^189^2082^26
 ;;^UTILITY(U,$J,358.3,40569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40569,1,3,0)
 ;;=3^Burn of lft lwr leg, first degree, init enc
 ;;^UTILITY(U,$J,358.3,40569,1,4,0)
 ;;=4^T24.132A
 ;;^UTILITY(U,$J,358.3,40569,2)
 ;;=^5048235
