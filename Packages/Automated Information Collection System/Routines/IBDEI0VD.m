IBDEI0VD ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14701,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,14702,0)
 ;;=Y36.300D^^53^612^127
 ;;^UTILITY(U,$J,358.3,14702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14702,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14702,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,14702,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,14703,0)
 ;;=Y36.410A^^53^612^121
 ;;^UTILITY(U,$J,358.3,14703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14703,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,14703,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,14703,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,14704,0)
 ;;=Y36.410D^^53^612^123
 ;;^UTILITY(U,$J,358.3,14704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14704,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14704,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,14704,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,14705,0)
 ;;=Y36.6X0A^^53^612^113
 ;;^UTILITY(U,$J,358.3,14705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14705,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,14705,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,14705,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,14706,0)
 ;;=Y36.6X0D^^53^612^115
 ;;^UTILITY(U,$J,358.3,14706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14706,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14706,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,14706,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,14707,0)
 ;;=Y36.7X0A^^53^612^128
 ;;^UTILITY(U,$J,358.3,14707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14707,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,14707,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,14707,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,14708,0)
 ;;=Y36.7X0D^^53^612^129
 ;;^UTILITY(U,$J,358.3,14708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14708,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14708,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,14708,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,14709,0)
 ;;=Y36.810A^^53^612^22
 ;;^UTILITY(U,$J,358.3,14709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14709,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,14709,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,14709,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,14710,0)
 ;;=Y36.810D^^53^612^23
 ;;^UTILITY(U,$J,358.3,14710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14710,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14710,1,4,0)
 ;;=4^Y36.810D
 ;;^UTILITY(U,$J,358.3,14710,2)
 ;;=^5061788
 ;;^UTILITY(U,$J,358.3,14711,0)
 ;;=Y36.820A^^53^612^19
 ;;^UTILITY(U,$J,358.3,14711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14711,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,14711,1,4,0)
 ;;=4^Y36.820A
 ;;^UTILITY(U,$J,358.3,14711,2)
 ;;=^5061793
 ;;^UTILITY(U,$J,358.3,14712,0)
 ;;=Y36.820D^^53^612^20
 ;;^UTILITY(U,$J,358.3,14712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14712,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14712,1,4,0)
 ;;=4^Y36.820D
 ;;^UTILITY(U,$J,358.3,14712,2)
 ;;=^5061794
 ;;^UTILITY(U,$J,358.3,14713,0)
 ;;=Y37.200A^^53^612^91
 ;;^UTILITY(U,$J,358.3,14713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14713,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Init Encntr
