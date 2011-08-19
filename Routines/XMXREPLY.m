XMXREPLY ;ISC-SF/GMB-Reply to a msg ;04/24/2002  10:29
 ;;8.0;MailMan;;Jun 28, 2002
REPLYMSG(XMDUZ,XMK,XMKZ,XMBODY,XMINSTR,XMZR) ;
 ; XMDUZ    DUZ of who the msg is from
 ; XMBODY   Body of the msg
 ;          Must be closed root, passed by value.  See WP_ROOT
 ;          definition for WP^DIE(), FM word processing filer.
 ; XMINSTR("FROM")     String saying from whom (default is XMDUZ)
 ; XMINSTR("STRIP")    String containing chars to strip from msg text
 ; XMINSTR("SCR HINT") Hint to guess the scramble key
 ;                     (must be the hint from original message)
 ; XMINSTR("SCR KEY")  Scramble key, if original message was scrambled.
 ;                     (must be the key from original message, as
 ;                     entered by the user: unscrambled!)
 ; *NOTE: SCR hint and key needed only for remote replies.  Even then,
 ;        they are ignored.  That info is gotten from the original msg.
 ; XMINSTR("NET REPLY") Should reply go over the network? 1=yes; 0=no
 ; XMINSTR("NET SUBJ") Subject for network reply msg, else default to
 ;          "Re: original msg subject"
 ; XMZSENDR XMDUZ of the person who created and sent the msg
 ; If you are not a recipient or the sender, you may not reply.
 ; If msg is in SHARED,MAIL and your DUZ is .6, ERROR! G H^XUS ***
 ; If msg is info only AND you are not the sender, you may not reply.
 ; If msg is info only and broadcast to all local users, may not reply
 ; If you are info only, you may not reply.
 ; If msg is from a remote POSTMASTER, may not reply.
 ; If msg is in waste basket or no basket, move it to a basket.
 ;
 ; Output:
 ; XMZR     msg # holding the reply to XMZ
 N XMZ,XMZREC,XMZSENDR,XMNETMSG
 K XMERR,^TMP("XMERR",$J)
 D CHKMSG^XMXSEC1(XMDUZ,.XMK,.XMKZ,.XMZ,.XMZREC) Q:$D(XMERR)
 Q:'$$REPLY^XMXSEC(XMDUZ,XMZ,XMZREC)
 D:XMK<1 FLTR^XMXMSGS2(XMDUZ,XMK,$S(XMK=.5:$$EZBLD^DIALOG(37004),1:""),XMZ) ; Move msg from WASTE basket
 D CRE8XMZ^XMXSEND("R"_XMZ,.XMZR) Q:$D(XMERR)  ; Create a place for the response in the msg file
 D MOVEBODY^XMXSEND(XMZR,XMBODY) ; Put the msg body in place
 D CHEKBODY^XMXSEND(XMZR,$G(XMINSTR("STRIP")))
 D DOREPLY(XMDUZ,XMZ,XMZR,.XMINSTR)
 S XMZSENDR=$P(XMZREC,U,2)
 S XMNETMSG=$S(XMZSENDR["@":1,1:0)
 I 'XMNETMSG!'$G(XMINSTR("NET REPLY")) Q
 N XMFROM,XMREPLTO
 D REPLYTO(XMZ,.XMFROM,.XMREPLTO)
 D INIT^XMXADDR
 S XMINSTR("EXACT")=1 ; Match on exact domain name
 D CHKADDR^XMXADDR(XMDUZ,$$REMADDR^XMXADDR3($G(XMREPLTO,XMFROM)),.XMINSTR)
 K XMINSTR("EXACT")
 D:'$D(XMERR) NETREPLY(XMDUZ,XMZ,XMZR,$S($G(XMINSTR("NET SUBJ"))'="":XMINSTR("NET SUBJ"),$E($P(XMZREC,U,1),1,4)=$$EZBLD^DIALOG(37006):$E($P(XMZREC,U,1),1,65),1:$E($$EZBLD^DIALOG(37006)_$P(XMZREC,U,1),1,65)),.XMINSTR) ;Re:
 D CLEANUP^XMXADDR
 Q
DOREPLY(XMDUZ,XMZ,XMZR,XMINSTR) ;
 D:$D(XMSECURE) ENCMSG^XMJMCODE(XMZR) ; Scramble the msg, if needed
 D MOVER(XMDUZ,XMZ,XMZR,.XMINSTR) ; Point from response back to original msg
 D RPOST^XMKP(XMDUZ,XMZ,XMZR) ; Point from original msg to response and send the msg
 D CHECK^XMKPL
 Q
NETREPLY(XMDUZ,XMZ,XMZR,XMZRSUBJ,XMINSTR) ;
 N XMFDA,XMIENS
 S XMIENS=XMZR_","
 S XMFDA(3.9,XMIENS,.01)=XMZRSUBJ
 I $D(XMSECURE) D  ; Scramble hint / Scramble key
 . S XMFDA(3.9,XMIENS,1.8)=$P(^XMB(3.9,XMZ,0),U,10) ;XMINSTR("SCR HINT")
 . S XMFDA(3.9,XMIENS,1.85)=^XMB(3.9,XMZ,"K") ;XMINSTR("SCR KEY")
 I $G(^XMB(3.9,XMZ,5))'="" D  ; In response to remote msg id
 . S XMFDA(3.9,XMIENS,9.5)=$E(^XMB(3.9,XMZ,5),1,110)
 D FILE^DIE("","XMFDA")
 D SEND^XMKP(XMDUZ,XMZR)
 Q
MOVER(XMDUZ,XMZ,XMZR,XMINSTR) ;
 N XMFDA,XMIENS
 S XMIENS=XMZR_","
 I $D(XMINSTR("FROM")) D
 . S XMFDA(3.9,XMIENS,1)=XMINSTR("FROM")
 . ;S XMFDA(3.9,XMIENS,1.1)=DUZ
 E  D
 . S XMFDA(3.9,XMIENS,1)=XMDUZ
 . S:XMDUZ'=DUZ XMFDA(3.9,XMIENS,1.1)=DUZ
 S XMFDA(3.9,XMIENS,1.4)=$$NOW^XLFDT()
 S XMFDA(3.9,XMIENS,1.35)=XMZ
 D FILE^DIE("","XMFDA")
 Q
REPLYTO(XMZ,XMFROM,XMREPLTO) ; Get from and reply-to address, if any
 N XMHDR,XMFIND
 S XMFIND="^FROM^REPLY-TO^"
 D HDRFIND^XMR3(XMZ,XMFIND,.XMHDR)
 I $D(XMHDR("FROM")) S XMFROM=XMHDR("FROM")
 E  S XMFROM=$P($G(^XMB(3.9,XMZ,0)),U,2)  ; not really remote msg?
 I $D(XMHDR("REPL")) S XMREPLTO=XMHDR("REPL")
 Q
REPLYTO1(XMZ) ;
 N XMFROM,XMREPLTO
 D REPLYTO(XMZ,.XMFROM,.XMREPLTO)
 Q $$REMADDR^XMXADDR3($G(XMREPLTO,XMFROM))
