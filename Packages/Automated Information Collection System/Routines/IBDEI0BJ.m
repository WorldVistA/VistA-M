IBDEI0BJ ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14633,1,3,0)
 ;;=3^Assault by Unarmed Fight,Init Encntr
 ;;^UTILITY(U,$J,358.3,14633,1,4,0)
 ;;=4^Y04.0XXA
 ;;^UTILITY(U,$J,358.3,14633,2)
 ;;=^5061165
 ;;^UTILITY(U,$J,358.3,14634,0)
 ;;=Y04.0XXD^^43^643^8
 ;;^UTILITY(U,$J,358.3,14634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14634,1,3,0)
 ;;=3^Assault by Unarmed Fight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14634,1,4,0)
 ;;=4^Y04.0XXD
 ;;^UTILITY(U,$J,358.3,14634,2)
 ;;=^5061166
 ;;^UTILITY(U,$J,358.3,14635,0)
 ;;=Y04.1XXA^^43^643^1
 ;;^UTILITY(U,$J,358.3,14635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14635,1,3,0)
 ;;=3^Assault by Human Bite,Init Encntr
 ;;^UTILITY(U,$J,358.3,14635,1,4,0)
 ;;=4^Y04.1XXA
 ;;^UTILITY(U,$J,358.3,14635,2)
 ;;=^5061168
 ;;^UTILITY(U,$J,358.3,14636,0)
 ;;=Y04.1XXD^^43^643^2
 ;;^UTILITY(U,$J,358.3,14636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14636,1,3,0)
 ;;=3^Assault by Human Bite,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14636,1,4,0)
 ;;=4^Y04.1XXD
 ;;^UTILITY(U,$J,358.3,14636,2)
 ;;=^5061169
 ;;^UTILITY(U,$J,358.3,14637,0)
 ;;=Y04.2XXA^^43^643^5
 ;;^UTILITY(U,$J,358.3,14637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14637,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,14637,1,4,0)
 ;;=4^Y04.2XXA
 ;;^UTILITY(U,$J,358.3,14637,2)
 ;;=^5061171
 ;;^UTILITY(U,$J,358.3,14638,0)
 ;;=Y04.8XXA^^43^643^3
 ;;^UTILITY(U,$J,358.3,14638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14638,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Init Encntr
 ;;^UTILITY(U,$J,358.3,14638,1,4,0)
 ;;=4^Y04.8XXA
 ;;^UTILITY(U,$J,358.3,14638,2)
 ;;=^5061174
 ;;^UTILITY(U,$J,358.3,14639,0)
 ;;=Y04.2XXD^^43^643^6
 ;;^UTILITY(U,$J,358.3,14639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14639,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14639,1,4,0)
 ;;=4^Y04.2XXD
 ;;^UTILITY(U,$J,358.3,14639,2)
 ;;=^5061172
 ;;^UTILITY(U,$J,358.3,14640,0)
 ;;=Y04.8XXD^^43^643^4
 ;;^UTILITY(U,$J,358.3,14640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14640,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14640,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,14640,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,14641,0)
 ;;=Y36.200A^^43^643^124
 ;;^UTILITY(U,$J,358.3,14641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14641,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,14641,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,14641,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,14642,0)
 ;;=Y36.200D^^43^643^125
 ;;^UTILITY(U,$J,358.3,14642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14642,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14642,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,14642,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,14643,0)
 ;;=Y36.300A^^43^643^126
 ;;^UTILITY(U,$J,358.3,14643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14643,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,14643,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,14643,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,14644,0)
 ;;=Y36.300D^^43^643^127
 ;;^UTILITY(U,$J,358.3,14644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14644,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14644,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,14644,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,14645,0)
 ;;=Y36.410A^^43^643^121
 ;;^UTILITY(U,$J,358.3,14645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14645,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,14645,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,14645,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,14646,0)
 ;;=Y36.410D^^43^643^123
 ;;^UTILITY(U,$J,358.3,14646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14646,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14646,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,14646,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,14647,0)
 ;;=Y36.6X0A^^43^643^113
 ;;^UTILITY(U,$J,358.3,14647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14647,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,14647,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,14647,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,14648,0)
 ;;=Y36.6X0D^^43^643^115
 ;;^UTILITY(U,$J,358.3,14648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14648,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14648,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,14648,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,14649,0)
 ;;=Y36.7X0A^^43^643^128
 ;;^UTILITY(U,$J,358.3,14649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14649,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,14649,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,14649,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,14650,0)
 ;;=Y36.7X0D^^43^643^129
 ;;^UTILITY(U,$J,358.3,14650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14650,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14650,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,14650,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,14651,0)
 ;;=Y36.810A^^43^643^22
 ;;^UTILITY(U,$J,358.3,14651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14651,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,14651,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,14651,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,14652,0)
 ;;=Y36.810D^^43^643^23
 ;;^UTILITY(U,$J,358.3,14652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14652,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14652,1,4,0)
 ;;=4^Y36.810D
 ;;^UTILITY(U,$J,358.3,14652,2)
 ;;=^5061788
 ;;^UTILITY(U,$J,358.3,14653,0)
 ;;=Y36.820A^^43^643^19
 ;;^UTILITY(U,$J,358.3,14653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14653,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,14653,1,4,0)
 ;;=4^Y36.820A
 ;;^UTILITY(U,$J,358.3,14653,2)
 ;;=^5061793
 ;;^UTILITY(U,$J,358.3,14654,0)
 ;;=Y36.820D^^43^643^20
 ;;^UTILITY(U,$J,358.3,14654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14654,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14654,1,4,0)
 ;;=4^Y36.820D
 ;;^UTILITY(U,$J,358.3,14654,2)
 ;;=^5061794
 ;;^UTILITY(U,$J,358.3,14655,0)
 ;;=Y37.200A^^43^643^91
 ;;^UTILITY(U,$J,358.3,14655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14655,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,14655,1,4,0)
 ;;=4^Y37.200A
 ;;^UTILITY(U,$J,358.3,14655,2)
 ;;=^5137997
 ;;^UTILITY(U,$J,358.3,14656,0)
 ;;=Y37.200D^^43^643^92
 ;;^UTILITY(U,$J,358.3,14656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14656,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14656,1,4,0)
 ;;=4^Y37.200D
 ;;^UTILITY(U,$J,358.3,14656,2)
 ;;=^5137999
 ;;^UTILITY(U,$J,358.3,14657,0)
 ;;=X00.1XXA^^43^643^13
 ;;^UTILITY(U,$J,358.3,14657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14657,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,14657,1,4,0)
 ;;=4^X00.1XXA
 ;;^UTILITY(U,$J,358.3,14657,2)
 ;;=^5060664
 ;;^UTILITY(U,$J,358.3,14658,0)
 ;;=X00.1XXD^^43^643^14
 ;;^UTILITY(U,$J,358.3,14658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14658,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14658,1,4,0)
 ;;=4^X00.1XXD
 ;;^UTILITY(U,$J,358.3,14658,2)
 ;;=^5060665
 ;;^UTILITY(U,$J,358.3,14659,0)
 ;;=Y36.820S^^43^643^21
 ;;^UTILITY(U,$J,358.3,14659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14659,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,14659,1,4,0)
 ;;=4^Y36.820S
 ;;^UTILITY(U,$J,358.3,14659,2)
 ;;=^5061795
 ;;^UTILITY(U,$J,358.3,14660,0)
 ;;=Y36.810S^^43^643^24
 ;;^UTILITY(U,$J,358.3,14660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14660,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,14660,1,4,0)
 ;;=4^Y36.810S
 ;;^UTILITY(U,$J,358.3,14660,2)
 ;;=^5061789
 ;;^UTILITY(U,$J,358.3,14661,0)
 ;;=Y36.6X0S^^43^643^114
 ;;^UTILITY(U,$J,358.3,14661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14661,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,14661,1,4,0)
 ;;=4^Y36.6X0S
 ;;^UTILITY(U,$J,358.3,14661,2)
 ;;=^5061777
 ;;^UTILITY(U,$J,358.3,14662,0)
 ;;=Y36.410S^^43^643^122
 ;;^UTILITY(U,$J,358.3,14662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14662,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,14662,1,4,0)
 ;;=4^Y36.410S
 ;;^UTILITY(U,$J,358.3,14662,2)
 ;;=^5061693
 ;;^UTILITY(U,$J,358.3,14663,0)
 ;;=Y36.200S^^43^643^119
 ;;^UTILITY(U,$J,358.3,14663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14663,1,3,0)
 ;;=3^War Op Inv Explosion/Fragments,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,14663,1,4,0)
 ;;=4^Y36.200S
 ;;^UTILITY(U,$J,358.3,14663,2)
 ;;=^5061609
 ;;^UTILITY(U,$J,358.3,14664,0)
 ;;=Y36.300S^^43^643^120
 ;;^UTILITY(U,$J,358.3,14664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14664,1,3,0)
 ;;=3^War Op Inv Fire/Conflagr/Hot Subst,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,14664,1,4,0)
 ;;=4^Y36.300S
 ;;^UTILITY(U,$J,358.3,14664,2)
 ;;=^5061663
 ;;^UTILITY(U,$J,358.3,14665,0)
 ;;=Y36.230A^^43^643^116
 ;;^UTILITY(U,$J,358.3,14665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14665,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Init Encntr
 ;;^UTILITY(U,$J,358.3,14665,1,4,0)
 ;;=4^Y36.230A
 ;;^UTILITY(U,$J,358.3,14665,2)
 ;;=^5061625
