IBDEI2PZ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,45634,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,45634,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,45634,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,45635,0)
 ;;=Y36.300A^^200^2247^126
 ;;^UTILITY(U,$J,358.3,45635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45635,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,45635,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,45635,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,45636,0)
 ;;=Y36.300D^^200^2247^127
 ;;^UTILITY(U,$J,358.3,45636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45636,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,45636,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,45636,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,45637,0)
 ;;=Y36.410A^^200^2247^121
 ;;^UTILITY(U,$J,358.3,45637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45637,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,45637,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,45637,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,45638,0)
 ;;=Y36.410D^^200^2247^123
 ;;^UTILITY(U,$J,358.3,45638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45638,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,45638,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,45638,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,45639,0)
 ;;=Y36.6X0A^^200^2247^113
 ;;^UTILITY(U,$J,358.3,45639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45639,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,45639,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,45639,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,45640,0)
 ;;=Y36.6X0D^^200^2247^115
 ;;^UTILITY(U,$J,358.3,45640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45640,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,45640,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,45640,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,45641,0)
 ;;=Y36.7X0A^^200^2247^128
 ;;^UTILITY(U,$J,358.3,45641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45641,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,45641,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,45641,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,45642,0)
 ;;=Y36.7X0D^^200^2247^129
 ;;^UTILITY(U,$J,358.3,45642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45642,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,45642,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,45642,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,45643,0)
 ;;=Y36.810A^^200^2247^22
 ;;^UTILITY(U,$J,358.3,45643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45643,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,45643,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,45643,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,45644,0)
 ;;=Y36.810D^^200^2247^23
 ;;^UTILITY(U,$J,358.3,45644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45644,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,45644,1,4,0)
 ;;=4^Y36.810D
 ;;^UTILITY(U,$J,358.3,45644,2)
 ;;=^5061788
 ;;^UTILITY(U,$J,358.3,45645,0)
 ;;=Y36.820A^^200^2247^19
 ;;^UTILITY(U,$J,358.3,45645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45645,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,45645,1,4,0)
 ;;=4^Y36.820A
 ;;^UTILITY(U,$J,358.3,45645,2)
 ;;=^5061793
 ;;^UTILITY(U,$J,358.3,45646,0)
 ;;=Y36.820D^^200^2247^20
