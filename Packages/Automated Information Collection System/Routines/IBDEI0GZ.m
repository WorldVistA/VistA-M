IBDEI0GZ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7848,1,4,0)
 ;;=4^Y37.200D
 ;;^UTILITY(U,$J,358.3,7848,2)
 ;;=^5137999
 ;;^UTILITY(U,$J,358.3,7849,0)
 ;;=X00.1XXA^^30^415^13
 ;;^UTILITY(U,$J,358.3,7849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7849,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,7849,1,4,0)
 ;;=4^X00.1XXA
 ;;^UTILITY(U,$J,358.3,7849,2)
 ;;=^5060664
 ;;^UTILITY(U,$J,358.3,7850,0)
 ;;=X00.1XXD^^30^415^14
 ;;^UTILITY(U,$J,358.3,7850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7850,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7850,1,4,0)
 ;;=4^X00.1XXD
 ;;^UTILITY(U,$J,358.3,7850,2)
 ;;=^5060665
 ;;^UTILITY(U,$J,358.3,7851,0)
 ;;=Y36.820S^^30^415^21
 ;;^UTILITY(U,$J,358.3,7851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7851,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,7851,1,4,0)
 ;;=4^Y36.820S
 ;;^UTILITY(U,$J,358.3,7851,2)
 ;;=^5061795
 ;;^UTILITY(U,$J,358.3,7852,0)
 ;;=Y36.810S^^30^415^24
 ;;^UTILITY(U,$J,358.3,7852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7852,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,7852,1,4,0)
 ;;=4^Y36.810S
 ;;^UTILITY(U,$J,358.3,7852,2)
 ;;=^5061789
 ;;^UTILITY(U,$J,358.3,7853,0)
 ;;=Y36.6X0S^^30^415^114
 ;;^UTILITY(U,$J,358.3,7853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7853,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,7853,1,4,0)
 ;;=4^Y36.6X0S
 ;;^UTILITY(U,$J,358.3,7853,2)
 ;;=^5061777
 ;;^UTILITY(U,$J,358.3,7854,0)
 ;;=Y36.410S^^30^415^122
 ;;^UTILITY(U,$J,358.3,7854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7854,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,7854,1,4,0)
 ;;=4^Y36.410S
 ;;^UTILITY(U,$J,358.3,7854,2)
 ;;=^5061693
 ;;^UTILITY(U,$J,358.3,7855,0)
 ;;=Y36.200S^^30^415^119
 ;;^UTILITY(U,$J,358.3,7855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7855,1,3,0)
 ;;=3^War Op Inv Explosion/Fragments,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,7855,1,4,0)
 ;;=4^Y36.200S
 ;;^UTILITY(U,$J,358.3,7855,2)
 ;;=^5061609
 ;;^UTILITY(U,$J,358.3,7856,0)
 ;;=Y36.300S^^30^415^120
 ;;^UTILITY(U,$J,358.3,7856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7856,1,3,0)
 ;;=3^War Op Inv Fire/Conflagr/Hot Subst,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,7856,1,4,0)
 ;;=4^Y36.300S
 ;;^UTILITY(U,$J,358.3,7856,2)
 ;;=^5061663
 ;;^UTILITY(U,$J,358.3,7857,0)
 ;;=Y36.230A^^30^415^116
 ;;^UTILITY(U,$J,358.3,7857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7857,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Init Encntr
 ;;^UTILITY(U,$J,358.3,7857,1,4,0)
 ;;=4^Y36.230A
 ;;^UTILITY(U,$J,358.3,7857,2)
 ;;=^5061625
 ;;^UTILITY(U,$J,358.3,7858,0)
 ;;=Y36.230D^^30^415^117
 ;;^UTILITY(U,$J,358.3,7858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7858,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7858,1,4,0)
 ;;=4^Y36.230D
 ;;^UTILITY(U,$J,358.3,7858,2)
 ;;=^5061626
 ;;^UTILITY(U,$J,358.3,7859,0)
 ;;=Y36.230S^^30^415^118
 ;;^UTILITY(U,$J,358.3,7859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7859,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Sequela
 ;;^UTILITY(U,$J,358.3,7859,1,4,0)
 ;;=4^Y36.230S
 ;;^UTILITY(U,$J,358.3,7859,2)
 ;;=^5061627
 ;;^UTILITY(U,$J,358.3,7860,0)
 ;;=Y36.7X0S^^30^415^130
 ;;^UTILITY(U,$J,358.3,7860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7860,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,7860,1,4,0)
 ;;=4^Y36.7X0S
