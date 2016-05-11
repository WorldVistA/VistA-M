IBDEI19A ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21339,1,4,0)
 ;;=4^Y37.200A
 ;;^UTILITY(U,$J,358.3,21339,2)
 ;;=^5137997
 ;;^UTILITY(U,$J,358.3,21340,0)
 ;;=Y37.200D^^84^948^92
 ;;^UTILITY(U,$J,358.3,21340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21340,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21340,1,4,0)
 ;;=4^Y37.200D
 ;;^UTILITY(U,$J,358.3,21340,2)
 ;;=^5137999
 ;;^UTILITY(U,$J,358.3,21341,0)
 ;;=X00.1XXA^^84^948^13
 ;;^UTILITY(U,$J,358.3,21341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21341,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,21341,1,4,0)
 ;;=4^X00.1XXA
 ;;^UTILITY(U,$J,358.3,21341,2)
 ;;=^5060664
 ;;^UTILITY(U,$J,358.3,21342,0)
 ;;=X00.1XXD^^84^948^14
 ;;^UTILITY(U,$J,358.3,21342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21342,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21342,1,4,0)
 ;;=4^X00.1XXD
 ;;^UTILITY(U,$J,358.3,21342,2)
 ;;=^5060665
 ;;^UTILITY(U,$J,358.3,21343,0)
 ;;=Y36.820S^^84^948^21
 ;;^UTILITY(U,$J,358.3,21343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21343,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,21343,1,4,0)
 ;;=4^Y36.820S
 ;;^UTILITY(U,$J,358.3,21343,2)
 ;;=^5061795
 ;;^UTILITY(U,$J,358.3,21344,0)
 ;;=Y36.810S^^84^948^24
 ;;^UTILITY(U,$J,358.3,21344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21344,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,21344,1,4,0)
 ;;=4^Y36.810S
 ;;^UTILITY(U,$J,358.3,21344,2)
 ;;=^5061789
 ;;^UTILITY(U,$J,358.3,21345,0)
 ;;=Y36.6X0S^^84^948^114
 ;;^UTILITY(U,$J,358.3,21345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21345,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,21345,1,4,0)
 ;;=4^Y36.6X0S
 ;;^UTILITY(U,$J,358.3,21345,2)
 ;;=^5061777
 ;;^UTILITY(U,$J,358.3,21346,0)
 ;;=Y36.410S^^84^948^122
 ;;^UTILITY(U,$J,358.3,21346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21346,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,21346,1,4,0)
 ;;=4^Y36.410S
 ;;^UTILITY(U,$J,358.3,21346,2)
 ;;=^5061693
 ;;^UTILITY(U,$J,358.3,21347,0)
 ;;=Y36.200S^^84^948^119
 ;;^UTILITY(U,$J,358.3,21347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21347,1,3,0)
 ;;=3^War Op Inv Explosion/Fragments,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,21347,1,4,0)
 ;;=4^Y36.200S
 ;;^UTILITY(U,$J,358.3,21347,2)
 ;;=^5061609
 ;;^UTILITY(U,$J,358.3,21348,0)
 ;;=Y36.300S^^84^948^120
 ;;^UTILITY(U,$J,358.3,21348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21348,1,3,0)
 ;;=3^War Op Inv Fire/Conflagr/Hot Subst,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,21348,1,4,0)
 ;;=4^Y36.300S
 ;;^UTILITY(U,$J,358.3,21348,2)
 ;;=^5061663
 ;;^UTILITY(U,$J,358.3,21349,0)
 ;;=Y36.230A^^84^948^116
 ;;^UTILITY(U,$J,358.3,21349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21349,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Init Encntr
 ;;^UTILITY(U,$J,358.3,21349,1,4,0)
 ;;=4^Y36.230A
 ;;^UTILITY(U,$J,358.3,21349,2)
 ;;=^5061625
 ;;^UTILITY(U,$J,358.3,21350,0)
 ;;=Y36.230D^^84^948^117
 ;;^UTILITY(U,$J,358.3,21350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21350,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21350,1,4,0)
 ;;=4^Y36.230D
 ;;^UTILITY(U,$J,358.3,21350,2)
 ;;=^5061626
 ;;^UTILITY(U,$J,358.3,21351,0)
 ;;=Y36.230S^^84^948^118
 ;;^UTILITY(U,$J,358.3,21351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21351,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Sequela
