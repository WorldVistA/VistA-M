IBDEI0BI ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28119,1,3,0)
 ;;=3^Exp to Sunlight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28119,1,4,0)
 ;;=4^X32.XXXD
 ;;^UTILITY(U,$J,358.3,28119,2)
 ;;=^5060848
 ;;^UTILITY(U,$J,358.3,28120,0)
 ;;=Y04.0XXA^^81^1092^7
 ;;^UTILITY(U,$J,358.3,28120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28120,1,3,0)
 ;;=3^Assault by Unarmed Fight,Init Encntr
 ;;^UTILITY(U,$J,358.3,28120,1,4,0)
 ;;=4^Y04.0XXA
 ;;^UTILITY(U,$J,358.3,28120,2)
 ;;=^5061165
 ;;^UTILITY(U,$J,358.3,28121,0)
 ;;=Y04.0XXD^^81^1092^8
 ;;^UTILITY(U,$J,358.3,28121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28121,1,3,0)
 ;;=3^Assault by Unarmed Fight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28121,1,4,0)
 ;;=4^Y04.0XXD
 ;;^UTILITY(U,$J,358.3,28121,2)
 ;;=^5061166
 ;;^UTILITY(U,$J,358.3,28122,0)
 ;;=Y04.1XXA^^81^1092^1
 ;;^UTILITY(U,$J,358.3,28122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28122,1,3,0)
 ;;=3^Assault by Human Bite,Init Encntr
 ;;^UTILITY(U,$J,358.3,28122,1,4,0)
 ;;=4^Y04.1XXA
 ;;^UTILITY(U,$J,358.3,28122,2)
 ;;=^5061168
 ;;^UTILITY(U,$J,358.3,28123,0)
 ;;=Y04.1XXD^^81^1092^2
 ;;^UTILITY(U,$J,358.3,28123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28123,1,3,0)
 ;;=3^Assault by Human Bite,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28123,1,4,0)
 ;;=4^Y04.1XXD
 ;;^UTILITY(U,$J,358.3,28123,2)
 ;;=^5061169
 ;;^UTILITY(U,$J,358.3,28124,0)
 ;;=Y04.2XXA^^81^1092^5
 ;;^UTILITY(U,$J,358.3,28124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28124,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,28124,1,4,0)
 ;;=4^Y04.2XXA
 ;;^UTILITY(U,$J,358.3,28124,2)
 ;;=^5061171
 ;;^UTILITY(U,$J,358.3,28125,0)
 ;;=Y04.8XXA^^81^1092^3
 ;;^UTILITY(U,$J,358.3,28125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28125,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Init Encntr
 ;;^UTILITY(U,$J,358.3,28125,1,4,0)
 ;;=4^Y04.8XXA
 ;;^UTILITY(U,$J,358.3,28125,2)
 ;;=^5061174
 ;;^UTILITY(U,$J,358.3,28126,0)
 ;;=Y04.2XXD^^81^1092^6
 ;;^UTILITY(U,$J,358.3,28126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28126,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28126,1,4,0)
 ;;=4^Y04.2XXD
 ;;^UTILITY(U,$J,358.3,28126,2)
 ;;=^5061172
 ;;^UTILITY(U,$J,358.3,28127,0)
 ;;=Y04.8XXD^^81^1092^4
 ;;^UTILITY(U,$J,358.3,28127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28127,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28127,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,28127,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,28128,0)
 ;;=Y36.200A^^81^1092^133
 ;;^UTILITY(U,$J,358.3,28128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28128,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,28128,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,28128,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,28129,0)
 ;;=Y36.200D^^81^1092^134
 ;;^UTILITY(U,$J,358.3,28129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28129,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28129,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,28129,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,28130,0)
 ;;=Y36.300A^^81^1092^135
 ;;^UTILITY(U,$J,358.3,28130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28130,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,28130,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,28130,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,28131,0)
 ;;=Y36.300D^^81^1092^136
 ;;^UTILITY(U,$J,358.3,28131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28131,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28131,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,28131,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,28132,0)
 ;;=Y36.410A^^81^1092^130
 ;;^UTILITY(U,$J,358.3,28132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28132,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,28132,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,28132,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,28133,0)
 ;;=Y36.410D^^81^1092^132
 ;;^UTILITY(U,$J,358.3,28133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28133,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28133,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,28133,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,28134,0)
 ;;=Y36.6X0A^^81^1092^122
 ;;^UTILITY(U,$J,358.3,28134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28134,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,28134,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,28134,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,28135,0)
 ;;=Y36.6X0D^^81^1092^124
 ;;^UTILITY(U,$J,358.3,28135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28135,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28135,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,28135,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,28136,0)
 ;;=Y36.7X0A^^81^1092^137
 ;;^UTILITY(U,$J,358.3,28136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28136,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,28136,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,28136,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,28137,0)
 ;;=Y36.7X0D^^81^1092^138
 ;;^UTILITY(U,$J,358.3,28137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28137,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28137,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,28137,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,28138,0)
 ;;=Y36.810A^^81^1092^27
 ;;^UTILITY(U,$J,358.3,28138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28138,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,28138,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,28138,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,28139,0)
 ;;=Y36.810D^^81^1092^28
 ;;^UTILITY(U,$J,358.3,28139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28139,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28139,1,4,0)
 ;;=4^Y36.810D
 ;;^UTILITY(U,$J,358.3,28139,2)
 ;;=^5061788
 ;;^UTILITY(U,$J,358.3,28140,0)
 ;;=Y36.820A^^81^1092^24
 ;;^UTILITY(U,$J,358.3,28140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28140,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,28140,1,4,0)
 ;;=4^Y36.820A
 ;;^UTILITY(U,$J,358.3,28140,2)
 ;;=^5061793
 ;;^UTILITY(U,$J,358.3,28141,0)
 ;;=Y36.820D^^81^1092^25
 ;;^UTILITY(U,$J,358.3,28141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28141,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28141,1,4,0)
 ;;=4^Y36.820D
 ;;^UTILITY(U,$J,358.3,28141,2)
 ;;=^5061794
 ;;^UTILITY(U,$J,358.3,28142,0)
 ;;=Y37.200A^^81^1092^96
 ;;^UTILITY(U,$J,358.3,28142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28142,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,28142,1,4,0)
 ;;=4^Y37.200A
 ;;^UTILITY(U,$J,358.3,28142,2)
 ;;=^5137997
 ;;^UTILITY(U,$J,358.3,28143,0)
 ;;=Y37.200D^^81^1092^97
 ;;^UTILITY(U,$J,358.3,28143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28143,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28143,1,4,0)
 ;;=4^Y37.200D
 ;;^UTILITY(U,$J,358.3,28143,2)
 ;;=^5137999
 ;;^UTILITY(U,$J,358.3,28144,0)
 ;;=X00.1XXA^^81^1092^18
 ;;^UTILITY(U,$J,358.3,28144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28144,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,28144,1,4,0)
 ;;=4^X00.1XXA
 ;;^UTILITY(U,$J,358.3,28144,2)
 ;;=^5060664
 ;;^UTILITY(U,$J,358.3,28145,0)
 ;;=X00.1XXD^^81^1092^19
 ;;^UTILITY(U,$J,358.3,28145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28145,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28145,1,4,0)
 ;;=4^X00.1XXD
 ;;^UTILITY(U,$J,358.3,28145,2)
 ;;=^5060665
 ;;^UTILITY(U,$J,358.3,28146,0)
 ;;=Y36.820S^^81^1092^26
 ;;^UTILITY(U,$J,358.3,28146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28146,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,28146,1,4,0)
 ;;=4^Y36.820S
 ;;^UTILITY(U,$J,358.3,28146,2)
 ;;=^5061795
 ;;^UTILITY(U,$J,358.3,28147,0)
 ;;=Y36.810S^^81^1092^29
 ;;^UTILITY(U,$J,358.3,28147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28147,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,28147,1,4,0)
 ;;=4^Y36.810S
 ;;^UTILITY(U,$J,358.3,28147,2)
 ;;=^5061789
 ;;^UTILITY(U,$J,358.3,28148,0)
 ;;=Y36.6X0S^^81^1092^123
 ;;^UTILITY(U,$J,358.3,28148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28148,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,28148,1,4,0)
 ;;=4^Y36.6X0S
 ;;^UTILITY(U,$J,358.3,28148,2)
 ;;=^5061777
 ;;^UTILITY(U,$J,358.3,28149,0)
 ;;=Y36.410S^^81^1092^131
 ;;^UTILITY(U,$J,358.3,28149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28149,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,28149,1,4,0)
 ;;=4^Y36.410S
 ;;^UTILITY(U,$J,358.3,28149,2)
 ;;=^5061693
 ;;^UTILITY(U,$J,358.3,28150,0)
 ;;=Y36.200S^^81^1092^128
 ;;^UTILITY(U,$J,358.3,28150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28150,1,3,0)
 ;;=3^War Op Inv Explosion/Fragments,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,28150,1,4,0)
 ;;=4^Y36.200S
 ;;^UTILITY(U,$J,358.3,28150,2)
 ;;=^5061609
 ;;^UTILITY(U,$J,358.3,28151,0)
 ;;=Y36.300S^^81^1092^129
 ;;^UTILITY(U,$J,358.3,28151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28151,1,3,0)
 ;;=3^War Op Inv Fire/Conflagr/Hot Subst,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,28151,1,4,0)
 ;;=4^Y36.300S
 ;;^UTILITY(U,$J,358.3,28151,2)
 ;;=^5061663
 ;;^UTILITY(U,$J,358.3,28152,0)
 ;;=Y36.230A^^81^1092^125
 ;;^UTILITY(U,$J,358.3,28152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28152,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Init Encntr
 ;;^UTILITY(U,$J,358.3,28152,1,4,0)
 ;;=4^Y36.230A
 ;;^UTILITY(U,$J,358.3,28152,2)
 ;;=^5061625
 ;;^UTILITY(U,$J,358.3,28153,0)
 ;;=Y36.230D^^81^1092^126
 ;;^UTILITY(U,$J,358.3,28153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28153,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28153,1,4,0)
 ;;=4^Y36.230D
 ;;^UTILITY(U,$J,358.3,28153,2)
 ;;=^5061626
 ;;^UTILITY(U,$J,358.3,28154,0)
 ;;=Y36.230S^^81^1092^127
 ;;^UTILITY(U,$J,358.3,28154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28154,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Sequela
 ;;^UTILITY(U,$J,358.3,28154,1,4,0)
 ;;=4^Y36.230S
 ;;^UTILITY(U,$J,358.3,28154,2)
 ;;=^5061627
 ;;^UTILITY(U,$J,358.3,28155,0)
 ;;=Y36.7X0S^^81^1092^139
 ;;^UTILITY(U,$J,358.3,28155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28155,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,28155,1,4,0)
 ;;=4^Y36.7X0S
 ;;^UTILITY(U,$J,358.3,28155,2)
 ;;=^5061783
 ;;^UTILITY(U,$J,358.3,28156,0)
 ;;=V47.6XXA^^81^1092^14
 ;;^UTILITY(U,$J,358.3,28156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28156,1,3,0)
 ;;=3^Car Pasngr Injured in Collsn w/ Fixed Obj/Traffic,Init Encntr
 ;;^UTILITY(U,$J,358.3,28156,1,4,0)
 ;;=4^V47.6XXA
 ;;^UTILITY(U,$J,358.3,28156,2)
 ;;=^5140366
 ;;^UTILITY(U,$J,358.3,28157,0)
 ;;=V47.9XXA^^81^1092^13
 ;;^UTILITY(U,$J,358.3,28157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28157,1,3,0)
 ;;=3^Car Occpnt,Unspec,Injured in Collsn w/ Fixed Obj/Traffic,Init Encntr
 ;;^UTILITY(U,$J,358.3,28157,1,4,0)
 ;;=4^V47.9XXA
 ;;^UTILITY(U,$J,358.3,28157,2)
 ;;=^5140369
 ;;^UTILITY(U,$J,358.3,28158,0)
 ;;=W26.2XXA^^81^1092^15
 ;;^UTILITY(U,$J,358.3,28158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28158,1,3,0)
 ;;=3^Contact w/ Edge of Stiff Paper,Init Encntr
 ;;^UTILITY(U,$J,358.3,28158,1,4,0)
 ;;=4^W26.2XXA
 ;;^UTILITY(U,$J,358.3,28158,2)
 ;;=^5140372
 ;;^UTILITY(U,$J,358.3,28159,0)
 ;;=W26.8XXA^^81^1092^16
 ;;^UTILITY(U,$J,358.3,28159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28159,1,3,0)
 ;;=3^Contact w/ Other Sharp Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,28159,1,4,0)
 ;;=4^W26.8XXA
 ;;^UTILITY(U,$J,358.3,28159,2)
 ;;=^5140375
 ;;^UTILITY(U,$J,358.3,28160,0)
 ;;=W26.9XXA^^81^1092^17
 ;;^UTILITY(U,$J,358.3,28160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28160,1,3,0)
 ;;=3^Contact w/ Unspec Sharp Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,28160,1,4,0)
 ;;=4^W26.9XXA
 ;;^UTILITY(U,$J,358.3,28160,2)
 ;;=^5140378
 ;;^UTILITY(U,$J,358.3,28161,0)
 ;;=X50.0XXA^^81^1092^103
 ;;^UTILITY(U,$J,358.3,28161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28161,1,3,0)
 ;;=3^Overexertion from Strenuous Movement/Load,Init Encntr
 ;;^UTILITY(U,$J,358.3,28161,1,4,0)
 ;;=4^X50.0XXA
 ;;^UTILITY(U,$J,358.3,28161,2)
 ;;=^5140381
 ;;^UTILITY(U,$J,358.3,28162,0)
 ;;=X50.1XXA^^81^1092^105
 ;;^UTILITY(U,$J,358.3,28162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28162,1,3,0)
 ;;=3^Overextertion from Prlgd/Akwrd Postures,Init Encntr
 ;;^UTILITY(U,$J,358.3,28162,1,4,0)
 ;;=4^X50.1XXA
 ;;^UTILITY(U,$J,358.3,28162,2)
 ;;=^5140384
 ;;^UTILITY(U,$J,358.3,28163,0)
 ;;=X50.3XXA^^81^1092^102
 ;;^UTILITY(U,$J,358.3,28163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28163,1,3,0)
 ;;=3^Overexertion from Repetitive Movements,Init Encntr
 ;;^UTILITY(U,$J,358.3,28163,1,4,0)
 ;;=4^X50.3XXA
 ;;^UTILITY(U,$J,358.3,28163,2)
 ;;=^5140387
 ;;^UTILITY(U,$J,358.3,28164,0)
 ;;=X50.9XXA^^81^1092^104
 ;;^UTILITY(U,$J,358.3,28164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28164,1,3,0)
 ;;=3^Overexertion/Sten Mvmnts/Postures,Oth/Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,28164,1,4,0)
 ;;=4^X50.9XXA
 ;;^UTILITY(U,$J,358.3,28164,2)
 ;;=^5140390
 ;;^UTILITY(U,$J,358.3,28165,0)
 ;;=F02.81^^81^1093^11
 ;;^UTILITY(U,$J,358.3,28165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28165,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,28165,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,28165,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,28166,0)
 ;;=F02.80^^81^1093^12
 ;;^UTILITY(U,$J,358.3,28166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28166,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,28166,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,28166,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,28167,0)
 ;;=F03.91^^81^1093^13
 ;;^UTILITY(U,$J,358.3,28167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28167,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbances,Unspec
 ;;^UTILITY(U,$J,358.3,28167,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,28167,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,28168,0)
 ;;=G31.83^^81^1093^14
 ;;^UTILITY(U,$J,358.3,28168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28168,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,28168,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,28168,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,28169,0)
 ;;=F01.51^^81^1093^30
 ;;^UTILITY(U,$J,358.3,28169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28169,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,28169,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,28169,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,28170,0)
 ;;=F01.50^^81^1093^31
 ;;^UTILITY(U,$J,358.3,28170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28170,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,28170,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,28170,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,28171,0)
 ;;=A81.9^^81^1093^6
 ;;^UTILITY(U,$J,358.3,28171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28171,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,28171,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,28171,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,28172,0)
 ;;=A81.09^^81^1093^8
 ;;^UTILITY(U,$J,358.3,28172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28172,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,28172,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,28172,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,28173,0)
 ;;=A81.00^^81^1093^9
 ;;^UTILITY(U,$J,358.3,28173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28173,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,28173,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,28173,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,28174,0)
 ;;=A81.01^^81^1093^10
 ;;^UTILITY(U,$J,358.3,28174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28174,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,28174,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,28174,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,28175,0)
 ;;=A81.89^^81^1093^7
 ;;^UTILITY(U,$J,358.3,28175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28175,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,28175,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,28175,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,28176,0)
 ;;=A81.2^^81^1093^27
 ;;^UTILITY(U,$J,358.3,28176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28176,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,28176,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,28176,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,28177,0)
 ;;=B20.^^81^1093^17
 ;;^UTILITY(U,$J,358.3,28177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28177,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,28177,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,28177,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,28178,0)
 ;;=B20.^^81^1093^18
 ;;^UTILITY(U,$J,358.3,28178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28178,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,28178,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,28178,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,28179,0)
 ;;=F10.27^^81^1093^1
 ;;^UTILITY(U,$J,358.3,28179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28179,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,28179,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,28179,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,28180,0)
 ;;=F19.97^^81^1093^29
 ;;^UTILITY(U,$J,358.3,28180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28180,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,28180,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,28180,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,28181,0)
 ;;=F03.90^^81^1093^15
 ;;^UTILITY(U,$J,358.3,28181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28181,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,28181,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,28181,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,28182,0)
 ;;=G30.0^^81^1093^2
 ;;^UTILITY(U,$J,358.3,28182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28182,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,28182,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,28182,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,28183,0)
 ;;=G30.1^^81^1093^3
 ;;^UTILITY(U,$J,358.3,28183,1,0)
 ;;=^358.31IA^4^2
