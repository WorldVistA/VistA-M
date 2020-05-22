IBDEI2DB ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37798,0)
 ;;=S82.54XM^^146^1917^281
 ;;^UTILITY(U,$J,358.3,37798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37798,1,3,0)
 ;;=3^Nondisp fx med mall rt tib, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,37798,1,4,0)
 ;;=4^S82.54XM
 ;;^UTILITY(U,$J,358.3,37798,2)
 ;;=^5042273
 ;;^UTILITY(U,$J,358.3,37799,0)
 ;;=S82.54XK^^146^1917^279
 ;;^UTILITY(U,$J,358.3,37799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37799,1,3,0)
 ;;=3^Nondisp fx med mall rt tib, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,37799,1,4,0)
 ;;=4^S82.54XK
 ;;^UTILITY(U,$J,358.3,37799,2)
 ;;=^5042272
 ;;^UTILITY(U,$J,358.3,37800,0)
 ;;=S82.52XN^^146^1917^50
 ;;^UTILITY(U,$J,358.3,37800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37800,1,3,0)
 ;;=3^Disp fx med mal lft tib, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,37800,1,4,0)
 ;;=4^S82.52XN
 ;;^UTILITY(U,$J,358.3,37800,2)
 ;;=^5042242
 ;;^UTILITY(U,$J,358.3,37801,0)
 ;;=S82.52XM^^146^1917^54
 ;;^UTILITY(U,$J,358.3,37801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37801,1,3,0)
 ;;=3^Disp fx med mallft tib, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,37801,1,4,0)
 ;;=4^S82.52XM
 ;;^UTILITY(U,$J,358.3,37801,2)
 ;;=^5042241
 ;;^UTILITY(U,$J,358.3,37802,0)
 ;;=S82.52XK^^146^1917^51
 ;;^UTILITY(U,$J,358.3,37802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37802,1,3,0)
 ;;=3^Disp fx med mall lft tib, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,37802,1,4,0)
 ;;=4^S82.52XK
 ;;^UTILITY(U,$J,358.3,37802,2)
 ;;=^5042240
 ;;^UTILITY(U,$J,358.3,37803,0)
 ;;=S82.51XN^^146^1917^52
 ;;^UTILITY(U,$J,358.3,37803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37803,1,3,0)
 ;;=3^Disp fx med mall rt tib, subs for opn fx type IIIA/B/C w/ nonunion
 ;;^UTILITY(U,$J,358.3,37803,1,4,0)
 ;;=4^S82.51XN
 ;;^UTILITY(U,$J,358.3,37803,2)
 ;;=^5042226
 ;;^UTILITY(U,$J,358.3,37804,0)
 ;;=S82.51XM^^146^1917^53
 ;;^UTILITY(U,$J,358.3,37804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37804,1,3,0)
 ;;=3^Disp fx med mall rt tib, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,37804,1,4,0)
 ;;=4^S82.51XM
 ;;^UTILITY(U,$J,358.3,37804,2)
 ;;=^5042225
 ;;^UTILITY(U,$J,358.3,37805,0)
 ;;=S82.51XK^^146^1917^103
 ;;^UTILITY(U,$J,358.3,37805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37805,1,3,0)
 ;;=3^Disp fx of med mall rt tib, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,37805,1,4,0)
 ;;=4^S82.51XK
 ;;^UTILITY(U,$J,358.3,37805,2)
 ;;=^5042224
 ;;^UTILITY(U,$J,358.3,37806,0)
 ;;=M84.378K^^146^1917^446
 ;;^UTILITY(U,$J,358.3,37806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37806,1,3,0)
 ;;=3^Stress fx lft toe(s), subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,37806,1,4,0)
 ;;=4^M84.378K
 ;;^UTILITY(U,$J,358.3,37806,2)
 ;;=^5013779
 ;;^UTILITY(U,$J,358.3,37807,0)
 ;;=M84.377K^^146^1917^448
 ;;^UTILITY(U,$J,358.3,37807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37807,1,3,0)
 ;;=3^Stress fx rt toe(s), subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,37807,1,4,0)
 ;;=4^M84.377K
 ;;^UTILITY(U,$J,358.3,37807,2)
 ;;=^5013773
 ;;^UTILITY(U,$J,358.3,37808,0)
 ;;=M84.375K^^146^1917^445
 ;;^UTILITY(U,$J,358.3,37808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37808,1,3,0)
 ;;=3^Stress fx lft ft, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,37808,1,4,0)
 ;;=4^M84.375K
 ;;^UTILITY(U,$J,358.3,37808,2)
 ;;=^5013761
 ;;^UTILITY(U,$J,358.3,37809,0)
 ;;=M84.374K^^146^1917^447
