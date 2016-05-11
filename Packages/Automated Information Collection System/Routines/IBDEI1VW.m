IBDEI1VW ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32000,1,4,0)
 ;;=4^S92.052A
 ;;^UTILITY(U,$J,358.3,32000,2)
 ;;=^5044514
 ;;^UTILITY(U,$J,358.3,32001,0)
 ;;=S92.045A^^126^1609^354
 ;;^UTILITY(U,$J,358.3,32001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32001,1,3,0)
 ;;=3^Nondisp fx of tuberosity of lft calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,32001,1,4,0)
 ;;=4^S92.045A
 ;;^UTILITY(U,$J,358.3,32001,2)
 ;;=^5137560
 ;;^UTILITY(U,$J,358.3,32002,0)
 ;;=S92.044A^^126^1609^355
 ;;^UTILITY(U,$J,358.3,32002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32002,1,3,0)
 ;;=3^Nondisp fx of tuberosity of rt calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,32002,1,4,0)
 ;;=4^S92.044A
 ;;^UTILITY(U,$J,358.3,32002,2)
 ;;=^5044500
 ;;^UTILITY(U,$J,358.3,32003,0)
 ;;=S92.041A^^126^1609^129
 ;;^UTILITY(U,$J,358.3,32003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32003,1,3,0)
 ;;=3^Disp fx of tuberosity of rt calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,32003,1,4,0)
 ;;=4^S92.041A
 ;;^UTILITY(U,$J,358.3,32003,2)
 ;;=^5044493
 ;;^UTILITY(U,$J,358.3,32004,0)
 ;;=S92.042A^^126^1609^128
 ;;^UTILITY(U,$J,358.3,32004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32004,1,3,0)
 ;;=3^Disp fx of tuberosity of lft calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,32004,1,4,0)
 ;;=4^S92.042A
 ;;^UTILITY(U,$J,358.3,32004,2)
 ;;=^5137546
 ;;^UTILITY(U,$J,358.3,32005,0)
 ;;=S92.035A^^126^1609^232
 ;;^UTILITY(U,$J,358.3,32005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32005,1,3,0)
 ;;=3^Nondisp avulsion fx of tuberosity of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,32005,1,4,0)
 ;;=4^S92.035A
 ;;^UTILITY(U,$J,358.3,32005,2)
 ;;=^5044479
 ;;^UTILITY(U,$J,358.3,32006,0)
 ;;=S92.002A^^126^1609^192
 ;;^UTILITY(U,$J,358.3,32006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32006,1,3,0)
 ;;=3^Fx of lft calcaneus, unspec, init
 ;;^UTILITY(U,$J,358.3,32006,1,4,0)
 ;;=4^S92.002A
 ;;^UTILITY(U,$J,358.3,32006,2)
 ;;=^5044360
 ;;^UTILITY(U,$J,358.3,32007,0)
 ;;=S92.011A^^126^1609^83
 ;;^UTILITY(U,$J,358.3,32007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32007,1,3,0)
 ;;=3^Disp fx of body of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,32007,1,4,0)
 ;;=4^S92.011A
 ;;^UTILITY(U,$J,358.3,32007,2)
 ;;=^5044367
 ;;^UTILITY(U,$J,358.3,32008,0)
 ;;=S92.012A^^126^1609^81
 ;;^UTILITY(U,$J,358.3,32008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32008,1,3,0)
 ;;=3^Disp fx of body of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,32008,1,4,0)
 ;;=4^S92.012A
 ;;^UTILITY(U,$J,358.3,32008,2)
 ;;=^5044374
 ;;^UTILITY(U,$J,358.3,32009,0)
 ;;=S92.031A^^126^1609^11
 ;;^UTILITY(U,$J,358.3,32009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32009,1,3,0)
 ;;=3^Disp avulsion fx tubersotiy of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,32009,1,4,0)
 ;;=4^S92.031A
 ;;^UTILITY(U,$J,358.3,32009,2)
 ;;=^5044451
 ;;^UTILITY(U,$J,358.3,32010,0)
 ;;=S92.032A^^126^1609^10
 ;;^UTILITY(U,$J,358.3,32010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32010,1,3,0)
 ;;=3^Disp avulsion fx tuberosity of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,32010,1,4,0)
 ;;=4^S92.032A
 ;;^UTILITY(U,$J,358.3,32010,2)
 ;;=^5044458
 ;;^UTILITY(U,$J,358.3,32011,0)
 ;;=S92.025A^^126^1609^304
 ;;^UTILITY(U,$J,358.3,32011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32011,1,3,0)
 ;;=3^Nondisp fx of anterior process of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,32011,1,4,0)
 ;;=4^S92.025A
 ;;^UTILITY(U,$J,358.3,32011,2)
 ;;=^5044437
 ;;^UTILITY(U,$J,358.3,32012,0)
 ;;=S92.024A^^126^1609^305
 ;;^UTILITY(U,$J,358.3,32012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32012,1,3,0)
 ;;=3^Nondisp fx of anterior process of rt calcaneus, init
