IBDEI2IP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42251,1,4,0)
 ;;=4^S92.035A
 ;;^UTILITY(U,$J,358.3,42251,2)
 ;;=^5044479
 ;;^UTILITY(U,$J,358.3,42252,0)
 ;;=S92.002A^^192^2137^192
 ;;^UTILITY(U,$J,358.3,42252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42252,1,3,0)
 ;;=3^Fx of lft calcaneus, unspec, init
 ;;^UTILITY(U,$J,358.3,42252,1,4,0)
 ;;=4^S92.002A
 ;;^UTILITY(U,$J,358.3,42252,2)
 ;;=^5044360
 ;;^UTILITY(U,$J,358.3,42253,0)
 ;;=S92.011A^^192^2137^83
 ;;^UTILITY(U,$J,358.3,42253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42253,1,3,0)
 ;;=3^Disp fx of body of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,42253,1,4,0)
 ;;=4^S92.011A
 ;;^UTILITY(U,$J,358.3,42253,2)
 ;;=^5044367
 ;;^UTILITY(U,$J,358.3,42254,0)
 ;;=S92.012A^^192^2137^81
 ;;^UTILITY(U,$J,358.3,42254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42254,1,3,0)
 ;;=3^Disp fx of body of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,42254,1,4,0)
 ;;=4^S92.012A
 ;;^UTILITY(U,$J,358.3,42254,2)
 ;;=^5044374
 ;;^UTILITY(U,$J,358.3,42255,0)
 ;;=S92.031A^^192^2137^11
 ;;^UTILITY(U,$J,358.3,42255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42255,1,3,0)
 ;;=3^Disp avulsion fx tubersotiy of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,42255,1,4,0)
 ;;=4^S92.031A
 ;;^UTILITY(U,$J,358.3,42255,2)
 ;;=^5044451
 ;;^UTILITY(U,$J,358.3,42256,0)
 ;;=S92.032A^^192^2137^10
 ;;^UTILITY(U,$J,358.3,42256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42256,1,3,0)
 ;;=3^Disp avulsion fx tuberosity of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,42256,1,4,0)
 ;;=4^S92.032A
 ;;^UTILITY(U,$J,358.3,42256,2)
 ;;=^5044458
 ;;^UTILITY(U,$J,358.3,42257,0)
 ;;=S92.025A^^192^2137^304
 ;;^UTILITY(U,$J,358.3,42257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42257,1,3,0)
 ;;=3^Nondisp fx of anterior process of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,42257,1,4,0)
 ;;=4^S92.025A
 ;;^UTILITY(U,$J,358.3,42257,2)
 ;;=^5044437
 ;;^UTILITY(U,$J,358.3,42258,0)
 ;;=S92.024A^^192^2137^305
 ;;^UTILITY(U,$J,358.3,42258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42258,1,3,0)
 ;;=3^Nondisp fx of anterior process of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,42258,1,4,0)
 ;;=4^S92.024A
 ;;^UTILITY(U,$J,358.3,42258,2)
 ;;=^5044430
 ;;^UTILITY(U,$J,358.3,42259,0)
 ;;=S92.021A^^192^2137^80
 ;;^UTILITY(U,$J,358.3,42259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42259,1,3,0)
 ;;=3^Disp fx of anterior process of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,42259,1,4,0)
 ;;=4^S92.021A
 ;;^UTILITY(U,$J,358.3,42259,2)
 ;;=^5044409
 ;;^UTILITY(U,$J,358.3,42260,0)
 ;;=S92.022A^^192^2137^79
 ;;^UTILITY(U,$J,358.3,42260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42260,1,3,0)
 ;;=3^Disp fx of anterior process of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,42260,1,4,0)
 ;;=4^S92.022A
 ;;^UTILITY(U,$J,358.3,42260,2)
 ;;=^5044416
 ;;^UTILITY(U,$J,358.3,42261,0)
 ;;=S92.015A^^192^2137^306
 ;;^UTILITY(U,$J,358.3,42261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42261,1,3,0)
 ;;=3^Nondisp fx of body of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,42261,1,4,0)
 ;;=4^S92.015A
 ;;^UTILITY(U,$J,358.3,42261,2)
 ;;=^5044395
 ;;^UTILITY(U,$J,358.3,42262,0)
 ;;=S92.014A^^192^2137^308
 ;;^UTILITY(U,$J,358.3,42262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42262,1,3,0)
 ;;=3^Nondisp fx of body of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,42262,1,4,0)
 ;;=4^S92.014A
 ;;^UTILITY(U,$J,358.3,42262,2)
 ;;=^5044388
 ;;^UTILITY(U,$J,358.3,42263,0)
 ;;=S92.033A^^192^2137^9
 ;;^UTILITY(U,$J,358.3,42263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42263,1,3,0)
 ;;=3^Disp avulsion fx tuberosity of calcaneus, unspec, init
 ;;^UTILITY(U,$J,358.3,42263,1,4,0)
 ;;=4^S92.033A
