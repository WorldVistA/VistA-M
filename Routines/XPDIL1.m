XPDIL1 ;SFISC/RSD - cont. of load Distribution Global ;05/05/2008
 ;;8.0;KERNEL;**15,17,39,41,44,66,68,76,85,100,108,229,525**;Jul 10, 1995;Build 10
 ; Per VHA Directive 2004-038, this routine should not be modified.
 ;
PKG(XPDA) ;check Package file
 N XPD,XPDCP,XPDNM,XPDNOQUE,XPDPKG,X,Y,%
 S XPDNM=$P(XPDT(XPDIT),U,2) W !?3,XPDNM
 ;check KIDS version against sites version, skip if package is Kernel
 I $$PKG^XPDUTL(XPDNM)'["KERNEL" D  I $D(XPDQUIT) D ABORT^XPDI(XPDA,1) Q
 .;this is part of a Kernel multi package
 .Q:$O(XPDT("NM","KERNEL"))["KERNEL"
 .S Y=$G(^XTMP("XPDI",XPDA,"VER"))
 .I $$VERSION^XPDUTL("XU")<Y W !!,"But I need Version ",+Y," of KERNEL!"  S XPDQUIT=1
 .I $$VERSION^XPDUTL("VA FILEMAN")<$P(Y,U,2) W !,"But I Need Version ",+$P(Y,U,2)," of VA FILEMAN!" S XPDQUIT=1
 ;get national package name
 S %=$O(^XTMP("XPDI",XPDA,"PKG",0)),XPDPKG(0)=$G(^(+%,0)),XPDPKG=%
 ;XPDPKG=new ien^old ien
 I XPDPKG D  S XPDPKG=+Y_U_XPDPKG
 .N D,DIC
 .S DIC="^DIC(9.4,",DIC(0)="X",X=$P(XPDPKG(0),U)
 .D ^DIC Q:Y>0
 .;if lookup fails try C & C2 x-ref
 .S X=$P(XPDPKG(0),U,2),DIC(0)="MX",D="C^C2" D MIX^DIC1
 ;add package to Install file
 I XPDPKG>0 S XPD(9.7,XPDA_",",1)=+XPDPKG D FILE^DIE("","XPD")
 ;XPDSKPE= does site want to run Environ. Check
 I '$G(XPDSKPE) Q:$$ENV(0)=1
 ;global package can't have pre or post inits
 Q:$D(XPDGP)
 ;create pre-init checkpoint
 S XPDCP="INI" I '$$NEWCP^XPDUTL("XPD PREINSTALL COMPLETED") D ABORT^XPDI(XPDA,1) Q
 S %=$$INRTN("INI")
 ;check for routine, use as call back
 I $L(%),'$$NEWCP^XPDUTL("XPD PREINSTALL STARTED",%) D ABORT^XPDI(XPDA,1) Q
 ;create post-init checkpoint
 S XPDCP="INIT" I '$$NEWCP^XPDUTL("XPD POSTINSTALL COMPLETED") D ABORT^XPDI(XPDA,1) Q
 S %=$$INRTN("INIT")
 I $L(%),'$$NEWCP^XPDUTL("XPD POSTINSTALL STARTED",%) D ABORT^XPDI(XPDA,1) Q
 ;create fileman and components check points and file rest of data
 D XPCK^XPDIK("FIA"),XPCK^XPDIK("KRN")
 Q
INST(XPDNM) ;add to Install file
 N %X,DIC,DIR,DIRUT,DLAYGO,X,XPD,XPDA,XPDIE,XPDDIQ,Y,SH
 ;check if Build was already installed
 ;XPD=0 abort install, else XPD=ien in Install file
 I $D(^XPD(9.7,"B",XPDNM)) S (SH,Y)=0 D  Q:$D(XPD) XPD
 . W !,"Build ",XPDNM," has been loaded before, here is when: "
 . F  S Y=$O(^XPD(9.7,"B",XPDNM,Y)) Q:'Y  D
 .. Q:'$D(^XPD(9.7,Y,0))  S %=^(0)
 .. W !?6,$P(%,U),"   "
 .. I $P(%,U,9)<3,$D(^XTMP("XPDI",Y)) W "**Transport Global already exists**",*7 S XPD=0 Q
 .. S %X=$X W $$EXTERNAL^DILFD(9.7,.02,"",$P(%,U,9)),!?%X,"was loaded on ",$$FMTE^XLFDT($P($G(^XPD(9.7,Y,1)),U))
 . ;quit if transport global exist
 . Q:$D(XPD)
 . S DIR(0)="Y",DIR("A")="OK to continue with Load",DIR("B")="NO"
 . D ^DIR W ! I $D(DIRUT)!'Y S XPD=0 Q
 S DIC="^XPD(9.7,",DIC(0)="XL",DLAYGO=9.7,X=""""_XPDNM_""""
 ;add to Install file, must be new
 D ^DIC
 I Y<0 S SH=0 W !,"Can't add Build ",XPDNM," to Install File" Q 0
 ;set starting package to Y, if it is not already defined
 S:'XPDST XPDST=+Y
 ;XPDT array keeps track of all packages in this distribution
 S XPDA=+Y,XPDT(XPDIT)=XPDA_U_XPDNM,(XPDT("DA",XPDA),XPDT("NM",XPDNM))=XPDIT
 S %="XPDIE(9.7,"""_XPDA_","")",@%@(.02)=0,@%@(2)=$$NOW^XLFDT,@%@(3)=XPDST,@%@(4)=XPDIT,@%@(5)="",@%@(6)=XPDST("H1")
 D FILE^DIE("","XPDIE")
 I '$D(SH) W !?3,XPDNM ;SH is set when some other part of INST shows the name
 Q XPDA
 ;
 ;XPDQUIT quit current package install, 1=kill global, 2=leave global
 ;XPDQUIT(package) quit package install, 1=kill, 2=leave
 ;XPDABORT quit the entire distribution, 1=kill, 2=leave
 ;XPDENV 0=loading distribution, 1=installing
ENV(XPDENV) ;environment check & version check
 ;returns 0=ok, 1=rejected kill global, 2=rejected leave global
 N %,DIR,XPDI,XPDQUIT,XPDABORT,XPDDONE,XPDGREF,XPDMBREQ
 M X=DUZ N DUZ M DUZ=X S DUZ(0)="@" ;See that ENV check has full FM priv.
 S XPDGREF="^XTMP(""XPDI"","_XPDA_",""TEMP"")"
 S XPDMBREQ=$G(^XTMP("XPDI",XPDA,"MBREQ"))
 S $P(^XPD(9.7,XPDA,0),U,7)=XPDMBREQ
 ;check version number
 I XPDPKG>0 D  I $G(XPDQUIT) D ABORT^XPDI(XPDA,1) Q 1
 .N DIR,DIRUT,X,Y
 .S %=+$$VER^XPDUTL(XPDNM),Y=+$G(^DIC(9.4,+XPDPKG,"VERSION")),X=XPDNM["*"
 .;if patch, version must be the same
 .I X,%'=Y W !,"This Patch is for Version ",%,", you are running Version ",Y,! S XPDQUIT=1
 .;if package, version must be greater or equal
 .I 'X,%<Y W !,"You have a Version greater than mine!",! S XPDQUIT=1
 .Q:'$G(XPDQUIT)
 .I $G(XPDMBREQ) D  S XPDQUIT=0,XPDDONE=1 Q
 . . D MES^XPDUTL("**ABORT** Required Build "_XPDNM_", did not pass internal KIDS checks!"),ABRTALL^XPDI(1),NONE^XPDI
 . . Q
 .S DIR(0)="Y",DIR("A")="Want to continue installing this build",DIR("B")="NO"
 .D ^DIR I Y K XPDQUIT
 .Q
 Q:$G(XPDDONE) 1
 S %=$$REQB I % S (XPDABORT,XPDREQAB)=% G ABORT
 S %=$G(^XTMP("XPDI",XPDA,"PRE")) D:%]""
 .W !,"Will first run the Environment Check Routine, ",%,!
 .D SAVE^XPDIJ(%),@("^"_%)
ABORT I $G(XPDABORT) D  Q XPDABORT
 .;if during load & leave global quit
 .I 'XPDENV,XPDABORT=2 Q
 .D ABRTALL^XPDI(XPDABORT)
 Q:'$D(XPDQUIT) 0
 I $G(XPDQUIT) D ABORT^XPDI(XPDA,XPDQUIT)
 S XPDI=""
 ;don't do if loading & leave global, need to keep XPDT(array)
 F  S XPDI=$O(XPDQUIT(XPDI)) Q:XPDI=""  D:'(XPDQUIT(XPDI)=2&'XPDENV)
 .S %=$G(XPDT("NM",XPDI)) D:% ABORT^XPDI(+XPDT(%),XPDQUIT(XPDI))
 S XPDQUIT=$S($G(XPDQUIT):XPDQUIT,'$O(XPDT(0))!'$D(^XTMP("XPDI",XPDA)):1,1:0)
 Q XPDQUIT
 ;
