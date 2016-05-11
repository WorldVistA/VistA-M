IBDEI1WH ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32254,1,3,0)
 ;;=3^Disp trimall fx rt lwr leg, subs for opn fx type IIIA/B/C w/ nonunion
 ;;^UTILITY(U,$J,358.3,32254,1,4,0)
 ;;=4^S82.851N
 ;;^UTILITY(U,$J,358.3,32254,2)
 ;;=^5042586
 ;;^UTILITY(U,$J,358.3,32255,0)
 ;;=S82.852N^^126^1609^151
 ;;^UTILITY(U,$J,358.3,32255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32255,1,3,0)
 ;;=3^Disp trimall fx lft lwr leg, subs for opn fx type IIIA/B/C w/ nonunion
 ;;^UTILITY(U,$J,358.3,32255,1,4,0)
 ;;=4^S82.852N
 ;;^UTILITY(U,$J,358.3,32255,2)
 ;;=^5042602
 ;;^UTILITY(U,$J,358.3,32256,0)
 ;;=S82.851M^^126^1609^158
 ;;^UTILITY(U,$J,358.3,32256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32256,1,3,0)
 ;;=3^Disp trimall fx rt lwr leg, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,32256,1,4,0)
 ;;=4^S82.851M
 ;;^UTILITY(U,$J,358.3,32256,2)
 ;;=^5042585
 ;;^UTILITY(U,$J,358.3,32257,0)
 ;;=S82.852M^^126^1609^152
 ;;^UTILITY(U,$J,358.3,32257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32257,1,3,0)
 ;;=3^Disp trimall fx lft lwr leg, subs for opn fx type I/II w/ nonunion
 ;;^UTILITY(U,$J,358.3,32257,1,4,0)
 ;;=4^S82.852M
 ;;^UTILITY(U,$J,358.3,32257,2)
 ;;=^5042601
 ;;^UTILITY(U,$J,358.3,32258,0)
 ;;=S82.851K^^126^1609^156
 ;;^UTILITY(U,$J,358.3,32258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32258,1,3,0)
 ;;=3^Disp trimall fx rt lwr leg, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,32258,1,4,0)
 ;;=4^S82.851K
 ;;^UTILITY(U,$J,358.3,32258,2)
 ;;=^5042584
 ;;^UTILITY(U,$J,358.3,32259,0)
 ;;=S82.852K^^126^1609^150
 ;;^UTILITY(U,$J,358.3,32259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32259,1,3,0)
 ;;=3^Disp trimall fx lft lwr leg, subs for clos fx w/ nonunion
 ;;^UTILITY(U,$J,358.3,32259,1,4,0)
 ;;=4^S82.852K
 ;;^UTILITY(U,$J,358.3,32259,2)
 ;;=^5042600
 ;;^UTILITY(U,$J,358.3,32260,0)
 ;;=S92.114K^^126^1609^283
 ;;^UTILITY(U,$J,358.3,32260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32260,1,3,0)
 ;;=3^Nondisp fx neck rt talus, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32260,1,4,0)
 ;;=4^S92.114K
 ;;^UTILITY(U,$J,358.3,32260,2)
 ;;=^5044630
 ;;^UTILITY(U,$J,358.3,32261,0)
 ;;=S92.115K^^126^1609^282
 ;;^UTILITY(U,$J,358.3,32261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32261,1,3,0)
 ;;=3^Nondisp fx neck lft talus, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32261,1,4,0)
 ;;=4^S92.115K
 ;;^UTILITY(U,$J,358.3,32261,2)
 ;;=^5044637
 ;;^UTILITY(U,$J,358.3,32262,0)
 ;;=S92.112K^^126^1609^57
 ;;^UTILITY(U,$J,358.3,32262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32262,1,3,0)
 ;;=3^Disp fx neck lft talus, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32262,1,4,0)
 ;;=4^S92.112K
 ;;^UTILITY(U,$J,358.3,32262,2)
 ;;=^5044616
 ;;^UTILITY(U,$J,358.3,32263,0)
 ;;=S92.111K^^126^1609^58
 ;;^UTILITY(U,$J,358.3,32263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32263,1,3,0)
 ;;=3^Disp fx neck rt talus, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32263,1,4,0)
 ;;=4^S92.111K
 ;;^UTILITY(U,$J,358.3,32263,2)
 ;;=^5044609
 ;;^UTILITY(U,$J,358.3,32264,0)
 ;;=S92.142K^^126^1609^20
 ;;^UTILITY(U,$J,358.3,32264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32264,1,3,0)
 ;;=3^Disp dome fx lft talus, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32264,1,4,0)
 ;;=4^S92.142K
 ;;^UTILITY(U,$J,358.3,32264,2)
 ;;=^5044742
 ;;^UTILITY(U,$J,358.3,32265,0)
 ;;=S92.141K^^126^1609^23
 ;;^UTILITY(U,$J,358.3,32265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32265,1,3,0)
 ;;=3^Disp dome fx rt talus, subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,32265,1,4,0)
 ;;=4^S92.141K
 ;;^UTILITY(U,$J,358.3,32265,2)
 ;;=^5044735
