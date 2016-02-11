IBDEI2GC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41146,1,3,0)
 ;;=3^Nondisp fx med mall rt tib, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,41146,1,4,0)
 ;;=4^S82.54XM
 ;;^UTILITY(U,$J,358.3,41146,2)
 ;;=^5042273
 ;;^UTILITY(U,$J,358.3,41147,0)
 ;;=S82.54XK^^189^2086^279
 ;;^UTILITY(U,$J,358.3,41147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41147,1,3,0)
 ;;=3^Nondisp fx med mall rt tib, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,41147,1,4,0)
 ;;=4^S82.54XK
 ;;^UTILITY(U,$J,358.3,41147,2)
 ;;=^5042272
 ;;^UTILITY(U,$J,358.3,41148,0)
 ;;=S82.52XN^^189^2086^50
 ;;^UTILITY(U,$J,358.3,41148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41148,1,3,0)
 ;;=3^Disp fx med mal lft tib, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,41148,1,4,0)
 ;;=4^S82.52XN
 ;;^UTILITY(U,$J,358.3,41148,2)
 ;;=^5042242
 ;;^UTILITY(U,$J,358.3,41149,0)
 ;;=S82.52XM^^189^2086^54
 ;;^UTILITY(U,$J,358.3,41149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41149,1,3,0)
 ;;=3^Disp fx med mallft tib, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,41149,1,4,0)
 ;;=4^S82.52XM
 ;;^UTILITY(U,$J,358.3,41149,2)
 ;;=^5042241
 ;;^UTILITY(U,$J,358.3,41150,0)
 ;;=S82.52XK^^189^2086^51
 ;;^UTILITY(U,$J,358.3,41150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41150,1,3,0)
 ;;=3^Disp fx med mall lft tib, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,41150,1,4,0)
 ;;=4^S82.52XK
 ;;^UTILITY(U,$J,358.3,41150,2)
 ;;=^5042240
 ;;^UTILITY(U,$J,358.3,41151,0)
 ;;=S82.51XN^^189^2086^52
 ;;^UTILITY(U,$J,358.3,41151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41151,1,3,0)
 ;;=3^Disp fx med mall rt tib, subs for opn fx type IIIA/B/C w/ nonunion
 ;;^UTILITY(U,$J,358.3,41151,1,4,0)
 ;;=4^S82.51XN
 ;;^UTILITY(U,$J,358.3,41151,2)
 ;;=^5042226
 ;;^UTILITY(U,$J,358.3,41152,0)
 ;;=S82.51XM^^189^2086^53
 ;;^UTILITY(U,$J,358.3,41152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41152,1,3,0)
 ;;=3^Disp fx med mall rt tib, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,41152,1,4,0)
 ;;=4^S82.51XM
 ;;^UTILITY(U,$J,358.3,41152,2)
 ;;=^5042225
 ;;^UTILITY(U,$J,358.3,41153,0)
 ;;=S82.51XK^^189^2086^103
 ;;^UTILITY(U,$J,358.3,41153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41153,1,3,0)
 ;;=3^Disp fx of med mall rt tib, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,41153,1,4,0)
 ;;=4^S82.51XK
 ;;^UTILITY(U,$J,358.3,41153,2)
 ;;=^5042224
 ;;^UTILITY(U,$J,358.3,41154,0)
 ;;=M84.378K^^189^2086^422
 ;;^UTILITY(U,$J,358.3,41154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41154,1,3,0)
 ;;=3^Stress fx lft toe(s), subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,41154,1,4,0)
 ;;=4^M84.378K
 ;;^UTILITY(U,$J,358.3,41154,2)
 ;;=^5013779
 ;;^UTILITY(U,$J,358.3,41155,0)
 ;;=M84.377K^^189^2086^424
 ;;^UTILITY(U,$J,358.3,41155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41155,1,3,0)
 ;;=3^Stress fx rt toe(s), subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,41155,1,4,0)
 ;;=4^M84.377K
 ;;^UTILITY(U,$J,358.3,41155,2)
 ;;=^5013773
 ;;^UTILITY(U,$J,358.3,41156,0)
 ;;=M84.375K^^189^2086^421
 ;;^UTILITY(U,$J,358.3,41156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41156,1,3,0)
 ;;=3^Stress fx lft ft, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,41156,1,4,0)
 ;;=4^M84.375K
 ;;^UTILITY(U,$J,358.3,41156,2)
 ;;=^5013761
 ;;^UTILITY(U,$J,358.3,41157,0)
 ;;=M84.374K^^189^2086^423
 ;;^UTILITY(U,$J,358.3,41157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41157,1,3,0)
 ;;=3^Stress fx rt ft, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,41157,1,4,0)
 ;;=4^M84.374K
 ;;^UTILITY(U,$J,358.3,41157,2)
 ;;=^5013755
 ;;^UTILITY(U,$J,358.3,41158,0)
 ;;=M84.475K^^189^2086^403
