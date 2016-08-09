IBDEI0XH ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33671,1,3,0)
 ;;=3^Assault by Unarmed Fight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33671,1,4,0)
 ;;=4^Y04.0XXD
 ;;^UTILITY(U,$J,358.3,33671,2)
 ;;=^5061166
 ;;^UTILITY(U,$J,358.3,33672,0)
 ;;=Y04.1XXA^^119^1583^1
 ;;^UTILITY(U,$J,358.3,33672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33672,1,3,0)
 ;;=3^Assault by Human Bite,Init Encntr
 ;;^UTILITY(U,$J,358.3,33672,1,4,0)
 ;;=4^Y04.1XXA
 ;;^UTILITY(U,$J,358.3,33672,2)
 ;;=^5061168
 ;;^UTILITY(U,$J,358.3,33673,0)
 ;;=Y04.1XXD^^119^1583^2
 ;;^UTILITY(U,$J,358.3,33673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33673,1,3,0)
 ;;=3^Assault by Human Bite,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33673,1,4,0)
 ;;=4^Y04.1XXD
 ;;^UTILITY(U,$J,358.3,33673,2)
 ;;=^5061169
 ;;^UTILITY(U,$J,358.3,33674,0)
 ;;=Y04.2XXA^^119^1583^5
 ;;^UTILITY(U,$J,358.3,33674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33674,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,33674,1,4,0)
 ;;=4^Y04.2XXA
 ;;^UTILITY(U,$J,358.3,33674,2)
 ;;=^5061171
 ;;^UTILITY(U,$J,358.3,33675,0)
 ;;=Y04.8XXA^^119^1583^3
 ;;^UTILITY(U,$J,358.3,33675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33675,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Init Encntr
 ;;^UTILITY(U,$J,358.3,33675,1,4,0)
 ;;=4^Y04.8XXA
 ;;^UTILITY(U,$J,358.3,33675,2)
 ;;=^5061174
 ;;^UTILITY(U,$J,358.3,33676,0)
 ;;=Y04.2XXD^^119^1583^6
 ;;^UTILITY(U,$J,358.3,33676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33676,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33676,1,4,0)
 ;;=4^Y04.2XXD
 ;;^UTILITY(U,$J,358.3,33676,2)
 ;;=^5061172
 ;;^UTILITY(U,$J,358.3,33677,0)
 ;;=Y04.8XXD^^119^1583^4
 ;;^UTILITY(U,$J,358.3,33677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33677,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33677,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,33677,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,33678,0)
 ;;=Y36.200A^^119^1583^124
 ;;^UTILITY(U,$J,358.3,33678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33678,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,33678,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,33678,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,33679,0)
 ;;=Y36.200D^^119^1583^125
 ;;^UTILITY(U,$J,358.3,33679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33679,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33679,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,33679,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,33680,0)
 ;;=Y36.300A^^119^1583^126
 ;;^UTILITY(U,$J,358.3,33680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33680,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,33680,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,33680,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,33681,0)
 ;;=Y36.300D^^119^1583^127
 ;;^UTILITY(U,$J,358.3,33681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33681,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33681,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,33681,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,33682,0)
 ;;=Y36.410A^^119^1583^121
 ;;^UTILITY(U,$J,358.3,33682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33682,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,33682,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,33682,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,33683,0)
 ;;=Y36.410D^^119^1583^123
 ;;^UTILITY(U,$J,358.3,33683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33683,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33683,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,33683,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,33684,0)
 ;;=Y36.6X0A^^119^1583^113
 ;;^UTILITY(U,$J,358.3,33684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33684,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,33684,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,33684,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,33685,0)
 ;;=Y36.6X0D^^119^1583^115
 ;;^UTILITY(U,$J,358.3,33685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33685,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33685,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,33685,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,33686,0)
 ;;=Y36.7X0A^^119^1583^128
 ;;^UTILITY(U,$J,358.3,33686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33686,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,33686,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,33686,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,33687,0)
 ;;=Y36.7X0D^^119^1583^129
 ;;^UTILITY(U,$J,358.3,33687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33687,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33687,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,33687,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,33688,0)
 ;;=Y36.810A^^119^1583^22
 ;;^UTILITY(U,$J,358.3,33688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33688,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,33688,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,33688,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,33689,0)
 ;;=Y36.810D^^119^1583^23
 ;;^UTILITY(U,$J,358.3,33689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33689,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33689,1,4,0)
 ;;=4^Y36.810D
 ;;^UTILITY(U,$J,358.3,33689,2)
 ;;=^5061788
 ;;^UTILITY(U,$J,358.3,33690,0)
 ;;=Y36.820A^^119^1583^19
 ;;^UTILITY(U,$J,358.3,33690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33690,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,33690,1,4,0)
 ;;=4^Y36.820A
 ;;^UTILITY(U,$J,358.3,33690,2)
 ;;=^5061793
 ;;^UTILITY(U,$J,358.3,33691,0)
 ;;=Y36.820D^^119^1583^20
 ;;^UTILITY(U,$J,358.3,33691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33691,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33691,1,4,0)
 ;;=4^Y36.820D
 ;;^UTILITY(U,$J,358.3,33691,2)
 ;;=^5061794
 ;;^UTILITY(U,$J,358.3,33692,0)
 ;;=Y37.200A^^119^1583^91
 ;;^UTILITY(U,$J,358.3,33692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33692,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,33692,1,4,0)
 ;;=4^Y37.200A
 ;;^UTILITY(U,$J,358.3,33692,2)
 ;;=^5137997
 ;;^UTILITY(U,$J,358.3,33693,0)
 ;;=Y37.200D^^119^1583^92
 ;;^UTILITY(U,$J,358.3,33693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33693,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33693,1,4,0)
 ;;=4^Y37.200D
 ;;^UTILITY(U,$J,358.3,33693,2)
 ;;=^5137999
 ;;^UTILITY(U,$J,358.3,33694,0)
 ;;=X00.1XXA^^119^1583^13
 ;;^UTILITY(U,$J,358.3,33694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33694,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,33694,1,4,0)
 ;;=4^X00.1XXA
 ;;^UTILITY(U,$J,358.3,33694,2)
 ;;=^5060664
 ;;^UTILITY(U,$J,358.3,33695,0)
 ;;=X00.1XXD^^119^1583^14
 ;;^UTILITY(U,$J,358.3,33695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33695,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33695,1,4,0)
 ;;=4^X00.1XXD
 ;;^UTILITY(U,$J,358.3,33695,2)
 ;;=^5060665
 ;;^UTILITY(U,$J,358.3,33696,0)
 ;;=Y36.820S^^119^1583^21
 ;;^UTILITY(U,$J,358.3,33696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33696,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,33696,1,4,0)
 ;;=4^Y36.820S
