IBDEI1VC ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33277,1,4,0)
 ;;=4^S92.061A
 ;;^UTILITY(U,$J,358.3,33277,2)
 ;;=^5044549
 ;;^UTILITY(U,$J,358.3,33278,0)
 ;;=S92.062A^^191^1968^137
 ;;^UTILITY(U,$J,358.3,33278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33278,1,3,0)
 ;;=3^Disp intraarticular fx of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,33278,1,4,0)
 ;;=4^S92.062A
 ;;^UTILITY(U,$J,358.3,33278,2)
 ;;=^5044556
 ;;^UTILITY(U,$J,358.3,33279,0)
 ;;=S92.055A^^191^1968^250
 ;;^UTILITY(U,$J,358.3,33279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33279,1,3,0)
 ;;=3^Nondisp extrartic fx of lft calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,33279,1,4,0)
 ;;=4^S92.055A
 ;;^UTILITY(U,$J,358.3,33279,2)
 ;;=^5044535
 ;;^UTILITY(U,$J,358.3,33280,0)
 ;;=S92.054A^^191^1968^251
 ;;^UTILITY(U,$J,358.3,33280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33280,1,3,0)
 ;;=3^Nondisp extrartic fx of rt calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,33280,1,4,0)
 ;;=4^S92.054A
 ;;^UTILITY(U,$J,358.3,33280,2)
 ;;=^5044528
 ;;^UTILITY(U,$J,358.3,33281,0)
 ;;=S92.051A^^191^1968^26
 ;;^UTILITY(U,$J,358.3,33281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33281,1,3,0)
 ;;=3^Disp extrartic fx rt calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,33281,1,4,0)
 ;;=4^S92.051A
 ;;^UTILITY(U,$J,358.3,33281,2)
 ;;=^5044507
 ;;^UTILITY(U,$J,358.3,33282,0)
 ;;=S92.052A^^191^1968^25
 ;;^UTILITY(U,$J,358.3,33282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33282,1,3,0)
 ;;=3^Disp extrartic fx of lft calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,33282,1,4,0)
 ;;=4^S92.052A
 ;;^UTILITY(U,$J,358.3,33282,2)
 ;;=^5044514
 ;;^UTILITY(U,$J,358.3,33283,0)
 ;;=S92.045A^^191^1968^354
 ;;^UTILITY(U,$J,358.3,33283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33283,1,3,0)
 ;;=3^Nondisp fx of tuberosity of lft calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,33283,1,4,0)
 ;;=4^S92.045A
 ;;^UTILITY(U,$J,358.3,33283,2)
 ;;=^5137560
 ;;^UTILITY(U,$J,358.3,33284,0)
 ;;=S92.044A^^191^1968^355
 ;;^UTILITY(U,$J,358.3,33284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33284,1,3,0)
 ;;=3^Nondisp fx of tuberosity of rt calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,33284,1,4,0)
 ;;=4^S92.044A
 ;;^UTILITY(U,$J,358.3,33284,2)
 ;;=^5044500
 ;;^UTILITY(U,$J,358.3,33285,0)
 ;;=S92.041A^^191^1968^129
 ;;^UTILITY(U,$J,358.3,33285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33285,1,3,0)
 ;;=3^Disp fx of tuberosity of rt calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,33285,1,4,0)
 ;;=4^S92.041A
 ;;^UTILITY(U,$J,358.3,33285,2)
 ;;=^5044493
 ;;^UTILITY(U,$J,358.3,33286,0)
 ;;=S92.042A^^191^1968^128
 ;;^UTILITY(U,$J,358.3,33286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33286,1,3,0)
 ;;=3^Disp fx of tuberosity of lft calcaneus, oth, init
 ;;^UTILITY(U,$J,358.3,33286,1,4,0)
 ;;=4^S92.042A
 ;;^UTILITY(U,$J,358.3,33286,2)
 ;;=^5137546
 ;;^UTILITY(U,$J,358.3,33287,0)
 ;;=S92.035A^^191^1968^232
 ;;^UTILITY(U,$J,358.3,33287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33287,1,3,0)
 ;;=3^Nondisp avulsion fx of tuberosity of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,33287,1,4,0)
 ;;=4^S92.035A
 ;;^UTILITY(U,$J,358.3,33287,2)
 ;;=^5044479
 ;;^UTILITY(U,$J,358.3,33288,0)
 ;;=S92.002A^^191^1968^193
 ;;^UTILITY(U,$J,358.3,33288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33288,1,3,0)
 ;;=3^Fx of lft calcaneus, unspec, init
 ;;^UTILITY(U,$J,358.3,33288,1,4,0)
 ;;=4^S92.002A
 ;;^UTILITY(U,$J,358.3,33288,2)
 ;;=^5044360
 ;;^UTILITY(U,$J,358.3,33289,0)
 ;;=S92.011A^^191^1968^83
 ;;^UTILITY(U,$J,358.3,33289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33289,1,3,0)
 ;;=3^Disp fx of body of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,33289,1,4,0)
 ;;=4^S92.011A
