IBDEI1W5 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32111,1,3,0)
 ;;=3^Disp fx of prox phalanx of rt lsr toe(s), init
 ;;^UTILITY(U,$J,358.3,32111,1,4,0)
 ;;=4^S92.511A
 ;;^UTILITY(U,$J,358.3,32111,2)
 ;;=^5045431
 ;;^UTILITY(U,$J,358.3,32112,0)
 ;;=S92.491A^^126^1609^212
 ;;^UTILITY(U,$J,358.3,32112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32112,1,3,0)
 ;;=3^Fx of rt grt toe, oth, init
 ;;^UTILITY(U,$J,358.3,32112,1,4,0)
 ;;=4^S92.491A
 ;;^UTILITY(U,$J,358.3,32112,2)
 ;;=^5045382
 ;;^UTILITY(U,$J,358.3,32113,0)
 ;;=S92.425A^^126^1609^313
 ;;^UTILITY(U,$J,358.3,32113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32113,1,3,0)
 ;;=3^Nondisp fx of dist phalanx of lft grt toe, init
 ;;^UTILITY(U,$J,358.3,32113,1,4,0)
 ;;=4^S92.425A
 ;;^UTILITY(U,$J,358.3,32113,2)
 ;;=^5045368
 ;;^UTILITY(U,$J,358.3,32114,0)
 ;;=S92.424A^^126^1609^315
 ;;^UTILITY(U,$J,358.3,32114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32114,1,3,0)
 ;;=3^Nondisp fx of dist phalanx of rt grt toe, init
 ;;^UTILITY(U,$J,358.3,32114,1,4,0)
 ;;=4^S92.424A
 ;;^UTILITY(U,$J,358.3,32114,2)
 ;;=^5045361
 ;;^UTILITY(U,$J,358.3,32115,0)
 ;;=S92.505A^^126^1609^323
 ;;^UTILITY(U,$J,358.3,32115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32115,1,3,0)
 ;;=3^Nondisp fx of lft lsr toe(s), unspec, init
 ;;^UTILITY(U,$J,358.3,32115,1,4,0)
 ;;=4^S92.505A
 ;;^UTILITY(U,$J,358.3,32115,2)
 ;;=^5045424
 ;;^UTILITY(U,$J,358.3,32116,0)
 ;;=S92.504A^^126^1609^353
 ;;^UTILITY(U,$J,358.3,32116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32116,1,3,0)
 ;;=3^Nondisp fx of rt lsr toe(s), unspec, init
 ;;^UTILITY(U,$J,358.3,32116,1,4,0)
 ;;=4^S92.504A
 ;;^UTILITY(U,$J,358.3,32116,2)
 ;;=^5045417
 ;;^UTILITY(U,$J,358.3,32117,0)
 ;;=S92.502A^^126^1609^98
 ;;^UTILITY(U,$J,358.3,32117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32117,1,3,0)
 ;;=3^Disp fx of lft lsr toe(s), unspec, init
 ;;^UTILITY(U,$J,358.3,32117,1,4,0)
 ;;=4^S92.502A
 ;;^UTILITY(U,$J,358.3,32117,2)
 ;;=^5045410
 ;;^UTILITY(U,$J,358.3,32118,0)
 ;;=S92.501A^^126^1609^127
 ;;^UTILITY(U,$J,358.3,32118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32118,1,3,0)
 ;;=3^Disp fx of rt lsr toe(s), unspec, init
 ;;^UTILITY(U,$J,358.3,32118,1,4,0)
 ;;=4^S92.501A
 ;;^UTILITY(U,$J,358.3,32118,2)
 ;;=^5045403
 ;;^UTILITY(U,$J,358.3,32119,0)
 ;;=S92.492A^^126^1609^195
 ;;^UTILITY(U,$J,358.3,32119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32119,1,3,0)
 ;;=3^Fx of lft grt toe, oth, init
 ;;^UTILITY(U,$J,358.3,32119,1,4,0)
 ;;=4^S92.492A
 ;;^UTILITY(U,$J,358.3,32119,2)
 ;;=^5045389
 ;;^UTILITY(U,$J,358.3,32120,0)
 ;;=T33.822S^^126^1609^1
 ;;^UTILITY(U,$J,358.3,32120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32120,1,3,0)
 ;;=3
 ;;^UTILITY(U,$J,358.3,32120,1,4,0)
 ;;=4^T33.822S
 ;;^UTILITY(U,$J,358.3,32120,2)
 ;;=Superficial Frostbite of lft ft, sequela^5049126
 ;;^UTILITY(U,$J,358.3,32121,0)
 ;;=S92.911A^^126^1609^221
 ;;^UTILITY(U,$J,358.3,32121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32121,1,3,0)
 ;;=3^Fx of rt toe(s), unspec, init
 ;;^UTILITY(U,$J,358.3,32121,1,4,0)
 ;;=4^S92.911A
 ;;^UTILITY(U,$J,358.3,32121,2)
 ;;=^5045592
 ;;^UTILITY(U,$J,358.3,32122,0)
 ;;=T34.821S^^126^1609^187
 ;;^UTILITY(U,$J,358.3,32122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32122,1,3,0)
 ;;=3^Frostbite w/ tissue necrosis of rt ft, sequela
 ;;^UTILITY(U,$J,358.3,32122,1,4,0)
 ;;=4^T34.821S
 ;;^UTILITY(U,$J,358.3,32122,2)
 ;;=^5049234
 ;;^UTILITY(U,$J,358.3,32123,0)
 ;;=T34.822S^^126^1609^182
 ;;^UTILITY(U,$J,358.3,32123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32123,1,3,0)
 ;;=3^Frostbite w/ tissue necrosis of lft ft, seqeula
 ;;^UTILITY(U,$J,358.3,32123,1,4,0)
 ;;=4^T34.822S
