IBDEI0HH ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8088,1,3,0)
 ;;=3^Toxic effect of unsp gases, fumes and vapors, acc, init
 ;;^UTILITY(U,$J,358.3,8088,1,4,0)
 ;;=4^T59.91XA
 ;;^UTILITY(U,$J,358.3,8088,2)
 ;;=^5053042
 ;;^UTILITY(U,$J,358.3,8089,0)
 ;;=S41.111A^^33^431^135
 ;;^UTILITY(U,$J,358.3,8089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8089,1,3,0)
 ;;=3^Laceration w/o fb of right upper arm, init encntr
 ;;^UTILITY(U,$J,358.3,8089,1,4,0)
 ;;=4^S41.111A
 ;;^UTILITY(U,$J,358.3,8089,2)
 ;;=^5026336
 ;;^UTILITY(U,$J,358.3,8090,0)
 ;;=S41.112A^^33^431^123
 ;;^UTILITY(U,$J,358.3,8090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8090,1,3,0)
 ;;=3^Laceration w/o fb of left upper arm, init encntr
 ;;^UTILITY(U,$J,358.3,8090,1,4,0)
 ;;=4^S41.112A
 ;;^UTILITY(U,$J,358.3,8090,2)
 ;;=^5026339
 ;;^UTILITY(U,$J,358.3,8091,0)
 ;;=S61.210A^^33^431^128
 ;;^UTILITY(U,$J,358.3,8091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8091,1,3,0)
 ;;=3^Laceration w/o fb of right indx fngr w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8091,1,4,0)
 ;;=4^S61.210A
 ;;^UTILITY(U,$J,358.3,8091,2)
 ;;=^5032771
 ;;^UTILITY(U,$J,358.3,8092,0)
 ;;=S61.211A^^33^431^116
 ;;^UTILITY(U,$J,358.3,8092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8092,1,3,0)
 ;;=3^Laceration w/o fb of left indx fngr w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8092,1,4,0)
 ;;=4^S61.211A
 ;;^UTILITY(U,$J,358.3,8092,2)
 ;;=^5032774
 ;;^UTILITY(U,$J,358.3,8093,0)
 ;;=S61.212A^^33^431^132
 ;;^UTILITY(U,$J,358.3,8093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8093,1,3,0)
 ;;=3^Laceration w/o fb of right mid finger w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8093,1,4,0)
 ;;=4^S61.212A
 ;;^UTILITY(U,$J,358.3,8093,2)
 ;;=^5032777
 ;;^UTILITY(U,$J,358.3,8094,0)
 ;;=S61.213A^^33^431^120
 ;;^UTILITY(U,$J,358.3,8094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8094,1,3,0)
 ;;=3^Laceration w/o fb of left mid finger w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8094,1,4,0)
 ;;=4^S61.213A
 ;;^UTILITY(U,$J,358.3,8094,2)
 ;;=^5032780
 ;;^UTILITY(U,$J,358.3,8095,0)
 ;;=S61.214A^^33^431^133
 ;;^UTILITY(U,$J,358.3,8095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8095,1,3,0)
 ;;=3^Laceration w/o fb of right rng fngr w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8095,1,4,0)
 ;;=4^S61.214A
 ;;^UTILITY(U,$J,358.3,8095,2)
 ;;=^5032783
 ;;^UTILITY(U,$J,358.3,8096,0)
 ;;=S61.215A^^33^431^121
 ;;^UTILITY(U,$J,358.3,8096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8096,1,3,0)
 ;;=3^Laceration w/o fb of left rng fngr w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8096,1,4,0)
 ;;=4^S61.215A
 ;;^UTILITY(U,$J,358.3,8096,2)
 ;;=^5032786
 ;;^UTILITY(U,$J,358.3,8097,0)
 ;;=S61.216A^^33^431^130
 ;;^UTILITY(U,$J,358.3,8097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8097,1,3,0)
 ;;=3^Laceration w/o fb of right litttle finger w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8097,1,4,0)
 ;;=4^S61.216A
 ;;^UTILITY(U,$J,358.3,8097,2)
 ;;=^5032789
 ;;^UTILITY(U,$J,358.3,8098,0)
 ;;=S61.217A^^33^431^118
 ;;^UTILITY(U,$J,358.3,8098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8098,1,3,0)
 ;;=3^Laceration w/o fb of left little finger w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8098,1,4,0)
 ;;=4^S61.217A
 ;;^UTILITY(U,$J,358.3,8098,2)
 ;;=^5032792
 ;;^UTILITY(U,$J,358.3,8099,0)
 ;;=S91.311A^^33^431^124
 ;;^UTILITY(U,$J,358.3,8099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8099,1,3,0)
 ;;=3^Laceration w/o fb of right foot, init encntr
 ;;^UTILITY(U,$J,358.3,8099,1,4,0)
 ;;=4^S91.311A
 ;;^UTILITY(U,$J,358.3,8099,2)
 ;;=^5044320
 ;;^UTILITY(U,$J,358.3,8100,0)
 ;;=S91.312A^^33^431^112
