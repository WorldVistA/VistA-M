IBDEI39G ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52046,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,52046,1,4,0)
 ;;=4^Y04.2XXD
 ;;^UTILITY(U,$J,358.3,52046,2)
 ;;=^5061172
 ;;^UTILITY(U,$J,358.3,52047,0)
 ;;=Y04.8XXD^^193^2516^4
 ;;^UTILITY(U,$J,358.3,52047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52047,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,52047,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,52047,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,52048,0)
 ;;=Y36.200A^^193^2516^133
 ;;^UTILITY(U,$J,358.3,52048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52048,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,52048,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,52048,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,52049,0)
 ;;=Y36.200D^^193^2516^134
 ;;^UTILITY(U,$J,358.3,52049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52049,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,52049,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,52049,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,52050,0)
 ;;=Y36.300A^^193^2516^135
 ;;^UTILITY(U,$J,358.3,52050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52050,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,52050,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,52050,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,52051,0)
 ;;=Y36.300D^^193^2516^136
 ;;^UTILITY(U,$J,358.3,52051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52051,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,52051,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,52051,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,52052,0)
 ;;=Y36.410A^^193^2516^130
 ;;^UTILITY(U,$J,358.3,52052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52052,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,52052,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,52052,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,52053,0)
 ;;=Y36.410D^^193^2516^132
 ;;^UTILITY(U,$J,358.3,52053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52053,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,52053,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,52053,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,52054,0)
 ;;=Y36.6X0A^^193^2516^122
 ;;^UTILITY(U,$J,358.3,52054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52054,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,52054,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,52054,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,52055,0)
 ;;=Y36.6X0D^^193^2516^124
 ;;^UTILITY(U,$J,358.3,52055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52055,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,52055,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,52055,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,52056,0)
 ;;=Y36.7X0A^^193^2516^137
 ;;^UTILITY(U,$J,358.3,52056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52056,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,52056,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,52056,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,52057,0)
 ;;=Y36.7X0D^^193^2516^138
 ;;^UTILITY(U,$J,358.3,52057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52057,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
