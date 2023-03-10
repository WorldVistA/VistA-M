IBDEI09P ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23712,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,23712,1,4,0)
 ;;=4^Y04.2XXA
 ;;^UTILITY(U,$J,358.3,23712,2)
 ;;=^5061171
 ;;^UTILITY(U,$J,358.3,23713,0)
 ;;=Y04.8XXA^^71^933^3
 ;;^UTILITY(U,$J,358.3,23713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23713,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Init Encntr
 ;;^UTILITY(U,$J,358.3,23713,1,4,0)
 ;;=4^Y04.8XXA
 ;;^UTILITY(U,$J,358.3,23713,2)
 ;;=^5061174
 ;;^UTILITY(U,$J,358.3,23714,0)
 ;;=Y04.2XXD^^71^933^6
 ;;^UTILITY(U,$J,358.3,23714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23714,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23714,1,4,0)
 ;;=4^Y04.2XXD
 ;;^UTILITY(U,$J,358.3,23714,2)
 ;;=^5061172
 ;;^UTILITY(U,$J,358.3,23715,0)
 ;;=Y04.8XXD^^71^933^4
 ;;^UTILITY(U,$J,358.3,23715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23715,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23715,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,23715,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,23716,0)
 ;;=Y36.200A^^71^933^133
 ;;^UTILITY(U,$J,358.3,23716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23716,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23716,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,23716,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,23717,0)
 ;;=Y36.200D^^71^933^134
 ;;^UTILITY(U,$J,358.3,23717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23717,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23717,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,23717,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,23718,0)
 ;;=Y36.300A^^71^933^135
 ;;^UTILITY(U,$J,358.3,23718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23718,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23718,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,23718,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,23719,0)
 ;;=Y36.300D^^71^933^136
 ;;^UTILITY(U,$J,358.3,23719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23719,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23719,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,23719,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,23720,0)
 ;;=Y36.410A^^71^933^130
 ;;^UTILITY(U,$J,358.3,23720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23720,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23720,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,23720,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,23721,0)
 ;;=Y36.410D^^71^933^132
 ;;^UTILITY(U,$J,358.3,23721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23721,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23721,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,23721,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,23722,0)
 ;;=Y36.6X0A^^71^933^122
 ;;^UTILITY(U,$J,358.3,23722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23722,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23722,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,23722,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,23723,0)
 ;;=Y36.6X0D^^71^933^124
 ;;^UTILITY(U,$J,358.3,23723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23723,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23723,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,23723,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,23724,0)
 ;;=Y36.7X0A^^71^933^137
 ;;^UTILITY(U,$J,358.3,23724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23724,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23724,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,23724,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,23725,0)
 ;;=Y36.7X0D^^71^933^138
 ;;^UTILITY(U,$J,358.3,23725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23725,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23725,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,23725,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,23726,0)
 ;;=Y36.810A^^71^933^27
 ;;^UTILITY(U,$J,358.3,23726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23726,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23726,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,23726,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,23727,0)
 ;;=Y36.810D^^71^933^28
 ;;^UTILITY(U,$J,358.3,23727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23727,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23727,1,4,0)
 ;;=4^Y36.810D
 ;;^UTILITY(U,$J,358.3,23727,2)
 ;;=^5061788
 ;;^UTILITY(U,$J,358.3,23728,0)
 ;;=Y36.820A^^71^933^24
 ;;^UTILITY(U,$J,358.3,23728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23728,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23728,1,4,0)
 ;;=4^Y36.820A
 ;;^UTILITY(U,$J,358.3,23728,2)
 ;;=^5061793
 ;;^UTILITY(U,$J,358.3,23729,0)
 ;;=Y36.820D^^71^933^25
 ;;^UTILITY(U,$J,358.3,23729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23729,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23729,1,4,0)
 ;;=4^Y36.820D
 ;;^UTILITY(U,$J,358.3,23729,2)
 ;;=^5061794
 ;;^UTILITY(U,$J,358.3,23730,0)
 ;;=Y37.200A^^71^933^96
 ;;^UTILITY(U,$J,358.3,23730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23730,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,23730,1,4,0)
 ;;=4^Y37.200A
 ;;^UTILITY(U,$J,358.3,23730,2)
 ;;=^5137997
 ;;^UTILITY(U,$J,358.3,23731,0)
 ;;=Y37.200D^^71^933^97
 ;;^UTILITY(U,$J,358.3,23731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23731,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23731,1,4,0)
 ;;=4^Y37.200D
 ;;^UTILITY(U,$J,358.3,23731,2)
 ;;=^5137999
 ;;^UTILITY(U,$J,358.3,23732,0)
 ;;=X00.1XXA^^71^933^18
 ;;^UTILITY(U,$J,358.3,23732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23732,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,23732,1,4,0)
 ;;=4^X00.1XXA
 ;;^UTILITY(U,$J,358.3,23732,2)
 ;;=^5060664
 ;;^UTILITY(U,$J,358.3,23733,0)
 ;;=X00.1XXD^^71^933^19
 ;;^UTILITY(U,$J,358.3,23733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23733,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23733,1,4,0)
 ;;=4^X00.1XXD
 ;;^UTILITY(U,$J,358.3,23733,2)
 ;;=^5060665
 ;;^UTILITY(U,$J,358.3,23734,0)
 ;;=Y36.820S^^71^933^26
 ;;^UTILITY(U,$J,358.3,23734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23734,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23734,1,4,0)
 ;;=4^Y36.820S
 ;;^UTILITY(U,$J,358.3,23734,2)
 ;;=^5061795
 ;;^UTILITY(U,$J,358.3,23735,0)
 ;;=Y36.810S^^71^933^29
 ;;^UTILITY(U,$J,358.3,23735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23735,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23735,1,4,0)
 ;;=4^Y36.810S
 ;;^UTILITY(U,$J,358.3,23735,2)
 ;;=^5061789
 ;;^UTILITY(U,$J,358.3,23736,0)
 ;;=Y36.6X0S^^71^933^123
 ;;^UTILITY(U,$J,358.3,23736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23736,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23736,1,4,0)
 ;;=4^Y36.6X0S
 ;;^UTILITY(U,$J,358.3,23736,2)
 ;;=^5061777
 ;;^UTILITY(U,$J,358.3,23737,0)
 ;;=Y36.410S^^71^933^131
 ;;^UTILITY(U,$J,358.3,23737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23737,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23737,1,4,0)
 ;;=4^Y36.410S
 ;;^UTILITY(U,$J,358.3,23737,2)
 ;;=^5061693
 ;;^UTILITY(U,$J,358.3,23738,0)
 ;;=Y36.200S^^71^933^128
 ;;^UTILITY(U,$J,358.3,23738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23738,1,3,0)
 ;;=3^War Op Inv Explosion/Fragments,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23738,1,4,0)
 ;;=4^Y36.200S
 ;;^UTILITY(U,$J,358.3,23738,2)
 ;;=^5061609
 ;;^UTILITY(U,$J,358.3,23739,0)
 ;;=Y36.300S^^71^933^129
 ;;^UTILITY(U,$J,358.3,23739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23739,1,3,0)
 ;;=3^War Op Inv Fire/Conflagr/Hot Subst,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23739,1,4,0)
 ;;=4^Y36.300S
 ;;^UTILITY(U,$J,358.3,23739,2)
 ;;=^5061663
 ;;^UTILITY(U,$J,358.3,23740,0)
 ;;=Y36.230A^^71^933^125
 ;;^UTILITY(U,$J,358.3,23740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23740,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Init Encntr
 ;;^UTILITY(U,$J,358.3,23740,1,4,0)
 ;;=4^Y36.230A
 ;;^UTILITY(U,$J,358.3,23740,2)
 ;;=^5061625
 ;;^UTILITY(U,$J,358.3,23741,0)
 ;;=Y36.230D^^71^933^126
 ;;^UTILITY(U,$J,358.3,23741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23741,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23741,1,4,0)
 ;;=4^Y36.230D
 ;;^UTILITY(U,$J,358.3,23741,2)
 ;;=^5061626
 ;;^UTILITY(U,$J,358.3,23742,0)
 ;;=Y36.230S^^71^933^127
 ;;^UTILITY(U,$J,358.3,23742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23742,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Sequela
 ;;^UTILITY(U,$J,358.3,23742,1,4,0)
 ;;=4^Y36.230S
 ;;^UTILITY(U,$J,358.3,23742,2)
 ;;=^5061627
 ;;^UTILITY(U,$J,358.3,23743,0)
 ;;=Y36.7X0S^^71^933^139
 ;;^UTILITY(U,$J,358.3,23743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23743,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,23743,1,4,0)
 ;;=4^Y36.7X0S
 ;;^UTILITY(U,$J,358.3,23743,2)
 ;;=^5061783
 ;;^UTILITY(U,$J,358.3,23744,0)
 ;;=V47.6XXA^^71^933^14
 ;;^UTILITY(U,$J,358.3,23744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23744,1,3,0)
 ;;=3^Car Pasngr Injured in Collsn w/ Fixed Obj/Traffic,Init Encntr
 ;;^UTILITY(U,$J,358.3,23744,1,4,0)
 ;;=4^V47.6XXA
 ;;^UTILITY(U,$J,358.3,23744,2)
 ;;=^5140366
 ;;^UTILITY(U,$J,358.3,23745,0)
 ;;=V47.9XXA^^71^933^13
 ;;^UTILITY(U,$J,358.3,23745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23745,1,3,0)
 ;;=3^Car Occpnt,Unspec,Injured in Collsn w/ Fixed Obj/Traffic,Init Encntr
 ;;^UTILITY(U,$J,358.3,23745,1,4,0)
 ;;=4^V47.9XXA
 ;;^UTILITY(U,$J,358.3,23745,2)
 ;;=^5140369
 ;;^UTILITY(U,$J,358.3,23746,0)
 ;;=W26.2XXA^^71^933^15
 ;;^UTILITY(U,$J,358.3,23746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23746,1,3,0)
 ;;=3^Contact w/ Edge of Stiff Paper,Init Encntr
 ;;^UTILITY(U,$J,358.3,23746,1,4,0)
 ;;=4^W26.2XXA
 ;;^UTILITY(U,$J,358.3,23746,2)
 ;;=^5140372
 ;;^UTILITY(U,$J,358.3,23747,0)
 ;;=W26.8XXA^^71^933^16
 ;;^UTILITY(U,$J,358.3,23747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23747,1,3,0)
 ;;=3^Contact w/ Other Sharp Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,23747,1,4,0)
 ;;=4^W26.8XXA
 ;;^UTILITY(U,$J,358.3,23747,2)
 ;;=^5140375
 ;;^UTILITY(U,$J,358.3,23748,0)
 ;;=W26.9XXA^^71^933^17
 ;;^UTILITY(U,$J,358.3,23748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23748,1,3,0)
 ;;=3^Contact w/ Unspec Sharp Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,23748,1,4,0)
 ;;=4^W26.9XXA
 ;;^UTILITY(U,$J,358.3,23748,2)
 ;;=^5140378
 ;;^UTILITY(U,$J,358.3,23749,0)
 ;;=X50.0XXA^^71^933^103
 ;;^UTILITY(U,$J,358.3,23749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23749,1,3,0)
 ;;=3^Overexertion from Strenuous Movement/Load,Init Encntr
 ;;^UTILITY(U,$J,358.3,23749,1,4,0)
 ;;=4^X50.0XXA
 ;;^UTILITY(U,$J,358.3,23749,2)
 ;;=^5140381
 ;;^UTILITY(U,$J,358.3,23750,0)
 ;;=X50.1XXA^^71^933^105
 ;;^UTILITY(U,$J,358.3,23750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23750,1,3,0)
 ;;=3^Overextertion from Prlgd/Akwrd Postures,Init Encntr
 ;;^UTILITY(U,$J,358.3,23750,1,4,0)
 ;;=4^X50.1XXA
 ;;^UTILITY(U,$J,358.3,23750,2)
 ;;=^5140384
 ;;^UTILITY(U,$J,358.3,23751,0)
 ;;=X50.3XXA^^71^933^102
 ;;^UTILITY(U,$J,358.3,23751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23751,1,3,0)
 ;;=3^Overexertion from Repetitive Movements,Init Encntr
 ;;^UTILITY(U,$J,358.3,23751,1,4,0)
 ;;=4^X50.3XXA
 ;;^UTILITY(U,$J,358.3,23751,2)
 ;;=^5140387
 ;;^UTILITY(U,$J,358.3,23752,0)
 ;;=X50.9XXA^^71^933^104
 ;;^UTILITY(U,$J,358.3,23752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23752,1,3,0)
 ;;=3^Overexertion/Sten Mvmnts/Postures,Oth/Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,23752,1,4,0)
 ;;=4^X50.9XXA
 ;;^UTILITY(U,$J,358.3,23752,2)
 ;;=^5140390
 ;;^UTILITY(U,$J,358.3,23753,0)
 ;;=F02.81^^71^934^11
 ;;^UTILITY(U,$J,358.3,23753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23753,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,23753,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,23753,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,23754,0)
 ;;=F02.80^^71^934^12
 ;;^UTILITY(U,$J,358.3,23754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23754,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,23754,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,23754,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,23755,0)
 ;;=F03.91^^71^934^13
 ;;^UTILITY(U,$J,358.3,23755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23755,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbances,Unspec
 ;;^UTILITY(U,$J,358.3,23755,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,23755,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,23756,0)
 ;;=G31.83^^71^934^14
 ;;^UTILITY(U,$J,358.3,23756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23756,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,23756,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,23756,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,23757,0)
 ;;=F01.51^^71^934^30
 ;;^UTILITY(U,$J,358.3,23757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23757,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,23757,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,23757,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,23758,0)
 ;;=F01.50^^71^934^31
 ;;^UTILITY(U,$J,358.3,23758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23758,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,23758,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,23758,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,23759,0)
 ;;=A81.9^^71^934^6
 ;;^UTILITY(U,$J,358.3,23759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23759,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,23759,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,23759,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,23760,0)
 ;;=A81.09^^71^934^8
 ;;^UTILITY(U,$J,358.3,23760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23760,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,23760,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,23760,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,23761,0)
 ;;=A81.00^^71^934^9
 ;;^UTILITY(U,$J,358.3,23761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23761,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,23761,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,23761,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,23762,0)
 ;;=A81.01^^71^934^10
 ;;^UTILITY(U,$J,358.3,23762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23762,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,23762,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,23762,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,23763,0)
 ;;=A81.89^^71^934^7
 ;;^UTILITY(U,$J,358.3,23763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23763,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,23763,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,23763,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,23764,0)
 ;;=A81.2^^71^934^27
 ;;^UTILITY(U,$J,358.3,23764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23764,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,23764,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,23764,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,23765,0)
 ;;=B20.^^71^934^17
 ;;^UTILITY(U,$J,358.3,23765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23765,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,23765,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,23765,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,23766,0)
 ;;=B20.^^71^934^18
 ;;^UTILITY(U,$J,358.3,23766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23766,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,23766,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,23766,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,23767,0)
 ;;=F10.27^^71^934^1
 ;;^UTILITY(U,$J,358.3,23767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23767,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,23767,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,23767,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,23768,0)
 ;;=F19.97^^71^934^29
 ;;^UTILITY(U,$J,358.3,23768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23768,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,23768,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,23768,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,23769,0)
 ;;=F03.90^^71^934^15
 ;;^UTILITY(U,$J,358.3,23769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23769,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,23769,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,23769,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,23770,0)
 ;;=G30.0^^71^934^2
 ;;^UTILITY(U,$J,358.3,23770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23770,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,23770,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,23770,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,23771,0)
 ;;=G30.1^^71^934^3
 ;;^UTILITY(U,$J,358.3,23771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23771,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,23771,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,23771,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,23772,0)
 ;;=G30.9^^71^934^4
 ;;^UTILITY(U,$J,358.3,23772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23772,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,23772,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,23772,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,23773,0)
 ;;=G10.^^71^934^19
 ;;^UTILITY(U,$J,358.3,23773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23773,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,23773,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,23773,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,23774,0)
 ;;=G10.^^71^934^20
 ;;^UTILITY(U,$J,358.3,23774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23774,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,23774,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,23774,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,23775,0)
 ;;=G90.3^^71^934^21
 ;;^UTILITY(U,$J,358.3,23775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23775,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,23775,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,23775,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,23776,0)
 ;;=G91.2^^71^934^22
