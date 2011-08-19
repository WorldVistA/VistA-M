LR138P ;DALISC/FHS - LR*5.2*138 AFTER USER COMMITS ROUTINE KIDS INSTALL
 ;;5.2;LAB SERVICE;**138**;Sep 27, 1994
EN ;
 Q:'$D(XPDNM)
 ;Removing Alpha site dds
 K DIK,DA S DA(1)=63.04,DIK="^DD(63.04," F DA=.064,.065,.066,.067 D ^DIK
 K DIK,DA S DA(1)=63.05,DIK="^DD(63.05," F DA=.064,.065,.066,.067 D ^DIK
 K DIK,DA S DA(1)=68.02,DIK="^DD(68.02," F DA=95,96,97,98 D ^DIK
 K DIK,DA
 I $O(^LAB(64.81,0)) W !?5,"You still have unistalled data in LAB NLT/CPT CODES file ",!,$C(7)
 S X="SCDXUAPI" X ^%ZOSF("TEST") I '$T D  S XPDQUIT=2 Q
 . W !!,$$CJ^XLFSTR("You must Load the SD*5.3*63 to add OOS clinic locations",80),!,$$CJ^XLFSTR("BEFORE YOU INSTALL THIS PATCH",80),!! S LRSDCX=1
 S LRPKG=$O(^DIC(9.4,"B","LR",0))
 I 'LRPKG S LRPKG=$O(^DIC(9.4,"B","LAB SERVICE",0))
 I 'LRPKG W !!?10,"Not able to find 'LAB SERVICE' in your Package (#9.4) file.",!,"Contact your IRM Service !!",!!,$C(7) H 5 S XPDQUIT=2 Q
 K DA,DIK S DA(1)=64,DA=14,DIK="^DD(64," D ^DIK K DA,DIK
 W !!,$$CJ^XLFSTR("LOCKING THE ^LRO(69,AA) GLOBAL",80),!
 L +LRO(69,"AA"):10 I '$T W !!?5,"Not able to LOCK ^LRO(69,AA) Global" S XPDQUIT=2 Q
 W !,$$CJ^XLFSTR("Pre Install Step Complete",80),!!
 Q
