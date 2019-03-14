DDEX ;SLC/MKB - Entity DD utilities ;AUG 1, 2018  12:37
 ;;22.2;VA FileMan;**9**;Jan 05, 2016;Build 73
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
TREE ;Look back up tree to make sure item is not ancestor (input xform)
 ;From: 1.51,.08 Entry: DA(1),X
 N DDEDA,DDED
 S DDEDA=DA(1) K:X=DDEDA X
 D TREE1
 Q
TREE1 F DDED=0:0 Q:'$D(X)  S DDED=$O(^DDE("AD",DDEDA,DDED)) Q:DDED'>0  K:DDED=X X Q:'$D(X)  D TREE2
 Q
TREE2 N DDEDA S DDEDA=DDED N DDED D TREE1
 Q
 ;
FLDLST ; -- ??help for FIELD# [DDEFN set in ScreenMan form]
 N FN,DIC,DO,X
 S FN=$G(DDEFN) S:'FN FN=$P($G(^DDE(DA(1),1,DA,0)),U,4) Q:'FN
 S DIC="^DD("_FN_",",DIC(0)="EQ",X="??" D ^DIC
 Q
