XPDB1 ;SFISC/RSD - Build utilities  ;10/15/2008
 ;;8.0;KERNEL;**108,539**;Jul 10, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
LOOK() ;Lookup BUILD, build XPDT from build file
 ;XPDT(seq #)=ien^name
 ;XPDT("DA",ien)=seq #
 N XPD,XPDA,XPDI,XPDNM,X,Y,Z K XPDT
 S XPDT=0
 S XPDA=$$DIC^XPDE("AEMQZ",,1) Q:'XPDA 0
 S XPDI=$P(Y(0),U)
 ;if type is Global Package, set DIRUT if there is other packages
 I $P(Y(0),U,3)=2 W "   GLOBAL PACKAGE"
 D PCK(XPDA,XPDI)
 G:$P(Y(0),U,3)'=1 LKX
 ;multi-package
 W "   (Multi-Package)" S X=0
 F  S X=$O(^XPD(9.6,XPDA,10,X)) Q:'X  S Z=$P($G(^(X,0)),U) D:Z]""
 .N XPDA,X
 .W !?3,Z S XPDA=$O(^XPD(9.6,"B",Z,0))
 .I 'XPDA W "  **Can't find definition in Build file**" Q
 .I $D(XPDT("DA",XPDA)) W "  already listed" Q
 .D PCK(XPDA,Z)
LKX Q XPDA
 ;
PCK(XPDA,XPDNM) ;XPDA=Build ien, XPDNM=Build name
 N Y
 S XPDT=XPDT+1,XPDT(XPDT)=XPDA_U_XPDNM,XPDT("DA",XPDA)=XPDT
 Q
 ;
