XM ;ISC-SF/GMB-MailMan Main Driver ;04/22/2002  14:31
 ;;8.0;MailMan;;Jun 28, 2002
 ; Replaces ^XM,EN^XMA01,INTRO^XMA6,REC^XMA22,MULTI^XM0,^XMAK (ISC-WASH/CAP/THM)
 ;
 ; Entry points (DBIA 10064):
 ; ^XM       Programmer entry into MailMan
 ; CHECKIN   Meant to be included in option ENTRY ACTION
 ; CHECKOUT  Meant to be included in option EXIT ACTION
 ; EN        Option entry point into MailMan
 ; HEADER    Displays user intro when entering MailMan
 ; KILL      Kill MailMan variables
 ; N1        Create a mailbox
 ; NEW       Create a mailbox
 ; $$NU      Tell user how many new messages he has
 ; 
 ; Entry points used by MailMan options (not covered by DBIA):
 ; NEWMBOX   XMMGR-NEW-MAIL-BOX - Create a mailbox
 D KILL^XUSCLEAN
 N XMXUSEC,XMABORT,XMMENU
 S XMMENU(0)="^XM"
 I '$D(IOF) D HOME^%ZIS
 D EN
 I $D(XQUIT)!'$D(XMDUZ) K XQUIT D CLEANUP Q
 D:'$D(^DOPT("XM")) OPTIONS
 S XMABORT=0
 F  D  Q:XMABORT  ; Programmer option choices
 . N DIC,X,Y
 . S XMXUSEC=$S($G(DUZ(0))="@":1,$D(^XUSEC("XUPROG",XMDUZ)):1,$D(^XUSEC("XUPROGMODE",XMDUZ)):1,1:0)
 . S DIC="^DOPT(""XM"","
 . S DIC(0)="AEQMZ"
 . S DIC("S")="Q:XMXUSEC  I ^(0)'[""LOAD"""
 . W !!
 . D ^DIC I Y<0 S XMABORT=1 Q
 . K DIC,X
 . X $P(Y(0),U,2,999)
 D CLEANUP
 Q
EN ;Initialize
 ;N XMDUZ,XMDISPI,XMDUN,XMNOSEND,XMV
 Q:$D(DUZ("SAV"))  ; Set by option XUTESTUSER
 D SETUP
 D HEADER
 Q
SETUP ;
 I $G(IO)'=$G(IO(0))!'$D(IO(0)) D HOME^%ZIS U IO
 D CHECK^XMKPL ; Make sure background filers are running.
 I '$D(IOF)!'$D(IOM)!'$D(IOSL) S IOP="" D ^%ZIS K IOP
 S XMDUZ=DUZ
 D INIT^XMVVITAE
 K XMERR,^TMP("XMERR",$J)
 Q