REQB() ;check for Required Builds
 ;returns 0=ok, 1=failed kill global, 2=failed leave global
 N XPDACT,XPDBLD,XPDI,XPDQ,XPDQUIT,XPDX,XPDX0,X,Y
 S XPDBLD=$O(^XTMP("XPDI",XPDA,"BLD",0)),XPDQUIT=0,XPDI=0
 Q:'$D(^XTMP("XPDI",XPDA,"BLD",XPDBLD,"REQB")) 0
 F  S XPDI=$O(^XTMP("XPDI",XPDA,"BLD",XPDBLD,"REQB",XPDI)) Q:'XPDI  S XPDX0=^(XPDI,0) D
 .S XPDQ=0,XPDX=$P(XPDX0,U),XPDACT=$P(XPDX0,U,2),X=$$PKG^XPDUTL(XPDX),Y=$$VER^XPDUTL(XPDX),Z=$$VERSION^XPDUTL(X)
 .;quit if current version is greater than what we are checking for
 .Q:Z>Y
 .I XPDX'["*" S:Z<Y XPDQ=2
 .E  S:'$$PATCH^XPDUTL(XPDX) XPDQ=1
 .;quit if patch is already on system
 .Q:'XPDQ
 .;quit if patch is sequenced prior within this build 
 .I $D(XPDT("NM",XPDX)),(XPDT("NM",XPDX)<XPDT("NM",XPDNM)) S XPDQ=0 Q
 .S XPDQUIT=$S(XPDACT>XPDQUIT:XPDACT,1:XPDQUIT)
 .;XPDACT=0 warning, =1 abort & kill global, =2 abort
 .W !!,$S(XPDACT:"**INSTALL ABORTED**",1:"**WARNING**")_$S(XPDQ=1:" Patch ",1:" Package ")_XPDX_" is Required "_$S(XPDACT:"to install",1:"for")_" this package!!",!
 Q:'XPDQUIT 0
 ;don't do if leave global and loading
 D:'(XPDQUIT=2&'XPDENV) ABORT^XPDI(XPDA,XPDQUIT)
 Q XPDQUIT
 ;
 ;return a routine that can be run
INRTN(X) N Y
 S Y=$G(^XTMP("XPDI",XPDA,X)) Q:Y="" ""
 S Y=$S(Y["^":Y,1:"^"_Y)
 Q Y
