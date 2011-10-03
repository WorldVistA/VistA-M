XMVGRP ;ISC-SF/GMB-Group creation/enrollment ;03/07/2002  07:01
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; ENLOCAL    XMxxxxx - Add local users to mail groups
ENLOCAL1(XMXQUSER) ; Add local user(s) to group(s) - called from Kernel
 ; XMXQUSER - first user being added (duz or name)
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 D INITAPI^XMVVITAE
ENLOCAL ; Add local user(s) to mail group(s).
 N XMGRP,XMMBR,XMINSTR,XMTSK,XMTO,XMABORT
 S XMABORT=0
 D ENGRP(.XMGRP,.XMABORT) Q:XMABORT!'$D(XMGRP)  ; select groups
 D ENUSER(.XMMBR,.XMABORT,.XMXQUSER) Q:XMABORT  ; select users
 D ENCONF(.XMGRP,.XMMBR,.XMABORT) Q:XMABORT     ; confirm it
 D ADD2GRPZ^XMXGRP(.XMGRP,.XMMBR,.XMTO)         ; add users to groups
 W !!,$$EZBLD^DIALOG(38233) ; Users have been added to the mail groups
 D ENFWD(XMDUZ,.XMINSTR,.XMABORT) Q:XMABORT     ; forward msgs?
 D FAFMSGS^XMXGRP1(XMDUZ,.XMGRP,.XMTO,.XMINSTR,.XMTSK) ; yup.
 D FWDTSK^XMVGROUP(XMTSK) ; tell the user the task number.
 Q
ENGRP(XMGRP,XMABORT) ;
 N Y
 F  D  Q:Y=-1!XMABORT
 . N DIC,DIR,X,XMDEL
 . S DIR("A")=$$EZBLD^DIALOG($S($D(XMGRP):38211,1:38210)) ; Another mail group / Allocate mail group
 . S DIR("PRE")="I $E(X)=""-"" S XMDEL=1,X=$E(X,2,99)"
 . D BLD^DIALOG(38213,"","","DIR(""?"")")
 . ;Enter the name of the mail group you wish to allocate.
 . ;Precede any mail group name with '-' to remove it.
 . ;You'll only be able to select mail groups you're authorized to edit.
 . ;Enter ?? for a list of mail groups you've already selected,
 . ;and for mail group help.
 . S DIR("??")="^D HELPGRP^XMVGRP"
 . S DIR(0)="PO^3.8:FEMQ"
 . S DIC("S")=$$GRPSCR^XMVGROUP(1)
 . D ^DIR I $D(DTOUT)!$D(DUOUT) S XMABORT=1 Q
 . Q:Y=-1
 . I '$G(XMDEL) S XMGRP($P(Y,U,2))=+Y Q
 . I '$D(XMGRP($P(Y,U,2))) W $C(7),$$EZBLD^DIALOG(38214) Q  ; ?? Not on current list.
 . K XMGRP($P(Y,U,2))
 . W $$EZBLD^DIALOG(38215) ;   Deleted from current list.
 Q
HELPGRP ;
 I '$D(XMGRP) W !,$$EZBLD^DIALOG(38216) ; You haven't selected any mail groups yet.
 E  D SHOWGRP
 N DIR,X,Y,DIRUT,DTOUT,DIRUT
 S DIR("A")=$$EZBLD^DIALOG(38217) ; Want mail group help
 S DIR(0)="Y"
 S DIR("B")=$$EZBLD^DIALOG(39053) ; NO
 D ^DIR Q:'Y
 ;D HELP^XMHIG
 N DIC,X,Y,DLAYGO
 S DIC(0)="AEQM",DIC="^XMB(3.8,"
 S DIC("S")=$$GRPSCR^XMVGROUP(1)
 F  W ! D ^DIC Q:Y<0  D
 . D DISPLAY^XMHIG(+Y)
 Q
