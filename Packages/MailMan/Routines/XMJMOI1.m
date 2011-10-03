XMJMOI1 ;ISC-SF/GMB-Options at Ignore prompt (cont.) ;05/14/2002  15:28
 ;;8.0;MailMan;;Jun 28, 2002
INIT(XMDUZ,XMZ,XMSUBJ,XMFROM,XMORIGN8,XMINSTR,XMRESTR,XMIEN,XMRESPSO,XMRESP) ;
 N XMZREC,XMIM,XMIU
 S XMZREC=^XMB(3.9,XMZ,0)
 D INMSG^XMXUTIL2(XMDUZ,0,XMZ,XMZREC,"I",.XMIM,.XMINSTR,.XMIU)
 S XMSUBJ=XMIM("SUBJ")
 S XMFROM=XMIM("FROM")
 S XMRESPSO=XMIM("RESPS")
 S XMIEN=XMIU("IEN")
 S XMORIGN8=XMIU("ORIGN8")
 S XMRESP=XMIU("RESP")
 D GETRESTR(XMDUZ,XMZ,XMZREC,.XMINSTR,.XMRESTR)
 Q
GETRESTR(XMDUZ,XMZ,XMZREC,XMINSTR,XMRESTR) ;
 D GETRESTR^XMXSEC1(XMDUZ,XMZ,XMZREC,.XMINSTR,.XMRESTR) ; Get restricts
 I $D(XMRESTR("FLAGS")) K XMRESTR("FLAGS") ; We'll have these in XMINSTR("FLAGS"), and they may be changed during user edit.
 Q
IMBACK(XMDIALOG) ;
 W $C(7),!!,$$EZBLD^DIALOG(XMDIALOG),!,$$EZBLD^DIALOG(34075),!! ; Finished.  Now back to:
 D HEADER^XMJMP1(XMDUZ,XMK,XMKN,XMZ,$$ZREAD^XMXUTIL2(XMDUZ,XMZ),^XMB(3.9,XMZ,0),$$EZBLD^DIALOG(34536,XMSUBJ),$$EZBLD^DIALOG(34537,XMZ)) ; Subj: _XMSUBJ / [#_XMZ_]
 Q
PRIORITY ; For priority msgs, ask user if replies should be priority.
 ; Don't ask if the user has already issued a priority toggle,
 ; or if the user has chosen never to be asked.
 Q:XMDUZ=.5&(XMK>999)
 Q:$G(XMSETPRI)!$P(^XMB(3.7,DUZ,0),U,12)
 N DIR,Y,DIRUT
 ;This message is a priority message.
 ;Deliver future responses to this message as Priority Mail
 W !
 S DIR(0)="Y"
 D BLD^DIALOG(34081,"","","DIR(""A"")")
 S DIR("B")=$$EZBLD^DIALOG($S(XMINSTR("FLAGS")["K":39054,1:39053)) ; Yes / No
 S DIR("??")="^D QQPRI^XMJMOI1"
 D ^DIR Q:$D(DIRUT)
 I (XMINSTR("FLAGS")["K"&(Y=0))!(XMINSTR("FLAGS")'["K"&(Y=1)) D K^XMJMOI
 Q
QQPRI ;
 N XMTEXT
 D BLD^DIALOG(34082,"","","XMTEXT","F")
 D MSG^DIALOG("WH","","","","XMTEXT")
 ;Your answer determines, for this message,
 ;how MailMan delivers responses to you.
 ;Note: Recipients can determine for themselves, on a message by message
 ;basis, how responses to priority messages are delivered to them.
 ;It follows that responses to priority messages are not necessarily
 ;delivered as Priority Mail to all recipients.
 Q
RESETXMK(XMDUZ,XMZ,XMK,XMKN) ;
 D BSKT^XMJMP1(XMDUZ,XMZ,.XMK,.XMKN)
 N XMTEXT,XMPARM
 S XMPARM(1)=XMKN,XMPARM(2)=XMV("NAME")
 W !
 D BLD^DIALOG(34068,.XMPARM,"","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 W !
 ; This message is now in the '|1|' basket.
 ; Someone acting for |2| must have moved it.
 Q
READSET(XMDUZ,XMK,XMKN,XMZ,XMFROM,XMORIGN8,XMINSTR,XMIEN,XMDIR,XMOPT,XMOX) ;
 N XMIM,XMIU,XMDEF
 S XMIM("FROM")=XMFROM
 S XMIU("ORIGN8")=XMORIGN8
 S XMIU("IEN")=XMIEN
 D OPTMSG^XMXSEC2(XMDUZ,XMK,XMZ,.XMIM,.XMINSTR,.XMIU,.XMOPT,.XMOX,1)
 K XMOPT("QR"),XMOX("X",XMOX("O","QR")),XMOX("O","QR")
 D SET^XMXSEC1("Q xxx",37420.1,.XMOPT,.XMOX) ; Query recipient(s) xxx
 D SET^XMXSEC1("HU",37429,.XMOPT,.XMOX) ; Help:User Information
 D SET^XMXSEC1("HG",37430,.XMOPT,.XMOX) ; Help:Group Information
 D SET^XMXSEC1("BR",37446,.XMOPT,.XMOX) ; Print to the Browser
 I $D(XMOPT("B","?")) S XMOPT("BR","?")=XMOPT("B","?")
 E  I '$$TEST^DDBRT S XMOPT("BR","?")=37446.9 ; The BROWSER device is not selectable from this terminal.
 S XMDIR("A")=$$EZBLD^DIALOG(34065,XMKN) ; Enter message action (in _XMKN_ basket):
 S XMDEF=$S(XMDUZ=.6:"I",XMINSTR("FLAGS")["N":"I",XMK=1:XMV("MSG DEF"),1:"I")
 S XMDIR("B")=XMOX("O",XMDEF)_":"_XMOPT(XMDEF)
 S XMDIR("PRE")="I XMX?1(1"""_XMOX("O","Q")_" "",1"""_$$LOW^XLFSTR(XMOX("O","Q"))_" "",1"""_XMOX("O","QD")_" "",1"""_$$LOW^XLFSTR(XMOX("O","QD"))_" "").E S XMNAME=$P(XMX,"" "",2,99),XMX="""_XMOX("O","QD")_""""
 Q:XMK="!"  ; Super Search (option XM SUPER SEARCH)
 I XMV("NOSEND") D
 . N I
 . F I="A","C","R","W" S XMOPT(I,"?")=37453 ; This session is concurrent with another.  You may not do this.
 E  I $G(XMOPT("A","?"))=37401.1 K XMOPT("A","?") ; You must have a Network Signature to Answer a message.
 D SET^XMXSEC1("RI",37443,.XMOPT,.XMOX) ; Reply and Include responses
 I $D(XMOPT("R","?")) S XMOPT("RI","?")=XMOPT("R","?")
 Q
