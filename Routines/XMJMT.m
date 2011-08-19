XMJMT ;ISC-SF/GMB-Interactive Send to whom ;07/17/2003  13:06
 ;;8.0;MailMan;**20**;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; R     XMHELPLNK - Get help on remote addresses (mail link)
TOWHOM(XMDUZ,XMTYPE,XMINSTR,XMRESTR,XMABORT) ;
 N DIR,X,Y,XMTO
 S XMTO="?"
 F  D  Q:XMTO=""!XMABORT
 . K DIR
 . I $D(^TMP("XMY0",$J)) D
 . . S DIR("A")=$$EZBLD^DIALOG(34113,XMTYPE) ;And |1| to
 . . S DIR(0)="FrO^1:100" ; ('r' means no 'replace...with...' prompt)
 . E  D
 . . S DIR("A")=$$EZBLD^DIALOG(34112,XMTYPE) ;|1| mail to
 . . I XMTYPE=$$EZBLD^DIALOG(34110) S DIR("B")=$G(XMINSTR("TO PROMPT"),XMV("NAME")) ;Send
 . . E  I $G(XMINSTR("TO PROMPT")) S DIR("B")=XMINSTR("TO PROMPT")
 . . S DIR(0)="Fr^1:100"
 . D BLD^DIALOG(34114,"","","DIR(""?"")") ;Enter the name(s) of the recipient(s)
 . S DIR("??")="^D QQ^XMJMT"
 . D ^DIR I $D(DTOUT) S XMABORT=DTIME Q
 . I $D(DUOUT) D  Q
 . . I XMTYPE=$$EZBLD^DIALOG(34111) S XMABORT=1 Q  ;Forward
 . . N DIR,DIRUT,X,Y
 . . S DIR("A")=$$EZBLD^DIALOG(34115) ;Shall we forget the whole thing
 . . S DIR("B")=$$EZBLD^DIALOG(39053) ;No
 . . S DIR(0)="Y"
 . . D BLD^DIALOG(34116,"","","DIR(""?"")") ;Enter YES to abort this message.
 . . D ^DIR
 . . I Y=1!$D(DIRUT) S XMABORT=1
 . S XMTO=Y Q:XMTO=""
 . I $G(XMRESTR("NOFPG")),$E(XMTO,1,2)="G." D  Q
 . . ;Only the message originator or XM GROUP PRIORITY key
 . . ;holders may forward priority messages to Mail Groups.
 . . N XMTEXT
 . . D BLD^DIALOG(34117,"","","XMTEXT","F")
 . . D MSG^DIALOG("WE","","","","XMTEXT")
 . I $G(XMRESTR("NONET")),XMTO["@" D  Q
 . . N XMTEXT
 . . W $C(7)
 . . ;Messages longer than |1| lines may not be sent across the network.
 . . D BLD^DIALOG(39001,XMRESTR("NONET"),"","XMTEXT","F")
 . . D MSG^DIALOG("WE","","","","XMTEXT")
 . I XMTO=XMV("NAME"),$G(DIR("B"))=XMV("NAME") S XMTO="`"_XMDUZ ; to avoid ambiguity in case 2 users have the same name.
 . D ADDR^XMXADDR(XMDUZ,XMTO,.XMINSTR,.XMRESTR)
 Q
QQ ; "??" help
 N DIR,X,Y,XMCHOICE,I
 S DIR("A")=$$EZBLD^DIALOG(34120) ;Enter the kind of help you'd like
 S I=$$EZBLD^DIALOG(34126),XMCHOICE($P(I,":"))="U" ;U:User information
 S DIR(0)="SO^"_I
 S I=$$EZBLD^DIALOG(34121),XMCHOICE($P(I,":"))="G" ;G:Mail Group information
 S DIR(0)=DIR(0)_";"_I
 S I=$$EZBLD^DIALOG(34122),XMCHOICE($P(I,":"))="D" ;D:Domain information
 S DIR(0)=DIR(0)_";"_I
 I $O(^XMD(4.2997,0)) D
 . S I=$$EZBLD^DIALOG(34123),XMCHOICE($P(I,":"))="R" ;R:Remote user information
 . S DIR(0)=DIR(0)_";"_I
 I $D(^TMP("XMY0",$J)) D
 . S I=$$EZBLD^DIALOG(34124),XMCHOICE($P(I,":"))="S" ;S:Show current recipients of this message
 . S DIR(0)=DIR(0)_";"_I
 S I=$$EZBLD^DIALOG(34125),XMCHOICE($P(I,":"))="M" ;M:More help
 S DIR(0)=DIR(0)_";"_I
 F  D ^DIR Q:$D(DIRUT)  D @XMCHOICE(Y)
 Q
S ; Show Current Recipients
 N XMTO,XMABORT,DIR,X,Y
 I '$D(^TMP("XMY0",$J)) W !,$$EZBLD^DIALOG(34130) Q  ;There aren't any recipients so far.
 W @IOF,$$EZBLD^DIALOG(34131) ;Current recipients are:
 S XMTO="",XMABORT=0
 F  S XMTO=$O(^TMP("XMY0",$J,XMTO)) Q:XMTO=""  D  Q:XMABORT
 . D:$Y+3>IOSL PAGE(.XMABORT)
 . W !,?3,$S($D(^TMP("XMY0",$J,XMTO,1)):^(1)_":",1:""),XMTO
 . W:$D(^TMP("XMY0",$J,XMTO,"L")) ?40,$$EZBLD^DIALOG(34132),$$MMDT^XMXUTIL1(^("L")) ;Deliver:
 Q:XMABORT
 Q:'$D(^TMP("XMY",$J))
 S DIR(0)="Y"
 S DIR("A")=$$EZBLD^DIALOG(34133) ;Like more detail
 S DIR("B")=$$EZBLD^DIALOG(39054) ;Yes
 D ^DIR
 Q:Y'=1
 ;Expanded Recipient List
 S XMTO=""
 F  S XMTO=$O(^TMP("XMY",$J,XMTO)) Q:XMTO=""  D  Q:XMABORT
 . I $Y+3>IOSL D PAGE(.XMABORT) Q:XMABORT
 . W !,?3,$S($D(^TMP("XMY",$J,XMTO,1)):^(1)_":",1:""),$$NAME^XMXUTIL(XMTO)
 D PAGE(.XMABORT)
 Q
PAGE(XMABORT) ;
 D PAGE^XMXUTIL(.XMABORT) Q:XMABORT
 W @IOF
 Q
U ; User Info
 D HELP^XMHIU
 Q
G ; Group Info
 N DIR
 D HELP^XMHIG
 Q
D ; Domain Info (Replaces QQ2^XMA50)
 N DIC,X,Y,XMSTATE,XMREC
 S DIC="^DIC(4.2,",DIC(0)="AEQMZ"
 F  W ! D ^DIC Q:Y<0  D
 . S XMREC=Y(0)
 . W:$L($P(XMREC,U,14)) !,$$EZBLD^DIALOG(34140),$P(XMREC,U,14) ;Routing indicator:
 . I $D(^XUSEC("XMMGR",DUZ)) D
 . . W:$L($P(XMREC,U,12)) !,$$EZBLD^DIALOG(34141),$P(XMREC,U,12) ;MailMan Host Number:
 . . W:$L($P(XMREC,U,11)) !,$$EZBLD^DIALOG(34142),$P(XMREC,U,11) ;Security Key:
 . W:$P(XMREC,U,3) !,$$EZBLD^DIALOG(34143),$P(^DIC(4.2,$P(XMREC,U,3),0),U,1) ;Relay Domain:
 . S XMSTATE=$P(XMREC,U,2)
 . W !,$$EZBLD^DIALOG($S(XMSTATE["C":34144,XMSTATE'["S":34145,1:34146))
 . ; 34144 - Messages cannot be sent, because this domain is CLOSED
 . ; 34145 - Messages are QUEUED for later transmission
 . ; 34146 - Messages are SENT immediately
 Q
R ; Remote User Info (Replaces QQ3A,QQ3B^XMA5)
 N DIC,X,Y,DR,DA
 S DIC="^XMD(4.2997,",DIC(0)="AEFMQ"
 S DIC("A")=$$EZBLD^DIALOG(34149) ; Enter LASTNAME, MAIL CODE, or LOCATION
 F  W ! D ^DIC Q:Y<0  D
 . S DA=+Y,DR=0 D EN^DIQ
 Q
M ;
 N XQH,DIR,X,Y
 S XQH="XM-U-A-ADDRESS"
 D EN^XQH
 Q
