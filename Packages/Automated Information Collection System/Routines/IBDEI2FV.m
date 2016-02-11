IBDEI2FV ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40945,1,3,0)
 ;;=3^Frostbite of rt ft,Superficial, init
 ;;^UTILITY(U,$J,358.3,40945,1,4,0)
 ;;=4^T33.821A
 ;;^UTILITY(U,$J,358.3,40945,2)
 ;;=^5049121
 ;;^UTILITY(U,$J,358.3,40946,0)
 ;;=T33.822A^^189^2086^176
 ;;^UTILITY(U,$J,358.3,40946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40946,1,3,0)
 ;;=3^Frostbite of lft ft, Superficial,init
 ;;^UTILITY(U,$J,358.3,40946,1,4,0)
 ;;=4^T33.822A
 ;;^UTILITY(U,$J,358.3,40946,2)
 ;;=^5049124
 ;;^UTILITY(U,$J,358.3,40947,0)
 ;;=T33.831A^^189^2086^180
 ;;^UTILITY(U,$J,358.3,40947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40947,1,3,0)
 ;;=3^Frostbite of rt toe(s), Superficial,init
 ;;^UTILITY(U,$J,358.3,40947,1,4,0)
 ;;=4^T33.831A
 ;;^UTILITY(U,$J,358.3,40947,2)
 ;;=^5049130
 ;;^UTILITY(U,$J,358.3,40948,0)
 ;;=T33.832A^^189^2086^177
 ;;^UTILITY(U,$J,358.3,40948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40948,1,3,0)
 ;;=3^Frostbite of lft toe(s), Superficial,init
 ;;^UTILITY(U,$J,358.3,40948,1,4,0)
 ;;=4^T33.832A
 ;;^UTILITY(U,$J,358.3,40948,2)
 ;;=^5049133
 ;;^UTILITY(U,$J,358.3,40949,0)
 ;;=T34.811A^^189^2086^186
 ;;^UTILITY(U,$J,358.3,40949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40949,1,3,0)
 ;;=3^Frostbite w/ tissue necrosis of rt ankl, init
 ;;^UTILITY(U,$J,358.3,40949,1,4,0)
 ;;=4^T34.811A
 ;;^UTILITY(U,$J,358.3,40949,2)
 ;;=^5049223
 ;;^UTILITY(U,$J,358.3,40950,0)
 ;;=T34.812A^^189^2086^181
 ;;^UTILITY(U,$J,358.3,40950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40950,1,3,0)
 ;;=3^Frostbite w/ tissue necrosis of lft ankl, init
 ;;^UTILITY(U,$J,358.3,40950,1,4,0)
 ;;=4^T34.812A
 ;;^UTILITY(U,$J,358.3,40950,2)
 ;;=^5049226
 ;;^UTILITY(U,$J,358.3,40951,0)
 ;;=Z46.89^^189^2086^161
 ;;^UTILITY(U,$J,358.3,40951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40951,1,3,0)
 ;;=3^Fitting and adjustment of device, other
 ;;^UTILITY(U,$J,358.3,40951,1,4,0)
 ;;=4^Z46.89
 ;;^UTILITY(U,$J,358.3,40951,2)
 ;;=^5063023
 ;;^UTILITY(U,$J,358.3,40952,0)
 ;;=S92.532K^^189^2086^90
 ;;^UTILITY(U,$J,358.3,40952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40952,1,3,0)
 ;;=3^Disp fx of dist phalanx of lft lsr toe(s), subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,40952,1,4,0)
 ;;=4^S92.532K
 ;;^UTILITY(U,$J,358.3,40952,2)
 ;;=^5045526
 ;;^UTILITY(U,$J,358.3,40953,0)
 ;;=S92.531K^^189^2086^93
 ;;^UTILITY(U,$J,358.3,40953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40953,1,3,0)
 ;;=3^Disp fx of dist phalanx of rt lsr toe(s), subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,40953,1,4,0)
 ;;=4^S92.531K
 ;;^UTILITY(U,$J,358.3,40953,2)
 ;;=^5045519
 ;;^UTILITY(U,$J,358.3,40954,0)
 ;;=S92.525K^^189^2086^331
 ;;^UTILITY(U,$J,358.3,40954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40954,1,3,0)
 ;;=3^Nondisp fx of med phalanx of lft lsr toe(s), subs w/ nonunion
 ;;^UTILITY(U,$J,358.3,40954,1,4,0)
 ;;=4^S92.525K
 ;;^UTILITY(U,$J,358.3,40954,2)
 ;;=^5045505
 ;;^UTILITY(U,$J,358.3,40955,0)
 ;;=S92.404K^^189^2086^358
 ;;^UTILITY(U,$J,358.3,40955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40955,1,3,0)
 ;;=3^Nondisp fx rt grt toe, subs w/ nonunion, unspec
 ;;^UTILITY(U,$J,358.3,40955,1,4,0)
 ;;=4^S92.404K
 ;;^UTILITY(U,$J,358.3,40955,2)
 ;;=^5045288
 ;;^UTILITY(U,$J,358.3,40956,0)
 ;;=S92.402K^^189^2086^38
 ;;^UTILITY(U,$J,358.3,40956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40956,1,3,0)
 ;;=3^Disp fx lft grt toe, subs w/ nonunion, unspec
 ;;^UTILITY(U,$J,358.3,40956,1,4,0)
 ;;=4^S92.402K
 ;;^UTILITY(U,$J,358.3,40956,2)
 ;;=^5045281
 ;;^UTILITY(U,$J,358.3,40957,0)
 ;;=S92.401K^^189^2086^132
 ;;^UTILITY(U,$J,358.3,40957,1,0)
 ;;=^358.31IA^4^2