SHOWGRP ;
 N XMI,XMJ,XML,XMLN
 W !!,$$EZBLD^DIALOG(38218) ; You've selected the following mail groups:
 S XML=0,XMI="" F  S XMI=$O(XMGRP(XMI)) Q:XMI=""  I $L(XMI)>XML S XML=$L(XMI)
 S XML=XML+3,XMLN=80\XML
 S XMI=""
 F XMJ=0:1 S XMI=$O(XMGRP(XMI)) Q:XMI=""  D
 . W:'(XMJ#XMLN) ! W ?(XMJ#XMLN*XML),XMI
 Q
ENUSER(XMMBR,XMABORT,XMUSER) ;
 N XMX,XMDONE
 W !
 S XMDONE=0
 F  D  Q:XMDONE!XMABORT
 . N XMDEL
 . W !,$$EZBLD^DIALOG($S($D(XMMBR):38221,1:38220)) ; Another user: / Add user:
 . I $G(XMUSER)'="" D
 . . S XMX=XMUSER
 . . K XMUSER
 . . W XMX
 . E  D  Q:XMX=""
 . . R XMX:DTIME S:'$T XMX=U I XMX[U S XMABORT=1 Q
 . . I XMX="" D  Q
 . . . I $D(XMMBR) S XMDONE=1 Q
 . . . W $C(7)," ??",!,$$EZBLD^DIALOG(38222) ; You must select a user, or enter ^ to exit.
 . . I XMX?1."?" D HELPUSR(XMX) S:XMX'="?" XMX="" Q
 . . I $E(XMX)="-" S XMDEL=1,XMX=$E(XMX,2,99) W:XMX="" " ??",$C(7)
 . N DIC,D,X,Y,DLAYGO,XMNAME
 . S X=$$UP^XLFSTR(XMX)
 . S DIC("S")="I $L($P(^(0),U,3)),$D(^XMB(3.7,+Y,2))" ; User must have an access code & mailbox
 . S DIC("W")="I Y'=DUZ D USERINFO^XMXADDR1(Y)"
 . S DIC="^VA(200,"
 . S DIC(0)="FEMN"  ; 'N' means if user enters a DUZ, ask "OK?"
 . S D="B^BB^C^D" ; name^alias^initial^nickname
 . D MIX^DIC1 I $D(DTOUT)!$D(DUOUT) S XMABORT=1 Q
 . I Y<0 W " ??",$C(7) Q
 . S XMNAME=$$NAME^XMXUTIL(+Y) ; $P(Y,U,2)
 . I '$G(XMDEL) S XMMBR(XMNAME)=+Y Q
 . I '$D(XMMBR(XMNAME)) W !,$C(7),$$EZBLD^DIALOG(38214) Q  ; ?? Not on current list.
 . K XMMBR(XMNAME)
 . W !,$$EZBLD^DIALOG(38215) ;  Deleted from current list.
 Q
HELPUSR(XMX) ;
 I XMX="?" D  Q
 . N XMTEXT
 . D BLD^DIALOG(38223,"","","XMTEXT","F")
 . D MSG^DIALOG("WH","","","","XMTEXT")
 . ;Enter the name of the user you wish to add to the group(s).
 . ;Precede any user name with '-' to remove it.
 . ;You'll only be able to select users with mailboxes and access codes.
 . ;Enter ?? for a list of users you've already selected,
 . ;and for user help.
 I '$D(XMMBR) W !,$$EZBLD^DIALOG(38226) ;You haven't selected any users yet.
 E  D SHOWUSR
 N DIR,X,Y,DIRUT,DTOUT,DIRUT
 S DIR("A")=$$EZBLD^DIALOG(38224) ; Want user help
 S DIR(0)="Y"
 S DIR("B")=$$EZBLD^DIALOG(39053) ; NO
 D ^DIR Q:'Y
 D HELP^XMHIU
 Q
SHOWUSR ;
 N XMI,XMJ,XML,XMLN
 W !!,$$EZBLD^DIALOG(38225) ; You've selected the following users:
 S XML=0,XMI="" F  S XMI=$O(XMMBR(XMI)) Q:XMI=""  I $L(XMI)>XML S XML=$L(XMI)
 S XML=XML+3,XMLN=80\XML
 S XMI=""
 F XMJ=0:1 S XMI=$O(XMMBR(XMI)) Q:XMI=""  D
 . W:'(XMJ#XMLN) ! W ?(XMJ#XMLN*XML),XMI
 Q
