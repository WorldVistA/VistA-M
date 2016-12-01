IBDEI0ZZ ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47172,1,4,0)
 ;;=4^S82.851A
 ;;^UTILITY(U,$J,358.3,47172,2)
 ;;=^5042575
 ;;^UTILITY(U,$J,358.3,47173,0)
 ;;=S82.851A^^139^1984^155
 ;;^UTILITY(U,$J,358.3,47173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47173,1,3,0)
 ;;=3^Disp trimall fx of rt lwr leg, init
 ;;^UTILITY(U,$J,358.3,47173,1,4,0)
 ;;=4^S82.851A
 ;;^UTILITY(U,$J,358.3,47173,2)
 ;;=^5042575
 ;;^UTILITY(U,$J,358.3,47174,0)
 ;;=S82.855A^^139^1984^377
 ;;^UTILITY(U,$J,358.3,47174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47174,1,3,0)
 ;;=3^Nondisp trimall fx of lft lwr leg, init
 ;;^UTILITY(U,$J,358.3,47174,1,4,0)
 ;;=4^S82.855A
 ;;^UTILITY(U,$J,358.3,47174,2)
 ;;=^5042639
 ;;^UTILITY(U,$J,358.3,47175,0)
 ;;=S92.065A^^139^1984^364
 ;;^UTILITY(U,$J,358.3,47175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47175,1,3,0)
 ;;=3^Nondisp intraarticular fx of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,47175,1,4,0)
 ;;=4^S92.065A
 ;;^UTILITY(U,$J,358.3,47175,2)
 ;;=^5044577
 ;;^UTILITY(U,$J,358.3,47176,0)
 ;;=S92.064A^^139^1984^365
 ;;^UTILITY(U,$J,358.3,47176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47176,1,3,0)
 ;;=3^Nondisp intraarticular fx of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,47176,1,4,0)
 ;;=4^S92.064A
 ;;^UTILITY(U,$J,358.3,47176,2)
 ;;=^5044570
 ;;^UTILITY(U,$J,358.3,47177,0)
 ;;=S92.061A^^139^1984^138
 ;;^UTILITY(U,$J,358.3,47177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47177,1,3,0)
 ;;=3^Disp intraarticular fx of right calcaneus, init
 ;;^UTILITY(U,$J,358.3,47177,1,4,0)
 ;;=4^S92.061A
 ;;^UTILITY(U,$J,358.3,47177,2)
 ;;=^5044549
 ;;^UTILITY(U,$J,358.3,47178,0)
 ;;=S92.062A^^139^1984^137
 ;;^UTILITY(U,$J,358.3,47178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47178,1,3,0)
 ;;=3^Disp intraarticular fx of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,47178,1,4,0)
 ;;=4^S92.062A
 ;;^UTILITY(U,$J,358.3,47178,2)
 ;;=^5044556
 ;;^UTILITY(U,$J,358.3,47179,0)
 ;;=S92.055A^^139^1984^250
 ;;^UTILITY(U,$J,358.3,47179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47179,1,3,0)
 ;;=3^Nondisp extrartic fx of lft calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,47179,1,4,0)
 ;;=4^S92.055A
 ;;^UTILITY(U,$J,358.3,47179,2)
 ;;=^5044535
 ;;^UTILITY(U,$J,358.3,47180,0)
 ;;=S92.054A^^139^1984^251
 ;;^UTILITY(U,$J,358.3,47180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47180,1,3,0)
 ;;=3^Nondisp extrartic fx of rt calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,47180,1,4,0)
 ;;=4^S92.054A
 ;;^UTILITY(U,$J,358.3,47180,2)
 ;;=^5044528
 ;;^UTILITY(U,$J,358.3,47181,0)
 ;;=S92.051A^^139^1984^26
 ;;^UTILITY(U,$J,358.3,47181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47181,1,3,0)
 ;;=3^Disp extrartic fx rt calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,47181,1,4,0)
 ;;=4^S92.051A
 ;;^UTILITY(U,$J,358.3,47181,2)
 ;;=^5044507
 ;;^UTILITY(U,$J,358.3,47182,0)
 ;;=S92.052A^^139^1984^25
 ;;^UTILITY(U,$J,358.3,47182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47182,1,3,0)
 ;;=3^Disp extrartic fx of lft calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,47182,1,4,0)
 ;;=4^S92.052A
 ;;^UTILITY(U,$J,358.3,47182,2)
 ;;=^5044514
 ;;^UTILITY(U,$J,358.3,47183,0)
 ;;=S92.045A^^139^1984^354
 ;;^UTILITY(U,$J,358.3,47183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47183,1,3,0)
 ;;=3^Nondisp fx of tuberosity of lft calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,47183,1,4,0)
 ;;=4^S92.045A
 ;;^UTILITY(U,$J,358.3,47183,2)
 ;;=^5137560
 ;;^UTILITY(U,$J,358.3,47184,0)
 ;;=S92.044A^^139^1984^355
 ;;^UTILITY(U,$J,358.3,47184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47184,1,3,0)
 ;;=3^Nondisp fx of tuberosity of rt calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,47184,1,4,0)
 ;;=4^S92.044A
 ;;^UTILITY(U,$J,358.3,47184,2)
 ;;=^5044500
 ;;^UTILITY(U,$J,358.3,47185,0)
 ;;=S92.041A^^139^1984^129
 ;;^UTILITY(U,$J,358.3,47185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47185,1,3,0)
 ;;=3^Disp fx of tuberosity of rt calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,47185,1,4,0)
 ;;=4^S92.041A
 ;;^UTILITY(U,$J,358.3,47185,2)
 ;;=^5044493
 ;;^UTILITY(U,$J,358.3,47186,0)
 ;;=S92.042A^^139^1984^128
 ;;^UTILITY(U,$J,358.3,47186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47186,1,3,0)
 ;;=3^Disp fx of tuberosity of lft calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,47186,1,4,0)
 ;;=4^S92.042A
 ;;^UTILITY(U,$J,358.3,47186,2)
 ;;=^5137546
 ;;^UTILITY(U,$J,358.3,47187,0)
 ;;=S92.035A^^139^1984^232
 ;;^UTILITY(U,$J,358.3,47187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47187,1,3,0)
 ;;=3^Nondisp avulsion fx of tuberosity of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,47187,1,4,0)
 ;;=4^S92.035A
 ;;^UTILITY(U,$J,358.3,47187,2)
 ;;=^5044479
 ;;^UTILITY(U,$J,358.3,47188,0)
 ;;=S92.002A^^139^1984^192
 ;;^UTILITY(U,$J,358.3,47188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47188,1,3,0)
 ;;=3^Fx of lft calcaneus, unspec, init
 ;;^UTILITY(U,$J,358.3,47188,1,4,0)
 ;;=4^S92.002A
 ;;^UTILITY(U,$J,358.3,47188,2)
 ;;=^5044360
 ;;^UTILITY(U,$J,358.3,47189,0)
 ;;=S92.011A^^139^1984^83
 ;;^UTILITY(U,$J,358.3,47189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47189,1,3,0)
 ;;=3^Disp fx of body of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,47189,1,4,0)
 ;;=4^S92.011A
 ;;^UTILITY(U,$J,358.3,47189,2)
 ;;=^5044367
 ;;^UTILITY(U,$J,358.3,47190,0)
 ;;=S92.012A^^139^1984^81
 ;;^UTILITY(U,$J,358.3,47190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47190,1,3,0)
 ;;=3^Disp fx of body of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,47190,1,4,0)
 ;;=4^S92.012A
 ;;^UTILITY(U,$J,358.3,47190,2)
 ;;=^5044374
 ;;^UTILITY(U,$J,358.3,47191,0)
 ;;=S92.031A^^139^1984^11
 ;;^UTILITY(U,$J,358.3,47191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47191,1,3,0)
 ;;=3^Disp avulsion fx tubersotiy of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,47191,1,4,0)
 ;;=4^S92.031A
 ;;^UTILITY(U,$J,358.3,47191,2)
 ;;=^5044451
 ;;^UTILITY(U,$J,358.3,47192,0)
 ;;=S92.032A^^139^1984^10
 ;;^UTILITY(U,$J,358.3,47192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47192,1,3,0)
 ;;=3^Disp avulsion fx tuberosity of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,47192,1,4,0)
 ;;=4^S92.032A
 ;;^UTILITY(U,$J,358.3,47192,2)
 ;;=^5044458
 ;;^UTILITY(U,$J,358.3,47193,0)
 ;;=S92.025A^^139^1984^304
 ;;^UTILITY(U,$J,358.3,47193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47193,1,3,0)
 ;;=3^Nondisp fx of anterior process of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,47193,1,4,0)
 ;;=4^S92.025A
 ;;^UTILITY(U,$J,358.3,47193,2)
 ;;=^5044437
 ;;^UTILITY(U,$J,358.3,47194,0)
 ;;=S92.024A^^139^1984^305
 ;;^UTILITY(U,$J,358.3,47194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47194,1,3,0)
 ;;=3^Nondisp fx of anterior process of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,47194,1,4,0)
 ;;=4^S92.024A
 ;;^UTILITY(U,$J,358.3,47194,2)
 ;;=^5044430
 ;;^UTILITY(U,$J,358.3,47195,0)
 ;;=S92.021A^^139^1984^80
 ;;^UTILITY(U,$J,358.3,47195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47195,1,3,0)
 ;;=3^Disp fx of anterior process of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,47195,1,4,0)
 ;;=4^S92.021A
 ;;^UTILITY(U,$J,358.3,47195,2)
 ;;=^5044409
 ;;^UTILITY(U,$J,358.3,47196,0)
 ;;=S92.022A^^139^1984^79
 ;;^UTILITY(U,$J,358.3,47196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47196,1,3,0)
 ;;=3^Disp fx of anterior process of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,47196,1,4,0)
 ;;=4^S92.022A
 ;;^UTILITY(U,$J,358.3,47196,2)
 ;;=^5044416
 ;;^UTILITY(U,$J,358.3,47197,0)
 ;;=S92.015A^^139^1984^306
 ;;^UTILITY(U,$J,358.3,47197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47197,1,3,0)
 ;;=3^Nondisp fx of body of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,47197,1,4,0)
 ;;=4^S92.015A
 ;;^UTILITY(U,$J,358.3,47197,2)
 ;;=^5044395
 ;;^UTILITY(U,$J,358.3,47198,0)
 ;;=S92.014A^^139^1984^308
 ;;^UTILITY(U,$J,358.3,47198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47198,1,3,0)
 ;;=3^Nondisp fx of body of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,47198,1,4,0)
 ;;=4^S92.014A
 ;;^UTILITY(U,$J,358.3,47198,2)
 ;;=^5044388
 ;;^UTILITY(U,$J,358.3,47199,0)
 ;;=S92.033A^^139^1984^9
 ;;^UTILITY(U,$J,358.3,47199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47199,1,3,0)
 ;;=3^Disp avulsion fx tuberosity of calcaneus, unspec, init
 ;;^UTILITY(U,$J,358.3,47199,1,4,0)
 ;;=4^S92.033A
 ;;^UTILITY(U,$J,358.3,47199,2)
 ;;=^5044465
 ;;^UTILITY(U,$J,358.3,47200,0)
 ;;=S92.034A^^139^1984^233
 ;;^UTILITY(U,$J,358.3,47200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47200,1,3,0)
 ;;=3^Nondisp avulsion fx of tuberosity of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,47200,1,4,0)
 ;;=4^S92.034A
 ;;^UTILITY(U,$J,358.3,47200,2)
 ;;=^5044472
 ;;^UTILITY(U,$J,358.3,47201,0)
 ;;=S92.902A^^139^1984^193
 ;;^UTILITY(U,$J,358.3,47201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47201,1,3,0)
 ;;=3^Fx of lft foot, unspec, init
 ;;^UTILITY(U,$J,358.3,47201,1,4,0)
 ;;=4^S92.902A
 ;;^UTILITY(U,$J,358.3,47201,2)
 ;;=^5045585
 ;;^UTILITY(U,$J,358.3,47202,0)
 ;;=S92.901A^^139^1984^211
 ;;^UTILITY(U,$J,358.3,47202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47202,1,3,0)
 ;;=3^Fx of rt ft, unspec, init
 ;;^UTILITY(U,$J,358.3,47202,1,4,0)
 ;;=4^S92.901A
 ;;^UTILITY(U,$J,358.3,47202,2)
 ;;=^5045578
 ;;^UTILITY(U,$J,358.3,47203,0)
 ;;=S92.192A^^139^1984^199
 ;;^UTILITY(U,$J,358.3,47203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47203,1,3,0)
 ;;=3^Fx of lft talus, oth, init
 ;;^UTILITY(U,$J,358.3,47203,1,4,0)
 ;;=4^S92.192A
 ;;^UTILITY(U,$J,358.3,47203,2)
 ;;=^5137581
 ;;^UTILITY(U,$J,358.3,47204,0)
 ;;=S92.191A^^139^1984^216
 ;;^UTILITY(U,$J,358.3,47204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47204,1,3,0)
 ;;=3^Fx of rt talus, oth, init
 ;;^UTILITY(U,$J,358.3,47204,1,4,0)
 ;;=4^S92.191A
 ;;^UTILITY(U,$J,358.3,47204,2)
 ;;=^5044815
 ;;^UTILITY(U,$J,358.3,47205,0)
 ;;=S92.155A^^139^1984^230
 ;;^UTILITY(U,$J,358.3,47205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47205,1,3,0)
 ;;=3^Nondisp avulsion fx (chip) of lft talus, init
 ;;^UTILITY(U,$J,358.3,47205,1,4,0)
 ;;=4^S92.155A
 ;;^UTILITY(U,$J,358.3,47205,2)
 ;;=^5044801
