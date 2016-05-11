IBDEI1VV ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31988,1,3,0)
 ;;=3^Nondisp trimall fx of rt lwr leg, init
 ;;^UTILITY(U,$J,358.3,31988,1,4,0)
 ;;=4^S82.854A
 ;;^UTILITY(U,$J,358.3,31988,2)
 ;;=^5042623
 ;;^UTILITY(U,$J,358.3,31989,0)
 ;;=S82.852A^^126^1609^153
 ;;^UTILITY(U,$J,358.3,31989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31989,1,3,0)
 ;;=3^Disp trimall fx of lft lwr leg, init
 ;;^UTILITY(U,$J,358.3,31989,1,4,0)
 ;;=4^S82.852A
 ;;^UTILITY(U,$J,358.3,31989,2)
 ;;=^5042591
 ;;^UTILITY(U,$J,358.3,31990,0)
 ;;=S82.851A^^126^1609^154
 ;;^UTILITY(U,$J,358.3,31990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31990,1,3,0)
 ;;=3^Disp trimall fx of rt lwr leg, init
 ;;^UTILITY(U,$J,358.3,31990,1,4,0)
 ;;=4^S82.851A
 ;;^UTILITY(U,$J,358.3,31990,2)
 ;;=^5042575
 ;;^UTILITY(U,$J,358.3,31991,0)
 ;;=S82.851A^^126^1609^155
 ;;^UTILITY(U,$J,358.3,31991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31991,1,3,0)
 ;;=3^Disp trimall fx of rt lwr leg, init
 ;;^UTILITY(U,$J,358.3,31991,1,4,0)
 ;;=4^S82.851A
 ;;^UTILITY(U,$J,358.3,31991,2)
 ;;=^5042575
 ;;^UTILITY(U,$J,358.3,31992,0)
 ;;=S82.855A^^126^1609^377
 ;;^UTILITY(U,$J,358.3,31992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31992,1,3,0)
 ;;=3^Nondisp trimall fx of lft lwr leg, init
 ;;^UTILITY(U,$J,358.3,31992,1,4,0)
 ;;=4^S82.855A
 ;;^UTILITY(U,$J,358.3,31992,2)
 ;;=^5042639
 ;;^UTILITY(U,$J,358.3,31993,0)
 ;;=S92.065A^^126^1609^364
 ;;^UTILITY(U,$J,358.3,31993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31993,1,3,0)
 ;;=3^Nondisp intraarticular fx of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,31993,1,4,0)
 ;;=4^S92.065A
 ;;^UTILITY(U,$J,358.3,31993,2)
 ;;=^5044577
 ;;^UTILITY(U,$J,358.3,31994,0)
 ;;=S92.064A^^126^1609^365
 ;;^UTILITY(U,$J,358.3,31994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31994,1,3,0)
 ;;=3^Nondisp intraarticular fx of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,31994,1,4,0)
 ;;=4^S92.064A
 ;;^UTILITY(U,$J,358.3,31994,2)
 ;;=^5044570
 ;;^UTILITY(U,$J,358.3,31995,0)
 ;;=S92.061A^^126^1609^138
 ;;^UTILITY(U,$J,358.3,31995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31995,1,3,0)
 ;;=3^Disp intraarticular fx of right calcaneus, init
 ;;^UTILITY(U,$J,358.3,31995,1,4,0)
 ;;=4^S92.061A
 ;;^UTILITY(U,$J,358.3,31995,2)
 ;;=^5044549
 ;;^UTILITY(U,$J,358.3,31996,0)
 ;;=S92.062A^^126^1609^137
 ;;^UTILITY(U,$J,358.3,31996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31996,1,3,0)
 ;;=3^Disp intraarticular fx of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,31996,1,4,0)
 ;;=4^S92.062A
 ;;^UTILITY(U,$J,358.3,31996,2)
 ;;=^5044556
 ;;^UTILITY(U,$J,358.3,31997,0)
 ;;=S92.055A^^126^1609^250
 ;;^UTILITY(U,$J,358.3,31997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31997,1,3,0)
 ;;=3^Nondisp extrartic fx of lft calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,31997,1,4,0)
 ;;=4^S92.055A
 ;;^UTILITY(U,$J,358.3,31997,2)
 ;;=^5044535
 ;;^UTILITY(U,$J,358.3,31998,0)
 ;;=S92.054A^^126^1609^251
 ;;^UTILITY(U,$J,358.3,31998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31998,1,3,0)
 ;;=3^Nondisp extrartic fx of rt calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,31998,1,4,0)
 ;;=4^S92.054A
 ;;^UTILITY(U,$J,358.3,31998,2)
 ;;=^5044528
 ;;^UTILITY(U,$J,358.3,31999,0)
 ;;=S92.051A^^126^1609^26
 ;;^UTILITY(U,$J,358.3,31999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31999,1,3,0)
 ;;=3^Disp extrartic fx rt calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,31999,1,4,0)
 ;;=4^S92.051A
 ;;^UTILITY(U,$J,358.3,31999,2)
 ;;=^5044507
 ;;^UTILITY(U,$J,358.3,32000,0)
 ;;=S92.052A^^126^1609^25
 ;;^UTILITY(U,$J,358.3,32000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32000,1,3,0)
 ;;=3^Disp extrartic fx of lft calcaneus, oth, init
