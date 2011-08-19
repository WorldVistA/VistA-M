XMJMS ;ISC-SF/GMB-Interactive Send ;08/24/2001  12:02
 ;;8.0;MailMan;;Jun 28, 2002
 ; Replaces ^XMA2,^XMA20 (ISC-WASH/CAP/THM)
 ; Entry points used by MailMan options (not covered by DBIA):
 ; PAKMAN  XMPACK - Load PackMan message
 ; SEND    XMSEND - Send a message
 ; *** BLOB^XMA2B (Imaging package) calls entry BLOB
SEND ;
 N XMSUBJ,XMZ,XMABORT
 S XMABORT=0
 D INIT(XMDUZ,.XMABORT) Q:XMABORT
 D SUBJ(.XMSUBJ,.XMABORT) Q:XMABORT
 D CRE8XMZ^XMXSEND(XMSUBJ,.XMZ,1) I XMZ<1 S XMABORT=1 Q
 D:'$G(XMPAKMAN) EDITON(XMDUZ,XMZ,"",.XMBLOB)
 D PROCESS(XMDUZ,XMZ,XMSUBJ,.XMABORT)
 D:XMABORT=DTIME HALT($$EZBLD^DIALOG(34260)) ; sending
 D:'$G(XMPAKMAN) EDITOFF(XMDUZ)
 D:XMABORT KILLMSG^XMXUTIL(XMZ)
 Q
PAKMAN ;
 N XMPAKMAN,XMLOAD,X,XMR
 S (XMPAKMAN,XMLOAD)=1
 D SEND
 Q
BLOB ;
 N XMBLOB,XMOUT
 S XMBLOB=1
 D SEND
 Q
INIT(XMDUZ,XMABORT) ; Clean up and initialize for Sending a message
 D CHECK^XMVVITAE
 I XMDUZ'=DUZ,'$$WPRIV^XMXSEC D  Q  ; Replaces SUR^XMA22
 . S XMABORT=1
 . D SHOW^XMJERR
 D CHKLOCK(XMDUZ,.XMABORT)
 Q
