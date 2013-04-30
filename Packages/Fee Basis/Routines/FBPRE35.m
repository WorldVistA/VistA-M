FBPRE35 ;AISC/DMK-PRE-INIT FOR FEE BASIS ;5/24/94  09:25
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;CHECK DUZ and DUZ(0)
 I $S('($D(DUZ)#2):1,'($D(DUZ(0))#2):1,'DUZ:1,1:0) W *7,!!,"***  DUZ and DUZ(0) must be defined as a valid user to initialize.  ***",!! K DIFQ Q
 I DUZ(0)'="@" W *7,!!,"You must have programmer access (DUZ(0)='@') before running FBINIT.",!! K DIFQ Q
 ;
 ;check for routine XPDUTL (part of kernel tool kit 7.2
 S X="XPDUTL" X ^%ZOSF("TEST") I '$T D  K DIFQ Q
 .W *7,!,"Routine XPDUTL, part of Kernel Tool Kit 7.2 was not found on",!,"your system.  This must be installed prior to installing this",!,"version of Fee Basis.",!
 ;
 ;check version of Fee Basis. If Fee is installed, must be version 3.0.
 S X=+$$VERSION^XPDUTL("FB") I X,X<3 D  Q
 .W *7,!,"You must have Fee Basis Version 3.0 installed prior to installing version 3.5",! K DIFQ
 I $D(^FBAA(161.81,6)) S X=$O(^FBAA(161.81,"B","CONTRACT HOSPITAL",0)) I X D
 .N DA,DIE,DIC,DR
 .S DA=X,DIE="^FBAA(161.81,",DR=".01///"_"NON-VA HOSPITAL" D ^DIE
 ;
VER ;determine appropriate version number
 N FBI,FBV,FBVNEW,FBX,FBY
 S FBI=1 F  S FBV=$P($T(V+FBI),";;",2) Q:FBV="END"  S FBI=FBI+1,FBVNEW=$P(FBV,";",2),FBX=$P(FBV,";") D  Q:'$D(DIFQ)
 .S X=+$$VERSION^XPDUTL(FBX) D:X'>0 MESS1 K:X'>0 DIFQ I X>0,X<FBVNEW D MESS2 K DIFQ
 ;
CLEANUP ;driver to cleanup package file entries.
 N I,X
 F I=1:1 S X=$P($T(OLDPKG+I),";;",2) Q:'$L(X)  D DELPKG(X)
 ;
 ;driver to queue data for transmission before install
 I $G(DIFQ),+$G(^DD(161,0,"VR"))=3,+$O(^FBAA(161.25,0)) D
 .D RTRAN^FBAAV0
 ;
 Q
 ;
MESS1 W !!,"Check your package file for the ",FBX," entry.  Unable to determine version."
 Q
 ;
MESS2 W !!,"Your version of the ",FBX," must be at least ",FBVNEW," to install this version of FEE.",*7
 Q
 ;
V ;;package namespace;version number
 ;;DGYA;5.0
 ;;DG;5.3
 ;;XU;7.1
 ;;XT;7.2
 ;;IB;2.0
 ;;END
 ;
DELPKG(X) ;pass in x equal to the namespace you want deleted from
 ;the package file (9.4). Called to clean-up prior version init
 ;patches, namespace changes, etc.
 Q:'$L(X)
 N DIC,DIK,D,DA,Y
 S DIC="^DIC(9.4,",DIC(0)="",D="C" D IX^DIC Q:'+Y
 S DA=+Y,DIK=DIC
 D ^DIK
 Q
OLDPKG ;entries to be deleted from the package file.
 ;;FBBA
