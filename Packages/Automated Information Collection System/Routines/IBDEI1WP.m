IBDEI1WP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32349,1,3,0)
 ;;=3^Stress fx lft toe(s), subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32349,1,4,0)
 ;;=4^M84.378K
 ;;^UTILITY(U,$J,358.3,32349,2)
 ;;=^5013779
 ;;^UTILITY(U,$J,358.3,32350,0)
 ;;=M84.377K^^126^1609^424
 ;;^UTILITY(U,$J,358.3,32350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32350,1,3,0)
 ;;=3^Stress fx rt toe(s), subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32350,1,4,0)
 ;;=4^M84.377K
 ;;^UTILITY(U,$J,358.3,32350,2)
 ;;=^5013773
 ;;^UTILITY(U,$J,358.3,32351,0)
 ;;=M84.375K^^126^1609^421
 ;;^UTILITY(U,$J,358.3,32351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32351,1,3,0)
 ;;=3^Stress fx lft ft, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32351,1,4,0)
 ;;=4^M84.375K
 ;;^UTILITY(U,$J,358.3,32351,2)
 ;;=^5013761
 ;;^UTILITY(U,$J,358.3,32352,0)
 ;;=M84.374K^^126^1609^423
 ;;^UTILITY(U,$J,358.3,32352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32352,1,3,0)
 ;;=3^Stress fx rt ft, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32352,1,4,0)
 ;;=4^M84.374K
 ;;^UTILITY(U,$J,358.3,32352,2)
 ;;=^5013755
 ;;^UTILITY(U,$J,358.3,32353,0)
 ;;=M84.475K^^126^1609^403
 ;;^UTILITY(U,$J,358.3,32353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32353,1,3,0)
 ;;=3^Path fx lft ft, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32353,1,4,0)
 ;;=4^M84.475K
 ;;^UTILITY(U,$J,358.3,32353,2)
 ;;=^5013989
 ;;^UTILITY(U,$J,358.3,32354,0)
 ;;=M84.474K^^126^1609^416
 ;;^UTILITY(U,$J,358.3,32354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32354,1,3,0)
 ;;=3^Path fx rt ft, sub w/ nonunion
 ;;^UTILITY(U,$J,358.3,32354,1,4,0)
 ;;=4^M84.474K
 ;;^UTILITY(U,$J,358.3,32354,2)
 ;;=^5013983
 ;;^UTILITY(U,$J,358.3,32355,0)
 ;;=M84.472K^^126^1609^398
 ;;^UTILITY(U,$J,358.3,32355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32355,1,3,0)
 ;;=3^Path fx lft ankl, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32355,1,4,0)
 ;;=4^M84.472K
 ;;^UTILITY(U,$J,358.3,32355,2)
 ;;=^5013971
 ;;^UTILITY(U,$J,358.3,32356,0)
 ;;=M84.471K^^126^1609^412
 ;;^UTILITY(U,$J,358.3,32356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32356,1,3,0)
 ;;=3^Path fx rt ankl, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32356,1,4,0)
 ;;=4^M84.471K
 ;;^UTILITY(U,$J,358.3,32356,2)
 ;;=^5013965
 ;;^UTILITY(U,$J,358.3,32357,0)
 ;;=M84.571K^^126^1609^387
 ;;^UTILITY(U,$J,358.3,32357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32357,1,3,0)
 ;;=3^Path fx in neopl dis rt ankl, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32357,1,4,0)
 ;;=4^M84.571K
 ;;^UTILITY(U,$J,358.3,32357,2)
 ;;=^5014175
 ;;^UTILITY(U,$J,358.3,32358,0)
 ;;=M84.575K^^126^1609^386
 ;;^UTILITY(U,$J,358.3,32358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32358,1,3,0)
 ;;=3^Path fx in neopl dis lft ft, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32358,1,4,0)
 ;;=4^M84.575K
 ;;^UTILITY(U,$J,358.3,32358,2)
 ;;=^5014199
 ;;^UTILITY(U,$J,358.3,32359,0)
 ;;=M84.574K^^126^1609^388
 ;;^UTILITY(U,$J,358.3,32359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32359,1,3,0)
 ;;=3^Path fx in neopl dis rt ft, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32359,1,4,0)
 ;;=4^M84.574K
 ;;^UTILITY(U,$J,358.3,32359,2)
 ;;=^5014193
 ;;^UTILITY(U,$J,358.3,32360,0)
 ;;=M84.478K^^126^1609^406
 ;;^UTILITY(U,$J,358.3,32360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32360,1,3,0)
 ;;=3^Path fx lft toe(s), subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32360,1,4,0)
 ;;=4^M84.478K
 ;;^UTILITY(U,$J,358.3,32360,2)
 ;;=^5014007
 ;;^UTILITY(U,$J,358.3,32361,0)
 ;;=M84.477K^^126^1609^419
 ;;^UTILITY(U,$J,358.3,32361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32361,1,3,0)
 ;;=3^Path fx rt toe(s), subs w/ nonunion
