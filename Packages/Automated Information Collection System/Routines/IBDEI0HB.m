IBDEI0HB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8014,0)
 ;;=S90.425A^^33^431^31
 ;;^UTILITY(U,$J,358.3,8014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8014,1,3,0)
 ;;=3^Blister (nonthermal), left lesser toe(s), initial encounter
 ;;^UTILITY(U,$J,358.3,8014,1,4,0)
 ;;=4^S90.425A
 ;;^UTILITY(U,$J,358.3,8014,2)
 ;;=^5043919
 ;;^UTILITY(U,$J,358.3,8015,0)
 ;;=T23.121A^^33^431^35
 ;;^UTILITY(U,$J,358.3,8015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8015,1,3,0)
 ;;=3^Burn first degree of single r finger except thumb, init
 ;;^UTILITY(U,$J,358.3,8015,1,4,0)
 ;;=4^T23.121A
 ;;^UTILITY(U,$J,358.3,8015,2)
 ;;=^5047671
 ;;^UTILITY(U,$J,358.3,8016,0)
 ;;=T23.122A^^33^431^34
 ;;^UTILITY(U,$J,358.3,8016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8016,1,3,0)
 ;;=3^Burn first degree of single l finger except thumb, init
 ;;^UTILITY(U,$J,358.3,8016,1,4,0)
 ;;=4^T23.122A
 ;;^UTILITY(U,$J,358.3,8016,2)
 ;;=^5047674
 ;;^UTILITY(U,$J,358.3,8017,0)
 ;;=T23.221A^^33^431^39
 ;;^UTILITY(U,$J,358.3,8017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8017,1,3,0)
 ;;=3^Burn second degree of single r finger except thumb, init
 ;;^UTILITY(U,$J,358.3,8017,1,4,0)
 ;;=4^T23.221A
 ;;^UTILITY(U,$J,358.3,8017,2)
 ;;=^5047749
 ;;^UTILITY(U,$J,358.3,8018,0)
 ;;=T23.222A^^33^431^38
 ;;^UTILITY(U,$J,358.3,8018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8018,1,3,0)
 ;;=3^Burn second degree of single l finger except thumb, init
 ;;^UTILITY(U,$J,358.3,8018,1,4,0)
 ;;=4^T23.222A
 ;;^UTILITY(U,$J,358.3,8018,2)
 ;;=^5047752
 ;;^UTILITY(U,$J,358.3,8019,0)
 ;;=T23.321A^^33^431^43
 ;;^UTILITY(U,$J,358.3,8019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8019,1,3,0)
 ;;=3^Burn third degree of single r finger except thumb, init
 ;;^UTILITY(U,$J,358.3,8019,1,4,0)
 ;;=4^T23.321A
 ;;^UTILITY(U,$J,358.3,8019,2)
 ;;=^5047827
 ;;^UTILITY(U,$J,358.3,8020,0)
 ;;=T23.322A^^33^431^42
 ;;^UTILITY(U,$J,358.3,8020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8020,1,3,0)
 ;;=3^Burn third degree of single l finger except thumb, init
 ;;^UTILITY(U,$J,358.3,8020,1,4,0)
 ;;=4^T23.322A
 ;;^UTILITY(U,$J,358.3,8020,2)
 ;;=^5047830
 ;;^UTILITY(U,$J,358.3,8021,0)
 ;;=T23.101A^^33^431^33
 ;;^UTILITY(U,$J,358.3,8021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8021,1,3,0)
 ;;=3^Burn first degree of right hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,8021,1,4,0)
 ;;=4^T23.101A
 ;;^UTILITY(U,$J,358.3,8021,2)
 ;;=^5047656
 ;;^UTILITY(U,$J,358.3,8022,0)
 ;;=T23.102A^^33^431^32
 ;;^UTILITY(U,$J,358.3,8022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8022,1,3,0)
 ;;=3^Burn first degree of left hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,8022,1,4,0)
 ;;=4^T23.102A
 ;;^UTILITY(U,$J,358.3,8022,2)
 ;;=^5047659
 ;;^UTILITY(U,$J,358.3,8023,0)
 ;;=T23.201A^^33^431^37
 ;;^UTILITY(U,$J,358.3,8023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8023,1,3,0)
 ;;=3^Burn second degree of right hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,8023,1,4,0)
 ;;=4^T23.201A
 ;;^UTILITY(U,$J,358.3,8023,2)
 ;;=^5047734
 ;;^UTILITY(U,$J,358.3,8024,0)
 ;;=T23.202A^^33^431^36
 ;;^UTILITY(U,$J,358.3,8024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8024,1,3,0)
 ;;=3^Burn second degree of left hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,8024,1,4,0)
 ;;=4^T23.202A
 ;;^UTILITY(U,$J,358.3,8024,2)
 ;;=^5047737
 ;;^UTILITY(U,$J,358.3,8025,0)
 ;;=T23.301A^^33^431^41
 ;;^UTILITY(U,$J,358.3,8025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8025,1,3,0)
 ;;=3^Burn third degree of right hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,8025,1,4,0)
 ;;=4^T23.301A
 ;;^UTILITY(U,$J,358.3,8025,2)
 ;;=^5047812
