IBDEI2KI ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40986,1,3,0)
 ;;=3^Assault by Strike/Bumped by Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,40986,1,4,0)
 ;;=4^Y04.2XXD
 ;;^UTILITY(U,$J,358.3,40986,2)
 ;;=^5061172
 ;;^UTILITY(U,$J,358.3,40987,0)
 ;;=Y04.8XXD^^152^2019^4
 ;;^UTILITY(U,$J,358.3,40987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40987,1,3,0)
 ;;=3^Assault by Oth Bodily Force,Subs Encntr
 ;;^UTILITY(U,$J,358.3,40987,1,4,0)
 ;;=4^Y04.8XXD
 ;;^UTILITY(U,$J,358.3,40987,2)
 ;;=^5061175
 ;;^UTILITY(U,$J,358.3,40988,0)
 ;;=Y36.200A^^152^2019^133
 ;;^UTILITY(U,$J,358.3,40988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40988,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,40988,1,4,0)
 ;;=4^Y36.200A
 ;;^UTILITY(U,$J,358.3,40988,2)
 ;;=^5061607
 ;;^UTILITY(U,$J,358.3,40989,0)
 ;;=Y36.200D^^152^2019^134
 ;;^UTILITY(U,$J,358.3,40989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40989,1,3,0)
 ;;=3^War Op Inv Unspec Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,40989,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,40989,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,40990,0)
 ;;=Y36.300A^^152^2019^135
 ;;^UTILITY(U,$J,358.3,40990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40990,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,40990,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,40990,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,40991,0)
 ;;=Y36.300D^^152^2019^136
 ;;^UTILITY(U,$J,358.3,40991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40991,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,40991,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,40991,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,40992,0)
 ;;=Y36.410A^^152^2019^130
 ;;^UTILITY(U,$J,358.3,40992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40992,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,40992,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,40992,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,40993,0)
 ;;=Y36.410D^^152^2019^132
 ;;^UTILITY(U,$J,358.3,40993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40993,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,40993,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,40993,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,40994,0)
 ;;=Y36.6X0A^^152^2019^122
 ;;^UTILITY(U,$J,358.3,40994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40994,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,40994,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,40994,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,40995,0)
 ;;=Y36.6X0D^^152^2019^124
 ;;^UTILITY(U,$J,358.3,40995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40995,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,40995,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,40995,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,40996,0)
 ;;=Y36.7X0A^^152^2019^137
 ;;^UTILITY(U,$J,358.3,40996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40996,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,40996,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,40996,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,40997,0)
 ;;=Y36.7X0D^^152^2019^138
 ;;^UTILITY(U,$J,358.3,40997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40997,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
