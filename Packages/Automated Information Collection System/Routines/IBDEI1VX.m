IBDEI1VX ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32012,1,4,0)
 ;;=4^S92.024A
 ;;^UTILITY(U,$J,358.3,32012,2)
 ;;=^5044430
 ;;^UTILITY(U,$J,358.3,32013,0)
 ;;=S92.021A^^126^1609^80
 ;;^UTILITY(U,$J,358.3,32013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32013,1,3,0)
 ;;=3^Disp fx of anterior process of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,32013,1,4,0)
 ;;=4^S92.021A
 ;;^UTILITY(U,$J,358.3,32013,2)
 ;;=^5044409
 ;;^UTILITY(U,$J,358.3,32014,0)
 ;;=S92.022A^^126^1609^79
 ;;^UTILITY(U,$J,358.3,32014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32014,1,3,0)
 ;;=3^Disp fx of anterior process of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,32014,1,4,0)
 ;;=4^S92.022A
 ;;^UTILITY(U,$J,358.3,32014,2)
 ;;=^5044416
 ;;^UTILITY(U,$J,358.3,32015,0)
 ;;=S92.015A^^126^1609^306
 ;;^UTILITY(U,$J,358.3,32015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32015,1,3,0)
 ;;=3^Nondisp fx of body of lft calcaneus, init
 ;;^UTILITY(U,$J,358.3,32015,1,4,0)
 ;;=4^S92.015A
 ;;^UTILITY(U,$J,358.3,32015,2)
 ;;=^5044395
 ;;^UTILITY(U,$J,358.3,32016,0)
 ;;=S92.014A^^126^1609^308
 ;;^UTILITY(U,$J,358.3,32016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32016,1,3,0)
 ;;=3^Nondisp fx of body of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,32016,1,4,0)
 ;;=4^S92.014A
 ;;^UTILITY(U,$J,358.3,32016,2)
 ;;=^5044388
 ;;^UTILITY(U,$J,358.3,32017,0)
 ;;=S92.033A^^126^1609^9
 ;;^UTILITY(U,$J,358.3,32017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32017,1,3,0)
 ;;=3^Disp avulsion fx tuberosity of calcaneus, unspec, init
 ;;^UTILITY(U,$J,358.3,32017,1,4,0)
 ;;=4^S92.033A
 ;;^UTILITY(U,$J,358.3,32017,2)
 ;;=^5044465
 ;;^UTILITY(U,$J,358.3,32018,0)
 ;;=S92.034A^^126^1609^233
 ;;^UTILITY(U,$J,358.3,32018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32018,1,3,0)
 ;;=3^Nondisp avulsion fx of tuberosity of rt calcaneus, init
 ;;^UTILITY(U,$J,358.3,32018,1,4,0)
 ;;=4^S92.034A
 ;;^UTILITY(U,$J,358.3,32018,2)
 ;;=^5044472
 ;;^UTILITY(U,$J,358.3,32019,0)
 ;;=S92.902A^^126^1609^193
 ;;^UTILITY(U,$J,358.3,32019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32019,1,3,0)
 ;;=3^Fx of lft foot, unspec, init
 ;;^UTILITY(U,$J,358.3,32019,1,4,0)
 ;;=4^S92.902A
 ;;^UTILITY(U,$J,358.3,32019,2)
 ;;=^5045585
 ;;^UTILITY(U,$J,358.3,32020,0)
 ;;=S92.901A^^126^1609^211
 ;;^UTILITY(U,$J,358.3,32020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32020,1,3,0)
 ;;=3^Fx of rt ft, unspec, init
 ;;^UTILITY(U,$J,358.3,32020,1,4,0)
 ;;=4^S92.901A
 ;;^UTILITY(U,$J,358.3,32020,2)
 ;;=^5045578
 ;;^UTILITY(U,$J,358.3,32021,0)
 ;;=S92.192A^^126^1609^199
 ;;^UTILITY(U,$J,358.3,32021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32021,1,3,0)
 ;;=3^Fx of lft talus, oth, init
 ;;^UTILITY(U,$J,358.3,32021,1,4,0)
 ;;=4^S92.192A
 ;;^UTILITY(U,$J,358.3,32021,2)
 ;;=^5137581
 ;;^UTILITY(U,$J,358.3,32022,0)
 ;;=S92.191A^^126^1609^216
 ;;^UTILITY(U,$J,358.3,32022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32022,1,3,0)
 ;;=3^Fx of rt talus, oth, init
 ;;^UTILITY(U,$J,358.3,32022,1,4,0)
 ;;=4^S92.191A
 ;;^UTILITY(U,$J,358.3,32022,2)
 ;;=^5044815
 ;;^UTILITY(U,$J,358.3,32023,0)
 ;;=S92.155A^^126^1609^230
 ;;^UTILITY(U,$J,358.3,32023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32023,1,3,0)
 ;;=3^Nondisp avulsion fx (chip) of lft talus, init
 ;;^UTILITY(U,$J,358.3,32023,1,4,0)
 ;;=4^S92.155A
 ;;^UTILITY(U,$J,358.3,32023,2)
 ;;=^5044801
 ;;^UTILITY(U,$J,358.3,32024,0)
 ;;=S92.154A^^126^1609^231
 ;;^UTILITY(U,$J,358.3,32024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32024,1,3,0)
 ;;=3^Nondisp avulsion fx (chip) of rt talus, init
 ;;^UTILITY(U,$J,358.3,32024,1,4,0)
 ;;=4^S92.154A
 ;;^UTILITY(U,$J,358.3,32024,2)
 ;;=^5044794
