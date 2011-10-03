XMXSEND ;ISC-SF/GMB-Send a msg ;06/19/2002  07:01
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points:
 ; SENDMSG  Send a message
 ; CRE8XMZ  Setup a message. (1st part of 3-part message sending process)
 ;          In the second part, the programmer directly sets the message
 ;          text into the global.
 ; ADDRNSND Send the message created by CRE8XMZ and 'texted' by the
 ;          programmer.  (3rd part of 3-part message sending process)
 ;          Involves checking the addressees, loading the message,
 ;          putting the addressees in the message,
 ;          and sending the message.
 ; LATER    TaskMan entry point to send a 'later'd message
SENDMSG(XMDUZ,XMSUBJ,XMBODY,XMTO,XMINSTR,XMZ,XMATTACH) ;
 ; XMDUZ             DUZ of who the msg is from
 ; XMSUBJ            Subject of the msg
 ; XMBODY            Body of the msg
 ;                   Must be closed root, passed by value.  See WP_ROOT
 ;                   definition for WP^DIE(), FM word processing filer.
 ; XMTO              Addressees
 ; XMINSTR("SELF BSKT") Basket to deliver to if sender is recipient
 ; XMINSTR("SHARE DATE") Delete date if recipient is "SHARED,MAIL"
 ; XMINSTR("SHARE BSKT") Basket if recipient is "SHARED,MAIL"
 ; XMINSTR("RCPT BSKT") Basket name (only) to deliver to for other recipients
 ; XMINSTR("VAPOR")  Date on which to vaporize (delete) this message
 ;                   from recipient baskets
 ; XMINSTR("LATER")  Date on which to send this msg, if not now
 ; XMINSTR("FROM")   String saying from whom (default is user)
 ; XMINSTR("FLAGS")  Any or all of the following:
 ;                   P Priority
 ;                   I Information only (may not be replied to)
 ;                   X Closed msg (may not be forwarded)
 ;                   C Confidential (surrogates may not read)
 ;                   S Send to sender (make sender a recipient)
 ;                   R Confirm receipt
 ; XMINSTR("SCR KEY") Scramble key (implies that msg should be scrambled)
 ; XMINSTR("SCR HINT") Hint (to guess the scramble key)
 ; XMINSTR("STRIP")  String containing characters to strip from the message text
 ; XMINSTR("TYPE")   Msg type is one of the following:
 ;                   D Document          (NOT IMPLEMENTED)
 ;                   S Spooled Document  (NOT IMPLEMENTED)
 ;                   X DIFROM            (NOT IMPLEMENTED)
 ;                   O ODIF              (NOT IMPLEMENTED)
 ;                   B BLOB
 ;                   K KIDS              (NOT IMPLEMENTED)
 ; XMINSTR("ADDR FLAGS")   Any or all of the following:
 ;                   I Do not Initialize (kill) the ^TMP addressee global
 ;                   R Do not Restrict addressees
 ; XMZ         (out) msg number in ^XMB(3.9 (BUT IF $D(XMINSTR("LATER")),
 ;                   then XMZ contains the task number)
 ; XMATTACH    (in)  Array of files to attach to message
 ;                   ("IMAGE",x) imaging (BLOB) files
 ;                   ("ROU",x)   routines (NOT IMPLEMENTED)
 K XMERR,^TMP("XMERR",$J)
 Q:'$$SEND^XMXSEC(XMDUZ,.XMINSTR)
 I $D(XMINSTR("LATER")) D  Q
 . N XMTASK
 . D PSNDLATR(XMDUZ,XMSUBJ,XMBODY,.XMTO,.XMINSTR,.XMTASK,.XMATTACH)
 . I $D(XMTASK) S XMZ=XMTASK
 D CRE8XMZ(XMSUBJ,.XMZ) Q:$D(XMERR)  ; Create a place for the msg in the msg file
 D:$D(XMATTACH("IMAGE"))>9 ADDBLOB(XMZ,.XMATTACH) Q:$D(XMERR)
 D MOVEBODY(XMZ,XMBODY) ; Put the msg body in place
 D CHEKBODY(XMZ,$G(XMINSTR("STRIP")))
 D ADDRNSND(XMDUZ,XMZ,.XMTO,.XMINSTR)
 Q
ADDRNSND(XMDUZ,XMZ,XMTO,XMINSTR) ;
 D CHEKADDR(XMDUZ,XMZ,.XMTO,.XMINSTR)
 D BLDNSND(XMDUZ,XMZ,.XMINSTR)
 D CLEANUP^XMXADDR
 Q
CHEKADDR(XMDUZ,XMZ,XMTO,XMINSTR) ;
 N XMRESTR
 D:$G(XMINSTR("ADDR FLAGS"))'["I" INIT^XMXADDR
 D:$G(XMINSTR("ADDR FLAGS"))'["R" CHKLINES^XMXSEC1(XMDUZ,XMZ,.XMRESTR)
 D:$G(XMINSTR("FLAGS"))["S" CHKADDR^XMXADDR(XMDUZ,XMDUZ)
 D CHKADDR^XMXADDR(XMDUZ,.XMTO,.XMINSTR,.XMRESTR) ; Address the msg
 Q
BLDNSND(XMDUZ,XMZ,XMINSTR) ;
 D MOVEPART(XMDUZ,XMZ,.XMINSTR) ; Put various parts of the msg in place
 I '$$GOTADDR^XMXADDR D ERRSET^XMXUTIL(34100) Q  ; No addressees.  Message not sent.
 D SEND^XMKP(XMDUZ,XMZ,.XMINSTR) ; Send the msg
 D CHECK^XMKPL
 Q
ADDBLOB(XMZ,XMATTACH) ;
 N X,XMYBLOB,%X,%Y
 S %X="XMATTACH(""IMAGE"",",%Y="XMYBLOB(" D %XY^%RCR
 S X=$$MULTI^XMBBLOB(XMZ)
 Q:'X
 S XMERR=$G(XMERR)+1,^TMP("XMERR",$J,XMERR,"TEXT",1)="Error with $$MULTI^XMBBLOB"
 D KILLMSG^XMXUTIL(XMZ)
 Q
CRE8XMZ(XMSUBJ,XMZ,XMIA) ; Create a place for the msg in the msg file
 N XMFDA,XMIEN,XMMAXDIG,XMRESET
 I XMSUBJ[U S XMSUBJ=$$ENCODEUP^XMXUTIL1(XMSUBJ)
 S XMMAXDIG=$P($G(^XMB(1,1,.17),8),U,1) I 'XMMAXDIG S XMMAXDIG=8
 S XMRESET=0
TRYXMZ ;
 S XMFDA(3.9,"+1,",.01)=XMSUBJ
 S XMFDA(3.9,"+1,",31)=DT ; local create date
 D UPDATE^DIE("","XMFDA","XMIEN")
 I $D(DIERR) D  Q
 . S XMZ=-1
 . ; Call to UPDATE^DIE failed.  Can't get a message number.
 . ; Here's the error returned by FileMan:
 . D ERRSET^XMXUTIL(34107)
 . N I,J,K
 . S J=0
 . S I=$O(^TMP("XMERR",$J,XMERR,"TEXT",":"),-1)
 . F K=1:1:+DIERR D
 . . F  S J=$O(^TMP("DIERR",$J,K,"TEXT",J)) Q:'J  D
 . . . S I=I+1,^TMP("XMERR",$J,XMERR,"TEXT",I)=^TMP("DIERR",$J,K,"TEXT",J)
 . Q:'$G(XMIA)!$D(ZTQUEUED)
 . D SHOW^XMJERR
 . D WAIT^XMXUTIL
 S XMZ=XMIEN(1)
 Q:$L(XMZ)'>XMMAXDIG
 I XMRESET S $P(^XMB(1,1,.17),U,1)=$L(XMZ) Q
 ; Recycle message numbers, because this one's too big...
 K XMIEN
 S XMRESET=1
 I '$D(^XMB(3.9,99999,0)) D
 . ; We do this so that if message 100000 is created and then deleted,
 . ; FM will set piece 3 of ^XMB(3.9,0) to 99999.  We don't want any
 . ; message number lower than 100000 to be created, so that message
 . ; numbers can't be confused with message sequence numbers in baskets
 . S ^XMB(3.9,99999,0)="place holder"
 . S ^XMB(3.9,"B","place holder",99999)=""
 L +^XMB(3.9,0):1
 I $L($P(^XMB(3.9,0),U,3))>XMMAXDIG S $P(^XMB(3.9,0),U,3)=99999
 N DIK,DA S DIK="^XMB(3.9,",DA=XMZ D ^DIK ; Delete the message stub.
 L -^XMB(3.9,0)
 G TRYXMZ ; Go get another
MOVEBODY(XMZ,XMBODY,XMFLAG) ;
 D WP^DIE(3.9,XMZ_",",3,$G(XMFLAG),XMBODY)
 Q
CHEKBODY(XMZ,XMSTRIP,XMI) ; Remove XMSTRIP, control characters from text
 N XMLINE,I,XMLEN,XMALTRD
 S XMI=+$G(XMI)
 F  S XMI=$O(^XMB(3.9,XMZ,2,XMI)) Q:'XMI  S XMLINE=^(XMI,0) D
 . S XMALTRD=0
 . I $G(XMSTRIP)'="" S XMLEN=$L(XMLINE),XMLINE=$TR(XMLINE,XMSTRIP) I XMLEN>$L(XMLINE) S XMALTRD=1
 . I XMLINE?.E1C.E D
 . . S (I,XMALTRD)=1
 . . F  D  Q:XMLINE'?.E1C.E
 . . . I $E(XMLINE,I)?1C S XMLINE=$E(XMLINE,1,I-1)_$E(XMLINE,I+1,999) Q
 . . . S I=I+1
 . S:XMALTRD ^XMB(3.9,XMZ,2,XMI,0)=XMLINE
 Q
MOVEPART(XMDUZ,XMZ,XMINSTR) ; Put various parts of the msg in place
 N XMFDA,XMIENS
 S XMIENS=XMZ_","
 I $D(XMINSTR("FROM")) S XMFDA(3.9,XMIENS,1)=XMINSTR("FROM")
 E  D
 . S XMFDA(3.9,XMIENS,1)=XMDUZ
 . S:XMDUZ'=DUZ XMFDA(3.9,XMIENS,1.1)=DUZ
 S XMFDA(3.9,XMIENS,1.4)=$$NOW^XLFDT()
 I $D(XMINSTR) D
 . S:$G(XMINSTR("FLAGS"))["R" XMFDA(3.9,XMIENS,1.3)="y"
 . S:$D(XMINSTR("VAPOR")) XMFDA(3.9,XMIENS,1.6)=XMINSTR("VAPOR")
 . S:$D(XMINSTR("TYPE")) XMFDA(3.9,XMIENS,1.7)=XMINSTR("TYPE")
 . I $D(XMINSTR("SCR KEY")) D
 . . N XMKEY,XMSECURE  ; XMSECURE is new'd for scramble
 . . S XMFDA(3.9,XMIENS,1.8)=$S($G(XMINSTR("SCR HINT"))="":" ",1:XMINSTR("SCR HINT"))
 . . D LOADCODE^XMJMCODE
 . . S XMKEY=XMINSTR("SCR KEY")
 . . D ADJUST^XMJMCODE(.XMKEY)
 . . S XMFDA(3.9,XMIENS,1.85)="1"_$$ENCSTR^XMJMCODE(XMKEY)
 . . D ENCMSG^XMJMCODE(XMZ)
 . S:$G(XMINSTR("FLAGS"))["X" XMFDA(3.9,XMIENS,1.95)="y"
 . S:$G(XMINSTR("FLAGS"))["C" XMFDA(3.9,XMIENS,1.96)="y"
 . S:$G(XMINSTR("FLAGS"))["I" XMFDA(3.9,XMIENS,1.97)="y"
 . S:$G(XMINSTR("FLAGS"))["P" XMFDA(3.9,XMIENS,1.7)=$G(XMFDA(3.9,XMIENS,1.7))_"P"
 . S:$D(XMINSTR("RCPT BSKT")) XMFDA(3.9,XMIENS,21)=XMINSTR("RCPT BSKT")
 S:$$BRODCAST^XMKP XMFDA(3.9,XMIENS,1.97)="y"
 D FILE^DIE("","XMFDA")
 Q
LATER ; TaskMan entry point to send a user's latered message
 N XMI,XMLATER,XMPREFIX,XMTO,XMV,XMPRIVAT,XMBCAST
 S XMPRIVAT=$$EZBLD^DIALOG(39135) ; " [Private Mail Group]"
 S XMBCAST=$$EZBLD^DIALOG(39006) ; "* (Broadcast to all local users)"
 D INIT^XMVVITAE
 S XMI=""
 F  S XMI=$O(^TMP("XMY0",$J,XMI)) Q:XMI=""  D
 . S XMPREFIX=$G(^TMP("XMY0",$J,XMI,1)) ; prefix (I:,C:)
 . S XMLATER=$G(^TMP("XMY0",$J,XMI,"L"))
 . S:XMLATER'="" XMPREFIX=XMPREFIX_"L@"_XMLATER
 . S:XMPREFIX'="" XMPREFIX=XMPREFIX_":"
 . S XMTO(XMPREFIX_$S(XMI[XMPRIVAT:$P(XMI,XMPRIVAT,1),XMI=XMBCAST:"*",1:XMI))="" ; (set in ^XMXADDRG)
 D SENDMSG(XMDUZ,XMSUBJ,"^TMP(""XM"",$J,""BODY"")",.XMTO,.XMINSTR)
 S ZTREQ="@"
 Q
PSNDLATR(XMDUZ,XMSUBJ,XMBODY,XMTO,XMINSTR,ZTSK,XMATTACH) ; Set up a task for a program to send a message later
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSAVE
 S ZTIO=""
 S ZTRTN="PTSKLATR^XMXSEND"
 S ZTDTH=$$FMTH^XLFDT(XMINSTR("LATER"))
 S ZTDESC=$$EZBLD^DIALOG(39310) ; MailMan: Send Message Later
 S ZTSAVE($$OREF^DILF(XMBODY))=""
 F I="DUZ","XMDUZ","XMSUBJ","XMBODY","XMTO","XMTO(","XMINSTR(","XMATTACH(" S ZTSAVE(I)=""
 D ^%ZTLOAD
 ;D HOME^%ZIS call this only if preceded by call to ^%ZIS
 I '$D(ZTSK) D ERRSET^XMXUTIL(39311) ; Task creation not successful
 Q
PTSKLATR ; TaskMan entry point to send a program's latered message
 K XMINSTR("LATER")
 D SENDMSG(XMDUZ,XMSUBJ,XMBODY,.XMTO,.XMINSTR,"",.XMATTACH)
 S ZTREQ="@"
 Q
STARTMSG(XMSUBJ,XMZ) ;
 K XMERR,^TMP("XMERR",$J)
 D CRE8XMZ(XMSUBJ,.XMZ) Q:$D(XMERR)
 S XMLCNT=0
 Q
BODYLINE(XMZ,XMLINE) ; Put the msg body in place, line by line
 S XMLCNT=XMLCNT+1
 S ^XMB(3.9,XMZ,2,XMLCNT,0)=XMLINE
 Q
ENDMSG(XMDUZ,XMZ,XMTO,XMINSTR) ;
 S ^XMB(3.9,XMZ,2,0)="^^"_XMLCNT_U_XMLCNT_U_DT
 K XMLCNT
 D ADDRNSND(XMDUZ,XMZ,.XMTO,.XMINSTR)
 Q
POSTMAST(XMDUZ,XMINSTR) ;
 S:'$D(XMDUZ) XMDUZ=DUZ
 D:'$G(XMV("PRIV")) INIT^XMVVITAE
 S XMINSTR("FROM")=.5
 Q
