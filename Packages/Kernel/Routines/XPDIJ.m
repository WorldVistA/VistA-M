XPDIJ ;SFISC/RSD - Install Job ;08/14/2008
 ;;8.0;KERNEL;**2,21,28,41,44,68,81,95,108,124,229,275,506**;Jul 10, 1995;Build 11
 ;Per VHA Directive  2004-038, this routine should not be modified.
EN ;install all packages
 ;XPDA=ien of first package
 ;this is needed to restore XPDIJ1
 D LNRF("XPDUTL") ;p275 SAVE calls RTNLOG^XPDUTL
 D LNRF("XPDIJ1") ;See that XPDIJ1 is loaded befor it is called
 N IEN,XPDI,XPD0,XPDSET,XPDABORT,XPDMENU,XPDQUIT,XPDVOL,X,Y,ZTRTN,ZTDTH,ZTIO,ZTDESC,ZTSK
 M X=DUZ N DUZ M DUZ=X S DUZ(0)="@" ;See that install has full FM priv.
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^XPDIJ"
 E  S X="ERR^XPDIJ",@^%ZOSF("TRAP")
 Q:'$D(^XPD(9.7,+$G(XPDA),0))  S XPD0=^(0)
 D INIT^XPDID
 ;See if need to Inhibit Logons
 I $$ANSWER^XPDIQ("XPI1") D INHIBIT^XPDIJ1("Y")
 ;disable options & protocols for setname, XPDSET=1/0^setname^out of order msg.
 S Y=$P(XPD0,U,8),XPDSET=+Y_U_$E(Y,2,99)_U_$S($L(Y):$P($G(^XTMP("XQOO",$E(Y,2,99),0)),U),1:"")
 ;hang the number of seconds given in 0;10
 I XPDSET D OFF^XQOO1($P(XPDSET,U,2)) I $P(XPD0,U,10) H ($P(XPD0,U,10)*60)
 S Y=0
 ;XPDABORT can be set in pre or post install to abort install
 F  S Y=$O(^XPD(9.7,"ASP",XPDA,Y)) Q:'Y  S %=$O(^(Y,0)) D:%  Q:$D(XPDABORT)
 .N XPD,XPDA,XPDNM,XPDV,XPDV0,XPDVOL,XPDX,XPDY,Y
 .;Now do the Install
 .S XPDA=%,XPDNM=$P($G(^XPD(9.7,XPDA,0)),U) D IN^XPDIJ1 Q:$D(XPDABORT)
 ;
 ;Now do Master Build Post INIT.
 I '$D(XPDABORT),$D(XPDT("MASTER")) D
 .N XPDBLD,XPDGREF
 .S XPDBLD=$O(^XTMP("XPDI",XPDA,"BLD",0)),XPDGREF="^XTMP(""XPDI"","_XPDA_",""TEMP"")"
 .D POST^XPDIJ1
 ;ZTREQ tells taskman to delete task
 I $G(ZTSK) S ZTREQ="@" D
 .;remove task # from Install File
 .N XPD S XPD(9.7,XPDA_",",5)="@"
 .D FILE^DIE("","XPD")
 ;quit if install was aborted
 I $D(XPDABORT) D EXIT^XPDID("Install Aborted!!"),^%ZISC Q
 ;put option back in order
 I $P(XPDSET,U,2)]"" D ON^XQOO1($P(XPDSET,U,2)) K ^XTMP("XQOO",$P(XPDSET,U,2))
 ;check if menu rebuild is wanted (only if option has been added to any installs)
 ;XPDMENU is used to check that it is only done once
 S (Y,XPDMENU)=0
 F  S Y=$O(^XPD(9.7,"ASP",XPDA,Y)) Q:'Y  S %=$O(^(Y,0)) D:%  Q:XPDMENU
 .N XPDA,Y
 .S XPDA=%
 .I $$ANSWER^XPDIQ("XPO1") D BMES^XPDUTL(" Call MENU rebuild"),KIDS^XQ81 S XPDMENU=1
 .;There should be no reason to check other CPUs anymore, patch 496
 .Q
 .;check if need to queue menu rebuild on other CPUs
 .D:$O(^XPD(9.7,XPDA,"VOL",0))
 ..N XPDU,XPDY,XPDV,XPDV0,ZTUCI,ZTCPU
 ..X ^%ZOSF("UCI") S XPDU=$P(Y,","),XPDY=$P(Y,",",2),XPDV=0
 ..;loop thru VOLUMES SET and don't do current volume set
 ..F  S XPDV=$O(^XPD(9.7,XPDA,"VOL",XPDV)) Q:'XPDV  S XPDV0=$P(^(XPDV,0),U) D:XPDV0'=XPDY
 ...S ZTUCI=XPDU,ZTDTH=$H,ZTIO="",ZTDESC="Install Menu Rebuild",ZTCPU=XPDV0,ZTRTN="KIDS^XQ81" D ^%ZTLOAD
 ;
 ;See if need to reset inhibit logons
 I $$ANSWER^XPDIQ("XPI1") D INHIBIT^XPDIJ1("N")
 ;
 ;clean up globals
 S Y=0
 F  S Y=$O(^XPD(9.7,"ASP",XPDA,Y)) Q:'Y  S XPDI=$O(^(Y,0)) D:XPDI
 . N %,Y,XPD,X
 . ;See if need to delete Env,Pre,Post routines.
 . S %=$O(^XTMP("XPDI",XPDI,"BLD",0)),XPD=$G(^XTMP("XPDI",XPDI,"BLD",%,"INID"))
 . I '$$GET^XUPARAM("XPD NO_EPP_DELETE") F %=1:1:3 I $P(XPD,U,%)="y" D
 . . S X=^XTMP("XPDI",XPDI,$P("PRE^INIT^INI",U,%)) S:X[U X=$P(X,U,2) X:X]"" ^%ZOSF("DEL")
 . ;kill transport global
 . K ^XTMP("XPDI",XPDI)
 . ;update the status field
 . S XPD(9.7,XPDI_",",.02)=3
 . D FILE^DIE("","XPD")
 D EXIT^XPDID("Install Completed"),^%ZISC
 Q
 ;
