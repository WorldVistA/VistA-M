IBDEI04B ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10387,1,4,0)
 ;;=4^X32.XXXD
 ;;^UTILITY(U,$J,358.3,10387,2)
 ;;=^5060848
 ;;^UTILITY(U,$J,358.3,10388,0)
 ;;=Y04.0XXA^^45^450^7
 ;;^UTILITY(U,$J,358.3,10388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10388,1,3,0)
 ;;=3^Assault by Unarmed Fight,Init Encntr
 ;;^UTILITY(U,$J,358.3,10388,1,4,0)
 ;;=4^Y04.0XXA
 ;;^UTILITY(U,$J,358.3,10388,2)
 ;;=^5061165
 ;;^UTILITY(U,$J,358.3,10389,0)
 ;;=Y04.0XXD^^45^450^8
 ;;^UTILITY(U,$J,358.3,10389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10389,1,3,0)
 ;;=3^Assault by Unarmed Fight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,10389,1,4,0)
 ;;=4^Y04.0XXD
 ;;^UTILITY(U,$J,358.3,10389,2)
 ;;=^5061166
 ;;^UTILITY(U,$J,358.3,10390,0)
 ;;=Y04.1XXA^^45^450^1
 ;;^UTILITY(U,$J,358.3,10390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10390,1,3,0)
 ;;=3^Assault by Human Bite,Init Encntr
 ;;^UTILITY(U,$J,358.3,10390,1,4,0)
 ;;=4^Y04.1XXA
 ;;^UTILITY(U,$J,358.3,10390,2)
 ;;=^5061168
 ;;^UTILITY(U,$J,358.3,10391,0)
 ;;=Y04.1XXD^^45^450^2
 ;;^UTILITY(U,$J,358.3,10391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10391,1,3,0)
 ;;=3^Assault by Human Bite,Subs Encntr
 ;;^UTILITY(U,$J,358.3,10391,1,4,0)
 ;;=4^Y04.1XXD
 ;;^UTILITY(U,$J,358.3,10391,2)
 ;;=^5061169
 ;;^UTILITY(U,$J,358.3,10392,0)
 ;;=Y04.2XXA^^45^450^5
 ;;^UTILITY(U,$J,358.3,10392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10392,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,10392,1,4,0)
 ;;=4^Y04.2XXA
 ;;^UTILITY(U,$J,358.3,10392,2)
 ;;=^5061171
 ;;^UTILITY(U,$J,358.3,10393,0)
 ;;=Y04.8XXA^^45^450^3
 ;;^UTILITY(U,$J,358.3,10393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10393,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Init Encntr
 ;;^UTILITY(U,$J,358.3,10393,1,4,0)
 ;;=4^Y04.8XXA
 ;;^UTILITY(U,$J,358.3,10393,2)
 ;;=^5061174
 ;;^UTILITY(U,$J,358.3,10394,0)
 ;;=Y04.2XXD^^45^450^6
 ;;^UTILITY(U,$J,358.3,10394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10394,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,10394,1,4,0)
 ;;=4^Y04.2XXD
 ;;^UTILITY(U,$J,358.3,10394,2)
 ;;=^5061172
 ;;^UTILITY(U,$J,358.3,10395,0)
 ;;=Y04.8XXD^^45^450^4
 ;;^UTILITY(U,$J,358.3,10395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10395,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,10395,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,10395,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,10396,0)
 ;;=Y36.200A^^45^450^133
 ;;^UTILITY(U,$J,358.3,10396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10396,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,10396,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,10396,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,10397,0)
 ;;=Y36.200D^^45^450^134
 ;;^UTILITY(U,$J,358.3,10397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10397,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,10397,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,10397,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,10398,0)
 ;;=Y36.300A^^45^450^135
 ;;^UTILITY(U,$J,358.3,10398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10398,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,10398,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,10398,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,10399,0)
 ;;=Y36.300D^^45^450^136
 ;;^UTILITY(U,$J,358.3,10399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10399,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,10399,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,10399,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,10400,0)
 ;;=Y36.410A^^45^450^130
 ;;^UTILITY(U,$J,358.3,10400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10400,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,10400,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,10400,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,10401,0)
 ;;=Y36.410D^^45^450^132
 ;;^UTILITY(U,$J,358.3,10401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10401,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,10401,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,10401,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,10402,0)
 ;;=Y36.6X0A^^45^450^122
 ;;^UTILITY(U,$J,358.3,10402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10402,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,10402,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,10402,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,10403,0)
 ;;=Y36.6X0D^^45^450^124
 ;;^UTILITY(U,$J,358.3,10403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10403,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,10403,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,10403,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,10404,0)
 ;;=Y36.7X0A^^45^450^137
 ;;^UTILITY(U,$J,358.3,10404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10404,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,10404,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,10404,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,10405,0)
 ;;=Y36.7X0D^^45^450^138
 ;;^UTILITY(U,$J,358.3,10405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10405,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,10405,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,10405,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,10406,0)
 ;;=Y36.810A^^45^450^27
 ;;^UTILITY(U,$J,358.3,10406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10406,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,10406,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,10406,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,10407,0)
 ;;=Y36.810D^^45^450^28
 ;;^UTILITY(U,$J,358.3,10407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10407,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,10407,1,4,0)
 ;;=4^Y36.810D
 ;;^UTILITY(U,$J,358.3,10407,2)
 ;;=^5061788
 ;;^UTILITY(U,$J,358.3,10408,0)
 ;;=Y36.820A^^45^450^24
 ;;^UTILITY(U,$J,358.3,10408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10408,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,10408,1,4,0)
 ;;=4^Y36.820A
 ;;^UTILITY(U,$J,358.3,10408,2)
 ;;=^5061793
 ;;^UTILITY(U,$J,358.3,10409,0)
 ;;=Y36.820D^^45^450^25
 ;;^UTILITY(U,$J,358.3,10409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10409,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,10409,1,4,0)
 ;;=4^Y36.820D
 ;;^UTILITY(U,$J,358.3,10409,2)
 ;;=^5061794
 ;;^UTILITY(U,$J,358.3,10410,0)
 ;;=Y37.200A^^45^450^96
 ;;^UTILITY(U,$J,358.3,10410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10410,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,10410,1,4,0)
 ;;=4^Y37.200A
 ;;^UTILITY(U,$J,358.3,10410,2)
 ;;=^5137997
 ;;^UTILITY(U,$J,358.3,10411,0)
 ;;=Y37.200D^^45^450^97
 ;;^UTILITY(U,$J,358.3,10411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10411,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,10411,1,4,0)
 ;;=4^Y37.200D
 ;;^UTILITY(U,$J,358.3,10411,2)
 ;;=^5137999
 ;;^UTILITY(U,$J,358.3,10412,0)
 ;;=X00.1XXA^^45^450^18
 ;;^UTILITY(U,$J,358.3,10412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10412,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,10412,1,4,0)
 ;;=4^X00.1XXA
 ;;^UTILITY(U,$J,358.3,10412,2)
 ;;=^5060664
 ;;^UTILITY(U,$J,358.3,10413,0)
 ;;=X00.1XXD^^45^450^19
 ;;^UTILITY(U,$J,358.3,10413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10413,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,10413,1,4,0)
 ;;=4^X00.1XXD
 ;;^UTILITY(U,$J,358.3,10413,2)
 ;;=^5060665
 ;;^UTILITY(U,$J,358.3,10414,0)
 ;;=Y36.820S^^45^450^26
 ;;^UTILITY(U,$J,358.3,10414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10414,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,10414,1,4,0)
 ;;=4^Y36.820S
 ;;^UTILITY(U,$J,358.3,10414,2)
 ;;=^5061795
 ;;^UTILITY(U,$J,358.3,10415,0)
 ;;=Y36.810S^^45^450^29
 ;;^UTILITY(U,$J,358.3,10415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10415,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,10415,1,4,0)
 ;;=4^Y36.810S
 ;;^UTILITY(U,$J,358.3,10415,2)
 ;;=^5061789
 ;;^UTILITY(U,$J,358.3,10416,0)
 ;;=Y36.6X0S^^45^450^123
 ;;^UTILITY(U,$J,358.3,10416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10416,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,10416,1,4,0)
 ;;=4^Y36.6X0S
 ;;^UTILITY(U,$J,358.3,10416,2)
 ;;=^5061777
 ;;^UTILITY(U,$J,358.3,10417,0)
 ;;=Y36.410S^^45^450^131
 ;;^UTILITY(U,$J,358.3,10417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10417,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,10417,1,4,0)
 ;;=4^Y36.410S
 ;;^UTILITY(U,$J,358.3,10417,2)
 ;;=^5061693
 ;;^UTILITY(U,$J,358.3,10418,0)
 ;;=Y36.200S^^45^450^128
 ;;^UTILITY(U,$J,358.3,10418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10418,1,3,0)
 ;;=3^War Op Inv Explosion/Fragments,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,10418,1,4,0)
 ;;=4^Y36.200S
 ;;^UTILITY(U,$J,358.3,10418,2)
 ;;=^5061609
 ;;^UTILITY(U,$J,358.3,10419,0)
 ;;=Y36.300S^^45^450^129
 ;;^UTILITY(U,$J,358.3,10419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10419,1,3,0)
 ;;=3^War Op Inv Fire/Conflagr/Hot Subst,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,10419,1,4,0)
 ;;=4^Y36.300S
 ;;^UTILITY(U,$J,358.3,10419,2)
 ;;=^5061663
 ;;^UTILITY(U,$J,358.3,10420,0)
 ;;=Y36.230A^^45^450^125
 ;;^UTILITY(U,$J,358.3,10420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10420,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Init Encntr
 ;;^UTILITY(U,$J,358.3,10420,1,4,0)
 ;;=4^Y36.230A
 ;;^UTILITY(U,$J,358.3,10420,2)
 ;;=^5061625
 ;;^UTILITY(U,$J,358.3,10421,0)
 ;;=Y36.230D^^45^450^126
 ;;^UTILITY(U,$J,358.3,10421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10421,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Subs Encntr
 ;;^UTILITY(U,$J,358.3,10421,1,4,0)
 ;;=4^Y36.230D
 ;;^UTILITY(U,$J,358.3,10421,2)
 ;;=^5061626
 ;;^UTILITY(U,$J,358.3,10422,0)
 ;;=Y36.230S^^45^450^127
 ;;^UTILITY(U,$J,358.3,10422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10422,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Sequela
 ;;^UTILITY(U,$J,358.3,10422,1,4,0)
 ;;=4^Y36.230S
 ;;^UTILITY(U,$J,358.3,10422,2)
 ;;=^5061627
 ;;^UTILITY(U,$J,358.3,10423,0)
 ;;=Y36.7X0S^^45^450^139
 ;;^UTILITY(U,$J,358.3,10423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10423,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,10423,1,4,0)
 ;;=4^Y36.7X0S
 ;;^UTILITY(U,$J,358.3,10423,2)
 ;;=^5061783
 ;;^UTILITY(U,$J,358.3,10424,0)
 ;;=V47.6XXA^^45^450^14
 ;;^UTILITY(U,$J,358.3,10424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10424,1,3,0)
 ;;=3^Car Pasngr Injured in Collsn w/ Fixed Obj/Traffic,Init Encntr
 ;;^UTILITY(U,$J,358.3,10424,1,4,0)
 ;;=4^V47.6XXA
 ;;^UTILITY(U,$J,358.3,10424,2)
 ;;=^5140366
 ;;^UTILITY(U,$J,358.3,10425,0)
 ;;=V47.9XXA^^45^450^13
 ;;^UTILITY(U,$J,358.3,10425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10425,1,3,0)
 ;;=3^Car Occpnt,Unspec,Injured in Collsn w/ Fixed Obj/Traffic,Init Encntr
 ;;^UTILITY(U,$J,358.3,10425,1,4,0)
 ;;=4^V47.9XXA
 ;;^UTILITY(U,$J,358.3,10425,2)
 ;;=^5140369
 ;;^UTILITY(U,$J,358.3,10426,0)
 ;;=W26.2XXA^^45^450^15
 ;;^UTILITY(U,$J,358.3,10426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10426,1,3,0)
 ;;=3^Contact w/ Edge of Stiff Paper,Init Encntr
 ;;^UTILITY(U,$J,358.3,10426,1,4,0)
 ;;=4^W26.2XXA
 ;;^UTILITY(U,$J,358.3,10426,2)
 ;;=^5140372
 ;;^UTILITY(U,$J,358.3,10427,0)
 ;;=W26.8XXA^^45^450^16
 ;;^UTILITY(U,$J,358.3,10427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10427,1,3,0)
 ;;=3^Contact w/ Other Sharp Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,10427,1,4,0)
 ;;=4^W26.8XXA
 ;;^UTILITY(U,$J,358.3,10427,2)
 ;;=^5140375
 ;;^UTILITY(U,$J,358.3,10428,0)
 ;;=W26.9XXA^^45^450^17
 ;;^UTILITY(U,$J,358.3,10428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10428,1,3,0)
 ;;=3^Contact w/ Unspec Sharp Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,10428,1,4,0)
 ;;=4^W26.9XXA
 ;;^UTILITY(U,$J,358.3,10428,2)
 ;;=^5140378
 ;;^UTILITY(U,$J,358.3,10429,0)
 ;;=X50.0XXA^^45^450^103
 ;;^UTILITY(U,$J,358.3,10429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10429,1,3,0)
 ;;=3^Overexertion from Strenuous Movement/Load,Init Encntr
 ;;^UTILITY(U,$J,358.3,10429,1,4,0)
 ;;=4^X50.0XXA
 ;;^UTILITY(U,$J,358.3,10429,2)
 ;;=^5140381
 ;;^UTILITY(U,$J,358.3,10430,0)
 ;;=X50.1XXA^^45^450^105
 ;;^UTILITY(U,$J,358.3,10430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10430,1,3,0)
 ;;=3^Overextertion from Prlgd/Akwrd Postures,Init Encntr
 ;;^UTILITY(U,$J,358.3,10430,1,4,0)
 ;;=4^X50.1XXA
 ;;^UTILITY(U,$J,358.3,10430,2)
 ;;=^5140384
 ;;^UTILITY(U,$J,358.3,10431,0)
 ;;=X50.3XXA^^45^450^102
 ;;^UTILITY(U,$J,358.3,10431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10431,1,3,0)
 ;;=3^Overexertion from Repetitive Movements,Init Encntr
 ;;^UTILITY(U,$J,358.3,10431,1,4,0)
 ;;=4^X50.3XXA
 ;;^UTILITY(U,$J,358.3,10431,2)
 ;;=^5140387
 ;;^UTILITY(U,$J,358.3,10432,0)
 ;;=X50.9XXA^^45^450^104
 ;;^UTILITY(U,$J,358.3,10432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10432,1,3,0)
 ;;=3^Overexertion/Sten Mvmnts/Postures,Oth/Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,10432,1,4,0)
 ;;=4^X50.9XXA
 ;;^UTILITY(U,$J,358.3,10432,2)
 ;;=^5140390
 ;;^UTILITY(U,$J,358.3,10433,0)
 ;;=F02.81^^45^451^11
 ;;^UTILITY(U,$J,358.3,10433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10433,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10433,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,10433,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,10434,0)
 ;;=F02.80^^45^451^12
 ;;^UTILITY(U,$J,358.3,10434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10434,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10434,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,10434,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,10435,0)
 ;;=F03.91^^45^451^13
 ;;^UTILITY(U,$J,358.3,10435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10435,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbances,Unspec
 ;;^UTILITY(U,$J,358.3,10435,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,10435,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,10436,0)
 ;;=G31.83^^45^451^14
 ;;^UTILITY(U,$J,358.3,10436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10436,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,10436,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,10436,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,10437,0)
 ;;=F01.51^^45^451^30
 ;;^UTILITY(U,$J,358.3,10437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10437,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10437,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,10437,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,10438,0)
 ;;=F01.50^^45^451^31
 ;;^UTILITY(U,$J,358.3,10438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10438,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10438,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,10438,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,10439,0)
 ;;=A81.9^^45^451^6
 ;;^UTILITY(U,$J,358.3,10439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10439,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,10439,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,10439,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,10440,0)
 ;;=A81.09^^45^451^8
 ;;^UTILITY(U,$J,358.3,10440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10440,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,10440,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,10440,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,10441,0)
 ;;=A81.00^^45^451^9
 ;;^UTILITY(U,$J,358.3,10441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10441,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,10441,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,10441,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,10442,0)
 ;;=A81.01^^45^451^10
 ;;^UTILITY(U,$J,358.3,10442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10442,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,10442,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,10442,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,10443,0)
 ;;=A81.89^^45^451^7
 ;;^UTILITY(U,$J,358.3,10443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10443,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,10443,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,10443,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,10444,0)
 ;;=A81.2^^45^451^27
 ;;^UTILITY(U,$J,358.3,10444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10444,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,10444,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,10444,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,10445,0)
 ;;=B20.^^45^451^17
 ;;^UTILITY(U,$J,358.3,10445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10445,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10445,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,10445,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,10446,0)
 ;;=B20.^^45^451^18
 ;;^UTILITY(U,$J,358.3,10446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10446,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10446,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,10446,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,10447,0)
 ;;=F10.27^^45^451^1
 ;;^UTILITY(U,$J,358.3,10447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10447,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,10447,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,10447,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,10448,0)
 ;;=F19.97^^45^451^29
 ;;^UTILITY(U,$J,358.3,10448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10448,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,10448,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,10448,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,10449,0)
 ;;=F03.90^^45^451^15
 ;;^UTILITY(U,$J,358.3,10449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10449,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,10449,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,10449,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,10450,0)
 ;;=G30.0^^45^451^2
 ;;^UTILITY(U,$J,358.3,10450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10450,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,10450,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,10450,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,10451,0)
 ;;=G30.1^^45^451^3
 ;;^UTILITY(U,$J,358.3,10451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10451,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,10451,1,4,0)
 ;;=4^G30.1
