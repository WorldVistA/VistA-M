IBDEI06F ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8013,1,3,0)
 ;;=3^Fx of left foot unspec, init encntr for closed fx
 ;;^UTILITY(U,$J,358.3,8013,1,4,0)
 ;;=4^S92.902A
 ;;^UTILITY(U,$J,358.3,8013,2)
 ;;=^5045585
 ;;^UTILITY(U,$J,358.3,8014,0)
 ;;=S42.301A^^29^437^81
 ;;^UTILITY(U,$J,358.3,8014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8014,1,3,0)
 ;;=3^Fx of right humerus shaft humerus unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8014,1,4,0)
 ;;=4^S42.301A
 ;;^UTILITY(U,$J,358.3,8014,2)
 ;;=^5027031
 ;;^UTILITY(U,$J,358.3,8015,0)
 ;;=S42.302A^^29^437^68
 ;;^UTILITY(U,$J,358.3,8015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8015,1,3,0)
 ;;=3^Fx of left humerus shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8015,1,4,0)
 ;;=4^S42.302A
 ;;^UTILITY(U,$J,358.3,8015,2)
 ;;=^5027038
 ;;^UTILITY(U,$J,358.3,8016,0)
 ;;=S92.301A^^29^437^91
 ;;^UTILITY(U,$J,358.3,8016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8016,1,3,0)
 ;;=3^Fx of unsp metatarsal bone(s), right foot, init
 ;;^UTILITY(U,$J,358.3,8016,1,4,0)
 ;;=4^S92.301A
 ;;^UTILITY(U,$J,358.3,8016,2)
 ;;=^5045046
 ;;^UTILITY(U,$J,358.3,8017,0)
 ;;=S92.302A^^29^437^90
 ;;^UTILITY(U,$J,358.3,8017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8017,1,3,0)
 ;;=3^Fx of unsp metatarsal bone(s), left foot, init
 ;;^UTILITY(U,$J,358.3,8017,1,4,0)
 ;;=4^S92.302A
 ;;^UTILITY(U,$J,358.3,8017,2)
 ;;=^5045053
 ;;^UTILITY(U,$J,358.3,8018,0)
 ;;=S82.001A^^29^437^83
 ;;^UTILITY(U,$J,358.3,8018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8018,1,3,0)
 ;;=3^Fx of right patella unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8018,1,4,0)
 ;;=4^S82.001A
 ;;^UTILITY(U,$J,358.3,8018,2)
 ;;=^5040104
 ;;^UTILITY(U,$J,358.3,8019,0)
 ;;=S82.002A^^29^437^70
 ;;^UTILITY(U,$J,358.3,8019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8019,1,3,0)
 ;;=3^Fx of left patella unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8019,1,4,0)
 ;;=4^S82.002A
 ;;^UTILITY(U,$J,358.3,8019,2)
 ;;=^5040120
 ;;^UTILITY(U,$J,358.3,8020,0)
 ;;=S52.91XA^^29^437^80
 ;;^UTILITY(U,$J,358.3,8020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8020,1,3,0)
 ;;=3^Fx of right forearm unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8020,1,4,0)
 ;;=4^S52.91XA
 ;;^UTILITY(U,$J,358.3,8020,2)
 ;;=^5031158
 ;;^UTILITY(U,$J,358.3,8021,0)
 ;;=S52.92XA^^29^437^67
 ;;^UTILITY(U,$J,358.3,8021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8021,1,3,0)
 ;;=3^Fx of left forearm unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8021,1,4,0)
 ;;=4^S52.92XA
 ;;^UTILITY(U,$J,358.3,8021,2)
 ;;=^5031174
 ;;^UTILITY(U,$J,358.3,8022,0)
 ;;=S22.31XA^^29^437^76
 ;;^UTILITY(U,$J,358.3,8022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8022,1,3,0)
 ;;=3^Fx of one rib, right side, init for clos fx
 ;;^UTILITY(U,$J,358.3,8022,1,4,0)
 ;;=4^S22.31XA
 ;;^UTILITY(U,$J,358.3,8022,2)
 ;;=^5023105
 ;;^UTILITY(U,$J,358.3,8023,0)
 ;;=S22.32XA^^29^437^75
 ;;^UTILITY(U,$J,358.3,8023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8023,1,3,0)
 ;;=3^Fx of one rib, left side, init for clos fx
 ;;^UTILITY(U,$J,358.3,8023,1,4,0)
 ;;=4^S22.32XA
 ;;^UTILITY(U,$J,358.3,8023,2)
 ;;=^5023111
 ;;^UTILITY(U,$J,358.3,8024,0)
 ;;=S42.91XA^^29^437^84
 ;;^UTILITY(U,$J,358.3,8024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8024,1,3,0)
 ;;=3^Fx of right shoulder girdle, part unsp, init
 ;;^UTILITY(U,$J,358.3,8024,1,4,0)
 ;;=4^S42.91XA
 ;;^UTILITY(U,$J,358.3,8024,2)
 ;;=^5027643
 ;;^UTILITY(U,$J,358.3,8025,0)
 ;;=S42.92XA^^29^437^71
 ;;^UTILITY(U,$J,358.3,8025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8025,1,3,0)
 ;;=3^Fx of left shoulder girdle, part unsp, init
 ;;^UTILITY(U,$J,358.3,8025,1,4,0)
 ;;=4^S42.92XA
 ;;^UTILITY(U,$J,358.3,8025,2)
 ;;=^5027650
 ;;^UTILITY(U,$J,358.3,8026,0)
 ;;=S42.101A^^29^437^95
 ;;^UTILITY(U,$J,358.3,8026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8026,1,3,0)
 ;;=3^Fx of unsp part of scapula, right shoulder, init
 ;;^UTILITY(U,$J,358.3,8026,1,4,0)
 ;;=4^S42.101A
 ;;^UTILITY(U,$J,358.3,8026,2)
 ;;=^5026530
 ;;^UTILITY(U,$J,358.3,8027,0)
 ;;=S42.102A^^29^437^94
 ;;^UTILITY(U,$J,358.3,8027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8027,1,3,0)
 ;;=3^Fx of unsp part of scapula, left shoulder, init
 ;;^UTILITY(U,$J,358.3,8027,1,4,0)
 ;;=4^S42.102A
 ;;^UTILITY(U,$J,358.3,8027,2)
 ;;=^5026537
 ;;^UTILITY(U,$J,358.3,8028,0)
 ;;=S92.201A^^29^437^107
 ;;^UTILITY(U,$J,358.3,8028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8028,1,3,0)
 ;;=3^Fx of unsp tarsal bone(s) of right foot, init
 ;;^UTILITY(U,$J,358.3,8028,1,4,0)
 ;;=4^S92.201A
 ;;^UTILITY(U,$J,358.3,8028,2)
 ;;=^5044822
 ;;^UTILITY(U,$J,358.3,8029,0)
 ;;=S92.202A^^29^437^106
 ;;^UTILITY(U,$J,358.3,8029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8029,1,3,0)
 ;;=3^Fx of unsp tarsal bone(s) of left foot, init
 ;;^UTILITY(U,$J,358.3,8029,1,4,0)
 ;;=4^S92.202A
 ;;^UTILITY(U,$J,358.3,8029,2)
 ;;=^5044829
 ;;^UTILITY(U,$J,358.3,8030,0)
 ;;=S62.501A^^29^437^105
 ;;^UTILITY(U,$J,358.3,8030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8030,1,3,0)
 ;;=3^Fx of unsp phalanx of right thumb, init for clos fx
 ;;^UTILITY(U,$J,358.3,8030,1,4,0)
 ;;=4^S62.501A
 ;;^UTILITY(U,$J,358.3,8030,2)
 ;;=^5034284
 ;;^UTILITY(U,$J,358.3,8031,0)
 ;;=S62.502A^^29^437^100
 ;;^UTILITY(U,$J,358.3,8031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8031,1,3,0)
 ;;=3^Fx of unsp phalanx of left thumb, init for clos fx
 ;;^UTILITY(U,$J,358.3,8031,1,4,0)
 ;;=4^S62.502A
 ;;^UTILITY(U,$J,358.3,8031,2)
 ;;=^5034291
 ;;^UTILITY(U,$J,358.3,8032,0)
 ;;=S82.201A^^29^437^85
 ;;^UTILITY(U,$J,358.3,8032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8032,1,3,0)
 ;;=3^Fx of right tibia shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8032,1,4,0)
 ;;=4^S82.201A
 ;;^UTILITY(U,$J,358.3,8032,2)
 ;;=^5041102
 ;;^UTILITY(U,$J,358.3,8033,0)
 ;;=S82.202A^^29^437^72
 ;;^UTILITY(U,$J,358.3,8033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8033,1,3,0)
 ;;=3^Fx of left tibia shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8033,1,4,0)
 ;;=4^S82.202A
 ;;^UTILITY(U,$J,358.3,8033,2)
 ;;=^5041118
 ;;^UTILITY(U,$J,358.3,8034,0)
 ;;=S92.911A^^29^437^86
 ;;^UTILITY(U,$J,358.3,8034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8034,1,3,0)
 ;;=3^Fx of right toe(s) unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8034,1,4,0)
 ;;=4^S92.911A
 ;;^UTILITY(U,$J,358.3,8034,2)
 ;;=^5045592
 ;;^UTILITY(U,$J,358.3,8035,0)
 ;;=S92.912A^^29^437^73
 ;;^UTILITY(U,$J,358.3,8035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8035,1,3,0)
 ;;=3^Fx of left toe(s) unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8035,1,4,0)
 ;;=4^S92.912A
 ;;^UTILITY(U,$J,358.3,8035,2)
 ;;=^5045599
 ;;^UTILITY(U,$J,358.3,8036,0)
 ;;=S52.201A^^29^437^87
 ;;^UTILITY(U,$J,358.3,8036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8036,1,3,0)
 ;;=3^Fx of right ulna shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8036,1,4,0)
 ;;=4^S52.201A
 ;;^UTILITY(U,$J,358.3,8036,2)
 ;;=^5029260
 ;;^UTILITY(U,$J,358.3,8037,0)
 ;;=S52.202A^^29^437^74
 ;;^UTILITY(U,$J,358.3,8037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8037,1,3,0)
 ;;=3^Fx of left ulna shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8037,1,4,0)
 ;;=4^S52.202A
 ;;^UTILITY(U,$J,358.3,8037,2)
 ;;=^5029276
 ;;^UTILITY(U,$J,358.3,8038,0)
 ;;=T59.91XA^^29^437^245
 ;;^UTILITY(U,$J,358.3,8038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8038,1,3,0)
 ;;=3^Toxic effect of unsp gases, fumes and vapors, acc, init
 ;;^UTILITY(U,$J,358.3,8038,1,4,0)
 ;;=4^T59.91XA
 ;;^UTILITY(U,$J,358.3,8038,2)
 ;;=^5053042
 ;;^UTILITY(U,$J,358.3,8039,0)
 ;;=S41.111A^^29^437^135
 ;;^UTILITY(U,$J,358.3,8039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8039,1,3,0)
 ;;=3^Laceration w/o fb of right upper arm, init encntr
 ;;^UTILITY(U,$J,358.3,8039,1,4,0)
 ;;=4^S41.111A
 ;;^UTILITY(U,$J,358.3,8039,2)
 ;;=^5026336
 ;;^UTILITY(U,$J,358.3,8040,0)
 ;;=S41.112A^^29^437^123
 ;;^UTILITY(U,$J,358.3,8040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8040,1,3,0)
 ;;=3^Laceration w/o fb of left upper arm, init encntr
 ;;^UTILITY(U,$J,358.3,8040,1,4,0)
 ;;=4^S41.112A
 ;;^UTILITY(U,$J,358.3,8040,2)
 ;;=^5026339
 ;;^UTILITY(U,$J,358.3,8041,0)
 ;;=S61.210A^^29^437^128
 ;;^UTILITY(U,$J,358.3,8041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8041,1,3,0)
 ;;=3^Laceration w/o fb of right indx fngr w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8041,1,4,0)
 ;;=4^S61.210A
 ;;^UTILITY(U,$J,358.3,8041,2)
 ;;=^5032771
 ;;^UTILITY(U,$J,358.3,8042,0)
 ;;=S61.211A^^29^437^116
 ;;^UTILITY(U,$J,358.3,8042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8042,1,3,0)
 ;;=3^Laceration w/o fb of left indx fngr w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8042,1,4,0)
 ;;=4^S61.211A
 ;;^UTILITY(U,$J,358.3,8042,2)
 ;;=^5032774
 ;;^UTILITY(U,$J,358.3,8043,0)
 ;;=S61.212A^^29^437^132
 ;;^UTILITY(U,$J,358.3,8043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8043,1,3,0)
 ;;=3^Laceration w/o fb of right mid finger w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8043,1,4,0)
 ;;=4^S61.212A
 ;;^UTILITY(U,$J,358.3,8043,2)
 ;;=^5032777
 ;;^UTILITY(U,$J,358.3,8044,0)
 ;;=S61.213A^^29^437^120
 ;;^UTILITY(U,$J,358.3,8044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8044,1,3,0)
 ;;=3^Laceration w/o fb of left mid finger w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8044,1,4,0)
 ;;=4^S61.213A
 ;;^UTILITY(U,$J,358.3,8044,2)
 ;;=^5032780
 ;;^UTILITY(U,$J,358.3,8045,0)
 ;;=S61.214A^^29^437^133
 ;;^UTILITY(U,$J,358.3,8045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8045,1,3,0)
 ;;=3^Laceration w/o fb of right rng fngr w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8045,1,4,0)
 ;;=4^S61.214A
 ;;^UTILITY(U,$J,358.3,8045,2)
 ;;=^5032783
 ;;^UTILITY(U,$J,358.3,8046,0)
 ;;=S61.215A^^29^437^121
 ;;^UTILITY(U,$J,358.3,8046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8046,1,3,0)
 ;;=3^Laceration w/o fb of left rng fngr w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,8046,1,4,0)
 ;;=4^S61.215A
