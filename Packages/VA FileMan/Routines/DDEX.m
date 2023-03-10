DDEX ;SLC/MKB - Entity DD utilities ;AUG 1, 2018  12:37
 ;;22.2;VA FileMan;**9,21**;Jan 05, 2016;Build 4
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
 ;
CHKNAME ;Input transform for .01 field in ENTITY file (#1.5) ;p21
 I $D(DIC(0))#2,DIC(0)'["E" Q
 I $D(^DDE("B",X)) D EN^DDIOL("  Duplicate names are not allowed.") K X Q
 N %,%1 S %1=""
 D NAME I %1="" D EN^DDIOL("Not a known package or a local namespace.") Q
 D EN^DDIOL("  Located in the "_$E(X,1,%)_" ("_%1_") namespace.") Q
 Q
 ;
NAME ;check name X as PREFIX (#1) in PACKAGE file (#9.4)
 I $E(X,1)="Z" S %=1,%1="Local" Q
 F %=4:-1:2 G:$D(^DIC(9.4,"C",$E(X,1,%))) NAMEOK
 I $E(X,1)="A" S %=1,%1="Local" Q
 Q
 ;
NAMEOK S %1=$O(^DIC(9.4,"C",$E(X,1,%),0)) I %1,$G(^DIC(9.4,%1,0))]"" S %1=$P(^(0),U,1) Q
 S %1="" Q
 ;
