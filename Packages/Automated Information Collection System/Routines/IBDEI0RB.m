IBDEI0RB ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36086,0)
 ;;=Y04.8XXA^^100^1526^3
 ;;^UTILITY(U,$J,358.3,36086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36086,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Init Encntr
 ;;^UTILITY(U,$J,358.3,36086,1,4,0)
 ;;=4^Y04.8XXA
 ;;^UTILITY(U,$J,358.3,36086,2)
 ;;=^5061174
 ;;^UTILITY(U,$J,358.3,36087,0)
 ;;=Y04.2XXD^^100^1526^6
 ;;^UTILITY(U,$J,358.3,36087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36087,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36087,1,4,0)
 ;;=4^Y04.2XXD
 ;;^UTILITY(U,$J,358.3,36087,2)
 ;;=^5061172
 ;;^UTILITY(U,$J,358.3,36088,0)
 ;;=Y04.8XXD^^100^1526^4
 ;;^UTILITY(U,$J,358.3,36088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36088,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36088,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,36088,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,36089,0)
 ;;=Y36.200A^^100^1526^124
 ;;^UTILITY(U,$J,358.3,36089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36089,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,36089,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,36089,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,36090,0)
 ;;=Y36.200D^^100^1526^125
 ;;^UTILITY(U,$J,358.3,36090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36090,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36090,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,36090,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,36091,0)
 ;;=Y36.300A^^100^1526^126
 ;;^UTILITY(U,$J,358.3,36091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36091,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,36091,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,36091,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,36092,0)
 ;;=Y36.300D^^100^1526^127
 ;;^UTILITY(U,$J,358.3,36092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36092,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36092,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,36092,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,36093,0)
 ;;=Y36.410A^^100^1526^121
 ;;^UTILITY(U,$J,358.3,36093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36093,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,36093,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,36093,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,36094,0)
 ;;=Y36.410D^^100^1526^123
 ;;^UTILITY(U,$J,358.3,36094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36094,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36094,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,36094,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,36095,0)
 ;;=Y36.6X0A^^100^1526^113
 ;;^UTILITY(U,$J,358.3,36095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36095,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,36095,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,36095,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,36096,0)
 ;;=Y36.6X0D^^100^1526^115
 ;;^UTILITY(U,$J,358.3,36096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36096,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36096,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,36096,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,36097,0)
 ;;=Y36.7X0A^^100^1526^128
 ;;^UTILITY(U,$J,358.3,36097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36097,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,36097,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,36097,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,36098,0)
 ;;=Y36.7X0D^^100^1526^129
 ;;^UTILITY(U,$J,358.3,36098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36098,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36098,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,36098,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,36099,0)
 ;;=Y36.810A^^100^1526^22
 ;;^UTILITY(U,$J,358.3,36099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36099,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,36099,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,36099,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,36100,0)
 ;;=Y36.810D^^100^1526^23
 ;;^UTILITY(U,$J,358.3,36100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36100,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36100,1,4,0)
 ;;=4^Y36.810D
 ;;^UTILITY(U,$J,358.3,36100,2)
 ;;=^5061788
 ;;^UTILITY(U,$J,358.3,36101,0)
 ;;=Y36.820A^^100^1526^19
 ;;^UTILITY(U,$J,358.3,36101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36101,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,36101,1,4,0)
 ;;=4^Y36.820A
 ;;^UTILITY(U,$J,358.3,36101,2)
 ;;=^5061793
 ;;^UTILITY(U,$J,358.3,36102,0)
 ;;=Y36.820D^^100^1526^20
 ;;^UTILITY(U,$J,358.3,36102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36102,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36102,1,4,0)
 ;;=4^Y36.820D
 ;;^UTILITY(U,$J,358.3,36102,2)
 ;;=^5061794
 ;;^UTILITY(U,$J,358.3,36103,0)
 ;;=Y37.200A^^100^1526^91
 ;;^UTILITY(U,$J,358.3,36103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36103,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,36103,1,4,0)
 ;;=4^Y37.200A
 ;;^UTILITY(U,$J,358.3,36103,2)
 ;;=^5137997
 ;;^UTILITY(U,$J,358.3,36104,0)
 ;;=Y37.200D^^100^1526^92
 ;;^UTILITY(U,$J,358.3,36104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36104,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36104,1,4,0)
 ;;=4^Y37.200D
 ;;^UTILITY(U,$J,358.3,36104,2)
 ;;=^5137999
 ;;^UTILITY(U,$J,358.3,36105,0)
 ;;=X00.1XXA^^100^1526^13
 ;;^UTILITY(U,$J,358.3,36105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36105,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,36105,1,4,0)
 ;;=4^X00.1XXA
 ;;^UTILITY(U,$J,358.3,36105,2)
 ;;=^5060664
 ;;^UTILITY(U,$J,358.3,36106,0)
 ;;=X00.1XXD^^100^1526^14
 ;;^UTILITY(U,$J,358.3,36106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36106,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36106,1,4,0)
 ;;=4^X00.1XXD
 ;;^UTILITY(U,$J,358.3,36106,2)
 ;;=^5060665
 ;;^UTILITY(U,$J,358.3,36107,0)
 ;;=Y36.820S^^100^1526^21
 ;;^UTILITY(U,$J,358.3,36107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36107,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,36107,1,4,0)
 ;;=4^Y36.820S
 ;;^UTILITY(U,$J,358.3,36107,2)
 ;;=^5061795
 ;;^UTILITY(U,$J,358.3,36108,0)
 ;;=Y36.810S^^100^1526^24
 ;;^UTILITY(U,$J,358.3,36108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36108,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,36108,1,4,0)
 ;;=4^Y36.810S
 ;;^UTILITY(U,$J,358.3,36108,2)
 ;;=^5061789
 ;;^UTILITY(U,$J,358.3,36109,0)
 ;;=Y36.6X0S^^100^1526^114
 ;;^UTILITY(U,$J,358.3,36109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36109,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,36109,1,4,0)
 ;;=4^Y36.6X0S
 ;;^UTILITY(U,$J,358.3,36109,2)
 ;;=^5061777
 ;;^UTILITY(U,$J,358.3,36110,0)
 ;;=Y36.410S^^100^1526^122
 ;;^UTILITY(U,$J,358.3,36110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36110,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,36110,1,4,0)
 ;;=4^Y36.410S
 ;;^UTILITY(U,$J,358.3,36110,2)
 ;;=^5061693
 ;;^UTILITY(U,$J,358.3,36111,0)
 ;;=Y36.200S^^100^1526^119
 ;;^UTILITY(U,$J,358.3,36111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36111,1,3,0)
 ;;=3^War Op Inv Explosion/Fragments,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,36111,1,4,0)
 ;;=4^Y36.200S
 ;;^UTILITY(U,$J,358.3,36111,2)
 ;;=^5061609
 ;;^UTILITY(U,$J,358.3,36112,0)
 ;;=Y36.300S^^100^1526^120
 ;;^UTILITY(U,$J,358.3,36112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36112,1,3,0)
 ;;=3^War Op Inv Fire/Conflagr/Hot Subst,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,36112,1,4,0)
 ;;=4^Y36.300S
 ;;^UTILITY(U,$J,358.3,36112,2)
 ;;=^5061663
 ;;^UTILITY(U,$J,358.3,36113,0)
 ;;=Y36.230A^^100^1526^116
 ;;^UTILITY(U,$J,358.3,36113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36113,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Init Encntr
 ;;^UTILITY(U,$J,358.3,36113,1,4,0)
 ;;=4^Y36.230A
 ;;^UTILITY(U,$J,358.3,36113,2)
 ;;=^5061625
 ;;^UTILITY(U,$J,358.3,36114,0)
 ;;=Y36.230D^^100^1526^117
 ;;^UTILITY(U,$J,358.3,36114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36114,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Subs Encntr
 ;;^UTILITY(U,$J,358.3,36114,1,4,0)
 ;;=4^Y36.230D
 ;;^UTILITY(U,$J,358.3,36114,2)
 ;;=^5061626
 ;;^UTILITY(U,$J,358.3,36115,0)
 ;;=Y36.230S^^100^1526^118
 ;;^UTILITY(U,$J,358.3,36115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36115,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Sequela
 ;;^UTILITY(U,$J,358.3,36115,1,4,0)
 ;;=4^Y36.230S
 ;;^UTILITY(U,$J,358.3,36115,2)
 ;;=^5061627
 ;;^UTILITY(U,$J,358.3,36116,0)
 ;;=Y36.7X0S^^100^1526^130
 ;;^UTILITY(U,$J,358.3,36116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36116,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,36116,1,4,0)
 ;;=4^Y36.7X0S
 ;;^UTILITY(U,$J,358.3,36116,2)
 ;;=^5061783
 ;;^UTILITY(U,$J,358.3,36117,0)
 ;;=F02.81^^100^1527^11
 ;;^UTILITY(U,$J,358.3,36117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36117,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,36117,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,36117,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,36118,0)
 ;;=F02.80^^100^1527^12
 ;;^UTILITY(U,$J,358.3,36118,1,0)
 ;;=^358.31IA^4^2
