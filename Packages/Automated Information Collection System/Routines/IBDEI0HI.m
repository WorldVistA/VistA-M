IBDEI0HI ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8100,1,3,0)
 ;;=3^Laceration w/o fb of left foot, init encntr
 ;;^UTILITY(U,$J,358.3,8100,1,4,0)
 ;;=4^S91.312A
 ;;^UTILITY(U,$J,358.3,8100,2)
 ;;=^5044323
 ;;^UTILITY(U,$J,358.3,8101,0)
 ;;=S51.811A^^33^431^125
 ;;^UTILITY(U,$J,358.3,8101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8101,1,3,0)
 ;;=3^Laceration w/o fb of right forearm, init encntr
 ;;^UTILITY(U,$J,358.3,8101,1,4,0)
 ;;=4^S51.811A
 ;;^UTILITY(U,$J,358.3,8101,2)
 ;;=^5028665
 ;;^UTILITY(U,$J,358.3,8102,0)
 ;;=S51.812A^^33^431^113
 ;;^UTILITY(U,$J,358.3,8102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8102,1,3,0)
 ;;=3^Laceration w/o fb of left forearm, init encntr
 ;;^UTILITY(U,$J,358.3,8102,1,4,0)
 ;;=4^S51.812A
 ;;^UTILITY(U,$J,358.3,8102,2)
 ;;=^5028668
 ;;^UTILITY(U,$J,358.3,8103,0)
 ;;=S61.411A^^33^431^127
 ;;^UTILITY(U,$J,358.3,8103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8103,1,3,0)
 ;;=3^Laceration w/o fb of right hand, init encntr
 ;;^UTILITY(U,$J,358.3,8103,1,4,0)
 ;;=4^S61.411A
 ;;^UTILITY(U,$J,358.3,8103,2)
 ;;=^5032987
 ;;^UTILITY(U,$J,358.3,8104,0)
 ;;=S61.412A^^33^431^115
 ;;^UTILITY(U,$J,358.3,8104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8104,1,3,0)
 ;;=3^Laceration w/o fb of left hand, init encntr
 ;;^UTILITY(U,$J,358.3,8104,1,4,0)
 ;;=4^S61.412A
 ;;^UTILITY(U,$J,358.3,8104,2)
 ;;=^5032990
 ;;^UTILITY(U,$J,358.3,8105,0)
 ;;=S81.811A^^33^431^131
 ;;^UTILITY(U,$J,358.3,8105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8105,1,3,0)
 ;;=3^Laceration w/o fb of right lower leg, init encntr
 ;;^UTILITY(U,$J,358.3,8105,1,4,0)
 ;;=4^S81.811A
 ;;^UTILITY(U,$J,358.3,8105,2)
 ;;=^5040071
 ;;^UTILITY(U,$J,358.3,8106,0)
 ;;=S81.812A^^33^431^119
 ;;^UTILITY(U,$J,358.3,8106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8106,1,3,0)
 ;;=3^Laceration w/o fb of left lower leg, init encntr
 ;;^UTILITY(U,$J,358.3,8106,1,4,0)
 ;;=4^S81.812A
 ;;^UTILITY(U,$J,358.3,8106,2)
 ;;=^5040074
 ;;^UTILITY(U,$J,358.3,8107,0)
 ;;=S01.01XA^^33^431^136
 ;;^UTILITY(U,$J,358.3,8107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8107,1,3,0)
 ;;=3^Laceration w/o fb of scalp, initial encounter
 ;;^UTILITY(U,$J,358.3,8107,1,4,0)
 ;;=4^S01.01XA
 ;;^UTILITY(U,$J,358.3,8107,2)
 ;;=^5020036
 ;;^UTILITY(U,$J,358.3,8108,0)
 ;;=S61.011A^^33^431^134
 ;;^UTILITY(U,$J,358.3,8108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8108,1,3,0)
 ;;=3^Laceration w/o fb of right thumb w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8108,1,4,0)
 ;;=4^S61.011A
 ;;^UTILITY(U,$J,358.3,8108,2)
 ;;=^5032690
 ;;^UTILITY(U,$J,358.3,8109,0)
 ;;=S61.012A^^33^431^122
 ;;^UTILITY(U,$J,358.3,8109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8109,1,3,0)
 ;;=3^Laceration w/o fb of left thumb w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8109,1,4,0)
 ;;=4^S61.012A
 ;;^UTILITY(U,$J,358.3,8109,2)
 ;;=^5032693
 ;;^UTILITY(U,$J,358.3,8110,0)
 ;;=S91.111A^^33^431^126
 ;;^UTILITY(U,$J,358.3,8110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8110,1,3,0)
 ;;=3^Laceration w/o fb of right great toe w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8110,1,4,0)
 ;;=4^S91.111A
 ;;^UTILITY(U,$J,358.3,8110,2)
 ;;=^5044183
 ;;^UTILITY(U,$J,358.3,8111,0)
 ;;=S91.112A^^33^431^114
 ;;^UTILITY(U,$J,358.3,8111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8111,1,3,0)
 ;;=3^Laceration w/o fb of left great toe w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8111,1,4,0)
 ;;=4^S91.112A
 ;;^UTILITY(U,$J,358.3,8111,2)
 ;;=^5044186
 ;;^UTILITY(U,$J,358.3,8112,0)
 ;;=S91.114A^^33^431^129
 ;;^UTILITY(U,$J,358.3,8112,1,0)
 ;;=^358.31IA^4^2