SAVE(X) ;restore routine X
 N %,DIE,XCM,XCN,XCS
 S DIE="^XTMP(""XPDI"",XPDA,""RTN"",X,",XCN=0
 X ^%ZOSF("SAVE") D RTNLOG^XPDUTL(X)
 Q
RTN(XPDA) ;restore all routines for package XPDA
 ;^XPD("XPDI",XPDA,"RTN",routine name)=0-install, 1-delete, 2-skip^checksum
 Q:$G(XPDA)=""
 N X,XPDI,XPDJ S XPDI=""
 F  S XPDI=$O(^XTMP("XPDI",XPDA,"RTN",XPDI)) Q:XPDI=""  S XPDJ=^(XPDI) D
 .;if we are doing VT graphic display, set counter
 .I $D(XPDIDVT) S XPDIDCNT=XPDIDCNT+1 D:'(XPDIDCNT#XPDIDMOD) UPDATE^XPDID(XPDIDCNT)
 .I 'XPDJ D SAVE(XPDI) Q
 .;set checksum to null, since routine wasn't loaded
 .I $P(XPDJ,U,2) S $P(^XTMP("XPDI",XPDA,"BLD",XPDBLD,"KRN",9.8,"NM",$P(XPDJ,U,2),0),U,4)=""
 .I $P(XPDJ,U)=1 S X=XPDI X ^%ZOSF("DEL")
 ;if graphic display, update full count
 I $D(XPDIDVT) D UPDATE^XPDID(XPDIDCNT)
 Q
 ;
VOLERR(V,F) ;volume set not updated,V=volume set, F=flag
 N XQA,XQAMSG,XPDMES
 S XPDMES(1)=" ",XPDMES(2)=" ** Job on VOLUME SET "_V_$S(F:" never started **",1:" has been idle for an hour.")
 S XPDMES(3)=" ** "_V_" has NOT been updated! **"
 S XQA(DUZ)="",XQAMSG="VOLUME SET "_V_" NOT updated for Install "_$E($P($G(^XPD(9.7,+$G(XPDA),0)),"^"),1,30)
 D MES^XPDUTL(.XPDMES),SETUP^XQALERT
 Q
 ;come here on error, record error in Install file and cleanup var.
ERR N XPDERROR,XQA,XQAMSG
 S XPDERROR=$$EC^%ZOSV
 ;record error, write message, reset terminal
 D ^%ZTER,BMES^XPDUTL(XPDERROR),EXIT^XPDID()
 S XQA(DUZ)="",XQAMSG="Install "_$E($P($G(^XPD(9.7,+$G(XPDA),0)),"^"),1,30)_" has encountered an Error."
 D SETUP^XQALERT G UNWIND^%ZTER
 ;
LNRF(RN) ;Load needed routines first
 I $D(^XTMP("XPDI",XPDA,"RTN",RN)) D
 .N X
 .D SAVE(RN)
 .S XCN=$$RTNUP^XPDUTL(RN,2)
 Q
