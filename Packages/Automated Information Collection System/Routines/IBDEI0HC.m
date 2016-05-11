IBDEI0HC ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8026,0)
 ;;=T23.302A^^33^431^40
 ;;^UTILITY(U,$J,358.3,8026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8026,1,3,0)
 ;;=3^Burn third degree of left hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,8026,1,4,0)
 ;;=4^T23.302A
 ;;^UTILITY(U,$J,358.3,8026,2)
 ;;=^5047815
 ;;^UTILITY(U,$J,358.3,8027,0)
 ;;=T79.A11A^^33^431^248
 ;;^UTILITY(U,$J,358.3,8027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8027,1,3,0)
 ;;=3^Traumatic compartment syndrome of right upper extrem, init
 ;;^UTILITY(U,$J,358.3,8027,1,4,0)
 ;;=4^T79.A11A
 ;;^UTILITY(U,$J,358.3,8027,2)
 ;;=^5054326
 ;;^UTILITY(U,$J,358.3,8028,0)
 ;;=T79.A12A^^33^431^247
 ;;^UTILITY(U,$J,358.3,8028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8028,1,3,0)
 ;;=3^Traumatic compartment syndrome of left upper extremity, init
 ;;^UTILITY(U,$J,358.3,8028,1,4,0)
 ;;=4^T79.A12A
 ;;^UTILITY(U,$J,358.3,8028,2)
 ;;=^5054329
 ;;^UTILITY(U,$J,358.3,8029,0)
 ;;=S06.0X9A^^33^431^44
 ;;^UTILITY(U,$J,358.3,8029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8029,1,3,0)
 ;;=3^Concussion w loss of consciousness of unsp duration, init
 ;;^UTILITY(U,$J,358.3,8029,1,4,0)
 ;;=4^S06.0X9A
 ;;^UTILITY(U,$J,358.3,8029,2)
 ;;=^5020693
 ;;^UTILITY(U,$J,358.3,8030,0)
 ;;=S60.152A^^33^431^50
 ;;^UTILITY(U,$J,358.3,8030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8030,1,3,0)
 ;;=3^Contusion of left little finger w damage to nail, init
 ;;^UTILITY(U,$J,358.3,8030,1,4,0)
 ;;=4^S60.152A
 ;;^UTILITY(U,$J,358.3,8030,2)
 ;;=^5135669
 ;;^UTILITY(U,$J,358.3,8031,0)
 ;;=S50.11XA^^33^431^52
 ;;^UTILITY(U,$J,358.3,8031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8031,1,3,0)
 ;;=3^Contusion of right forearm, initial encounter
 ;;^UTILITY(U,$J,358.3,8031,1,4,0)
 ;;=4^S50.11XA
 ;;^UTILITY(U,$J,358.3,8031,2)
 ;;=^5028494
 ;;^UTILITY(U,$J,358.3,8032,0)
 ;;=S50.12XA^^33^431^47
 ;;^UTILITY(U,$J,358.3,8032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8032,1,3,0)
 ;;=3^Contusion of left forearm, initial encounter
 ;;^UTILITY(U,$J,358.3,8032,1,4,0)
 ;;=4^S50.12XA
 ;;^UTILITY(U,$J,358.3,8032,2)
 ;;=^5028497
 ;;^UTILITY(U,$J,358.3,8033,0)
 ;;=S60.221A^^33^431^53
 ;;^UTILITY(U,$J,358.3,8033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8033,1,3,0)
 ;;=3^Contusion of right hand, initial encounter
 ;;^UTILITY(U,$J,358.3,8033,1,4,0)
 ;;=4^S60.221A
 ;;^UTILITY(U,$J,358.3,8033,2)
 ;;=^5032276
 ;;^UTILITY(U,$J,358.3,8034,0)
 ;;=S60.222A^^33^431^48
 ;;^UTILITY(U,$J,358.3,8034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8034,1,3,0)
 ;;=3^Contusion of left hand, initial encounter
 ;;^UTILITY(U,$J,358.3,8034,1,4,0)
 ;;=4^S60.222A
 ;;^UTILITY(U,$J,358.3,8034,2)
 ;;=^5032279
 ;;^UTILITY(U,$J,358.3,8035,0)
 ;;=S80.01XA^^33^431^54
 ;;^UTILITY(U,$J,358.3,8035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8035,1,3,0)
 ;;=3^Contusion of right knee, initial encounter
 ;;^UTILITY(U,$J,358.3,8035,1,4,0)
 ;;=4^S80.01XA
 ;;^UTILITY(U,$J,358.3,8035,2)
 ;;=^5039891
 ;;^UTILITY(U,$J,358.3,8036,0)
 ;;=S80.02XA^^33^431^49
 ;;^UTILITY(U,$J,358.3,8036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8036,1,3,0)
 ;;=3^Contusion of left knee, initial encounter
 ;;^UTILITY(U,$J,358.3,8036,1,4,0)
 ;;=4^S80.02XA
 ;;^UTILITY(U,$J,358.3,8036,2)
 ;;=^5039894
 ;;^UTILITY(U,$J,358.3,8037,0)
 ;;=S80.11XA^^33^431^55
 ;;^UTILITY(U,$J,358.3,8037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8037,1,3,0)
 ;;=3^Contusion of right lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,8037,1,4,0)
 ;;=4^S80.11XA
 ;;^UTILITY(U,$J,358.3,8037,2)
 ;;=^5039900
 ;;^UTILITY(U,$J,358.3,8038,0)
 ;;=S80.12XA^^33^431^51
 ;;^UTILITY(U,$J,358.3,8038,1,0)
 ;;=^358.31IA^4^2
