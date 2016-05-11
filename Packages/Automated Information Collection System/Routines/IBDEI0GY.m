IBDEI0GY ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7836,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,7836,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,7837,0)
 ;;=Y36.410A^^30^415^121
 ;;^UTILITY(U,$J,358.3,7837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7837,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,7837,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,7837,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,7838,0)
 ;;=Y36.410D^^30^415^123
 ;;^UTILITY(U,$J,358.3,7838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7838,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7838,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,7838,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,7839,0)
 ;;=Y36.6X0A^^30^415^113
 ;;^UTILITY(U,$J,358.3,7839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7839,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,7839,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,7839,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,7840,0)
 ;;=Y36.6X0D^^30^415^115
 ;;^UTILITY(U,$J,358.3,7840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7840,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7840,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,7840,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,7841,0)
 ;;=Y36.7X0A^^30^415^128
 ;;^UTILITY(U,$J,358.3,7841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7841,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,7841,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,7841,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,7842,0)
 ;;=Y36.7X0D^^30^415^129
 ;;^UTILITY(U,$J,358.3,7842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7842,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7842,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,7842,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,7843,0)
 ;;=Y36.810A^^30^415^22
 ;;^UTILITY(U,$J,358.3,7843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7843,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,7843,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,7843,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,7844,0)
 ;;=Y36.810D^^30^415^23
 ;;^UTILITY(U,$J,358.3,7844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7844,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7844,1,4,0)
 ;;=4^Y36.810D
 ;;^UTILITY(U,$J,358.3,7844,2)
 ;;=^5061788
 ;;^UTILITY(U,$J,358.3,7845,0)
 ;;=Y36.820A^^30^415^19
 ;;^UTILITY(U,$J,358.3,7845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7845,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,7845,1,4,0)
 ;;=4^Y36.820A
 ;;^UTILITY(U,$J,358.3,7845,2)
 ;;=^5061793
 ;;^UTILITY(U,$J,358.3,7846,0)
 ;;=Y36.820D^^30^415^20
 ;;^UTILITY(U,$J,358.3,7846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7846,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7846,1,4,0)
 ;;=4^Y36.820D
 ;;^UTILITY(U,$J,358.3,7846,2)
 ;;=^5061794
 ;;^UTILITY(U,$J,358.3,7847,0)
 ;;=Y37.200A^^30^415^91
 ;;^UTILITY(U,$J,358.3,7847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7847,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,7847,1,4,0)
 ;;=4^Y37.200A
 ;;^UTILITY(U,$J,358.3,7847,2)
 ;;=^5137997
 ;;^UTILITY(U,$J,358.3,7848,0)
 ;;=Y37.200D^^30^415^92
 ;;^UTILITY(U,$J,358.3,7848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7848,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Subs Encntr
