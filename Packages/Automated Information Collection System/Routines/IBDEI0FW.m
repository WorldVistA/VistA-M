IBDEI0FW ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15902,2)
 ;;=^5061166
 ;;^UTILITY(U,$J,358.3,15903,0)
 ;;=Y04.1XXA^^61^759^1
 ;;^UTILITY(U,$J,358.3,15903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15903,1,3,0)
 ;;=3^Assault by Human Bite,Init Encntr
 ;;^UTILITY(U,$J,358.3,15903,1,4,0)
 ;;=4^Y04.1XXA
 ;;^UTILITY(U,$J,358.3,15903,2)
 ;;=^5061168
 ;;^UTILITY(U,$J,358.3,15904,0)
 ;;=Y04.1XXD^^61^759^2
 ;;^UTILITY(U,$J,358.3,15904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15904,1,3,0)
 ;;=3^Assault by Human Bite,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15904,1,4,0)
 ;;=4^Y04.1XXD
 ;;^UTILITY(U,$J,358.3,15904,2)
 ;;=^5061169
 ;;^UTILITY(U,$J,358.3,15905,0)
 ;;=Y04.2XXA^^61^759^5
 ;;^UTILITY(U,$J,358.3,15905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15905,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,15905,1,4,0)
 ;;=4^Y04.2XXA
 ;;^UTILITY(U,$J,358.3,15905,2)
 ;;=^5061171
 ;;^UTILITY(U,$J,358.3,15906,0)
 ;;=Y04.8XXA^^61^759^3
 ;;^UTILITY(U,$J,358.3,15906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15906,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Init Encntr
 ;;^UTILITY(U,$J,358.3,15906,1,4,0)
 ;;=4^Y04.8XXA
 ;;^UTILITY(U,$J,358.3,15906,2)
 ;;=^5061174
 ;;^UTILITY(U,$J,358.3,15907,0)
 ;;=Y04.2XXD^^61^759^6
 ;;^UTILITY(U,$J,358.3,15907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15907,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15907,1,4,0)
 ;;=4^Y04.2XXD
 ;;^UTILITY(U,$J,358.3,15907,2)
 ;;=^5061172
 ;;^UTILITY(U,$J,358.3,15908,0)
 ;;=Y04.8XXD^^61^759^4
 ;;^UTILITY(U,$J,358.3,15908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15908,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15908,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,15908,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,15909,0)
 ;;=Y36.200A^^61^759^124
 ;;^UTILITY(U,$J,358.3,15909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15909,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,15909,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,15909,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,15910,0)
 ;;=Y36.200D^^61^759^125
 ;;^UTILITY(U,$J,358.3,15910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15910,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15910,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,15910,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,15911,0)
 ;;=Y36.300A^^61^759^126
 ;;^UTILITY(U,$J,358.3,15911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15911,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,15911,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,15911,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,15912,0)
 ;;=Y36.300D^^61^759^127
 ;;^UTILITY(U,$J,358.3,15912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15912,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15912,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,15912,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,15913,0)
 ;;=Y36.410A^^61^759^121
 ;;^UTILITY(U,$J,358.3,15913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15913,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,15913,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,15913,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,15914,0)
 ;;=Y36.410D^^61^759^123
 ;;^UTILITY(U,$J,358.3,15914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15914,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15914,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,15914,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,15915,0)
 ;;=Y36.6X0A^^61^759^113
 ;;^UTILITY(U,$J,358.3,15915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15915,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,15915,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,15915,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,15916,0)
 ;;=Y36.6X0D^^61^759^115
 ;;^UTILITY(U,$J,358.3,15916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15916,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15916,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,15916,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,15917,0)
 ;;=Y36.7X0A^^61^759^128
 ;;^UTILITY(U,$J,358.3,15917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15917,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,15917,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,15917,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,15918,0)
 ;;=Y36.7X0D^^61^759^129
 ;;^UTILITY(U,$J,358.3,15918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15918,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15918,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,15918,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,15919,0)
 ;;=Y36.810A^^61^759^22
 ;;^UTILITY(U,$J,358.3,15919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15919,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,15919,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,15919,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,15920,0)
 ;;=Y36.810D^^61^759^23
 ;;^UTILITY(U,$J,358.3,15920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15920,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15920,1,4,0)
 ;;=4^Y36.810D
 ;;^UTILITY(U,$J,358.3,15920,2)
 ;;=^5061788
 ;;^UTILITY(U,$J,358.3,15921,0)
 ;;=Y36.820A^^61^759^19
 ;;^UTILITY(U,$J,358.3,15921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15921,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,15921,1,4,0)
 ;;=4^Y36.820A
 ;;^UTILITY(U,$J,358.3,15921,2)
 ;;=^5061793
 ;;^UTILITY(U,$J,358.3,15922,0)
 ;;=Y36.820D^^61^759^20
 ;;^UTILITY(U,$J,358.3,15922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15922,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15922,1,4,0)
 ;;=4^Y36.820D
 ;;^UTILITY(U,$J,358.3,15922,2)
 ;;=^5061794
 ;;^UTILITY(U,$J,358.3,15923,0)
 ;;=Y37.200A^^61^759^91
 ;;^UTILITY(U,$J,358.3,15923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15923,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,15923,1,4,0)
 ;;=4^Y37.200A
 ;;^UTILITY(U,$J,358.3,15923,2)
 ;;=^5137997
 ;;^UTILITY(U,$J,358.3,15924,0)
 ;;=Y37.200D^^61^759^92
 ;;^UTILITY(U,$J,358.3,15924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15924,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15924,1,4,0)
 ;;=4^Y37.200D
 ;;^UTILITY(U,$J,358.3,15924,2)
 ;;=^5137999
 ;;^UTILITY(U,$J,358.3,15925,0)
 ;;=X00.1XXA^^61^759^13
 ;;^UTILITY(U,$J,358.3,15925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15925,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,15925,1,4,0)
 ;;=4^X00.1XXA
 ;;^UTILITY(U,$J,358.3,15925,2)
 ;;=^5060664
 ;;^UTILITY(U,$J,358.3,15926,0)
 ;;=X00.1XXD^^61^759^14
 ;;^UTILITY(U,$J,358.3,15926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15926,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15926,1,4,0)
 ;;=4^X00.1XXD
 ;;^UTILITY(U,$J,358.3,15926,2)
 ;;=^5060665
 ;;^UTILITY(U,$J,358.3,15927,0)
 ;;=Y36.820S^^61^759^21
 ;;^UTILITY(U,$J,358.3,15927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15927,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,15927,1,4,0)
 ;;=4^Y36.820S
 ;;^UTILITY(U,$J,358.3,15927,2)
 ;;=^5061795
 ;;^UTILITY(U,$J,358.3,15928,0)
 ;;=Y36.810S^^61^759^24
 ;;^UTILITY(U,$J,358.3,15928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15928,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld After,Milt,Sequela
