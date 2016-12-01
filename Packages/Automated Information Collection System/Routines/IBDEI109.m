IBDEI109 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47502,1,3,0)
 ;;=3^Path fx rt ft, subs w/ nonunion, oth disease
 ;;^UTILITY(U,$J,358.3,47502,1,4,0)
 ;;=4^M84.674K
 ;;^UTILITY(U,$J,358.3,47502,2)
 ;;=^5014301
 ;;^UTILITY(U,$J,358.3,47503,0)
 ;;=M84.68XK^^139^1984^420
 ;;^UTILITY(U,$J,358.3,47503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47503,1,3,0)
 ;;=3^Path fx subs w/ nonunion, oth disease, oth site
 ;;^UTILITY(U,$J,358.3,47503,1,4,0)
 ;;=4^M84.68XK
 ;;^UTILITY(U,$J,358.3,47503,2)
 ;;=^5134054
 ;;^UTILITY(U,$J,358.3,47504,0)
 ;;=S82.65XN^^139^1984^268
 ;;^UTILITY(U,$J,358.3,47504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47504,1,3,0)
 ;;=3^Nondisp fx ltrl lmall lft fib, subs for opn fx type IIIA/B/C w/ nonunion
 ;;^UTILITY(U,$J,358.3,47504,1,4,0)
 ;;=4^S82.65XN
 ;;^UTILITY(U,$J,358.3,47504,2)
 ;;=^5042386
 ;;^UTILITY(U,$J,358.3,47505,0)
 ;;=S82.65XM^^139^1984^269
 ;;^UTILITY(U,$J,358.3,47505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47505,1,3,0)
 ;;=3^Nondisp fx ltrl mall lft fib, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,47505,1,4,0)
 ;;=4^S82.65XM
 ;;^UTILITY(U,$J,358.3,47505,2)
 ;;=^5042385
 ;;^UTILITY(U,$J,358.3,47506,0)
 ;;=S82.65XK^^139^1984^270
 ;;^UTILITY(U,$J,358.3,47506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47506,1,3,0)
 ;;=3^Nondisp fx ltrl mall lft fib, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,47506,1,4,0)
 ;;=4^S82.65XK
 ;;^UTILITY(U,$J,358.3,47506,2)
 ;;=^5042384
 ;;^UTILITY(U,$J,358.3,47507,0)
 ;;=S82.64XN^^139^1984^272
 ;;^UTILITY(U,$J,358.3,47507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47507,1,3,0)
 ;;=3^Nondisp fx ltrl mall rt fib, subs for opn fx type IIIA/B/C w/ nonunion
 ;;^UTILITY(U,$J,358.3,47507,1,4,0)
 ;;=4^S82.64XN
 ;;^UTILITY(U,$J,358.3,47507,2)
 ;;=^5042370
 ;;^UTILITY(U,$J,358.3,47508,0)
 ;;=S82.64XM^^139^1984^273
 ;;^UTILITY(U,$J,358.3,47508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47508,1,3,0)
 ;;=3^Nondisp fx ltrl mall rt fib, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,47508,1,4,0)
 ;;=4^S82.64XM
 ;;^UTILITY(U,$J,358.3,47508,2)
 ;;=^5042369
 ;;^UTILITY(U,$J,358.3,47509,0)
 ;;=S82.64XK^^139^1984^271
 ;;^UTILITY(U,$J,358.3,47509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47509,1,3,0)
 ;;=3^Nondisp fx ltrl mall rt fib, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,47509,1,4,0)
 ;;=4^S82.64XK
 ;;^UTILITY(U,$J,358.3,47509,2)
 ;;=^5042368
 ;;^UTILITY(U,$J,358.3,47510,0)
 ;;=S82.842N^^139^1984^13
 ;;^UTILITY(U,$J,358.3,47510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47510,1,3,0)
 ;;=3^Disp bimal fx lft lwr leg, subs for opn fx type IIIA/B/C w/ nonunion
 ;;^UTILITY(U,$J,358.3,47510,1,4,0)
 ;;=4^S82.842N
 ;;^UTILITY(U,$J,358.3,47510,2)
 ;;=^5042506
 ;;^UTILITY(U,$J,358.3,47511,0)
 ;;=S82.842M^^139^1984^14
 ;;^UTILITY(U,$J,358.3,47511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47511,1,3,0)
 ;;=3^Disp bimal fx lft lwr leg, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,47511,1,4,0)
 ;;=4^S82.842M
 ;;^UTILITY(U,$J,358.3,47511,2)
 ;;=^5042505
 ;;^UTILITY(U,$J,358.3,47512,0)
 ;;=S82.842K^^139^1984^12
 ;;^UTILITY(U,$J,358.3,47512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47512,1,3,0)
 ;;=3^Disp bimal fx lft lwr leg, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,47512,1,4,0)
 ;;=4^S82.842K
 ;;^UTILITY(U,$J,358.3,47512,2)
 ;;=^5042504
 ;;^UTILITY(U,$J,358.3,47513,0)
 ;;=S82.841N^^139^1984^16
 ;;^UTILITY(U,$J,358.3,47513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47513,1,3,0)
 ;;=3^Disp bimal fx rt lwr leg, subs for opn fx type IIIA/B/C w/ nonunion
 ;;^UTILITY(U,$J,358.3,47513,1,4,0)
 ;;=4^S82.841N
 ;;^UTILITY(U,$J,358.3,47513,2)
 ;;=^5042490
 ;;^UTILITY(U,$J,358.3,47514,0)
 ;;=S82.841M^^139^1984^17
 ;;^UTILITY(U,$J,358.3,47514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47514,1,3,0)
 ;;=3^Disp bimal fx rt lwr leg, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,47514,1,4,0)
 ;;=4^S82.841M
 ;;^UTILITY(U,$J,358.3,47514,2)
 ;;=^5042489
 ;;^UTILITY(U,$J,358.3,47515,0)
 ;;=S82.841K^^139^1984^15
 ;;^UTILITY(U,$J,358.3,47515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47515,1,3,0)
 ;;=3^Disp bimal fx rt lwr leg, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,47515,1,4,0)
 ;;=4^S82.841K
 ;;^UTILITY(U,$J,358.3,47515,2)
 ;;=^5042488
 ;;^UTILITY(U,$J,358.3,47516,0)
 ;;=M84.452K^^139^1984^400
 ;;^UTILITY(U,$J,358.3,47516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47516,1,3,0)
 ;;=3^Path fx lft fem, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,47516,1,4,0)
 ;;=4^M84.452K
 ;;^UTILITY(U,$J,358.3,47516,2)
 ;;=^5013911
 ;;^UTILITY(U,$J,358.3,47517,0)
 ;;=M84.672K^^139^1984^399
 ;;^UTILITY(U,$J,358.3,47517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47517,1,3,0)
 ;;=3^Path fx lft ankl, subs w/ nonunion, oth disease
 ;;^UTILITY(U,$J,358.3,47517,1,4,0)
 ;;=4^M84.672K
 ;;^UTILITY(U,$J,358.3,47517,2)
 ;;=^5134030
 ;;^UTILITY(U,$J,358.3,47518,0)
 ;;=M84.671K^^139^1984^413
 ;;^UTILITY(U,$J,358.3,47518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47518,1,3,0)
 ;;=3^Path fx rt ankl, subs w/ nonunion, oth disease
 ;;^UTILITY(U,$J,358.3,47518,1,4,0)
 ;;=4^M84.671K
 ;;^UTILITY(U,$J,358.3,47518,2)
 ;;=^5014295
 ;;^UTILITY(U,$J,358.3,47519,0)
 ;;=S82.55XN^^139^1984^277
 ;;^UTILITY(U,$J,358.3,47519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47519,1,3,0)
 ;;=3^Nondisp fx med mall lft tib, subs for opn fx type IIIA/B/C w/ nonunion
 ;;^UTILITY(U,$J,358.3,47519,1,4,0)
 ;;=4^S82.55XN
 ;;^UTILITY(U,$J,358.3,47519,2)
 ;;=^5042290
 ;;^UTILITY(U,$J,358.3,47520,0)
 ;;=S82.55XM^^139^1984^278
 ;;^UTILITY(U,$J,358.3,47520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47520,1,3,0)
 ;;=3^Nondisp fx med mall lft tib, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,47520,1,4,0)
 ;;=4^S82.55XM
 ;;^UTILITY(U,$J,358.3,47520,2)
 ;;=^5042289
 ;;^UTILITY(U,$J,358.3,47521,0)
 ;;=S82.55XK^^139^1984^276
 ;;^UTILITY(U,$J,358.3,47521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47521,1,3,0)
 ;;=3^Nondisp fx med mall lft tib, subs for clo fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,47521,1,4,0)
 ;;=4^S82.55XK
 ;;^UTILITY(U,$J,358.3,47521,2)
 ;;=^5042288
 ;;^UTILITY(U,$J,358.3,47522,0)
 ;;=S82.54XN^^139^1984^280
 ;;^UTILITY(U,$J,358.3,47522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47522,1,3,0)
 ;;=3^Nondisp fx med mall rt tib, subs for opn fx type IIIA/B/C w/ nonunion
 ;;^UTILITY(U,$J,358.3,47522,1,4,0)
 ;;=4^S82.54XN
 ;;^UTILITY(U,$J,358.3,47522,2)
 ;;=^5042274
 ;;^UTILITY(U,$J,358.3,47523,0)
 ;;=S82.54XM^^139^1984^281
 ;;^UTILITY(U,$J,358.3,47523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47523,1,3,0)
 ;;=3^Nondisp fx med mall rt tib, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,47523,1,4,0)
 ;;=4^S82.54XM
 ;;^UTILITY(U,$J,358.3,47523,2)
 ;;=^5042273
 ;;^UTILITY(U,$J,358.3,47524,0)
 ;;=S82.54XK^^139^1984^279
 ;;^UTILITY(U,$J,358.3,47524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47524,1,3,0)
 ;;=3^Nondisp fx med mall rt tib, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,47524,1,4,0)
 ;;=4^S82.54XK
 ;;^UTILITY(U,$J,358.3,47524,2)
 ;;=^5042272
 ;;^UTILITY(U,$J,358.3,47525,0)
 ;;=S82.52XN^^139^1984^50
 ;;^UTILITY(U,$J,358.3,47525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47525,1,3,0)
 ;;=3^Disp fx med mal lft tib, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,47525,1,4,0)
 ;;=4^S82.52XN
 ;;^UTILITY(U,$J,358.3,47525,2)
 ;;=^5042242
 ;;^UTILITY(U,$J,358.3,47526,0)
 ;;=S82.52XM^^139^1984^54
 ;;^UTILITY(U,$J,358.3,47526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47526,1,3,0)
 ;;=3^Disp fx med mallft tib, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,47526,1,4,0)
 ;;=4^S82.52XM
 ;;^UTILITY(U,$J,358.3,47526,2)
 ;;=^5042241
 ;;^UTILITY(U,$J,358.3,47527,0)
 ;;=S82.52XK^^139^1984^51
 ;;^UTILITY(U,$J,358.3,47527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47527,1,3,0)
 ;;=3^Disp fx med mall lft tib, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,47527,1,4,0)
 ;;=4^S82.52XK
 ;;^UTILITY(U,$J,358.3,47527,2)
 ;;=^5042240
 ;;^UTILITY(U,$J,358.3,47528,0)
 ;;=S82.51XN^^139^1984^52
 ;;^UTILITY(U,$J,358.3,47528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47528,1,3,0)
 ;;=3^Disp fx med mall rt tib, subs for opn fx type IIIA/B/C w/ nonunion
 ;;^UTILITY(U,$J,358.3,47528,1,4,0)
 ;;=4^S82.51XN
 ;;^UTILITY(U,$J,358.3,47528,2)
 ;;=^5042226
 ;;^UTILITY(U,$J,358.3,47529,0)
 ;;=S82.51XM^^139^1984^53
 ;;^UTILITY(U,$J,358.3,47529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47529,1,3,0)
 ;;=3^Disp fx med mall rt tib, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,47529,1,4,0)
 ;;=4^S82.51XM
 ;;^UTILITY(U,$J,358.3,47529,2)
 ;;=^5042225
 ;;^UTILITY(U,$J,358.3,47530,0)
 ;;=S82.51XK^^139^1984^103
 ;;^UTILITY(U,$J,358.3,47530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47530,1,3,0)
 ;;=3^Disp fx of med mall rt tib, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,47530,1,4,0)
 ;;=4^S82.51XK
 ;;^UTILITY(U,$J,358.3,47530,2)
 ;;=^5042224
 ;;^UTILITY(U,$J,358.3,47531,0)
 ;;=M84.378K^^139^1984^422
 ;;^UTILITY(U,$J,358.3,47531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47531,1,3,0)
 ;;=3^Stress fx lft toe(s), subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,47531,1,4,0)
 ;;=4^M84.378K
 ;;^UTILITY(U,$J,358.3,47531,2)
 ;;=^5013779
 ;;^UTILITY(U,$J,358.3,47532,0)
 ;;=M84.377K^^139^1984^424
 ;;^UTILITY(U,$J,358.3,47532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47532,1,3,0)
 ;;=3^Stress fx rt toe(s), subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,47532,1,4,0)
 ;;=4^M84.377K
 ;;^UTILITY(U,$J,358.3,47532,2)
 ;;=^5013773
 ;;^UTILITY(U,$J,358.3,47533,0)
 ;;=M84.375K^^139^1984^421
 ;;^UTILITY(U,$J,358.3,47533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47533,1,3,0)
 ;;=3^Stress fx lft ft, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,47533,1,4,0)
 ;;=4^M84.375K
 ;;^UTILITY(U,$J,358.3,47533,2)
 ;;=^5013761
 ;;^UTILITY(U,$J,358.3,47534,0)
 ;;=M84.374K^^139^1984^423
