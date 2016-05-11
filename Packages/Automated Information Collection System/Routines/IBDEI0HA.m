IBDEI0HA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8001,1,4,0)
 ;;=4^S40.862A
 ;;^UTILITY(U,$J,358.3,8001,2)
 ;;=^5026264
 ;;^UTILITY(U,$J,358.3,8002,0)
 ;;=S50.861A^^33^431^110
 ;;^UTILITY(U,$J,358.3,8002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8002,1,3,0)
 ;;=3^Insect bite (nonvenomous) of right forearm, init encntr
 ;;^UTILITY(U,$J,358.3,8002,1,4,0)
 ;;=4^S50.861A
 ;;^UTILITY(U,$J,358.3,8002,2)
 ;;=^5028590
 ;;^UTILITY(U,$J,358.3,8003,0)
 ;;=S50.862A^^33^431^108
 ;;^UTILITY(U,$J,358.3,8003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8003,1,3,0)
 ;;=3^Insect bite (nonvenomous) of left forearm, initial encounter
 ;;^UTILITY(U,$J,358.3,8003,1,4,0)
 ;;=4^S50.862A
 ;;^UTILITY(U,$J,358.3,8003,2)
 ;;=^5028593
 ;;^UTILITY(U,$J,358.3,8004,0)
 ;;=S91.351A^^33^431^148
 ;;^UTILITY(U,$J,358.3,8004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8004,1,3,0)
 ;;=3^Open bite, right foot, initial encounter
 ;;^UTILITY(U,$J,358.3,8004,1,4,0)
 ;;=4^S91.351A
 ;;^UTILITY(U,$J,358.3,8004,2)
 ;;=^5044344
 ;;^UTILITY(U,$J,358.3,8005,0)
 ;;=S91.352A^^33^431^140
 ;;^UTILITY(U,$J,358.3,8005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8005,1,3,0)
 ;;=3^Open bite, left foot, initial encounter
 ;;^UTILITY(U,$J,358.3,8005,1,4,0)
 ;;=4^S91.352A
 ;;^UTILITY(U,$J,358.3,8005,2)
 ;;=^5044347
 ;;^UTILITY(U,$J,358.3,8006,0)
 ;;=S61.451A^^33^431^151
 ;;^UTILITY(U,$J,358.3,8006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8006,1,3,0)
 ;;=3^Open bite, right hand, initial encounter
 ;;^UTILITY(U,$J,358.3,8006,1,4,0)
 ;;=4^S61.451A
 ;;^UTILITY(U,$J,358.3,8006,2)
 ;;=^5033011
 ;;^UTILITY(U,$J,358.3,8007,0)
 ;;=S61.452A^^33^431^143
 ;;^UTILITY(U,$J,358.3,8007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8007,1,3,0)
 ;;=3^Open bite, left hand, initial encounter
 ;;^UTILITY(U,$J,358.3,8007,1,4,0)
 ;;=4^S61.452A
 ;;^UTILITY(U,$J,358.3,8007,2)
 ;;=^5033014
 ;;^UTILITY(U,$J,358.3,8008,0)
 ;;=S81.851A^^33^431^153
 ;;^UTILITY(U,$J,358.3,8008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8008,1,3,0)
 ;;=3^Open bite, right lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,8008,1,4,0)
 ;;=4^S81.851A
 ;;^UTILITY(U,$J,358.3,8008,2)
 ;;=^5040095
 ;;^UTILITY(U,$J,358.3,8009,0)
 ;;=S81.852A^^33^431^145
 ;;^UTILITY(U,$J,358.3,8009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8009,1,3,0)
 ;;=3^Open bite, left lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,8009,1,4,0)
 ;;=4^S81.852A
 ;;^UTILITY(U,$J,358.3,8009,2)
 ;;=^5040098
 ;;^UTILITY(U,$J,358.3,8010,0)
 ;;=S91.151A^^33^431^150
 ;;^UTILITY(U,$J,358.3,8010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8010,1,3,0)
 ;;=3^Open bite, right great toe w/o damage to nail, init encntr
 ;;^UTILITY(U,$J,358.3,8010,1,4,0)
 ;;=4^S91.151A
 ;;^UTILITY(U,$J,358.3,8010,2)
 ;;=^5044243
 ;;^UTILITY(U,$J,358.3,8011,0)
 ;;=S91.152A^^33^431^142
 ;;^UTILITY(U,$J,358.3,8011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8011,1,3,0)
 ;;=3^Open bite, left great toe w/o damage to nail, init encntr
 ;;^UTILITY(U,$J,358.3,8011,1,4,0)
 ;;=4^S91.152A
 ;;^UTILITY(U,$J,358.3,8011,2)
 ;;=^5044246
 ;;^UTILITY(U,$J,358.3,8012,0)
 ;;=S91.154A^^33^431^152
 ;;^UTILITY(U,$J,358.3,8012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8012,1,3,0)
 ;;=3^Open bite, right lesser toe(s) w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8012,1,4,0)
 ;;=4^S91.154A
 ;;^UTILITY(U,$J,358.3,8012,2)
 ;;=^5044252
 ;;^UTILITY(U,$J,358.3,8013,0)
 ;;=S91.155A^^33^431^144
 ;;^UTILITY(U,$J,358.3,8013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8013,1,3,0)
 ;;=3^Open bite, left lesser toe(s) w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8013,1,4,0)
 ;;=4^S91.155A
 ;;^UTILITY(U,$J,358.3,8013,2)
 ;;=^5044255
