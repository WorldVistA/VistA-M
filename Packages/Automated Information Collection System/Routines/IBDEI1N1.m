IBDEI1N1 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26162,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,26162,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,26162,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,26163,0)
 ;;=Y36.200A^^107^1230^133
 ;;^UTILITY(U,$J,358.3,26163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26163,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,26163,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,26163,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,26164,0)
 ;;=Y36.200D^^107^1230^134
 ;;^UTILITY(U,$J,358.3,26164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26164,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,26164,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,26164,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,26165,0)
 ;;=Y36.300A^^107^1230^135
 ;;^UTILITY(U,$J,358.3,26165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26165,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,26165,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,26165,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,26166,0)
 ;;=Y36.300D^^107^1230^136
 ;;^UTILITY(U,$J,358.3,26166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26166,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,26166,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,26166,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,26167,0)
 ;;=Y36.410A^^107^1230^130
 ;;^UTILITY(U,$J,358.3,26167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26167,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,26167,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,26167,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,26168,0)
 ;;=Y36.410D^^107^1230^132
 ;;^UTILITY(U,$J,358.3,26168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26168,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,26168,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,26168,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,26169,0)
 ;;=Y36.6X0A^^107^1230^122
 ;;^UTILITY(U,$J,358.3,26169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26169,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,26169,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,26169,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,26170,0)
 ;;=Y36.6X0D^^107^1230^124
 ;;^UTILITY(U,$J,358.3,26170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26170,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,26170,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,26170,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,26171,0)
 ;;=Y36.7X0A^^107^1230^137
 ;;^UTILITY(U,$J,358.3,26171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26171,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,26171,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,26171,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,26172,0)
 ;;=Y36.7X0D^^107^1230^138
 ;;^UTILITY(U,$J,358.3,26172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26172,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,26172,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,26172,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,26173,0)
 ;;=Y36.810A^^107^1230^27
 ;;^UTILITY(U,$J,358.3,26173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26173,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
