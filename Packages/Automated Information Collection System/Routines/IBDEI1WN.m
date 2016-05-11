IBDEI1WN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32325,2)
 ;;=^5042370
 ;;^UTILITY(U,$J,358.3,32326,0)
 ;;=S82.64XM^^126^1609^273
 ;;^UTILITY(U,$J,358.3,32326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32326,1,3,0)
 ;;=3^Nondisp fx ltrl mall rt fib, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,32326,1,4,0)
 ;;=4^S82.64XM
 ;;^UTILITY(U,$J,358.3,32326,2)
 ;;=^5042369
 ;;^UTILITY(U,$J,358.3,32327,0)
 ;;=S82.64XK^^126^1609^271
 ;;^UTILITY(U,$J,358.3,32327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32327,1,3,0)
 ;;=3^Nondisp fx ltrl mall rt fib, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,32327,1,4,0)
 ;;=4^S82.64XK
 ;;^UTILITY(U,$J,358.3,32327,2)
 ;;=^5042368
 ;;^UTILITY(U,$J,358.3,32328,0)
 ;;=S82.842N^^126^1609^13
 ;;^UTILITY(U,$J,358.3,32328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32328,1,3,0)
 ;;=3^Disp bimal fx lft lwr leg, subs for opn fx type IIIA/B/C w/ nonunion
 ;;^UTILITY(U,$J,358.3,32328,1,4,0)
 ;;=4^S82.842N
 ;;^UTILITY(U,$J,358.3,32328,2)
 ;;=^5042506
 ;;^UTILITY(U,$J,358.3,32329,0)
 ;;=S82.842M^^126^1609^14
 ;;^UTILITY(U,$J,358.3,32329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32329,1,3,0)
 ;;=3^Disp bimal fx lft lwr leg, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,32329,1,4,0)
 ;;=4^S82.842M
 ;;^UTILITY(U,$J,358.3,32329,2)
 ;;=^5042505
 ;;^UTILITY(U,$J,358.3,32330,0)
 ;;=S82.842K^^126^1609^12
 ;;^UTILITY(U,$J,358.3,32330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32330,1,3,0)
 ;;=3^Disp bimal fx lft lwr leg, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,32330,1,4,0)
 ;;=4^S82.842K
 ;;^UTILITY(U,$J,358.3,32330,2)
 ;;=^5042504
 ;;^UTILITY(U,$J,358.3,32331,0)
 ;;=S82.841N^^126^1609^16
 ;;^UTILITY(U,$J,358.3,32331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32331,1,3,0)
 ;;=3^Disp bimal fx rt lwr leg, subs for opn fx type IIIA/B/C w/ nonunion
 ;;^UTILITY(U,$J,358.3,32331,1,4,0)
 ;;=4^S82.841N
 ;;^UTILITY(U,$J,358.3,32331,2)
 ;;=^5042490
 ;;^UTILITY(U,$J,358.3,32332,0)
 ;;=S82.841M^^126^1609^17
 ;;^UTILITY(U,$J,358.3,32332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32332,1,3,0)
 ;;=3^Disp bimal fx rt lwr leg, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,32332,1,4,0)
 ;;=4^S82.841M
 ;;^UTILITY(U,$J,358.3,32332,2)
 ;;=^5042489
 ;;^UTILITY(U,$J,358.3,32333,0)
 ;;=S82.841K^^126^1609^15
 ;;^UTILITY(U,$J,358.3,32333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32333,1,3,0)
 ;;=3^Disp bimal fx rt lwr leg, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,32333,1,4,0)
 ;;=4^S82.841K
 ;;^UTILITY(U,$J,358.3,32333,2)
 ;;=^5042488
 ;;^UTILITY(U,$J,358.3,32334,0)
 ;;=M84.452K^^126^1609^400
 ;;^UTILITY(U,$J,358.3,32334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32334,1,3,0)
 ;;=3^Path fx lft fem, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32334,1,4,0)
 ;;=4^M84.452K
 ;;^UTILITY(U,$J,358.3,32334,2)
 ;;=^5013911
 ;;^UTILITY(U,$J,358.3,32335,0)
 ;;=M84.672K^^126^1609^399
 ;;^UTILITY(U,$J,358.3,32335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32335,1,3,0)
 ;;=3^Path fx lft ankl, subs w/ nonunion, oth disease
 ;;^UTILITY(U,$J,358.3,32335,1,4,0)
 ;;=4^M84.672K
 ;;^UTILITY(U,$J,358.3,32335,2)
 ;;=^5134030
 ;;^UTILITY(U,$J,358.3,32336,0)
 ;;=M84.671K^^126^1609^413
 ;;^UTILITY(U,$J,358.3,32336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32336,1,3,0)
 ;;=3^Path fx rt ankl, subs w/ nonunion, oth disease
 ;;^UTILITY(U,$J,358.3,32336,1,4,0)
 ;;=4^M84.671K
 ;;^UTILITY(U,$J,358.3,32336,2)
 ;;=^5014295
 ;;^UTILITY(U,$J,358.3,32337,0)
 ;;=S82.55XN^^126^1609^277
 ;;^UTILITY(U,$J,358.3,32337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32337,1,3,0)
 ;;=3^Nondisp fx med mall lft tib, subs for opn fx type IIIA/B/C w/ nonunion