ENCONF(XMGRP,XMMBR,XMABORT) ;
 D SHOWGRP
 D SHOWUSR
 W !
 N DIR,X,Y
 D BLD^DIALOG(38230,"","","DIR(""A"")") ; You are adding users to mail groups.  Do you wish to proceed
 S DIR(0)="Y"
 S DIR("B")=$$EZBLD^DIALOG(39054) ; yes
 D ^DIR I 'Y S XMABORT=1
 Q
ENFWD(XMDUZ,XMINSTR,XMABORT) ;
 W !
 N DIR,X,Y
 D BLD^DIALOG(38231,"","","DIR(""A"")")
 ;Do you wish to forward past mail group messages
 ;to the user(s) you just added to the mail group(s)
 D BLD^DIALOG(38232,"","","DIR(""?"")")
 ;Answer YES to forward past mail group messages.
 ;You will be asked for a time frame to search,
 ;and then MailMan will create a task to find and forward
 ;existing mail group messages.
 S DIR(0)="Y"
 S DIR("B")=$$EZBLD^DIALOG(39053) ; no
 D ^DIR I $D(DIRUT)!'Y S XMABORT=1 Q
 D FWDDATES(XMDUZ,.XMINSTR,.XMABORT) Q:XMABORT
 S XMINSTR("FLAGS")="F"
 Q
FWDDATES(XMDUZ,XMINSTR,XMABORT) ;
 ; Message sent on or before date
 N DIR,Y,X,XMOLDEST,XMTEXT
 ;S XMOLDEST=$O(^XMB(3.9,"C",""))
 F  S XMOLDEST=$O(^XMB(3.9,"C","")) Q:XMOLDEST?1N.N  K ^XMB(3.9,"C",XMOLDEST) ; kill bogus nodes
 ; You will now choose a date range for the messages to be searched
 ; and forwarded.  The oldest message is from XMOLDEST.
 W !
 D BLD^DIALOG(38023.5,$$FMTE^XLFDT(XMOLDEST,5),"","XMTEXT","F")
 D MSG^DIALOG("WM","",IOM,"","XMTEXT")
 I $P(^XMB(3.7,XMDUZ,0),U,7) D
 . N XMCUT
 . S XMCUT=$P(^XMB(3.7,XMDUZ,0),U,7)
 . Q:XMCUT<XMOLDEST
 . ; You may not access any message prior to |1| unless someone
 . ; forwards it to you.
 . D BLD^DIALOG(37100,$$FMTE^XLFDT(XMCUT,5),"","XMTEXT","F")
 . D MSG^DIALOG("WE","",IOM,"","XMTEXT")
 . S XMOLDEST=XMCUT
 W !
 S DIR(0)="DO^"_XMOLDEST_":DT:EX"
 S DIR("A")=$$EZBLD^DIALOG(34444) ; Message sent on or after
 D BLD^DIALOG(34444.1,"","","DIR(""?"")")
 ; Enter a date.  It must include day, month, and year.
 S DIR("B")=$$FMTE^XLFDT($$MAX^XLFMTH(XMOLDEST,$$FMADD^XLFDT(DT,-365)),5)
 D ^DIR I $D(DIRUT) S XMABORT=1 Q
 S XMINSTR("FDATE")=Y
 ; Message sent on or before date
 I XMINSTR("FDATE")=DT S XMINSTR("TDATE")=DT Q
 K DIR,Y,X
 S DIR(0)="DO^"_XMINSTR("FDATE")_":DT:EX"
 S DIR("A")=$$EZBLD^DIALOG(34445) ; Message sent on or before
 D BLD^DIALOG(34444.1,"","","DIR(""?"")")
 ; Enter a date.  It must include day, month, and year.
 S DIR("B")=$$FMTE^XLFDT(DT,5)
 D ^DIR I $D(DIRUT) S XMABORT=1 Q
 S XMINSTR("TDATE")=Y
 Q
