IBDEI13U ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17930,1,4,0)
 ;;=4^Y36.200D
 ;;^UTILITY(U,$J,358.3,17930,2)
 ;;=^5061608
 ;;^UTILITY(U,$J,358.3,17931,0)
 ;;=Y36.300A^^61^794^135
 ;;^UTILITY(U,$J,358.3,17931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17931,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,17931,1,4,0)
 ;;=4^Y36.300A
 ;;^UTILITY(U,$J,358.3,17931,2)
 ;;=^5061661
 ;;^UTILITY(U,$J,358.3,17932,0)
 ;;=Y36.300D^^61^794^136
 ;;^UTILITY(U,$J,358.3,17932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17932,1,3,0)
 ;;=3^War Op Inv Unspec Fire/Conflagr/Hot Subst,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17932,1,4,0)
 ;;=4^Y36.300D
 ;;^UTILITY(U,$J,358.3,17932,2)
 ;;=^5061662
 ;;^UTILITY(U,$J,358.3,17933,0)
 ;;=Y36.410A^^61^794^130
 ;;^UTILITY(U,$J,358.3,17933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17933,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,17933,1,4,0)
 ;;=4^Y36.410A
 ;;^UTILITY(U,$J,358.3,17933,2)
 ;;=^5061691
 ;;^UTILITY(U,$J,358.3,17934,0)
 ;;=Y36.410D^^61^794^132
 ;;^UTILITY(U,$J,358.3,17934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17934,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17934,1,4,0)
 ;;=4^Y36.410D
 ;;^UTILITY(U,$J,358.3,17934,2)
 ;;=^5061692
 ;;^UTILITY(U,$J,358.3,17935,0)
 ;;=Y36.6X0A^^61^794^122
 ;;^UTILITY(U,$J,358.3,17935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17935,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,17935,1,4,0)
 ;;=4^Y36.6X0A
 ;;^UTILITY(U,$J,358.3,17935,2)
 ;;=^5061775
 ;;^UTILITY(U,$J,358.3,17936,0)
 ;;=Y36.6X0D^^61^794^124
 ;;^UTILITY(U,$J,358.3,17936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17936,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17936,1,4,0)
 ;;=4^Y36.6X0D
 ;;^UTILITY(U,$J,358.3,17936,2)
 ;;=^5061776
 ;;^UTILITY(U,$J,358.3,17937,0)
 ;;=Y36.7X0A^^61^794^137
 ;;^UTILITY(U,$J,358.3,17937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17937,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,17937,1,4,0)
 ;;=4^Y36.7X0A
 ;;^UTILITY(U,$J,358.3,17937,2)
 ;;=^5061781
 ;;^UTILITY(U,$J,358.3,17938,0)
 ;;=Y36.7X0D^^61^794^138
 ;;^UTILITY(U,$J,358.3,17938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17938,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17938,1,4,0)
 ;;=4^Y36.7X0D
 ;;^UTILITY(U,$J,358.3,17938,2)
 ;;=^5061782
 ;;^UTILITY(U,$J,358.3,17939,0)
 ;;=Y36.810A^^61^794^27
 ;;^UTILITY(U,$J,358.3,17939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17939,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,17939,1,4,0)
 ;;=4^Y36.810A
 ;;^UTILITY(U,$J,358.3,17939,2)
 ;;=^5061787
 ;;^UTILITY(U,$J,358.3,17940,0)
 ;;=Y36.810D^^61^794^28
 ;;^UTILITY(U,$J,358.3,17940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17940,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld Aft,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17940,1,4,0)
 ;;=4^Y36.810D
 ;;^UTILITY(U,$J,358.3,17940,2)
 ;;=^5061788
 ;;^UTILITY(U,$J,358.3,17941,0)
 ;;=Y36.820A^^61^794^24
 ;;^UTILITY(U,$J,358.3,17941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17941,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op But Expld Aft,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,17941,1,4,0)
 ;;=4^Y36.820A
