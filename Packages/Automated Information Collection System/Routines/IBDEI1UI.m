IBDEI1UI ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32902,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,32902,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,32902,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,32903,0)
 ;;=Y36.300D^^190^1962^116
 ;;^UTILITY(U,$J,358.3,32903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32903,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32903,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,32903,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,32904,0)
 ;;=Y36.410A^^190^1962^111
 ;;^UTILITY(U,$J,358.3,32904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32904,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,32904,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,32904,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,32905,0)
 ;;=Y36.410D^^190^1962^112
 ;;^UTILITY(U,$J,358.3,32905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32905,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32905,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,32905,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,32906,0)
 ;;=Y36.6X0A^^190^1962^109
 ;;^UTILITY(U,$J,358.3,32906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32906,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,32906,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,32906,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,32907,0)
 ;;=Y36.6X0D^^190^1962^110
 ;;^UTILITY(U,$J,358.3,32907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32907,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32907,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,32907,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,32908,0)
 ;;=Y36.7X0A^^190^1962^117
 ;;^UTILITY(U,$J,358.3,32908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32908,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,32908,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,32908,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,32909,0)
 ;;=Y36.7X0D^^190^1962^118
 ;;^UTILITY(U,$J,358.3,32909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32909,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32909,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,32909,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,32910,0)
 ;;=Y36.810A^^190^1962^19
 ;;^UTILITY(U,$J,358.3,32910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32910,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,32910,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,32910,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,32911,0)
 ;;=Y36.810D^^190^1962^20
 ;;^UTILITY(U,$J,358.3,32911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32911,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32911,1,4,0)
 ;;=4^Y36.810D
 ;;^UTILITY(U,$J,358.3,32911,2)
 ;;=^5061788
 ;;^UTILITY(U,$J,358.3,32912,0)
 ;;=Y36.820A^^190^1962^17
 ;;^UTILITY(U,$J,358.3,32912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32912,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,32912,1,4,0)
 ;;=4^Y36.820A
 ;;^UTILITY(U,$J,358.3,32912,2)
 ;;=^5061793
 ;;^UTILITY(U,$J,358.3,32913,0)
 ;;=Y36.820D^^190^1962^18
 ;;^UTILITY(U,$J,358.3,32913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32913,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32913,1,4,0)
 ;;=4^Y36.820D
 ;;^UTILITY(U,$J,358.3,32913,2)
 ;;=^5061794
