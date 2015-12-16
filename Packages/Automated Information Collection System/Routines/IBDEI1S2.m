IBDEI1S2 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31381,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,31381,1,4,0)
 ;;=4^T84.82XA
 ;;^UTILITY(U,$J,358.3,31381,2)
 ;;=^5055457
 ;;^UTILITY(U,$J,358.3,31382,0)
 ;;=T84.83XA^^180^1955^3
 ;;^UTILITY(U,$J,358.3,31382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31382,1,3,0)
 ;;=3^Hemorrhage due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,31382,1,4,0)
 ;;=4^T84.83XA
 ;;^UTILITY(U,$J,358.3,31382,2)
 ;;=^5055460
 ;;^UTILITY(U,$J,358.3,31383,0)
 ;;=T84.84XA^^180^1955^4
 ;;^UTILITY(U,$J,358.3,31383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31383,1,3,0)
 ;;=3^Pain due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,31383,1,4,0)
 ;;=4^T84.84XA
 ;;^UTILITY(U,$J,358.3,31383,2)
 ;;=^5055463
 ;;^UTILITY(U,$J,358.3,31384,0)
 ;;=T84.85XA^^180^1955^5
 ;;^UTILITY(U,$J,358.3,31384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31384,1,3,0)
 ;;=3^Stenosis due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,31384,1,4,0)
 ;;=4^T84.85XA
 ;;^UTILITY(U,$J,358.3,31384,2)
 ;;=^5055466
 ;;^UTILITY(U,$J,358.3,31385,0)
 ;;=T84.86XA^^180^1955^6
 ;;^UTILITY(U,$J,358.3,31385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31385,1,3,0)
 ;;=3^Thrombosis due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,31385,1,4,0)
 ;;=4^T84.86XA
 ;;^UTILITY(U,$J,358.3,31385,2)
 ;;=^5055469
 ;;^UTILITY(U,$J,358.3,31386,0)
 ;;=Z89.442^^180^1956^1
 ;;^UTILITY(U,$J,358.3,31386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31386,1,3,0)
 ;;=3^Acquired absence of left ankle
 ;;^UTILITY(U,$J,358.3,31386,1,4,0)
 ;;=4^Z89.442
 ;;^UTILITY(U,$J,358.3,31386,2)
 ;;=^5063564
 ;;^UTILITY(U,$J,358.3,31387,0)
 ;;=Z89.622^^180^1956^2
 ;;^UTILITY(U,$J,358.3,31387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31387,1,3,0)
 ;;=3^Acquired absence of left hip joint
 ;;^UTILITY(U,$J,358.3,31387,1,4,0)
 ;;=4^Z89.622
 ;;^UTILITY(U,$J,358.3,31387,2)
 ;;=^5063576
 ;;^UTILITY(U,$J,358.3,31388,0)
 ;;=Z89.612^^180^1956^3
 ;;^UTILITY(U,$J,358.3,31388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31388,1,3,0)
 ;;=3^Acquired absence of left leg above knee
 ;;^UTILITY(U,$J,358.3,31388,1,4,0)
 ;;=4^Z89.612
 ;;^UTILITY(U,$J,358.3,31388,2)
 ;;=^5063573
 ;;^UTILITY(U,$J,358.3,31389,0)
 ;;=Z89.512^^180^1956^4
 ;;^UTILITY(U,$J,358.3,31389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31389,1,3,0)
 ;;=3^Acquired absence of left leg below knee
 ;;^UTILITY(U,$J,358.3,31389,1,4,0)
 ;;=4^Z89.512
 ;;^UTILITY(U,$J,358.3,31389,2)
 ;;=^5063567
 ;;^UTILITY(U,$J,358.3,31390,0)
 ;;=Z89.441^^180^1956^5
 ;;^UTILITY(U,$J,358.3,31390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31390,1,3,0)
 ;;=3^Acquired absence of right ankle
 ;;^UTILITY(U,$J,358.3,31390,1,4,0)
 ;;=4^Z89.441
 ;;^UTILITY(U,$J,358.3,31390,2)
 ;;=^5063563
 ;;^UTILITY(U,$J,358.3,31391,0)
 ;;=Z89.621^^180^1956^6
 ;;^UTILITY(U,$J,358.3,31391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31391,1,3,0)
 ;;=3^Acquired absence of right hip joint
 ;;^UTILITY(U,$J,358.3,31391,1,4,0)
 ;;=4^Z89.621
 ;;^UTILITY(U,$J,358.3,31391,2)
 ;;=^5063575
 ;;^UTILITY(U,$J,358.3,31392,0)
 ;;=Z89.611^^180^1956^7
 ;;^UTILITY(U,$J,358.3,31392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31392,1,3,0)
 ;;=3^Acquired absence of right leg above knee
 ;;^UTILITY(U,$J,358.3,31392,1,4,0)
 ;;=4^Z89.611
 ;;^UTILITY(U,$J,358.3,31392,2)
 ;;=^5063572
 ;;^UTILITY(U,$J,358.3,31393,0)
 ;;=Z89.511^^180^1956^8
 ;;^UTILITY(U,$J,358.3,31393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31393,1,3,0)
 ;;=3^Acquired absence of right leg below knee
