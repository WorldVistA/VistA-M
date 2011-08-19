XMXANSER ;ISC-SF/GMB-Answer a msg ;04/24/2002  10:08
 ;;8.0;MailMan;;Jun 28, 2002
 ; Replaces ^XMA11A (ISC-WASH/CAP/THM)
 ; XMDUZ             DUZ of who the msg is from
 ; XMSUBJ            Subject of the msg (defaults to 'Re:' original subject)
 ; XMBODY            Closed root of Body of the msg
 ;                   Must be closed root, passed by value.  See WP_ROOT
 ;                   definition for WP^DIE(), FM word processing filer.
 ; XMTO              Additional addressees, besides msg originator
 ; XMINSTR("FROM")   String saying from whom (default is user)
 ; XMINSTR("SELF BSKT") Basket to deliver to if sender is recipient
 ; XMINSTR("SHARE BSKT") Basket to deliver to if recipient is "SHARED,MAIL"
 ; XMINSTR("SHARE DATE") Delete date if recipient is "SHARED,MAIL"
 ; XMINSTR("RCPT BSKT") Basket name (only) to deliver to for other recipients
 ; XMINSTR("VAPOR")  Date on which to vaporize (delete) this message
 ;                   from recipient baskets
 ; XMINSTR("LATER")  Date on which to send this msg, if not now
 ; XMINSTR("FLAGS")  Any or all of the following:
 ;                   P Priority
 ;                   I Information only (may not be replied to)
 ;                   X Closed msg (may not be forwarded)
 ;                   C Confidential (surrogates may not read)
 ;                   S Send to sender (make sender a recipient)
 ;                   R Confirm receipt
 ; XMINSTR("SCR KEY")   Scramble key (implies that msg should be scrambled)
 ; XMINSTR("SCR HINT")  Hint (to guess the scramble key)
 ; XMINSTR("KEYS")   List of keys needed by recipient to read msg (NOT IMPLEMENTED)
 ; XMINSTR("TYPE")   Msg type is one of the following:
 ;                   D Document
 ;                   S Spooled Document
 ;                   X DIFROM
 ;                   O ODIF
 ;                   B BLOB
 ;                   K KIDS
 ;
 ; Output:
 ; XMZR              The number of the message containing the answer.
ANSRMSG(XMDUZ,XMK,XMKZ,XMSUBJ,XMBODY,XMTO,XMINSTR,XMZR) ;
 N XMZ,XMZREC,XMZSENDR
 K XMERR,^TMP("XMERR",$J)
 D CHKMSG^XMXSEC1(XMDUZ,.XMK,.XMKZ,.XMZ,.XMZREC) Q:$D(XMERR)
 Q:'$$ANSWER^XMXSEC(XMDUZ,XMZ,XMZREC)
 S:$G(XMSUBJ)="" XMSUBJ=$E($$EZBLD^DIALOG(37006)_$P(XMZREC,U,1),1,65) ; Re:
 D CRE8XMZ^XMXSEND(XMSUBJ,.XMZR) Q:$D(XMERR)
 S XMZSENDR=$P(XMZREC,U,2)
 S:XMZSENDR["@" XMZSENDR=$$REPLYTO1^XMXREPLY(XMZ)
 D COMPOSE(XMDUZ,XMZ,$P(XMZREC,U,1),XMZSENDR,$P(XMZREC,U,3),XMZR,XMBODY)
 S XMTO(XMZSENDR)=""
 S XMINSTR("EXACT")=1 ; Match on exact domain name
 D ADDRNSND^XMXSEND(XMDUZ,XMZR,.XMTO,.XMINSTR)
 K XMINSTR("EXACT")
 Q
COMPOSE(XMDUZ,XMZ,XMZSUBJ,XMZSENDR,XMZDATE,XMZR,XMBODY) ;
 D COPY(XMZ,XMZSUBJ,XMZSENDR,XMZDATE,XMZR)
 ; File XMBODY, with the "append" option
 D MOVEBODY^XMXSEND(XMZR,XMBODY,"A") ; Put the msg body in place
 D NETSIG^XMXEDIT(XMDUZ,XMZR)
 Q
COPY(XMZO,XMZOSUBJ,XMZOFROM,XMZODATE,XMZ) ; Copy the original msg, putting ">" in front of each line.
 N I,J
 D COPYHEAD^XMJMC(XMZO,XMZOSUBJ,XMZOFROM,XMZODATE,XMZ,"A",.J)
 S J=J+1,^XMB(3.9,XMZ,2,J,0)=">"
 S I=.999999
 F  S I=$O(^XMB(3.9,XMZO,2,I)) Q:I=""  S J=J+1,^XMB(3.9,XMZ,2,J,0)=$E(">"_^(I,0),1,254)
 S J=J+1,^XMB(3.9,XMZ,2,J,0)=""
 S J=J+1,^XMB(3.9,XMZ,2,J,0)=""
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_J_U_J_U_DT
 Q
