IBDEI0VE ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14713,1,4,0)
 ;;=4^Y37.200A
 ;;^UTILITY(U,$J,358.3,14713,2)
 ;;=^5137997
 ;;^UTILITY(U,$J,358.3,14714,0)
 ;;=Y37.200D^^53^612^92
 ;;^UTILITY(U,$J,358.3,14714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14714,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14714,1,4,0)
 ;;=4^Y37.200D
 ;;^UTILITY(U,$J,358.3,14714,2)
 ;;=^5137999
 ;;^UTILITY(U,$J,358.3,14715,0)
 ;;=X00.1XXA^^53^612^13
 ;;^UTILITY(U,$J,358.3,14715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14715,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,14715,1,4,0)
 ;;=4^X00.1XXA
 ;;^UTILITY(U,$J,358.3,14715,2)
 ;;=^5060664
 ;;^UTILITY(U,$J,358.3,14716,0)
 ;;=X00.1XXD^^53^612^14
 ;;^UTILITY(U,$J,358.3,14716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14716,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14716,1,4,0)
 ;;=4^X00.1XXD
 ;;^UTILITY(U,$J,358.3,14716,2)
 ;;=^5060665
 ;;^UTILITY(U,$J,358.3,14717,0)
 ;;=Y36.820S^^53^612^21
 ;;^UTILITY(U,$J,358.3,14717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14717,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,14717,1,4,0)
 ;;=4^Y36.820S
 ;;^UTILITY(U,$J,358.3,14717,2)
 ;;=^5061795
 ;;^UTILITY(U,$J,358.3,14718,0)
 ;;=Y36.810S^^53^612^24
 ;;^UTILITY(U,$J,358.3,14718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14718,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,14718,1,4,0)
 ;;=4^Y36.810S
 ;;^UTILITY(U,$J,358.3,14718,2)
 ;;=^5061789
 ;;^UTILITY(U,$J,358.3,14719,0)
 ;;=Y36.6X0S^^53^612^114
 ;;^UTILITY(U,$J,358.3,14719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14719,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,14719,1,4,0)
 ;;=4^Y36.6X0S
 ;;^UTILITY(U,$J,358.3,14719,2)
 ;;=^5061777
 ;;^UTILITY(U,$J,358.3,14720,0)
 ;;=Y36.410S^^53^612^122
 ;;^UTILITY(U,$J,358.3,14720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14720,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,14720,1,4,0)
 ;;=4^Y36.410S
 ;;^UTILITY(U,$J,358.3,14720,2)
 ;;=^5061693
 ;;^UTILITY(U,$J,358.3,14721,0)
 ;;=Y36.200S^^53^612^119
 ;;^UTILITY(U,$J,358.3,14721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14721,1,3,0)
 ;;=3^War Op Inv Explosion/Fragments,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,14721,1,4,0)
 ;;=4^Y36.200S
 ;;^UTILITY(U,$J,358.3,14721,2)
 ;;=^5061609
 ;;^UTILITY(U,$J,358.3,14722,0)
 ;;=Y36.300S^^53^612^120
 ;;^UTILITY(U,$J,358.3,14722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14722,1,3,0)
 ;;=3^War Op Inv Fire/Conflagr/Hot Subst,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,14722,1,4,0)
 ;;=4^Y36.300S
 ;;^UTILITY(U,$J,358.3,14722,2)
 ;;=^5061663
 ;;^UTILITY(U,$J,358.3,14723,0)
 ;;=Y36.230A^^53^612^116
 ;;^UTILITY(U,$J,358.3,14723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14723,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Init Encntr
 ;;^UTILITY(U,$J,358.3,14723,1,4,0)
 ;;=4^Y36.230A
 ;;^UTILITY(U,$J,358.3,14723,2)
 ;;=^5061625
 ;;^UTILITY(U,$J,358.3,14724,0)
 ;;=Y36.230D^^53^612^117
 ;;^UTILITY(U,$J,358.3,14724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14724,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14724,1,4,0)
 ;;=4^Y36.230D
 ;;^UTILITY(U,$J,358.3,14724,2)
 ;;=^5061626
 ;;^UTILITY(U,$J,358.3,14725,0)
 ;;=Y36.230S^^53^612^118
 ;;^UTILITY(U,$J,358.3,14725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14725,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Sequela
