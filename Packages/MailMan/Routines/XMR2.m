XMR2 ;ISC-SF/GMB-SMTP Receiver (non-standard) ;04/17/2002  11:15
 ;;8.0;MailMan;;Jun 28, 2002
 ; *** Note that this command (MESS <what:parm>) is not standard.
 ; *** MESS ID, in particular, may return 'RSET', which is supposed
 ;     to be sent only by the sender, not by the receiver.
MESS ; CHECK IF DUPLICATE MESSAGE / USERS...
 N XMWHAT,XMPARM
 I XMP="" D ERRCMD^XMR Q
 S XMWHAT=$E($P(XMP,":"),1,6),XMPARM=$P(XMP,":",2,99)
 I $T(@XMWHAT)="" D ERRCMD^XMR Q
 D @XMWHAT
 Q
BLOB ;; MESS BLOB
 D BLOB^XMR0BLOB(XMPARM)
 Q
CLOSED ;; MESS CLOSED
 S XMZFDA(3.9,XMZIENS,1.95)="y"
 S XMSG="250 OK" X XMSEN
 Q
CONFID ;; MESS CONFIDENTIAL
 S XMZFDA(3.9,XMZIENS,1.96)="y"
 S XMSG="250 OK" X XMSEN
 Q
CONFIR ;; MESS CONFIRMATION
 S XMZFDA(3.9,XMZIENS,1.3)="y"
 S XMSG="250 OK" X XMSEN
 Q
ID ;;
 N XMZCHK
 S XMREMID=XMPARM
 S XMZCHK=$$LOCALXMZ^XMR3A(XMREMID)
 I 'XMZCHK S XMSG="250 OK" X XMSEN Q
 I $P(XMZCHK,U,2,3)="1^P" S XMSG="250 OK" X XMSEN Q
 ;Message originated here.  /  Previously received message.
 D DOTRAN^XMC1($S($P(XMZCHK,U,2):42305,1:42306))
 S XMRXMZ=+XMZCHK
 I $P(XMZCHK,U,3)'="E"!(XMRXMZ=XMZ) D  Q
 . I $P(XMZCHK,U,3)="P" D DOTRAN^XMC1(42307) ;Already purged.
 . I $P(XMZCHK,U,3)="R" D DOTRAN^XMC1(42308) ;Already purged & replaced with a different message.
 . S XMSG="RSET:"_XMRXMZ_"@"_^XMB("NETNAME")_":Duplicate purged" X XMSEN
 D DOTRAN^XMC1(42309) ;Delivering to additional recipients.
 S XMSG="RSET:"_XMRXMZ_"@"_^XMB("NETNAME")_":Previously received" X XMSEN
 Q
INFO ;; MESS INFORMATION 
 S XMZFDA(3.9,XMZIENS,1.97)="y"
 S XMSG="250 OK" X XMSEN
 Q
LINES ;; MESS LINES
 N XMLINES,XMLIMIT
 S XMLIMIT=$P($G(^XMB(1,1,"NETWORK-LIMIT")),U,2)
 S XMLINES=XMPARM
 I 'XMLIMIT!(XMLINES'>XMLIMIT) S XMSG="250 OK" X XMSEN Q
 S XMSG="RSET:"_XMLIMIT_":Max lines exceeded" X XMSEN
 S XM2LONG=1
 Q
TYPE ;; MESS TYPE
 S XMZFDA(3.9,XMZIENS,1.7)=XMPARM
 S XMSG="250 OK" X XMSEN
 Q
