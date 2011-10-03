XMA2R ;ISC-SF/GMB- Reply to/Answer a message API ;04/19/2002  12:37
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/CAP
 ;
 ; Entry points (DBIA 1145):
 ; ENT  function for non-interactive reply to a message.
 ;      Reply is sent to all local recipients of the message.
 ;      If message if from a remote sender, the reply is sent to
 ;      the remote sender, too.
 ; ENTA function for non-interactive answer to a message
ENT(XMZ,XMSUBJ,XMTEXT,XMSTRIP,XMDUZ,XMNET) ; Send response to a message
 ;Call as follows:
 ; S var=$$ENT^XMA2R(XMZ,XMSUBJ,.XMTEXT,XMSTRIP,XMDUZ,XMNET)
 ;Where:  XMZ     = Message being responded to
 ;        XMSUBJ  = Subject of the response
 ;                  (ignored, unless message is from a remote sender)
 ;        .XMTEXT = Array containing text
 ;        XMSTRIP = Characters to be stripped from text
 ;        XMDUZ   = Sender of response (DUZ or free text)
 ;        XMNET   = Send reply over the net? (0=no (DEFAULT); 1=yes)
 ;                  (ignored, unless message is from a remote sender)
 ;OUTPUT: If results okay = internal pointer to response in file 3.9
 ;        If bad result, the letter "E" followed by a number,
 ;        followed by a space, then a human readable explanation.
 N XMV,XMZR,XMINSTR,XMMG,XMSECURE,XMZREC
 K XMERR,^TMP("XMERR",$J)
 I '$D(^XMB(3.9,XMZ,0)) Q "E5 Message "_XMZ_" does not exist."
 I '$O(^XMB(3.9,XMZ,1,0)) Q "E6 Message "_XMZ_" has no recipients."
 I $D(XMTEXT)<9 Q "E2 No message text !"
 I '$O(XMTEXT(0)) Q "E4 No message text !"
 S XMDUZ=$G(XMDUZ,DUZ)
 I XMDUZ'?.N D  Q:$D(XMMG) "E10 "_$P(XMMG,"= ",2)
 . D SETFROM^XMD(.XMDUZ,.XMINSTR)
 D INITAPI^XMVVITAE
 D CRE8XMZ^XMXSEND("R"_XMZ,.XMZR) Q:XMZR<1 $$ERR("E9")
 D MOVETEXT(XMZR,.XMTEXT)
 D CHEKBODY^XMXSEND(XMZR,$G(XMSTRIP))
 D DOREPLY^XMXREPLY(XMDUZ,XMZ,XMZR,.XMINSTR)
 S XMZREC=$G(^XMB(3.9,XMZ,0))
 I $P(XMZREC,U,2)'["@"!'$G(XMNET) Q XMZR
 I '$D(XMSUBJ) Q "E1 No subject !"
 I $L(XMSUBJ)<3!($L(XMSUBJ)>65) Q "E3 Subject too long or short !"
 S XMSUBJ=$$SCRUB^XMXUTIL1(XMSUBJ)
 S:XMSUBJ[U XMSUBJ=$$ENCODEUP^XMXUTIL1(XMSUBJ)
 N XMFROM,XMREPLTO
 D REPLYTO^XMXREPLY(XMZ,.XMFROM,.XMREPLTO)
 D INIT^XMXADDR
 D CHKADDR^XMXADDR(XMDUZ,$$REMADDR^XMXADDR3($G(XMREPLTO,XMFROM)),.XMINSTR) Q:$D(XMERR) $$ERR("E12")
 D NETREPLY^XMXREPLY(XMDUZ,XMZ,XMZR,XMSUBJ,.XMINSTR)
 D CLEANUP^XMXADDR
 Q XMZR
MOVETEXT(XMZ,XMTEXT,XMAPPEND) ;
 N I,XMLINE
 S XMLINE=$S($G(XMAPPEND):$O(^XMB(3.9,XMZ,2,":"),-1),1:0)
 S I=0
 F  S I=$O(XMTEXT(I)) Q:'I  D
 . S XMLINE=XMLINE+1
 . S ^XMB(3.9,XMZ,2,XMLINE,0)=$S($D(XMTEXT(I,0)):XMTEXT(I,0),1:XMTEXT(I))
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_XMLINE_U_XMLINE
 Q
ENTA(XMZ,XMSUBJ,XMTEXT,XMSTRIP,XMDUZ) ; Send Response Only to Sender of Original Message
 ;Call as follows:
 ; S var=$$ENT^XMA2R(XMZ,XMSUBJ,.XMTEXT,XMSTRIP,XMDUZ)
 ;Where:  XMZ     = Message being responded to
 ;        XMSUBJ  = Subject of the response
 ;        .XMTEXT = Array containing text
 ;        XMSTRIP = Characters to be stripped from text
 ;        XMDUZ   = Sender of response (DUZ or free text)
 ;
 ;OUTPUT: If results okay = internal pointer to response in file 3.9
 ;        If bad result, the letter "E" followed by a number,
 ;        followed by a space, then a human readable explanation.
 N XMV,XMZR,XMINSTR,XMMG,XMSECURE,XMZSENDR,XMZREC,XMTO
 K XMERR,^TMP("XMERR",$J)
 I '$D(^XMB(3.9,XMZ,0)) Q "E5 Message "_XMZ_" does not exist."
 I '$D(XMSUBJ) Q "E1 No subject !"
 I $D(XMTEXT)<9 Q "E2 No message text !"
 I $L(XMSUBJ)<3!($L(XMSUBJ)>65) Q "E3 Subject too long or short !"
 I '$O(XMTEXT(0)) Q "E4 No message text !"
 S XMDUZ=$G(XMDUZ,DUZ)
 I XMDUZ'?.N D  Q:$D(XMMG) "E10 "_$P(XMMG,"= ",2)
 . D SETFROM^XMD(.XMDUZ,.XMINSTR)
 D INITAPI^XMVVITAE
 S XMZREC=^XMB(3.9,XMZ,0)
 S XMZSENDR=$P(XMZREC,U,2)
 S:XMZSENDR["@" XMZSENDR=$$REPLYTO1^XMXREPLY(XMZ)
 D CRE8XMZ^XMXSEND(XMSUBJ,.XMZR) Q:XMZR<1 $$ERR("E9")
 D COPY^XMXANSER(XMZ,$P(XMZREC,U,1),XMZSENDR,$P(XMZREC,U,3),XMZR)
 D MOVETEXT(XMZR,.XMTEXT,1)
 D NETSIG^XMXEDIT(XMDUZ,XMZR)
 D CHEKBODY^XMXSEND(XMZR,$G(XMSTRIP))
 S XMTO(XMZSENDR)=""
 S XMTO(XMDUZ)=""
 S XMINSTR("ADDR FLAGS")="R"  ; No addressing restrictions
 D ADDRNSND^XMXSEND(XMDUZ,XMZR,.XMTO,.XMINSTR)
 Q:$D(XMERR) $$ERR("E11")
 Q XMZR
ERR(XMER) ;
 S XMER=XMER_" "_^TMP("XMERR",$J,1,"TEXT",1)
 K XMERR,^TMP("XMERR",$J)
 Q XMER
