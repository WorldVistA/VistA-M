XPDDP ;SFISC/RSD - Display a package ;03/18/2008
 ;;8.0;KERNEL;**21,28,44,68,100,108,229,304,346,463,488,525**;Jul 10, 1995;Build 10
 ; Per VHA Directive 2004-038, this routine should not be modified.
 ; Options: XPD PRINT BUILD calls EN1
 ;          XPD PRINT INSTALL calls EN2
EN1 ; Print from Build file
 N DIC,D0,XPD,XPDT,XPDST,Y
 S XPDST=$$LOOK^XPDB1 Q:XPDST'>0
 S XPD("XPDT(")=""
 D EN^XUTMDEVQ("LST1^XPDDP","Build File Print",.XPD)
 Q
 ;
EN2 ; Print from Distribution
 N D0,DIC,DIR,DUOUT,DTOUT,POP,XPD,XPDA,XPDNM,XPDP,XPDT,XPDST,Y,Z,%ZIS
 S XPDST=$$LOOK^XPDI1("I $D(^XTMP(""XPDI"",Y))",1) Q:XPDST'>0
 S DIR(0)="SO^1:Print Summary;2:Print Summary and Routines;3:Print Routines",DIR("A")="What to Print"
 D ^DIR Q:Y=""!$D(DTOUT)!$D(DUOUT)
 S XPDP=Y,D0=$O(^XTMP("XPDI",XPDST,"BLD",0)) Q:'D0
 S (XPD("XPDT("),XPD("XPDP"))=""
 D EN^XUTMDEVQ("LST2^XPDDP","Transport Global Print",.XPD)
 Q
 ;
LST1 ; Print from Build file
 N DIRUT,XPDIT,XPDCNT
 S (XPDIT,XPDCNT)=0
 F  S XPDIT=$O(XPDT(XPDIT)) Q:$D(DIRUT)!(XPDIT'>0)  D  Q:$D(DIRUT)
 . I XPDCNT Q:'$$CONT
 . S XPDCNT=XPDCNT+1
 . S D0=+XPDT(XPDIT) D PNT^XPDDP1("XPD(9.6,D0)")
 D WAIT
 Q
 ;
LST2 ; Print from XPDT array
 N DIRUT,XPDIT,XPDCNT
 S (XPDIT,XPDCNT)=0
 F  S XPDIT=$O(XPDT(XPDIT)) Q:$D(DIRUT)!(XPDIT'>0)  D  Q:$D(DIRUT)
 . I XPDCNT Q:'$$CONT
 . S XPDCNT=XPDCNT+1,XPDA=+XPDT(XPDIT),D0=$O(^XTMP("XPDI",XPDA,"BLD",0))
 . D PNT^XPDDP1("XTMP(""XPDI"",XPDA,""BLD"",D0)"):XPDP<3,RTN:XPDP>1
 D WAIT
 Q
 ;
XMP2(X,D0) ;called from ^XMP2
 N XPDA S XPDA=-1
 D PNT^XPDDP1(X)
 Q
 ;
WAIT ; Pause on last page or not? It depends on whether there's enough room
 ; left on the page to display the KIDS menu.
 Q:$E($G(IOST),1,2)'="C-"
 Q:$D(DIRUT)
 ; DUZ("AUTO")=1 means show menu option choices
 I IOSL-$Y<$S($G(DUZ("AUTO")):14,1:3) D WAIT^XMXUTIL
 Q
 ;
CONT() ; Press Return to continue; ^ to exit.
 Q:$D(DIRUT) 0
 Q:$E(IOST,1,2)'="C-" 1
 N DIR,I,J,K,X,Y
 S DIR(0)="E" D ^DIR
 Q Y
 ;
CHK(Y) ;Y=excess lines, return 1 to exit
 ;return 0 to continue
 Q:$Y<(IOSL-Y) 0
 Q:'$$CONT 1
 W @IOF
 Q 0
 ;
RTN ;Print Routines
 Q:$D(DIRUT)!$$CHK(2)
 N XPD0,XPDI,XPDRTN
 S XPD0=$G(^XTMP("XPDI",XPDA,"BLD",D0,0)) Q:XPD0=""
 I XPDP=3 N XPDDT,XPDPG,XPDUL D
 . S XPDDT=$$HTE^XLFDT($H,"1PM"),XPDPG=1,$P(XPDUL,"-",IOM)=""
 . D HDR^XPDDP1
 . W !,XPDUL
 S XPDRTN=""
 F  S XPDRTN=$O(^XTMP("XPDI",XPDA,"RTN",XPDRTN)) Q:XPDRTN=""  D  Q:$D(DIRUT)
 . W !,XPDRTN S XPDI=0
 . F  S XPDI=$O(^XTMP("XPDI",XPDA,"RTN",XPDRTN,XPDI)) Q:'XPDI  W !,$G(^(XPDI,0)) Q:$$CHK(2)
 . W ! Q:'$$CHK(2)
 W !! S DIRUT=1
 Q
