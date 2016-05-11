IBDEI0HF ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8063,1,3,0)
 ;;=3^Fx of left foot unspec, init encntr for closed fx
 ;;^UTILITY(U,$J,358.3,8063,1,4,0)
 ;;=4^S92.902A
 ;;^UTILITY(U,$J,358.3,8063,2)
 ;;=^5045585
 ;;^UTILITY(U,$J,358.3,8064,0)
 ;;=S42.301A^^33^431^81
 ;;^UTILITY(U,$J,358.3,8064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8064,1,3,0)
 ;;=3^Fx of right humerus shaft humerus unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8064,1,4,0)
 ;;=4^S42.301A
 ;;^UTILITY(U,$J,358.3,8064,2)
 ;;=^5027031
 ;;^UTILITY(U,$J,358.3,8065,0)
 ;;=S42.302A^^33^431^68
 ;;^UTILITY(U,$J,358.3,8065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8065,1,3,0)
 ;;=3^Fx of left humerus shaft unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8065,1,4,0)
 ;;=4^S42.302A
 ;;^UTILITY(U,$J,358.3,8065,2)
 ;;=^5027038
 ;;^UTILITY(U,$J,358.3,8066,0)
 ;;=S92.301A^^33^431^91
 ;;^UTILITY(U,$J,358.3,8066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8066,1,3,0)
 ;;=3^Fx of unsp metatarsal bone(s), right foot, init
 ;;^UTILITY(U,$J,358.3,8066,1,4,0)
 ;;=4^S92.301A
 ;;^UTILITY(U,$J,358.3,8066,2)
 ;;=^5045046
 ;;^UTILITY(U,$J,358.3,8067,0)
 ;;=S92.302A^^33^431^90
 ;;^UTILITY(U,$J,358.3,8067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8067,1,3,0)
 ;;=3^Fx of unsp metatarsal bone(s), left foot, init
 ;;^UTILITY(U,$J,358.3,8067,1,4,0)
 ;;=4^S92.302A
 ;;^UTILITY(U,$J,358.3,8067,2)
 ;;=^5045053
 ;;^UTILITY(U,$J,358.3,8068,0)
 ;;=S82.001A^^33^431^83
 ;;^UTILITY(U,$J,358.3,8068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8068,1,3,0)
 ;;=3^Fx of right patella unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8068,1,4,0)
 ;;=4^S82.001A
 ;;^UTILITY(U,$J,358.3,8068,2)
 ;;=^5040104
 ;;^UTILITY(U,$J,358.3,8069,0)
 ;;=S82.002A^^33^431^70
 ;;^UTILITY(U,$J,358.3,8069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8069,1,3,0)
 ;;=3^Fx of left patella unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8069,1,4,0)
 ;;=4^S82.002A
 ;;^UTILITY(U,$J,358.3,8069,2)
 ;;=^5040120
 ;;^UTILITY(U,$J,358.3,8070,0)
 ;;=S52.91XA^^33^431^80
 ;;^UTILITY(U,$J,358.3,8070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8070,1,3,0)
 ;;=3^Fx of right forearm unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8070,1,4,0)
 ;;=4^S52.91XA
 ;;^UTILITY(U,$J,358.3,8070,2)
 ;;=^5031158
 ;;^UTILITY(U,$J,358.3,8071,0)
 ;;=S52.92XA^^33^431^67
 ;;^UTILITY(U,$J,358.3,8071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8071,1,3,0)
 ;;=3^Fx of left forearm unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,8071,1,4,0)
 ;;=4^S52.92XA
 ;;^UTILITY(U,$J,358.3,8071,2)
 ;;=^5031174
 ;;^UTILITY(U,$J,358.3,8072,0)
 ;;=S22.31XA^^33^431^76
 ;;^UTILITY(U,$J,358.3,8072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8072,1,3,0)
 ;;=3^Fx of one rib, right side, init for clos fx
 ;;^UTILITY(U,$J,358.3,8072,1,4,0)
 ;;=4^S22.31XA
 ;;^UTILITY(U,$J,358.3,8072,2)
 ;;=^5023105
 ;;^UTILITY(U,$J,358.3,8073,0)
 ;;=S22.32XA^^33^431^75
 ;;^UTILITY(U,$J,358.3,8073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8073,1,3,0)
 ;;=3^Fx of one rib, left side, init for clos fx
 ;;^UTILITY(U,$J,358.3,8073,1,4,0)
 ;;=4^S22.32XA
 ;;^UTILITY(U,$J,358.3,8073,2)
 ;;=^5023111
 ;;^UTILITY(U,$J,358.3,8074,0)
 ;;=S42.91XA^^33^431^84
 ;;^UTILITY(U,$J,358.3,8074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8074,1,3,0)
 ;;=3^Fx of right shoulder girdle, part unsp, init
 ;;^UTILITY(U,$J,358.3,8074,1,4,0)
 ;;=4^S42.91XA
 ;;^UTILITY(U,$J,358.3,8074,2)
 ;;=^5027643
 ;;^UTILITY(U,$J,358.3,8075,0)
 ;;=S42.92XA^^33^431^71
 ;;^UTILITY(U,$J,358.3,8075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8075,1,3,0)
 ;;=3^Fx of left shoulder girdle, part unsp, init
