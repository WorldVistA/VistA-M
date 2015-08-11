IBDEI1VM ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33400,1,4,0)
 ;;=4^S92.502A
 ;;^UTILITY(U,$J,358.3,33400,2)
 ;;=^5045410
 ;;^UTILITY(U,$J,358.3,33401,0)
 ;;=S92.501A^^191^1968^127
 ;;^UTILITY(U,$J,358.3,33401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33401,1,3,0)
 ;;=3^Disp fx of rt lsr toe(s), unspec, init
 ;;^UTILITY(U,$J,358.3,33401,1,4,0)
 ;;=4^S92.501A
 ;;^UTILITY(U,$J,358.3,33401,2)
 ;;=^5045403
 ;;^UTILITY(U,$J,358.3,33402,0)
 ;;=S92.492A^^191^1968^196
 ;;^UTILITY(U,$J,358.3,33402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33402,1,3,0)
 ;;=3^Fx of lft grt toe, oth, init
 ;;^UTILITY(U,$J,358.3,33402,1,4,0)
 ;;=4^S92.492A
 ;;^UTILITY(U,$J,358.3,33402,2)
 ;;=^5045389
 ;;^UTILITY(U,$J,358.3,33403,0)
 ;;=T33.822S^^191^1968^1
 ;;^UTILITY(U,$J,358.3,33403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33403,1,3,0)
 ;;=3^
 ;;^UTILITY(U,$J,358.3,33403,1,4,0)
 ;;=4^T33.822S
 ;;^UTILITY(U,$J,358.3,33403,2)
 ;;=Superficial Frostbite of lft ft, sequela^5049126
 ;;^UTILITY(U,$J,358.3,33404,0)
 ;;=S92.911A^^191^1968^221
 ;;^UTILITY(U,$J,358.3,33404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33404,1,3,0)
 ;;=3^Fx of rt toe(s), unspec, init
 ;;^UTILITY(U,$J,358.3,33404,1,4,0)
 ;;=4^S92.911A
 ;;^UTILITY(U,$J,358.3,33404,2)
 ;;=^5045592
 ;;^UTILITY(U,$J,358.3,33405,0)
 ;;=T34.821S^^191^1968^187
 ;;^UTILITY(U,$J,358.3,33405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33405,1,3,0)
 ;;=3^Frostbite w/ tissue necrosis of rt ft, sequela
 ;;^UTILITY(U,$J,358.3,33405,1,4,0)
 ;;=4^T34.821S
 ;;^UTILITY(U,$J,358.3,33405,2)
 ;;=^5049234
 ;;^UTILITY(U,$J,358.3,33406,0)
 ;;=T34.821S^^191^1968^188
 ;;^UTILITY(U,$J,358.3,33406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33406,1,3,0)
 ;;=3^Frostbite w/ tissue necrosis of rt ft, sequela
 ;;^UTILITY(U,$J,358.3,33406,1,4,0)
 ;;=4^T34.821S
 ;;^UTILITY(U,$J,358.3,33406,2)
 ;;=^5049234
 ;;^UTILITY(U,$J,358.3,33407,0)
 ;;=T34.822S^^191^1968^182
 ;;^UTILITY(U,$J,358.3,33407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33407,1,3,0)
 ;;=3^Frostbite w/ tissue necrosis of lft ft, seqeula
 ;;^UTILITY(U,$J,358.3,33407,1,4,0)
 ;;=4^T34.822S
 ;;^UTILITY(U,$J,358.3,33407,2)
 ;;=^5049237
 ;;^UTILITY(U,$J,358.3,33408,0)
 ;;=T34.831S^^191^1968^190
 ;;^UTILITY(U,$J,358.3,33408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33408,1,3,0)
 ;;=3^Frostbite w/ tissue necrosis of rt toe(s), sequela
 ;;^UTILITY(U,$J,358.3,33408,1,4,0)
 ;;=4^T34.831S
 ;;^UTILITY(U,$J,358.3,33408,2)
 ;;=^5049243
 ;;^UTILITY(U,$J,358.3,33409,0)
 ;;=T34.832S^^191^1968^184
 ;;^UTILITY(U,$J,358.3,33409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33409,1,3,0)
 ;;=3^Frostbite w/ tissue necrosis of lft toe(s), sequela
 ;;^UTILITY(U,$J,358.3,33409,1,4,0)
 ;;=4^T34.832S
 ;;^UTILITY(U,$J,358.3,33409,2)
 ;;=^5049246
 ;;^UTILITY(U,$J,358.3,33410,0)
 ;;=S80.851A^^191^1968^174
 ;;^UTILITY(U,$J,358.3,33410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33410,1,3,0)
 ;;=3^Foreign body, rt lwr leg,Superficial,init
 ;;^UTILITY(U,$J,358.3,33410,1,4,0)
 ;;=4^S80.851A
 ;;^UTILITY(U,$J,358.3,33410,2)
 ;;=^5039987
 ;;^UTILITY(U,$J,358.3,33411,0)
 ;;=S90.451A^^191^1968^172
 ;;^UTILITY(U,$J,358.3,33411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33411,1,3,0)
 ;;=3^Foreign body, rt grt toe, Superficial,init
 ;;^UTILITY(U,$J,358.3,33411,1,4,0)
 ;;=4^S90.451A
 ;;^UTILITY(U,$J,358.3,33411,2)
 ;;=^5043943
 ;;^UTILITY(U,$J,358.3,33412,0)
 ;;=S90.454A^^191^1968^173
 ;;^UTILITY(U,$J,358.3,33412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33412,1,3,0)
 ;;=3^Foreign body, rt lsr toe(s),Superficial,init
 ;;^UTILITY(U,$J,358.3,33412,1,4,0)
 ;;=4^S90.454A
 ;;^UTILITY(U,$J,358.3,33412,2)
 ;;=^5043952
