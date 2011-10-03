XMXTO ;ISC-SF/GMB-Address a msg ;08/08/2000  14:38
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points:
 ; ITOWHOM  Interactive 'to whom:'
 ; TOWHOM   Silent 'to whom:'
ITOWHOM(XMDUZ,XMZ,XMTYPE,XMINSTR) ; Interactive
 ; XMDUZ             DUZ of who is sending or forwarding the message
 ; XMZ               The message number
 ;                   (need not be supplied if XMTYPE="S" and
 ;                   XMINSTR("ADDR FLAGS")["R")
 ; XMTYPE            S='Send to:'
 ;                   F='Forward to:'
 ; XMINSTR("SELF BSKT") Basket to deliver to if sender is recipient
 ; XMINSTR("SHARE DATE") Delete date if recipient is "SHARED,MAIL"
 ; XMINSTR("SHARE BSKT") Basket if recipient is "SHARED,MAIL"
 ; XMINSTR("TO PROMPT") Initial prompt to whom to send the message (default=XMDUZ)
 ; XMINSTR("FLAGS")  Any or all or none of the following:
 ;                   (Necessary only if XMTYPE="S" and XMINSTR("ADDR FLAGS")["R")
 ;                   X Closed msg (may not be forwarded)
 ;                   C Confidential msg (surrogates may not read)
 ; XMINSTR("ADDR FLAGS")   Any or all of the following:
 ;                   I Do not Initialize (kill) the ^TMP addressee global
 ;                   R Do not Restrict addressees
 N XMRESTR,XMABORT
 K XMERR,^TMP("XMERR",$J)
 D INIT(XMDUZ,.XMZ,XMTYPE,.XMINSTR,.XMRESTR,.XMPROMPT) Q:$D(XMERR)
 S XMABORT=0
 D TOWHOM^XMJMT(XMDUZ,XMPROMPT,.XMINSTR,.XMRESTR,.XMABORT)
 Q:'XMABORT
 D ERRSET^XMXUTIL($S(XMABORT=1:37000,1:37001)) ; up-arrow out. / time out.
 Q
TOWHOM(XMDUZ,XMZ,XMTYPE,XMTO,XMINSTR,XMFULL) ; Silent
 ; XMDUZ       (in)  DUZ of who is sending or forwarding the message
 ; XMZ         (in)  The message number
 ;                   (need not be supplied if XMTYPE="S" and
 ;                   XMINSTR("ADDR FLAGS")["R")
 ; XMTYPE      (in)  S='Send to:'
 ;                   F='Forward to:'
 ; XMTO        (in)  ONE addressee
 ; XMINSTR("SELF BSKT")  (in) Basket to deliver to if sender is recipient
 ; XMINSTR("SHARE DATE") (in) Delete date if recipient is "SHARED,MAIL"
 ; XMINSTR("SHARE BSKT") (in) Basket if recipient is "SHARED,MAIL"
 ; XMINSTR("FLAGS")      (in) Any or all or none of the following:
 ;                   (Necessary only if XMTYPE="S" and XMINSTR("ADDR FLAGS")["R")
 ;                   X Closed msg (may not be forwarded)
 ;                   C Confidential msg (surrogates may not read)
 ; XMINSTR("ADDR FLAGS")   Any or all of the following:
 ;                   I Do not Initialize (kill) the ^TMP addressee global
 ;                   R Do not Restrict addressees
 ; XMFULL      (out) the full address
 N XMRESTR
 K XMERR,^TMP("XMERR",$J)
 D INIT(XMDUZ,.XMZ,XMTYPE,.XMINSTR,.XMRESTR) Q:$D(XMERR)
 D CHKADDR^XMXADDR(XMDUZ,.XMTO,.XMINSTR,.XMRESTR,.XMFULL)
 Q
INIT(XMDUZ,XMZ,XMTYPE,XMINSTR,XMRESTR,XMPROMPT) ;
 I XMTYPE="S" D
 . S XMPROMPT=$$EZBLD^DIALOG(34110) ; Send
 . D:$G(XMINSTR("ADDR FLAGS"))'["R" CHKLINES^XMXSEC1(XMDUZ,XMZ,.XMRESTR)
 E  D
 . N XMZREC
 . S XMZREC=^XMB(3.9,XMZ,0)
 . S XMPROMPT=$$EZBLD^DIALOG(34111) ; Forward
 . Q:'$$FORWARD^XMXSEC(XMDUZ,XMZ,XMZREC)
 . D:$G(XMINSTR("ADDR FLAGS"))'["R" GETRESTR^XMXSEC1(XMDUZ,XMZ,XMZREC,.XMINSTR,.XMRESTR)
 D:$G(XMINSTR("ADDR FLAGS"))'["I" INIT^XMXADDR
 Q
