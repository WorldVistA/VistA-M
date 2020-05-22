IBDEI27R ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35350,1,3,0)
 ;;=3^Trigeminal Neuralgia
 ;;^UTILITY(U,$J,358.3,35350,1,4,0)
 ;;=4^G50.0
 ;;^UTILITY(U,$J,358.3,35350,2)
 ;;=^121978
 ;;^UTILITY(U,$J,358.3,35351,0)
 ;;=M79.10^^137^1800^27
 ;;^UTILITY(U,$J,358.3,35351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35351,1,3,0)
 ;;=3^Myalga,Unspec Site
 ;;^UTILITY(U,$J,358.3,35351,1,4,0)
 ;;=4^M79.10
 ;;^UTILITY(U,$J,358.3,35351,2)
 ;;=^5157394
 ;;^UTILITY(U,$J,358.3,35352,0)
 ;;=M79.11^^137^1800^29
 ;;^UTILITY(U,$J,358.3,35352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35352,1,3,0)
 ;;=3^Myalgia,Mastication Muscle
 ;;^UTILITY(U,$J,358.3,35352,1,4,0)
 ;;=4^M79.11
 ;;^UTILITY(U,$J,358.3,35352,2)
 ;;=^5157395
 ;;^UTILITY(U,$J,358.3,35353,0)
 ;;=M79.12^^137^1800^28
 ;;^UTILITY(U,$J,358.3,35353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35353,1,3,0)
 ;;=3^Myalgia,Auxiliary Muscles,Head/Neck
 ;;^UTILITY(U,$J,358.3,35353,1,4,0)
 ;;=4^M79.12
 ;;^UTILITY(U,$J,358.3,35353,2)
 ;;=^5157396
 ;;^UTILITY(U,$J,358.3,35354,0)
 ;;=M79.18^^137^1800^30
 ;;^UTILITY(U,$J,358.3,35354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35354,1,3,0)
 ;;=3^Myalgia,Other Site
 ;;^UTILITY(U,$J,358.3,35354,1,4,0)
 ;;=4^M79.18
 ;;^UTILITY(U,$J,358.3,35354,2)
 ;;=^5157397
 ;;^UTILITY(U,$J,358.3,35355,0)
 ;;=Z47.1^^137^1801^1
 ;;^UTILITY(U,$J,358.3,35355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35355,1,3,0)
 ;;=3^Aftercare following joint replacement surgery
 ;;^UTILITY(U,$J,358.3,35355,1,4,0)
 ;;=4^Z47.1
 ;;^UTILITY(U,$J,358.3,35355,2)
 ;;=^5063025
 ;;^UTILITY(U,$J,358.3,35356,0)
 ;;=Z96.662^^137^1801^2
 ;;^UTILITY(U,$J,358.3,35356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35356,1,3,0)
 ;;=3^Presence of left artificial ankle joint
 ;;^UTILITY(U,$J,358.3,35356,1,4,0)
 ;;=4^Z96.662
 ;;^UTILITY(U,$J,358.3,35356,2)
 ;;=^5063710
 ;;^UTILITY(U,$J,358.3,35357,0)
 ;;=Z96.622^^137^1801^3
 ;;^UTILITY(U,$J,358.3,35357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35357,1,3,0)
 ;;=3^Presence of left artificial elbow joint
 ;;^UTILITY(U,$J,358.3,35357,1,4,0)
 ;;=4^Z96.622
 ;;^UTILITY(U,$J,358.3,35357,2)
 ;;=^5063696
 ;;^UTILITY(U,$J,358.3,35358,0)
 ;;=Z96.642^^137^1801^4
 ;;^UTILITY(U,$J,358.3,35358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35358,1,3,0)
 ;;=3^Presence of left artificial hip joint
 ;;^UTILITY(U,$J,358.3,35358,1,4,0)
 ;;=4^Z96.642
 ;;^UTILITY(U,$J,358.3,35358,2)
 ;;=^5063702
 ;;^UTILITY(U,$J,358.3,35359,0)
 ;;=Z96.652^^137^1801^5
 ;;^UTILITY(U,$J,358.3,35359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35359,1,3,0)
 ;;=3^Presence of left artificial knee joint
 ;;^UTILITY(U,$J,358.3,35359,1,4,0)
 ;;=4^Z96.652
 ;;^UTILITY(U,$J,358.3,35359,2)
 ;;=^5063706
 ;;^UTILITY(U,$J,358.3,35360,0)
 ;;=Z96.612^^137^1801^6
 ;;^UTILITY(U,$J,358.3,35360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35360,1,3,0)
 ;;=3^Presence of left artificial shoulder joint
 ;;^UTILITY(U,$J,358.3,35360,1,4,0)
 ;;=4^Z96.612
 ;;^UTILITY(U,$J,358.3,35360,2)
 ;;=^5063693
 ;;^UTILITY(U,$J,358.3,35361,0)
 ;;=Z96.632^^137^1801^7
 ;;^UTILITY(U,$J,358.3,35361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35361,1,3,0)
 ;;=3^Presence of left artificial wrist joint
 ;;^UTILITY(U,$J,358.3,35361,1,4,0)
 ;;=4^Z96.632
 ;;^UTILITY(U,$J,358.3,35361,2)
 ;;=^5063699
 ;;^UTILITY(U,$J,358.3,35362,0)
 ;;=Z96.60^^137^1801^14
 ;;^UTILITY(U,$J,358.3,35362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35362,1,3,0)
 ;;=3^Presence of unspecified orthopedic joint implant
