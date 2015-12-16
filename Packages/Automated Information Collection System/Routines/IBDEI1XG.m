IBDEI1XG ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33861,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,33861,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,33862,0)
 ;;=Y36.200A^^182^2011^113
 ;;^UTILITY(U,$J,358.3,33862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33862,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,33862,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,33862,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,33863,0)
 ;;=Y36.200D^^182^2011^114
 ;;^UTILITY(U,$J,358.3,33863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33863,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33863,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,33863,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,33864,0)
 ;;=Y36.300A^^182^2011^115
 ;;^UTILITY(U,$J,358.3,33864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33864,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,33864,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,33864,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,33865,0)
 ;;=Y36.300D^^182^2011^116
 ;;^UTILITY(U,$J,358.3,33865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33865,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33865,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,33865,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,33866,0)
 ;;=Y36.410A^^182^2011^111
 ;;^UTILITY(U,$J,358.3,33866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33866,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,33866,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,33866,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,33867,0)
 ;;=Y36.410D^^182^2011^112
 ;;^UTILITY(U,$J,358.3,33867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33867,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33867,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,33867,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,33868,0)
 ;;=Y36.6X0A^^182^2011^109
 ;;^UTILITY(U,$J,358.3,33868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33868,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,33868,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,33868,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,33869,0)
 ;;=Y36.6X0D^^182^2011^110
 ;;^UTILITY(U,$J,358.3,33869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33869,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33869,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,33869,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,33870,0)
 ;;=Y36.7X0A^^182^2011^117
 ;;^UTILITY(U,$J,358.3,33870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33870,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,33870,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,33870,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,33871,0)
 ;;=Y36.7X0D^^182^2011^118
 ;;^UTILITY(U,$J,358.3,33871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33871,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33871,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,33871,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,33872,0)
 ;;=Y36.810A^^182^2011^19
 ;;^UTILITY(U,$J,358.3,33872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33872,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,33872,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,33872,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,33873,0)
 ;;=Y36.810D^^182^2011^20
 ;;^UTILITY(U,$J,358.3,33873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33873,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Subs Encntr