CHKLOCK(XMDUZ,XMABORT) ;
 ; FYI, The menu system releases all locks upon exit from an option.
 I $G(XMV("PRIV"),"W")["W" S XMV("NOSEND")=0
 I 'XMV("NOSEND") D
 . L +^XMB(3.7,"AD",XMDUZ):0 E  S XMV("NOSEND")=1
 I XMV("NOSEND") D  Q  ; Replaces TWO^XMA1E
 . W !,$$EZBLD^DIALOG(37453) ; This session is concurrent with another.  You may not do this.
 . S XMABORT=1
 Q
PROCESS(XMDUZ,XMZ,XMSUBJ,XMABORT) ;
 N XMINSTR,XMRESTR
 I '$G(XMPAKMAN) D BODY(XMDUZ,XMZ,XMSUBJ,.XMRESTR,.XMABORT) Q:XMABORT
 I $G(XMBLOB) D ADD^XMA2B K XMBLOB I $D(XMOUT) S XMABORT=1 Q
 I $G(XMPAKMAN) D PACKIT(XMDUZ,XMZ,XMSUBJ,.XMABORT) Q:XMABORT
 D INIT^XMXADDR
 D TOWHOM^XMJMT(XMDUZ,$$EZBLD^DIALOG(34110),.XMINSTR,.XMRESTR,.XMABORT) ; Send
 I $G(XMPAKMAN),'XMABORT D PSECURE^XMPSEC(XMZ,.XMABORT)
 D:'XMABORT SENDMSG^XMJMSO(XMDUZ,XMZ,XMSUBJ,.XMINSTR,.XMRESTR,.XMABORT)
 D CLEANUP^XMXADDR
 Q
SUBJ(XMSUBJ,XMABORT) ; ask subject
 N DIR,X,Y,XMY
 S DIR("A")=$$EZBLD^DIALOG(34002) ; Subject:
 S DIR(0)="FOU^3:65"
 S:$D(XMSUBJ) DIR("B")=XMSUBJ
 S DIR("?")=$$EZBLD^DIALOG(39403) ; Subject must be from 3 to 65 characters long.
 S DIR("??")="^D QSUBJ^XMJMS"
 F  D  Q:XMY'=""!XMABORT
 . W !
 . D ^DIR S XMY=Y
 . I $D(DTOUT)!$D(DUOUT) S XMABORT=1 Q
 . D VSUBJ^XMXPARM(.XMY)
 . I $D(XMERR) D SHOW^XMJERR S XMY=""
 Q:XMABORT
 S XMSUBJ=$S(XMY[U:$$ENCODEUP^XMXUTIL1(XMY),1:XMY)
 Q
QSUBJ ;
 ;This is the subject of the message, shown whenever the message is displayed.
 ;Leading and trailing blanks are deleted.
 ;Any sequence of 3 or more blanks is reduced to 2 blanks.
 N XMTEXT
 D BLD^DIALOG(34261,"","","XMTEXT","F")
 D MSG^DIALOG("WH","",79,"","XMTEXT")
 Q:$D(XMSUBJ)
 W !!,$$EZBLD^DIALOG(34262) ; If you want to send a message with no subject, just press ENTER.
 Q
BODY(XMDUZ,XMZ,DIWESUB,XMRESTR,XMABORT) ; Replaces ENT1^XMA2
 N DIC
 ;W !,"You may ",$S($D(^XMB(3.9,XMZ,2,0)):"edit",1:"enter")," the ",$S($G(XMPAKMAN):"description of the PackMan",1:"text of the")," message..."
 W !,$$EZBLD^DIALOG($S($D(^XMB(3.9,XMZ,2,0)):34263.1,1:34263)) ; You may edit/enter the text of the message...
 S DWPK=1,DWLW=75,DIC="^XMB(3.9,"_XMZ_",2,"
 D EN^DIWE
 ; The following $D check is to recover from situations in which a user
 ; is in the middle of replying to a message, then opens a 2nd session,
 ; and somehow the reply message stub gets deleted in the 2nd session,
 ; and when the user returns to the 1st session and sends the reply, it
 ; says the reply is from * No Name *.  A lock on ^XMB(3.7,"AD",XMDUZ)
 ; is supposed to prevent the second session from doing this, but for
 ; some reason, at some sites, the second session does not see the lock.
 ; So we recreate the message stub here, in the 1st session, if it was
 ; deleted in the 2nd session.
 I '$D(^XMB(3.9,XMZ,0)) D
 . N XMSUBJ
 . S XMSUBJ=$S($D(XMRESTR("REPLYTO")):"R"_XMRESTR("REPLYTO"),1:DIWESUB)
 . S ^XMB(3.9,XMZ,0)=XMSUBJ
 . S ^XMB(3.9,"B",$E(XMSUBJ,1,30),XMZ)=""
 . I '$D(^XMB(3.9,XMZ,.6)) S ^XMB(3.9,XMZ,.6)=DT,^XMB(3.9,"C",DT,XMZ)=""
 I '$O(^XMB(3.9,XMZ,2,0)) S XMABORT=1 Q
 D CHKLINES^XMXSEC1(XMDUZ,XMZ,.XMRESTR)
 Q
PACKIT(XMDUZ,XMZ,XMSUBJ,XMABORT) ;
 N XCF,XCN,XMA,XMB0,XMP2,X,Y
 D ^XMP
 I X=U,Y=-1 S XMABORT=1
 Q
EDITON(XMDUZ,XMZ,XMZR,XMBLOB) ; Note that msg is being edited.  Replaces D^XMA0A
 N XMFDA,XMIENS
 S XMIENS=XMDUZ_","
 S XMFDA(3.7,XMIENS,5)=XMZ          ; current message/response
 S XMFDA(3.7,XMIENS,7)=$G(XMZR)     ; original message for response
 S XMFDA(3.7,XMIENS,7.5)=$G(XMBLOB) ; 0/1=BLOB yes/no
 D FILE^DIE("","XMFDA")
 Q
EDITOFF(XMDUZ) ; Note that msg is no longer being edited.
 N XMFDA,XMIENS
 S XMIENS=XMDUZ_","
 S XMFDA(3.7,XMIENS,5)="@"
 S XMFDA(3.7,XMIENS,7)="@"
 S XMFDA(3.7,XMIENS,7.5)="@"
 D FILE^DIE("","XMFDA")
 Q
HALT(XMACTION) ;
 W $C(7),!
 ;You have timed out while _XMACTION_ a message.
 ;You can resume when you log back on and re-enter MailMan.
 ;Do it today, or your text may be purged this evening.
 N XMTEXT
 D BLD^DIALOG(34264,XMACTION,"","XMTEXT","F")
 D MSG^DIALOG("WM","",79,"","XMTEXT")
 G H^XUS
RECOVER(XMDUZ,XMZ,XMBLOB) ;
 N XMTEXT,XMSUBJ,XMABORT
 S XMABORT=0
 W $C(7),!
 ;You have / |1| has an unsent message in your buffer.
 D BLD^DIALOG($S(XMDUZ=DUZ:34265,1:34265.1),XMV("NAME"),"","XMTEXT","F")
 I $G(XMV("PRIV"),"W")'["W" D  Q
 . ;Since you don't have 'send' privilege, you may not complete this
 . ;message.  If we delete this message, you'll be able to read and
 . ;reply to messages in this mailbox.  If we leave it alone, you'll
 . ;be able to read messages, but you won't be able to reply to them.
 . D BLD^DIALOG(34267,"","","XMTEXT","F")
 . D MSG^DIALOG("WM","",79,"","XMTEXT")
 . W !
 . N DIR,X,Y
 . S DIR(0)="Y"
 . S DIR("A")=$$EZBLD^DIALOG(34267.1) ; Shall we delete the message?
 . S DIR("B")=$$EZBLD^DIALOG(39054) ; YES
 . D ^DIR
 . I $D(DTOUT) D HALT($$EZBLD^DIALOG(34221)) ; recovering
 . I Y D  Q
 . . D EDITOFF(XMDUZ)
 . . D KILLMSG^XMXUTIL(XMZ)
 . S XMV("NOSEND")=1
 . W !
 . ;OK, you'll be able to read messages,
 . ;but you won't be able to reply to them.
 . D BLD^DIALOG(34267.2,"","","XMTEXT","F")
 . D MSG^DIALOG("WM","",79,"","XMTEXT")
 S XMSUBJ=$P(^XMB(3.9,XMZ,0),U,1)
 S:XMSUBJ["~U~" XMSUBJ=$$DECODEUP^XMXUTIL1(XMSUBJ)
 ;Subj: _XMSUBJ
 D BLD^DIALOG(34536,XMSUBJ,"","XMTEXT","FS")
 ;Some of the text may have been lost.
 ;You must re-enter recipients and any special handling instructions.
 D BLD^DIALOG(34266,"","","XMTEXT","FS")
 D MSG^DIALOG("WM","",79,"","XMTEXT")
 W !
 D INIT(XMDUZ,.XMABORT) Q:XMV("NOSEND")
 D WAIT^XMXUTIL
 I XMABORT D HALT($$EZBLD^DIALOG(34221)) ; recovering
 D PROCESS(XMDUZ,XMZ,XMSUBJ,.XMABORT)
 I XMABORT=DTIME D HALT($$EZBLD^DIALOG(34260)) ; sending
 D EDITOFF(XMDUZ)
 D:XMABORT KILLMSG^XMXUTIL(XMZ)
 Q
