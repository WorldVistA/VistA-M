IBDEI0Q8 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12010,1,4,0)
 ;;=4^Y37.200A
 ;;^UTILITY(U,$J,358.3,12010,2)
 ;;=^5137997
 ;;^UTILITY(U,$J,358.3,12011,0)
 ;;=Y37.200D^^68^694^92
 ;;^UTILITY(U,$J,358.3,12011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12011,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,12011,1,4,0)
 ;;=4^Y37.200D
 ;;^UTILITY(U,$J,358.3,12011,2)
 ;;=^5137999
 ;;^UTILITY(U,$J,358.3,12012,0)
 ;;=X00.1XXA^^68^694^13
 ;;^UTILITY(U,$J,358.3,12012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12012,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,12012,1,4,0)
 ;;=4^X00.1XXA
 ;;^UTILITY(U,$J,358.3,12012,2)
 ;;=^5060664
 ;;^UTILITY(U,$J,358.3,12013,0)
 ;;=X00.1XXD^^68^694^14
 ;;^UTILITY(U,$J,358.3,12013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12013,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,12013,1,4,0)
 ;;=4^X00.1XXD
 ;;^UTILITY(U,$J,358.3,12013,2)
 ;;=^5060665
 ;;^UTILITY(U,$J,358.3,12014,0)
 ;;=Y36.820S^^68^694^21
 ;;^UTILITY(U,$J,358.3,12014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12014,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,12014,1,4,0)
 ;;=4^Y36.820S
 ;;^UTILITY(U,$J,358.3,12014,2)
 ;;=^5061795
 ;;^UTILITY(U,$J,358.3,12015,0)
 ;;=Y36.810S^^68^694^24
 ;;^UTILITY(U,$J,358.3,12015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12015,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,12015,1,4,0)
 ;;=4^Y36.810S
 ;;^UTILITY(U,$J,358.3,12015,2)
 ;;=^5061789
 ;;^UTILITY(U,$J,358.3,12016,0)
 ;;=Y36.6X0S^^68^694^114
 ;;^UTILITY(U,$J,358.3,12016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12016,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,12016,1,4,0)
 ;;=4^Y36.6X0S
 ;;^UTILITY(U,$J,358.3,12016,2)
 ;;=^5061777
 ;;^UTILITY(U,$J,358.3,12017,0)
 ;;=Y36.410S^^68^694^122
 ;;^UTILITY(U,$J,358.3,12017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12017,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,12017,1,4,0)
 ;;=4^Y36.410S
 ;;^UTILITY(U,$J,358.3,12017,2)
 ;;=^5061693
 ;;^UTILITY(U,$J,358.3,12018,0)
 ;;=Y36.200S^^68^694^119
 ;;^UTILITY(U,$J,358.3,12018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12018,1,3,0)
 ;;=3^War Op Inv Explosion/Fragments,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,12018,1,4,0)
 ;;=4^Y36.200S
 ;;^UTILITY(U,$J,358.3,12018,2)
 ;;=^5061609
 ;;^UTILITY(U,$J,358.3,12019,0)
 ;;=Y36.300S^^68^694^120
 ;;^UTILITY(U,$J,358.3,12019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12019,1,3,0)
 ;;=3^War Op Inv Fire/Conflagr/Hot Subst,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,12019,1,4,0)
 ;;=4^Y36.300S
 ;;^UTILITY(U,$J,358.3,12019,2)
 ;;=^5061663
 ;;^UTILITY(U,$J,358.3,12020,0)
 ;;=Y36.230A^^68^694^116
 ;;^UTILITY(U,$J,358.3,12020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12020,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Init Encntr
 ;;^UTILITY(U,$J,358.3,12020,1,4,0)
 ;;=4^Y36.230A
 ;;^UTILITY(U,$J,358.3,12020,2)
 ;;=^5061625
 ;;^UTILITY(U,$J,358.3,12021,0)
 ;;=Y36.230D^^68^694^117
 ;;^UTILITY(U,$J,358.3,12021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12021,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Subs Encntr
 ;;^UTILITY(U,$J,358.3,12021,1,4,0)
 ;;=4^Y36.230D
 ;;^UTILITY(U,$J,358.3,12021,2)
 ;;=^5061626
 ;;^UTILITY(U,$J,358.3,12022,0)
 ;;=Y36.230S^^68^694^118
 ;;^UTILITY(U,$J,358.3,12022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12022,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Sequela
