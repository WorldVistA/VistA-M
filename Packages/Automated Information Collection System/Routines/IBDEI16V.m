IBDEI16V ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19105,1,2,0)
 ;;=2^TENS,Unattended
 ;;^UTILITY(U,$J,358.3,19105,1,3,0)
 ;;=3^97014
 ;;^UTILITY(U,$J,358.3,19106,0)
 ;;=97032^^92^984^3^^^^1
 ;;^UTILITY(U,$J,358.3,19106,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19106,1,2,0)
 ;;=2^TENS,1+ Areas,Ea 15 min
 ;;^UTILITY(U,$J,358.3,19106,1,3,0)
 ;;=3^97032
 ;;^UTILITY(U,$J,358.3,19107,0)
 ;;=0362T^^92^985^3^^^^1
 ;;^UTILITY(U,$J,358.3,19107,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19107,1,2,0)
 ;;=2^Behavior ID Supporting Assess,Ea 15 min
 ;;^UTILITY(U,$J,358.3,19107,1,3,0)
 ;;=3^0362T
 ;;^UTILITY(U,$J,358.3,19108,0)
 ;;=97151^^92^985^1^^^^1
 ;;^UTILITY(U,$J,358.3,19108,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19108,1,2,0)
 ;;=2^Behavior ID Assess by MD/HCP,Ea 15 min
 ;;^UTILITY(U,$J,358.3,19108,1,3,0)
 ;;=3^97151
 ;;^UTILITY(U,$J,358.3,19109,0)
 ;;=97152^^92^985^2^^^^1
 ;;^UTILITY(U,$J,358.3,19109,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19109,1,2,0)
 ;;=2^Behavior ID Assess by Tech,Ea 15 min
 ;;^UTILITY(U,$J,358.3,19109,1,3,0)
 ;;=3^97152
 ;;^UTILITY(U,$J,358.3,19110,0)
 ;;=0373T^^92^986^1^^^^1
 ;;^UTILITY(U,$J,358.3,19110,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19110,1,2,0)
 ;;=2^Adaptive Behav ID Supporting Assess,Ea 15 min
 ;;^UTILITY(U,$J,358.3,19110,1,3,0)
 ;;=3^0373T
 ;;^UTILITY(U,$J,358.3,19111,0)
 ;;=97153^^92^986^2^^^^1
 ;;^UTILITY(U,$J,358.3,19111,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19111,1,2,0)
 ;;=2^Adaptive Behav Tx by Prot by Tech,Ea 15 min
 ;;^UTILITY(U,$J,358.3,19111,1,3,0)
 ;;=3^97153
 ;;^UTILITY(U,$J,358.3,19112,0)
 ;;=97154^^92^986^6^^^^1
 ;;^UTILITY(U,$J,358.3,19112,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19112,1,2,0)
 ;;=2^Grp Adaptive Behav Tx by Prot by Tech,Ea 15 min
 ;;^UTILITY(U,$J,358.3,19112,1,3,0)
 ;;=3^97154
 ;;^UTILITY(U,$J,358.3,19113,0)
 ;;=97155^^92^986^3^^^^1
 ;;^UTILITY(U,$J,358.3,19113,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19113,1,2,0)
 ;;=2^Adaptive Behav Tx w/ Prot Mod by MD/HCP,Ea 15 min
 ;;^UTILITY(U,$J,358.3,19113,1,3,0)
 ;;=3^97155
 ;;^UTILITY(U,$J,358.3,19114,0)
 ;;=97156^^92^986^4^^^^1
 ;;^UTILITY(U,$J,358.3,19114,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19114,1,2,0)
 ;;=2^Fam Adaptive Behav Tx Guidance by MD/HCP,Ea 15 min
 ;;^UTILITY(U,$J,358.3,19114,1,3,0)
 ;;=3^97156
 ;;^UTILITY(U,$J,358.3,19115,0)
 ;;=97157^^92^986^7^^^^1
 ;;^UTILITY(U,$J,358.3,19115,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19115,1,2,0)
 ;;=2^Multi-Fam Adaptive Beh Tx Gdn by MD/HCP,Ea 15 min
 ;;^UTILITY(U,$J,358.3,19115,1,3,0)
 ;;=3^97157
 ;;^UTILITY(U,$J,358.3,19116,0)
 ;;=97158^^92^986^5^^^^1
 ;;^UTILITY(U,$J,358.3,19116,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19116,1,2,0)
 ;;=2^Grp Adaptive Beh Tx w/ Prot Mod by MD/HCP,Ea 15min
 ;;^UTILITY(U,$J,358.3,19116,1,3,0)
 ;;=3^97158
 ;;^UTILITY(U,$J,358.3,19117,0)
 ;;=S9451^^92^987^2^^^^1
 ;;^UTILITY(U,$J,358.3,19117,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19117,1,2,0)
 ;;=2^Exercise Class,per Session
 ;;^UTILITY(U,$J,358.3,19117,1,3,0)
 ;;=3^S9451
 ;;^UTILITY(U,$J,358.3,19118,0)
 ;;=97129^^92^987^3^^^^1
 ;;^UTILITY(U,$J,358.3,19118,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19118,1,2,0)
 ;;=2^Therapeutic Intrvn Cognitive Function,1st 15 min
 ;;^UTILITY(U,$J,358.3,19118,1,3,0)
 ;;=3^97129
 ;;^UTILITY(U,$J,358.3,19119,0)
 ;;=97130^^92^987^4^^^^1
 ;;^UTILITY(U,$J,358.3,19119,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19119,1,2,0)
 ;;=2^Therapeutic Intrvn Cognitive Func,Ea Addl 15 min