HEADER ;
 N XMPERSON,XMPARM,XMTEXT
 I $D(XMV("SYSERR")) D ERROR(.XMV,"SYSERR") S:$D(XMMENU) XQUIT="" Q  ; Fatal Errors
 I $D(XMV("ERROR")) D ERROR(.XMV,"ERROR") S:$D(XMMENU) XQUIT="" Q  ; Fatal Errors
 I $D(XMV("WARNING")) D WARNING(XMDUZ,.XMV)
 S XMPARM(1)=XMV("VERSION"),XMPARM(2)=XMV("NETNAME")
 W !!,$$EZBLD^DIALOG(38150,.XMPARM) ; |1| service for |2|
 I XMDUZ'=DUZ W !,$$EZBLD^DIALOG(38008,XMV("DUZ NAME")) ; (Surrogate: |1|)
 I XMDUZ'=.6 D
 . S XMPARM(1)=XMV("LAST USE"),XMPARM(2)=XMV("NAME")
 . W !,$$EZBLD^DIALOG($S(XMDUZ=DUZ:38151,1:38152),.XMPARM) ; You/|2| last used MailMan: |1|
 . Q:'$D(XMV("BANNER"))
 . S XMPARM(1)=XMV("BANNER"),XMPARM(2)=XMV("NAME")
 . D BLD^DIALOG($S(XMDUZ=DUZ:38153,1:38154),.XMPARM,"","XMTEXT","F")
 . D MSG^DIALOG("WM","","","","XMTEXT")
 . ; Your/|2|'s current banner: |1|
 . ;E  W !,$S(XMDUZ=DUZ:"You have",1:XMV("NAME")_" has")," no banner."
 S XMPARM(1)=XMV("NEW MSGS"),XMPARM(2)=XMV("NAME")
 W !,$$EZBLD^DIALOG($S(XMDUZ=DUZ:38155,1:38156)+$S(XMV("NEW MSGS")>1:0,'XMV("NEW MSGS"):.2,1:.1),.XMPARM) ; You have/|2| has |1|/no new message(s).
 I XMV("NEW MSGS")<0!(XMV("NEW MSGS")&'$D(^XMB(3.7,XMDUZ,"N0")))!('XMV("NEW MSGS")&$D(^XMB(3.7,XMDUZ,"N0"))) D
 . D MSG(38160)
 . ; There's a discrepancy in the 'new message' count.  Checking the mailbox...
 . D USER^XMUT4(XMDUZ)
 Q
ERROR(XMV,XMTYPE) ;
 N I
 S I=0
 F  S I=$O(XMV(XMTYPE,I)) Q:I=""  W !,$C(7),XMV(XMTYPE,I)
 K XMDUZ
 Q
WARNING(XMDUZ,XMV) ;
 D:$D(XMV("WARNING",5)) POST(XMV("WARNING",5))
 D:$D(XMV("WARNING",4)) MULTI
 D:$D(XMV("WARNING",3)) INTRO(XMDUZ)
 D:$D(XMV("WARNING",2)) UNSENT(XMDUZ)
 D:$D(XMV("WARNING",1)) LISTPRI^XMJML(XMDUZ)
 ;D:$D(XMV("WARNING",1)) PRIO^XMJML(XMDUZ)
 K XMV("WARNING")
 Q
MSG(XMDIALOG) ;
 N XMTEXT
 W !
 D BLD^DIALOG(XMDIALOG,"","","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 Q
POST(XMMSG) ;
 W !!,$C(7),XMMSG ; "POSTMASTER has X baskets."
 D MSG(38113.1)
 ;POSTMASTER may not have more than 999 baskets.
 ;Baskets numbered above 999 are reserved for network transmission
 ;queues and for server queues.
 Q
MULTI ;
 ;It appears someone is signed on as you/|1| already.
 ;You may not send mail or respond to mail in this session.
 ;(Only the 1st of multiple MailMan sessions may send or respond to mail.)
 N XMTEXT
 W !
 D BLD^DIALOG($S(XMDUZ=DUZ:38110.1,1:38110.2),XMV("NAME"),"","XMTEXT","F")
 D BLD^DIALOG(38110.3,"","","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 Q
INTRO(XMDUZ) ;
 D MSG(38114.1)
 ;You have not yet introduced yourself to the group.
 ;Please enter a short introduction, so that others may use
 ;the HELP option to find out more about you.
 ;You may change your INTRODUCTION later
 ;under 'Personal Preferences|User Options Edit.
 W !!
 N DIR S DIR(0)="E" D ^DIR Q:$D(DIRUT)
 N DWPK,DIC
 S DWPK=1,DIC="^XMB(3.7,XMDUZ,1,"
 D EN^DIWE
 Q
UNSENT(XMDUZ) ;
 N XMREC,XMZ
 L +^XMB(3.7,"AD",XMDUZ):0 E  D  Q
 . S XMV("NOSEND")=1
 . D MULTI
 S XMREC=^XMB(3.7,XMDUZ,"T")
 S XMZ=$P(XMREC,U) Q:'XMZ
 I $P(XMREC,U,3) D RECOVER^XMJMR(XMDUZ,XMZ,$P(XMREC,U,3)) Q  ; Reply
 D RECOVER^XMJMS(XMDUZ,XMZ,$P(XMREC,U,4))  ; Original Message (w/BLOB)
 Q
CHECKIN ;
 Q:$D(XMMENU(0))   ; Set by option XMUSER or other options using MailMan
 Q:$D(DUZ("SAV"))  ; Set by option XUTESTUSER
 D SETUP
 I $D(XMV("WARNING")) D WARNING(XMDUZ,.XMV)
 Q
CHECKOUT ;
 K XMERR,^TMP("XMERR",$J)
 Q:$D(XMMENU(0))
 K XMDISPI,XMDUN,XMDUZ,XMNOSEND,XMPRIV,XMV
 L -^XMB(3.7,"AD",DUZ)
 Q
LOCK ;
 S Y=1
 Q:'$D(XMMENU(0))
 L +^XMB(3.7,"AD",DUZ):0 E  D MULTI S Y=-1
 Q
UNLOCK ;
 Q:'$D(XMMENU(0))
 L -^XMB(3.7,"AD",DUZ)
 Q
CHK ; Entry used by Kernel
 K ^TMP("XMY",$J),^TMP("XMY0",$J)
 S XMDUZ=$G(XMDUZ,DUZ)
 Q:XMDUZ=.6
 D NUS(0)
 Q
NU(XMFORCE) ;API for new message display
 ; XMFORCE  (in) 1=force new display; 0=display only if recent receipt
 N XMNEW
 D NUS(XMFORCE,.XMNEW)
 Q XMNEW
NUS(XMFORCE,XMNEW) ; new message display
 ; XMFORCE  (in) 1=force new display; 0=display only if recent receipt
 ; XMNEW    (out) number of new messages
 ; XMLAST   last message arrival date (FM format)
 N XMREC,XMNEW2U,XMLAST
 S XMDUZ=$G(XMDUZ,DUZ)
 S XMREC=$$NEWS^XMXUTIL(XMDUZ,$D(DUZ("SAV")))
 Q:XMREC=-1
 S XMNEW=$P(XMREC,U,1)
 I 'XMFORCE,'XMNEW Q
 S XMLAST=$P(XMREC,U,4)
 S XMNEW2U=$P(XMREC,U,5)
 I XMNEW2U!XMFORCE D
 . N XMPARM,XMDIALOG
 . S XMPARM(1)=XMNEW
 . I XMDUZ=DUZ S XMDIALOG=38155
 . E  S XMDIALOG=38156,XMPARM(2)=$$NAME^XMXUTIL(XMDUZ)
 . W !,$$EZBLD^DIALOG(XMDIALOG+$S(XMNEW>1:0,'XMNEW:.2,1:.1),.XMPARM) ; You have/|2| has |1|/no new message(s).
 . Q:'XMNEW
 . W "  ",$$EZBLD^DIALOG(38158,$$MMDT^XMXUTIL1(XMLAST)) ; (Last arrival: |1|)
 D:$P(XMREC,U,2) NOTEPRIO
 Q
NOTEPRIO ;
 N XMDIALOG,XMPARM
 I XMDUZ=DUZ S XMDIALOG=38159 ;You've got PRIORITY Mail!
 E  S XMDIALOG=38159.1,XMPARM(1)=$$NAME^XMXUTIL(XMDUZ) ;|1| has PRIORITY Mail!
 D ZIS
 W $C(7),!!,$G(IORVON),$$EZBLD^DIALOG(XMDIALOG,.XMPARM),!!,$G(IORVOFF)
 Q
ZIS ;
 Q:$D(IORVON)
 N X
 S X="IORVON;IORVOFF;IOBON;IOBOFF"
 D ENDR^%ZISS
 Q
NEWMBOX ; Create a mailbox for a user
 N DIC,XMZ
 D MSG(38165)
 ;Ready to create a mailbox for a user.
 ;You will only be able to select a user who does not already have a mailbox.
 S DIC="^VA(200,"
 S DIC(0)="AEQM"
 S DIC("S")="I '$D(^XMB(3.7,Y,0))"
 D ^DIC Q:Y=-1
 S Y=+Y
 D NEW
 W !,$$EZBLD^DIALOG(38165.1) ; Mailbox created.
 Q
N1 S Y=XMDUZ
NEW ; CREATE MAILBOX 4 NEW USER
N L +^XMB(3.7,0):0 E  H 1 G N
 D CRE8MBOX^XMXMBOX(Y,$S($D(XMZ):DT,1:""))
 L -^XMB(3.7,0)
 D:$D(XMERR) SHOW^XMJERR
 Q
KILL ;
CLEANUP ;
 K XMV,XMDISPI,XMDUN,XMDUZ,XMPRIV,XMNOSEND,XMERR
 K:$D(^TMP("XMERR",$J)) ^TMP("XMERR",$J)
 D KILLALL
 D UNLOCK
 Q
KILLALL ;All variables except XMDISPI,XMDUZ,XMDUN and XMPRIV are killed here on
 ;exit from the MailMan package or by calls to this code.
 K A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,V,W,X,Z,%,%0,%1,%2,%3,%4
 K XM,XMA,XMA0,XMAPBLOB,XMB,XMB0
 K XMC,XMC0,XMCH,XMCI,XMCL,XMCNT,XMCT
 K XMD,XMD0,XMDATE,XMDI,XMDT,XME,XME0,XMF,XMF0,XMG,XMG0
 K XMK,XMKM,XMKN,XMI,XMJ
 K XML,XMLOAD,XMLOC,XMLOCK,XMM,XMMG,XMN,XMOUT,XMP
 K XMR,XMRES,XMS,XMSEN,XMSUB
 K XMT,XMTYPE,XMU,XMY,XMZ,XMZ1,XMZ2
 Q
DSP ;
 D INIT^XMVVITAE
 Q
OPTIONS ; Set up options
 N DIK,I,X
 K ^DOPT("XM")
 S DIK="^DOPT(""XM"","
 S ^DOPT("XM",0)="MailMan Option^1N^"
 F I=1:1 S X=$P($T(T+I)," ",1,3) Q:X=" ;;"  S X=$E(X,4,255),^DOPT("XM",I,0)=$$UP^XLFSTR($$EZBLD^DIALOG(+X))_U_$P(X,U,2,3)
 D IXALL^DIK
 Q
T ;;TABLE
 ;;38170^D SEND^XMJMS        ; SEND A MESSAGE
 ;;38171^D MANAGE^XMJBM      ; READ/MANAGE MESSAGES
 ;;38172^D NEW^XMJBN         ; NEW MESSAGES AND RESPONSES
 ;;38173^D PAKMAN^XMJMS      ; LOAD PACKMAN MESSAGE
 ;;38174^D EDIT^XMVVITA      ; EDIT USER OPTIONS
 ;;38175^D PERSONAL^XMVGROUP ; PERSONAL MAIL GROUP EDIT
 ;;38176^D ENROLL^XMVGROUP   ; JOIN MAIL GROUP
 ;;38177^D LISTMBOX^XMJBL    ; MAILBOX CONTENTS LIST
 ;;38178^D TALK^XMC          ; LOG-IN TO ANOTHER SYSTEM (TalkMan)
 ;;38179^D FIND^XMJMF        ; QUERY/SEARCH FOR MESSAGES
 ;;
 ;;**OBSOLETE**
 ;;BLOB SEND^D BLOB^XMA2B
 ;;
