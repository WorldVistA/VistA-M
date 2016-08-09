IBDEI0L0 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21165,1,4,0)
 ;;=4^Y04.0XXA
 ;;^UTILITY(U,$J,358.3,21165,2)
 ;;=^5061165
 ;;^UTILITY(U,$J,358.3,21166,0)
 ;;=Y04.0XXD^^86^1013^8
 ;;^UTILITY(U,$J,358.3,21166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21166,1,3,0)
 ;;=3^Assault by Unarmed Fight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21166,1,4,0)
 ;;=4^Y04.0XXD
 ;;^UTILITY(U,$J,358.3,21166,2)
 ;;=^5061166
 ;;^UTILITY(U,$J,358.3,21167,0)
 ;;=Y04.1XXA^^86^1013^1
 ;;^UTILITY(U,$J,358.3,21167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21167,1,3,0)
 ;;=3^Assault by Human Bite,Init Encntr
 ;;^UTILITY(U,$J,358.3,21167,1,4,0)
 ;;=4^Y04.1XXA
 ;;^UTILITY(U,$J,358.3,21167,2)
 ;;=^5061168
 ;;^UTILITY(U,$J,358.3,21168,0)
 ;;=Y04.1XXD^^86^1013^2
 ;;^UTILITY(U,$J,358.3,21168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21168,1,3,0)
 ;;=3^Assault by Human Bite,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21168,1,4,0)
 ;;=4^Y04.1XXD
 ;;^UTILITY(U,$J,358.3,21168,2)
 ;;=^5061169
 ;;^UTILITY(U,$J,358.3,21169,0)
 ;;=Y04.2XXA^^86^1013^5
 ;;^UTILITY(U,$J,358.3,21169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21169,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,21169,1,4,0)
 ;;=4^Y04.2XXA
 ;;^UTILITY(U,$J,358.3,21169,2)
 ;;=^5061171
 ;;^UTILITY(U,$J,358.3,21170,0)
 ;;=Y04.8XXA^^86^1013^3
 ;;^UTILITY(U,$J,358.3,21170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21170,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Init Encntr
 ;;^UTILITY(U,$J,358.3,21170,1,4,0)
 ;;=4^Y04.8XXA
 ;;^UTILITY(U,$J,358.3,21170,2)
 ;;=^5061174
 ;;^UTILITY(U,$J,358.3,21171,0)
 ;;=Y04.2XXD^^86^1013^6
 ;;^UTILITY(U,$J,358.3,21171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21171,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21171,1,4,0)
 ;;=4^Y04.2XXD
 ;;^UTILITY(U,$J,358.3,21171,2)
 ;;=^5061172
 ;;^UTILITY(U,$J,358.3,21172,0)
 ;;=Y04.8XXD^^86^1013^4
 ;;^UTILITY(U,$J,358.3,21172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21172,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21172,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,21172,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,21173,0)
 ;;=Y36.200A^^86^1013^124
 ;;^UTILITY(U,$J,358.3,21173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21173,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,21173,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,21173,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,21174,0)
 ;;=Y36.200D^^86^1013^125
 ;;^UTILITY(U,$J,358.3,21174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21174,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21174,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,21174,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,21175,0)
 ;;=Y36.300A^^86^1013^126
 ;;^UTILITY(U,$J,358.3,21175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21175,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,21175,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,21175,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,21176,0)
 ;;=Y36.300D^^86^1013^127
 ;;^UTILITY(U,$J,358.3,21176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21176,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21176,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,21176,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,21177,0)
 ;;=Y36.410A^^86^1013^121
 ;;^UTILITY(U,$J,358.3,21177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21177,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,21177,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,21177,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,21178,0)
 ;;=Y36.410D^^86^1013^123
 ;;^UTILITY(U,$J,358.3,21178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21178,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21178,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,21178,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,21179,0)
 ;;=Y36.6X0A^^86^1013^113
 ;;^UTILITY(U,$J,358.3,21179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21179,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,21179,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,21179,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,21180,0)
 ;;=Y36.6X0D^^86^1013^115
 ;;^UTILITY(U,$J,358.3,21180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21180,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21180,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,21180,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,21181,0)
 ;;=Y36.7X0A^^86^1013^128
 ;;^UTILITY(U,$J,358.3,21181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21181,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,21181,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,21181,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,21182,0)
 ;;=Y36.7X0D^^86^1013^129
 ;;^UTILITY(U,$J,358.3,21182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21182,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21182,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,21182,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,21183,0)
 ;;=Y36.810A^^86^1013^22
 ;;^UTILITY(U,$J,358.3,21183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21183,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,21183,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,21183,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,21184,0)
 ;;=Y36.810D^^86^1013^23
 ;;^UTILITY(U,$J,358.3,21184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21184,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21184,1,4,0)
 ;;=4^Y36.810D
 ;;^UTILITY(U,$J,358.3,21184,2)
 ;;=^5061788
 ;;^UTILITY(U,$J,358.3,21185,0)
 ;;=Y36.820A^^86^1013^19
 ;;^UTILITY(U,$J,358.3,21185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21185,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,21185,1,4,0)
 ;;=4^Y36.820A
 ;;^UTILITY(U,$J,358.3,21185,2)
 ;;=^5061793
 ;;^UTILITY(U,$J,358.3,21186,0)
 ;;=Y36.820D^^86^1013^20
 ;;^UTILITY(U,$J,358.3,21186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21186,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21186,1,4,0)
 ;;=4^Y36.820D
 ;;^UTILITY(U,$J,358.3,21186,2)
 ;;=^5061794
 ;;^UTILITY(U,$J,358.3,21187,0)
 ;;=Y37.200A^^86^1013^91
 ;;^UTILITY(U,$J,358.3,21187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21187,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,21187,1,4,0)
 ;;=4^Y37.200A
 ;;^UTILITY(U,$J,358.3,21187,2)
 ;;=^5137997
 ;;^UTILITY(U,$J,358.3,21188,0)
 ;;=Y37.200D^^86^1013^92
 ;;^UTILITY(U,$J,358.3,21188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21188,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21188,1,4,0)
 ;;=4^Y37.200D
 ;;^UTILITY(U,$J,358.3,21188,2)
 ;;=^5137999
 ;;^UTILITY(U,$J,358.3,21189,0)
 ;;=X00.1XXA^^86^1013^13
 ;;^UTILITY(U,$J,358.3,21189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21189,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,21189,1,4,0)
 ;;=4^X00.1XXA
 ;;^UTILITY(U,$J,358.3,21189,2)
 ;;=^5060664
 ;;^UTILITY(U,$J,358.3,21190,0)
 ;;=X00.1XXD^^86^1013^14
 ;;^UTILITY(U,$J,358.3,21190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21190,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21190,1,4,0)
 ;;=4^X00.1XXD
 ;;^UTILITY(U,$J,358.3,21190,2)
 ;;=^5060665
 ;;^UTILITY(U,$J,358.3,21191,0)
 ;;=Y36.820S^^86^1013^21
 ;;^UTILITY(U,$J,358.3,21191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21191,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op but Expld After,Milt,Sequela
