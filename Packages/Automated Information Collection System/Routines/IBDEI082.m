IBDEI082 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3472,2)
 ;;=^5013363
 ;;^UTILITY(U,$J,358.3,3473,0)
 ;;=M80.00XG^^18^219^128
 ;;^UTILITY(U,$J,358.3,3473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3473,1,3,0)
 ;;=3^Osteoporosis,Age-Related Fx,Unspec Site,Delayed Healing
 ;;^UTILITY(U,$J,358.3,3473,1,4,0)
 ;;=4^M80.00XG
 ;;^UTILITY(U,$J,358.3,3473,2)
 ;;=^5013365
 ;;^UTILITY(U,$J,358.3,3474,0)
 ;;=M80.00XP^^18^219^129
 ;;^UTILITY(U,$J,358.3,3474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3474,1,3,0)
 ;;=3^Osteoporosis,Age-Related Fx,Unspec Site,Malunion
 ;;^UTILITY(U,$J,358.3,3474,1,4,0)
 ;;=4^M80.00XP
 ;;^UTILITY(U,$J,358.3,3474,2)
 ;;=^5013367
 ;;^UTILITY(U,$J,358.3,3475,0)
 ;;=M80.00XK^^18^219^130
 ;;^UTILITY(U,$J,358.3,3475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3475,1,3,0)
 ;;=3^Osteoporosis,Age-Related Fx,Unspec Site,Nonunion
 ;;^UTILITY(U,$J,358.3,3475,1,4,0)
 ;;=4^M80.00XK
 ;;^UTILITY(U,$J,358.3,3475,2)
 ;;=^5013366
 ;;^UTILITY(U,$J,358.3,3476,0)
 ;;=M80.00XD^^18^219^131
 ;;^UTILITY(U,$J,358.3,3476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3476,1,3,0)
 ;;=3^Osteoporosis,Age-Related Fx,Unspec Site,Routine Healing
 ;;^UTILITY(U,$J,358.3,3476,1,4,0)
 ;;=4^M80.00XD
 ;;^UTILITY(U,$J,358.3,3476,2)
 ;;=^5013364
 ;;^UTILITY(U,$J,358.3,3477,0)
 ;;=M80.00XS^^18^219^132
 ;;^UTILITY(U,$J,358.3,3477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3477,1,3,0)
 ;;=3^Osteoporosis,Age-Related Fx,Unspec Site,Sequela
 ;;^UTILITY(U,$J,358.3,3477,1,4,0)
 ;;=4^M80.00XS
 ;;^UTILITY(U,$J,358.3,3477,2)
 ;;=^5013368
 ;;^UTILITY(U,$J,358.3,3478,0)
 ;;=M81.0^^18^219^126
 ;;^UTILITY(U,$J,358.3,3478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3478,1,3,0)
 ;;=3^Osteoporosis,Age-Related
 ;;^UTILITY(U,$J,358.3,3478,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,3478,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,3479,0)
 ;;=Z87.310^^18^219^137
 ;;^UTILITY(U,$J,358.3,3479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3479,1,3,0)
 ;;=3^Personal Hx of Healed Osteoporosis Fx
 ;;^UTILITY(U,$J,358.3,3479,1,4,0)
 ;;=4^Z87.310
 ;;^UTILITY(U,$J,358.3,3479,2)
 ;;=^5063485
 ;;^UTILITY(U,$J,358.3,3480,0)
 ;;=M81.6^^18^219^133
 ;;^UTILITY(U,$J,358.3,3480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3480,1,3,0)
 ;;=3^Osteoporosis,Localized
 ;;^UTILITY(U,$J,358.3,3480,1,4,0)
 ;;=4^M81.6
 ;;^UTILITY(U,$J,358.3,3480,2)
 ;;=^5013556
 ;;^UTILITY(U,$J,358.3,3481,0)
 ;;=M54.00^^18^219^134
 ;;^UTILITY(U,$J,358.3,3481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3481,1,3,0)
 ;;=3^Panniculitis,Neck/Back,Unspec Site
 ;;^UTILITY(U,$J,358.3,3481,1,4,0)
 ;;=4^M54.00
 ;;^UTILITY(U,$J,358.3,3481,2)
 ;;=^5012285
 ;;^UTILITY(U,$J,358.3,3482,0)
 ;;=M79.3^^18^219^135
 ;;^UTILITY(U,$J,358.3,3482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3482,1,3,0)
 ;;=3^Panniculitis,Unspec
 ;;^UTILITY(U,$J,358.3,3482,1,4,0)
 ;;=4^M79.3
 ;;^UTILITY(U,$J,358.3,3482,2)
 ;;=^5013323
 ;;^UTILITY(U,$J,358.3,3483,0)
 ;;=M62.3^^18^219^136
 ;;^UTILITY(U,$J,358.3,3483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3483,1,3,0)
 ;;=3^Paraplegic Immobility Syndrome
 ;;^UTILITY(U,$J,358.3,3483,1,4,0)
 ;;=4^M62.3
 ;;^UTILITY(U,$J,358.3,3483,2)
 ;;=^5012630
 ;;^UTILITY(U,$J,358.3,3484,0)
 ;;=R29.3^^18^219^139
 ;;^UTILITY(U,$J,358.3,3484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3484,1,3,0)
 ;;=3^Posture,Abnormal
 ;;^UTILITY(U,$J,358.3,3484,1,4,0)
 ;;=4^R29.3
 ;;^UTILITY(U,$J,358.3,3484,2)
 ;;=^322158
 ;;^UTILITY(U,$J,358.3,3485,0)
 ;;=M54.10^^18^219^140
 ;;^UTILITY(U,$J,358.3,3485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3485,1,3,0)
 ;;=3^Radiculopathy,Unspec Site
 ;;^UTILITY(U,$J,358.3,3485,1,4,0)
 ;;=4^M54.10
