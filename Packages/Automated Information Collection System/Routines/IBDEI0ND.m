IBDEI0ND ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23557,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,23558,0)
 ;;=Y36.200A^^89^1065^124
 ;;^UTILITY(U,$J,358.3,23558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23558,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23558,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,23558,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,23559,0)
 ;;=Y36.200D^^89^1065^125
 ;;^UTILITY(U,$J,358.3,23559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23559,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23559,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,23559,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,23560,0)
 ;;=Y36.300A^^89^1065^126
 ;;^UTILITY(U,$J,358.3,23560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23560,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23560,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,23560,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,23561,0)
 ;;=Y36.300D^^89^1065^127
 ;;^UTILITY(U,$J,358.3,23561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23561,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23561,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,23561,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,23562,0)
 ;;=Y36.410A^^89^1065^121
 ;;^UTILITY(U,$J,358.3,23562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23562,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23562,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,23562,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,23563,0)
 ;;=Y36.410D^^89^1065^123
 ;;^UTILITY(U,$J,358.3,23563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23563,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23563,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,23563,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,23564,0)
 ;;=Y36.6X0A^^89^1065^113
 ;;^UTILITY(U,$J,358.3,23564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23564,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23564,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,23564,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,23565,0)
 ;;=Y36.6X0D^^89^1065^115
 ;;^UTILITY(U,$J,358.3,23565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23565,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23565,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,23565,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,23566,0)
 ;;=Y36.7X0A^^89^1065^128
 ;;^UTILITY(U,$J,358.3,23566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23566,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23566,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,23566,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,23567,0)
 ;;=Y36.7X0D^^89^1065^129
 ;;^UTILITY(U,$J,358.3,23567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23567,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23567,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,23567,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,23568,0)
 ;;=Y36.810A^^89^1065^22
 ;;^UTILITY(U,$J,358.3,23568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23568,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23568,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,23568,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,23569,0)
 ;;=Y36.810D^^89^1065^23
 ;;^UTILITY(U,$J,358.3,23569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23569,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23569,1,4,0)
 ;;=4^Y36.810D
 ;;^UTILITY(U,$J,358.3,23569,2)
 ;;=^5061788
 ;;^UTILITY(U,$J,358.3,23570,0)
 ;;=Y36.820A^^89^1065^19
 ;;^UTILITY(U,$J,358.3,23570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23570,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23570,1,4,0)
 ;;=4^Y36.820A
 ;;^UTILITY(U,$J,358.3,23570,2)
 ;;=^5061793
 ;;^UTILITY(U,$J,358.3,23571,0)
 ;;=Y36.820D^^89^1065^20
 ;;^UTILITY(U,$J,358.3,23571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23571,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23571,1,4,0)
 ;;=4^Y36.820D
 ;;^UTILITY(U,$J,358.3,23571,2)
 ;;=^5061794
 ;;^UTILITY(U,$J,358.3,23572,0)
 ;;=Y37.200A^^89^1065^91
 ;;^UTILITY(U,$J,358.3,23572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23572,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23572,1,4,0)
 ;;=4^Y37.200A
 ;;^UTILITY(U,$J,358.3,23572,2)
 ;;=^5137997
 ;;^UTILITY(U,$J,358.3,23573,0)
 ;;=Y37.200D^^89^1065^92
 ;;^UTILITY(U,$J,358.3,23573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23573,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23573,1,4,0)
 ;;=4^Y37.200D
 ;;^UTILITY(U,$J,358.3,23573,2)
 ;;=^5137999
 ;;^UTILITY(U,$J,358.3,23574,0)
 ;;=X00.1XXA^^89^1065^13
 ;;^UTILITY(U,$J,358.3,23574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23574,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,23574,1,4,0)
 ;;=4^X00.1XXA
 ;;^UTILITY(U,$J,358.3,23574,2)
 ;;=^5060664
 ;;^UTILITY(U,$J,358.3,23575,0)
 ;;=X00.1XXD^^89^1065^14
 ;;^UTILITY(U,$J,358.3,23575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23575,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23575,1,4,0)
 ;;=4^X00.1XXD
 ;;^UTILITY(U,$J,358.3,23575,2)
 ;;=^5060665
 ;;^UTILITY(U,$J,358.3,23576,0)
 ;;=Y36.820S^^89^1065^21
 ;;^UTILITY(U,$J,358.3,23576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23576,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23576,1,4,0)
 ;;=4^Y36.820S
 ;;^UTILITY(U,$J,358.3,23576,2)
 ;;=^5061795
 ;;^UTILITY(U,$J,358.3,23577,0)
 ;;=Y36.810S^^89^1065^24
 ;;^UTILITY(U,$J,358.3,23577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23577,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23577,1,4,0)
 ;;=4^Y36.810S
 ;;^UTILITY(U,$J,358.3,23577,2)
 ;;=^5061789
 ;;^UTILITY(U,$J,358.3,23578,0)
 ;;=Y36.6X0S^^89^1065^114
 ;;^UTILITY(U,$J,358.3,23578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23578,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23578,1,4,0)
 ;;=4^Y36.6X0S
 ;;^UTILITY(U,$J,358.3,23578,2)
 ;;=^5061777
 ;;^UTILITY(U,$J,358.3,23579,0)
 ;;=Y36.410S^^89^1065^122
 ;;^UTILITY(U,$J,358.3,23579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23579,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23579,1,4,0)
 ;;=4^Y36.410S
 ;;^UTILITY(U,$J,358.3,23579,2)
 ;;=^5061693
 ;;^UTILITY(U,$J,358.3,23580,0)
 ;;=Y36.200S^^89^1065^119
 ;;^UTILITY(U,$J,358.3,23580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23580,1,3,0)
 ;;=3^War Op Inv Explosion/Fragments,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23580,1,4,0)
 ;;=4^Y36.200S
 ;;^UTILITY(U,$J,358.3,23580,2)
 ;;=^5061609
 ;;^UTILITY(U,$J,358.3,23581,0)
 ;;=Y36.300S^^89^1065^120
 ;;^UTILITY(U,$J,358.3,23581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23581,1,3,0)
 ;;=3^War Op Inv Fire/Conflagr/Hot Subst,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23581,1,4,0)
 ;;=4^Y36.300S
 ;;^UTILITY(U,$J,358.3,23581,2)
 ;;=^5061663
 ;;^UTILITY(U,$J,358.3,23582,0)
 ;;=Y36.230A^^89^1065^116
 ;;^UTILITY(U,$J,358.3,23582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23582,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Init Encntr
 ;;^UTILITY(U,$J,358.3,23582,1,4,0)
 ;;=4^Y36.230A
 ;;^UTILITY(U,$J,358.3,23582,2)
 ;;=^5061625
 ;;^UTILITY(U,$J,358.3,23583,0)
 ;;=Y36.230D^^89^1065^117
 ;;^UTILITY(U,$J,358.3,23583,1,0)
 ;;=^358.31IA^4^2
