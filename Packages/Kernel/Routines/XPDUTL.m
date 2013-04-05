XPDUTL ;SFISC/RSD - KIDS utilities ;10/15/2008
 ;;8.0;KERNEL;**21,28,39,81,100,108,137,181,275,491,511,559**;Jul 10, 1995;Build 4
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
VERSION(X) ;Get current version from Package file, X=package name or
 ;package namespace
 N I
 S I=$$LKPKG(X) Q:'I ""
 Q $P($G(^DIC(9.4,+I,"VERSION")),"^")
 ;
VER(X) ;returns version number from Build file, X=build name
 Q:X["*" $P(X,"*",2)
 Q $P(X," ",$L(X," "))
 ;
STATUS(IEN) ;returns status from Install File, IEN=Install File IEN
 I '$D(^XPD(9.7,IEN,0)) Q -1
 Q $P(^XPD(9.7,IEN,0),U,9)
 ;
PKG(X) ;returns package name from Build file, X=build name
 Q $S(X["*":$P(X,"*"),1:$P(X," ",1,$L(X," ")-1))
 ;
LAST(PKG,VER,REL) ;returns last patch applied for a Package, PATCH^DATE
 ;PKG=package name, VER=version number, REL[optional]=1 if you want released patches only
 ;Patch includes Seq # if Released
 N PKGIEN,VERIEN,LATEST,PATCH,SUBIEN,Y
 S PKGIEN=$$LKPKG($G(PKG)) Q:'PKGIEN -1
 I $G(VER)="" S VER=$P($G(^DIC(9.4,PKGIEN,"VERSION")),"^") Q:'VER -1
 S VERIEN=$O(^DIC(9.4,PKGIEN,22,"B",VER,"")) Q:'VERIEN -1
 S LATEST=-1,PATCH=-1,SUBIEN=0
 F  S SUBIEN=$O(^DIC(9.4,PKGIEN,22,VERIEN,"PAH",SUBIEN)) Q:SUBIEN'>0  S Y=$G(^(SUBIEN,0)) D:$P(Y,U,2)>LATEST
 . I $G(REL),$P(Y,U)'["SEQ #" Q  ;released only, must contain SEQ
 . S LATEST=$P(Y,U,2),PATCH=$P(Y,U)
 Q PATCH_U_LATEST
 ;
PATCH(X) ;return 1 if patch X was installed, X=aaaa*nn.nn*nnn
 Q:X'?1.4UN1"*"1.2N1"."1.2N.1(1"V",1"T").2N1"*"1.3N 0
 N %,I,J
 S I=$$LKPKG($P(X,"*")) Q:'I 0
 S J=$O(^DIC(9.4,I,22,"B",$P(X,"*",2),0)),X=$P(X,"*",3) Q:'J 0
 ;check if patch is just a number
 Q:$O(^DIC(9.4,I,22,J,"PAH","B",X,0)) 1
 S %=$O(^DIC(9.4,I,22,J,"PAH","B",X_" SEQ"))
 Q (X=+%)
 ;
INSTALDT(INSTALL,RESULT) ;returns number of installs, 0 if not installed or doesn't exist
 ;input: INSTALL=required, Install name; RESULT=required, passed by reference
 ;output: RESULT=number in RESULT array; RESULT(FM date/time)=TEST# ^ SEQ#
 N CNT,DATE,IEN
 K RESULT
 S (IEN,CNT,RESULT)=0
 I $G(INSTALL)="" Q 0
 F  S IEN=$O(^XPD(9.7,"B",INSTALL,IEN)) Q:'IEN  D
 .S DATE=$P($G(^XPD(9.7,IEN,1)),U,3) Q:'DATE
 .S RESULT(DATE)=$G(^XPD(9.7,IEN,6)),CNT=CNT+1
 S RESULT=CNT
 Q CNT
 ;
NEWCP(XPD,XPDC,XPDP) ;create new check point, returns 0=error or ien
 ;XPD=name, XPDC=call back, XPDP=parameters
 Q:$G(XPD)="" 0
 N %,XPDI,XPDJ,XPDF,XPDY
 ;XPDCP="INI"=Pre-init, "INIT"=Post-init
 S XPDI=$S(XPDCP="INIT":9.716,1:9.713)
 S %=$$FIND1^DIC(XPDI,","_XPDA_",","X",XPD) Q:% %
 S XPDF="+1,"_XPDA_",",XPDJ(XPDI,XPDF,.01)=XPD
 S:$D(XPDC) XPDJ(XPDI,XPDF,2)=XPDC
 S:$D(XPDP) XPDJ(XPDI,XPDF,3)=XPDP
 D UPDATE^DIE("","XPDJ","XPDY")
 Q $G(XPDY(1))
 ;
UPCP(XPD,XPDP) ;update check point, returns 0=error or ien
 ;XPD=name, XPDP=parameters
 N XPDI,XPDJ,XPDF,XPDY
 ;XPDCP="INI"=Pre-init, "INIT"=Post-init
 S XPDI=$S(XPDCP="INIT":9.716,1:9.713),XPDY=$$DICCP($G(XPD))
 Q:'XPDY 0
 S XPDF=XPDY_","_XPDA_","
 S:$D(XPDP) XPDJ(XPDI,XPDF,3)=XPDP
 D FILE^DIE("","XPDJ")
 Q XPDY
 ;
COMCP(XPD) ;complete check point, returns 0=error or date/time
 ;XPD=name
 N XPDD,XPDI,XPDJ,XPDY
 S XPDI=$S(XPDCP="INIT":9.716,1:9.713),XPDY=$$DICCP($G(XPD))
 Q:'XPDY 0
 S XPDD=$$NOW^XLFDT,XPDJ(XPDI,XPDY_","_XPDA_",",1)=XPDD
 D FILE^DIE("","XPDJ")
 Q XPDD
 ;
VERCP(XPD) ;verify check point, returns 1=completed, 0=not
 ;-1=doesn't exist
 ;XPD=name
 N XPDI,XPDY
 S XPDI=$S(XPDCP="INIT":9.716,1:9.713),XPDY=$$DICCP($G(XPD))
 Q:'XPDY -1
 Q ''$$GET1^DIQ(XPDI,XPDY_","_XPDA_",",1,"I")
 ;
PARCP(XPD,XPDF) ;returns parameters of check point
 ;XPD=name, XPDF="PRE"
 N XPDI,XPDY
 I $G(XPDF)="PRE" N XPDCP S XPDCP="INI"
 S XPDI=$S(XPDCP="INIT":9.716,1:9.713),XPDY=$$DICCP($G(XPD))
 Q:'XPDY 0
 Q $$GET1^DIQ(XPDI,XPDY_","_XPDA_",",3,"I")
 ;
CURCP(XPDF) ;returns current check point
 ;XPDF flag - 0=externel, 1=internal
 Q $S($G(XPDF):XPDCHECK,1:XPDCHECK(0))
 ;
WP(X) ;X=global ref
 N %
 Q:'$D(@X)
 F %=1:1 Q:'$D(@X@(%))  W !,@X@(%)
 Q:'$G(XPDA)  D WP^DIE(9.7,XPDA_",",20,"A",X)
 Q
MES(X) ;record message, X=message or an array passed by reference
 N %
 I $D(X)#2 S %=X K X S X(1)=%
 ;write message
 F %=1:1 Q:'$D(X(%))  W !,X(%)
 Q:'$G(XPDA)  D WP^DIE(9.7,XPDA_",",20,"A","X")
 Q
BMES(X) ;add blank line before message
 N %
 I $D(X)#2 S %=X K X S X(1)=" ",X(2)=%
 D MES(.X)
 Q
RTNUP(X,Y) ;update routine action, X=routine, Y=action
 ;actions:  1=delete, 2=skip
 N %
 ;set action to Y
 Q:'$G(Y)!'$D(^XTMP("XPDI",$G(XPDA),"RTN",X)) 0 S $P(^(X),U)=+Y
 Q 1
 ;get Build ien
 S Y=$O(^XTMP("XPDI",XPDA,"BLD",0))
 ;remove checksum when updating action, since action can only be
 ;delete or skip, not sure if we want to do this
 S:$P(%,U,2) $P(^XTMP("XPDI",XPDA,"BLD",Y,"KRN",9.8,"NM",$P(%,U,2),0),U,4)=""
 Q 1
 ;
RTNLOG(X) ;Enter/Update routine in the Routine File
 N Y,FDA,IEN
 S Y=$O(^DIC(9.8,"B",X,0))
 I Y'>0 S IEN="?+1,",FDA(9.8,IEN,1)="R"
 I Y>0 S IEN=(+Y)_","
 S FDA(9.8,IEN,.01)=X,FDA(9.8,IEN,7.4)=$$NOW^XLFDT
 D UPDATE^DIE("","FDA","IEN")
 Q
 ;
DICCP(X) ;lookup check point, returns ien or 0
 Q:$G(X)="" 0
 ;if they pass ien, fail if can't find
 I X=+X S Y=X Q:'$D(^XPD(9.7,XPDA,XPDCP,Y,0)) 0
 E  S Y=$$FIND1^DIC(XPDI,","_XPDA_",","X",X)
 Q Y
 ;
PRODE(XPDN,XPD) ;enable/disable protocols, return 1 for success
 ;XPDN=protocol name, XPD=1-enable, 0-disable
 Q:$G(XPDN)="" 0
 S XPD=+$G(XPD)
 D KIDS^XQOO1($P(XPDSET,U,2),101,XPDN,.XPD)
 Q $S(XPD<0:0,1:1)
 ;
OPTDE(XPDN,XPD) ;enable/disable options, return 1 for success
 ;XPDN=protocol name, XPD=1-enable, 0-disable
 Q:$G(XPDN)="" 0
 S XPD=+$G(XPD)
 D KIDS^XQOO1($P(XPDSET,U,2),19,XPDN,.XPD)
 Q $S(XPD<0:0,1:1)
 ;
BUILD(XPDN,XPD) ;check if a build exists, return 1 for success
 ;XPDN=build name, XPD=1-exist, 0-been removed
 S XPD=$D(XPDT("NM",XPDN))
 Q XPD
 ;
MAILGRP(X) ;Return mail group for package, X=package name or namespace
 N XD,DIC,DR,DA,DIQ
 S DA=$$LKPKG(X) Q:'DA ""
 S DIC="^DIC(9.4,",DR=1938,DIQ="XD" D EN^DIQ1
 Q $S($G(XD(9.4,DA,1938))="":"",1:"G."_XD(9.4,DA,1938))
 ;
LKPKG(X) ;Return Package ien,  X=package name or namespace
 Q:$G(X)="" 0
 N DA
 I $L(X)<5 D  Q:DA +DA
 .S DA=$O(^DIC(9.4,"C",X,0))
 .S:'DA DA=$O(^DIC(9.4,"C2",X,0))
 I $L(X)>3 S DA=$O(^DIC(9.4,"B",X,0))
 Q +DA
